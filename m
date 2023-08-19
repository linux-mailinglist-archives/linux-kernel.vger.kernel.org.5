Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3830D781791
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbjHSGK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245378AbjHSGKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:10:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F45422A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58419550c3aso25848517b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425394; x=1693030194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qC3vk56gRknF3fOaEKF795ZsBfdlq95wET1mxzdE7Mc=;
        b=g6GB3juRYLx+m9aJECt4rR+KJfQHwue08PBPzqoJCw1mhxOdrXu9BHJVTdCwKf60zm
         6YfglGIIPI55k9eKKoLKk2JvN2zTnXbZ9ZVXWth9YzAhbUJ9wqqyXtGpb5JJKMasZOYs
         rNEz4iYOVLVxbTwr6VD2crtnCPp3bU5h9Oa3wj2K13ISZVxTWZGIj1LQIIyugOw2AUT1
         2A0JSVe7FROYC+Gnt3TtaaJmOhpDBWKx3j5iJOUQCyss0/faHsarDPP2Jmu0Vck1mFKy
         M24VkEP3TSCuLQKF/hykmHcnKIVXXe41dE1+QSATR3htYC4xijBwl5IL4WAzsiQTCcya
         DLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425394; x=1693030194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qC3vk56gRknF3fOaEKF795ZsBfdlq95wET1mxzdE7Mc=;
        b=PZi+/1C6pJ65e2902T8k8orvP0qTrqW2rRQr5gf1oUCcuBAT7b62VPCeBl71smvYRU
         E1IzKc5VsjbVI5/k9zywPz4dIOtkS5sqGaRsyJgwomQB8CH6/f9XE0XN5rmqe+MG72aF
         8GXjORwqwzn6GRiImrU5I88MY1n3iX2wbA7oAPOts3QZdHaNYOs0VW2m9P3V9WeghozQ
         h9hGlmGdJFKWV9vn1sqKITREvG2rKJczXe+ey3D+cX/Ua4NeKiMqeJt7t5IqqndSOT7O
         jneXE44KO5vIwTlnM1U8xno9cnjGs6KY6mPVvaqYT7Hqd+8h8lQz4YnbIKGsYDtoj/tm
         fRrQ==
X-Gm-Message-State: AOJu0YwmIL5b5QPRnbGaJYkqVwBoTf/T25VWUQ/4tSqSlxaOEoSj75+v
        9Z1vwEs576t5y3uZwlgmVQkVHlkEpcK6vmBBd1n9eY0Ne4jLVNGw04sXl5o2W/apZeDqFiE2BtB
        Bnp0+3VGI35Xtqx4P3FB96nYIomr/DBMrfjrS5sKz6nHDafcu/aUyCe7SoUsFh/GruFdfKpA=
X-Google-Smtp-Source: AGHT+IG54fVgG3cLOBgFmJu9aidURXuvCHgUqMat+j6i+tExtG4vwXEyW61UJu1714RKPCWfItFvVITB4ZaU
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:b65c:0:b0:583:a8dc:1165 with SMTP id
 h28-20020a81b65c000000b00583a8dc1165mr11773ywk.10.1692425393585; Fri, 18 Aug
 2023 23:09:53 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:48 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-15-jstultz@google.com>
Subject: [PATCH v5 14/19] sched: Add a very simple proxy() function
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

This adds a very simple proxy() function so if
we select a blocked task to run, we will deactivate it
and pick again. The exception being if it has become
unblocked after proxy() was called.

Greatly simplified from patch by:
  Peter Zijlstra (Intel) <peterz@infradead.org>
  Juri Lelli <juri.lelli@redhat.com>
  Valentin Schneider <valentin.schneider@arm.com>
  Connor O'Brien <connoro@google.com>

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
[jstultz: Split out from larger proxy patch and simplified
 for review and testing.]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split out from larger proxy patch
---
 kernel/sched/core.c | 89 +++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/rt.c   | 19 +++++++++-
 2 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 76a42f21dda7..72d0803c7d47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6562,11 +6562,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 # define SM_MASK_PREEMPT	SM_PREEMPT
 #endif
 
