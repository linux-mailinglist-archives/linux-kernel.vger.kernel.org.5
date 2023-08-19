Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C228C78179C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245637AbjHSGKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245301AbjHSGJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:09:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF827420E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:47 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bb8caf7312so20418145ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425387; x=1693030187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOc6VW12skBOT6UpgTVChkGuV7aizXPCPRbBY5TT+qQ=;
        b=G8u0PiYALzhsc7g/AbYuQ/T0HPLQSatvx5aPbZgYZ2Pnjc5OTrzNoiJ9oCnhXxXuMs
         LFWpvm36oByV0epmiwsSni6fcmcOt6DUBn+BEunN++ieKw2fX2V2Gdpz3ECE6s/oxCFy
         zVoc/FPa3mrlgHi75Q87+a1MtwcyOlDsfTyk5Aqqr0KDCQg+ykq0DqMu/oo+VTjo7WMp
         nptQy75aVPXDKEtMnnlYSdRyWrhwWuyUspJ678dZzMeCX6wtxZ5/JPYBAPXKFnams9TB
         OCXAUpxxqtNTBrL7Eq2A2Ke5dq0sy+VnWWVQ2t5O1h4/lC3BQenj8jo8bVi8bo2+nWR2
         4MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425387; x=1693030187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOc6VW12skBOT6UpgTVChkGuV7aizXPCPRbBY5TT+qQ=;
        b=HXahLHGKju8IQ2iEeeneXSjwJyvL4ONOJD1Qy/aujzQEBYRcPcWJMN8gs+ru56qNDv
         KlzqEndLLr7xZ+MaAT6CizRw0F1J9P5dR6ysDB3eQyMqaa9LqtVoH9QmLGGTJfOviBgU
         xUTjvKnBTA2LhJ0+eZ0Ft29/c/Yg762Y+5bAC+tRTgCoih7za/cXkYjCkV3IoajAMml7
         5+2xlg1FLYk6oFjMY0svThs2zjZW1TAQ0hbJ9Q6ILs9Tk5i0drZuX/aZ8iGZ+DZo4oKl
         kztTYaeKSFel8SZVLChrU1MpCrvQLY8PkHtLh3y4BlzQyFSmA40FYt1IL3pe3Hs9xbvP
         qOUA==
X-Gm-Message-State: AOJu0YyzItUyu1ljzr4yx8jqRMd5yLv24rzm+LboRkq0ytCH/rZ8Ouz7
        kovHHO4U35ovncvsRhzN2fUEuWHFkwSOJ7jwh2FfrCdbGjAKWahhBTGyz4tAY18kbNcISnA9qSt
        X+OSxGOZ5GkTnHH+e00ULwbB1m69ARNYR0mjN9NYLmDHKXuS0V2BvOFXHHrHBsmMVxtNyD8U=
X-Google-Smtp-Source: AGHT+IEaWkjZooxI0/4o/3v9ou4u53KzKZDrY0eCMyAGYiUso8vMBE6jpt/LoYMbq8UkL9ecR5LPPS38afQb
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:fb05:b0:1bd:e698:74e with SMTP id
 le5-20020a170902fb0500b001bde698074emr106139plb.6.1692425386150; Fri, 18 Aug
 2023 23:09:46 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:44 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-11-jstultz@google.com>
Subject: [PATCH v5 10/19] sched: Split scheduler execution context
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Lets define the scheduling context as all the scheduler state in
task_struct and the execution context as all state required to run
the task.

Currently both are intertwined in task_struct. We want to logically
split these such that we can run the execution context of one task
with the scheduling context of another.

To this purpose introduce rq_selected() macro to point to the
task_struct used for scheduler state and preserve rq->curr to
denote the execution context.

NOTE: Peter previously mentioned he didn't like the name
"rq_selected()", but I've not come up with a better alternative.
I'm very open to other name proposals.

Question for Peter: Dietmar suggested you'd prefer I drop the
conditionalization of the scheduler context pointer on the rq
(so rq_selected() would be open coded as rq->curr_sched or
whatever we agree on for a name), but I'd think in the
!CONFIG_PROXY_EXEC case we'd want to avoid the wasted pointer
and its use (since it curr_sched would always be == curr)?
If I'm wrong I'm fine switching this, but would appreciate
clarification.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20181009092434.26221-5-juri.lelli@redhat.com
[add additional comments and update more sched_class code to use
 rq::proxy]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Rebased and resolved minor collisions, reworked to use
 accessors, tweaked update_curr_common to use rq_proxy fixing rt
 scheduling issues]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Reworked to use accessors
