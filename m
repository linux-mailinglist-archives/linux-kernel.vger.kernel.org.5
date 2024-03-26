Return-Path: <linux-kernel+bounces-118436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F11F88BAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119E1B222DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC94129E6A;
	Tue, 26 Mar 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnZXP2hr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4140823BF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436316; cv=none; b=PrpJ+eYK7PqFI7+VPfUBQLLQrroOprDpW9OYrYyve694UHo77tGLvJ+7bBcXh9fz4GrTH1Hh166HHtQZOFJ9tOB0fVvKaijrZKkIx+FJGLolWnLHRIQ3dsS4MBin2aSB62CeZD+cl8OxKqany+t7scgyeqypMkBfvRkqE6Kqoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436316; c=relaxed/simple;
	bh=2h+xwPao4UQjY5pzAeqIZuJmOnkTkwIZDSMWkOI2/m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULOn6hyfT2wT8i6tCcUyEgnJiiwxuslSLTxdNAeTnjpGMmm5ghG00K5SxxdhvjDukLy7rjaj8pADYieJPeAT3jcnLPX+TPNnvDqEXvaGAUBa/90DN5qSi/VRlpAoQo59Wlyw5nxX7oIjw0h5TzCWuiGVSamuWFaTdeZen7uy/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnZXP2hr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9A1C433C7;
	Tue, 26 Mar 2024 06:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711436316;
	bh=2h+xwPao4UQjY5pzAeqIZuJmOnkTkwIZDSMWkOI2/m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnZXP2hrOZj2Z8QDTITPOCDYzWo/RpPKcF0v6NAm2SpxZh0PsXWZuJwc3oEBhKUWv
	 Mi68YOrSG5ih18gIT2PvjY4DobC3VNnhLdVZ4TKV5pulyRNF+tgTqiupcSx4gKxdDF
	 jeh31wT4loBcfFORRnpiYexhmfYOeJ0YRYAbUKlUvrW4KnatdYDaSPrIx66kjajELw
	 ZmEbAEgh75QcmMm4slvb4gY5lIJxBCtvKm1zkNq5n1lycKvAdGz+YzlUO+7hqlJNOw
	 OOI24Tspe9k4/8k5zOe4Nf3ymGckG543nJ0Hn4azqvR6YbgKjAskBkT5tdXk4ZBfMA
	 uifqEFW4HXdvQ==
Date: Tue, 26 Mar 2024 08:57:55 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 6/6] mm/mm_init.c: remove arch_reserved_kernel_pages()
Message-ID: <ZgJx8wXHkbY4FsuT@kernel.org>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-7-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325145646.1044760-7-bhe@redhat.com>

On Mon, Mar 25, 2024 at 10:56:46PM +0800, Baoquan He wrote:
> Since the current calculation of calc_nr_kernel_pages() has taken into
> consideration of kernel reserved memory, no need to have
> arch_reserved_kernel_pages() any more.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/powerpc/include/asm/mmu.h |  4 ----
>  arch/powerpc/kernel/fadump.c   |  5 -----
>  include/linux/mm.h             |  3 ---
>  mm/mm_init.c                   | 12 ------------
>  4 files changed, 24 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index 3b72c7ed24cf..aa5c0fd5edb1 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -406,9 +406,5 @@ extern void *abatron_pteptrs[2];
>  #include <asm/nohash/mmu.h>
>  #endif
>  
> -#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
> -#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
> -#endif
> -
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_MMU_H_ */
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index d14eda1e8589..ae8c7619e597 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1735,8 +1735,3 @@ static void __init fadump_reserve_crash_area(u64 base)
>  		memblock_reserve(mstart, msize);
>  	}
>  }
> -
> -unsigned long __init arch_reserved_kernel_pages(void)
> -{
> -	return memblock_reserved_size() / PAGE_SIZE;
> -}
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ad19350e1538..ab1ba0a31429 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3221,9 +3221,6 @@ static inline void show_mem(void)
>  extern long si_mem_available(void);
>  extern void si_meminfo(struct sysinfo * val);
>  extern void si_meminfo_node(struct sysinfo *val, int nid);
> -#ifdef __HAVE_ARCH_RESERVED_KERNEL_PAGES
> -extern unsigned long arch_reserved_kernel_pages(void);
> -#endif
>  
>  extern __printf(3, 4)
>  void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...);
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index e269a724f70e..089dc60159e9 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2373,17 +2373,6 @@ void __init page_alloc_init_late(void)
>  	page_alloc_sysctl_init();
>  }
>  
> -#ifndef __HAVE_ARCH_RESERVED_KERNEL_PAGES
> -/*
> - * Returns the number of pages that arch has reserved but
> - * is not known to alloc_large_system_hash().
> - */
> -static unsigned long __init arch_reserved_kernel_pages(void)
> -{
> -	return 0;
> -}
> -#endif
> -
>  /*
>   * Adaptive scale is meant to reduce sizes of hash tables on large memory
>   * machines. As memory size is increased the scale is also increased but at
> @@ -2426,7 +2415,6 @@ void *__init alloc_large_system_hash(const char *tablename,
>  	if (!numentries) {
>  		/* round applicable memory size up to nearest megabyte */
>  		numentries = nr_kernel_pages;
> -		numentries -= arch_reserved_kernel_pages();
>  
>  		/* It isn't necessary when PAGE_SIZE >= 1MB */
>  		if (PAGE_SIZE < SZ_1M)
> -- 
> 2.41.0
> 

-- 
Sincerely yours,
Mike.

