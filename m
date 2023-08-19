Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D278179E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbjHSGKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245330AbjHSGKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:10:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF7D420E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:10:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840ea40c59so23668967b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425399; x=1693030199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2eXKGIOPTG4WKBBPdhJq7QHtWiYQlL25GRYTqoo55tc=;
        b=VjgkVCsRAVgQOmbXsYUwqb/LOh6uJnRp+4gg4NZpOrAc8UJ7oImDatcohb471h1hKJ
         WXy9ptz9+E4BJeZlXcU/6r6/FpXfslgzs2CcUwTqRBTRAnbib8cdOLleFGA0TaAbcCyX
         TT85fmpvj0JctoWzR13VYLiGu+GfynK90IYSxPnrbNVG7fossGxGKTXzgrFrMHRzy4b+
         PzldXghmkap8DEQj1fr1/pmcRF++dWQjzRUeM45nuMQq7df3SxIj2nQ2gNQmu+RqpcOU
         MpLiDBTghfbofwEjZscQfdgr9+yZLq8A2XKRCms200bPiu19z0QcMESkGQhYHuxh2Nng
         bDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425399; x=1693030199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eXKGIOPTG4WKBBPdhJq7QHtWiYQlL25GRYTqoo55tc=;
        b=I4INPurwmd/Gw7zdX8wPSXXFt8Kxv0IIAxbqZKSNE5gNyiwPi8x7hX4JuNl7PykcUx
         dso3v4cFD8w+pbzK8w2LbsX0h7omUHVL61gwzyIeQ8g+watSpZJPtNxtkt+X3YG3/93U
         kG+LklZMpwa9ibCDqwh4j0a+ZpMmxS0hZHUvePn6MtKzKKSml8GvXpWHWu6ELdXPva5K
         Mq5rp5fAf5PbVkPMlai6pdEdP2KJU0gs/1VI/m0VteIdBe6gmTOLlO9Pl1sAfcBUbC7E
         SuaWQT+UGQMhBEDuhZVq6FvdkfVcUsitaTVaWyYKsf9fN6ZM6/Bx0w+zlznLtFSnoqzk
         iG+A==
X-Gm-Message-State: AOJu0YwP2gFTP8C1gA37raCZO0SS7/D1ROIYF+fbamgOUFyPltQVE+jf
        11g6UBANrhHlsZHmhOcO7qXktKMWuQ8e1O+DM+Y8bpXTf0d+Ida1RsIJ7MXvCL49OtBEws5v3Zn
        xIh3JJdqQ0ET7Hh2k3UfoJ19vNUDLXL+dnf8OAAovS3l97d33vBIc0+Gti7QcxK6gjgf3Ono=
X-Google-Smtp-Source: AGHT+IGH/4tsGTtEhJSmBJphNsOFAQA/4RwaJ+iIyOf62dKKl10Uv4rfjM1ngSDxpG8sdgN5ZrOK+eL9Rw9y
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:af0c:0:b0:589:a997:f9ce with SMTP id
 n12-20020a81af0c000000b00589a997f9cemr11088ywh.2.1692425399007; Fri, 18 Aug
 2023 23:09:59 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:51 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-18-jstultz@google.com>
Subject: [PATCH v5 17/19] sched: Start blocked_on chain processing in proxy()
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index e8065fc5c894..fd3494503be7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -95,6 +95,7 @@
 #include "../workqueue_internal.h"
 #include "../../io_uring/io-wq.h"
 #include "../smpboot.h"
+#include "../locking/mutex.h"
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpu);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpumask);
@@ -6600,6 +6601,15 @@ bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
 
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
@@ -6609,52 +6619,146 @@ bool proxy_deactivate(struct rq *rq, struct task_struct *next)
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
@@ -6730,6 +6834,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	struct rq *rq;
 	bool proxied;
 	int cpu;
+	bool preserve_need_resched = false;
 
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
@@ -6790,9 +6895,12 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
index 6385693f1da6..1d0c2cc4606a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8643,7 +8643,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/* Disregard pcpu kthreads; they are where they need to be. */
 	if (kthread_is_per_cpu(p))
 		return 0;
-
+	if (task_is_blocked(p))
+		return 0;
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
@@ -8680,7 +8681,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/* Record that we found at least one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-	if (task_on_cpu(env->src_rq, p)) {
+	if (task_on_cpu(env->src_rq, p) ||
+	    task_current_selected(env->src_rq, p)) {
 		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
@@ -8719,6 +8721,10 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
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
2.42.0.rc1.204.g551eb34607-goog

