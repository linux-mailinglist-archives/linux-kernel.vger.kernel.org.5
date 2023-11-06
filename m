Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F467E2D08
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjKFThe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjKFTgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:36:49 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C0A1FDD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:36:15 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso31473565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299375; x=1699904175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQZP1XEEgwn2YYv3etnqftUpHkV/CQmcTiW8k1J7ma8=;
        b=FjwOaRqOvOJT4NJ3JgSNlO9UKL1xPnnxLoRpEGhJ43rL1T2lcFcEMq7wuyrlyaqSZs
         YTJvuHIz49GSqACKRHvuwE6CEi1qISHpT72dcuEAyHCf2+CDmvPHxrFAg7zb05CuYKxs
         939o0oR3GuC/bwyZJNdMZrlH8P2wMaawq57XL7gqFNfoU8HsI5TX17KorevWm5EzkTXv
         tEBq1L4aLlyBdAPrSDdTteyS8UxNxXJmYtqDeMvVOnIVs1WG1GpU5q7oVHYFpa7/KG74
         urMg0AsmYPAz0ZHLC4siFflQZ+e4CZWMbVZdciNu345jAHGVuSgfCGfayGsspUmNlZtE
         wJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299375; x=1699904175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQZP1XEEgwn2YYv3etnqftUpHkV/CQmcTiW8k1J7ma8=;
        b=G3Wypry+cjLZHxkGE2nlgQJP0onFvNjW4fOKFkT+KmEw5HW72RKiuKVHZSjIyGqaaW
         2WYYnQgT+1vZXB/Jmos5TtQLrv9gy5QQUKYGIpE7JvoYzA2R0Pv0hWoBGl2vjjX2sHls
         GVY54VLZ21ZxtY/cmXezxXnxAOAyoDbi2to1J7pdwg56tWZttr48+fx21X4BDL0u7VcU
         V7TyXIadgF1KeHsIwbWYIrCOFrOAotIsxmz5U/6tnqfVfH7/SaASSX4p4FozZSUaaMJ/
         2mZY7BDfcxtIBCZOQHtYBgkRMfVgFEybwDPao6HPrHpBUXlOOZuV5brGIX3tAyMFafen
         ILYA==
X-Gm-Message-State: AOJu0Yz5fUx7q7L6WIRXz1xDc7DArjwwMgLoEkPVhLC7sE8fo75e1WVx
        5binzW/Xt/gFsIesKwHMA9+/4VLAXd2MzZjGAUsJkYVeyJFDT+rGUctz7//CAckcxGQUo4T5T06
        5WYupDjF1UB0oJFAR8WTRrw1iUShqD03FGK05RFb01Ml38EU/ffYcaQPUShIpObsdJLnWrLE=
X-Google-Smtp-Source: AGHT+IGY/Vg33tEt+lGHPMLzx2eg54yf5M/fb4KFZc/G5c3aBucYKpOFcfeNOyv5xKlfAl6bx00g0vemAfvo
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:efd1:b0:1c6:2b9d:570b with SMTP id
 ja17-20020a170902efd100b001c62b9d570bmr533931plb.7.1699299373896; Mon, 06 Nov
 2023 11:36:13 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:35:02 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-20-jstultz@google.com>
