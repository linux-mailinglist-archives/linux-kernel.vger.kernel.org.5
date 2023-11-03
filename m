Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5E7E0AEF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjKCWFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjKCWFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:05:21 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1551D54
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:05:18 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7aae07e7ba4so839116241.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699049118; x=1699653918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EydcEpACM05kVQfNtJfjKtosc54xvlAF8YKW9rmzQ9I=;
        b=HcwRhX+btHteI76B9gQJaJRvMAW97JxFNiEg7gxY/qHzRpoTXS7HjXxXUVy9tiuv4P
         MV0gdadrjqNGcS9Tr2mNV/apMcUS4Y66Qx+9iAH94Da5BrzlzzXGlaP8dGZHMYUJagB0
         ezzJ5XqTgPVyrt/ZxV5sgT3WJmF0TSsHIDLbO/km2wnWXIbUgRHZIOxwXfBVFi3/d4kg
         PTFLrQ/S9UockNPTo/gL1mwR4aiK4r7eqBGhPG+trkwcRSoCobo3VAD+Aur37dcr+nYr
         lCclHRO47MUmYD6/LcQqIEDNU135+yt8MvbbiLUT/hzf407ksS1m8hTXWKlMVBJ6lWUI
         y3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699049118; x=1699653918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EydcEpACM05kVQfNtJfjKtosc54xvlAF8YKW9rmzQ9I=;
        b=eC2RAkEWwvhTu3ev/z3MP34v//rSeeryVxIeraCYLjWRiAYkYgTgXJMSZSXB3SNg3Z
         p7aT+5pwBAgV2xvtz8nSldYPqLTtCJ0uqALgIxnYyUQk9OlaQn8fZPZo9YK+IunQCvnf
         HjyPMTnyG5MjxHE/QVcf/liXFGQQYNaC6DlAlfHWosaI7zixLwjIPaMf+9T87sCMTvr/
         ZwUqiUmuT0BX4HF7JBj6Z6233WcvUi9ghcBX6hcR5apkmXJyibBEnnm1B5OihYM2xcFJ
         DlCf+GWhFSNDUZV72r58XfoSJB8lUVa51RNcEJC69b+pXWw/dX6EJSsVSavoVZAME7pH
         Y+Ag==
X-Gm-Message-State: AOJu0YxZtbuwP36PIX5KSkrLvJXWYz2xaeHh3WdJiZdcy73EaX0zKvB9
        OQ9VtVDyTTRf4wf7v6anLAE=
X-Google-Smtp-Source: AGHT+IGxHhlq7aUjljkDi7WNU9tzjmgNyQT9SgSKXcoRUuzhwQnYzseR+Gsw1MniltKjuuKH0kkfLQ==
X-Received: by 2002:a05:6102:160d:b0:45d:9252:f03d with SMTP id cu13-20020a056102160d00b0045d9252f03dmr3722521vsb.28.1699049117543;
        Fri, 03 Nov 2023 15:05:17 -0700 (PDT)
Received: from localhost ([50.221.102.30])
        by smtp.gmail.com with ESMTPSA id o16-20020a9f3510000000b007a028f8fffesm481865uao.19.2023.11.03.15.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 15:05:16 -0700 (PDT)
Date:   Fri, 3 Nov 2023 15:05:15 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v8 3/3] arm64: mte: add compression support to mteswap.c
Message-ID: <ZUVulBKVYK7cq2rJ@yury-ThinkPad>
References: <20231103160335.2464561-1-glider@google.com>
 <20231103160335.2464561-4-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103160335.2464561-4-glider@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 05:03:35PM +0100, Alexander Potapenko wrote:
> Update mteswap.c to perform inline compression of memory tags when
> possible.
> 
> If CONFIG_ARM64_MTE_COMP is enabled, mteswap.c will attemt to compress

attempt?

