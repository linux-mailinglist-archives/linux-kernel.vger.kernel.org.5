Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE608096BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444131AbjLGXrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjLGXrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:47:06 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2989BD53
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:47:11 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc79f73e58so31785ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 15:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701992830; x=1702597630; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pwtshkhroNcEMzBdkiwuGRAULl8SBl22EvNnHzkPoo=;
        b=xd0/bupBRVMauxGvZswGGBaFscEvumrD7suLyuQxrC112Zpj+WP24MJyMSv6HuKSgk
         bzSg7uKkffjmisq3m4YrF9XL14l76RVlPyobXtBTv5KG9ZjYliolk1nW2hjh5JhZ2HOL
         OdP7soQN4MUqCtMuzPn71C4YvpObk6gOk1KMMNJsibiXZ+z3PUHkcA6LjzVdfpOOy6Pv
         BEZqUBcI9fXhvKV/ctJt7MDI3bNLQ166fap4AqWcbXmbTMM3vog7ZK496Yl7UM8EsgXz
         Tzkp2p0uMG5c2fiQIeo/kFrNQzJFCasa+tsqg8UB8pEKrJrD2INLGmGnGWjdiVJTvlev
         Sz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701992830; x=1702597630;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pwtshkhroNcEMzBdkiwuGRAULl8SBl22EvNnHzkPoo=;
        b=MQzbeEcQGyHw48D8TpHg3+FtinT3UMjKDlzdCro+Ialfe9vut41DtUxVMVHvpV3M8/
         8ht/q0yW9x+FkDLfwOPSKPww30GylU0lE8+yFIt+YhJbGOmZJb4fVel37TZ5ui93f+G2
         YBtNyPyEv/jbEmJ8f3TAOAi7Lsc33i653N89ykNdqZXIbB6q42pr+nmxiJP/MRU7ynnI
         pO9ax8BTyE6ixcPheWY54YWAI5NlI2pFIyDZvp6RsGRkPo29rZKNWFgo403SrGqz5VY3
         KHf1SOL1T3dzeaI/SJg54W1x6kx2uhlQ3x1jhCGgavgqvPAkPkatGKKFqNg3rXtX00di
         TwFQ==
X-Gm-Message-State: AOJu0Yyw4tvbXkQIHtj1AZHaws6IcCZxYwc0uEndcM7/L8iNHBIANimJ
        Owj3dksgjdCuzdwL6eqyyZDw9A==
X-Google-Smtp-Source: AGHT+IHTE/jXQJ+hTP5c6pkFHQrL6G2yzJiVLz7KZTpBJyB9fZQNEIQuUoeD08YKEMwZmGdXGsWdAw==
X-Received: by 2002:a17:902:c94f:b0:1d0:c25b:574c with SMTP id i15-20020a170902c94f00b001d0c25b574cmr86167pla.14.1701992830163;
        Thu, 07 Dec 2023 15:47:10 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2a3:200:6d82:2d7c:28f0:542c])
        by smtp.gmail.com with ESMTPSA id dw8-20020a17090b094800b0028862dc530bsm1979681pjb.25.2023.12.07.15.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 15:47:09 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH 1/2] sched/fair: Only throttle CFS tasks on return
 to userspace
