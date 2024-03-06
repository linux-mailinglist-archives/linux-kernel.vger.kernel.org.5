Return-Path: <linux-kernel+bounces-93387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ECB872EEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D2F289E70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7788B5B662;
	Wed,  6 Mar 2024 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAjNfent"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7664A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709706928; cv=none; b=pgWs51Z3HbFdsA7r9gIbL5A9ki/qkndnIkbfpEDSWjSrA9h9sCn8snM8pLjXaavch4niW69vx7c3gaPBFFgb3nVMHI3fwadjXpCxt+8KdtlpeFnYuYE4Rr2SGf0IY5aBkMJCC00rhOiWEhUHBEdux8CfzELRoFDXcU+svCJryS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709706928; c=relaxed/simple;
	bh=AkqGeSCbOkMjmEjMN58b39D1ek/Y+Xn4vMztXVmtzMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naFxOom/0M0GUgOzvSMxzpwyl2I2IK0efWJj8Bp6xGDHLyJqineCMTRBuqhse1VhcEKLExYVjklSXMIfXBWZnmxFGcJ0UPLzACxsQIvG/a3+yvlDSSK7MzYyJnHNHo6+qT+aWU2BZEUTvRFyF+YUWFTnmfEsFbPWbA4GdgRbDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAjNfent; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98586C433F1;
	Wed,  6 Mar 2024 06:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709706928;
	bh=AkqGeSCbOkMjmEjMN58b39D1ek/Y+Xn4vMztXVmtzMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAjNfentksW5IBwcqdR2CUFKXyp35TuVTau+fIG66JkxSeGh1Di933CcGYONg8lA2
	 kuAcfDOe3S1L/j4Kn200rLcN9mlAzW6a12lAKe1zmSdhdo8Tl5HDhh34P6WoH0xaiK
	 k8H3dCa3gf4LajnlpBV14oo0/IyXbEayUQahpBRAi+C3vZWSUfPEnMTsdD1ul5paUK
	 QFl/Mz0uQhm00r/y/VhMyka89QVNgjFnuQNkY5Y6ZoLSf7DHiKYIC5PvSfaQG1eGKX
	 0+my/6FwLLrYJdbNaEXXJHjtLs3rsz7hTso34bZH6kzJIB/yEqITaR7+QyD/eJZaa9
	 FGHbodbbP4YFg==
Date: Wed, 6 Mar 2024 08:34:35 +0200
From: Mike Rapoport <rppt@kernel.org>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>, Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 09/10] mm/treewide: Drop pXd_large()
Message-ID: <ZegOe5XEsLl9vu3E@kernel.org>
References: <20240305043750.93762-1-peterx@redhat.com>
 <20240305043750.93762-10-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305043750.93762-10-peterx@redhat.com>