> saved tags for a struct page and store them directly in Xarray entry
> instead of wasting heap space.
> 
> Soon after booting Android, tag compression saves ~2x memory previously
> spent by mteswap.c on tag allocations. On a moderately loaded device with
> ~20% tagged pages, this leads to saving several megabytes of kernel heap:
> 
>   # cat /sys/kernel/debug/mteswap/stats
>   8 bytes: 102496 allocations, 67302 deallocations
>   128 bytes: 212234 allocations, 178278 deallocations
>   uncompressed tag storage size: 8851200
>   compressed tag storage size: 4346368

Can you align them like this:

   # cat /sys/kernel/debug/mteswap/stats
   8 bytes:      102496 allocations,    67302 deallocations
   128 bytes:    212234 allocations,   178278 deallocations
   uncompressed tag storage size:    8851200
   compressed tag storage size:      4346368

And also, can you mention a new file in the documentation?

IIRC, it was my suggestion to measure some stats... If so, can you add:

Suggested-by: Yury Norov <yury.norov@gmail.com> # for stats

> Signed-off-by: Alexander Potapenko <glider@google.com>
> 
> ---
>  v8:
>   - adapt to the new compression API, abandon mteswap_{no,}comp.c
>   - move stats collection to mteswap.c
> 
>  v5:
>   - drop a dead variable from _mte_free_saved_tags() in mteswap_comp.c
>   - ensure MTE compression works with arbitrary page sizes
>   - update patch description
> 
>  v4:
>   - minor code simplifications suggested by Andy Shevchenko, added
>     missing header dependencies
>   - changed compression API names to reflect modifications made to
>     memcomp.h (as suggested by Yury Norov)
> 
>  v3:
>   - Addressed comments by Andy Shevchenko in another patch:
>    - fixed includes order
>    - replaced u64 with unsigned long
>    - added MODULE_IMPORT_NS(MTECOMP)
> ---
>  arch/arm64/mm/mteswap.c | 88 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 84 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index a31833e3ddc54..0f558942d88b8 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -1,28 +1,48 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
> +#include <linux/debugfs.h>
>  #include <linux/pagemap.h>
>  #include <linux/xarray.h>
>  #include <linux/slab.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
>  #include <asm/mte.h>
> +#include <asm/mtecomp.h>
> +#include "mtecomp.h"
> +
> +enum mteswap_counters {
> +	MTESWAP_CTR_INLINE = 0,
> +	MTESWAP_CTR_NOINLINE,
> +	MTESWAP_CTR_SIZE
> +};
> +static atomic_long_t alloc_counters[MTESWAP_CTR_SIZE];
> +static atomic_long_t dealloc_counters[MTESWAP_CTR_SIZE];

I think it's worth to add them and all the book keeping code in
a separate patch? Also can you consider making them configurable,
maybe depending on CONFIG_ARM64_MTE_SWAP_STAT?..

>  static DEFINE_XARRAY(mte_pages);
>  
>  void *mte_allocate_tag_storage(void)
>  {
> -	/* tags granule is 16 bytes, 2 tags stored per byte */
> -	return kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
> +	void *ret;
> +
> +	ret = kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
> +	if (ret)
> +		atomic_long_inc(&alloc_counters[MTESWAP_CTR_NOINLINE]);
> +	return ret;
>  }
>  
>  void mte_free_tag_storage(char *storage)

If you use a term 'free' here, the counter name should probably
reflect that.

