Return-Path: <linux-kernel+bounces-149751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301748A9567
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D84281F90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48B3158A00;
	Thu, 18 Apr 2024 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYfc6xjD"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C592E403
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430523; cv=none; b=akpC0eY1cmrFBIumu8RRUKzmoA8r6yf/eFcdjPqupotISvmucIscDQuZHmCSup2WikPg1U1qOS06wTObaL2fhyM+kijnewC5DAkk//L2j+UhpVRT5fCPxgPTRpmr9R4LaTQxHIFq/ow/e8K+ZxWC6FedgI2XDFClTW4We/10diI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430523; c=relaxed/simple;
	bh=QLn7nZFfQAUU4e0jB/sbvHmNydyEmjT8RxkvfhX2GTM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvsphGpTJBRKEaw3g18fM009/ALV7kuR8rAwhZAeEJVHK8xuWNA7vaP73RbEcrjasdrcBT8jQhMnZcS365oVHyecoP9qPDYiNtMhua8eNJ4NlgZlxaw8DdbGcrdDq0eGefDe92bsBVpeHD1DrDbsC9tARyAeF/Q93B3g4zoHSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYfc6xjD; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5176f217b7bso931610e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713430519; x=1714035319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ATTOtpITJHTqXd4qITdiMR9j7i3v4ta7d8GuQUxjQKg=;
        b=mYfc6xjDWhMyuayl92t86NeHak1zKnD04PCzKaszgdGg+Whs4hWRNCarJQ+zIydLQ8
         UQxCpqlPUAdW7s2oJ2RqElmJYjMajaiFuxNEH2KPTJX/tBtND83A2mV19CUIx1AJanWe
         50Hg9JTA6+A4gOA43XvZo7/nUQEySG3BiKgvT+XGMkqUFknMEkAqP3DhoszLgDAge5dJ
         ZECGtmB67H2sPCTna62agIWKbtZPHuhyf0PVlUQRk5S52szIUmc/K+cz3QWVbSORm4No
         IVhGTnPNgXgwRhLK5QlWG5PiOZv6IpXx9Cbi2qgJhsZHW+3bsnwnaRuAcF4dSKFa97NT
         w8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713430519; x=1714035319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATTOtpITJHTqXd4qITdiMR9j7i3v4ta7d8GuQUxjQKg=;
        b=iC1I8ytFhXqvN8hONAoarovbOunfdqo+3K8mUC9F0gDGb+KjQ09BNnOmvRRWZ/2Xyb
         UUH1Y3vHiX9GDYxn6MGNDZCQnT9ipNEBnQ5goMhD3fBcaWaCOuagf6qDCbBAaHdwBccd
         URm09WaBG/GwDC+fpuwWggVR/2iUKPy67r9dXm3DrVcfPzF58Styj/OL3iK+IPeR4zJR
         z/iU7ZW8GFxh5JcC6E1L1jLYrkLQIpAsTA06vxeC8+qCmbZLuimFYJJSdgT/RoVxdsVu
         dbFdvkOACqPq8kIcn2HoIFoQjiYKHbUYp8lMDKjBrZya+QGlAqLm+FonT93EVJOc8m3D
         dPfw==
X-Forwarded-Encrypted: i=1; AJvYcCW990zPbYV34ZVmGFKCQF66hUKyI6WAtKh30coQQl2QhFol21GPJWP+/g2npC4TI5tDrhptB/3E4BvYDTT2usnKzIUmP3lI5T4KHhXq
X-Gm-Message-State: AOJu0YzucHsL4nXZCyHUK0VJ8OSertYJ8VLr3fObZaGn2AG4oOTuKX9n
	LMLMqhCajvnnuT4dKSkOBjOBx2a6vmc7qhH5KcbKOxeOaFm2WQHR
X-Google-Smtp-Source: AGHT+IHi5RkkzxI9vaTl7K0CKyoJi0lVLO/HprgvfOejQQ/ALyXGw9R75sHNZaJznI+ya9Itzk7Lcw==
X-Received: by 2002:a19:434a:0:b0:516:cd71:9bb1 with SMTP id m10-20020a19434a000000b00516cd719bb1mr1195915lfj.38.1713430519072;
        Thu, 18 Apr 2024 01:55:19 -0700 (PDT)
Received: from pc636 (host-90-233-210-75.mobileonline.telia.com. [90.233.210.75])
        by smtp.gmail.com with ESMTPSA id p26-20020ac246da000000b005192bf678a3sm155253lfo.104.2024.04.18.01.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:55:18 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 18 Apr 2024 10:55:16 +0200
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH 1/5] mm: allow arch refinement/skip for vmap alloc
Message-ID: <ZiDf9AeFUG22CEU5@pc636>
References: <20240416122254.868007168-1-mbland@motorola.com>
 <20240416122254.868007168-2-mbland@motorola.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416122254.868007168-2-mbland@motorola.com>