* Fixed update_curr_common to use proxy instead of curr
v3:
* Tweaked wrapper names
* Swapped proxy for selected for clarity
v4:
* Minor variable name tweaks for readability
* Use a macro instead of a inline function and drop
  other helper functions as suggested by Peter.
* Remove verbose comments/questions to avoid review
  distractions, as suggested by Dietmar
v5:
* Add CONFIG_PROXY_EXEC option to this patch so the
  new logic can be tested with this change
* Minor fix to grab rq_selected when holding the rq lock
---
 init/Kconfig            |  7 +++++++
 kernel/sched/core.c     | 39 ++++++++++++++++++++++++++-------------
 kernel/sched/deadline.c | 35 ++++++++++++++++++-----------------
 kernel/sched/fair.c     | 18 +++++++++---------
 kernel/sched/rt.c       | 40 ++++++++++++++++++++--------------------
 kernel/sched/sched.h    | 37 +++++++++++++++++++++++++++++++++++--
 6 files changed, 115 insertions(+), 61 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index f7f65af4ee12..a6c83931a9a9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -907,6 +907,13 @@ config NUMA_BALANCING_DEFAULT_ENABLED
 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
 	  machine.
 
+config PROXY_EXEC
+	bool "Proxy Execution"
+	default n
+	help
+	  This option enables proxy execution, a mechanism for mutex owning
+	  tasks to inherit the scheduling context of higher priority waiters.
+
 menuconfig CGROUPS
 	bool "Control Group support"
 	select KERNFS
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c73..ea0a7fb144fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -793,7 +793,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->curr->sched_class->task_tick(rq, rq->curr, 1);
+	rq_selected(rq)->sched_class->task_tick(rq, rq_selected(rq), 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -2200,16 +2200,18 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->sched_class == rq->curr->sched_class)
-		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
-	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
+	struct task_struct *curr = rq_selected(rq);
+
+	if (p->sched_class == curr->sched_class)
+		curr->sched_class->check_preempt_curr(rq, p, flags);
+	else if (sched_class_above(p->sched_class, curr->sched_class))
 		resched_curr(rq);
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
 	 * this case, we can save a useless back to back clock update.
 	 */
-	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
+	if (task_on_rq_queued(curr) && test_tsk_need_resched(rq->curr))
 		rq_clock_skip_update(rq);
 }
 
