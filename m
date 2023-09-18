Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC75C7A4E69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjIRQRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:17:16 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AB93C0B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:16:47 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4124e1909edso27598521cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695053805; x=1695658605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpekWC9RDoPaptS5D3LgfCtgsKJPqxE0CvywzGx4FOY=;
        b=lTKf5HmXfzz6g0vTbOdb0JTl8mEnT3BgZnUv0j9xGxWthn78YIy2FyIEOrqay5/MiR
         U8TJhjLd5tYhJxCQNZd8w/CgLMbTyYDd2JcQBmFN5Td19Oq/P2F/9K9/mLi0GjYqsXoE
         3IC0hpC4bO0PAuurYcuON9vdTd+ZYo5pXbkl6Rr2PSwPHC93oZWWY8rhBHOk9xpO60Ib
         bGY5g0Nl3Z3Kk1yIVlnUTvBsNaCUCGCIPI8W3Ei2x/S0bWseTCqKc7lgvYDzPhPhYf9l
         WxtnuogXrWxKDzu2j9iaEHRwTLk7W/qtqQqv7l1uBDsV5pCXqV1IgJVr55MtcjWRoXnc
         aTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053805; x=1695658605;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QpekWC9RDoPaptS5D3LgfCtgsKJPqxE0CvywzGx4FOY=;
        b=weai+CHHPqFZaNncVnTb/hNAcR41ypVAoGbUPhku1h/ufrlcWDunxJMeK57JYllYUG
         O5dCeLaXrxn/9SbRijF4jHU5RD8SdHEUnyaxJysxLX1hJZ+jylMrHvkLJabuVU66N6g9
         Jcdpxg9Wb9kiYm2eLA9cRxsSu2Y3TSTelWLmdWXns5fWU2sQMiB7+iojkKi+Nx4rUDAW
         qdZhdusl3BzaoKfpFEOz1kahbXM7/yFvPL41tykXvxZb00i5k4cpc5snNkYxqXU46vn4
         +yLxxiG/Dzz2xB/hI8QDuG+9SUDFCY959tzRts25+9lpnAyRCAtrfhb8q5J6WevUvTi1
         6eUA==
X-Gm-Message-State: AOJu0YzA8AzUSSdh0OPb5WzRtnGWETtTCtjWeNPIsSXM9eMiXrtUDYLB
        Y21eoEUQkExbDKkGwacVVscTAOgEVGrbMO6H+W8=
X-Google-Smtp-Source: AGHT+IG19Ts0EgOuzI/WqXVCrvF4OpJ7JCaLRhVWQBgeNTxF4XOA9vmkEQ2/CAfIf6KkmuJkIwYS+g==
X-Received: by 2002:a17:902:728a:b0:1c4:152a:496c with SMTP id d10-20020a170902728a00b001c4152a496cmr7514885pll.19.1695042889984;
        Mon, 18 Sep 2023 06:14:49 -0700 (PDT)
Received: from [10.254.225.85] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b001a80ad9c599sm8276929plg.294.2023.09.18.06.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 06:14:49 -0700 (PDT)
Message-ID: <7f0db16b-609c-7504-bd5b-52a76e0200b3@bytedance.com>
Date:   Mon, 18 Sep 2023 21:14:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/6] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-7-zhangpeng.00@bytedance.com>
 <20230907201414.dagnqxfnu7f7qzxd@revolver>
 <2868f2d5-1abe-7af6-4196-ee53cfae76a9@bytedance.com>
 <377b1e27-5752-ee04-b568-69b697852228@bytedance.com>
 <20230915200040.ebrri6zy3uccndx2@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230915200040.ebrri6zy3uccndx2@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/16 04:00, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230915 06:57]:
