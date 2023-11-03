Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061557E06A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbjKCQnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjKCQnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:43:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7BE111;
        Fri,  3 Nov 2023 09:43:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc53d0030fso18814265ad.0;
        Fri, 03 Nov 2023 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699029791; x=1699634591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ih7WlNmerHDqwU0NzEXfphRvrs+9wIcIe2yQovPxT6Y=;
        b=giuCMBCr7zS5g1l4IBcJfjWDRjIJ3xoYMovnCBWAzAXvq2J2tLwCdqqcUngz5jDp9S
         ZDYPEHGwC7xDgPdV6juJ5iEPGh8oYXzXN40dHDlCHADVeIfbhLKo1mzHJt+Fw9Tl/STa
         v1kebx42zC7zBnD+SM+He6QcPQIUTJ8fDE54qHO/fdfnKKnKNgcckTFIKRBOqa9l4mjA
         cm8t+FCfVYGH2PKoU7uSkP3QT/K7vIfva1IVFYdxn39nDsLWmiraPwJ4x5iEZOpNkILx
         uVUJ8vvX+pwzTH0gVwYf7r+nDQcWbVdxZpJK8UPuo6EXdHyNKKQ9vBVCXUdLYq9g6df0
         gsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699029791; x=1699634591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih7WlNmerHDqwU0NzEXfphRvrs+9wIcIe2yQovPxT6Y=;
        b=feyfLSLlvrlzag+VxcOhtUGYi4BbadZoBd4iDkTUOKX+YSJ+AwfTke5NqYDkqT3NXt
         WlJIKUVmxz75R/fMSMFMFUxt4bbVnbCRdipxvXrSbMB3xkfdxTfCMZmud7MS6t+cNPCr
         459teSIPursCbYqzoag6M+WtM6A49VLo+8TvOf2djOSTvPzTZuiKar40IkgH8PwMYDSB
         8o9S2NnByY4SGSJbG5EZX2EuDnLuucPzTtsrAbl2LRn4JDob89SdIysIuwzK3ymWvCkl
         DQVJyWrwotFrx/55Y79R1bPSWrCGrsHkiAMMhcVMhlimxrfQmEM3NP2n6ft2K3MDv5wP
         680g==
X-Gm-Message-State: AOJu0YzhJp698j5khhM39KwN7ENjOIBjjWSOsl0KERIOA/2NQJUhAof5
        AlgqPL+6lHHyAcvys8PX/xI=
X-Google-Smtp-Source: AGHT+IHTY2DwZYDb52LHJUlwhpLWjT3LP+Yjv3rvTMU9Z3tdBf3bcsoesLUWFtnMH+nusSYEVmCOag==
X-Received: by 2002:a17:902:e744:b0:1cc:431f:55e3 with SMTP id p4-20020a170902e74400b001cc431f55e3mr3164775plf.28.1699029791458;
        Fri, 03 Nov 2023 09:43:11 -0700 (PDT)
Received: from debian (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id w21-20020a1709029a9500b001bb9bc8d232sm1605796plp.61.2023.11.03.09.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 09:43:11 -0700 (PDT)
From:   fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date:   Fri, 3 Nov 2023 09:43:06 -0700
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v8 2/3] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Message-ID: <ZUUjGgB40u_tmRg9@debian>
References: <20231101-vv-kmem_memmap-v8-0-5e4a83331388@intel.com>
 <20231101-vv-kmem_memmap-v8-2-5e4a83331388@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-vv-kmem_memmap-v8-2-5e4a83331388@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 04:51:52PM -0600, Vishal Verma wrote:
> The MHP_MEMMAP_ON_MEMORY flag for hotplugged memory is restricted to
> 'memblock_size' chunks of memory being added. Adding a larger span of
> memory precludes memmap_on_memory semantics.
> 
> For users of hotplug such as kmem, large amounts of memory might get
> added from the CXL subsystem. In some cases, this amount may exceed the
> available 'main memory' to store the memmap for the memory being added.
> In this case, it is useful to have a way to place the memmap on the
> memory being added, even if it means splitting the addition into
> memblock-sized chunks.
> 
> Change add_memory_resource() to loop over memblock-sized chunks of
> memory if caller requested memmap_on_memory, and if other conditions for
> it are met. Teach try_remove_memory() to also expect that a memory
> range being removed might have been split up into memblock sized chunks,
> and to loop through those as needed.
> 
> This does preclude being able to use PUD mappings in the direct map; a
> proposal to how this could be optimized in the future is laid out
> here[1].
> 
> [1]: https://lore.kernel.org/linux-mm/b6753402-2de9-25b2-36e9-eacd49752b19@redhat.com/
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  mm/memory_hotplug.c | 213 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 138 insertions(+), 75 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6be7de9efa55..d242e49d7f7b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1380,6 +1380,84 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
>  	return arch_supports_memmap_on_memory(vmemmap_size);
>  }
>  
> +static void __ref remove_memory_blocks_and_altmaps(u64 start, u64 size)
> +{
> +	unsigned long memblock_size = memory_block_size_bytes();
> +	u64 cur_start;
> +
> +	/*
> +	 * For memmap_on_memory, the altmaps were added on a per-memblock
> +	 * basis; we have to process each individual memory block.
> +	 */
> +	for (cur_start = start; cur_start < start + size;
> +	     cur_start += memblock_size) {
> +		struct vmem_altmap *altmap = NULL;
> +		struct memory_block *mem;
> +
> +		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start)));
> +		WARN_ON_ONCE(!mem);
> +		if (!mem)
> +			continue;
> +
> +		altmap = mem->altmap;
> +		mem->altmap = NULL;
> +
> +		remove_memory_block_devices(cur_start, memblock_size);

