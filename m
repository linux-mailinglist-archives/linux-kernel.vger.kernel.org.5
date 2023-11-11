Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0367E8B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 14:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjKKNdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 08:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKKNdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 08:33:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30403862
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 05:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699709591; x=1731245591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/LCakEuB0Rfh/bNDksXQcLdkDB04TgxPXel4oM8RTZQ=;
  b=dzzfLMWkIGSNt5OEFO4YPPzZdo7wrq4dovZFknHQ6CHTXfUH8YIbAW6B
   xfpn5KA966XtCcQt+I8i4Bw28R3+CAiScGgEFksv5UGcDsUIP3/hcb/GJ
   yfxlmOBumKnw//zR3Kn/razudoQNT+jiBuYajyLznIdfVd3hVF6p5c9qg
   4jKjkQQLt7ZFtLCC1ERFp2wR/hBmxIBLOeY7oBjw2oPjzj4qjp/BIfA5b
   z2UOb2tKoJrJhsU2HoZNh+JEDxc8zdrwlXjNciwAt8wQuQw/twVGM4LGZ
   yb85qT+Z6u25jHTTS1R/xKdWG3QgkWkHGE61Q971Afn36q6A4LISWXx2G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476501708"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="476501708"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 05:33:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="5275004"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2023 05:33:06 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1o6h-000ATh-2d;
        Sat, 11 Nov 2023 13:33:03 +0000
