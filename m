Return-Path: <linux-kernel+bounces-19673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F3A8270AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEA61F226D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D544C46538;
	Mon,  8 Jan 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEmvGEKC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5746531
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so1546579a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704722830; x=1705327630; darn=vger.kernel.org;
        h=content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=J4Z19zGQtolnXAzznbpSkcsThN34C4x1v4SKOLbXW3M=;
        b=iEmvGEKCR75HHhqLQDWqa8Ut/AuCxNMicowV0XSchMnhS4qkxTEo42C4lhJAjAPjCM
         8SC6kMQu3ooK2RnAu23qK9N6XGS1fIqNFftZpfXxPu5tVtvCu3Z/Lpm4qJaOVj0fa6Dd
         H3xruWOzylZDGO2pzXZYgKZFBK21EaRPU152DpvQjU9xFPVyCZ0yNR/NOwtU5aXDUCUu
         BtMf7C4gdlC7Fy1COS4EY3FpPYRki6umKebHfYNJvvqo90BCc0uqaRLuLWLXXrh+0iQq
         x7Y3jO6mcoy8mj8WMQllCVQJuvoj8fpmeQd6lLMwxKIyldb1Tx23T6izHXX+0HnCBkF8
         f/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704722830; x=1705327630;
        h=content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4Z19zGQtolnXAzznbpSkcsThN34C4x1v4SKOLbXW3M=;
        b=BG0LIsVhlcBuRIV8woRyqsidpXx9fYaFUI3G+w36QnAiFuBdDHOpsiRFN7bp/nkWvi
         wjFIakmlCpyKb0nbJzCy5Ipp6+pnGtHW5NuB5opOmCq9VXwK35CKN+HSIO+U4Yp6YNj8
         17xDSNpxDblfJWwafI/kh4oUce0rDUFxPAdXZJ2izE1cMoMgJ0pVeEcJY7o1R4zAttON
         mFQ7tNsAaVJN5MTlbZysYJFTmOQXtSpFyuivxVY61CG3ACRw6O/2iLzNtPtjzf9sxeXi
         VZiXGQZ6FthBJ2MNidqFE6+sa8UkFTGsP4kxLdXEbleym75ce/vFh7rch5lytME0f+M1
         4Hgg==
X-Gm-Message-State: AOJu0YzRo+iKmunNK1qUZDTzyYmTU92aVckwJ5KmolmTY0m+srYximQg
	N76X0DO348xOiaDe6F657Ek=
X-Google-Smtp-Source: AGHT+IERafY5pjPyT+iOkqBOWGxJHr0j2xjDWEOWENrlFhPyJhFJFqbrvoBXDL1MhvFrcKnrqjx8dA==
X-Received: by 2002:a05:6402:646:b0:557:3c7a:4000 with SMTP id u6-20020a056402064600b005573c7a4000mr1916741edx.20.1704722829491;
        Mon, 08 Jan 2024 06:07:09 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id fd5-20020a056402388500b0055743d6e9ebsm3386605edb.41.2024.01.08.06.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:07:09 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 15:07:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] Scheduler changes for v6.8
Message-ID: <ZZwBi/YmnMqm7zrO@gmail.com>
References: <ZTz9RpZxfxysYCmt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-01-08

   # HEAD: cdb3033e191fd03da2d7da23b9cd448dfa180a8e Merge branch 'sched/urgent' into sched/core, to pick up pending v6.7 fixes for the v6.8 merge window

Scheduler changes for v6.8:

 - Energy scheduling:

    - Consolidate how the max compute capacity is
      used in the scheduler and how we calculate
      the frequency for a level of utilization.

    - Rework interface between the scheduler and
      the schedutil governor

    - Simplify the util_est logic

 - Deadline scheduler:

    - Work more towards reducing SCHED_DEADLINE
      starvation of low priority tasks (e.g., SCHED_OTHER)
      tasks when higher priority tasks monopolize CPU
      cycles, via the introduction of 'deadline servers'
      (nested/2-level scheduling).
      "Fair servers" to make use of this facility are
      not introduced yet.

 - EEVDF:

    - Introduce O(1) fastpath for EEVDF task selection

 - NUMA balancing:

    - Tune the NUMA-balancing vma scanning logic some more,
      to better distribute the probability
      of a particular vma getting scanned.

 - Plus misc fixes, cleanups and updates.

 Thanks,

	Ingo