In-Reply-To: <xhsmhfs0maw49.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
        (Valentin Schneider's message of "Fri, 01 Dec 2023 14:30:14 +0100")
References: <20231130161245.3894682-1-vschneid@redhat.com>
        <20231130161245.3894682-2-vschneid@redhat.com>
        <xm26sf4n2ar6.fsf@google.com>
        <xhsmhfs0maw49.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date:   Thu, 07 Dec 2023 15:47:07 -0800
Message-ID: <xm26edfxpock.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, this took longer than I intended, but here's the basic version
with the duplicate "runqueue" just being a list rather than actual EEVDF
or anything sensible.

I also wasn't actually able to adapt it to work via task_work like I
thought I could; flagging the entry to the relevant schedule() calls is
too critical.

--------

Subject: [RFC PATCH] sched/fair: only throttle CFS tasks in userspace

The basic idea of this implementation is to maintain duplicate runqueues
in each cfs_rq that contain duplicate pointers to sched_entitys which
should bypass throttling. Then we can skip throttling cfs_rqs that have
any such children, and when we pick inside any not-actually-throttled
cfs_rq, we only look at this duplicated list.

"Which tasks should bypass throttling" here is "all schedule() calls
that don't set a special flag", but could instead involve the lockdep
markers (except for the problem of percpu-rwsem and similar) or explicit
flags around syscalls and faults, or something else.

This approach avoids any O(tasks) loops, but leaves partially-throttled
cfs_rqs still contributing their full h_nr_running to their parents,
which might result in worse balancing. Also it adds more (generally
still small) overhead to the common enqueue/dequeue/pick paths.

The very basic debug test added is to run a cpusoaker and "cat
/sys/kernel/debug/sched_locked_spin" pinned to the same cpu in the same
cgroup with a quota < 1 cpu.
---
 include/linux/sched.h |   7 ++
 kernel/entry/common.c |   2 +-
 kernel/entry/kvm.c    |   2 +-
 kernel/sched/core.c   |  20 ++++
 kernel/sched/debug.c  |  28 +++++
 kernel/sched/fair.c   | 232 ++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h  |   3 +
 7 files changed, 281 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d258162deb0a..3e9e0e308d66d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -301,10 +301,11 @@ extern long schedule_timeout(long timeout);
 extern long schedule_timeout_interruptible(long timeout);
 extern long schedule_timeout_killable(long timeout);
 extern long schedule_timeout_uninterruptible(long timeout);
 extern long schedule_timeout_idle(long timeout);
 asmlinkage void schedule(void);
+asmlinkage void schedule_usermode(void);
 extern void schedule_preempt_disabled(void);
 asmlinkage void preempt_schedule_irq(void);
 #ifdef CONFIG_PREEMPT_RT
  extern void schedule_rtlock(void);
 #endif
@@ -576,10 +577,13 @@ struct sched_entity {
 	struct cfs_rq			*cfs_rq;
 	/* rq "owned" by this entity/group: */
 	struct cfs_rq			*my_q;
 	/* cached value of my_q->h_nr_running */
 	unsigned long			runnable_weight;
+#ifdef CONFIG_CFS_BANDWIDTH
+	struct list_head		kernel_node;
+#endif
 #endif
 
 #ifdef CONFIG_SMP
 	/*
 	 * Per entity load average tracking.
@@ -1562,10 +1566,13 @@ struct task_struct {
 
 #ifdef CONFIG_USER_EVENTS
 	struct user_event_mm		*user_event_mm;
 #endif
 
+#ifdef CONFIG_CFS_BANDWIDTH
+	atomic_t			in_return_to_user;
+#endif
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
 	 */
 	randomized_struct_fields_end
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d7ee4bc3f2ba3..008c4cf7c09a1 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -154,11 +154,11 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 	while (ti_work & EXIT_TO_USER_MODE_WORK) {
 
 		local_irq_enable_exit_to_user(ti_work);
 
 		if (ti_work & _TIF_NEED_RESCHED)
-			schedule();
+			schedule_usermode(); /* TODO: also all of the arch/* loops that don't use this yet */
 
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
 
 		if (ti_work & _TIF_PATCH_PENDING)
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 2e0f75bcb7fd1..fc4b73de07539 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -12,11 +12,11 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			kvm_handle_signal_exit(vcpu);
 			return -EINTR;
 		}
 
 		if (ti_work & _TIF_NEED_RESCHED)
-			schedule();
+			schedule_usermode();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
 			resume_user_mode_work(NULL);
 
 		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be4921e7f0..a7c028fad5a89 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4527,10 +4527,14 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
 #endif
+#ifdef CONFIG_CFS_BANDWIDTH
+	INIT_LIST_HEAD(&p->se.kernel_node);
+	atomic_set(&p->in_return_to_user, 0);
+#endif
 
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
 	memset(&p->stats, 0, sizeof(p->stats));
 #endif
@@ -6816,10 +6820,26 @@ asmlinkage __visible void __sched schedule(void)
 	__schedule_loop(SM_NONE);
 	sched_update_worker(tsk);
 }
 EXPORT_SYMBOL(schedule);
 
+asmlinkage __visible void __sched schedule_usermode(void)
+{
+#ifdef CONFIG_CFS_BANDWIDTH
+	/*
+	 * This is only atomic because of this simple implementation. We could
+	 * do something with an SM_USER to avoid other-cpu scheduler operations
+	 * racing against these writes.
+	 */
+	atomic_set(&current->in_return_to_user, true);
+	schedule();
+	atomic_set(&current->in_return_to_user, false);
+#else
+	schedule();
+#endif
+}
+
 /*
  * synchronize_rcu_tasks() makes sure that no task is stuck in preempted
  * state (have scheduled out non-voluntarily) by making sure that all
  * tasks have either left the run queue or have gone into user space.
  * As idle tasks do not do either, they must not ever be preempted
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 168eecc209b49..5d9d011a0e6fb 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -317,10 +317,36 @@ static const struct file_operations sched_verbose_fops = {
 	.write =        sched_verbose_write,
 	.open =         simple_open,
 	.llseek =       default_llseek,
 };
 
+static DEFINE_MUTEX(sched_debug_spin_mutex);
+static int sched_debug_spin_show(struct seq_file *m, void *v) {
+	int count;
+	mutex_lock(&sched_debug_spin_mutex);
+	for (count = 0; count < 1000; count++) {
+		u64 start2;
+		start2 = jiffies;
+		while (jiffies == start2)
+			cpu_relax();
+		schedule();
+	}
+	mutex_unlock(&sched_debug_spin_mutex);
+	return 0;
+}
+static int sched_debug_spin_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_debug_spin_show, NULL);
+}
+
+static const struct file_operations sched_debug_spin_fops = {
+	.open		= sched_debug_spin_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static const struct seq_operations sched_debug_sops;
 
 static int sched_debug_open(struct inode *inode, struct file *filp)
 {
 	return seq_open(filp, &sched_debug_sops);
@@ -372,10 +398,12 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
 #endif
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
+	debugfs_create_file("sched_locked_spin", 0444, NULL, NULL,
+			    &sched_debug_spin_fops);
 	return 0;
 }
 late_initcall(sched_init_debug);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d3..15e5e358c91e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -126,10 +126,11 @@ int __weak arch_asym_cpu_priority(int cpu)
  * we will always only issue the remaining available time.
  *
  * (default: 5 msec, units: microseconds)
  */
 static unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
+static unsigned int sysctl_sched_cfs_bandwidth_kernel_bypass 	= 1; 
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
 /* Restrict the NUMA promotion throughput (MB/s) for each target node. */
 static unsigned int sysctl_numa_balancing_promote_rate_limit = 65536;
@@ -144,10 +145,19 @@ static struct ctl_table sched_fair_sysctls[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
 		.extra1         = SYSCTL_ONE,
 	},
+	{
+		.procname       = "sched_cfs_bandwidth_kernel_bypass",
+		.data           = &sysctl_sched_cfs_bandwidth_kernel_bypass,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	{
 		.procname	= "numa_balancing_promote_rate_limit_MBps",
 		.data		= &sysctl_numa_balancing_promote_rate_limit,
@@ -5416,18 +5426,38 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
 }
 
 /*
  * Pick the next process, keeping these things in mind, in this order:
- * 1) keep things fair between processes/task groups
- * 2) pick the "next" process, since someone really wants that to run
- * 3) pick the "last" process, for cache locality
- * 4) do not run the "skip" process, if something else is available
+ * 1) If we're inside a throttled cfs_rq, only pick threads in the kernel
+ * 2) keep things fair between processes/task groups
+ * 3) pick the "next" process, since someone really wants that to run
+ * 4) pick the "last" process, for cache locality
+ * 5) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
-pick_next_entity(struct cfs_rq *cfs_rq)
+pick_next_entity(struct cfs_rq *cfs_rq, bool throttled)
 {
+#ifdef CONFIG_CFS_BANDWIDTH
+	/*
+	 * TODO: This might trigger, I'm not sure/don't remember. Regardless,
+	 * while we do not explicitly handle the case where h_kernel_running
+	 * goes to 0, we will call account/check_cfs_rq_runtime at worst in
+	 * entity_tick and notice that we can now properly do the full
+	 * throttle_cfs_rq.
+	 */
+	WARN_ON_ONCE(list_empty(&cfs_rq->kernel_children));
+	if (throttled && !list_empty(&cfs_rq->kernel_children)) {
+		/*
+		 * TODO: you'd want to factor out pick_eevdf to just take
+		 * tasks_timeline, and replace this list with a second rbtree
+		 * and a call to pick_eevdf.
+		 */
+		return list_first_entry(&cfs_rq->kernel_children,
+					struct sched_entity, kernel_node);
+	}
+#endif
 	/*
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
 	 */
 	if (sched_feat(NEXT_BUDDY) &&
 	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
@@ -5622,12 +5652,18 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	if (cfs_rq->throttled)
 		return;
 	/*
 	 * if we're unable to extend our runtime we resched so that the active
 	 * hierarchy can be throttled
+	 *
+	 * Don't resched_curr() if curr is in the kernel. We won't throttle the
+	 * cfs_rq if any task is in the kernel, and if curr in particular is we
+	 * don't need to preempt it in favor of whatever other task is in the
+	 * kernel.
 	 */
-	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->curr))
+	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->curr) &&
+	    list_empty(&rq_of(cfs_rq)->curr->se.kernel_node))
 		resched_curr(rq_of(cfs_rq));
 }
 
 static __always_inline
 void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