On Tue, Apr 02, 2024 at 03:15:01PM -0500, Maxwell Bland wrote:
> Makes red black tree allocation more flexible on a per-architecture
> basis by introducing an optional hooks to refine the red-black tree
> structuring and exposing vmalloc functions for clipping vmap areas,
> finding vmap areas, and inserting vmap areas.
> 
> With this patch, the red-black vmap tree can be refined to account for
> architecture-specific memory management operations, most notably address
> space layout randomization, as these features conflict with generic
> management of a single vmalloc_start to vmalloc_end range as given by
> mm/vmalloc.c.
> 
> For example, x86 is forced to restrict aslr to 1024 possible locations,
> which is a very, very small number, and arm64 breaks standard code/data
> partitioning altogether, which prevents the enforcement of performant
> immmutability on kernel page tables.
> 
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> ---
>  include/linux/vmalloc.h | 24 ++++++++++++++++++++++++
>  mm/vmalloc.c            | 16 ++++++++++------
>  2 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 98ea90e90439..3c5ce7ee0bea 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -12,6 +12,7 @@
>  
>  #include <asm/vmalloc.h>
>  
> +struct kmem_cache;
>  struct vm_area_struct;		/* vma defining user mapping in mm_types.h */
>  struct notifier_block;		/* in notifier.h */
>  struct iov_iter;		/* in uio.h */
> @@ -125,6 +126,21 @@ static inline pgprot_t arch_vmap_pgprot_tagged(pgprot_t prot)
>  }
>  #endif
>  
> +#ifndef arch_skip_va
> +static inline bool arch_skip_va(struct vmap_area *va, unsigned long vstart)
> +{
> +	return false;
> +}
> +#endif
> +
> +#ifndef arch_refine_vmap_space
> +static inline void arch_refine_vmap_space(struct rb_root *root,
> +					  struct list_head *head,
> +					  struct kmem_cache *cachep)
> +{
> +}
> +#endif
> +
>  /*
>   *	Highlevel APIs for driver use
>   */
> @@ -214,6 +230,14 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
>  void free_vm_area(struct vm_struct *area);
>  extern struct vm_struct *remove_vm_area(const void *addr);
>  extern struct vm_struct *find_vm_area(const void *addr);
> +extern void insert_vmap_area_augment(struct vmap_area *va, struct rb_node *from,
> +				     struct rb_root *root,
> +				     struct list_head *head);
> +extern int va_clip(struct rb_root *root, struct list_head *head,
> +		   struct vmap_area *va, unsigned long nva_start_addr,
> +		   unsigned long size);
> +extern struct vmap_area *__find_vmap_area(unsigned long addr,
> +					  struct rb_root *root);
>
To me it looks like you want to make internal functions as public for
everyone which is not good, imho.

>  struct vmap_area *find_vmap_area(unsigned long addr);
>  
>  static inline bool is_vm_area_hugepages(const void *addr)
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 68fa001648cc..de4577a3708e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -989,7 +989,7 @@ unsigned long vmalloc_nr_pages(void)
>  	return atomic_long_read(&nr_vmalloc_pages);
>  }
>  
> -static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
> +struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
>  {
>  	struct rb_node *n = root->rb_node;
>  
> @@ -1322,7 +1322,7 @@ insert_vmap_area(struct vmap_area *va,
>  		link_va(va, root, parent, link, head);
>  }
>  
> -static void
> +void
>  insert_vmap_area_augment(struct vmap_area *va,
>  	struct rb_node *from, struct rb_root *root,
>  	struct list_head *head)
> @@ -1501,7 +1501,7 @@ find_vmap_lowest_match(struct rb_root *root, unsigned long size,
>  				vstart < va->va_start) {
>  			node = node->rb_left;
>  		} else {
> -			if (is_within_this_va(va, size, align, vstart))
> +			if (!arch_skip_va(va, vstart) && is_within_this_va(va, size, align, vstart))
>  				return va;
>  
>  			/*
> @@ -1522,7 +1522,8 @@ find_vmap_lowest_match(struct rb_root *root, unsigned long size,
>  			 */
>  			while ((node = rb_parent(node))) {
>  				va = rb_entry(node, struct vmap_area, rb_node);
> -				if (is_within_this_va(va, size, align, vstart))
> +				if (!arch_skip_va(va, vstart) &&
> +				    is_within_this_va(va, size, align, vstart))
>  					return va;
>  
>  				if (get_subtree_max_size(node->rb_right) >= length &&
> @@ -1554,7 +1555,7 @@ find_vmap_lowest_linear_match(struct list_head *head, unsigned long size,
>  	struct vmap_area *va;
>  
>  	list_for_each_entry(va, head, list) {
> -		if (!is_within_this_va(va, size, align, vstart))
> +		if (arch_skip_va(va, vstart) || !is_within_this_va(va, size, align, vstart))
>  			continue;
>  
arch_skip_va() injections into the search algorithm sounds like a hack
and might lead(if i do not miss something, need to check closer) to alloc
failures when we go toward a reserved VA but we are not allowed to allocate
from.

>  		return va;
> @@ -1617,7 +1618,7 @@ classify_va_fit_type(struct vmap_area *va,
>  	return type;
>  }
>  
> -static __always_inline int
> +__always_inline int
>  va_clip(struct rb_root *root, struct list_head *head,
>  		struct vmap_area *va, unsigned long nva_start_addr,
>  		unsigned long size)
> @@ -5129,4 +5130,7 @@ void __init vmalloc_init(void)
>  	vmap_node_shrinker->count_objects = vmap_node_shrink_count;
>  	vmap_node_shrinker->scan_objects = vmap_node_shrink_scan;
>  	shrinker_register(vmap_node_shrinker);
> +
> +	arch_refine_vmap_space(&free_vmap_area_root, &free_vmap_area_list,
> +			       vmap_area_cachep);
>  }
>
Why do not you allocate just using a specific range from MODULES_ASLR_START
till VMALLOC_END?

Thanks!

--
Uladzislau Rezki

