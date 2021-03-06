class Hash
  def deep_merge!(other_hash, &block)
    other_hash.each_pair do |k,v|
      tv = self[k]
      if tv.is_a?(Hash) && v.is_a?(Hash)
        self[k] = tv.deep_merge(v, &block)
      else
        self[k] = block && tv ? block.call(k, tv, v) : v
      end
    end
    self
  end

  def deep_merge(other_hash, &block)
    dup.deep_merge!(other_hash, &block)
  end

  def deep_camelize
    Hash[map do |k,v|
           v = v.deep_camelize if v.is_a?(Hash)
           k = k.camelize if k.respond_to? :camelize
           [k,v]
         end
        ]
  end
             
end