@@ -5712,16 +5748,26 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	cfs_rq->throttle_count++;
 
 	return 0;
 }
 
+static void enqueue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count);
+static void dequeue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count);
+
 static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, dequeue = 1;
+	long task_delta, idle_task_delta, kernel_delta, dequeue = 1;
+
+	/*
+	 * We don't actually throttle, though account() will have made sure to
+	 * resched us so that we pick into a kernel task.
+	 */
+	if (cfs_rq->h_kernel_running)
+		return false;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
 	if (__assign_cfs_rq_runtime(cfs_b, cfs_rq, 1)) {
 		/*
@@ -5749,10 +5795,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
 	rcu_read_unlock();
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	kernel_delta = cfs_rq->h_kernel_running;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
 		if (!se->on_rq)
 			goto done;
@@ -5762,10 +5809,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
 			idle_task_delta = cfs_rq->h_nr_running;
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		dequeue_kernel(qcfs_rq, se, kernel_delta);
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
 			se = parent_entity(se);
 			break;
@@ -5784,10 +5832,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
 			idle_task_delta = cfs_rq->h_nr_running;
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		dequeue_kernel(qcfs_rq, se, kernel_delta);
 	}
 
 	/* At this point se is NULL and we are at root level*/
 	sub_nr_running(rq, task_delta);
 
@@ -5806,11 +5855,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta;
+	long task_delta, idle_task_delta, kernel_delta;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
 	cfs_rq->throttled = 0;
 
@@ -5841,10 +5890,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		goto unthrottle_throttle;
 	}
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	kernel_delta = cfs_rq->h_kernel_running;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
 		if (se->on_rq)
 			break;
