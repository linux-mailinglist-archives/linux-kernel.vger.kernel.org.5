Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C4D790B2F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjICIOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 04:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjICIOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 04:14:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF551136
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 01:14:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-986d8332f50so71454566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 01:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693728849; x=1694333649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYVc0KQcxWsMhJQuzoDqTO76YRj2Zg1n9LjHELSZSO8=;
        b=CZ/ybGS124dtM2SleM3PYnVaRG5nn7nMoQiFlaT7xXXZlVPNYD6x09XyugBySi/9CJ
         au1AUbQw3GSiOzg43Qy+5nNUlvKy+96QVVtZJYm11YODm+tBO9UXByumjnvpMW8f/vV7
         CoqL0SfZOkvzuD/P2OvNOU6BEbcPIKo+N+IJ3qUURMpq1p6UbWKYmaiFERh+2a0o8Uy0
         FXaTnp5VGMC2kR48cUGwdSoZrELnvJumtMM10dwe7Yo+/esOiyMjrp3VGFzSjCiYlgye
         ehiptc6zoVVfPI7Z+4iM8Oj4Szm85S7fm47nRiF6Wp6ILr6oM4BmujV+bnVT67ClBxJw
         KlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693728849; x=1694333649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYVc0KQcxWsMhJQuzoDqTO76YRj2Zg1n9LjHELSZSO8=;
        b=Z341GxbmeoTxrVLXt3u2nNFp/9rzpEwQPKywLrGkREiA/0f0sTHtXPexOeEmyQJo+1
         b5a0K1j3hKsL1qdD7/3rP+nrtHPjb0zDS0FN98I4M+AjNMwRn2wWpfcsZepmnkt5LsWp
         ed+Y3wqMGCHVILgSouSg8ytxKaXuOg241dRTtH8KMzlbMG6nOJjWfUhpL0olCMY/7CDA
         ChcYAqksj2x94gQMsHPcu9mtaRm+/6QQnIr6bzGEeXDkZgJWUYRQTFRbUD/oNq3C3FA2
         g7WMRG/80vOSMRv9s+m6aa3r3cUwsInWcT7ApFghcRGc8Icv9Q5q7yp38+m5+IBbyseL
         E1sw==
X-Gm-Message-State: AOJu0YwSsPEs2biWUGfCVtQ9F0BAT5UhQLpIHDcEgUD8uOX9ceqVlJbG
        Pmfc0KfebrH/Fc3EiRSJ8xr8H4Cb5GAedQ==
X-Google-Smtp-Source: AGHT+IE0FajYit6cPw62SbBgy9GSo42JmyMb/0qdLMXz3mWBrjPvVa20O+5VpeVaOJJsFyh/niqCAg==
X-Received: by 2002:a17:906:748f:b0:9a1:d67c:b4eb with SMTP id e15-20020a170906748f00b009a1d67cb4ebmr4806481ejl.48.1693728849066;
        Sun, 03 Sep 2023 01:14:09 -0700 (PDT)
Received: from f (cst-prg-30-15.cust.vodafone.cz. [46.135.30.15])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906349500b0098f33157e7dsm4478221ejb.82.2023.09.03.01.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 01:14:08 -0700 (PDT)
Date:   Sun, 3 Sep 2023 10:14:04 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 0/9] x86/clear_huge_page: multi-page clearing
Message-ID: <20230903081404.hmkhnrk243h2nuoa@f>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:49:49AM -0700, Ankur Arora wrote:
> This series adds a multi-page clearing primitive, clear_pages(),
> which enables more effective use of x86 string instructions by
> advertising the real region-size to be cleared. 
> 
> Region-size can be used as a hint by uarchs to optimize the
> clearing.
> 
> Also add allow_resched() which marks a code-section as allowing
> rescheduling in the irqentry_exit path. This allows clear_pages()
> to get by without having to call cond_sched() periodically.
> (preempt_model_full() already handles this via
> irqentry_exit_cond_resched(), so we handle this similarly for
> preempt_model_none() and preempt_model_voluntary().)
> 
> Performance
> ==
> 
> With this demand fault performance gets a decent increase:
> 
>   *Milan*     mm/clear_huge_page   x86/clear_huge_page   change    
>                           (GB/s)                (GB/s)             
>                                                                    
>   pg-sz=2MB                14.55                 19.29    +32.5%
>   pg-sz=1GB                19.34                 49.60   +156.4%  
> 
> Milan (and some other AMD Zen uarchs tested) take advantage of the
> hint to elide cacheline allocation for pg-sz=1GB. The cut-off for
> this optimization seems to be at around region-size > LLC-size so
> the pg-sz=2MB load still allocates cachelines.
> 

Have you benchmarked clzero? It is an AMD-specific instruction issuing
non-temporal stores. It is definitely something to try out for 1G pages.

One would think rep stosq has to be at least not worse since the CPU is
explicitly told what to do and is free to optimize it however it sees
fit, but the rep prefix has a long history of underperforming.

I'm not saying it is going to be better, but that this should be tested,
albeit one can easily argue this can be done at a later date.

