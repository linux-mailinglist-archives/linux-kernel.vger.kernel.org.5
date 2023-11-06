Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D117E2D07
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjKFTha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjKFTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:36:45 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E261FCF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:36:13 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b806e55dd2so3985459a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299372; x=1699904172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DYYMf6B/BOOOjO8wB1W8MvY0mQJzjw6qeErHpWe9lQ=;
        b=0AewwAz3/yOAYQxEC99x6ZKQnvgKn3O7JiBVIm+Sg1ha4mF8dRDdRn+WnMDT+xqpPA
         vd7F8v0p+KqDLlWHkewD4BVX1ncsdz+EtWohDFP9f/6dJLJPBuE0SOrTvb2w2isbpaVO
         RjlQ26uF9nFc3QcvXwHd/msqMeekXU+HEP8gBz70yBYnMlp+/ZJqh08Rx0Jfy6FnMUxt
         grfUBbj97pseMB8UYuPKwzSwe4PKtNuc5JFnVBtVT77YUbCaxKjNfc7oHSEcLkpZ1Zeg
         yjrr4NZoT2yWvQNZWJL3m304PU/aRv3bXhZQ3bfonXtAU5uUibsGMYXAO03QlkiZSx6B
         CZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299372; x=1699904172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DYYMf6B/BOOOjO8wB1W8MvY0mQJzjw6qeErHpWe9lQ=;
        b=JjU/EmLG6nY5W6Yawqm0WDLD/MVhxycehArMkazuG7r1byDNBQ7rh49YFyRU7Y133w
         TStQ/5v0alFXdtMOjgieNp5hOgXV0aLxRARl1IPdPF74tqM2/FMxuRnP29EB/ftSQhKe
         dHd2WyASLRciRljnq7AydGHna+E3ZU4c8zPjC4606KYdsSoJJiS4RBCHKyav5PYLwsgx
         H1ak+AwgBGAMiOPWVGYGlgODIZfz6O7CECncBsPIo97NzmjuFzD8OjIW4AX9o3aT02mX
         RAgbjrFYpycu8hF45nkgMoqXztmVNj5PP7IyDwkosJLygi7fiikRls44I8Zj5MOHNpd2
         dxEA==
X-Gm-Message-State: AOJu0YwRqCrfc2Ci+yOoyNoQJ1nFoZI/lcOBtvdIIgAgn7V091PK0KL8
        YYFVpHWgPnvaIdjz5PR5zlB8swZcw+UD1n62xVCir4pOSTKfeajVp2vvixV04GjwfGZw3EhZfFb
        K4FvdkPgTsgCdur08gOki1eei1s0jTo8kb1ycm3eyv07oimeQU6DcovJSMnuxY5Y2VEoLYE8=
X-Google-Smtp-Source: AGHT+IGdjfZwcTvITXfl+E+YXXt+S9v5v7Cw0MbAfVZk/9aHyf9v1d14/97VhvSIBSvP8zTMhHtBrxInVVG6
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:7985:0:b0:5b3:da50:ac28 with SMTP id
 u127-20020a637985000000b005b3da50ac28mr567674pgc.5.1699299372106; Mon, 06 Nov
 2023 11:36:12 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:35:01 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-19-jstultz@google.com>
Subject: [PATCH v6 18/20] sched: Handle blocked-waiter migration (and return migration)
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add logic to handle migrating a blocked waiter to a remote
cpu where the lock owner is runnable.

Additionally, as the blocked task may not be able to run
on the remote cpu, add logic to handle return migration once
the waiting task is given the mutex.

Because tasks may get migrated to where they cannot run,
this patch also modifies the scheduling classes to avoid
sched class migrations on mutex blocked tasks, leaving
proxy() to do the migrations and return migrations.

This was split out from the larger proxy patch, and
significantly reworked to avoid changes to the try_to_wakeup()
call path.

Credits for the original patch go to:
  Peter Zijlstra (Intel) <peterz@infradead.org>
  Juri Lelli <juri.lelli@redhat.com>
  Valentin Schneider <valentin.schneider@arm.com>
  Connor O'Brien <connoro@google.com>

NOTE: The return migration is further complicated in that we
need to take the pi_lock in order to decide which cpu we should
migrate back to. This requires dropping the current rq lock,
grabbing the pi_lock re-taking the current rq lock, picking a
cpu, deactivating the task, switching its cpu, dropping the
current rq lock, grabbing the target rq, activating the task
and then dropping the target rq and reaquiring the current
rq. This seems overly complex, so suggestions for a better
approach would be welcome!