@@ -5853,10 +5903,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
 			idle_task_delta = cfs_rq->h_nr_running;
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		enqueue_kernel(qcfs_rq, se, kernel_delta);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
 			goto unthrottle_throttle;
 	}
@@ -5870,10 +5921,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
 			idle_task_delta = cfs_rq->h_nr_running;
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		enqueue_kernel(qcfs_rq, se, kernel_delta);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
 			goto unthrottle_throttle;
 	}
@@ -6528,10 +6580,90 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 	if (cfs_task_bw_constrained(p))
 		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
 }
 #endif
 
+/*
+ * We keep track of all children that are runnable in the kernel with a count of
+ * all descendants. The state is checked on enqueue and put_prev (and hard
+ * cleared on dequeue), and is stored just as the filled/empty state of the
+ * kernel_node list entry.
+ *
+ * These are simple helpers that do both parts, and should be called bottom-up
+ * until hitting a throttled cfs_rq whenever a task changes state (or a cfs_rq
+ * is (un)throttled).
+ */
+static void enqueue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count)
+{
+	if (count == 0)
+		return;
+
+	if (list_empty(&se->kernel_node))
+		list_add(&se->kernel_node, &cfs_rq->kernel_children);
+	cfs_rq->h_kernel_running += count;
+}
+
+static bool is_kernel_task(struct task_struct *p)
+{
+	return sysctl_sched_cfs_bandwidth_kernel_bypass && !atomic_read(&p->in_return_to_user);
+}
+
+/*
+ * When called on a task this always transitions it to a !kernel state.
+ *
+ * When called on a group it is just synchronizing the state with the new
+ * h_kernel_waiters, unless this it has been throttled and is !on_rq
+ */
+static void dequeue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count)
+{
+	if (count == 0)
+		return;
+
+	if (!se->on_rq || entity_is_task(se) ||
+	    !group_cfs_rq(se)->h_kernel_running)
+		list_del_init(&se->kernel_node);
+	cfs_rq->h_kernel_running -= count;
+}
+
+/*
+ * Returns if the cfs_rq "should" be throttled but might not be because of
+ * kernel threads bypassing throttle.
+ */
+static bool cfs_rq_throttled_loose(struct cfs_rq *cfs_rq)
+{
+	if (!cfs_bandwidth_used())
+		return false;
+
+	if (likely(!cfs_rq->runtime_enabled || cfs_rq->runtime_remaining > 0))
+		return false;
+	return true;
+}
+
+static void unthrottle_on_enqueue(struct task_struct *p)
+{
+	struct sched_entity *se = &p->se;
+
+	if (!cfs_bandwidth_used() || !sysctl_sched_cfs_bandwidth_kernel_bypass)
+		return;
+	if (!cfs_rq_of(&p->se)->throttle_count)
+		return;
+
+	/*
+	 * MAYBE TODO: doing it this simple way is O(throttle_count *
+	 * cgroup_depth). We could optimize that into a single pass, but making
+	 * a mostly-copy of unthrottle_cfs_rq that does that is a pain and easy
+	 * to get wrong. (And even without unthrottle_on_enqueue it's O(nm),
+	 * just not while holding rq->lock the whole time)
+	 */
+
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+		if (cfs_rq->throttled)
+			unthrottle_cfs_rq(cfs_rq);
+	}
+}
+
 #else /* CONFIG_CFS_BANDWIDTH */
 
 static inline bool cfs_bandwidth_used(void)
 {
 	return false;
@@ -6575,10 +6707,20 @@ static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
 bool cfs_task_bw_constrained(struct task_struct *p)
 {
 	return false;
 }
 #endif
+static void enqueue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count) {}
+static void dequeue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count) {}
+static inline bool is_kernel_task(struct task_struct *p)
+{
+	return false;
+}
+static bool cfs_rq_throttled_loose(struct cfs_rq *cfs_rq)
+{
+	return false;
+}
 #endif /* CONFIG_CFS_BANDWIDTH */
 
 #if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
 static inline void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p) {}
 #endif