I would do it myself but my access to AMD CPUs is limited.

> 
>   *Icelakex*  mm/clear_huge_page   x86/clear_huge_page   change   
>                           (GB/s)                (GB/s)            
>                                                                   
>   pg-sz=2MB                 9.19                 12.94   +40.8%  
>   pg-sz=1GB                 9.36                 12.97   +38.5%  
> 
> Icelakex sees a decent improvement in performance but for both
> region-sizes does continue to allocate cachelines.
> 
> 
> Negative: there is, a downside to clearing in larger chunks: the
> current approach clears page-at-a-time, narrowing towards
> the faulting subpage. This has better cache characteristics for
> some sequential access workloads where subpages near the faulting
> page have a greater likelihood of access.
> 
> I'm not sure if there are real cases which care about this workload
> but one example is the vm-scalability/case-anon-w-seq-hugetlb test.
> This test starts a process for each online CPU, with each process
> writing sequentially to its set of hugepages.
> 
> The bottleneck here is the memory pipe and so the improvement in
> stime is limited, and because the clearing is less cache-optimal 
> now, utime suffers from worse user cache misses.
> 
>   *Icelakex*               mm/clear_huge_page  x86/clear_huge_page  change
>   (tasks=128, mem=4GB/task)
> 
>   stime                        286.8 +- 3.6%      243.9 +- 4.1%     -14.9%
>   utime                        497.7 +- 4.1%      553.5 +- 2.0%     +11.2%
>   wall-clock                     6.9 +- 2.8%        7.0 +- 1.4%     + 1.4%
> 
> 
>   *Milan*                  mm/clear_huge_page  x86/clear_huge_page  change
>   (mem=1GB/task, tasks=512)
> 
>   stime                        501.3 +- 1.4%      498.0 +- 0.9%      -0.5%
>   utime                        298.7 +- 1.1%      335.0 +- 2.2%     +12.1%
>   wall-clock                     3.5 +- 2.8%        3.8 +- 2.6%      +8.5%
> 
> The same test performs better if we have a smaller number of processes,
> since there is more backend BW available, and thus the improved stime
> compensates for the worse utime.
> 
> This could be improved by using more circuitous chunking (somewhat
> like this:
> https://lore.kernel.org/lkml/20220606203725.1313715-1-ankur.a.arora@oracle.com/).
> But I'm not sure if it is worth doing. Opinions?
> 
> Patches
> ==
> 
> Patch 1, 2, 3:
>   "mm/clear_huge_page: allow arch override for clear_huge_page()",
>   "mm/huge_page: separate clear_huge_page() and copy_huge_page()",
>   "mm/huge_page: cleanup clear_/copy_subpage()"
> are minor. The first one allows clear_huge_page() to have an
> arch specific version and the other two are mechanical cleanup
> patches.
> 
> Patches 3, 4, 5:
>   "x86/clear_page: extend clear_page*() for multi-page clearing",
>   "x86/clear_page: add clear_pages()",
>   "x86/clear_huge_page: multi-page clearing"
> define the x86 specific clear_pages() and clear_huge_pages().
> 
> Patches 6, 7, 8:
>   "sched: define TIF_ALLOW_RESCHED"
>   "irqentry: define irqentry_exit_allow_resched()"
> which defines allow_resched() to demarcate preemptible sections.
> 
> This gets used in patch 9:
>   "x86/clear_huge_page: make clear_contig_region() preemptible".
> 
> Changelog:
> 
> v2:
>   - Addressed review comments from peterz, tglx.
>   - Removed clear_user_pages(), and CONFIG_X86_32:clear_pages()
>   - General code cleanup
> 
> Also at:
>   github.com/terminus/linux clear-pages.v2
> 
> Comments appreciated!
> 
> Ankur Arora (9):
>   mm/clear_huge_page: allow arch override for clear_huge_page()
>   mm/huge_page: separate clear_huge_page() and copy_huge_page()
>   mm/huge_page: cleanup clear_/copy_subpage()
>   x86/clear_page: extend clear_page*() for multi-page clearing
>   x86/clear_page: add clear_pages()
>   x86/clear_huge_page: multi-page clearing
>   sched: define TIF_ALLOW_RESCHED
>   irqentry: define irqentry_exit_allow_resched()
>   x86/clear_huge_page: make clear_contig_region() preemptible
> 
>  arch/x86/include/asm/page_64.h     |  27 +++--
>  arch/x86/include/asm/thread_info.h |   2 +
>  arch/x86/lib/clear_page_64.S       |  52 ++++++---
>  arch/x86/mm/hugetlbpage.c          |  59 ++++++++++
>  include/linux/entry-common.h       |  13 +++
>  include/linux/sched.h              |  30 +++++
>  kernel/entry/common.c              |  13 ++-
>  kernel/sched/core.c                |  32 ++---
>  mm/memory.c                        | 181 +++++++++++++++++------------
>  9 files changed, 297 insertions(+), 112 deletions(-)
> 
> -- 
> 2.31.1
> 
> 
