Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B20C7E2D06
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjKFTh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjKFTgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:36:44 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F4019A0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:36:11 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-28016806be2so4049409a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299371; x=1699904171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/34a7T65q/i93pZLMFxfmu9n9gfJaq30v2OjoL4QEA=;
        b=z02nA1bb4+zRrhBFV3BPFW1Wd7iMvx0jSVo1tEU1fBo5Am00eOf5ks2/6rF729YcNv
         oekUN2MFs9GPqZAtBJDplxzMxG60MsMjIhi14NVP8W8FpQaxMe84Vsy3oI3/Mx/64EUp
         4fvkTc9j+7+/JvyVwOVMLkQGUWzQRBhOLMZkAVIAzOb+tEi29y6YOCQH2MzBxkHqZptJ
         hW/eSVXddjo950iL7QkkV8bSeqzhBkspZ6Iqemdqpb4OJY3H33elvMt1ZhjX3rw3lNJZ
         o8vhxJk3t1IZIB+wUSsQUpGXjBJHsxuNk2G9U0zq0yvvS8nKPeJcivjGtEDNUIsrZdC2
         1ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299371; x=1699904171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/34a7T65q/i93pZLMFxfmu9n9gfJaq30v2OjoL4QEA=;
        b=qjMpw8rIcmCYMufWCSTQkxYZ3cUwsPkICyI7QXxc2od+5OPolOZ4uL/JeTJy9jpubA
         aY07YPyVqepM2LstdDzaI2wT5t43pMih/OUbhdQHULIYRQItnE7fpyd779DSZ9/EQV3Q
         jJVeoGnNu2VeoQbODDXm6DrhmGRGi/mks/ZlLSJKtxTjkhupyFVkqDit4jnRJTXDIduE
         oA4YdW6h2rBkryaVMl4CjgM+xiDi3yWfTFfU9eJv0lgIKISrY7U9DE9VyQj/NFshCyR+
         /+6VTQWAuANMb7h8OVCj6n4l2sS7ld9r8LctS3WWwTcCaS3BJVs9qoLj3vtMY4rEabgL
         JIgw==
X-Gm-Message-State: AOJu0YxjPFaHeKlS10QiBgGlA3HusNomDp2uWBFNtNC41BWLa4584SqL
        /SYCCodFuErjKZVvV62p/wy0K6NGSbLDaa5N0RjbdSb/nIwUynzVX9MK55bKteI0NPVFAfqiPzP
        9LBzliUJ8rjACv7r2MIYugoLLfZ9ZfVF59VtZA00rx6u6c7t+yA9ZP56nTq/tlwezYI6QloQ=
X-Google-Smtp-Source: AGHT+IGgzYmPIY2EvqG2W1YPDa6SUZJKDYVdWSS02IGuXugANtR8YZqg7XLXRSEtZRsXRNYcXmojkSHvd8MX
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:c095:b0:280:54e3:cc69 with SMTP id
 o21-20020a17090ac09500b0028054e3cc69mr12004pjs.3.1699299370218; Mon, 06 Nov
 2023 11:36:10 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:35:00 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-18-jstultz@google.com>
Subject: [PATCH v6 17/20] sched: Start blocked_on chain processing in proxy()
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
        Valentin Schneider <valentin.schneider@arm.com>,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
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

From: Peter Zijlstra <peterz@infradead.org>

Start to flesh out the real proxy() implementation, but
avoid the migration cases for now, in those cases just
deactivate the selected task and pick again.

To ensure the selected task or other blocked tasks in
the chain aren't migrated away while we're running the
proxy, this patch also tweaks CFS logic to avoid migrating
selected or mutex blocked tasks.

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
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: This change was split out from the larger proxy patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split this out from larger proxy patch
---
 kernel/sched/core.c | 162 ++++++++++++++++++++++++++++++++++++--------
 kernel/sched/fair.c |  10 ++-
 2 files changed, 143 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c148ee5dcf7e..c7b5cb5d8dc3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -95,6 +95,7 @@
 #include "../workqueue_internal.h"
 #include "../../io_uring/io-wq.h"
 #include "../smpboot.h"
+#include "../locking/mutex.h"
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpu);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpumask);
@@ -6613,6 +6614,15 @@ static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
 
 #ifdef CONFIG_PROXY_EXEC
 
+static inline struct task_struct *
+proxy_resched_idle(struct rq *rq, struct task_struct *next)
+{
+	put_prev_task(rq, next);
+	rq_set_selected(rq, rq->idle);
+	set_tsk_need_resched(rq->idle);
+	return rq->idle;
+}
+
 bool proxy_deactivate(struct rq *rq, struct task_struct *next)
 {
 	unsigned long state = READ_ONCE(next->__state);
@@ -6622,52 +6632,146 @@ bool proxy_deactivate(struct rq *rq, struct task_struct *next)
 		return false;
 	if (!try_to_deactivate_task(rq, next, state, true))
 		return false;
-	put_prev_task(rq, next);
-	rq_set_selected(rq, rq->idle);
-	resched_curr(rq);
+	proxy_resched_idle(rq, next);
 	return true;
 }
 
 /*
- * Initial simple proxy that just returns the task if its waking
- * or deactivates the blocked task so we can pick something that
- * isn't blocked.
+ * Find who @next (currently blocked on a mutex) can proxy for.
+ *
+ * Follow the blocked-on relation:
+ *   task->blocked_on -> mutex->owner -> task...
+ *
+ * Lock order:
+ *
+ *   p->pi_lock
+ *     rq->lock
+ *       mutex->wait_lock
+ *         p->blocked_lock
+ *
+ * Returns the task that is going to be used as execution context (the one
+ * that is actually going to be put to run on cpu_of(rq)).
  */
 static struct task_struct *
 proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
 	struct task_struct *ret = NULL;
 	struct task_struct *p = next;
