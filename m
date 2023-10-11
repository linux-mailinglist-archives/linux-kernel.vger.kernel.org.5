Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646537C4B19
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjJKHAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjJKHAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:00:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E67C98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:00:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-692d2e8c003so498104b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697007612; x=1697612412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eisx0SLoG8NQB3HMdipM/jpTPkfOLRxxF1G3voEuhm8=;
        b=hbtaAQXRDYTukyfXeCrOi5h/hCBLJ1t3aj8fxKL/F9bhcRNSVxghV64tih7gMK6c8l
         m1iiRTlJ/l4GNth8n18C0GeKFoN+ZfudSK2JvWp8rqs56Y7JCPHYGFuUViU622pc7dKF
         ItUIJg1ddD4J9aXPXASyeXb/MZH9V4+YxToe8PszV8ftGcnsGXjmMg5FRGkVSbCdeWrq
         QmfyEyjpJ9QrkTP/Ziem0qTLFpG5bBrC4ntF3e1mHX92pJgC58ExF0vCP/eDoZIluwLQ
         NoELRrxKJCqzkVDAHiLT/mV2uKNB9yg6N3iX0OTW7YA3U6bQEZqM08bBE25Yd10OGYon
         2kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697007612; x=1697612412;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eisx0SLoG8NQB3HMdipM/jpTPkfOLRxxF1G3voEuhm8=;
        b=DU2a2mM7PxT5N/gFACrY7WckE0UuZiGQpxuwcpSRdzqv94A5q+BEYCikV/vHX/hl9I
         Lc8+myAsjx2nI8NWT++ovYd54NvYeUg7oXmNr2YCCNgu1ekCcmzSsX8pf3sjrzshdY9f
         2hjVbFSi8Crf1DvRl1J+R/X4ir9g6YvQmPNUpjAejiFEGZr1B8CtMwEYsX2gPqg79MDd
         B4t3ylPWnsrJWPQumIASkANc+MeUGfn8nZit7LbfXoxXF0X7tWxBvbmd85VNxS9rVeSI
         CgxBIZnmC3Vpl9AVD0PZ47mTONaP+rBCOmCRfrBkvyw2zB8tKBGytcN25jBmzqeEFHlg
         7b3w==
X-Gm-Message-State: AOJu0YzbBGHQBZpSQK27pqZuLGGBKwyqY5AIh/0zh04iIFetQsMNbkB9
        2EwNu6i44pz2Mvadj31U7ajI3A==
X-Google-Smtp-Source: AGHT+IE1soGw3kd38KXldhL6VMSSOpZLKfiUM40a40dJpnxJBW3U1WyJMy2qKtnzKA2Y7IcTsF91IQ==
X-Received: by 2002:a05:6a00:138e:b0:68f:c2f7:cef0 with SMTP id t14-20020a056a00138e00b0068fc2f7cef0mr29377468pfg.4.1697007612430;
        Wed, 11 Oct 2023 00:00:12 -0700 (PDT)
Received: from [10.84.146.237] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ff13-20020a056a002f4d00b00693390caf39sm9337603pfb.113.2023.10.11.00.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 00:00:11 -0700 (PDT)
Message-ID: <9eb93423-a2ee-4b9c-be8c-108915eb7e0f@bytedance.com>
Date:   Wed, 11 Oct 2023 15:00:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
 <20231009090320.64565-11-zhangpeng.00@bytedance.com>
 <20231011012849.3awzg5sfdk3sqmvo@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20231011012849.3awzg5sfdk3sqmvo@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/11 09:28, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [231009 05:04]:
>> In dup_mmap(), using __mt_dup() to duplicate the old maple tree and then
>> directly replacing the entries of VMAs in the new maple tree can result
>> in better performance. __mt_dup() uses DFS pre-order to duplicate the
>> maple tree, so it is efficient.
>>
>> The average time complexity of __mt_dup() is O(n), where n is the number
>> of VMAs. The proof of the time complexity is provided in the commit log
>> that introduces __mt_dup(). After duplicating the maple tree, each element
>> is traversed and replaced (ignoring the cases of deletion, which are rare).
>> Since it is only a replacement operation for each element, this process is
>> also O(n).
>>
>> Analyzing the exact time complexity of the previous algorithm is
>> challenging because each insertion can involve appending to a node, pushing
>> data to adjacent nodes, or even splitting nodes. The frequency of each
>> action is difficult to calculate. The worst-case scenario for a single
>> insertion is when the tree undergoes splitting at every level. If we
>> consider each insertion as the worst-case scenario, we can determine that
>> the upper bound of the time complexity is O(n*log(n)), although this is a
>> loose upper bound. However, based on the test data, it appears that the
>> actual time complexity is likely to be O(n).
>>
>> As the entire maple tree is duplicated using __mt_dup(), if dup_mmap()
>> fails, there will be a portion of VMAs that have not been duplicated in
>> the maple tree. This makes it impossible to unmap all VMAs in exit_mmap().
>> To solve this problem, undo_dup_mmap() is introduced to handle the failure
>> of dup_mmap(). I have carefully tested the failure path and so far it
>> seems there are no issues.
>>
>> There is a "spawn" in byte-unixbench[1], which can be used to test the
>> performance of fork(). I modified it slightly to make it work with
>> different number of VMAs.
>>
>> Below are the test results. The first row shows the number of VMAs.
>> The second and third rows show the number of fork() calls per ten seconds,
>> corresponding to next-20231006 and the this patchset, respectively. The
>> test results were obtained with CPU binding to avoid scheduler load
>> balancing that could cause unstable results. There are still some
>> fluctuations in the test results, but at least they are better than the
>> original performance.
>>
>> 21     121   221    421    821    1621   3221   6421   12821  25621  51221
>> 112100 76261 54227  34035  20195  11112  6017   3161   1606   802    393
>> 114558 83067 65008  45824  28751  16072  8922   4747   2436   1233   599
>> 2.19%  8.92% 19.88% 34.64% 42.37% 44.64% 48.28% 50.17% 51.68% 53.74% 52.42%
>>
>> [1] https://github.com/kdlucas/byte-unixbench/tree/master
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   include/linux/mm.h |  1 +
>>   kernel/fork.c      | 34 +++++++++++++++++++++----------
>>   mm/internal.h      |  3 ++-
>>   mm/memory.c        |  7 ++++---
>>   mm/mmap.c          | 50 ++++++++++++++++++++++++++++++++++++++++++++--
>>   5 files changed, 78 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 14e50925b76d..d039f10d258e 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3248,6 +3248,7 @@ extern void unlink_file_vma(struct vm_area_struct *);
>>   extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
>>   	unsigned long addr, unsigned long len, pgoff_t pgoff,
>>   	bool *need_rmap_locks);
>> +extern void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end);
>>   extern void exit_mmap(struct mm_struct *);
>>   
>>   static inline int check_data_rlimit(unsigned long rlim,
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 0ff2e0cd4109..5f24f6d68ea4 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   	int retval;
>>   	unsigned long charge = 0;
>>   	LIST_HEAD(uf);
>> -	VMA_ITERATOR(old_vmi, oldmm, 0);
>>   	VMA_ITERATOR(vmi, mm, 0);
>>   
>>   	uprobe_start_dup_mmap();
>> @@ -678,16 +677,25 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   		goto out;
>>   	khugepaged_fork(mm, oldmm);
>>   
>> -	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
>> -	if (retval)
>> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
>> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
>> +	if (unlikely(retval))
>>   		goto out;
>>   
>>   	mt_clear_in_rcu(vmi.mas.tree);
>> -	for_each_vma(old_vmi, mpnt) {
>> +	for_each_vma(vmi, mpnt) {
>>   		struct file *file;
>>   
>>   		vma_start_write(mpnt);
>>   		if (mpnt->vm_flags & VM_DONTCOPY) {
>> +			mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
>> +
>> +			/* If failed, undo all completed duplications. */
>> +			if (unlikely(mas_is_err(&vmi.mas))) {
>> +				retval = xa_err(vmi.mas.node);
>> +				goto loop_out;
>> +			}
>> +
>>   			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
> 
> I am not sure how we are getting away with this, but the mm stats are
> copied before we enter this loop, so I'm surprised that we aren't
> getting complaints about the VMAs that are later than the failure.  I
> don't think this needs to be fixed, it's just odd and it existed before
> this change as well.
> 
>>   			continue;
>>   		}
>> @@ -749,9 +757,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   		if (is_vm_hugetlb_page(tmp))
>>   			hugetlb_dup_vma_private(tmp);
>>   
>> -		/* Link the vma into the MT */
>> -		if (vma_iter_bulk_store(&vmi, tmp))
>> -			goto fail_nomem_vmi_store;
>> +		/*
>> +		 * Link the vma into the MT. After using __mt_dup(), memory
>> +		 * allocation is not necessary here, so it cannot fail.
>> +		 */
>> +		mas_store(&vmi.mas, tmp);
>>   
>>   		mm->map_count++;
>>   		if (!(tmp->vm_flags & VM_WIPEONFORK))
>> @@ -760,15 +770,19 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   		if (tmp->vm_ops && tmp->vm_ops->open)
>>   			tmp->vm_ops->open(tmp);
>>   
>> -		if (retval)
>> +		if (retval) {
>> +			mpnt = vma_next(&vmi);
>>   			goto loop_out;
>> +		}
>>   	}
>>   	/* a new mm has just been created */
>>   	retval = arch_dup_mmap(oldmm, mm);
>>   loop_out:
>>   	vma_iter_free(&vmi);
>> -	if (!retval)
>> +	if (likely(!retval))
>>   		mt_set_in_rcu(vmi.mas.tree);
>> +	else
>> +		undo_dup_mmap(mm, mpnt);
>>   out:
>>   	mmap_write_unlock(mm);
>>   	flush_tlb_mm(oldmm);
>> @@ -778,8 +792,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   	uprobe_end_dup_mmap();
>>   	return retval;
>>   
>> -fail_nomem_vmi_store:
>> -	unlink_anon_vmas(tmp);
>>   fail_nomem_anon_vma_fork:
>>   	mpol_put(vma_policy(tmp));
>>   fail_nomem_policy:
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 18e360fa53bc..bcd92a5b5474 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -111,7 +111,8 @@ void folio_activate(struct folio *folio);
>>   
>>   void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>   		   struct vm_area_struct *start_vma, unsigned long floor,
>> -		   unsigned long ceiling, bool mm_wr_locked);
>> +		   unsigned long ceiling, unsigned long tree_end,
>> +		   bool mm_wr_locked);
>>   void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
>>   
>>   struct zap_details;
>> diff --git a/mm/memory.c b/mm/memory.c
>> index b320af6466cc..51bb1d16a54e 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -363,7 +363,8 @@ void free_pgd_range(struct mmu_gather *tlb,
>>   
>>   void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>   		   struct vm_area_struct *vma, unsigned long floor,
>> -		   unsigned long ceiling, bool mm_wr_locked)
>> +		   unsigned long ceiling, unsigned long tree_end,
>> +		   bool mm_wr_locked)
>>   {
>>   	do {
>>   		unsigned long addr = vma->vm_start;
>> @@ -373,7 +374,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>   		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
>>   		 * be 0.  This will underflow and is okay.
>>   		 */
>> -		next = mas_find(mas, ceiling - 1);
>> +		next = mas_find(mas, tree_end - 1);
>>   
>>   		/*
>>   		 * Hide vma from rmap and truncate_pagecache before freeing
>> @@ -394,7 +395,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>   			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>>   			       && !is_vm_hugetlb_page(next)) {
>>   				vma = next;
>> -				next = mas_find(mas, ceiling - 1);
>> +				next = mas_find(mas, tree_end - 1);
>>   				if (mm_wr_locked)
>>   					vma_start_write(vma);
>>   				unlink_anon_vmas(vma);
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 1855a2d84200..d044d68d1361 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2337,7 +2337,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>>   	mas_set(mas, mt_start);
>>   	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
>>   				 next ? next->vm_start : USER_PGTABLES_CEILING,
>> -				 mm_wr_locked);
>> +				 tree_end, mm_wr_locked);
>>   	tlb_finish_mmu(&tlb);
>>   }
>>   
>> @@ -3197,6 +3197,52 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
>>   }
>>   EXPORT_SYMBOL(vm_brk_flags);
>>   
>> +void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end)
>> +{
>> +	unsigned long tree_end = USER_PGTABLES_CEILING;
>> +	VMA_ITERATOR(vmi, mm, 0);
>> +	struct vm_area_struct *vma;
>> +	unsigned long nr_accounted = 0;
>> +	int count = 0;
>> +
>> +	/*
>> +	 * vma_end points to the first VMA that has not been duplicated. We need
>> +	 * to unmap all VMAs before it.
>> +	 * If vma_end is NULL, it means that all VMAs in the maple tree have
>> +	 * been duplicated, so setting tree_end to USER_PGTABLES_CEILING will
>> +	 * unmap all VMAs in the maple tree.
>> +	 */
>> +	if (vma_end) {
>> +		tree_end = vma_end->vm_start;
>> +		if (tree_end == 0)
>> +			goto destroy;
>> +	}
>> +
>> +	vma = vma_find(&vmi, tree_end);
>> +	if (!vma)
>> +		goto destroy;
>> +
>> +	arch_unmap(mm, vma->vm_start, tree_end);
>> +
>> +	vma_iter_set(&vmi, vma->vm_end);
> 
> FYI, This missing vma_iter_set() in v3 was not caught by your testing
> because it would not cause an issue, just avoid the optimisation in the
> gathering of page tables.
> 
>> +	unmap_region(mm, &vmi.mas, vma, NULL, NULL, 0, tree_end, tree_end, true);
>> +
> 
> I really don't like having to modify unmap_region() and free_pgtables()
> for a rare error case.  Looking into the issue, you are correct in the
> rounding that is happening in free_pgd_range() and this alignment to
> avoid "unnecessary work" is causing us issues.  However, if we open code
> it a lot like what exit_mmap() does, we can avoid changing these
> functions:
> 
> +       lru_add_drain();
> +       tlb_gather_mmu(&tlb, mm);
> +       update_hiwater_rss(mm);
> +       unmap_vmas(&tlb, &vmi.mas, vma, 0, tree_end, tree_end, true);
> +       vma_iter_set(&vmi, vma->vm_end);
> +       free_pgtables(&tlb, &vmi.mas, vma, FIRST_USER_ADDRESS, vma_end->vm_start,
> +                     true);
> +       free_pgd_range(&tlb, vma->vm_start, vma_end->vm_start,
> +                      FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
I think both approaches are valid. If you feel that this method is better,
I can make the necessary changes accordingly. However, take a look at the
following code:

if (is_vm_hugetlb_page(vma)) {
	hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
		floor, next ? next->vm_start : ceiling);
}

In free_pgtables(), there is also a possibility of using
hugetlb_free_pgd_range() to free the page tables. By adding an
additional call to free_pgd_range() instead of hugetlb_free_pgd_range(),
I'm not sure if it would cause any potential issues.
> +       tlb_finish_mmu(&tlb);
> 
> Effectively, we do unmap_region() on our own with an extra
> free_pgd_range() call with the necessary range adjustment.
> 
> We have to add the tlb to this function as well, but it avoids adding
> identical arguments to all other callers.
> 
> I have tested (something like) this with your provided test and it does
> not provide errors on failures.
> 
> What do you think?
> 
>> +	vma_iter_set(&vmi, vma->vm_end);
>> +	do {
>> +		if (vma->vm_flags & VM_ACCOUNT)
>> +			nr_accounted += vma_pages(vma);
>> +		remove_vma(vma, true);
>> +		count++;
>> +		cond_resched();
>> +	} for_each_vma_range(vmi, vma, tree_end);
>> +
>> +	BUG_ON(count != mm->map_count);
>> +	vm_unacct_memory(nr_accounted);
>> +
>> +destroy:
>> +	__mt_destroy(&mm->mm_mt);
>> +}
>> +
>>   /* Release all mmaps. */
>>   void exit_mmap(struct mm_struct *mm)
>>   {
>> @@ -3236,7 +3282,7 @@ void exit_mmap(struct mm_struct *mm)
>>   	mt_clear_in_rcu(&mm->mm_mt);
>>   	mas_set(&mas, vma->vm_end);
>>   	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
>> -		      USER_PGTABLES_CEILING, true);
>> +		      USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true);
>>   	tlb_finish_mmu(&tlb);
>>   
>>   	/*
>> -- 
>> 2.20.1
>>
> 