Is cur_start always aligned to memory_block_size_bytes? If not, the
above function will return directly, is that a issue?

Fan

> +
> +		arch_remove_memory(cur_start, memblock_size, altmap);
> +
> +		/* Verify that all vmemmap pages have actually been freed. */
> +		WARN(altmap->alloc, "Altmap not fully unmapped");
> +		kfree(altmap);
> +	}
> +}
> +
> +static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
> +					    u64 start, u64 size)
> +{
> +	unsigned long memblock_size = memory_block_size_bytes();
> +	u64 cur_start;
> +	int ret;
> +
> +	for (cur_start = start; cur_start < start + size;
> +	     cur_start += memblock_size) {
> +		struct mhp_params params = { .pgprot =
> +						     pgprot_mhp(PAGE_KERNEL) };
> +		struct vmem_altmap mhp_altmap = {
> +			.base_pfn = PHYS_PFN(cur_start),
> +			.end_pfn = PHYS_PFN(cur_start + memblock_size - 1),
> +		};
> +
> +		mhp_altmap.free = memory_block_memmap_on_memory_pages();
> +		params.altmap = kmemdup(&mhp_altmap, sizeof(struct vmem_altmap),
> +					GFP_KERNEL);
> +		if (!params.altmap)
> +			return -ENOMEM;
> +
> +		/* call arch's memory hotadd */
> +		ret = arch_add_memory(nid, cur_start, memblock_size, &params);
> +		if (ret < 0) {
> +			kfree(params.altmap);
> +			goto out;
> +		}
> +
> +		/* create memory block devices after memory was added */
> +		ret = create_memory_block_devices(cur_start, memblock_size,
> +						  params.altmap, group);
> +		if (ret) {
> +			arch_remove_memory(cur_start, memblock_size, NULL);
> +			kfree(params.altmap);
> +			goto out;
> +		}
> +	}
> +
> +	return 0;
> +out:
> +	if (ret && (cur_start != start))
> +		remove_memory_blocks_and_altmaps(start, cur_start - start);
> +	return ret;
> +}
> +
>  /*
>   * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
>   * and online/offline operations (triggered e.g. by sysfs).
> @@ -1390,10 +1468,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  {
>  	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
>  	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
> -	struct vmem_altmap mhp_altmap = {
> -		.base_pfn =  PHYS_PFN(res->start),
> -		.end_pfn  =  PHYS_PFN(res->end),
> -	};
>  	struct memory_group *group = NULL;
>  	u64 start, size;
>  	bool new_node = false;
> @@ -1436,28 +1510,22 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  	/*
>  	 * Self hosted memmap array
>  	 */
> -	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
> -		if (mhp_supports_memmap_on_memory(size)) {
> -			mhp_altmap.free = memory_block_memmap_on_memory_pages();
> -			params.altmap = kmemdup(&mhp_altmap,
> -						sizeof(struct vmem_altmap),
> -						GFP_KERNEL);
> -			if (!params.altmap)
> -				goto error;
> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
> +	    mhp_supports_memmap_on_memory(memory_block_size_bytes())) {
> +		ret = create_altmaps_and_memory_blocks(nid, group, start, size);
> +		if (ret)
> +			goto error;
> +	} else {
> +		ret = arch_add_memory(nid, start, size, &params);
> +		if (ret < 0)
> +			goto error;
> +
> +		/* create memory block devices after memory was added */
> +		ret = create_memory_block_devices(start, size, NULL, group);
> +		if (ret) {
> +			arch_remove_memory(start, size, NULL);
> +			goto error;
>  		}
> -		/* fallback to not using altmap  */
> -	}
> -
> -	/* call arch's memory hotadd */
> -	ret = arch_add_memory(nid, start, size, &params);
> -	if (ret < 0)
> -		goto error_free;
> -
> -	/* create memory block devices after memory was added */
> -	ret = create_memory_block_devices(start, size, params.altmap, group);
> -	if (ret) {
> -		arch_remove_memory(start, size, NULL);
> -		goto error_free;
>  	}
>  
>  	if (new_node) {
> @@ -1494,8 +1562,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  		walk_memory_blocks(start, size, NULL, online_memory_block);
>  
>  	return ret;
> -error_free:
> -	kfree(params.altmap);
>  error:
>  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>  		memblock_remove(start, size);
> @@ -2062,17 +2128,13 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
>  	return 0;
>  }
>  
> -static int test_has_altmap_cb(struct memory_block *mem, void *arg)
> +static int count_memory_range_altmaps_cb(struct memory_block *mem, void *arg)
>  {
> -	struct memory_block **mem_ptr = (struct memory_block **)arg;
> -	/*
> -	 * return the memblock if we have altmap
> -	 * and break callback.
> -	 */
> -	if (mem->altmap) {
> -		*mem_ptr = mem;
> -		return 1;
> -	}
> +	u64 *num_altmaps = (u64 *)arg;
> +
> +	if (mem->altmap)
> +		*num_altmaps += 1;
> +
>  	return 0;
>  }
>  
> @@ -2146,11 +2208,31 @@ void try_offline_node(int nid)
>  }
>  EXPORT_SYMBOL(try_offline_node);
>  
> +static int memory_blocks_have_altmaps(u64 start, u64 size)
> +{
> +	u64 num_memblocks = size / memory_block_size_bytes();
> +	u64 num_altmaps = 0;
> +
> +	if (!mhp_memmap_on_memory())
> +		return 0;
> +
> +	walk_memory_blocks(start, size, &num_altmaps,
> +			   count_memory_range_altmaps_cb);
> +
> +	if (num_altmaps == 0)
> +		return 0;
> +
> +	if (num_memblocks != num_altmaps) {
> +		WARN_ONCE(1, "Not all memblocks in range have altmaps");
> +		return -EINVAL;
> +	}
> +
> +	return 1;
> +}
> +
>  static int __ref try_remove_memory(u64 start, u64 size)
>  {
> -	struct memory_block *mem;
> -	int rc = 0, nid = NUMA_NO_NODE;
> -	struct vmem_altmap *altmap = NULL;
> +	int rc, nid = NUMA_NO_NODE;
>  
>  	BUG_ON(check_hotplug_memory_range(start, size));
>  
> @@ -2167,45 +2249,25 @@ static int __ref try_remove_memory(u64 start, u64 size)
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
> -	 * the same granularity it was added - a single memory block.
> -	 */
> -	if (mhp_memmap_on_memory()) {
> -		rc = walk_memory_blocks(start, size, &mem, test_has_altmap_cb);
> -		if (rc) {
> -			if (size != memory_block_size_bytes()) {
> -				pr_warn("Refuse to remove %#llx - %#llx,"
> -					"wrong granularity\n",
> -					start, start + size);
> -				return -EINVAL;
> -			}
> -			altmap = mem->altmap;
> -			/*
> -			 * Mark altmap NULL so that we can add a debug
> -			 * check on memblock free.
> -			 */
> -			mem->altmap = NULL;
> -		}
> -	}
> -
>  	/* remove memmap entry */
>  	firmware_map_remove(start, start + size, "System RAM");
>  
> -	/*
> -	 * Memory block device removal under the device_hotplug_lock is
> -	 * a barrier against racing online attempts.
> -	 */
> -	remove_memory_block_devices(start, size);
> -
>  	mem_hotplug_begin();
>  
> -	arch_remove_memory(start, size, altmap);
> -
> -	/* Verify that all vmemmap pages have actually been freed. */
> -	if (altmap) {
> -		WARN(altmap->alloc, "Altmap not fully unmapped");
> -		kfree(altmap);
> +	rc = memory_blocks_have_altmaps(start, size);
> +	if (rc < 0) {
> +		goto err;
> +	} else if (rc == 0) {
> +		/*
> +		 * Memory block device removal under the device_hotplug_lock is
> +		 * a barrier against racing online attempts.
> +		 * No altmaps present, do the removal directly
> +		 */
> +		remove_memory_block_devices(start, size);
> +		arch_remove_memory(start, size, NULL);
> +	} else {
> +		/* all memblocks in the range have altmaps */
> +		remove_memory_blocks_and_altmaps(start, size);
>  	}
>  
>  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> @@ -2218,8 +2280,9 @@ static int __ref try_remove_memory(u64 start, u64 size)
>  	if (nid != NUMA_NO_NODE)
>  		try_offline_node(nid);
>  
> +err:
>  	mem_hotplug_done();
> -	return 0;
> +	return (rc < 0 ? rc : 0);
>  }
>  
>  /**
> 
> -- 
> 2.41.0
> 
