Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E277DA6EB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 14:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjJ1MXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 08:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJ1MXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 08:23:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201A8107
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 05:23:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-540105dea92so4435028a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698495817; x=1699100617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsmHn82DZjXxlEqmxDIeX8dVnbW1OtQR5syHK6U1RYM=;
        b=ANo90yj6LoH1qhUEoHbx4t9XvoHvj0lgrjcBy+voC8IdP9qnG0UrJV7mlN4ItOhydK
         g8wXTGoK25G0OXQP+CTvA3AaGhUWaqxSOO2n3kcAhs+6oWHc705nHyLJC6o10a77k9CL
         bgNriyQhqGl4ptwbIL94DL7epOPE6OBmEGx6kSAOjKni4qxNVvtcjKE4E+8oFVW7B7Sv
         p0lxiP0a4yuJffMQP8oqmcQsxl+ATUiOfXrnbI1XE0PCSp2LAFCSHWrGCdY7uGWdTbmm
         tavgKr9e7xEpKD130G6n/Y8GorV3TxYykbRcRQDSBA/JLz5CyLOBTkrZO0xLLjxq5jtS
         Uzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698495817; x=1699100617;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wsmHn82DZjXxlEqmxDIeX8dVnbW1OtQR5syHK6U1RYM=;
        b=l83Dmg5hq4Sjzp/yRDkiIvmVjhHgri8Vco71S3SHuAxbJ0gmqbXXh338H/QK7b6qQu
         lGa7OWYpP5zPEyS2Sy7l2KZZKwHiJaWZRM3CBsI+FVPZpeu3oL/v+i4UctV2A9BkMU74
         wr/G80kONLV/harPPPT02uz9MrQ+4ywRZXP+wnDYldHqSALEP9oqmgF4p/y6IcHj4kmk
         4Hoaj61Xp2uz5kaLCe7kLkV6OJBiaEaEGQU1lkO56xGVbKvMMLsNjcOnDWctywaKhnHv
         w4ktS1u/9lr5g2QdZt33WRkcUoc1ig8Oc+4O4SZ6kvl2PXo2cVPiVbtMiYaI0QOv51FR
         w5DA==
X-Gm-Message-State: AOJu0YyaI7B9i7yDx2eamAWlpjoGwDa1ljNukWZSlwvLz0hot7gRRNZD
        Am/rszVqMRN38QUKEz9aySA=
X-Google-Smtp-Source: AGHT+IHARYNOKYvevLus8+zdnmDZgKaY/5WaA8ApUZF1dwTahJRGk4oMFHCzv2ZWD3uigCz167rMdw==
X-Received: by 2002:a50:9fe2:0:b0:542:da34:cb7c with SMTP id c89-20020a509fe2000000b00542da34cb7cmr1012206edf.19.1698495817276;
        Sat, 28 Oct 2023 05:23:37 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906050b00b009a193a5acffsm2689376eja.121.2023.10.28.05.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 05:23:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 14:23:34 +0200
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
Subject: [GIT PULL] Scheduler changes for v6.7
Message-ID: <ZTz9RpZxfxysYCmt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-10-28

   # HEAD: 984ffb6a4366752c949f7b39640aecdce222607f sched/fair: Remove SIS_PROP

Scheduler changes for v6.7 are:

 - Fair scheduler (SCHED_OTHER) improvements:

    - Remove the old and now unused SIS_PROP code & option
    - Scan cluster before LLC in the wake-up path
    - Use candidate prev/recent_used CPU if scanning failed for cluster wakeup

 - NUMA scheduling improvements:

    - Improve the VMA access-PID code to better skip/scan VMAs
    - Extend tracing to cover VMA-skipping decisions
    - Improve/fix the recently introduced sched_numa_find_nth_cpu() code
    - Generalize numa_map_to_online_node()

 - Energy scheduling improvements:

    - Remove the EM_MAX_COMPLEXITY limit
    - Add tracepoints to track energy computation
    - Make the behavior of the 'sched_energy_aware' sysctl more consistent
    - Consolidate and clean up access to a CPU's max compute capacity
    - Fix uclamp code corner cases

 - RT scheduling improvements:

    - Drive dl_rq->overloaded with dl_rq->pushable_dl_tasks updates
    - Drive the ->rto_mask with rt_rq->pushable_tasks updates

 - Scheduler scalability improvements:

    - Rate-limit updates to tg->load_avg
    - On x86 disable IBRS when CPU is offline to improve single-threaded performance
    - Micro-optimize in_task() and in_interrupt()
    - Micro-optimize the PSI code
    - Avoid updating PSI triggers and ->rtpoll_total when there are no state changes

 - Core scheduler infrastructure improvements:

    - Use saved_state to reduce some spurious freezer wakeups
    - Bring in a handful of fast-headers improvements to scheduler headers
    - Make the scheduler UAPI headers more widely usable by user-space
    - Simplify the control flow of scheduler syscalls by using lock guards
    - Fix sched_setaffinity() vs. CPU hotplug race

 - Scheduler debuggability improvements:
    - Disallow writing invalid values to sched_rt_period_us
    - Fix a race in the rq-clock debugging code triggering warnings
    - Fix a warning in the bandwidth distribution code
    - Micro-optimize in_atomic_preempt_off() checks
    - Enforce that the tasklist_lock is held in for_each_thread()
    - Print the TGID in sched_show_task()
    - Remove the /proc/sys/kernel/sched_child_runs_first sysctl

 - Misc cleanups & fixes

 Thanks,

	Ingo