>  {
> -	kfree(storage);
> +	if (!mte_is_compressed(storage)) {
> +		kfree(storage);
> +		atomic_long_dec(&alloc_counters[MTESWAP_CTR_NOINLINE]);

s/NOINLINE/OUTLINE ?

> +	} else {
> +		atomic_long_dec(&alloc_counters[MTESWAP_CTR_INLINE]);
> +	}
>  }
>  
>  int mte_save_tags(struct page *page)
>  {
> -	void *tag_storage, *ret;
> +	void *tag_storage, *ret, *compressed;
>  
>  	if (!page_mte_tagged(page))
>  		return 0;
> @@ -32,6 +52,12 @@ int mte_save_tags(struct page *page)
>  		return -ENOMEM;
>  
>  	mte_save_page_tags(page_address(page), tag_storage);
> +	compressed = mte_compress(tag_storage);
> +	if (compressed) {
> +		mte_free_tag_storage(tag_storage);
> +		tag_storage = (void *)compressed;

But 'compressed' is already 'void *', what for typecasting?
Also, it's a bad naming - adjective implies bool type. I'd name it
'compressed_tag', or similar.

> +		atomic_long_inc(&alloc_counters[MTESWAP_CTR_INLINE]);
> +	}

Is it possible to move all this conditional inside the function call?
I feel like it should be a single-line:

	tag_storage = mte_compress(tag_storage);

So that client code will be free of housekeeping details.

>  
>  	/* lookup the swap entry.val from the page */
>  	ret = xa_store(&mte_pages, page_swap_entry(page).val, tag_storage,
> @@ -50,13 +76,20 @@ int mte_save_tags(struct page *page)
>  void mte_restore_tags(swp_entry_t entry, struct page *page)
>  {
>  	void *tags = xa_load(&mte_pages, entry.val);
> +	void *tag_storage = NULL;
>  
>  	if (!tags)
>  		return;
>  
>  	if (try_page_mte_tagging(page)) {
> +		if (mte_is_compressed(tags)) {
> +			tag_storage = mte_allocate_tag_storage();
> +			mte_decompress(tags, tag_storage);
> +			tags = tag_storage;
> +		}

Same here, if it's possible, I'd prefer a single line call instead of
the above chunk:
       
        tags = mte_decompress(tags);
  	if (!tags)
  		return;

And make sure that the decompress code will take care of details.

This would have a clear meaning: we add a compression/decompression
option which is as simple as calling corresponding functions in
mte_save/restore_tags(); and the rest of mte code is untouched

Thanks,
Yury

>  		mte_restore_page_tags(page_address(page), tags);
>  		set_page_mte_tagged(page);
> +		mte_free_tag_storage(tag_storage);
>  	}
>  }
>  
> @@ -83,3 +116,50 @@ void mte_invalidate_tags_area(int type)
>  	}
>  	xa_unlock(&mte_pages);
>  }
> +
> +/* DebugFS interface. */
> +static int stats_show(struct seq_file *seq, void *v)
> +{
> +	unsigned long total_mem_alloc = 0, total_mem_dealloc = 0;
> +	unsigned long total_num_alloc = 0, total_num_dealloc = 0;
> +	unsigned long sizes[2] = { 8, MTE_PAGE_TAG_STORAGE };
> +	long alloc, dealloc;
> +	unsigned long size;
> +	int i;
> +
> +	for (i = 0; i < MTESWAP_CTR_SIZE; i++) {
> +		alloc = atomic_long_read(&alloc_counters[i]);
> +		dealloc = atomic_long_read(&dealloc_counters[i]);
> +		total_num_alloc += alloc;
> +		total_num_dealloc += dealloc;
> +		size = sizes[i];
> +		/*
> +		 * Do not count 8-byte buffers towards compressed tag storage
> +		 * size.
> +		 */
> +		if (i) {
> +			total_mem_alloc += (size * alloc);
> +			total_mem_dealloc += (size * dealloc);
> +		}
> +		seq_printf(seq,
> +			   "%lu bytes: %lu allocations, %lu deallocations\n",
> +			   size, alloc, dealloc);
> +	}
> +	seq_printf(seq, "uncompressed tag storage size: %lu\n",
> +		   (total_num_alloc - total_num_dealloc) *
> +			   MTE_PAGE_TAG_STORAGE);
> +	seq_printf(seq, "compressed tag storage size: %lu\n",
> +		   total_mem_alloc - total_mem_dealloc);
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(stats);
> +
> +static int mteswap_init(void)
> +{
> +	struct dentry *mteswap_dir;
> +
> +	mteswap_dir = debugfs_create_dir("mteswap", NULL);
> +	debugfs_create_file("stats", 0444, mteswap_dir, NULL, &stats_fops);
> +	return 0;
> +}
> +module_init(mteswap_init);
> -- 
> 2.42.0.869.gea05f2083d-goog
