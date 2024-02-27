Return-Path: <linux-kernel+bounces-83058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4A868DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A334C288AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFE91386B2;
	Tue, 27 Feb 2024 10:48:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00143AAF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030914; cv=none; b=g9rlC+MsNyBEi2VTw60VjfW906/aXMlkD/A/ZFOTCBovYOW93Xu9uHC3mDwKAKSAwpAleYa3rD9qqrIjngg/OaQNNaFsWdRCa8WpKKycJrEObcAtRnFOlnh/glI3DLosrtdvVSYOF7+cEdYHngVf5UD+cZ8mau1xvLXenWPZ2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030914; c=relaxed/simple;
	bh=G1C0fQNr8UkQIExRGexWXqds8c9/LSQcxBuWVz/qjzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UANOnTsQbTD75HmO7tXw/yubph9r5avqw73X7G6cpL0C3MeJyXzeMDkwvG5zpLfPb/31Z4DPPpCn4MRMn46JTGcBott8Ys9A+1oxA2oYMobOsyzO8XUkE435XvdVO1tf5313esi3NhJxPurZURCIYjbPBq+XYw8KbfYh8/kLnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7110BDA7;
	Tue, 27 Feb 2024 02:49:08 -0800 (PST)
Received: from [10.1.30.188] (XHFQ2J9959.cambridge.arm.com [10.1.30.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5C213F762;
	Tue, 27 Feb 2024 02:48:28 -0800 (PST)
Message-ID: <f0a5d9c5-5d09-46ac-9d43-ac96738ededf@arm.com>
Date: Tue, 27 Feb 2024 10:48:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: make folio_pte_batch available outside of
 mm/memory.c
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 Yin Fengwei <fengwei.yin@intel.com>
References: <20240227104201.337988-1-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240227104201.337988-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2024 10:42, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> madvise, mprotect and some others might need folio_pte_batch to check if
> a range of PTEs are completely mapped to a large folio with contiguous
> physical addresses. Let's make it available in mm/internal.h.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> [david@redhat.com: improve the doc for the exported func]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  -v2:
>  * inline folio_pte_batch according to Ryan and David;
>  * improve the doc, thanks to David's work on this;
>  * fix tags of David and add David's s-o-b;
>  -v1:
>  https://lore.kernel.org/all/20240227024050.244567-1-21cnbao@gmail.com/
> 
>  mm/internal.h | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/memory.c   | 76 -------------------------------------------
>  2 files changed, 90 insertions(+), 76 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 13b59d384845..fa9e2f7db506 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -83,6 +83,96 @@ static inline void *folio_raw_mapping(struct folio *folio)
>  	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
>  }
>  
> +/* Flags for folio_pte_batch(). */
> +typedef int __bitwise fpb_t;
> +
> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> +#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
> +
> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
> +#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
> +
> +static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
> +{
> +	if (flags & FPB_IGNORE_DIRTY)
> +		pte = pte_mkclean(pte);
> +	if (likely(flags & FPB_IGNORE_SOFT_DIRTY))
> +		pte = pte_clear_soft_dirty(pte);
> +	return pte_wrprotect(pte_mkold(pte));
> +}
> +
> +/**
> + * folio_pte_batch - detect a PTE batch for a large folio
> + * @folio: The large folio to detect a PTE batch for.
> + * @addr: The user virtual address the first page is mapped at.
> + * @start_ptep: Page table pointer for the first entry.
> + * @pte: Page table entry for the first page.
> + * @max_nr: The maximum number of table entries to consider.
> + * @flags: Flags to modify the PTE batch semantics.
> + * @any_writable: Optional pointer to indicate whether any entry except the
> + *		  first one is writable.
> + *
> + * Detect a PTE batch: consecutive (present) PTEs that map consecutive
> + * pages of the same large folio.
> + *
> + * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
> + * the accessed bit, writable bit, dirty bit (with FPB_IGNORE_DIRTY) and
> + * soft-dirty bit (with FPB_IGNORE_SOFT_DIRTY).
> + *
> + * start_ptep must map any page of the folio. max_nr must be at least one and
> + * must be limited by the caller so scanning cannot exceed a single page table.
> + *
> + * Return: the number of table entries in the batch.
> + */
> +static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
> +		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> +		bool *any_writable)
> +{
> +	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
> +	const pte_t *end_ptep = start_ptep + max_nr;
> +	pte_t expected_pte, *ptep;
> +	bool writable;
> +	int nr;
> +
> +	if (any_writable)
> +		*any_writable = false;
> +
> +	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> +	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
> +	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
> +
> +	nr = pte_batch_hint(start_ptep, pte);
> +	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
> +	ptep = start_ptep + nr;
> +
> +	while (ptep < end_ptep) {
> +		pte = ptep_get(ptep);
> +		if (any_writable)
> +			writable = !!pte_write(pte);
> +		pte = __pte_batch_clear_ignored(pte, flags);
> +
> +		if (!pte_same(pte, expected_pte))
> +			break;
> +
> +		/*
> +		 * Stop immediately once we reached the end of the folio. In
> +		 * corner cases the next PFN might fall into a different
> +		 * folio.
> +		 */
> +		if (pte_pfn(pte) >= folio_end_pfn)
> +			break;
> +
> +		if (any_writable)
> +			*any_writable |= writable;
> +
> +		nr = pte_batch_hint(ptep, pte);
> +		expected_pte = pte_advance_pfn(expected_pte, nr);
> +		ptep += nr;
> +	}
> +
> +	return min(ptep - start_ptep, max_nr);
> +}
> +
>  void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>  						int nr_throttled);
>  static inline void acct_reclaim_writeback(struct folio *folio)
> diff --git a/mm/memory.c b/mm/memory.c
> index 1c45b6a42a1b..a7bcc39de56b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -953,82 +953,6 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
>  	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>  }
>  
> -/* Flags for folio_pte_batch(). */
> -typedef int __bitwise fpb_t;
> -
> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> -#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
> -
> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
> -#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
> -
> -static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
> -{
> -	if (flags & FPB_IGNORE_DIRTY)
> -		pte = pte_mkclean(pte);
> -	if (likely(flags & FPB_IGNORE_SOFT_DIRTY))
> -		pte = pte_clear_soft_dirty(pte);
> -	return pte_wrprotect(pte_mkold(pte));
> -}
> -
> -/*
> - * Detect a PTE batch: consecutive (present) PTEs that map consecutive
> - * pages of the same folio.
> - *
> - * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
> - * the accessed bit, writable bit, dirty bit (with FPB_IGNORE_DIRTY) and
> - * soft-dirty bit (with FPB_IGNORE_SOFT_DIRTY).
> - *
> - * If "any_writable" is set, it will indicate if any other PTE besides the
> - * first (given) PTE is writable.
> - */
> -static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
> -		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> -		bool *any_writable)
> -{
> -	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
> -	const pte_t *end_ptep = start_ptep + max_nr;
> -	pte_t expected_pte, *ptep;
> -	bool writable;
> -	int nr;
> -
> -	if (any_writable)
> -		*any_writable = false;
> -
> -	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> -
> -	nr = pte_batch_hint(start_ptep, pte);
> -	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
> -	ptep = start_ptep + nr;
> -
> -	while (ptep < end_ptep) {
> -		pte = ptep_get(ptep);
> -		if (any_writable)
> -			writable = !!pte_write(pte);
> -		pte = __pte_batch_clear_ignored(pte, flags);
> -
> -		if (!pte_same(pte, expected_pte))
> -			break;
> -
> -		/*
> -		 * Stop immediately once we reached the end of the folio. In
> -		 * corner cases the next PFN might fall into a different
> -		 * folio.
> -		 */
> -		if (pte_pfn(pte) >= folio_end_pfn)
> -			break;
> -
> -		if (any_writable)
> -			*any_writable |= writable;
> -
> -		nr = pte_batch_hint(ptep, pte);
> -		expected_pte = pte_advance_pfn(expected_pte, nr);
> -		ptep += nr;
> -	}
> -
> -	return min(ptep - start_ptep, max_nr);
> -}
> -
>  /*
>   * Copy one present PTE, trying to batch-process subsequent PTEs that map
>   * consecutive pages of the same folio by copying them as well.


