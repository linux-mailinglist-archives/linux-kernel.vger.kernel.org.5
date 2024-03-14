Return-Path: <linux-kernel+bounces-103165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD0E87BBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FED284148
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E700A6EB5A;
	Thu, 14 Mar 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NescIGjE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jbwCIgt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91571A38DD;
	Thu, 14 Mar 2024 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415057; cv=none; b=i+R6hc11Yve9wLtahtPf8XtF0TdBsB6CtE3tsqzQWJ9KI+7ED7rbiIV7E0cI3YSwnky083DuSmaHzP+scToDgB2FmZOio539vNWLuIMpt/V5awojsmzV0InHQhFWb8yTeYVzuOjOFfCoBEvUedUeOsu0IRsDOWvncBhbFbW1kIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415057; c=relaxed/simple;
	bh=nZMyTibL97qria2xhMumMQikMnIJutgZUAgvf+5WC+Q=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=odGGQl7f3ni+jd4vgupVYunWGZAZ5DyO/VbsgW3KrdCzX3ueKMHydO3P/a4uSECF1gtw+vBAkozCQYzKuRjZ9BlN4LR2q02ucYSZDxQj6xAlj3EwtQ+JNo5SckqzzJOY+/EyAVg+OylW85ruL/2E3BWOxC6LAYPJOABMHPLe+/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NescIGjE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0jbwCIgt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Mar 2024 11:17:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710415054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EIzuRjlyBheRR+e3Vbik81p31zl5BG6j6afsDm4MPhk=;
	b=NescIGjE3O6wmdJ9snPhdVkV5PYk7nG1G7cW+Ja8jk5OipUvosoKjALpwt9JjVjug7Z/TC
	RP24P4cgCzjEloxDVhxgcWDJf3Y2Batfg8pkWvqDG7j49M2wZTm/cxe7rPnz1mRxNCsHFu
	TJYEJ4PTztzZnFA2QOIuUDvAtv2CREFDT2apwy1WQpZA25tTFPhqEmE9k/hbMA3QtqGOQy
	n0EkZw6bCsEeJ7b3oXIFYcw6qbK3oHdQJMNCGFbBbvHt97x/lf3qsY/XR+Yqc6wvlgJwq4
	jJ1gMwe5gLpeAyPtrmEdZ6y+c+QWmFT9nEfFPL12QRhrDEfVnh9H2niT6Uzuqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710415054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EIzuRjlyBheRR+e3Vbik81p31zl5BG6j6afsDm4MPhk=;
	b=0jbwCIgtD6/nVQNFq79WJhRtW2KM5UtgaTvK3vGDDzwOS7NtckBV+Tx/wEXHzq5usaPF9u
	3rQBOWR02CQ2i0Cg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix typos in comments
Cc:
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171041505306.398.3446887943610854641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b9e6e28663928cab836a19abbdec3d036a07db3b
Gitweb:        https://git.kernel.org/tip/b9e6e28663928cab836a19abbdec3d036a07db3b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 14 Mar 2024 12:06:03 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 14 Mar 2024 12:08:23 +01:00

sched/fair: Fix typos in comments

So I made all speling mistakes / typos red in my editor. Big mistake...

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/fair.c | 68 ++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a19ea29..c8e50fb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -388,8 +388,8 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 
 		/*
 		 * With cfs_rq being unthrottled/throttled during an enqueue,
-		 * it can happen the tmp_alone_branch points the a leaf that
-		 * we finally want to del. In this case, tmp_alone_branch moves
+		 * it can happen the tmp_alone_branch points to the leaf that
+		 * we finally want to delete. In this case, tmp_alone_branch moves
 		 * to the prev element but it will point to rq->leaf_cfs_rq_list
 		 * at the end of the enqueue.
 		 */
@@ -406,7 +406,7 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
 }
 
-/* Iterate thr' all leaf cfs_rq's on a runqueue */
+/* Iterate through all leaf cfs_rq's on a runqueue */
 #define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
 	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
 				 leaf_cfs_rq_list)
@@ -595,13 +595,13 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
  *
  * [[ NOTE: this is only equal to the ideal scheduler under the condition
  *          that join/leave operations happen at lag_i = 0, otherwise the
- *          virtual time has non-continguous motion equivalent to:
+ *          virtual time has non-contiguous motion equivalent to:
  *
  *	      V +-= lag_i / W
  *
  *	    Also see the comment in place_entity() that deals with this. ]]
  *
- * However, since v_i is u64, and the multiplcation could easily overflow
+ * However, since v_i is u64, and the multiplication could easily overflow
  * transform it into a relative form that uses smaller quantities:
  *
  * Substitute: v_i == (v_i - v0) + v0