TODO: Seeing stalls/hangs after running for awhile with this
patch, which suggests we're losing track of a task somewhere
in the migrations.
[  880.032744] BUG: workqueue lockup - pool cpus=11 node=0 flags=0x0 nice=0 stuck for 58s!
...
[ 1443.185762] watchdog: BUG: soft lockup - CPU#11 stuck for 23s! [irqbalance:1880]
...

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
Signed-off-by: John Stultz <jstultz@google.com>
---
v6:
* Integrated sched_proxy_exec() check in proxy_return_migration()
* Minor cleanups to diff
* Unpin the rq before calling __balance_callbacks()
* Tweak proxy migrate to migrate deeper task in chain, to avoid
  tasks pingponging between rqs
---
 kernel/sched/core.c     | 183 ++++++++++++++++++++++++++++++++++++++--
 kernel/sched/deadline.c |   2 +-
 kernel/sched/fair.c     |   4 +-
 kernel/sched/rt.c       |   9 +-
 4 files changed, 187 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c7b5cb5d8dc3..760e2753a24c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3000,8 +3000,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
 	bool stop_pending, complete = false;
 
-	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+	/*
+	 * Can the task run on the task's current CPU? If so, we're done
+	 *
+	 * We are also done if the task is selected, boosting a lock-
+	 * holding proxy, (and potentially has been migrated outside its
+	 * current or previous affinity mask)
+	 */
+	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
+	    (task_current_selected(rq, p) && !task_current(rq, p))) {
 		struct task_struct *push_task = NULL;
 
 		if ((flags & SCA_MIGRATE_ENABLE) &&
@@ -6636,6 +6643,141 @@ bool proxy_deactivate(struct rq *rq, struct task_struct *next)
 	return true;
 }
 
+static struct task_struct *
+proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
+		   struct task_struct *p, int that_cpu)
+{
+	struct rq *that_rq;
+	int wake_cpu;
+
+	/*
+	 * If the blocked-on relationship crosses CPUs, migrate @p to the
+	 * @owner's CPU.
+	 *
+	 * This is because we must respect the CPU affinity of execution
+	 * contexts (@owner) but we can ignore affinity for scheduling
+	 * contexts (@p). So we have to move scheduling contexts towards
+	 * potential execution contexts.
+	 */
+	that_rq = cpu_rq(that_cpu);
+
+	/*
+	 * @owner can disappear, but simply migrate to @that_cpu and leave
+	 * that CPU to sort things out.
+	 */
+
+	/*
+	 * Since we're going to drop @rq, we have to put(@rq_selected) first,
+	 * otherwise we have a reference that no longer belongs to us. Use
+	 * @rq->idle to fill the void and make the next pick_next_task()
+	 * invocation happy.
+	 *
+	 * CPU0				CPU1
+	 *
+	 *				B mutex_lock(X)
+	 *
+	 * A mutex_lock(X) <- B
+	 * A __schedule()
+	 * A pick->A
+	 * A proxy->B
+	 * A migrate A to CPU1
+	 *				B mutex_unlock(X) -> A
+	 *				B __schedule()
+	 *				B pick->A
+	 *				B switch_to (A)
+	 *				A ... does stuff
+	 * A ... is still running here
+	 *
+	 *		* BOOM *
+	 */
+	put_prev_task(rq, rq_selected(rq));
+	rq_set_selected(rq, rq->idle);
+	set_next_task(rq, rq_selected(rq));
+	WARN_ON(p == rq->curr);
+
+	wake_cpu = p->wake_cpu;
+	deactivate_task(rq, p, 0);
+	set_task_cpu(p, that_cpu);
+	/*
+	 * Preserve p->wake_cpu, such that we can tell where it
+	 * used to run later.
+	 */
+	p->wake_cpu = wake_cpu;
+
+	rq_unpin_lock(rq, rf);
+	__balance_callbacks(rq);
+
+	raw_spin_rq_unlock(rq);
+	raw_spin_rq_lock(that_rq);
+
+	activate_task(that_rq, p, 0);
+	check_preempt_curr(that_rq, p, 0);
+
+	raw_spin_rq_unlock(that_rq);
+	raw_spin_rq_lock(rq);
+	rq_repin_lock(rq, rf);
+
+	return NULL; /* Retry task selection on _this_ CPU. */
+}
+
+static inline bool proxy_return_migration(struct rq *rq, struct rq_flags *rf,
+					  struct task_struct *next)
+{
+	if (!sched_proxy_exec())
+		return false;
+
+	if (next->blocked_on && next->blocked_on_waking) {
+		if (!is_cpu_allowed(next, cpu_of(rq))) {
+			struct rq *that_rq;
+			int cpu;
+
+			if (next == rq->curr) {
+				/* can't migrate curr, so return and let caller sort it */
+				return true;
+			}
+
+			put_prev_task(rq, rq_selected(rq));
+			rq_set_selected(rq, rq->idle);
+
+			/* First unpin & run balance callbacks */
+			rq_unpin_lock(rq, rf);
+			__balance_callbacks(rq);
+			/*
+			 * Drop the rq lock so we can get pi_lock,
+			 * then reaquire it again to figure out
+			 * where to send it.
+			 */
+			raw_spin_rq_unlock(rq);
+			raw_spin_lock(&next->pi_lock);
+			rq_lock(rq, rf);
+
+			cpu = select_task_rq(next, next->wake_cpu, WF_TTWU);
+
+			deactivate_task(rq, next, 0);
+			set_task_cpu(next, cpu);
+			that_rq = cpu_rq(cpu);
+
+			/* drop this rq lock and grab that_rq's */
+			rq_unpin_lock(rq, rf);
+			raw_spin_rq_unlock(rq);
+			raw_spin_rq_lock(that_rq);
+
+			activate_task(that_rq, next, 0);
+			check_preempt_curr(that_rq, next, 0);
+
+			/* drop that_rq's lock and re-grab this' */
+			raw_spin_rq_unlock(that_rq);
+			raw_spin_rq_lock(rq);
+			rq_repin_lock(rq, rf);
+
+			raw_spin_unlock(&next->pi_lock);
+
+			return true;
+		}
+	}
+	return false;
+}
+
 /*
  * Find who @next (currently blocked on a mutex) can proxy for.
  *
@@ -6658,7 +6800,8 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	struct task_struct *ret = NULL;
 	struct task_struct *p = next;
 	struct task_struct *owner = NULL;
-	int this_cpu;
+	bool curr_in_chain = false;
+	int this_cpu, that_cpu;
 	struct mutex *mutex;
 
 	this_cpu = cpu_of(rq);
@@ -6694,6 +6837,9 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 			return NULL;
 		}
 
+		if (task_current(rq, p))
+			curr_in_chain = true;
+
 		owner = __mutex_owner(mutex);
 		if (!owner) {
 			raw_spin_unlock(&p->blocked_lock);
@@ -6702,12 +6848,17 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		}
 
 		if (task_cpu(owner) != this_cpu) {
-			/* XXX Don't handle migrations yet */
-			if (!proxy_deactivate(rq, next))
-				ret = next;
+			that_cpu = task_cpu(owner);
+			/*
+			 * @owner can disappear, simply migrate to @that_cpu and leave that CPU
+			 * to sort things out.
+			 */
 			raw_spin_unlock(&p->blocked_lock);
 			raw_spin_unlock(&mutex->wait_lock);
