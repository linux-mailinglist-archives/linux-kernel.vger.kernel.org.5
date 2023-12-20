Return-Path: <linux-kernel+bounces-6152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F64819523
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A8728809D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C3B208DF;
	Wed, 20 Dec 2023 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxnHhl0e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A81F16B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28b8f963816so2527005a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031570; x=1703636370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYZk7eOoB4EkSBls2zylvhTpNqHG785S+70/RgizkRI=;
        b=YxnHhl0eZhQsCyfsCoXedRz7Nc2q+N9s9taDASCGO4gvgGFTh0Wf7eyEIJDlgmdob/
         PWfzbx3sipDy6FPlOQghDNquyLECzrI62TF3bSsRvwC9mYRsFOzmFazRHHVRx8eM1OYT
         6MKmcDXbTTqcBqL69nkWRvhtR0r4xTfjv6vfzJaQRCFBdwC+uBa8DtHZsYf4b7GOq4re
         L9/4usB7WoM/b48YDehJvG9PZVMTm/wqP7XMTmxlP8+x9CsptpH6ctZnQNxezMr7xiej
         XZERveUMXfCw0WNBIvkaWra4fNvPxejv+Z8W97Ez+Gf7qrDwIQ5t3K7EuC/sryPR1r9f
         k1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031570; x=1703636370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYZk7eOoB4EkSBls2zylvhTpNqHG785S+70/RgizkRI=;
        b=jbrnZwu2P9vi2lcOeY1H0ac0XI+HUnN1fKbOiS/fD5iOX4IjmMr1e7lYeNgJ3nl37Y
         p5ieHSzaecfhTROHjwubIvBuBzDGWWUXzwqNSuwTU34rSwPQNANuwY3tFrOfFdiqkgEQ
         rViraeIOKPaBF6wXeSOnXyQA5hX/Xm9ytg57F8tdkTKVBfxB9Knu+N4ySwL805iWQr+A
         xjC426tfY2jkpm+87IbIfiBIMDowj5TwL9gbcwNnokNBElkPYx599bbr3/0zlYFWcls/
         czi5ud2DSEB0s1Ywjdj4+lBi+6x/AkvkprGexJlStg7FC1y6MV4CElQjiv7rtykIV8aM
         gBfg==
X-Gm-Message-State: AOJu0Yxp/PGcHTL5S1XR0vRKRa1FNsJ+59MTwZUxwS51HiL+1lINQxnU
	QkAxTfUBlIWlFZVSkIz0ENnmvKjswdzVRfSYgn5sJ0JAyeO9D6LLuiP3TLjhAsqI0po3pfWm/me
	ABuTY69wGzKu7g37QZGHmGgh3astpCVjkxoQjN4mwKLRws3/MlHFW11zDI4q2oY0cO3Cl+C4=
X-Google-Smtp-Source: AGHT+IFmhibWT5gq4Ub9tf54kA1GyPrvkHcz1fxEkYADUkby5JfNtsItDzLDQNJQOT2C4R7gcwcZYhnmggnS
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90b:1d07:b0:28b:5015:301 with SMTP id
 on7-20020a17090b1d0700b0028b50150301mr865251pjb.6.1703031570653; Tue, 19 Dec
 2023 16:19:30 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:27 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-17-jstultz@google.com>
Subject: [PATCH v7 16/23] sched: Add deactivated (sleeping) owner handling to find_proxy_task()
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

If the blocked_on chain resolves to a sleeping owner, deactivate
selected task, and enqueue it on the sleeping owner task.
Then re-activate it later when the owner is woken up.