------------------>
Abel Wu (2):
      sched/eevdf: Sort the rbtree by virtual deadline
      sched/eevdf: O(1) fastpath for task selection

Elliot Berman (1):
      freezer,sched: Clean saved_state when restoring it during thaw

Frederic Weisbecker (2):
      sched/cpuidle: Comment about timers requirements VS idle handler
      sched/timers: Explain why idle task schedules out on remote timer enqueue

Paul E. McKenney (1):
      sched: Use WRITE_ONCE() for p->on_rq

Peter Zijlstra (6):
      sched: Unify runtime accounting across classes
      sched: Remove vruntime from trace_sched_stat_runtime()
      sched: Unify more update_curr*()
      sched/deadline: Collect sched_dl_entity initialization
      sched/deadline: Move bandwidth accounting into {en,de}queue_dl_entity
      sched/deadline: Introduce deadline servers

Pierre Gondois (1):
      sched/fair: Use all little CPUs for CPU-bound workloads

Raghavendra K T (1):
      sched/numa: Fix mm numa_scan_seq based unconditional scan

Vincent Guittot (13):
      sched/pelt: Avoid underestimation of task utilization
      sched/cpufreq: Rework schedutil governor performance estimation
      sched/cpufreq: Rework iowait boost
      sched/topology: Add a new arch_scale_freq_ref() method
      cpufreq: Use the fixed and coherent frequency for scaling capacity
      cpufreq/schedutil: Use a fixed reference frequency
      energy_model: Use a fixed reference frequency
      cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}()
      cpufreq/cppc: Set the frequency used for computing the capacity
      arm64/amu: Use capacity_ref_freq() to set AMU ratio
      sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)
      sched/fair: Simplify util_est
      sched/fair: Fix tg->load when offlining a CPU

Wang Jinchao (1):
      sched/fair: Remove unused 'next_buddy_marked' local variable in check_preempt_wakeup_fair()

Wenyu Huang (1):
      sched/doc: Update documentation after renames and synchronize Chinese version

Yiwei Lin (1):
      sched/fair: Update min_vruntime for reweight_entity() correctly


 Documentation/scheduler/sched-design-CFS.rst       |   8 +-
 Documentation/scheduler/schedutil.rst              |   7 +-
 .../zh_CN/scheduler/sched-design-CFS.rst           |   8 +-
 .../translations/zh_CN/scheduler/schedutil.rst     |   7 +-
 arch/arm/include/asm/topology.h                    |   1 +
 arch/arm64/include/asm/topology.h                  |   1 +
 arch/arm64/kernel/topology.c                       |  26 +-
 arch/riscv/include/asm/topology.h                  |   1 +
 drivers/acpi/cppc_acpi.c                           | 104 +++++
 drivers/base/arch_topology.c                       |  56 ++-
 drivers/cpufreq/cppc_cpufreq.c                     | 139 +-----
 drivers/cpufreq/cpufreq.c                          |   4 +-
 include/acpi/cppc_acpi.h                           |   2 +
 include/linux/arch_topology.h                      |   8 +
 include/linux/cpufreq.h                            |   1 +
 include/linux/energy_model.h                       |   7 +-
 include/linux/mm_types.h                           |   3 +
 include/linux/sched.h                              |  75 ++--
 include/linux/sched/topology.h                     |   8 +
 include/trace/events/sched.h                       |  15 +-
 kernel/freezer.c                                   |   1 +
 kernel/sched/core.c                                | 140 +++---
 kernel/sched/cpufreq_schedutil.c                   |  90 ++--
 kernel/sched/deadline.c                            | 477 +++++++++++++--------
 kernel/sched/debug.c                               |  18 +-
 kernel/sched/fair.c                                | 449 ++++++++++---------
 kernel/sched/features.h                            |   1 -
 kernel/sched/idle.c                                |  30 ++
 kernel/sched/pelt.h                                |   4 +-
 kernel/sched/rt.c                                  |  15 +-
 kernel/sched/sched.h                               | 135 ++----
 kernel/sched/stop_task.c                           |  13 +-
 32 files changed, 1054 insertions(+), 800 deletions(-)

