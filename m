Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74776E428
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjHCJSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjHCJSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:18:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00882130
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:17:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f74a8992so129209b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691054276; x=1691659076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRlGFt/b+eLL81fhIoc4g8Xnl9ZXM32WoVDoUNCTBPI=;
        b=Wy81fxHcIQAkCOjVlz/bXR2PEFHMyBpLCB/0rUSMHU/+AN9M9o+SWg7IeMqOl7dtXJ
         u4X5Xmtgbr1j2HlIsVyt5UNXMMDLJxoTaRAclA9TqXI7WKrW9+IBnJfH+DTnoe8C1pR/
         Ua8vJ7SkvZ3BfGOtQX4f/oVAVl0L5wivyhyymiEivlwLY8IuN30VfinZQXBHe84NQwjn
         vxvkWuD4OufFqIDnDBL6RQ49ypYOjDcMNYf9unSkCaHxT+Wgbf46GjdKuPaFlP2cpDBq
         02ZumQIM1oI0uqByQs5V8bGS3+Zz9zHG2v99uaBr1W/QHfi9khuYRMuO4GhTbMXqmhfg
         fEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691054276; x=1691659076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRlGFt/b+eLL81fhIoc4g8Xnl9ZXM32WoVDoUNCTBPI=;
        b=K+s/I9b12RTHU+7cC9rvzzjmtLQsfeEZ8Myb45YUy97yIaYsexsrjLiKiaV7oGrWet
         CkPeSqDbD+ZglCdkhxPhkmC/nSerpNmfTqbeJUx3HBRrQUcdQGLQngVc5RNRRuqb4YIH
         0oqBZidGWy+yNCFOEmmiwzHYcH8f6pSeALlb/7dAbG6uBZULkLbGYrwss/lesPl/kuO/
         uyFrumrbFxmBUMhk5JChAOpnhk5gtBrII41yvzIYCxFn5ezMwrUuV2ijwxnoGgdsZX4X
         cU/omvby0yy8XIITZVAYee1COiUSTI0UluouWU4KIpfojTufNdJsmPxysU0cTegDlv2J
         9zmw==
X-Gm-Message-State: ABy/qLZhJfJrZcWes7n62FG/abJFvuChuf364mFB4yjDO/PRL1WqOx1i
        5zSoITTjyHJBQ1tnTZPsyitWLQ==
X-Google-Smtp-Source: APBJJlF1R67qBIL1XVp7Pt2rmoZtkUWRGJa2ZDwYOFvPcmMmGiKpQTlnEEw5SIHIdIIPkp3jz66NKQ==
X-Received: by 2002:a05:6a21:9989:b0:111:a0e5:d2b7 with SMTP id ve9-20020a056a21998900b00111a0e5d2b7mr20024356pzb.4.1691054276027;
        Thu, 03 Aug 2023 02:17:56 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id g10-20020a63b14a000000b0056471d2ae8fsm3892765pgp.90.2023.08.03.02.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 02:17:55 -0700 (PDT)
Message-ID: <0df84f9f-e9b0-80b1-4c9e-95abc1a73a96@bytedance.com>
Date:   Thu, 3 Aug 2023 17:17:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 10/13] mm/khugepaged: collapse_pte_mapped_thp() with
 mmap_read_lock()
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
 <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/7/12 12:42, Hugh Dickins wrote:
> Bring collapse_and_free_pmd() back into collapse_pte_mapped_thp().
> It does need mmap_read_lock(), but it does not need mmap_write_lock(),
> nor vma_start_write() nor i_mmap lock nor anon_vma lock.  All racing
> paths are relying on pte_offset_map_lock() and pmd_lock(), so use those.
> 
> Follow the pattern in retract_page_tables(); and using pte_free_defer()
> removes most of the need for tlb_remove_table_sync_one() here; but call
> pmdp_get_lockless_sync() to use it in the PAE case.
> 
> First check the VMA, in case page tables are being torn down: from JannH.
> Confirm the preliminary find_pmd_or_thp_or_none() once page lock has been
> acquired and the page looks suitable: from then on its state is stable.
> 
> However, collapse_pte_mapped_thp() was doing something others don't:
> freeing a page table still containing "valid" entries.  i_mmap lock did
> stop a racing truncate from double-freeing those pages, but we prefer
> collapse_pte_mapped_thp() to clear the entries as usual.  Their TLB
> flush can wait until the pmdp_collapse_flush() which follows, but the
> mmu_notifier_invalidate_range_start() has to be done earlier.
> 
> Do the "step 1" checking loop without mmu_notifier: it wouldn't be good
> for khugepaged to keep on repeatedly invalidating a range which is then
> found unsuitable e.g. contains COWs.  "step 2", which does the clearing,
> must then be more careful (after dropping ptl to do mmu_notifier), with
> abort prepared to correct the accounting like "step 3".  But with those
> entries now cleared, "step 4" (after dropping ptl to do pmd_lock) is kept
> safe by the huge page lock, which stops new PTEs from being faulted in.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>   mm/khugepaged.c | 172 ++++++++++++++++++++++----------------------------
>   1 file changed, 77 insertions(+), 95 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 3bb05147961b..46986eb4eebb 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1483,7 +1483,7 @@ static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>   	return ret;
>   }
>   
> -/* hpage must be locked, and mmap_lock must be held in write */
> +/* hpage must be locked, and mmap_lock must be held */
>   static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
>   			pmd_t *pmdp, struct page *hpage)
>   {
> @@ -1495,7 +1495,7 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
>   	};
>   
>   	VM_BUG_ON(!PageTransHuge(hpage));
> -	mmap_assert_write_locked(vma->vm_mm);
> +	mmap_assert_locked(vma->vm_mm);
>   
>   	if (do_set_pmd(&vmf, hpage))
>   		return SCAN_FAIL;
> @@ -1504,48 +1504,6 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
>   	return SCAN_SUCCEED;
>   }
>   
> -/*
> - * A note about locking:
> - * Trying to take the page table spinlocks would be useless here because those
> - * are only used to synchronize:
> - *
> - *  - modifying terminal entries (ones that point to a data page, not to another
> - *    page table)
> - *  - installing *new* non-terminal entries
> - *
> - * Instead, we need roughly the same kind of protection as free_pgtables() or
> - * mm_take_all_locks() (but only for a single VMA):
> - * The mmap lock together with this VMA's rmap locks covers all paths towards
> - * the page table entries we're messing with here, except for hardware page
> - * table walks and lockless_pages_from_mm().
> - */
> -static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
> -				  unsigned long addr, pmd_t *pmdp)
> -{
> -	pmd_t pmd;
> -	struct mmu_notifier_range range;
> -
> -	mmap_assert_write_locked(mm);
> -	if (vma->vm_file)
> -		lockdep_assert_held_write(&vma->vm_file->f_mapping->i_mmap_rwsem);
> -	/*
> -	 * All anon_vmas attached to the VMA have the same root and are
> -	 * therefore locked by the same lock.
> -	 */
> -	if (vma->anon_vma)
> -		lockdep_assert_held_write(&vma->anon_vma->root->rwsem);
> -
> -	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
> -				addr + HPAGE_PMD_SIZE);
> -	mmu_notifier_invalidate_range_start(&range);
> -	pmd = pmdp_collapse_flush(vma, addr, pmdp);
> -	tlb_remove_table_sync_one();
> -	mmu_notifier_invalidate_range_end(&range);
> -	mm_dec_nr_ptes(mm);
> -	page_table_check_pte_clear_range(mm, addr, pmd);
> -	pte_free(mm, pmd_pgtable(pmd));
> -}
> -
>   /**
>    * collapse_pte_mapped_thp - Try to collapse a pte-mapped THP for mm at
>    * address haddr.
> @@ -1561,26 +1519,29 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
>   int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   			    bool install_pmd)
>   {
> +	struct mmu_notifier_range range;
> +	bool notified = false;
>   	unsigned long haddr = addr & HPAGE_PMD_MASK;
>   	struct vm_area_struct *vma = vma_lookup(mm, haddr);
>   	struct page *hpage;
>   	pte_t *start_pte, *pte;
> -	pmd_t *pmd;
> -	spinlock_t *ptl;
> -	int count = 0, result = SCAN_FAIL;
> +	pmd_t *pmd, pgt_pmd;
> +	spinlock_t *pml, *ptl;
> +	int nr_ptes = 0, result = SCAN_FAIL;
>   	int i;
>   
> -	mmap_assert_write_locked(mm);
> +	mmap_assert_locked(mm);
> +
> +	/* First check VMA found, in case page tables are being torn down */
> +	if (!vma || !vma->vm_file ||
> +	    !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
> +		return SCAN_VMA_CHECK;
>   
>   	/* Fast check before locking page if already PMD-mapped */
>   	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
>   	if (result == SCAN_PMD_MAPPED)
>   		return result;
>   
> -	if (!vma || !vma->vm_file ||
> -	    !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
> -		return SCAN_VMA_CHECK;
> -
>   	/*
>   	 * If we are here, we've succeeded in replacing all the native pages
>   	 * in the page cache with a single hugepage. If a mm were to fault-in
> @@ -1610,6 +1571,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   		goto drop_hpage;
>   	}
>   
> +	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
>   	switch (result) {
>   	case SCAN_SUCCEED:
>   		break;
> @@ -1623,27 +1585,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   		goto drop_hpage;
>   	}
>   
> -	/* Lock the vma before taking i_mmap and page table locks */
> -	vma_start_write(vma);
> -
> -	/*
> -	 * We need to lock the mapping so that from here on, only GUP-fast and
> -	 * hardware page walks can access the parts of the page tables that
> -	 * we're operating on.
> -	 * See collapse_and_free_pmd().
> -	 */
> -	i_mmap_lock_write(vma->vm_file->f_mapping);
> -
> -	/*
> -	 * This spinlock should be unnecessary: Nobody else should be accessing
> -	 * the page tables under spinlock protection here, only
> -	 * lockless_pages_from_mm() and the hardware page walker can access page
> -	 * tables while all the high-level locks are held in write mode.
> -	 */
>   	result = SCAN_FAIL;
>   	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
> -	if (!start_pte)
> -		goto drop_immap;
> +	if (!start_pte)		/* mmap_lock + page lock should prevent this */
> +		goto drop_hpage;
>   
>   	/* step 1: check all mapped PTEs are to the right huge page */
>   	for (i = 0, addr = haddr, pte = start_pte;
> @@ -1670,10 +1615,18 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   		 */
>   		if (hpage + i != page)
>   			goto abort;
> -		count++;
>   	}
>   
> -	/* step 2: adjust rmap */
> +	pte_unmap_unlock(start_pte, ptl);
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
> +				haddr, haddr + HPAGE_PMD_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +	notified = true;
> +	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
> +	if (!start_pte)		/* mmap_lock + page lock should prevent this */
> +		goto abort;
> +
> +	/* step 2: clear page table and adjust rmap */
>   	for (i = 0, addr = haddr, pte = start_pte;
>   	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
>   		struct page *page;
> @@ -1681,47 +1634,76 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   
>   		if (pte_none(ptent))
>   			continue;
> -		page = vm_normal_page(vma, addr, ptent);
> -		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
> +		/*
> +		 * We dropped ptl after the first scan, to do the mmu_notifier:
> +		 * page lock stops more PTEs of the hpage being faulted in, but
> +		 * does not stop write faults COWing anon copies from existing
> +		 * PTEs; and does not stop those being swapped out or migrated.
> +		 */
> +		if (!pte_present(ptent)) {
> +			result = SCAN_PTE_NON_PRESENT;
>   			goto abort;
> +		}
> +		page = vm_normal_page(vma, addr, ptent);
> +		if (hpage + i != page)
> +			goto abort;
> +
> +		/*
> +		 * Must clear entry, or a racing truncate may re-remove it.
> +		 * TLB flush can be left until pmdp_collapse_flush() does it.
> +		 * PTE dirty? Shmem page is already dirty; file is read-only.
> +		 */
> +		pte_clear(mm, addr, pte);

This is not non-present PTE entry, so we should call ptep_clear() to let
page_table_check track the PTE clearing operation, right? Otherwise it
may lead to false positives?

Thanks,
Qi

>   		page_remove_rmap(page, vma, false);
> +		nr_ptes++;
>   	}
>   
>   	pte_unmap_unlock(start_pte, ptl);
>   
>   	/* step 3: set proper refcount and mm_counters. */
> -	if (count) {
> -		page_ref_sub(hpage, count);
> -		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
> +	if (nr_ptes) {
> +		page_ref_sub(hpage, nr_ptes);
> +		add_mm_counter(mm, mm_counter_file(hpage), -nr_ptes);
>   	}
>   
> -	/* step 4: remove pte entries */
> -	/* we make no change to anon, but protect concurrent anon page lookup */
> -	if (vma->anon_vma)
> -		anon_vma_lock_write(vma->anon_vma);
> +	/* step 4: remove page table */
>   
> -	collapse_and_free_pmd(mm, vma, haddr, pmd);
> +	/* Huge page lock is still held, so page table must remain empty */
> +	pml = pmd_lock(mm, pmd);
> +	if (ptl != pml)
> +		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> +	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
> +	pmdp_get_lockless_sync();
> +	if (ptl != pml)
> +		spin_unlock(ptl);
> +	spin_unlock(pml);
>   
> -	if (vma->anon_vma)
> -		anon_vma_unlock_write(vma->anon_vma);
> -	i_mmap_unlock_write(vma->vm_file->f_mapping);
> +	mmu_notifier_invalidate_range_end(&range);
> +
> +	mm_dec_nr_ptes(mm);
> +	page_table_check_pte_clear_range(mm, haddr, pgt_pmd);
> +	pte_free_defer(mm, pmd_pgtable(pgt_pmd));
>   
>   maybe_install_pmd:
>   	/* step 5: install pmd entry */
>   	result = install_pmd
>   			? set_huge_pmd(vma, haddr, pmd, hpage)
>   			: SCAN_SUCCEED;
> -
> +	goto drop_hpage;
> +abort:
> +	if (nr_ptes) {
> +		flush_tlb_mm(mm);
> +		page_ref_sub(hpage, nr_ptes);
> +		add_mm_counter(mm, mm_counter_file(hpage), -nr_ptes);
> +	}
> +	if (start_pte)
> +		pte_unmap_unlock(start_pte, ptl);
> +	if (notified)
> +		mmu_notifier_invalidate_range_end(&range);
>   drop_hpage:
>   	unlock_page(hpage);
>   	put_page(hpage);
>   	return result;
> -
> -abort:
> -	pte_unmap_unlock(start_pte, ptl);
> -drop_immap:
> -	i_mmap_unlock_write(vma->vm_file->f_mapping);
> -	goto drop_hpage;
>   }
>   
>   static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
> @@ -2855,9 +2837,9 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>   		case SCAN_PTE_MAPPED_HUGEPAGE:
>   			BUG_ON(mmap_locked);
>   			BUG_ON(*prev);
> -			mmap_write_lock(mm);
> +			mmap_read_lock(mm);
>   			result = collapse_pte_mapped_thp(mm, addr, true);
> -			mmap_write_unlock(mm);
> +			mmap_locked = true;
>   			goto handle_result;
>   		/* Whitelisted set of results where continuing OK */
>   		case SCAN_PMD_NULL:
