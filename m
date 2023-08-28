Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBDA78B9FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjH1VMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjH1VLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:11:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F9513E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:11:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-317c3ac7339so3041410f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693257091; x=1693861891;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AGV7fm9BOo/BTZfQQDSKq6tain38HNOfDc/SVkbBLyU=;
        b=Ha8e4FOatxVIoLwNAY2swsz6p5CXDyjw4NNd2r4N5yQVuPxl9W9MOtU2qssA/aEtX2
         Sg7j0X3int2h0523Jsn3ofVtt74Y8wQ1M0QWIqC4E1uX6Dia0S8Ng/+oa9146ILN+rM8
         /O0e1r64sH1O4NTb1LEmfokxY+j1P9j4173QR5U3ZAyT3UPN5TzOBoywEnLDSxHSfuNn
         9rOwvAW2AiX7494u4Ifif3IwtVpg34Jt+6XMk+0sa0NSEdLUyzuodpBG2WQpWvZlN2MI
         C0HQEDarorTQ2I4MH1Qg6+I55hXwnnTwhJCdCXkbt8jfhrP/QAJkjuUQ9GBWhiIhrEdQ
         7RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693257091; x=1693861891;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGV7fm9BOo/BTZfQQDSKq6tain38HNOfDc/SVkbBLyU=;
        b=AnrbEJDznvQblUv5GWp74Oav5XPqFtXwH547gvDecWEGv6Hd88eP1vUM7sQhAuJ41L
         iGcWXi//mWYNp4iGyXJL3TXk7QRq39p5EQ9kHGxE1ArYAT90XqgbB7SXzZLcxs2NE2ox
         12rJ6BgasLxoLoo47TkSU/6gDlfQsg2/H6AiSBd8zRmaac1XI8AJ1LnQ5oiIVJOvCB6W
         D3RN2xxJF7jRTwqA58xkjeAhDod1AzESFf/GSFqyo6DySrUBQrMLZAmn5f6NR7gOquK4
         6X0K0RzZ+8VHfLEN0FIkwWVQJ44dvxYKqRmlIxKStIEJGeC66qqu9hAZu0XPKpiiSirM
         XC9w==
X-Gm-Message-State: AOJu0Yx6ODPTeVz+lP+OvYB6lH0IrKar5EfnUKSI5qRXp1pVLGSLK1ya
        0TrK5sk+TvlML/qoqj7Me0c=
X-Google-Smtp-Source: AGHT+IFPY7IxPmJiniTef/KLV+7hwXWgICNAQvq9yKq/rwhFkIjoaFsmvdxHF+VyjgM5yhQIn1XADw==
X-Received: by 2002:a5d:4911:0:b0:314:1f6:2c24 with SMTP id x17-20020a5d4911000000b0031401f62c24mr19759626wrq.36.1693257090621;
        Mon, 28 Aug 2023 14:11:30 -0700 (PDT)
Received: from gmail.com (1F2EF3C0.nat.pool.telekom.hu. [31.46.243.192])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d6144000000b00316eb7770b8sm11724647wrt.5.2023.08.28.14.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 14:11:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Aug 2023 23:11:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] Scheduler changes for v6.6
Message-ID: <ZO0NgNfvvS9oVUVW@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-08-28

   # HEAD: 2f88c8e802c8b128a155976631f4eb2ce4f3c805 sched/eevdf/doc: Modify the documented knob to base_slice_ns as well

Scheduler changes for v6.6:

- The biggest change is introduction of a new iteration of the
  SCHED_FAIR interactivity code: the EEVDF ("Earliest Eligible Virtual
  Deadline First") scheduler.

  EEVDF too is a virtual-time scheduler, with two parameters (weight
  and relative deadline), compared to CFS that had weight only.
  It completely reworks the base scheduler: placement, preemption,
  picking -- everything.

  LWN.net, as usual, has a terrific writeup about EEVDF:

     https://lwn.net/Articles/925371/

  Preemption (both tick and wakeup) is driven by testing against
  a fresh pick. Because the tree is now effectively an interval
  tree, and the selection is no longer the 'leftmost' task,
  over-scheduling is less of a problem. A lot of the CFS
  heuristics are removed or replaced by more natural latency-space
  parameters & constructs.

  In terms of expected performance regressions: we'll and can fix
  everything where a 'good' workload misbehaves with the new scheduler,
  but EEVDF inevitably changes workload scheduling in a binary fashion,
  hopefully for the better in the overwhelming majority of cases,
  but in some cases it won't, especially in adversarial loads that
  got lucky with the previous code, such as some variants of hackbench.
  We are trying hard to err on the side of fixing all performance
  regressions, but we expect some inevitable post-release iterations
  of that process.

- Improve load-balancing on hybrid x86 systems: enable cluster
  scheduling (again).

- Improve & fix bandwidth-scheduling on nohz systems.

- Improve bandwidth-throttling.

- Use lock guards to simplify and de-goto-ify control flow.

- Misc improvements, cleanups and fixes.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Chen Yu (1):
      sched/topology: Align group flags when removing degenerate domain

Chin Yik Ming (1):
      sched/headers: Rename task_struct::state to task_struct::__state in the comments too

Cruz Zhao (1):
      sched/core: introduce sched_core_idle_cpu()

Cyril Hrubis (2):
      sched/rt: Fix sysctl_sched_rr_timeslice intial value
      sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset

Johannes Weiner (1):
      MAINTAINERS: Add Peter explicitly to the psi section

Josh Don (2):
      sched: don't account throttle time for empty groups
      sched: add throttled time stat for throttled children

Miaohe Lin (1):
      sched/psi: make psi_cgroups_enabled static

Peter Zijlstra (22):
      x86/sched: Enable cluster scheduling on Hybrid
      sched/debug: Dump domains' sched group flags
      sched/fair: Add cfs_rq::avg_vruntime
      sched/fair: Remove sched_feat(START_DEBIT)
      sched/fair: Add lag based placement
      rbtree: Add rb_add_augmented_cached() helper
      sched/fair: Implement an EEVDF-like scheduling policy
      sched/fair: Commit to lag based placement
      sched/smp: Use lag to simplify cross-runqueue placement
      sched/fair: Commit to EEVDF
      sched/debug: Rename sysctl_sched_min_granularity to sysctl_sched_base_slice
      sched/fair: Propagate enqueue flags into place_entity()
      sched: Simplify get_nohz_timer_target()
      sched: Simplify sysctl_sched_uclamp_handler()
      sched: Simplify: migrate_swap_stop()
      sched: Simplify wake_up_if_idle()
      sched: Simplify ttwu()
      sched: Simplify sched_exec()
      sched: Simplify sched_tick_remote()
      sched: Simplify try_steal_cookie()
      sched: Simplify sched_core_cpu_{starting,deactivate}()
      sched/eevdf: Curb wakeup-preemption

Phil Auld (2):
      sched, cgroup: Restore meaning to hierarchical_quota
      sched/fair: Block nohz tick_stop when cfs bandwidth in use

Randy Dunlap (1):
      sched/psi: Select KERNFS as needed

Ricardo Neri (1):
      sched/fair: Consider the idle state of the whole core for load balance

Shrikanth Hegde (1):
      sched/eevdf/doc: Modify the documented knob to base_slice_ns as well

Tim C Chen (3):
      sched/fair: Determine active load balance for SMT sched groups
      sched/topology: Record number of cores in sched group
      sched/fair: Implement prefer sibling imbalance calculation between asymmetric groups

Vincent Guittot (2):
      sched/fair: Stabilize asym cpu capacity system idle cpu selection
      sched/fair: remove util_est boosting

Wander Lairson Costa (2):
      kernel/fork: beware of __put_task_struct() calling context
      sched: avoid false lockdep splat in put_task_struct()


 Documentation/scheduler/sched-design-CFS.rst |    2 +-
 MAINTAINERS                                  |    1 +
 arch/x86/kernel/smpboot.c                    |   11 +-
 include/linux/cgroup-defs.h                  |    2 +
 include/linux/rbtree_augmented.h             |   26 +
 include/linux/sched.h                        |   21 +-
 include/linux/sched/task.h                   |   38 +-
 init/Kconfig                                 |    1 +
 kernel/cgroup/cgroup.c                       |   34 +
 kernel/fork.c                                |    8 +
 kernel/sched/core.c                          |  496 +++++-----
 kernel/sched/debug.c                         |   49 +-
 kernel/sched/fair.c                          | 1333 ++++++++++++++------------
 kernel/sched/features.h                      |   24 +-
 kernel/sched/psi.c                           |    2 +-
 kernel/sched/rt.c                            |    5 +-
 kernel/sched/sched.h                         |   57 +-
 kernel/sched/topology.c                      |   15 +-
 kernel/softirq.c                             |    2 +-
 19 files changed, 1217 insertions(+), 910 deletions(-)
