Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA2E7A5AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjISHPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjISHPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:15:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E463419A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:15:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502defbb0c3so8923479e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695107714; x=1695712514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWdryEK98eIB3OwrZ7gXoSG69IfBkDIYZQBa+WiHnls=;
        b=hRtiN/jNY7aLfvhuTcOP3Llm9Wj6N6d7Uh9lpCKfKe5ohHDf/5n847H5vkGrlrRCRY
         zhVIeuko3jm5kjUt8W709PHsW3Ms5Y0xai8VBXor4PSzlCLcc5O7gMNxtPg0O0DZXCt2
         STurbkwvjfu5/2q8TwyneUkHV4ZF4THbEaXsck3Q053xoW55+DhjQVzAIPK1HXCNriTA
         leSS2dxAHN905papzjcPgwLJ4397DQUj8FJKpxTX0S36QxXCnmxZrINEieI8ZQQlOJ0s
         oGn19hBCbZ17AX85ptqvzaxX5qGD6qt4YPZ48Ese4JcgL3+y+Hh2plYnB58YjUZzZDXb
         tmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695107714; x=1695712514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWdryEK98eIB3OwrZ7gXoSG69IfBkDIYZQBa+WiHnls=;
        b=amecEzL/gBxkEZN9OVRy0LHD2lKEZPZNAjsuutRRTgKNzyff3D9IS3vp8PIGlFFF4p
         uaHQtDMIkcSFokLxSLmfiJtOsq9E2K5x0V7iCll2lF1KCYBIeEVdmxRtsHgU/we6ZhwI
         IypzhdAIYlEqC07lecvdnGJbZH/cqwnN5I6401Rn6URAZUmGpwxroen1QMO5CVQUg6me
         JJ9YG+nTxq2YetV+Y/jmTfbs4v+6bH22ftpDY0lOpFpJtAhW3pRIAyecUtjih1v7FKux
         IY6onOf+R/DYECm85e32XQde4s38/XkqyWVQIe0UgL7vhlvGFcXU8Sn9o04wfnJGxPQN
         kqCw==
X-Gm-Message-State: AOJu0YywDAFLtEd5M/I5ITd7Mpcs/V/vbOFPO13szdJPKRkj0N8lHpFB
        S7ATE9QeZQwNUT6A0NCimiCP/Db+1Ec=
X-Google-Smtp-Source: AGHT+IGQBcc/FuyYzkwtcJF2vCH6/U+pm48uZ8fj/45jFexnqaFWVicb2b9cWjpaapwnTKdmbHwFlg==
X-Received: by 2002:ac2:442e:0:b0:503:26bd:7f58 with SMTP id w14-20020ac2442e000000b0050326bd7f58mr1657297lfl.41.1695107713570;
        Tue, 19 Sep 2023 00:15:13 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c2d0700b00404719b05b5sm13863325wmf.27.2023.09.19.00.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 00:15:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 19 Sep 2023 09:15:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RFC PATCH V1 0/6] sched/numa: Enhance disjoint VMA scanning
Message-ID: <ZQlKfgk8Wvcd1Kbr@gmail.com>
References: <cover.1693287931.git.raghavendra.kt@amd.com>
 <719f0729-d28f-d12f-cff4-ab8115861d30@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <719f0729-d28f-d12f-cff4-ab8115861d30@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Raghavendra K T <raghavendra.kt@amd.com> wrote:

> On 8/29/2023 11:36 AM, Raghavendra K T wrote:
> > Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic") [1]
> > VMA scanning is allowed if:
> > 1) The task had accessed the VMA.
> >   Rationale: Reduce overhead for the tasks that had not
> > touched VMA. Also filter out unnecessary scanning.
> > 
> > 2) Early phase of the VMA scan where mm->numa_scan_seq is less than 2.
> >   Rationale: Understanding initial characteristics of VMAs and also
> >   prevent VMA scanning unfairness.
> > 
> > While that works for most of the times to reduce scanning overhead,
> >   there are some corner cases associated with it.
> > 
> > This was found in an internal LKP run and also reported by [2]. There was
> > an attempt to fix.
> > 
> > Link: https://lore.kernel.org/linux-mm/cover.1685506205.git.raghavendra.kt@amd.com/T/
> > 
> > This is a fully different series after Mel's feedback to address the issue
> >   and also a continuation of enhancing VMA scanning for NUMA balancing.
> > 
> > Problem statement (Disjoint VMA set):
> > ======================================
> > Let's look at some of the corner cases with a below example of tasks and their
> > access pattern.
> > 
> > Consider N tasks (threads) of a process.
> > Set1 tasks accessing vma_x (group of VMAs)
> > Set2 tasks accessing vma_y (group of VMAs)
> > 
> >               Set1                      Set2
> >          -------------------         --------------------
> >          | task_1..task_n/2 |       | task_n/2+1..task_n |
> >          -------------------         --------------------	
> >                   |                             |
> >                   V                             V
> >          -------------------         --------------------
> >          |     vma_x       |         |     vma_y         |
> >          -------------------         --------------------	
> > 
> > Corner cases:
> > (a) Out of N tasks, not all of them gets fair opportunity to scan. (PeterZ).
> > suppose Set1 tasks gets more opportunity to scan (May be because of the
> > activity pattern of tasks or other reasons in current design) in the above
> > example, then vma_x gets scanned more number of times than vma_y.
> > 
> > some experiment is also done here which illustrates this unfairness:
> > Link: https://lore.kernel.org/lkml/c730dee0-a711-8a8e-3eb1-1bfdd21e6add@amd.com/
> > 
> > (b) Sizes of vmas can differ.
> > Suppose size of vma_y is far greater than the size of vma_x, then a bigger
> > portion of vma_y can potentially be left unscanned since scanning is bounded
> > by scan_size of 256MB (default) for each iteration.
> > 
> > (c) Highly active threads trap a few VMAs frequently, and some of the VMAs not
> > accessed for long time can potentially get starved of scanning indefinitely
> > (Mel). There is a possibility of lack of enough hints/details about VMAs if it
> > is needed later for migration.
> > 
> > (d) Allocation of memory in some specific manner (Mel).
> > One example could be, Suppose a main thread allocates memory and it is not
> > active. When other threads tries to act upon it, they may not have much
> > hints about it, if the corresponding VMA was not scanned.
> > 
> > (e) VMAs that are created after two full scans of mm (mm->numa_scan_seq > 2)
> > will never get scanned. (Observed rarely but very much possible depending on
> > workload behaviour).
> > 
> > Above this, a combination of some of the above (e.g., (a) and (b)) can
> > potentially amplifyi/worsen the side effect.
> > 
> > This patchset, tries to address the above issues by enhancing unconditional
> > VMA scanning logic.
> > 
> > High level ideas:
> > =================
> > Idea-1) Depending on vma_size, populate a per vma_scan_select value, decrement it
> > and when it hits zero do force scan (Mel).
> > vma_scan_select value is again repopulated when it hits zero.
> > 
> > This is how VMA scanning phases looks like after implementation:
> > 
> > |<---p1--->|<-----p2----->|<-----p2----->|...
> > 
> > Algorithm:
> > p1: New VMA, initial phase do not scan till scan_delay.
> > 
> > p2: Allow scanning if the task has accessed VMA or vma_scan_select hit zero.
> > 
> > Reinitialize vma_scan_select and repeat p2.
> > 
> > pros/cons:
> > +  : Ratelimiting is inbuilt to the approach
> > +  : vma_size is taken into account for scanning
> > +/-: Scanning continues forever
> > -  : Changes in vma size is taken care after force scan. i.e.,
> >     vma_scan_select is repopulated only after vma_scan_select hits zero.
> > 
> > Idea-1 can potentially cover all the issues mentioned above.
> > 
> > Idea-2) Take bitmask_weight of latest access_pids value (suggested by Bharata).
> > If number of tasks accessing vma is >= 1, unconditionally allow scanning.
> > 
> > Idea-3 ) Take bitmask_weight of access_pid history of VMA. If number of tasks
> > accessing VMA is > THRESHOLD (=3), unconditionally allow scanning.
> > 
> > Rationale (Idea-2,3): Do not miss out scanning of critical VMAs.
> > 
> > Idea-4) Have a per vma_scan_seq. allow the unconditional scan till vma_scan_seq
> > reaches a value proportional (or equal) to vma_size/scan_size.
> > This a complimentary to Idea-1.
> > 
> > this is how VMA scanning phases looks like after implementation:
> > 
> > |<--p1--->|<-----p2----->|<-----p3----->|<-----p4----->...||<-----p2----->|<-----p3----->|<-----p4-----> ...||
> >                                                          RESET                                               RESET
> > Algorithm:
> > p1: New VMA, initial phase do not scan till scan_delay.
> > 
> > p2: Allow scanning if task has accessed VMA or vma_scan_seq has reached till
> >   f(vma_size)/scan_size) for e.g., f = 1/2 * vma_size/scan_size.
> > 
> > p3: Allow scanning if task has accessed VMA or vma_scan_seq has reached till
> >   f(vma_size)/scan_size in a rate limited manner. This is an optional phase.
> > 
> > p4: Allow scanning iff task has accessed VMA.
> > 
> > Reset after p4 (optional).
> > 
> > Repeat p2, p3 p4
> > 
> > Motivation: Allow agressive scanning in the beginning followed by a rate
> > limited scanning. And then completely disallow scanning to avoid unnecessary
> > scanning. Reset time could be a function of scan_delay and chosen long enough
> > to aid long running task to forget history and start afresh.
> > 
> > +  : Ratelimiting need to be taken care separately if needed.
> > +/-: Scanning continues only if RESET of vma_scan_seq is implemented.
> > +  : changes in vma size is taken care in every scan.
> > 
> >   Current patch series implements Ideas 1, 2, 3 + extension of access PID history
> > idea from PeterZ.
> > 
> > Results:
> > ======
> > Base: 6.5.0-rc6+ (4853c74bd7ab)
> > SUT: Milan w/ 2 numa nodes 256 cpus
> > 
> > mmtest		numa01_THREAD_ALLOC manual run:
> > 
> > 		base		patched
> > real		1m22.758s	1m9.200s
> > user		249m49.540s	229m30.039s
> > sys		0m25.040s	3m10.451s
> > 	
> > numa_pte_updates 	6985	1573363
> > numa_hint_faults 	2705	1022623
> > numa_hint_faults_local 	2279	389633
> > numa_pages_migrated 	426	632990
> > 
> > kernbench
> > 			base			patched
> > Amean     user-256    21989.09 (   0.00%)    21677.36 *   1.42%*
> > Amean     syst-256    10171.34 (   0.00%)    10818.28 *  -6.36%*
> > Amean     elsp-256      166.81 (   0.00%)      168.40 *  -0.95%*
> > 
> > Duration User       65973.18    65038.00
> > Duration System     30538.92    32478.59
> > Duration Elapsed      529.52      533.09
> > 
> > Ops NUMA PTE updates                  976844.00      962680.00
> > Ops NUMA hint faults                  226763.00      245620.00
> > Ops NUMA pages migrated               220146.00      207025.00
> > Ops AutoNUMA cost                       1144.84        1238.77
> > 
> > Improvements in other benchmarks I have tested.
> > Time based:
> > Hashjoin	4.21%
> > Btree	 	2.04%
> > XSbench		0.36%
> > 
> > Throughput based:
> > Graph500 	-3.62%
> > Nas.bt		3.69%
> > Nas.ft		21.91%
> > 
> > Note: VMA scanning improvements [1] has refined scanning so much that
> > system overhead we re-introduce with additional scan look glaringly
> > high. But If we consider the difference between before [1] and current
> > series, overall scanning overhead is considerably reduced.
> > 
> > 1. Link: https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
> > 2. Link: https://lore.kernel.org/lkml/cover.1683033105.git.raghavendra.kt@amd.com/
> > 
> > Note: Patch description is again repeated in some patches to avoid any
> > need to copy from cover letter again.
> > 
> > Peter Zijlstra (1):
> >    sched/numa: Increase tasks' access history
> > 
> > Raghavendra K T (5):
> >    sched/numa: Move up the access pid reset logic
> >    sched/numa: Add disjoint vma unconditional scan logic
> >    sched/numa: Remove unconditional scan logic using mm numa_scan_seq
> >    sched/numa: Allow recently accessed VMAs to be scanned
> >    sched/numa: Allow scanning of shared VMAs
> > 
> >   include/linux/mm.h       |  12 +++--
> >   include/linux/mm_types.h |   5 +-
> >   kernel/sched/fair.c      | 109 ++++++++++++++++++++++++++++++++-------
> >   3 files changed, 102 insertions(+), 24 deletions(-)
> > 
> 
> Hello Andrew,
> 
> I am Resending patch rebasing to mm-unstable, adding results from Oliver
> and Swapnil.

Just for the record, a final version of this series should be submitted via 
the scheduler tree, not -mm.

Thanks,

	Ingo