Subject: [PATCH v6 19/20] sched: Add blocked_donor link to task for smarter
 mutex handoffs
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Add link to the task this task is proxying for, and use it so we
do intellegent hand-off of the owned mutex to the task we're
running on behalf.

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
[jstultz: This patch was split out from larger proxy patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split out from larger proxy patch

v6:
* Moved proxied value from earlier patch to this one where it
  is actually used
* Rework logic to check sched_proxy_exec() instead of using ifdefs
* Moved comment change to this patch where it makes sense
---
 include/linux/sched.h  |  1 +
 kernel/fork.c          |  1 +
 kernel/locking/mutex.c | 35 ++++++++++++++++++++++++++++++++---
 kernel/sched/core.c    | 19 +++++++++++++++++--
 4 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 47c7095b918a..9bff2f123207 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1145,6 +1145,7 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
+	struct task_struct		*blocked_donor;	/* task that is boosting us */
 	struct mutex			*blocked_on;	/* lock we're blocked on */
 	bool				blocked_on_waking; /* blocked on, but waking */
 	raw_spinlock_t			blocked_lock;
diff --git a/kernel/fork.c b/kernel/fork.c
index 930947bf4569..6604e0472da0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2456,6 +2456,7 @@ __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
+	p->blocked_donor = NULL; /* nobody is boosting us yet */
 	p->blocked_on = NULL; /* not blocked yet */
 	p->blocked_on_waking = false; /* not blocked yet */
 
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5394a3c4b5d9..f7187a247482 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -907,7 +907,7 @@ EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
  */
 static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip)
 {
-	struct task_struct *next = NULL;
+	struct task_struct *donor, *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
 	unsigned long flags;
@@ -945,7 +945,34 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	preempt_disable();
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
-	if (!list_empty(&lock->wait_list)) {
+
+	if (sched_proxy_exec()) {
+		raw_spin_lock(&current->blocked_lock);
+		/*
+		 * If we have a task boosting us, and that task was boosting us through
+		 * this lock, hand the lock to that task, as that is the highest
+		 * waiter, as selected by the scheduling function.
+		 */
+		donor = current->blocked_donor;
+		if (donor) {
+			struct mutex *next_lock;
+
+			raw_spin_lock_nested(&donor->blocked_lock, SINGLE_DEPTH_NESTING);
+			next_lock = get_task_blocked_on(donor);
+			if (next_lock == lock) {
+				next = donor;
+				donor->blocked_on_waking = true;
+				wake_q_add(&wake_q, donor);
+				current->blocked_donor = NULL;
+			}
+			raw_spin_unlock(&donor->blocked_lock);
+		}
+	}
+
+	/*
+	 * Failing that, pick any on the wait list.
+	 */
+	if (!next && !list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
 		struct mutex_waiter *waiter =
 			list_first_entry(&lock->wait_list,
@@ -954,7 +981,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
-		raw_spin_lock(&next->blocked_lock);
+		raw_spin_lock_nested(&next->blocked_lock, SINGLE_DEPTH_NESTING);
 		WARN_ON(next->blocked_on != lock);
 		next->blocked_on_waking = true;
 		raw_spin_unlock(&next->blocked_lock);
@@ -964,6 +991,8 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	if (sched_proxy_exec())
+		raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 760e2753a24c..6ac7a241dacc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6782,7 +6782,17 @@ static inline bool proxy_return_migration(struct rq *rq, struct rq_flags *rf,
  * Find who @next (currently blocked on a mutex) can proxy for.
  *
  * Follow the blocked-on relation:
- *   task->blocked_on -> mutex->owner -> task...
+ *
+ *                ,-> task
+ *                |     | blocked-on
+ *                |     v
+ *  blocked_donor |   mutex
+ *                |     | owner
+ *                |     v
+ *                `-- task
+ *
+ * and set the blocked_donor relation, this latter is used by the mutex
+ * code to find which (blocked) task to hand-off to.
  *
  * Lock order:
  *
@@ -6919,6 +6929,8 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		 */
 		raw_spin_unlock(&p->blocked_lock);
 		raw_spin_unlock(&mutex->wait_lock);
+
+		owner->blocked_donor = p;
 	}
 
 	WARN_ON_ONCE(owner && !owner->on_rq);
@@ -7003,6 +7015,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool proxied;
 	int cpu;
 	bool preserve_need_resched = false;
 
@@ -7053,9 +7066,11 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		switch_count = &prev->nvcsw;
 	}
 
+	proxied = !!prev->blocked_donor;
 pick_again:
 	next = pick_next_task(rq, rq_selected(rq), &rf);
 	rq_set_selected(rq, next);
+	next->blocked_donor = NULL;
 	if (unlikely(task_is_blocked(next))) {
 		next = proxy(rq, next, &rf);
 		if (!next) {
@@ -7119,7 +7134,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		/* In case next was already curr but just got blocked_donor*/
-		if (unlikely(!task_current_selected(rq, next)))
+		if (unlikely(!proxied && next->blocked_donor))
 			proxy_tag_curr(rq, next);
 
 		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-- 
2.42.0.869.gea05f2083d-goog