@@ -6678,10 +6820,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
+	bool kernel_task = is_kernel_task(p);
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
 	 * the cfs_rq utilization to select a frequency.
 	 * Let's add the task's estimated utilization to the cfs_rq's
@@ -6706,10 +6849,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
+		if (kernel_task)
+			enqueue_kernel(cfs_rq, se, 1);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
 
@@ -6726,10 +6871,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
+		if (kernel_task)
+			enqueue_kernel(cfs_rq, se, 1);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
 	}
@@ -6756,10 +6903,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
+
+	if (kernel_task)
+		unthrottle_on_enqueue(p);
 }
 
 static void set_next_buddy(struct sched_entity *se);
 
 /*
@@ -6772,10 +6922,11 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
+	bool kernel_task = !list_empty(&p->se.kernel_node);
 
 	util_est_dequeue(&rq->cfs, p);
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -6784,10 +6935,12 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq->h_nr_running--;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
+		if (kernel_task)
+			dequeue_kernel(cfs_rq, se, 1);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto dequeue_throttle;
 
@@ -6816,10 +6969,12 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq->h_nr_running--;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
+		if (kernel_task)
+			dequeue_kernel(cfs_rq, se, 1);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto dequeue_throttle;
 
@@ -8316,15 +8471,44 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 
 preempt:
 	resched_curr(rq);
 }
 
+static void handle_kernel_task_prev(struct task_struct *prev)
+{
+#ifdef CONFIG_CFS_BANDWIDTH
+	struct sched_entity *se = &prev->se;
+	bool new_kernel = is_kernel_task(prev);
+	bool prev_kernel = !list_empty(&se->kernel_node);
+	/*
+	 * These extra loops are bad and against the whole point of the merged
+	 * PNT, but it's a pain to merge, particularly since we want it to occur
+	 * before check_cfs_runtime.
+	 */
+	if (prev_kernel && !new_kernel) {
+		WARN_ON_ONCE(!se->on_rq); /* dequeue should have removed us */
+		for_each_sched_entity(se) {
+			dequeue_kernel(cfs_rq_of(se), se, 1);
+			if (cfs_rq_throttled(cfs_rq_of(se)))
+				break;
+		}
+	} else if (!prev_kernel && new_kernel && se->on_rq) {
+		for_each_sched_entity(se) {
+			enqueue_kernel(cfs_rq_of(se), se, 1);
+			if (cfs_rq_throttled(cfs_rq_of(se)))
+				break;
+		}
+	}
+#endif
+}
+
 #ifdef CONFIG_SMP
 static struct task_struct *pick_task_fair(struct rq *rq)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
