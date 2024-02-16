Return-Path: <linux-kernel+bounces-68624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B4F857D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8591E1C24626
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B0E1292F3;
	Fri, 16 Feb 2024 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqxN2cC8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4C51B966
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089168; cv=none; b=CWxKKtIeNbznRGiUmMM3EAm5gnPXF024vFo1lB04Ym7LmucZ/aRyx51RrKT7PdaTFy6gTL7nRy3pd+Nr8w8l2lZrCBTtmolb6nmGBuFcb3ezucGxzyHCW6En9NbN+Rwt9HJY9rj6KqinQBOlTi0g8xooc2ZjzNcnTWChLtVu55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089168; c=relaxed/simple;
	bh=j1gARnrStxs9TGrBtAtjswrLM8Ze75CW5vUX+LzHO+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc/++xwn3Ld64mHP96pZZznOfaNK/1zGSqFdyAwdfRWcChO19v7Tl+GJwpNajDKKjClnX/R5WgH+Y2eZsW1dOAhazYxZi18rTKNbGytkVlcr7fndrXvA9adgs4ZR9BeR/N98SJazXJai4DgJ0eoNgXNaJz6ridNrlCBp/XGI0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqxN2cC8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708089166; x=1739625166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j1gARnrStxs9TGrBtAtjswrLM8Ze75CW5vUX+LzHO+0=;
  b=HqxN2cC8ChYgG/2F/SLgEZKy8I8PI5SHFWhztAnCZwkBt1FEdIrXeqHU
   +xiZ9MpQKdb4b7ryZYSrh47yV1shhJgpu+WlyNhaNFhjZi36o2DJN4NMi
   OAXk4StQ0dZS2ZAeWnRM9YMxV4MdXlUMnCQnhqSpQFAlJRozDP1Fa7Ze8
   UniQjEbv8aDpp+FcEbTVUAYlCNd72sTdCnOAVh7pxAoHC77pvG+Sz+q7h
   V2HOAL6uXeDKYaK6056SbznB5ux20fnRCyTnKcPe2FtLXmYQnZJx2Gh7Q
   SBar2iVJyYDR2tOay9lWg3XIcYJ6lmOLn4TmhjAANgu1zenhpYW5FeFCp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2359339"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2359339"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 05:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="935846694"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="935846694"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2024 05:12:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C37C42CB; Fri, 16 Feb 2024 15:12:39 +0200 (EET)
Date: Fri, 16 Feb 2024 15:12:39 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, debug@rivosinc.com, 
	broonie@kernel.org, keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org, 
	peterz@infradead.org, hpa@zytor.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/8] mm: Take placement mappings gap into account
Message-ID: <3ynogxcgokc6i6xojbxzzwqectg472laes24u7jmtktlxcch5e@dfytra3ia3zc>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
 <20240215231332.1556787-6-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215231332.1556787-6-rick.p.edgecombe@intel.com>