-			return ret;
+			if (curr_in_chain)
+				return proxy_resched_idle(rq, next);
+
+			return proxy_migrate_task(rq, rf, p, that_cpu);
 		}
 
 		if (task_on_rq_migrating(owner)) {
@@ -6788,7 +6939,14 @@ static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next)
 	dequeue_task(rq, next, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
 	enqueue_task(rq, next, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
 }
+
 #else /* PROXY_EXEC */
+static inline bool proxy_return_migration(struct rq *rq, struct rq_flags *rf,
+					  struct task_struct *next)
+{
+	return false;
+}
+
 static struct task_struct *
 proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
@@ -6909,6 +7067,14 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		if (next == rq->idle && prev == rq->idle)
 			preserve_need_resched = true;
 	}
+	if (unlikely(proxy_return_migration(rq, &rf, next))) {
+		if (next != rq->curr)
+			goto pick_again;
+
+		rq_set_selected(rq, rq->idle);
+		set_tsk_need_resched(rq->idle);
+		next = rq->idle;
+	}
 
 	if (!preserve_need_resched)
 		clear_tsk_need_resched(prev);
@@ -7006,6 +7172,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 */
 	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
 
+	if (task_is_blocked(tsk))
+		return;
+
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e8bca6b8da6f..99788cfd8835 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1731,7 +1731,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_dl_entity(&p->dl, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 && !task_is_blocked(p))
 		enqueue_pushable_dl_task(rq, p);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f334b129b269..f2dee89f475b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8220,7 +8220,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (!prev || prev->sched_class != &fair_sched_class)
+	if (!prev ||
+	    prev->sched_class != &fair_sched_class ||
+	    rq->curr != rq_selected(rq))
 		goto simple;
 
 	/*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0125a3ae5a7a..d4f5625e4433 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1549,6 +1549,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	if (p->nr_cpus_allowed == 1)
 		return;
 
+	if (task_is_blocked(p))
+		return;
+
 	enqueue_pushable_task(rq, p);
 }
 
@@ -1836,10 +1839,12 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 
-	/* Avoid marking selected as pushable */
-	if (task_current_selected(rq, p))
+	/* Avoid marking current or selected as pushable */
+	if (task_current(rq, p) || task_current_selected(rq, p))
 		return;
 
+	if (task_is_blocked(p))
+		return;
 	/*
 	 * The previous task needs to be made eligible for pushing
 	 * if it is still active
-- 
2.42.0.869.gea05f2083d-goog