------------------>
Aaron Lu (1):
      sched/fair: Ratelimit update to tg->load_avg

Barry Song (2):
      sched: Add cpus_share_resources API
      sched/fair: Scan cluster before scanning LLC in wake-up path

Chengming Zhou (1):
      sched/fair: Fix cfs_rq_is_decayed() on !SMP

Colin Ian King (1):
      sched/headers: Remove comment referring to rq::cpu_load, since this has been removed

Cyril Hrubis (3):
      sched/rt: Disallow writing invalid values to sched_rt_period_us
      sched/rt/docs: Clarify & fix sched_rt_* sysctl docs
      sched/rt/docs: Use 'real-time' instead of 'realtime'

Elliot Berman (2):
      sched/core: Remove ifdeffery for saved_state
      freezer,sched: Use saved_state to reduce some spurious wakeups

Fan Yu (1):
      sched/psi: Update poll => rtpoll in relevant comments

Finn Thain (1):
      sched/core: Optimize in_task() and in_interrupt() a bit

GUO Zihua (1):
      sched/headers: Remove duplicated includes in kernel/sched/sched.h

Haifeng Xu (1):
      sched/psi: Bail out early from irq time accounting

Hao Jia (1):
      sched/core: Fix RQCF_ACT_SKIP leak

Ingo Molnar (12):
      sched/fair: Rename check_preempt_wakeup() to check_preempt_wakeup_fair()
      sched/fair: Rename check_preempt_curr() to wakeup_preempt()
      sched/headers: Add header guard to <linux/sched/deadline.h>
      sched/headers: Standardize the <linux/sched/vhost_task.h> header guard name
      sched/headers: Standardize the <linux/sched/type.h> header guard #endif
      sched/headers: Standardize the <linux/sched/smt.h> header guard #endif
      <linux/list.h>: Introduce the list_for_each_reverse() method
      sched/core: Update stale comment in try_to_wake_up()
      sched/nohz: Update idle load-balancing (ILB) comments
      sched/nohz: Use consistent variable names in find_new_ilb() and kick_ilb()
      sched/nohz: Remove unnecessarily complex error handling pattern from find_new_ilb()
      sched/topology: Move the declaration of 'schedutil_gov' to kernel/sched/sched.h

Jiapeng Chong (1):
      sched/fair: Remove duplicate #include

Joel Fernandes (Google) (1):
      sched/nohz: Update comments about NEWILB_KICK

Josh Don (2):
      sched/fair: Make cfs_rq->throttled_csd_list available on !SMP
      sched/fair: Fix warning in bandwidth distribution

Kir Kolyshkin (1):
      sched/headers: Move 'struct sched_param' out of uapi, to work around glibc/musl breakage

Liming Wu (1):
      sched/debug: Avoid checking in_atomic_preempt_off() twice in schedule_debug()

Mathieu Desnoyers (1):
      sched: Make PELT acronym definition searchable

Matthew Wilcox (Oracle) (1):
      sched: Assert for_each_thread() is properly locked

Mel Gorman (5):
      sched/numa: Document vma_numab_state fields
      sched/numa: Rename vma_numab_state::access_pids[] => ::pids_active[], ::next_pid_reset => ::pids_active_reset
      sched/numa: Trace decisions related to skipping VMAs
      sched/numa: Complete scanning of partial VMAs regardless of PID activity
      sched/numa: Complete scanning of inactive VMAs when there is no alternative

Peter Zijlstra (11):
      sched: Simplify set_user_nice()
      sched: Simplify syscalls
      sched: Simplify sched_{set,get}affinity()
      sched: Simplify yield_to()
      sched: Simplify sched_rr_get_interval()
      sched: Simplify sched_move_task()
      sched: Simplify tg_set_cfs_bandwidth()
      sched: Misc cleanups
      sched/topology: Rename 'DIE' domain to 'PKG'
      sched: Fix stop_one_cpu_nowait() vs hotplug
      sched/fair: Remove SIS_PROP

Pierre Gondois (1):
      sched/topology: Remove the EM_MAX_COMPLEXITY limit

Qais Yousef (3):
      sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
      sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0
      sched/debug: Add new tracepoint to track compute energy computation

Raghavendra K T (1):
      sched/numa: Move up the access pid reset logic

