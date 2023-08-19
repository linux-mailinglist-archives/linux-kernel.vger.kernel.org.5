Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DDE7817A0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbjHSGKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245348AbjHSGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:10:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2743F4215
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:10:04 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56438e966baso2011966a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425403; x=1693030203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc8wVAapLiQV14PIdRyLGxQ+ZHqeexMHs/HFELTTvug=;
        b=Zk6nuiQUd3F5q67600hu+t6uX5T25tCP095+RcSRZ6un40VVYc+7GgVzV4YPxQPhlt
         HagC+V5pVxELJ0P6gX8i2VMR7i4AxX/qPdsXlRayAr1+5N9DhSLwGUBQ02Xe6xaN8+o5
         yREpSZ0oZ/VwXFVPYjYaz3ncbYCt2Iyk8nnaFV16oOMWjQ5hL7thN4YeziM4M1G9UKIu
         KBDbfsdIjQ5NpTfGYVAVUYkzcYTXI7s7Cz0X4aRZHX4tuO9XRUefYMGWPibs2JlI3fyW
         uBdIy57iIa8LHBre0bNs/0PYAx07k6KIt/c3H9f/zMFbjQAcDTzxpQXBmtNnH81T2sWh
         xMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425403; x=1693030203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc8wVAapLiQV14PIdRyLGxQ+ZHqeexMHs/HFELTTvug=;
        b=CrMeosxaaJXo4hjTANSvK4bvdB452f2HAH7TyVGPUjeZ5HHLSH0zIwTf07liDoos3E
         vfqmRt39axbXu4kNe8VY9CoGto4F2UYTTeFdWiheWJCU+Z53nnWn5yLCoAhCkkZh4IwP
         qhbFkOwT3wL6YJHPeqJ7YbbVDiGU8GZ+G3dlk8SnHosbqY32CSioLN6Kv8BPlySieel2
         WTnHYoBKMaGspneJD1xHWkiIfHex9xxXjedMG02PWNFcNnY6MhjLyOwx+vMlKozROaPm
         d8lljsoyRU7aQ7LgV1yq9CykozCsM4laNiECWvNv+nLdnbXo7h7SQplDPXadlHQcXdUo
         BK5Q==
X-Gm-Message-State: AOJu0YwPbHS2ZvvNYCUOOkP/SnT+xNZdrUn/4ulTgNGWumeJZov3SSBP
        uOGOS7+p8BdY7+TQ4dov1W9YF23pi8s5C2QLCedQEF3WrJiKFUnd5Od4a8Kb/gd6Fw40YYnqfHY
        PPyC3GtF+PUZXbKoNIYpiqqYgx5MFLaEg1V++cxNyk5a9yOs2V6HuKxvq0vat8w7uAPQNvlo=
X-Google-Smtp-Source: AGHT+IGmZf4DmqeHMDdgnuSRgsR1AgcK8fC/ItSdysdKP8jfKkcdYEpIulAbGYAtWIWvK56UY3SBt04Lbtr6
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:3e02:0:b0:564:1f95:71f1 with SMTP id
 l2-20020a633e02000000b005641f9571f1mr231282pga.3.1692425403054; Fri, 18 Aug
 2023 23:10:03 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:53 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-20-jstultz@google.com>
Subject: [PATCH v5 19/19] sched: Add blocked_donor link to task for smarter
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Add link to the task this task is proxying for, and use it so we
do intellegent hand-off of the owned mutex to the task we're
running on behalf.

TODO:
* Cleanup ifdef mess

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
---
 include/linux/sched.h  |  1 +
 kernel/fork.c          |  1 +
 kernel/locking/mutex.c | 36 +++++++++++++++++++++++++++++++++---
 kernel/sched/core.c    |  7 +++++--
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3b7f26df2496..c3aa05c27816 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1140,6 +1140,7 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
+	struct task_struct		*blocked_donor;	/* task that is boosting us */
 	struct mutex			*blocked_on;	/* lock we're blocked on */
 	bool				blocked_on_waking; /* blocked on, but waking */
 	raw_spinlock_t			blocked_lock;
diff --git a/kernel/fork.c b/kernel/fork.c
index 5b11ead90b12..a746ac03c533 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2459,6 +2459,7 @@ __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
+	p->blocked_donor = NULL; /* nobody is boosting us yet */
 	p->blocked_on = NULL; /* not blocked yet */
 	p->blocked_on_waking = false; /* not blocked yet */
 
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5125bbab4119..cf6c325515c2 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -906,7 +906,7 @@ EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
  */
 static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip)
 {
-	struct task_struct *next = NULL;
+	struct task_struct *donor, *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
 	unsigned long flags;
@@ -943,7 +943,34 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
-	if (!list_empty(&lock->wait_list)) {
+
+#ifdef CONFIG_PROXY_EXEC /* TODO: Clean up this ifdef mess */
+	raw_spin_lock(&current->blocked_lock);
+	/*
+	 * If we have a task boosting us, and that task was boosting us through
+	 * this lock, hand the lock to that task, as that is the highest
+	 * waiter, as selected by the scheduling function.
+	 */
+	donor = current->blocked_donor;
+	if (donor) {
+		struct mutex *next_lock;
+
+		raw_spin_lock_nested(&donor->blocked_lock, SINGLE_DEPTH_NESTING);
+		next_lock = get_task_blocked_on(donor);
+		if (next_lock == lock) {
+			next = donor;
+			donor->blocked_on_waking = true;
+			wake_q_add(&wake_q, donor);
+			current->blocked_donor = NULL;
+		}
+		raw_spin_unlock(&donor->blocked_lock);
+	}
+#endif
+
+	/*
+	 * Failing that, pick any on the wait list.
+	 */
+	if (!next && !list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
 		struct mutex_waiter *waiter =
 			list_first_entry(&lock->wait_list,
@@ -952,7 +979,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
-		raw_spin_lock(&next->blocked_lock);
+		raw_spin_lock_nested(&next->blocked_lock, SINGLE_DEPTH_NESTING);
 		WARN_ON(next->blocked_on != lock);
 		next->blocked_on_waking = true;
 		raw_spin_unlock(&next->blocked_lock);
@@ -963,6 +990,9 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		__mutex_handoff(lock, next);
 
 	preempt_disable();
+#ifdef CONFIG_PROXY_EXEC
+	raw_spin_unlock(&current->blocked_lock);
+#endif
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	wake_up_q(&wake_q);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab3b3a783ee9..59ec06988783 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6907,6 +6907,8 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		 */
 		raw_spin_unlock(&p->blocked_lock);
 		raw_spin_unlock(&mutex->wait_lock);
+
+		owner->blocked_donor = p;
 	}
 
 	WARN_ON_ONCE(owner && !owner->on_rq);
@@ -7042,10 +7044,11 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		switch_count = &prev->nvcsw;
 	}
 
-	proxied = (rq_selected(rq) != prev);
+	proxied = !!prev->blocked_donor;
 pick_again:
 	next = pick_next_task(rq, rq_selected(rq), &rf);
 	rq_set_selected(rq, next);
+	next->blocked_donor = NULL;
 	if (unlikely(task_is_blocked(next))) {
 		next = proxy(rq, next, &rf);
 		if (!next) {
@@ -7109,7 +7112,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		/* In case next was already curr but just got blocked_donor*/
-		if (unlikely(!task_current_selected(rq, next)))
+		if (unlikely(!proxied && next->blocked_donor))
 			proxy_tag_curr(rq, next);
 
 		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-- 
2.42.0.rc1.204.g551eb34607-goog

