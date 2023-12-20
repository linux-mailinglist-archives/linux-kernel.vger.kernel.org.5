Return-Path: <linux-kernel+bounces-6151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9EF819521
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705F31C2558D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD62200D8;
	Wed, 20 Dec 2023 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/xL+3FA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7551DA4F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbd4a080c0bso2649377276.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031569; x=1703636369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNh04uMPPxlN5w0eaiGKDRnEs2O+ir6chwSpLeyNOZY=;
        b=U/xL+3FA1vfQMVyGuj1gar9joGfNdh+gVdvjCD9SUuM2FdfSIgMFJpoXTKR20pxBl3
         l7GHeKi4KkqKK7IDb6pJ5H6TPsZJPnQWOd3lycLRDpm5VIBjwczzt6qWWfHGuv4Zm84q
         4OmJZJ3e9TT3Y3e8xRoPVPJD2X988uiSdTZrQs2OTdFQxbV077czvFPPh14ECvRUTd8N
         1/AHacSMoDfNQCKm7733cwoGy1PbxpwtyxdDknJu3HWrMFcbR04E3Br/9f7xdUAEBeQa
         VU8JgsCX1LsqAs9Na+lsWsixHHjET66ox7h+fOQn0Qf56divD4jSkyNx+BXazqYX+BSI
         /QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031569; x=1703636369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNh04uMPPxlN5w0eaiGKDRnEs2O+ir6chwSpLeyNOZY=;
        b=pSKLsTGZFmnmScN6AQtKLz5WOz5z+lcG9GB3ErDActre0Y6PgwB0Vc/7T3mHjdO7HU
         9vI9qqi3tDr5EVXzd1Eq2K0gnviMmMkmtpJhD6l6qZEip2Z1KFkzdH48Ui4Ut7nxP5Yz
         ExpnuXYL9qgEwnTAGF8Uq5NHa7zWoLooWs5PVUfdVyWwrEeNsrodDOTQwFj+XrSFU7cf
         5OyuvNoTyn+3MQ1ZbmppKQr268/7d7CgMZQ/1UqOs2c72Wsft9fyJY5uM4xGC0iAbXtA
         BT1M+sq+OqLMrj449Nh6qzXTylgqik6/dewbI9MdxZdrhVblMaZ/qo8+ZiwlLvJ8OLQI
         dXBA==
X-Gm-Message-State: AOJu0YwrRnniWpxniNvWNNSllH1larx46KlLp4Wvsa9MlYt6udlAJIwQ
	XppMfr7bNHnFOj9zDXUqau9kl2eJr/rTn/7n3pJ7DImjXuCVGlE1N2Crq0FAmijAY7+J9ahuGXm
	kySZc4Kk9DwMNe1WXhhvSWPzIN2xFHiYRDm66NZvnWDd2ojuFqDFe72YlH7xQAvJf/7ioOIo=
X-Google-Smtp-Source: AGHT+IGTvm5EURdKNjlgJfkx4HO9wEy6DegCXdkHHvIcX7tzc7ibCNKLNpt6PpKTty4+qzPdSBhDMTR1+rQP
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:86ce:0:b0:dbc:d2e9:39e7 with SMTP id
 y14-20020a2586ce000000b00dbcd2e939e7mr2500993ybm.10.1703031569088; Tue, 19
 Dec 2023 16:19:29 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:26 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-16-jstultz@google.com>
Subject: [PATCH v7 15/23] sched: Add blocked_donor link to task for smarter
 mutex handoffs
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	Valentin Schneider <valentin.schneider@arm.com>, "Connor O'Brien" <connoro@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

Add link to the task this task is proxying for, and use it so we
do intelligent hand-off of the owned mutex to the task we're
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
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
v7:
* Use more descriptive term then "us" in comments, as suggested
  by Metin Kaya.
* Minor typo fixup from Metin Kaya
* Reworked proxied variable to prev_not_proxied to simplify usage
---
 include/linux/sched.h  |  1 +
 kernel/fork.c          |  1 +
 kernel/locking/mutex.c | 35 ++++++++++++++++++++++++++++++++---
 kernel/sched/core.c    | 19 +++++++++++++++++--
 4 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 880af1c3097d..8020e224e057 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1157,6 +1157,7 @@ struct task_struct {
 
 	enum blocked_on_state		blocked_on_state;
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	struct task_struct		*blocked_donor;	/* task that is boosting this task */
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/kernel/fork.c b/kernel/fork.c
index b3ba3d22d8b2..138fc23cad43 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2459,6 +2459,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	p->blocked_on_state = BO_RUNNABLE;
 	p->blocked_on = NULL; /* not blocked yet */
+	p->blocked_donor = NULL; /* nobody is boosting p yet */
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 11dc5cb7a5a3..2711af8c0052 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -910,7 +910,7 @@ EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
  */
 static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip)
 {
-	struct task_struct *next = NULL;
+	struct task_struct *donor, *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
 	unsigned long flags;
@@ -948,7 +948,34 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	preempt_disable();
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
-	if (!list_empty(&lock->wait_list)) {
+
+	if (sched_proxy_exec()) {
+		raw_spin_lock(&current->blocked_lock);
+		/*
+		 * If we have a task boosting current, and that task was boosting
+		 * current through this lock, hand the lock to that task, as that
+		 * is the highest waiter, as selected by the scheduling function.
+		 */
+		donor = current->blocked_donor;
+		if (donor) {
+			struct mutex *next_lock;
+
+			raw_spin_lock_nested(&donor->blocked_lock, SINGLE_DEPTH_NESTING);
+			next_lock = get_task_blocked_on(donor);
+			if (next_lock == lock) {
+				next = donor;
+				donor->blocked_on_state = BO_WAKING;
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
@@ -956,7 +983,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 		next = waiter->task;
 
-		raw_spin_lock(&next->blocked_lock);
+		raw_spin_lock_nested(&next->blocked_lock, SINGLE_DEPTH_NESTING);
 		debug_mutex_wake_waiter(lock, waiter);
 		WARN_ON(next->blocked_on != lock);
 		next->blocked_on_state = BO_WAKING;
@@ -967,6 +994,8 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	if (sched_proxy_exec())
+		raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 55dc2a3b7e46..e0afa228bc9d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6765,7 +6765,17 @@ proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
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
@@ -6897,6 +6907,8 @@ find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		 */
 		raw_spin_unlock(&p->blocked_lock);
 		raw_spin_unlock(&mutex->wait_lock);
+
+		owner->blocked_donor = p;
 	}
 
 	WARN_ON_ONCE(owner && !owner->on_rq);
@@ -6979,6 +6991,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool prev_not_proxied;
 	int cpu;
 	bool preserve_need_resched = false;
 
@@ -7030,9 +7043,11 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		switch_count = &prev->nvcsw;
 	}
 
+	prev_not_proxied = !prev->blocked_donor;
 pick_again:
 	next = pick_next_task(rq, rq_selected(rq), &rf);
 	rq_set_selected(rq, next);
+	next->blocked_donor = NULL;
 	if (unlikely(task_is_blocked(next))) {
 		next = find_proxy_task(rq, next, &rf);
 		if (!next) {
@@ -7088,7 +7103,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		/* In case next was already curr but just got blocked_donor*/
-		if (!task_current_selected(rq, next))
+		if (prev_not_proxied && next->blocked_donor)
 			proxy_tag_curr(rq, next);
 
 		rq_unpin_lock(rq, &rf);
-- 
2.43.0.472.g3155946c3a-goog