@@ -2748,7 +2750,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 
 	if (queued) {
 		/*
@@ -5573,7 +5575,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	 * project cycles that may never be accounted to this
 	 * thread, breaking clock_gettime().
 	 */
-	if (task_current(rq, p) && task_on_rq_queued(p)) {
+	if (task_current_selected(rq, p) && task_on_rq_queued(p)) {
 		prefetch_curr_exec_start(p);
 		update_rq_clock(rq);
 		p->sched_class->update_curr(rq);
@@ -5641,7 +5643,8 @@ void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq->curr;
+	/* accounting goes to the selected task */
+	struct task_struct *curr;
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
 	u64 resched_latency;
@@ -5652,6 +5655,7 @@ void scheduler_tick(void)
 	sched_clock_tick();
 
 	rq_lock(rq, &rf);
+	curr = rq_selected(rq);
 
 	update_rq_clock(rq);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
@@ -5742,6 +5746,13 @@ static void sched_tick_remote(struct work_struct *work)
 	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
+	/*
+	 * Since this is a remote tick for full dynticks mode, we are
+	 * always sure that there is no proxy (only a single task is
+	 * running).
+	 */
+	SCHED_WARN_ON(rq->curr != rq_selected(rq));
+
 	update_rq_clock(rq);
 
 	if (!is_idle_task(curr)) {
@@ -6672,6 +6683,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+	rq_set_selected(rq, next);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -7138,7 +7150,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 
 	prev_class = p->sched_class;
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flag);
 	if (running)
@@ -7226,7 +7238,7 @@ void set_user_nice(struct task_struct *p, long nice)
 		goto out_unlock;
 	}
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	if (running)
@@ -7797,7 +7809,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flags);
 	if (running)
@@ -9298,6 +9310,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	rcu_read_unlock();
 
 	rq->idle = idle;
+	rq_set_selected(rq, idle);
 	rcu_assign_pointer(rq->curr, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
@@ -9387,7 +9400,7 @@ void sched_setnuma(struct task_struct *p, int nid)
 
 	rq = task_rq_lock(p, &rf);
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE);
@@ -10514,7 +10527,7 @@ void sched_move_task(struct task_struct *tsk)
 
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
+	running = task_current_selected(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
 	if (queued)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9522e6607754..e8bca6b8da6f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1174,7 +1174,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 #endif
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
-	if (dl_task(rq->curr))
+	if (dl_task(rq_selected(rq)))
 		check_preempt_curr_dl(rq, p, 0);
 	else
 		resched_curr(rq);
@@ -1297,7 +1297,7 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
  */
 static void update_curr_dl(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_selected(rq);
 	struct sched_dl_entity *dl_se = &curr->dl;
 	s64 delta_exec, scaled_delta_exec;
 	int cpu = cpu_of(rq);
@@ -1810,7 +1810,7 @@ static int find_later_rq(struct task_struct *task);
 static int
 select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *selected;
 	bool select_rq;
 	struct rq *rq;
 
@@ -1821,6 +1821,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	selected = READ_ONCE(rq_selected(rq));
 
 	/*
 	 * If we are dealing with a -deadline task, we must
@@ -1831,9 +1832,9 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 	 * other hand, if it has a shorter deadline, we
 	 * try to make it stay here, it might be important.
 	 */
-	select_rq = unlikely(dl_task(curr)) &&
+	select_rq = unlikely(dl_task(selected)) &&
 		    (curr->nr_cpus_allowed < 2 ||
-		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
+		     !dl_entity_preempt(&p->dl, &selected->dl)) &&
 		    p->nr_cpus_allowed > 1;
 
 	/*
@@ -1896,7 +1897,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	 * let's hope p can move out.
 	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpudl_find(&rq->rd->cpudl, rq->curr, NULL))
+	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), NULL))
 		return;
 
 	/*
@@ -1935,7 +1936,7 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 				  int flags)
 {
-	if (dl_entity_preempt(&p->dl, &rq->curr->dl)) {
+	if (dl_entity_preempt(&p->dl, &rq_selected(rq)->dl)) {
 		resched_curr(rq);
 		return;
 	}
@@ -1945,7 +1946,7 @@ static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 	 * In the unlikely case current and p have the same deadline
 	 * let us try to decide what's the best thing to do...
 	 */
-	if ((p->dl.deadline == rq->curr->dl.deadline) &&
+	if ((p->dl.deadline == rq_selected(rq)->dl.deadline) &&
 	    !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
@@ -1980,7 +1981,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (hrtick_enabled_dl(rq))
 		start_hrtick_dl(rq, p);
 
-	if (rq->curr->sched_class != &dl_sched_class)
+	if (rq_selected(rq)->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	deadline_queue_push_tasks(rq);
@@ -2297,8 +2298,8 @@ static int push_dl_task(struct rq *rq)
 	 * can move away, it makes sense to just reschedule
 	 * without going further in pushing next_task.
 	 */
-	if (dl_task(rq->curr) &&
-	    dl_time_before(next_task->dl.deadline, rq->curr->dl.deadline) &&
+	if (dl_task(rq_selected(rq)) &&
+	    dl_time_before(next_task->dl.deadline, rq_selected(rq)->dl.deadline) &&
 	    rq->curr->nr_cpus_allowed > 1) {
 		resched_curr(rq);
 		return 0;
@@ -2423,7 +2424,7 @@ static void pull_dl_task(struct rq *this_rq)
 			 * deadline than the current task of its runqueue.
 			 */
 			if (dl_time_before(p->dl.deadline,
-					   src_rq->curr->dl.deadline))
+					   rq_selected(src_rq)->dl.deadline))
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2462,9 +2463,9 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 	if (!task_on_cpu(rq, p) &&
 	    !test_tsk_need_resched(rq->curr) &&
 	    p->nr_cpus_allowed > 1 &&
-	    dl_task(rq->curr) &&
+	    dl_task(rq_selected(rq)) &&
 	    (rq->curr->nr_cpus_allowed < 2 ||
-	     !dl_entity_preempt(&p->dl, &rq->curr->dl))) {
+	     !dl_entity_preempt(&p->dl, &rq_selected(rq)->dl))) {
 		push_dl_tasks(rq);
 	}
 }
@@ -2639,12 +2640,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (rq->curr != p) {
+	if (rq_selected(rq) != p) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
 			deadline_queue_push_tasks(rq);
 #endif
-		if (dl_task(rq->curr))
+		if (dl_task(rq_selected(rq)))
 			check_preempt_curr_dl(rq, p, 0);
 		else
 			resched_curr(rq);
@@ -2673,7 +2674,7 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	if (!rq->dl.overloaded)
 		deadline_queue_pull_task(rq);
 
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 		/*
 		 * If we now have a earlier deadline task than p,
 		 * then reschedule, provided p is still on this
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 80f74ec20fb8..808a91ba6a5e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -919,7 +919,7 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
  */
 s64 update_curr_common(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_selected(rq);
 	s64 delta_exec;
 
 	delta_exec = update_curr_se(rq, &curr->se);
@@ -964,7 +964,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 static void update_curr_fair(struct rq *rq)
 {
-	update_curr(cfs_rq_of(&rq->curr->se));
+	update_curr(cfs_rq_of(&rq_selected(rq)->se));
 }
 
 static inline void
@@ -6248,7 +6248,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
-			if (task_current(rq, p))
+			if (task_current_selected(rq, p))
 				resched_curr(rq);
 			return;
 		}
@@ -6263,7 +6263,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
  */
 static void hrtick_update(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_selected(rq);
 
 	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
 		return;
@@ -7957,7 +7957,7 @@ static void set_skip_buddy(struct sched_entity *se)
  */
 static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_flags)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_selected(rq);
 	struct sched_entity *se = &curr->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	int scale = cfs_rq->nr_running >= sched_nr_latency;
@@ -7991,7 +7991,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(rq->curr))
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
@@ -8990,7 +8990,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
 	 * DL and IRQ signals have been updated before updating CFS.
 	 */
-	curr_class = rq->curr->sched_class;
+	curr_class = rq_selected(rq)->sched_class;
 
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 
@@ -12239,7 +12239,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 * our priority decreased, or if we are not currently running on
 	 * this runqueue and our priority is higher than the current's
 	 */
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
 	} else
@@ -12384,7 +12384,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		 * kick off the schedule if running, otherwise just see
 		 * if we can still preempt the current task.
 		 */
-		if (task_current(rq, p))
+		if (task_current_selected(rq, p))
 			resched_curr(rq);
 		else
 			check_preempt_curr(rq, p, 0);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0d0b276c447d..6d9036547c1d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -574,7 +574,7 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 
 static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 {
-	struct task_struct *curr = rq_of_rt_rq(rt_rq)->curr;
+	struct task_struct *curr = rq_selected(rq_of_rt_rq(rt_rq));
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 	struct sched_rt_entity *rt_se;
 
@@ -1044,7 +1044,7 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
  */
 static void update_curr_rt(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_selected(rq);
 	struct sched_rt_entity *rt_se = &curr->rt;
 	s64 delta_exec;
 
@@ -1591,7 +1591,7 @@ static int find_lowest_rq(struct task_struct *task);
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *selected;
 	struct rq *rq;
 	bool test;
 
@@ -1603,6 +1603,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	selected = READ_ONCE(rq_selected(rq));
 
 	/*
 	 * If the current task on @p's runqueue is an RT task, then
@@ -1631,8 +1632,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	 * systems like big.LITTLE.
 	 */
 	test = curr &&
-	       unlikely(rt_task(curr)) &&
-	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
+	       unlikely(rt_task(selected)) &&
+	       (curr->nr_cpus_allowed < 2 || selected->prio <= p->prio);
 
 	if (test || !rt_task_fits_capacity(p, cpu)) {
 		int target = find_lowest_rq(p);
@@ -1662,12 +1663,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 {
-	/*
-	 * Current can't be migrated, useless to reschedule,
-	 * let's hope p can move out.
-	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpupri_find(&rq->rd->cpupri, rq->curr, NULL))
+	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), NULL))
 		return;
 
 	/*
@@ -1710,7 +1707,9 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
  */
 static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->prio < rq->curr->prio) {
+	struct task_struct *curr = rq_selected(rq);
+
+	if (p->prio < curr->prio) {
 		resched_curr(rq);
 		return;
 	}
@@ -1728,7 +1727,7 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
+	if (p->prio == curr->prio && !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_prio(rq, p);
 #endif
 }
@@ -1753,7 +1752,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	 * utilization. We only care of the case where we start to schedule a
 	 * rt task
 	 */
-	if (rq->curr->sched_class != &rt_sched_class)
+	if (rq_selected(rq)->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	rt_queue_push_tasks(rq);
@@ -2034,6 +2033,7 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
 
 	BUG_ON(rq->cpu != task_cpu(p));
 	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current_selected(rq, p));
 	BUG_ON(p->nr_cpus_allowed <= 1);
 
 	BUG_ON(!task_on_rq_queued(p));
@@ -2066,7 +2066,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
+	if (unlikely(next_task->prio < rq_selected(rq)->prio)) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2419,7 +2419,7 @@ static void pull_rt_task(struct rq *this_rq)
 			 * p if it is lower in priority than the
 			 * current task on the run queue
 			 */
-			if (p->prio < src_rq->curr->prio)
+			if (p->prio < rq_selected(src_rq)->prio)
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2461,9 +2461,9 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 	bool need_to_push = !task_on_cpu(rq, p) &&
 			    !test_tsk_need_resched(rq->curr) &&
 			    p->nr_cpus_allowed > 1 &&
-			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
+			    (dl_task(rq_selected(rq)) || rt_task(rq_selected(rq))) &&
 			    (rq->curr->nr_cpus_allowed < 2 ||
-			     rq->curr->prio <= p->prio);
+			     rq_selected(rq)->prio <= p->prio);
 
 	if (need_to_push)
 		push_rt_tasks(rq);
@@ -2547,7 +2547,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
+		if (p->prio < rq_selected(rq)->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2562,7 +2562,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * If our priority decreases while running, we
@@ -2588,7 +2588,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq->curr->prio)
+		if (p->prio < rq_selected(rq)->prio)
 			resched_curr(rq);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 95900ccaaf82..71d92e75cee0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1008,7 +1008,10 @@ struct rq {
 	 */
 	unsigned int		nr_uninterruptible;
 
-	struct task_struct __rcu	*curr;
+	struct task_struct __rcu	*curr;       /* Execution context */
+#ifdef CONFIG_PROXY_EXEC
+	struct task_struct __rcu	*curr_sched; /* Scheduling context (policy) */
+#endif
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -1207,6 +1210,22 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+#ifdef CONFIG_PROXY_EXEC
+#define rq_selected(rq)		((rq)->curr_sched)
+#define cpu_curr_selected(cpu)	(cpu_rq(cpu)->curr_sched)
+static inline void rq_set_selected(struct rq *rq, struct task_struct *t)
+{
+	rcu_assign_pointer(rq->curr_sched, t);
+}
+#else
+#define rq_selected(rq)		((rq)->curr)
+#define cpu_curr_selected(cpu)	(cpu_rq(cpu)->curr)
+static inline void rq_set_selected(struct rq *rq, struct task_struct *t)
+{
+	/* Do nothing */
+}
+#endif
+
 struct sched_group;
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
@@ -2106,11 +2125,25 @@ static inline u64 global_rt_runtime(void)
 	return (u64)sysctl_sched_rt_runtime * NSEC_PER_USEC;
 }
 
+/*
+ * Is p the current execution context?
+ */
 static inline int task_current(struct rq *rq, struct task_struct *p)
 {
 	return rq->curr == p;
 }
 
+/*
+ * Is p the current scheduling context?
+ *
+ * Note that it might be the current execution context at the same time if
+ * rq->curr == rq_selected() == p.
+ */
+static inline int task_current_selected(struct rq *rq, struct task_struct *p)
+{
+	return rq_selected(rq) == p;
+}
+
 #ifdef CONFIG_PROXY_EXEC
 static inline bool task_is_blocked(struct task_struct *p)
 {
@@ -2284,7 +2317,7 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq_selected(rq) != prev);
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
-- 
2.42.0.rc1.204.g551eb34607-goog