+	struct task_struct *owner = NULL;
+	int this_cpu;
 	struct mutex *mutex;
-	mutex = p->blocked_on;
-	/* Something changed in the chain, pick_again */
-	if (!mutex)
-		return NULL;
+
+	this_cpu = cpu_of(rq);
+
 	/*
-	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
-	 * and ensure @owner sticks around.
+	 * Follow blocked_on chain.
+	 *
+	 * TODO: deadlock detection
 	 */
-	raw_spin_lock(&mutex->wait_lock);
-	raw_spin_lock(&p->blocked_lock);
+	for (p = next; task_is_blocked(p); p = owner) {
+		mutex = p->blocked_on;
+		/* Something changed in the chain, pick_again */
+		if (!mutex)
+			return NULL;
 
-	/* Check again that p is blocked with blocked_lock held */
-	if (!task_is_blocked(p) || mutex != p->blocked_on) {
 		/*
-		 * Something changed in the blocked_on chain and
-		 * we don't know if only at this level. So, let's
-		 * just bail out completely and let __schedule
-		 * figure things out (pick_again loop).
+		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
+		 * and ensure @owner sticks around.
+		 */
+		raw_spin_lock(&mutex->wait_lock);
+		raw_spin_lock(&p->blocked_lock);
+
+		/* Check again that p is blocked with blocked_lock held */
+		if (mutex != p->blocked_on) {
+			/*
+			 * Something changed in the blocked_on chain and
+			 * we don't know if only at this level. So, let's
+			 * just bail out completely and let __schedule
+			 * figure things out (pick_again loop).
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return NULL;
+		}
+
+		owner = __mutex_owner(mutex);
+		if (!owner) {
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return p;
+		}
+
+		if (task_cpu(owner) != this_cpu) {
+			/* XXX Don't handle migrations yet */
+			if (!proxy_deactivate(rq, next))
+				ret = next;
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return ret;
+		}
+
+		if (task_on_rq_migrating(owner)) {
+			/*
+			 * One of the chain of mutex owners is currently migrating to this
+			 * CPU, but has not yet been enqueued because we are holding the
+			 * rq lock. As a simple solution, just schedule rq->idle to give
+			 * the migration a chance to complete. Much like the migrate_task
+			 * case we should end up back in proxy(), this time hopefully with
+			 * all relevant tasks already enqueued.
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return proxy_resched_idle(rq, next);
+		}
+
+		if (!owner->on_rq) {
+			/* XXX Don't handle blocked owners yet */
+			if (!proxy_deactivate(rq, next))
+				ret = next;
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return ret;
+		}
+
+		if (owner == p) {
+			/*
+			 * Its possible we interleave with mutex_unlock like:
+			 *
+			 *				lock(&rq->lock);
+			 *				  proxy()
+			 * mutex_unlock()
+			 *   lock(&wait_lock);
+			 *   next(owner) = current->blocked_donor;
+			 *   unlock(&wait_lock);
+			 *
+			 *   wake_up_q();
+			 *     ...
+			 *       ttwu_runnable()
+			 *         __task_rq_lock()
+			 *				  lock(&wait_lock);
+			 *				  owner == p
+			 *
+			 * Which leaves us to finish the ttwu_runnable() and make it go.
+			 *
+			 * So schedule rq->idle so that ttwu_runnable can get the rq lock
+			 * and mark owner as running.
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return proxy_resched_idle(rq, next);
+		}
+
+		/*
+		 * OK, now we're absolutely sure @owner is not blocked _and_
+		 * on this rq, therefore holding @rq->lock is sufficient to
+		 * guarantee its existence, as per ttwu_remote().
 		 */
 		raw_spin_unlock(&p->blocked_lock);
 		raw_spin_unlock(&mutex->wait_lock);
-		return ret;
 	}
 
-	if (!proxy_deactivate(rq, next))
-		ret = p;
-	raw_spin_unlock(&p->blocked_lock);
-	raw_spin_unlock(&mutex->wait_lock);
-	return ret;
+	WARN_ON_ONCE(owner && !owner->on_rq);
+	return owner;
 }
 
 static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next)
@@ -6742,6 +6846,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
+	bool preserve_need_resched = false;
 
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
@@ -6801,9 +6906,12 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 			rq_repin_lock(rq, &rf);
 			goto pick_again;
 		}
+		if (next == rq->idle && prev == rq->idle)
+			preserve_need_resched = true;
 	}
 
-	clear_tsk_need_resched(prev);
+	if (!preserve_need_resched)
+		clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
 	rq->last_seen_need_resched_ns = 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1aca675985b2..f334b129b269 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8752,7 +8752,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/* Disregard pcpu kthreads; they are where they need to be. */
 	if (kthread_is_per_cpu(p))
 		return 0;
-
+	if (task_is_blocked(p))
+		return 0;
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
@@ -8789,7 +8790,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/* Record that we found at least one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-	if (task_on_cpu(env->src_rq, p)) {
+	if (task_on_cpu(env->src_rq, p) ||
+	    task_current_selected(env->src_rq, p)) {
 		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
@@ -8828,6 +8830,10 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 {
 	lockdep_assert_rq_held(env->src_rq);
 
+	BUG_ON(task_is_blocked(p));
+	BUG_ON(task_current(env->src_rq, p));
+	BUG_ON(task_current_selected(env->src_rq, p));
+
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, env->dst_cpu);
 }
-- 
2.42.0.869.gea05f2083d-goog

