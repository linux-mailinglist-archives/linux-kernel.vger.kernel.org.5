Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0457078179F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbjHSGKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245339AbjHSGKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:10:03 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B439B420F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:10:01 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-68893256397so2034554b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425401; x=1693030201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNgWUTWUrRQpNKYBpD/jRnlgkxMhVt3/MrrdiK3SLFc=;
        b=6DV1e6SMFkOI7W5odMDDDc9loykQVnfNta463i5wJGUDKStQR4J7rEH4Ryl+yLiKP9
         gyKMc5FeY6Hiz/xDqukGLEDnyX//YCoTRyyUFCQlha8Bx0HZ24BETAyIktZ6sYEG7Ju/
         tHbH1Kaf+2ZJCsWqfgQ2BdmRf/gcjgGLIXZmj4CJOdxEm/DLK+OShiXHfKSIRJnBBYzA
         t4L6ieu9iihbLiYcLMRQA1y7Zu9YrKK/uxltb6GvZB/Luh6i61RqtJwbPiNS226T76Sk
         LH+w/NamAeSrjbaBMOBOJPnHJpvd7ZpCxNhgi7jpp+FhlzOVkiA4r+eXjO1cKfFZ/sJ6
         8NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425401; x=1693030201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNgWUTWUrRQpNKYBpD/jRnlgkxMhVt3/MrrdiK3SLFc=;
        b=hVTMCDQZeI23r+6pEAdaflQffArh9kRNlKEN8F+s8Nx19LlYgUuFvj3N3yTaqyQJjp
         ssXPubVVEbTGVCCQEfbjTeIMKzd29NF1WgWFkKcBs0yHDd4eRqZIJEFhaKMLaJHVYkM4
         jGa5i5V+FmwcLXUayPSxJuMY31LnnJxFGTm3yZ5/idKWPGYRFfMdYhrU4Fwp9pixZYcB
         IIZch3wRJvkxxWwyj7xYwvybT7FgnZ6Yr1UYfsBFGJUIyaqpcY2vZXQQE2CCLX8g/mGg
         j3wwc+JIuBOIqialfdwi6iigrFZ0O74sDggzAeo3SFPpjFFX3POvwuseJbtw9f08OMV0
         d96g==
X-Gm-Message-State: AOJu0YzyKM9Dl91TGFKGdFkr0jpAJ2EjyK/CposoxO8VbEjtTEtE2Irz
        EovrPG/j8CbFVQQVAmYnJz2Dqoy9857A8G+gLRH63a5Tl3ikXnzS8Hgc3Et+EufETyiIlLMOI0+
        OouoqRJgo6w/zMRKa/pxxH2D8HQluR8hoHmJvarjV2myrc4+7jnOqqzoFueZeZHxfbVcKYqI=
X-Google-Smtp-Source: AGHT+IHPng1Ki6MYUp8txwEGUvDR17qAX9qfEhs0Gq5h+oMP9QqQfbQR1eIW/nvdfjF1bfv8RxMXwJdjc7kw
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:1702:b0:68a:2c24:57de with SMTP
 id h2-20020a056a00170200b0068a2c2457demr121958pfc.1.1692425400650; Fri, 18
 Aug 2023 23:10:00 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:52 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-19-jstultz@google.com>
Subject: [PATCH v5 18/19] sched: Handle blocked-waiter migration (and return migration)
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
 kernel/sched/core.c     | 184 ++++++++++++++++++++++++++++++++++++++--
 kernel/sched/deadline.c |   2 +-
 kernel/sched/fair.c     |   4 +-
 kernel/sched/rt.c       |  14 +--
 4 files changed, 190 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fd3494503be7..ab3b3a783ee9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2949,8 +2949,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
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
@@ -6623,6 +6630,142 @@ bool proxy_deactivate(struct rq *rq, struct task_struct *next)
 	return true;
 }
 
+static struct task_struct *
+proxy_migrate_task(struct rq *rq, struct task_struct *next,
+		   struct rq_flags *rf, struct task_struct *p,
+		   int that_cpu)
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
+	 * @owner can disappear, simply migrate to @that_cpu and leave that CPU
+	 * to sort things out.
+	 */
+
+	/*
+	 * Since we're going to drop @rq, we have to put(@next) first,
+	 * otherwise we have a reference that no longer belongs to us.  Use
+	 * @fake_task to fill the void and make the next pick_next_task()
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
+
+	wake_cpu = next->wake_cpu;
+
+	WARN_ON(next == rq->curr);
+
+	deactivate_task(rq, next, 0);
+	set_task_cpu(next, that_cpu);
+	/*
+	 * Preserve p->wake_cpu, such that we can tell where it
+	 * used to run later.
+	 */
+	next->wake_cpu = wake_cpu;
+
+	if (rq->balance_callback)
+		__balance_callbacks(rq);
+
+	rq_unpin_lock(rq, rf);
+	raw_spin_rq_unlock(rq);
+	raw_spin_rq_lock(that_rq);
+
+	activate_task(that_rq, next, 0);
+	check_preempt_curr(that_rq, next, 0);
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
+/*?*/			put_prev_task(rq, rq_selected(rq));
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
@@ -6645,7 +6788,8 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	struct task_struct *ret = NULL;
 	struct task_struct *p = next;
 	struct task_struct *owner = NULL;
-	int this_cpu;
+	bool curr_in_chain = false;
+	int this_cpu, that_cpu;
 	struct mutex *mutex;
 
 	this_cpu = cpu_of(rq);
@@ -6681,6 +6825,9 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 			return NULL;
 		}
 
+		if (task_current(rq, p))
+			curr_in_chain = true;
+
 		owner = __mutex_owner(mutex);
 		if (!owner) {
 			raw_spin_unlock(&p->blocked_lock);
@@ -6689,12 +6836,17 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
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
+			return proxy_migrate_task(rq, next, rf, p, that_cpu);
 		}
 
 		if (task_on_rq_migrating(owner)) {
@@ -6775,7 +6927,14 @@ static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next)
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
@@ -6898,6 +7057,14 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
@@ -6995,6 +7162,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
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
index 1d0c2cc4606a..00130a917da4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8112,7 +8112,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	if (!prev || prev->sched_class != &fair_sched_class)
+	if (!prev ||
+	    prev->sched_class != &fair_sched_class ||
+	    rq->curr != rq_selected(rq))
 		goto simple;
 
 	/*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index cfbf3925e595..7053b81580ca 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1538,8 +1538,8 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	enqueue_rt_entity(rt_se, flags);
 
 	/*
-	 * Current can't be pushed away. Selected is tied to current,
-	 * so don't push it either.
+	 * Current can't be pushed away. Proxy is tied to current, so don't
+	 * push it either.
 	 */
 	if (task_current(rq, p) || task_current_selected(rq, p))
 		return;
@@ -1549,6 +1549,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	if (p->nr_cpus_allowed == 1)
 		return;
 
+	if (task_is_blocked(p))
+		return;
+
 	enqueue_pushable_task(rq, p);
 }
 
@@ -1836,13 +1839,14 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 
-	/* Avoid marking selected as pushable */
-	if (task_current_selected(rq, p))
+	if (task_current(rq, p) || task_current_selected(rq, p))
 		return;
 
+	if (task_is_blocked(p))
+		return;
 	/*
 	 * The previous task needs to be made eligible for pushing
-	 * if it is still active
+	 * if it is still active.
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rq, p);
-- 
2.42.0.rc1.204.g551eb34607-goog

