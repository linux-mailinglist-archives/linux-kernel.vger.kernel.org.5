Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F447D4AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjJXIqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjJXIqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:46:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E428110
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:45:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c9e06f058bso38475225ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698137152; x=1698741952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QshcxRLMkYxbpDovzhpTFyvJdC1mbiOC7DrihsySHcY=;
        b=XNxYoMp0h0HjwAWxHQ/ayhj6eghZugeHwIIGccbpsXTQRP9ELDvDGwD7XqE7C/C/H+
         CMoNi+UcpIbMgKOG5TNHWyzYpMoQ5gG2wKmKcytgw3C2sqHq3qnEMeK2nR+/RnLz9N6l
         8w9XzrCKcsOFHGVLa/j96zhbr8nyGkjlPHwTcSfzSGvbs3oQNx9IvNx+B4jmuYBzv1c/
         Tv0fXek4J5mMX+oHCB8rWw7c/mOn7ME1oilob973Ugjwe5EbzGR2uSD6ntsPqsFRvh5J
         6Ao/GbBoKrwn0eSTjGAIfdEnW+knS63enFU4ZQKcpl6RB+hiSfSUwZ0tcS4/wYd1GTwg
         iGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698137152; x=1698741952;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QshcxRLMkYxbpDovzhpTFyvJdC1mbiOC7DrihsySHcY=;
        b=jrMAiwLlrwfsbIXgGDW+7Pf7lilzV74zRtYQ0cKogVby/KzHSYLGVznzX0HHOhcQh2
         l4VdaWGe73KYLYH1wBvD2Nns0SeBPIVtJK5zYsLFG3fwhLXYMh71Mq0IOz+Bo78+jvRK
         +F1FVnFs737t395sS2uCSeLNZR7yJXTtzqSrj2OPDPRJUd6sMpnjH+u+tZhI0ux36O8h
         E2O9L1Ux2SAfZw7BwuGkRd3sZZ4tprm1d5Hy8V2CUvRVlgpiFGuXLephr4pewZ+7Thcz
         w6wNuazaQe9a9Wp/+pDYJxWKLekdSeZ6p5BKoQ6SgBS2r1O7iO1TuJdgRkS5/TbKAxoq
         Vkqw==
X-Gm-Message-State: AOJu0YxlSL2YuLmuD97skZkBwYkQt9MkCFmV1TLd+I2ZpGY9akWV+2UU
        aj/7R5Axkv3muoYv7/pdj9D5RQ==
X-Google-Smtp-Source: AGHT+IHU/AWhNhPA3MvC+yOsf1y7zPifeXf6fsB2427YQf9ZBN+LQTweWv9W0xdu4HDJksTGqApvAw==
X-Received: by 2002:a17:903:5d0:b0:1c7:27a1:a9e5 with SMTP id kf16-20020a17090305d000b001c727a1a9e5mr11537246plb.33.1698137151687;
        Tue, 24 Oct 2023 01:45:51 -0700 (PDT)