Sebastian Andrzej Siewior (2):
      sched/debug: Remove the /proc/sys/kernel/sched_child_runs_first sysctl
      sched/debug: Update stale reference to sched_debug.c

Shrikanth Hegde (1):
      sched/topology: Change behaviour of the 'sched_energy_aware' sysctl, based on the platform

Uros Bizjak (1):
      sched/core: Use do-while instead of for loop in set_nr_if_polling()

Valentin Schneider (2):
      sched/rt: Make rt_rq->pushable_tasks updates drive rto_mask
      sched/deadline: Make dl_rq->pushable_dl_tasks update drive dl_rq->overloaded

Vincent Guittot (1):
      sched/topology: Consolidate and clean up access to a CPU's max compute capacity

Waiman Long (4):
      x86/speculation: Add __update_spec_ctrl() helper
      x86/idle: Disable IBRS when CPU is offline to improve single-threaded performance
      intel_idle: Use __update_spec_ctrl() in intel_idle_ibrs()
      intel_idle: Add ibrs_off module parameter to force-disable IBRS

Wang Jinchao (1):
      sched/core: Refactor the task_flags check for worker sleeping in sched_submit_work()

Yajun Deng (2):
      sched/debug: Print 'tgid' in sched_show_task()
      sched/rt: Change the type of 'sysctl_sched_rt_period' from 'unsigned int' to 'int'

Yang Yang (3):
      sched/psi: Change update_triggers() to a 'void' function
      sched/psi: Avoid updating PSI triggers and ->rtpoll_total when there are no state changes
      sched/psi: Delete the 'update_total' function parameter from update_triggers()

Yicong Yang (1):
      sched/fair: Use candidate prev/recent_used CPU if scanning failed for cluster wakeup

Yiwei Lin (1):
      sched/fair: Remove unused 'curr' argument from pick_next_entity()

Yu Liao (1):
      sched/headers: Remove duplicate header inclusions

Yury Norov (6):
      numa: Generalize numa_map_to_online_node()
      sched/fair: Fix open-coded numa_nearest_node()
      sched/topology: Fix sched_numa_find_nth_cpu() in CPU-less case
      sched/topology: Fix sched_numa_find_nth_cpu() in non-NUMA case
      sched/topology: Handle NUMA_NO_NODE in sched_numa_find_nth_cpu()
      sched/topology: Fix sched_numa_find_nth_cpu() comment


 Documentation/admin-guide/pm/intel_idle.rst |  17 +-
 Documentation/admin-guide/sysctl/kernel.rst |   3 +-
 Documentation/scheduler/sched-capacity.rst  |  13 +-
 Documentation/scheduler/sched-energy.rst    |  29 +-
 Documentation/scheduler/sched-rt-group.rst  |  40 +-
 arch/powerpc/kernel/smp.c                   |   4 +-
 arch/s390/kernel/topology.c                 |   2 +-
 arch/x86/include/asm/spec-ctrl.h            |  11 +
 arch/x86/kernel/smpboot.c                   |  12 +-
 drivers/idle/intel_idle.c                   |  18 +-
 include/linux/cpu.h                         |   2 +
 include/linux/list.h                        |   8 +
 include/linux/mm.h                          |   4 +-
 include/linux/mm_types.h                    |  31 +-
 include/linux/numa.h                        |   7 +-
 include/linux/preempt.h                     |  15 +-
 include/linux/sched.h                       |   7 +-
 include/linux/sched/deadline.h              |   4 +
 include/linux/sched/numa_balancing.h        |  10 +
 include/linux/sched/sd_flags.h              |   7 +
 include/linux/sched/signal.h                |   3 +-
 include/linux/sched/smt.h                   |   2 +-
 include/linux/sched/topology.h              |  10 +-
 include/linux/sched/types.h                 |   2 +-
 include/linux/sched/vhost_task.h            |   7 +-
 include/linux/topology.h                    |   2 +-
 include/trace/events/sched.h                |  57 +++
 include/uapi/linux/sched/types.h            |   4 -
 kernel/freezer.c                            |  41 +-
 kernel/sched/build_utility.c                |   1 -
 kernel/sched/core.c                         | 651 ++++++++++++----------------
 kernel/sched/cpudeadline.c                  |   2 +-
 kernel/sched/deadline.c                     |  73 +---
 kernel/sched/debug.c                        |   7 +-
 kernel/sched/fair.c                         | 432 ++++++++++--------
 kernel/sched/features.h                     |   1 -
 kernel/sched/idle.c                         |   4 +-
 kernel/sched/pelt.c                         |   2 +-
 kernel/sched/psi.c                          |  58 ++-
 kernel/sched/rt.c                           |  95 ++--
 kernel/sched/sched.h                        |  45 +-
 kernel/sched/stop_task.c                    |   4 +-
 kernel/sched/topology.c                     | 213 +++++----
 lib/cpumask.c                               |   4 +-
 mm/mempolicy.c                              |  18 +-
 45 files changed, 1015 insertions(+), 967 deletions(-)