Date:   Sat, 11 Nov 2023 21:32:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH v6 14/20] sched: Add a very simple proxy() function
Message-ID: <202311112119.WREdJHjx-lkp@intel.com>
References: <20231106193524.866104-15-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106193524.866104-15-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on v6.6]
[cannot apply to tip/sched/core tip/master linus/master tip/auto-latest next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/sched-Unify-runtime-accounting-across-classes/20231107-033946
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20231106193524.866104-15-jstultz%40google.com
patch subject: [PATCH v6 14/20] sched: Add a very simple proxy() function
config: x86_64-randconfig-121-20231111 (https://download.01.org/0day-ci/archive/20231111/202311112119.WREdJHjx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311112119.WREdJHjx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311112119.WREdJHjx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/core.c:756:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:756:31: sparse:     expected struct task_struct *task
   kernel/sched/core.c:756:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:757:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:757:25: sparse:     expected struct task_struct *task
   kernel/sched/core.c:757:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1074:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1074:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1074:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2254:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2254:36: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:2254:36: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2265:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2265:64: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2265:64: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5687:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5687:14: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5687:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6732:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6732:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6732:14: sparse:     got struct task_struct [noderef] __rcu *curr
>> kernel/sched/core.c:6778:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6778:35: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6778:35: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:7281:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7281:17: sparse:    struct task_struct *
   kernel/sched/core.c:7281:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7497:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7497:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7497:22: sparse:    struct task_struct *
   kernel/sched/core.c:11696:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11696:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11696:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:582:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/core.c:607:6: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:631:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c:669:36: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/core.c:710:36: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2155:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2155:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2155:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2155:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2155:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2155:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2155:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2155:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2155:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2166:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct *
   kernel/sched/sched.h:2344:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2344:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2166:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct *
   kernel/sched/sched.h:2344:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2166:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct *
   kernel/sched/sched.h:2344:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2166:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct *
   kernel/sched/sched.h:2344:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2155:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2155:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2155:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2166:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2166:32: sparse:    struct task_struct *
   kernel/sched/sched.h:2344:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct *

vim +6778 kernel/sched/core.c

  6681	
  6682	/*
  6683	 * __schedule() is the main scheduler function.
  6684	 *
  6685	 * The main means of driving the scheduler and thus entering this function are:
  6686	 *
  6687	 *   1. Explicit blocking: mutex, semaphore, waitqueue, etc.
  6688	 *
  6689	 *   2. TIF_NEED_RESCHED flag is checked on interrupt and userspace return
  6690	 *      paths. For example, see arch/x86/entry_64.S.
  6691	 *
  6692	 *      To drive preemption between tasks, the scheduler sets the flag in timer
  6693	 *      interrupt handler scheduler_tick().
  6694	 *
  6695	 *   3. Wakeups don't really cause entry into schedule(). They add a
  6696	 *      task to the run-queue and that's it.
  6697	 *
  6698	 *      Now, if the new task added to the run-queue preempts the current
  6699	 *      task, then the wakeup sets TIF_NEED_RESCHED and schedule() gets
  6700	 *      called on the nearest possible occasion:
  6701	 *
  6702	 *       - If the kernel is preemptible (CONFIG_PREEMPTION=y):
  6703	 *
  6704	 *         - in syscall or exception context, at the next outmost
  6705	 *           preempt_enable(). (this might be as soon as the wake_up()'s
  6706	 *           spin_unlock()!)
  6707	 *
  6708	 *         - in IRQ context, return from interrupt-handler to
  6709	 *           preemptible context
  6710	 *
  6711	 *       - If the kernel is not preemptible (CONFIG_PREEMPTION is not set)
  6712	 *         then at the next:
  6713	 *
  6714	 *          - cond_resched() call
  6715	 *          - explicit schedule() call
  6716	 *          - return from syscall or exception to user-space
  6717	 *          - return from interrupt-handler to user-space
  6718	 *
  6719	 * WARNING: must be called with preemption disabled!
  6720	 */
  6721	static void __sched notrace __schedule(unsigned int sched_mode)
  6722	{
  6723		struct task_struct *prev, *next;
  6724		unsigned long *switch_count;
  6725		unsigned long prev_state;
  6726		struct rq_flags rf;
  6727		struct rq *rq;
  6728		int cpu;
  6729	
  6730		cpu = smp_processor_id();
  6731		rq = cpu_rq(cpu);
  6732		prev = rq->curr;
  6733	
  6734		schedule_debug(prev, !!sched_mode);
  6735	
  6736		if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
  6737			hrtick_clear(rq);
  6738	
  6739		local_irq_disable();
  6740		rcu_note_context_switch(!!sched_mode);
  6741	
  6742		/*
  6743		 * Make sure that signal_pending_state()->signal_pending() below
  6744		 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
  6745		 * done by the caller to avoid the race with signal_wake_up():
  6746		 *
  6747		 * __set_current_state(@state)		signal_wake_up()
  6748		 * schedule()				  set_tsk_thread_flag(p, TIF_SIGPENDING)
  6749		 *					  wake_up_state(p, state)
  6750		 *   LOCK rq->lock			    LOCK p->pi_state
  6751		 *   smp_mb__after_spinlock()		    smp_mb__after_spinlock()
  6752		 *     if (signal_pending_state())	    if (p->state & @state)
  6753		 *
  6754		 * Also, the membarrier system call requires a full memory barrier
  6755		 * after coming from user-space, before storing to rq->curr.
  6756		 */
  6757		rq_lock(rq, &rf);
  6758		smp_mb__after_spinlock();
  6759	
  6760		/* Promote REQ to ACT */
  6761		rq->clock_update_flags <<= 1;
  6762		update_rq_clock(rq);
  6763	
  6764		switch_count = &prev->nivcsw;
  6765	
  6766		/*
  6767		 * We must load prev->state once (task_struct::state is volatile), such
  6768		 * that we form a control dependency vs deactivate_task() below.
  6769		 */
  6770		prev_state = READ_ONCE(prev->__state);
  6771		if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
  6772			try_to_deactivate_task(rq, prev, prev_state,
  6773					       !task_is_blocked(prev));
  6774			switch_count = &prev->nvcsw;
  6775		}
  6776	
  6777	pick_again:
> 6778		next = pick_next_task(rq, rq_selected(rq), &rf);
  6779		rq_set_selected(rq, next);
  6780		if (unlikely(task_is_blocked(next))) {
  6781			next = proxy(rq, next, &rf);
  6782			if (!next) {
  6783				rq_unpin_lock(rq, &rf);
  6784				__balance_callbacks(rq);
  6785				rq_repin_lock(rq, &rf);
  6786				goto pick_again;
  6787			}
  6788		}
  6789	
  6790		clear_tsk_need_resched(prev);
  6791		clear_preempt_need_resched();
  6792	#ifdef CONFIG_SCHED_DEBUG
  6793		rq->last_seen_need_resched_ns = 0;
  6794	#endif
  6795	
  6796		if (likely(prev != next)) {
  6797			rq->nr_switches++;
  6798			/*
  6799			 * RCU users of rcu_dereference(rq->curr) may not see
  6800			 * changes to task_struct made by pick_next_task().
  6801			 */
  6802			RCU_INIT_POINTER(rq->curr, next);
  6803			/*
  6804			 * The membarrier system call requires each architecture
  6805			 * to have a full memory barrier after updating
  6806			 * rq->curr, before returning to user-space.
  6807			 *
  6808			 * Here are the schemes providing that barrier on the
  6809			 * various architectures:
  6810			 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
  6811			 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
  6812			 * - finish_lock_switch() for weakly-ordered
  6813			 *   architectures where spin_unlock is a full barrier,
  6814			 * - switch_to() for arm64 (weakly-ordered, spin_unlock
  6815			 *   is a RELEASE barrier),
  6816			 */
  6817			++*switch_count;
  6818	
  6819			migrate_disable_switch(rq, prev);
  6820			psi_sched_switch(prev, next, !task_on_rq_queued(prev));
  6821	
  6822			trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
  6823	
  6824			/* Also unlocks the rq: */
  6825			rq = context_switch(rq, prev, next, &rf);
  6826		} else {
  6827			rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
  6828	
  6829			rq_unpin_lock(rq, &rf);
  6830			__balance_callbacks(rq);
  6831			raw_spin_rq_unlock_irq(rq);
  6832		}
  6833	}
  6834	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
