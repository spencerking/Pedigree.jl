module Pedigree

# Does not yet support trios
function readped(file)
    f = open(file, "r")
    ped = Dict{String,Dict{String, String}}()
    is_first = true
    
    for line in readlines(f)
        if is_first
            is_first = false
            continue
        end

        s = split(line, "\t")

        id = s[1]
        entry = Dict("Proband" => s[2],
                     "Father" => s[3],
                     "Mother" => s[4],
                     "Gender" => s[5]
                     )
        
        ped[id] = entry
    end
    
    close(f)

    return ped
end

function writeped(pedigree, file)
    open(file, "w") do f
        write(f, "FamID\tProband\tFather\tMother\tGender\n")
        for (id, content) in pedigree
            line = id * "\t" * content["Proband"] * "\t" * content["Father"] * "\t" * content["Mother"] * "\t" * content["Gender"] * "\n"
            
            # for (key, value) in content
            #     line = line * "\t" * value
            # end
            # line = line * "\n"
            
            write(f, line)
        end
    end
end

end # module