NOTE: This has been particularly challenging to get working
properly, and some of the locking is particularly ackward. I'd
very much appreciate review and feedback for ways to simplify
this.

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
[jstultz: This was broken out from the larger proxy() patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split out from larger proxy patch
v6:
* Major rework, replacing the single list head per task with
  per-task list head and nodes, creating a tree structure so
  we only wake up decendents of the task woken.
* Reworked the locking to take the task->pi_lock, so we can
  avoid mid-chain wakeup races from try_to_wake_up() called by
  the ww_mutex logic.
v7:
* Drop ununessary __nested lock annotation, as we already drop
  the lock prior.
* Add comments on #else & #endif lines, and clearer function
  names, and commit message tweaks as suggested by Metin Kaya
* Move activate_blocked_entities() call from ttwu_queue to
  try_to_wake_up() to simplify locking. Thanks to questions from
  Metin Kaya
* Fix irqsave/irqrestore usage now we call this outside where
  the pi_lock is held
* Fix activate_blocked_entitites not preserving wake_cpu
* Fix for UP builds
---
 include/linux/sched.h |   3 +
 kernel/fork.c         |   4 +
 kernel/sched/core.c   | 214 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 202 insertions(+), 19 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8020e224e057..6f982948a105 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1158,6 +1158,9 @@ struct task_struct {
 	enum blocked_on_state		blocked_on_state;
 	struct mutex			*blocked_on;	/* lock we're blocked on */
 	struct task_struct		*blocked_donor;	/* task that is boosting this task */
+	struct list_head		blocked_head;  /* tasks blocked on this task */
+	struct list_head		blocked_node;  /* our entry on someone elses blocked_head */
+	struct task_struct		*sleeping_owner; /* task our blocked_node is enqueued on */
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/kernel/fork.c b/kernel/fork.c
index 138fc23cad43..56f5e19c268e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2460,6 +2460,10 @@ __latent_entropy struct task_struct *copy_process(
 	p->blocked_on_state = BO_RUNNABLE;
 	p->blocked_on = NULL; /* not blocked yet */
 	p->blocked_donor = NULL; /* nobody is boosting p yet */
+
+	INIT_LIST_HEAD(&p->blocked_head);
+	INIT_LIST_HEAD(&p->blocked_node);
+	p->sleeping_owner = NULL;
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e0afa228bc9d..0cd63bd0bdcd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3785,6 +3785,133 @@ static inline void ttwu_do_wakeup(struct task_struct *p)
 	trace_sched_wakeup(p);
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+static void do_activate_task(struct rq *rq, struct task_struct *p, int en_flags)
+{
+	lockdep_assert_rq_held(rq);
+
+	if (!sched_proxy_exec()) {
+		activate_task(rq, p, en_flags);
+		return;
+	}
+
+	if (p->sleeping_owner) {
+		struct task_struct *owner = p->sleeping_owner;
+
+		raw_spin_lock(&owner->blocked_lock);
+		list_del_init(&p->blocked_node);
+		p->sleeping_owner = NULL;
+		raw_spin_unlock(&owner->blocked_lock);
+	}
+
+	/*
+	 * By calling activate_task with blocked_lock held, we
+	 * order against the find_proxy_task() blocked_task case
+	 * such that no more blocked tasks will be enqueued on p
+	 * once we release p->blocked_lock.
+	 */
+	raw_spin_lock(&p->blocked_lock);
+	WARN_ON(task_cpu(p) != cpu_of(rq));
+	activate_task(rq, p, en_flags);
+	raw_spin_unlock(&p->blocked_lock);
+}
+
+#ifdef CONFIG_SMP
+static inline void proxy_set_task_cpu(struct task_struct *p, int cpu)
+{
+	unsigned int wake_cpu;
+
+	/* Preserve wake_cpu */
+	wake_cpu = p->wake_cpu;
+	__set_task_cpu(p, cpu);
+	p->wake_cpu = wake_cpu;
+}
+#else /* !CONFIG_SMP */
+static inline void proxy_set_task_cpu(struct task_struct *p, int cpu)
+{
+	__set_task_cpu(p, cpu);
+}
+#endif /* CONFIG_SMP */
+
+static void activate_blocked_entities(struct rq *target_rq,
+				      struct task_struct *owner,
+				      int wake_flags)
+{
+	unsigned long flags;
+	struct rq_flags rf;
+	int target_cpu = cpu_of(target_rq);
+	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
+
+	if (wake_flags & WF_MIGRATED)
+		en_flags |= ENQUEUE_MIGRATED;
+	/*
+	 * A whole bunch of 'proxy' tasks back this blocked task, wake
+	 * them all up to give this task its 'fair' share.
+	 */
+	raw_spin_lock_irqsave(&owner->blocked_lock, flags);
+	while (!list_empty(&owner->blocked_head)) {
+		struct task_struct *pp;
+		unsigned int state;
+
+		pp = list_first_entry(&owner->blocked_head,
+				      struct task_struct,
+				      blocked_node);
+		BUG_ON(pp == owner);
+		list_del_init(&pp->blocked_node);
+		WARN_ON(!pp->sleeping_owner);
+		pp->sleeping_owner = NULL;
+		raw_spin_unlock_irqrestore(&owner->blocked_lock, flags);
+
+		raw_spin_lock_irqsave(&pp->pi_lock, flags);
+		state = READ_ONCE(pp->__state);
+		/* Avoid racing with ttwu */
+		if (state == TASK_WAKING) {
+			raw_spin_unlock_irqrestore(&pp->pi_lock, flags);
+			raw_spin_lock_irqsave(&owner->blocked_lock, flags);
+			continue;
+		}
+		if (READ_ONCE(pp->on_rq)) {
+			/*
+			 * We raced with a non mutex handoff activation of pp.
+			 * That activation will also take care of activating
+			 * all of the tasks after pp in the blocked_entry list,
+			 * so we're done here.
+			 */
+			raw_spin_unlock_irqrestore(&pp->pi_lock, flags);
+			raw_spin_lock_irqsave(&owner->blocked_lock, flags);
+			continue;
+		}
+
+		proxy_set_task_cpu(pp, target_cpu);
+
+		rq_lock_irqsave(target_rq, &rf);
+		update_rq_clock(target_rq);
+		do_activate_task(target_rq, pp, en_flags);
+		resched_curr(target_rq);
+		rq_unlock_irqrestore(target_rq, &rf);
+		raw_spin_unlock_irqrestore(&pp->pi_lock, flags);
+
+		/* recurse - XXX This needs to be reworked to avoid recursing */
+		activate_blocked_entities(target_rq, pp, wake_flags);
+
+		raw_spin_lock_irqsave(&owner->blocked_lock, flags);
+	}
+	raw_spin_unlock_irqrestore(&owner->blocked_lock, flags);
+}
+#else /* !CONFIG_SCHED_PROXY_EXEC */
+static inline void do_activate_task(struct rq *rq, struct task_struct *p,
+				    int en_flags)
+{
+	activate_task(rq, p, en_flags);
+}
+
+static inline void activate_blocked_entities(struct rq *target_rq,
+					     struct task_struct *owner,
+					     int wake_flags)
+{
+}
+#endif /* CONFIG_SCHED_PROXY_EXEC */
+
 #ifdef CONFIG_SMP
 static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
 {
@@ -3839,7 +3966,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		atomic_dec(&task_rq(p)->nr_iowait);
 	}
 
-	activate_task(rq, p, en_flags);
+	do_activate_task(rq, p, en_flags);
 	wakeup_preempt(rq, p, wake_flags);
 
 	ttwu_do_wakeup(p);
@@ -3936,13 +4063,19 @@ void sched_ttwu_pending(void *arg)
 	update_rq_clock(rq);
 
 	llist_for_each_entry_safe(p, t, llist, wake_entry.llist) {
+		int wake_flags;
 		if (WARN_ON_ONCE(p->on_cpu))
 			smp_cond_load_acquire(&p->on_cpu, !VAL);
 
 		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
 			set_task_cpu(p, cpu_of(rq));
 
-		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
+		wake_flags = p->sched_remote_wakeup ? WF_MIGRATED : 0;
+		ttwu_do_activate(rq, p, wake_flags, &rf);
+		rq_unlock(rq, &rf);
+		activate_blocked_entities(rq, p, wake_flags);
+		rq_lock(rq, &rf);
+		update_rq_clock(rq);
 	}
 
 	/*
@@ -4423,6 +4556,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (p->blocked_on_state == BO_WAKING)
 		p->blocked_on_state = BO_RUNNABLE;
 	raw_spin_unlock_irqrestore(&p->blocked_lock, flags);
+	activate_blocked_entities(cpu_rq(cpu), p, wake_flags);
 out:
 	if (success)
 		ttwu_stat(p, task_cpu(p), wake_flags);
@@ -6663,19 +6797,6 @@ proxy_resched_idle(struct rq *rq, struct task_struct *next)
 	return rq->idle;
 }
 
-static bool proxy_deactivate(struct rq *rq, struct task_struct *next)
-{
-	unsigned long state = READ_ONCE(next->__state);
-
-	/* Don't deactivate if the state has been changed to TASK_RUNNING */
-	if (state == TASK_RUNNING)
-		return false;
-	if (!try_to_deactivate_task(rq, next, state, true))
-		return false;
-	proxy_resched_idle(rq, next);
-	return true;
-}
-
 #ifdef CONFIG_SMP
 /*
  * If the blocked-on relationship crosses CPUs, migrate @p to the
@@ -6761,6 +6882,31 @@ proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
 }
 #endif /* CONFIG_SMP */
 
+static void proxy_enqueue_on_owner(struct rq *rq, struct task_struct *owner,
+				   struct task_struct *next)
+{
+	/*
+	 * ttwu_activate() will pick them up and place them on whatever rq
+	 * @owner will run next.
+	 */
+	if (!owner->on_rq) {
+		BUG_ON(!next->on_rq);
+		deactivate_task(rq, next, DEQUEUE_SLEEP);
+		if (task_current_selected(rq, next)) {
+			put_prev_task(rq, next);
+			rq_set_selected(rq, rq->idle);
+		}
+		/*
+		 * ttwu_do_activate must not have a chance to activate p
+		 * elsewhere before it's fully extricated from its old rq.
+		 */
+		WARN_ON(next->sleeping_owner);
+		next->sleeping_owner = owner;
+		smp_mb();
+		list_add(&next->blocked_node, &owner->blocked_head);
+	}
+}
+
 /*
  * Find who @next (currently blocked on a mutex) can proxy for.
  *
@@ -6866,10 +7012,40 @@ find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		}
 
 		if (!owner->on_rq) {
-			/* XXX Don't handle blocked owners yet */
-			if (!proxy_deactivate(rq, next))
-				ret = next;
-			goto out;
+			/*
+			 * rq->curr must not be added to the blocked_head list or else
+			 * ttwu_do_activate could enqueue it elsewhere before it switches
+			 * out here. The approach to avoid this is the same as in the
+			 * migrate_task case.
+			 */
+			if (curr_in_chain) {
+				raw_spin_unlock(&p->blocked_lock);
+				raw_spin_unlock(&mutex->wait_lock);
+				return proxy_resched_idle(rq, next);
+			}
+
+			/*
+			 * If !@owner->on_rq, holding @rq->lock will not pin the task,
+			 * so we cannot drop @mutex->wait_lock until we're sure its a blocked
+			 * task on this rq.
+			 *
+			 * We use @owner->blocked_lock to serialize against ttwu_activate().
+			 * Either we see its new owner->on_rq or it will see our list_add().
+			 */
+			if (owner != p) {
+				raw_spin_unlock(&p->blocked_lock);
+				raw_spin_lock(&owner->blocked_lock);
+			}
+
+			proxy_enqueue_on_owner(rq, owner, next);
+
+			if (task_current_selected(rq, next)) {
+				put_prev_task(rq, next);
+				rq_set_selected(rq, rq->idle);
+			}
+			raw_spin_unlock(&owner->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return NULL; /* retry task selection */
 		}
 
 		if (owner == p) {
-- 
2.43.0.472.g3155946c3a-goog