Received: from [10.84.146.196] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001c74df14e6fsm6990749plg.284.2023.10.24.01.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:45:51 -0700 (PDT)
Message-ID: <2f4422ba-b9d3-4fc1-a502-1060436052ab@bytedance.com>
Date:   Tue, 24 Oct 2023 16:45:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
 <20231016032226.59199-11-zhangpeng.00@bytedance.com>
 <20231017135020.dqq3u6zwvnbrsgfo@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20231017135020.dqq3u6zwvnbrsgfo@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/17 21:50, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [231015 23:23]:
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
>> the maple tree. To handle this, we mark the failure point with
>> XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered, stop
>> releasing VMAs that have not been duplicated after this point.
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
>>   kernel/fork.c | 39 ++++++++++++++++++++++++++++-----------
>>   mm/memory.c   |  7 ++++++-
>>   mm/mmap.c     |  9 ++++++---
>>   3 files changed, 40 insertions(+), 15 deletions(-)
>>
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 0ff2e0cd4109..0be15501e52e 100644
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
>> @@ -678,16 +677,21 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
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
>> +			retval = mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
> 
> vma_iter_clear_gfp() exists, but needs to be relocated from internal.h
> to mm.h to be used here.
Done in v6, thanks.
> 
>> +			if (retval)
>> +				goto loop_out;
>> +
>>   			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
>>   			continue;
>>   		}
>> @@ -749,9 +753,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
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
> 
> Allocations didn't happen here with the bulk store either, and the
> vma_iter_bulk_store() does a mas_store() - see include/linux/mm.h
> 
> The vma iterator is used when possible for type safety.
Done in v6, thanks.
> 
>> +		mas_store(&vmi.mas, tmp);
>>   
>>   		mm->map_count++;
>>   		if (!(tmp->vm_flags & VM_WIPEONFORK))
>> @@ -760,15 +766,28 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
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
>> +	if (!retval) {
>>   		mt_set_in_rcu(vmi.mas.tree);
>> +	} else if (mpnt) {
>> +		/*
>> +		 * The entire maple tree has already been duplicated. If the
>> +		 * mmap duplication fails, mark the failure point with
>> +		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
>> +		 * stop releasing VMAs that have not been duplicated after this
>> +		 * point.
>> +		 */
>> +		mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
>> +		mas_store(&vmi.mas, XA_ZERO_ENTRY);
> 
> vma_iter_clear() exists but uses the preallocation call.  I really don't
> want mas_ calls where unnecessary, but this seems like a special case.
> We have a vma iterator here so it's messy.
If mas_ interface is not used, it may be necessary to add another
vma_iter_ interface to do this.
> 
>> +	}
>>   out:
>>   	mmap_write_unlock(mm);
>>   	flush_tlb_mm(oldmm);
>> @@ -778,8 +797,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   	uprobe_end_dup_mmap();
>>   	return retval;
>>   
>> -fail_nomem_vmi_store:
>> -	unlink_anon_vmas(tmp);
>>   fail_nomem_anon_vma_fork:
>>   	mpol_put(vma_policy(tmp));
>>   fail_nomem_policy:
>> diff --git a/mm/memory.c b/mm/memory.c
>> index b320af6466cc..ea48bd4b1feb 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -374,6 +374,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>   		 * be 0.  This will underflow and is okay.
>>   		 */
>>   		next = mas_find(mas, ceiling - 1);
>> +		if (unlikely(xa_is_zero(next)))
>> +			next = NULL;
>>   
>>   		/*
>>   		 * Hide vma from rmap and truncate_pagecache before freeing
>> @@ -395,6 +397,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>   			       && !is_vm_hugetlb_page(next)) {
>>   				vma = next;
>>   				next = mas_find(mas, ceiling - 1);
>> +				if (unlikely(xa_is_zero(next)))
>> +					next = NULL;
>>   				if (mm_wr_locked)
>>   					vma_start_write(vma);
>>   				unlink_anon_vmas(vma);
>> @@ -1743,7 +1747,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>>   		unmap_single_vma(tlb, vma, start, end, &details,
>>   				 mm_wr_locked);
>>   		hugetlb_zap_end(vma, &details);
>> -	} while ((vma = mas_find(mas, tree_end - 1)) != NULL);
>> +		vma = mas_find(mas, tree_end - 1);
>> +	} while (vma && likely(!xa_is_zero(vma)));
>>   	mmu_notifier_invalidate_range_end(&range);
>>   }
>>   
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 1855a2d84200..12ce17863e62 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -3213,10 +3213,11 @@ void exit_mmap(struct mm_struct *mm)
>>   	arch_exit_mmap(mm);
>>   
>>   	vma = mas_find(&mas, ULONG_MAX);
>> -	if (!vma) {
>> +	if (!vma || unlikely(xa_is_zero(vma))) {
>>   		/* Can happen if dup_mmap() received an OOM */
>>   		mmap_read_unlock(mm);
>> -		return;
>> +		mmap_write_lock(mm);
>> +		goto destroy;
>>   	}
>>   
>>   	lru_add_drain();
>> @@ -3251,11 +3252,13 @@ void exit_mmap(struct mm_struct *mm)
>>   		remove_vma(vma, true);
>>   		count++;
>>   		cond_resched();
>> -	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
>> +		vma = mas_find(&mas, ULONG_MAX);
>> +	} while (vma && likely(!xa_is_zero(vma)));
>>   
>>   	BUG_ON(count != mm->map_count);
>>   
>>   	trace_exit_mmap(mm);
>> +destroy:
>>   	__mt_destroy(&mm->mm_mt);
>>   	mmap_write_unlock(mm);
>>   	vm_unacct_memory(nr_accounted);
>> -- 
>> 2.20.1
>>
> 
