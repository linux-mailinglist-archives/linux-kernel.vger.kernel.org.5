Return-Path: <linux-kernel+bounces-118426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9875788BA9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFC62A530D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80CF823CA;
	Tue, 26 Mar 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0c1jH74"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E085954BFF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435494; cv=none; b=XfarBpHpesLToSeYruSuq+wbNsVROk29H0hWzKfJgKPLi1CWO7oHjWIXwxlGGi/XVYIn5QrIgdTrNio9KcK3mfiOpHoIrprUz4x5FMA9ALnSPBwXVthjV5V4n5r4Vq08uNX3FFfqAe0JY5rqDhdjjLgJYHstOykyaHkc3aYX/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435494; c=relaxed/simple;
	bh=3CyPtQL/V1IOnl6rwkcMU6bxDU1vSxf5XUjUQAShHFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5WyN9Amm6Pu8iSygT5Ff2GgF2nqPfBBX6TV8HzQStJ1/WVQwnCjokVixk4iTnqVkcFZRYCwZ8CYknYUUXpTipfKyElKANNkZtYe8Nzn6Xz+t9BkNqG20yi0SgL6GhIc3SEfk9xcUL0aFKNqnVJcf7FHBb4eW5LwE9py4YnCF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0c1jH74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC90C433C7;
	Tue, 26 Mar 2024 06:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711435493;
	bh=3CyPtQL/V1IOnl6rwkcMU6bxDU1vSxf5XUjUQAShHFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0c1jH74lsUlDSMa3ELkDTKijMkqveJm6LsL81Sx0ma+ccTrHUXrcHMegPgew044d
	 iHcoNpWTVW9Tkb+KjBc+wjuiql254mwWnFH+IEE6JTyzWP69iALX4w2WXu9arsnVTX
	 KLPiskp39LfseoJhfHX/TJ3W859qKlr3qWYamIyVEjiKoUBrmM0vO3DjzURvmv4lC/
	 darEIMfVk+HuS/rcSTqIB05xbymnlelCexgKHmoWGf3MdT5O3cnggk6ZVmRONOtf7q
	 CCF9JLf4pC40PBjg7pRxuCL2lYk5TdfyaluGh4yRCT3oEwBfvalvFyyEdDZE2VBrWK
	 7ornIKdTuapAw==
Date: Tue, 26 Mar 2024 08:44:11 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/6] x86: remove unneeded memblock_find_dma_reserve()
Message-ID: <ZgJuuwcM4lXsnyX7@kernel.org>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-2-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325145646.1044760-2-bhe@redhat.com>

On Mon, Mar 25, 2024 at 10:56:41PM +0800, Baoquan He wrote:
> Variable dma_reserve and its usage was introduced in commit 0e0b864e069c
> ("[PATCH] Account for memmap and optionally the kernel image as holes").
> Its original purpose was to accounting for the reserved pages in DMA
> zone to make DMA zone's watermarks calculation more accurate on x86.
> 
> However, currently there's zone->managed_pages to account for all
> available pages for buddy, zone->present_pages to account for all
> present physical pages in zone. What is more important, on x86,
> calculating and setting the zone->managed_pages is a temporary move,
> all zone's managed_pages will be zeroed out and reset to the actual
> value according to how many pages are added to buddy allocator in
> mem_init(). Before mem_init(), no buddy alloction is requested. And
> zone's pcp and watermark setting are all done after mem_init(). So,
> no need to worry about the DMA zone's setting accuracy during
> free_area_init().
> 
> Hence, remove memblock_find_dma_reserve() to stop calculating and
> setting dma_reserve.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/x86/include/asm/pgtable.h |  1 -
>  arch/x86/kernel/setup.c        |  2 --
>  arch/x86/mm/init.c             | 47 ----------------------------------
>  3 files changed, 50 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 315535ffb258..cefc7a84f7a4 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1200,7 +1200,6 @@ static inline int pgd_none(pgd_t pgd)
>  extern int direct_gbpages;
>  void init_mem_mapping(void);
>  void early_alloc_pgt_buf(void);
> -extern void memblock_find_dma_reserve(void);
>  void __init poking_init(void);
>  unsigned long init_memory_mapping(unsigned long start,
>  				  unsigned long end, pgprot_t prot);
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index ef206500ed6f..74873bd04ad1 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1106,8 +1106,6 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	arch_reserve_crashkernel();
>  
> -	memblock_find_dma_reserve();
> -
>  	if (!early_xdbc_setup_hardware())
>  		early_xdbc_register_console();
>  
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 679893ea5e68..615f0bf4bda6 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -990,53 +990,6 @@ void __init free_initrd_mem(unsigned long start, unsigned long end)
>  }
>  #endif
>  
> -/*
> - * Calculate the precise size of the DMA zone (first 16 MB of RAM),
> - * and pass it to the MM layer - to help it set zone watermarks more
> - * accurately.
> - *
> - * Done on 64-bit systems only for the time being, although 32-bit systems
> - * might benefit from this as well.
> - */
> -void __init memblock_find_dma_reserve(void)
> -{
> -#ifdef CONFIG_X86_64
> -	u64 nr_pages = 0, nr_free_pages = 0;
> -	unsigned long start_pfn, end_pfn;
> -	phys_addr_t start_addr, end_addr;
> -	int i;
> -	u64 u;
> -
> -	/*
> -	 * Iterate over all memory ranges (free and reserved ones alike),
> -	 * to calculate the total number of pages in the first 16 MB of RAM:
> -	 */
> -	nr_pages = 0;
> -	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
> -		start_pfn = min(start_pfn, MAX_DMA_PFN);
> -		end_pfn   = min(end_pfn,   MAX_DMA_PFN);
> -
> -		nr_pages += end_pfn - start_pfn;
> -	}
> -
> -	/*
> -	 * Iterate over free memory ranges to calculate the number of free
> -	 * pages in the DMA zone, while not counting potential partial
> -	 * pages at the beginning or the end of the range:
> -	 */
> -	nr_free_pages = 0;
> -	for_each_free_mem_range(u, NUMA_NO_NODE, MEMBLOCK_NONE, &start_addr, &end_addr, NULL) {
> -		start_pfn = min_t(unsigned long, PFN_UP(start_addr), MAX_DMA_PFN);
> -		end_pfn   = min_t(unsigned long, PFN_DOWN(end_addr), MAX_DMA_PFN);
> -
> -		if (start_pfn < end_pfn)
> -			nr_free_pages += end_pfn - start_pfn;
> -	}
> -
> -	set_dma_reserve(nr_pages - nr_free_pages);
> -#endif
> -}
> -
>  void __init zone_sizes_init(void)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES];
> -- 
> 2.41.0
> 

-- 
Sincerely yours,
Mike.