@@ -671,7 +671,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 	}
 
 	if (load) {
-		/* sign flips effective floor / ceil */
+		/* sign flips effective floor / ceiling */
 		if (avg < 0)
 			avg -= (load - 1);
 		avg = div_s64(avg, load);
@@ -721,7 +721,7 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
  *
  * lag_i >= 0 -> \Sum (v_i - v)*w_i >= (v_i - v)*(\Sum w_i)
  *
- * Note: using 'avg_vruntime() > se->vruntime' is inacurate due
+ * Note: using 'avg_vruntime() > se->vruntime' is inaccurate due
  *       to the loss in precision caused by the division.
  */
 static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime)
@@ -1024,7 +1024,7 @@ void init_entity_runnable_average(struct sched_entity *se)
 	if (entity_is_task(se))
 		sa->load_avg = scale_load_down(se->load.weight);
 
-	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
+	/* when this task is enqueued, it will contribute to its cfs_rq's load_avg */
 }
 
 /*
@@ -1616,7 +1616,7 @@ static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
 	max_dist = READ_ONCE(sched_max_numa_distance);
 	/*
 	 * This code is called for each node, introducing N^2 complexity,
-	 * which should be ok given the number of nodes rarely exceeds 8.
+	 * which should be OK given the number of nodes rarely exceeds 8.
 	 */
 	for_each_online_node(node) {
 		unsigned long faults;
@@ -3284,7 +3284,7 @@ retry_pids:
 		/*
 		 * Shared library pages mapped by multiple processes are not
 		 * migrated as it is expected they are cache replicated. Avoid
-		 * hinting faults in read-only file-backed mappings or the vdso
+		 * hinting faults in read-only file-backed mappings or the vDSO
 		 * as migrating the pages will be of marginal benefit.
 		 */
 		if (!vma->vm_mm ||
@@ -3295,7 +3295,7 @@ retry_pids:
 
 		/*
 		 * Skip inaccessible VMAs to avoid any confusion between
-		 * PROT_NONE and NUMA hinting ptes
+		 * PROT_NONE and NUMA hinting PTEs
 		 */
 		if (!vma_is_accessible(vma)) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_INACCESSIBLE);
@@ -3327,7 +3327,7 @@ retry_pids:
 		}
 
 		/*
-		 * Scanning the VMA's of short lived tasks add more overhead. So
+		 * Scanning the VMAs of short lived tasks add more overhead. So
 		 * delay the scan for new VMAs.
 		 */
 		if (mm->numa_scan_seq && time_before(jiffies,
@@ -3371,7 +3371,7 @@ retry_pids:
 			/*
 			 * Try to scan sysctl_numa_balancing_size worth of
 			 * hpages that have at least one present PTE that
-			 * is not already pte-numa. If the VMA contains
+			 * is not already PTE-numa. If the VMA contains
 			 * areas that are unused or already full of prot_numa
 			 * PTEs, scan up to virtpages, to skip through those
 			 * areas faster.
@@ -4733,7 +4733,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	/*
 	 * Track task load average for carrying it to new CPU after migrated, and
-	 * track group sched_entity load average for task_h_load calc in migration
+	 * track group sched_entity load average for task_h_load calculation in migration
 	 */
 	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
 		__update_load_avg_se(now, cfs_rq, se);
@@ -5014,14 +5014,14 @@ static inline int util_fits_cpu(unsigned long util,
 	 *   |     |   |       |   |      |   |
 	 *   |     |   |       |   |      |   |
 	 *   +----------------------------------------
-	 *         cpu0        cpu1       cpu2
+	 *         CPU0        CPU1       CPU2
 	 *
 	 *   In the above example if a task is capped to a specific performance
 	 *   point, y, then when:
 	 *
-	 *   * util = 80% of x then it does not fit on cpu0 and should migrate
-	 *     to cpu1
-	 *   * util = 80% of y then it is forced to fit on cpu1 to honour
+	 *   * util = 80% of x then it does not fit on CPU0 and should migrate
+	 *     to CPU1
+	 *   * util = 80% of y then it is forced to fit on CPU1 to honour
 	 *     uclamp_max request.
 	 *
 	 *   which is what we're enforcing here. A task always fits if
@@ -5052,7 +5052,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 *   |     |   |       |   |      |   |
 	 *   |     |   |       |   |      |   |      (region c, boosted, util < uclamp_min)
 	 *   +----------------------------------------
-	 *         cpu0        cpu1       cpu2
+	 *         CPU0        CPU1       CPU2
 	 *
 	 * a) If util > uclamp_max, then we're capped, we don't care about
 	 *    actual fitness value here. We only care if uclamp_max fits
@@ -5242,7 +5242,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	se->vruntime = vruntime - lag;
 
 	/*
-	 * When joining the competition; the exisiting tasks will be,
+	 * When joining the competition; the existing tasks will be,
 	 * on average, halfway through their slice, as such start tasks
 	 * off with half a slice to ease into the competition.
 	 */
@@ -5391,7 +5391,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * Now advance min_vruntime if @se was the entity holding it back,
 	 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
 	 * put back on, and if we advance min_vruntime, we'll be placed back
-	 * further than we started -- ie. we'll be penalized.
+	 * further than we started -- i.e. we'll be penalized.
 	 */
 	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
@@ -5427,7 +5427,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 	/*
 	 * Track our maximum slice length, if the CPU's load is at
-	 * least twice that of our own weight (i.e. dont track it
+	 * least twice that of our own weight (i.e. don't track it
 	 * when there are only lesser-weight tasks around):
 	 */
 	if (schedstat_enabled() &&
@@ -7503,7 +7503,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 
 	/*
 	 * On asymmetric system, update task utilization because we will check
-	 * that the task fits with cpu's capacity.
+	 * that the task fits with CPU's capacity.
 	 */
 	if (sched_asym_cpucap_active()) {
 		sync_entity_load_avg(&p->se);
@@ -8027,7 +8027,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
 				/*
 				 * Open code uclamp_rq_util_with() except for
-				 * the clamp() part. Ie: apply max aggregation
+				 * the clamp() part. I.e.: apply max aggregation
 				 * only. util_fits_cpu() logic requires to
 				 * operate on non clamped util but must use the
 				 * max-aggregated uclamp_{min, max}.
@@ -8586,7 +8586,7 @@ static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 	if (!se->on_rq || throttled_hierarchy(cfs_rq_of(se)))
 		return false;
 
-	/* Tell the scheduler that we'd really like pse to run next. */
+	/* Tell the scheduler that we'd really like se to run next. */
 	set_next_buddy(se);
 
 	yield_task_fair(rq);
@@ -8924,7 +8924,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
-	/* Disregard pcpu kthreads; they are where they need to be. */
+	/* Disregard percpu kthreads; they are where they need to be. */
 	if (kthread_is_per_cpu(p))
 		return 0;
 
@@ -10076,7 +10076,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 has_spare:
 
 		/*
-		 * Select not overloaded group with lowest number of idle cpus
+		 * Select not overloaded group with lowest number of idle CPUs
 		 * and highest number of running tasks. We could also compare
 		 * the spare capacity which is more stable but it can end up
 		 * that the group has less spare capacity but finally more idle
@@ -10715,7 +10715,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 
 			/*
 			 * If there is no overload, we just want to even the number of
-			 * idle cpus.
+			 * idle CPUs.
 			 */
 			env->migration_type = migrate_task;
 			env->imbalance = max_t(long, 0,
@@ -11900,7 +11900,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * currently idle; in which case, kick the ILB to move tasks
 		 * around.
 		 *
-		 * When balancing betwen cores, all the SMT siblings of the
+		 * When balancing between cores, all the SMT siblings of the
 		 * preferred CPU must be idle.
 		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
@@ -12061,7 +12061,7 @@ void nohz_balance_enter_idle(int cpu)
 out:
 	/*
 	 * Each time a cpu enter idle, we assume that it has blocked load and
-	 * enable the periodic update of the load of idle cpus
+	 * enable the periodic update of the load of idle CPUs
 	 */
 	WRITE_ONCE(nohz.has_blocked, 1);
 }
@@ -12085,7 +12085,7 @@ static bool update_nohz_stats(struct rq *rq)
 }
 
 /*
- * Internal function that runs load balance for all idle cpus. The load balance
+ * Internal function that runs load balance for all idle CPUs. The load balance
  * can be a simple update of blocked load or a complete load balance with
  * tasks movement depending of flags.
  */
@@ -12190,7 +12190,7 @@ abort:
 
 /*
  * In CONFIG_NO_HZ_COMMON case, the idle balance kickee will do the
- * rebalancing for all the cpus for whom scheduler ticks are stopped.
+ * rebalancing for all the CPUs for whom scheduler ticks are stopped.
  */
 static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 {
@@ -12221,7 +12221,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
  * called from this function on (this) CPU that's not yet in the mask. That's
  * OK because the goal of nohz_run_idle_balance() is to run ILB only for
  * updating the blocked load of already idle CPUs without waking up one of
- * those idle CPUs and outside the preempt disable / irq off phase of the local
+ * those idle CPUs and outside the preempt disable / IRQ off phase of the local
  * cpu about to enter idle, because it can take a long time.
  */
 void nohz_run_idle_balance(int cpu)
@@ -12232,7 +12232,7 @@ void nohz_run_idle_balance(int cpu)
 
 	/*
 	 * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
-	 * (ie NOHZ_STATS_KICK set) and will do the same.
+	 * (i.e. NOHZ_STATS_KICK set) and will do the same.
 	 */
 	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
 		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);