+	bool throttled = false;
 
 again:
 	cfs_rq = &rq->cfs;
 	if (!cfs_rq->nr_running)
 		return NULL;
@@ -8341,11 +8525,14 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 
 			if (unlikely(check_cfs_rq_runtime(cfs_rq)))
 				goto again;
 		}
 
-		se = pick_next_entity(cfs_rq);
+		if (cfs_rq_throttled_loose(cfs_rq))
+			throttled = true;
+
+		se = pick_next_entity(cfs_rq, throttled);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
 	return task_of(se);
 }
@@ -8356,10 +8543,18 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 {
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *se;
 	struct task_struct *p;
 	int new_tasks;
+	bool throttled;
+
+	/*
+	 * We want to handle this before check_cfs_runtime(prev). We'll
+	 * duplicate a little work in the goto simple case, but that's fine
+	 */
+	if (prev)
+		handle_kernel_task_prev(prev);
 
 again:
 	if (!sched_fair_runnable(rq))
 		goto idle;
 
@@ -8373,10 +8568,11 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	 *
 	 * Therefore attempt to avoid putting and setting the entire cgroup
 	 * hierarchy, only change the part that actually changes.
 	 */
 
+	throttled = false;
 	do {
 		struct sched_entity *curr = cfs_rq->curr;
 
 		/*
 		 * Since we got here without doing put_prev_entity() we also
@@ -8404,11 +8600,14 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 
 				goto simple;
 			}
 		}
 
-		se = pick_next_entity(cfs_rq);
+		if (cfs_rq_throttled_loose(cfs_rq))
+			throttled = true;
+
+		se = pick_next_entity(cfs_rq, throttled);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
 	p = task_of(se);
 
@@ -8442,12 +8641,15 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 simple:
 #endif
 	if (prev)
 		put_prev_task(rq, prev);
 
+	throttled = false;
 	do {
-		se = pick_next_entity(cfs_rq);
+		if (cfs_rq_throttled_loose(cfs_rq))
+			throttled = true;
+		se = pick_next_entity(cfs_rq, throttled);
 		set_next_entity(cfs_rq, se);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
 	p = task_of(se);
@@ -8507,10 +8709,12 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq)
 static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
 
+	handle_kernel_task_prev(prev);
+
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		put_prev_entity(cfs_rq, se);
 	}
 }
@@ -12788,10 +12992,13 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
 	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
+#ifdef CONFIG_CFS_BANDWIDTH
+	INIT_LIST_HEAD(&cfs_rq->kernel_children);
+#endif
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void task_change_group_fair(struct task_struct *p)
 {
@@ -12940,10 +13147,13 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 
 	se->my_q = cfs_rq;
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
 	se->parent = parent;
+#ifdef CONFIG_CFS_BANDWIDTH
+	INIT_LIST_HEAD(&se->kernel_node);
+#endif
 }
 
 static DEFINE_MUTEX(shares_mutex);
 
 static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77de..5fee806cc4538 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -578,10 +578,11 @@ struct cfs_rq {
 	u64			min_vruntime_copy;
 #endif
 
 	struct rb_root_cached	tasks_timeline;
 
+
 	/*
 	 * 'curr' points to currently running entity on this cfs_rq.
 	 * It is set to NULL otherwise (i.e when none are currently running).
 	 */
 	struct sched_entity	*curr;
@@ -656,12 +657,14 @@ struct cfs_rq {
 	u64			throttled_clock_pelt_time;
 	u64			throttled_clock_self;
 	u64			throttled_clock_self_time;
 	int			throttled;
 	int			throttle_count;
+	int			h_kernel_running;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
+	struct list_head	kernel_children;;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
 
 static inline int rt_bandwidth_enabled(void)
-- 
2.43.0.472.g3155946c3a-goog