On Thu, Feb 15, 2024 at 03:13:29PM -0800, Rick Edgecombe wrote:
> When memory is being placed, mmap() will take care to respect the guard
> gaps of certain types of memory (VM_SHADOWSTACK, VM_GROWSUP and
> VM_GROWSDOWN). In order to ensure guard gaps between mappings, mmap()
> needs to consider two things:
>  1. That the new mapping isn’t placed in an any existing mappings guard
>     gaps.
>  2. That the new mapping isn’t placed such that any existing mappings
>     are not in *its* guard gaps.
> 
> The long standing behavior of mmap() is to ensure 1, but not take any care
> around 2. So for example, if there is a PAGE_SIZE free area, and a
> mmap() with a PAGE_SIZE size, and a type that has a guard gap is being
> placed, mmap() may place the shadow stack in the PAGE_SIZE free area. Then
> the mapping that is supposed to have a guard gap will not have a gap to
> the adjacent VMA.
> 
> For MAP_GROWSDOWN/VM_GROWSDOWN and MAP_GROWSUP/VM_GROWSUP this has not
> been a problem in practice because applications place these kinds of
> mappings very early, when there is not many mappings to find a space
> between. But for shadow stacks, they may be placed throughout the lifetime
> of the application.
> 
> So define a VM_UNMAPPED_START_GAP_SET flag to specify that a start_gap
> field has been set, as most vm_unmapped_area_info structs are not zeroed,
> so the added field will often contain garbage. Use
> VM_UNMAPPED_START_GAP_SET in unmapped_area/_topdown() to find a space that
> includes the guard gap for the new mapping. Take care to not interfere
> with the alignment.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  include/linux/mm.h |  2 ++
>  mm/mmap.c          | 21 ++++++++++++++-------
>  2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9addf16dbf18..160bb6db7a16 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3393,12 +3393,14 @@ extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
>  
>  struct vm_unmapped_area_info {
>  #define VM_UNMAPPED_AREA_TOPDOWN 1
> +#define VM_UNMAPPED_START_GAP_SET 2

The flag seems to be an workaround not to clear the structure. I think
users need to be updated to clear the structure. In most cases rework code
to use C99 struct initializer would do the trick.

>  	unsigned long flags;
>  	unsigned long length;
>  	unsigned long low_limit;
>  	unsigned long high_limit;
>  	unsigned long align_mask;
>  	unsigned long align_offset;
> +	unsigned long start_gap;
>  };
>  
>  extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 936d728ba1ca..1b6c333656f9 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1567,14 +1567,17 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
>   */
>  static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>  {
> -	unsigned long length, gap;
> +	unsigned long length, gap, start_gap = 0;
>  	unsigned long low_limit, high_limit;
>  	struct vm_area_struct *tmp;
>  
>  	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
>  
> +	if (info->flags & VM_UNMAPPED_START_GAP_SET)
> +		start_gap = info->start_gap;
> +
>  	/* Adjust search length to account for worst case alignment overhead */
> -	length = info->length + info->align_mask;
> +	length = info->length + info->align_mask + start_gap;
>  	if (length < info->length)
>  		return -ENOMEM;
>  
> @@ -1586,7 +1589,7 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>  	if (mas_empty_area(&mas, low_limit, high_limit - 1, length))
>  		return -ENOMEM;
>  
> -	gap = mas.index;
> +	gap = mas.index + start_gap;
>  	gap += (info->align_offset - gap) & info->align_mask;

Do we care to check if alignment itself would satisfy start_gap
requirement?

>  	tmp = mas_next(&mas, ULONG_MAX);
>  	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
> @@ -1619,13 +1622,17 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>   */
>  static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>  {
> -	unsigned long length, gap, gap_end;
> +	unsigned long length, gap, gap_end, start_gap = 0;
>  	unsigned long low_limit, high_limit;
>  	struct vm_area_struct *tmp;
>  
>  	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
> +
> +	if (info->flags & VM_UNMAPPED_START_GAP_SET)
> +		start_gap = info->start_gap;
> +
>  	/* Adjust search length to account for worst case alignment overhead */
> -	length = info->length + info->align_mask;
> +	length = info->length + info->align_mask + start_gap;
>  	if (length < info->length)
>  		return -ENOMEM;
>  
> @@ -1832,7 +1839,7 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm, struct file *fi
>  
>  unsigned long
>  __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
> -		unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
> +		    unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)

Unrelated space change.

>  {
>  	unsigned long (*get_area)(struct file *, unsigned long,
>  				  unsigned long, unsigned long, unsigned long)
> @@ -1883,7 +1890,7 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  
>  unsigned long
>  get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
> -		unsigned long pgoff, unsigned long flags)
> +		  unsigned long pgoff, unsigned long flags)

Ditto.

>  {
>  	return __get_unmapped_area(file, addr, len, pgoff, flags, 0);
>  }
> -- 
> 2.34.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