On Tue, Mar 05, 2024 at 12:37:49PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> They're not used anymore, drop all of them.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/arm/include/asm/pgtable-2level.h        |  1 -
>  arch/arm/include/asm/pgtable-3level.h        |  1 -
>  arch/loongarch/kvm/mmu.c                     |  2 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  4 +---
>  arch/powerpc/include/asm/pgtable.h           |  4 ----
>  arch/s390/include/asm/pgtable.h              |  8 ++++----
>  arch/sparc/include/asm/pgtable_64.h          |  8 ++++----
>  arch/x86/include/asm/pgtable.h               | 19 +++++++------------
>  arch/x86/kvm/mmu/mmu.c                       |  2 +-
>  9 files changed, 18 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index ce543cd9380c..b0a262566eb9 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -213,7 +213,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>  
>  #define pmd_pfn(pmd)		(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
>  
> -#define pmd_large(pmd)		(pmd_val(pmd) & 2)
>  #define pmd_leaf(pmd)		(pmd_val(pmd) & 2)
>  #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
>  #define pmd_present(pmd)	(pmd_val(pmd))
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index 71c3add6417f..4b1d9eb3908a 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -118,7 +118,6 @@
>  						 PMD_TYPE_TABLE)
>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
>  						 PMD_TYPE_SECT)
> -#define pmd_large(pmd)		pmd_sect(pmd)
>  #define pmd_leaf(pmd)		pmd_sect(pmd)
>  
>  #define pud_clear(pudp)			\
> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index 50a6acd7ffe4..a556cff35740 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
> @@ -723,7 +723,7 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
>  	/*
>  	 * Read each entry once.  As above, a non-leaf entry can be promoted to
>  	 * a huge page _during_ this walk.  Re-reading the entry could send the
> -	 * walk into the weeks, e.g. p*d_large() returns false (sees the old
> +	 * walk into the weeks, e.g. p*d_leaf() returns false (sees the old
>  	 * value) and then p*d_offset() walks into the target huge page instead
>  	 * of the old page table (sees the new value).
>  	 */
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 3e99e409774a..df66dce8306f 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1437,17 +1437,15 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
>  }
>  
>  /*
> - * Like pmd_huge() and pmd_large(), but works regardless of config options
> + * Like pmd_huge(), but works regardless of config options
>   */
>  #define pmd_leaf pmd_leaf
> -#define pmd_large pmd_leaf
>  static inline bool pmd_leaf(pmd_t pmd)
>  {
>  	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
>  }
>  
>  #define pud_leaf pud_leaf
> -#define pud_large pud_leaf
>  static inline bool pud_leaf(pud_t pud)
>  {
>  	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index e6edf1cdbc5b..239709a2f68e 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -101,10 +101,6 @@ void poking_init(void);
>  extern unsigned long ioremap_bot;
>  extern const pgprot_t protection_map[16];
>  
> -#ifndef pmd_large
> -#define pmd_large(pmd)		0
> -#endif
> -
>  /* can we use this in kvm */
>  unsigned long vmalloc_to_phys(void *vmalloc_addr);
>  
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index a5f16a244a64..9e08af5b9247 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -705,16 +705,16 @@ static inline int pud_none(pud_t pud)
>  	return pud_val(pud) == _REGION3_ENTRY_EMPTY;
>  }
>  
> -#define pud_leaf	pud_large
> -static inline int pud_large(pud_t pud)
> +#define pud_leaf pud_leaf
> +static inline int pud_leaf(pud_t pud)
>  {
>  	if ((pud_val(pud) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R3)
>  		return 0;
>  	return !!(pud_val(pud) & _REGION3_ENTRY_LARGE);
>  }
>  
> -#define pmd_leaf	pmd_large
> -static inline int pmd_large(pmd_t pmd)
> +#define pmd_leaf pmd_leaf
> +static inline int pmd_leaf(pmd_t pmd)
>  {
>  	return (pmd_val(pmd) & _SEGMENT_ENTRY_LARGE) != 0;
>  }
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 652af9d63fa2..6ff0a28d5fd1 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -680,8 +680,8 @@ static inline unsigned long pte_special(pte_t pte)
>  	return pte_val(pte) & _PAGE_SPECIAL;
>  }
>  
> -#define pmd_leaf	pmd_large
> -static inline unsigned long pmd_large(pmd_t pmd)
> +#define pmd_leaf pmd_leaf
> +static inline unsigned long pmd_leaf(pmd_t pmd)
>  {
>  	pte_t pte = __pte(pmd_val(pmd));
>  
> @@ -867,8 +867,8 @@ static inline pmd_t *pud_pgtable(pud_t pud)
>  /* only used by the stubbed out hugetlb gup code, should never be called */
>  #define p4d_page(p4d)			NULL
>  
> -#define pud_leaf	pud_large
> -static inline unsigned long pud_large(pud_t pud)
> +#define pud_leaf pud_leaf
> +static inline unsigned long pud_leaf(pud_t pud)
>  {
>  	pte_t pte = __pte(pud_val(pud));
>  
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 9db7a38a0e9f..cfc84c55d0e6 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -251,8 +251,8 @@ static inline unsigned long pgd_pfn(pgd_t pgd)
>  	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
>  }
>  
> -#define p4d_leaf	p4d_large
> -static inline int p4d_large(p4d_t p4d)
> +#define p4d_leaf p4d_leaf
> +static inline int p4d_leaf(p4d_t p4d)
>  {
>  	/* No 512 GiB pages yet */
>  	return 0;
> @@ -260,14 +260,14 @@ static inline int p4d_large(p4d_t p4d)
>  
>  #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
>  
> -#define pmd_leaf	pmd_large
> -static inline int pmd_large(pmd_t pte)
> +#define pmd_leaf pmd_leaf
> +static inline int pmd_leaf(pmd_t pte)
>  {
>  	return pmd_flags(pte) & _PAGE_PSE;
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -/* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_large */
> +/* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_leaf */
>  static inline int pmd_trans_huge(pmd_t pmd)
>  {
>  	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
> @@ -1085,8 +1085,8 @@ static inline pmd_t *pud_pgtable(pud_t pud)
>   */
>  #define pud_page(pud)	pfn_to_page(pud_pfn(pud))
>  
> -#define pud_leaf	pud_large
> -static inline int pud_large(pud_t pud)
> +#define pud_leaf pud_leaf
> +static inline int pud_leaf(pud_t pud)
>  {
>  	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
>  		(_PAGE_PSE | _PAGE_PRESENT);
> @@ -1096,11 +1096,6 @@ static inline int pud_bad(pud_t pud)
>  {
>  	return (pud_flags(pud) & ~(_KERNPG_TABLE | _PAGE_USER)) != 0;
>  }
> -#else
> -static inline int pud_large(pud_t pud)
> -{
> -	return 0;
> -}
>  #endif	/* CONFIG_PGTABLE_LEVELS > 2 */
>  
>  #if CONFIG_PGTABLE_LEVELS > 3
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 5cb5bc4a72c4..58f5e6b637b4 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3110,7 +3110,7 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
>  	/*
>  	 * Read each entry once.  As above, a non-leaf entry can be promoted to
>  	 * a huge page _during_ this walk.  Re-reading the entry could send the
> -	 * walk into the weeks, e.g. p*d_large() returns false (sees the old
> +	 * walk into the weeks, e.g. p*d_leaf() returns false (sees the old
>  	 * value) and then p*d_offset() walks into the target huge page instead
>  	 * of the old page table (sees the new value).
>  	 */
> -- 
> 2.44.0
> 
> 

-- 
Sincerely yours,
Mike.