>>
>>
> 
> ...
> 
>>>>> +    if (unlikely(retval))
>>>>>            goto out;
>>>>>        mt_clear_in_rcu(vmi.mas.tree);
>>>>> -    for_each_vma(old_vmi, mpnt) {
>>>>> +    for_each_vma(vmi, mpnt) {
>>>>>            struct file *file;
>>>>>            vma_start_write(mpnt);
>>>>>            if (mpnt->vm_flags & VM_DONTCOPY) {
>>>>>                vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
>>>>> +
>>>>> +            /*
>>>>> +             * Since the new tree is exactly the same as the old one,
>>>>> +             * we need to remove the unneeded VMAs.
>>>>> +             */
>>>>> +            mas_store(&vmi.mas, NULL);
>>>>> +
>>>>> +            /*
>>>>> +             * Even removing an entry may require memory allocation,
>>>>> +             * and if removal fails, we use XA_ZERO_ENTRY to mark
>>>>> +             * from which VMA it failed. The case of encountering
>>>>> +             * XA_ZERO_ENTRY will be handled in exit_mmap().
>>>>> +             */
>>>>> +            if (unlikely(mas_is_err(&vmi.mas))) {
>>>>> +                retval = xa_err(vmi.mas.node);
>>>>> +                mas_reset(&vmi.mas);
>>>>> +                if (mas_find(&vmi.mas, ULONG_MAX))
>>>>> +                    mas_store(&vmi.mas, XA_ZERO_ENTRY);
>>>>> +                goto loop_out;
>>>>> +            }
>>>>> +
>>>>
>>>> Storing NULL may need extra space as you noted, so we need to be careful
>>>> what happens if we don't have that space.  We should have a testcase to
>>>> test this scenario.
>>>>
>>>> mas_store_gfp() should be used with GFP_KERNEL.  The VMAs use GFP_KERNEL
>>>> in this function, see vm_area_dup().
>>>>
>>>> Don't use the exit_mmap() path to undo a failed fork.  You've added
>>>> checks and complications to the exit path for all tasks in the very
>>>> unlikely event that we run out of memory when we hit a very unlikely
>>>> VM_DONTCOPY flag.
>>>>
>>>> I see the issue with having a portion of the tree with new VMAs that are
>>>> accounted and a portion of the tree that has old VMAs that should not be
>>>> looked at.  It was clever to use the XA_ZERO_ENTRY as a stop point, but
>>>> we cannot add that complication to the exit path and then there is the
>>>> OOM race to worry about (maybe, I am not sure since this MM isn't
>>>> active yet).
>>> I encountered some errors after implementing the scheme you mentioned
>>> below.
> 
> What were the errors?  Maybe I missed something or there is another way.
I found the cause of the problem and fixed it, tested the error path and
it seems to be working fine now.

The reason is that "free_pgd_range(tlb, addr, vma->vm_end,floor, next?
next->vm_start: ceiling);" in free_pgtables() does not free all page
tables due to the existence of the last false VMA. I've fixed it.
Thanks.

> 
>>> This would also clutter fork.c and mmap.c, as some internal
>>> functions would need to be made global.
> 
> Could it not be a new function in mm/mmap.c and added to mm/internal.h
> that does the accounting and VMA freeing from [0 - vma->vm_start)?
> 
> Maybe we could use it in the other areas that do this sort of work?
> do_vmi_align_munmap() does something similar to what we need after the
> "Point of no return".
> 
>>>
>>> I thought of another way to put everything into maple tree. In non-RCU
>>> mode, we can remove the last half of the tree without allocating any
>>> memory. This requires modifications to the internal implementation of
>>> mas_store().
>>> Then remove the second half of the tree like this:
>>>
>>> mas.index = 0;
>> Sorry, typo.
>> Change to: mas.index = vma->start
>>> mas.last = ULONGN_MAX;
>>> mas_store(&mas, NULL).
> 
> Well, we know we are not in RCU mode here, but I am concerned about this
> going poorly.
> 
>>
>>>
>>> At least in non-RCU mode, we can do this, since we only need to merge
>>> some nodes, or move some items to adjacent nodes.
>>> However, this will increase the workload significantly.
> 
> In the unlikely event of an issue allocating memory, this would be
> unwelcome.  If we can avoid it, it would be best.  I don't mind being
> slow in error paths, but a significant workload would be rather bad on
> an overloaded system.
> 
>>>
>>>>
>>>> Using what is done in exit_mmap() and do_vmi_align_munmap() as a
>>>> prototype, we can do something like the *untested* code below:
>>>>
>>>> if (unlikely(mas_is_err(&vmi.mas))) {
>>>>      unsigned long max = vmi.index;
>>>>
>>>>      retval = xa_err(vmi.mas.node);
>>>>      mas_set(&vmi.mas, 0);
>>>>      tmp = mas_find(&vmi.mas, ULONG_MAX);
>>>>      if (tmp) { /* Not the first VMA failed */
>>>>          unsigned long nr_accounted = 0;
>>>>
>>>>          unmap_region(mm, &vmi.mas, vma, NULL, mpnt, 0, max, max,
>>>>                  true);
>>>>          do {
>>>>              if (vma->vm_flags & VM_ACCOUNT)
>>>>                  nr_accounted += vma_pages(vma);
>>>>              remove_vma(vma, true);
>>>>              cond_resched();
>>>>              vma = mas_find(&vmi.mas, max - 1);
>>>>          } while (vma != NULL);
>>>>
>>>>          vm_unacct_memory(nr_accounted);
>>>>      }
>>>>      __mt_destroy(&mm->mm_mt);
>>>>      goto loop_out;
>>>> }
>>>>
>>>> Once exit_mmap() is called, the check for OOM (no vma) will catch that
>>>> nothing is left to do.
>>>>
>>>> It might be worth making an inline function to do this to keep the fork
>>>> code clean.  We should test this by detecting a specific task name and
>>>> returning a failure at a given interval:
>>>>
>>>> if (!strcmp(current->comm, "fork_test") {
>>>> ...
>>>> }
>>>>
> ...
> 
> 
> Thanks,
> Liam
> 
