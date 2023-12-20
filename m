Return-Path: <linux-kernel+bounces-6146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E451819517
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246DF288090
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF0518AF6;
	Wed, 20 Dec 2023 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwDq0Ae1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D715ADB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbd4ed0b4d4so2258910276.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031562; x=1703636362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WvcOEd7dBy/nEtXMgBcYnJnQJnDQmfBeveDTN2lf28=;
        b=kwDq0Ae1Hr8XjyAoSWzUUQeLofbHyhG8PyIqE64GFejoy/mYCAIhMTTOeWDOI4uECZ
         B4DIRz480AqKgR3Bpzs/oTPaZtCef27C5uJYW/8SPTLeHmWzg/bYzfODpj4HILrnnnkp
         EgN9iE7zJ3qnkV7NZW7x3L9fb6gY7GKFmV4ciq04t7T6yzngYhvdaj3fRsetuuGvzAJi
         g8VN3PUL1g0YOOrIeBuyQW/vty3SMWKY8uDnqmRjuyfOd9YJsObVzDxQscvLnGiiqJGX
         0ykkdP/74ntuAgV5q6nh3H+HOLs/0EoYAjyz4kjwRMruOscpri7HgU9EOEh7LnaqEcuS
         i2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031562; x=1703636362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WvcOEd7dBy/nEtXMgBcYnJnQJnDQmfBeveDTN2lf28=;
        b=GhLTEiH6kOBRU/14ule/RZlYTFPrYaKMJuEKd5bzRjRvcAIXyKh3INs9Wp/MXlIeQZ
         N/r7Mm+RpK0j8fOjDaEVhFxeMwIRNu0Em+7QBBpjxpUBnxKKMKWSar8dIt74vuvNHAin
         hTc9KmiBM0PKdBGnfA4NdruuQw7lJLyfVGYRqtxAM3+2p6bOChd3G7/VjGmlS+Ubbjsp
         OmGO2VyMlJJyoTa/wb2Q39Fh1RWsCND2heSRo1MJoCVwkRX3vomaZxqM5xaem77XHK7q
         4gvmqbuGXmZnBdoHFlNyj6lgvJys5dZCWRmgo6vRIX7m5Nz661vmcLio8LaYetNg+VjB
         Rm5w==
X-Gm-Message-State: AOJu0Yxm9L6UfHLYWlVX7Sh7qlI8pHCV2gxPyICj5++N1eOZ/wrfdLu5
	Z1SS9jLtgH/qwfC4KxI247QfNac0WGakJfNV20ss5WQ+fzbTXBCdlvK+BINjWXetN39CBbi/xJf
	RRs6euFuGty4G7gBEZw1OtflWlNbRrCE5URHG1+g+dQwPLi769WkjDM1gLUBiqFkOjtqb4sA=
X-Google-Smtp-Source: AGHT+IHc9/8Lf1jyH+8Jf0HA6MLUdz+aT92t7ijdANyAVcJ0S1YNpEf15c5RUtVNt0psspRc4f7zsVHG2kqy
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:54f:b0:dbd:5a7f:6b38 with SMTP id
 z15-20020a056902054f00b00dbd5a7f6b38mr533918ybs.12.1703031561931; Tue, 19 Dec
 2023 16:19:21 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:22 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-12-jstultz@google.com>
Subject: [PATCH v7 11/23] sched: Add a initial sketch of the find_proxy_task() function
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Add a find_proxy_task() function which doesn't do much.

When we select a blocked task to run, we will just deactivate it
and pick again. The exception being if it has become unblocked
after find_proxy_task() was called.

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
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com
[jstultz: Split out from larger proxy patch and simplified
 for review and testing.]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split out from larger proxy patch
v7:
* Fixed unused function arguments, spelling nits, and tweaks for
  clarity, pointed out by Metin Kaya
* Moved task_is_blocked() implementation to this patch where it is
  first used. Also drop unused arguments. Suggested by Metin Kaya.
* Tweaks to make things easier to read, as suggested by Metin Kaya.
* Rename proxy() to find_proxy_task() for clarity, and typo
  fixes suggested by Metin Kaya
* Fix build warning Reported-by: kernel test robot <lkp@intel.com>
  Closes: https://lore.kernel.org/oe-kbuild-all/202311081028.yDLmCWgr-lkp@intel.com/
---
 kernel/sched/core.c  | 87 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/rt.c    | 19 +++++++++-
 kernel/sched/sched.h | 15 ++++++++
 3 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 34acd80b6bd0..12f5a0618328 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6572,11 +6572,11 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 #endif
 
 static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
-				   unsigned long task_state)
+				   unsigned long task_state, bool deactivate_cond)
 {
 	if (signal_pending_state(task_state, p)) {
 		WRITE_ONCE(p->__state, TASK_RUNNING);
-	} else {
+	} else if (deactivate_cond) {
 		p->sched_contributes_to_load =
 			(task_state & TASK_UNINTERRUPTIBLE) &&
 			!(task_state & TASK_NOLOAD) &&
@@ -6607,6 +6607,73 @@ static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
 	return false;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+
+static bool proxy_deactivate(struct rq *rq, struct task_struct *next)
+{
+	unsigned long state = READ_ONCE(next->__state);
+
+	/* Don't deactivate if the state has been changed to TASK_RUNNING */
+	if (state == TASK_RUNNING)
+		return false;
+	if (!try_to_deactivate_task(rq, next, state, true))
+		return false;
+	put_prev_task(rq, next);
+	rq_set_selected(rq, rq->idle);
+	resched_curr(rq);
+	return true;
+}
+
+/*
+ * Initial simple proxy that just returns the task if it's waking
+ * or deactivates the blocked task so we can pick something that
+ * isn't blocked.
+ */
+static struct task_struct *
+find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
+{
+	struct task_struct *ret = NULL;
+	struct task_struct *p = next;
+	struct mutex *mutex;
+
+	mutex = p->blocked_on;
+	/* Something changed in the chain, so pick again */
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
+		goto out;
+	}
+
+	if (!proxy_deactivate(rq, next))
+		ret = p;
+out:
+	raw_spin_unlock(&p->blocked_lock);
+	raw_spin_unlock(&mutex->wait_lock);
+	return ret;
+}
+#else /* SCHED_PROXY_EXEC */
+static struct task_struct *
+find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
+{
+	BUG(); // This should never be called in the !PROXY case
+	return next;
+}
+#endif /* SCHED_PROXY_EXEC */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6698,12 +6765,24 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
+		next = find_proxy_task(rq, next, &rf);
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
index 2682cec45aaa..81cd22eaa6dc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1491,8 +1491,19 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
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
@@ -1779,6 +1790,10 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 
+	/* Avoid marking selected as pushable */
+	if (task_current_selected(rq, p))
+		return;
+
 	/*
 	 * The previous task needs to be made eligible for pushing
 	 * if it is still active
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6ea1dfbe502a..765ba10661de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2148,6 +2148,21 @@ static inline int task_current_selected(struct rq *rq, struct task_struct *p)
 	return rq_selected(rq) == p;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	if (!sched_proxy_exec())
+		return false;
+
+	return !!p->blocked_on && p->blocked_on_state != BO_RUNNABLE;
+}
+#else /* !SCHED_PROXY_EXEC */
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	return false;
+}
+#endif /* SCHED_PROXY_EXEC */
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
-- 
2.43.0.472.g3155946c3a-goog