-bool try_to_deactivate_task(struct rq *rq, struct task_struct *p, unsigned long state)
+bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
+			    unsigned long state, bool deactivate_cond)
 {
 	if (signal_pending_state(state, p)) {
 		WRITE_ONCE(p->__state, TASK_RUNNING);
-	} else {
+	} else if (deactivate_cond) {
 		p->sched_contributes_to_load =
 			(state & TASK_UNINTERRUPTIBLE) &&
 			!(state & TASK_NOLOAD) &&
@@ -6597,6 +6598,74 @@ bool try_to_deactivate_task(struct rq *rq, struct task_struct *p, unsigned long
 	return false;
 }
 
+#ifdef CONFIG_PROXY_EXEC
+/*
+ * Initial simple proxy that just returns the task if its waking
+ * or deactivates the blocked task so we can pick something that
+ * isn't blocked.
+ */
+static struct task_struct *
+proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
+{
+	struct task_struct *p = next;
+	struct mutex *mutex;
+	unsigned long state;
+
+	mutex = p->blocked_on;
+	/* Something changed in the chain, pick_again */
+	if (!mutex)
+		return NULL;
+	/*
+	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
+	 * and ensure @owner sticks around.
+	 */
+	raw_spin_lock(&mutex->wait_lock);
+	raw_spin_lock(&p->blocked_lock);
+
+	/* Check again that p is blocked with blocked_lock held */
+	if (!task_is_blocked(p) || mutex != p->blocked_on) {
+		/*
+		 * Something changed in the blocked_on chain and
+		 * we don't know if only at this level. So, let's
+		 * just bail out completely and let __schedule
+		 * figure things out (pick_again loop).
+		 */
+		raw_spin_unlock(&p->blocked_lock);
+		raw_spin_unlock(&mutex->wait_lock);
+		return NULL;
+	}
+
+	state = READ_ONCE(p->__state);
+	/* Don't deactivate if the state has been changed to TASK_RUNNING */
+	if (!state) {
+		raw_spin_unlock(&p->blocked_lock);
+		raw_spin_unlock(&mutex->wait_lock);
+		return p;
+	}
+
+	try_to_deactivate_task(rq, next, state, true);
+
+	/*
+	 * If next is the selected task, then remove lingering
+	 * references to it from rq and sched_class structs after
+	 * dequeueing.
+	 */
+	put_prev_task(rq, next);
+	rq_set_selected(rq, rq->idle);
+	resched_curr(rq);
+	raw_spin_unlock(&p->blocked_lock);
+	raw_spin_unlock(&mutex->wait_lock);
+	return NULL;
+}
+#else /* PROXY_EXEC */
+static struct task_struct *
+proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
+{
+	BUG(); // This should never be called in the !PROXY case
+	return next;
+}
+#endif /* PROXY_EXEC */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6687,12 +6756,24 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	 */
 	prev_state = READ_ONCE(prev->__state);
 	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
-		try_to_deactivate_task(rq, prev, prev_state);
+		try_to_deactivate_task(rq, prev, prev_state,
+				       !task_is_blocked(prev));
 		switch_count = &prev->nvcsw;
 	}
 
-	next = pick_next_task(rq, prev, &rf);
+pick_again:
+	next = pick_next_task(rq, rq_selected(rq), &rf);
 	rq_set_selected(rq, next);
+	if (unlikely(task_is_blocked(next))) {
+		next = proxy(rq, next, &rf);
+		if (!next) {
+			rq_unpin_lock(rq, &rf);
+			__balance_callbacks(rq);
+			rq_repin_lock(rq, &rf);
+			goto pick_again;
+		}
+	}
+
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6d9036547c1d..cfbf3925e595 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1537,8 +1537,19 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_rt_entity(rt_se, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
-		enqueue_pushable_task(rq, p);
+	/*
+	 * Current can't be pushed away. Selected is tied to current,
+	 * so don't push it either.
+	 */
+	if (task_current(rq, p) || task_current_selected(rq, p))
+		return;
+	/*
+	 * Pinned tasks can't be pushed.
+	 */
+	if (p->nr_cpus_allowed == 1)
+		return;
+
+	enqueue_pushable_task(rq, p);
 }
 
 static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
@@ -1825,6 +1836,10 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 
+	/* Avoid marking selected as pushable */
+	if (task_current_selected(rq, p))
+		return;
+
 	/*
 	 * The previous task needs to be made eligible for pushing
 	 * if it is still active
-- 
2.42.0.rc1.204.g551eb34607-goog

