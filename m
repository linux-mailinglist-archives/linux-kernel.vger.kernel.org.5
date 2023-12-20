Return-Path: <linux-kernel+bounces-6157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A82819528
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2CC1C21EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4982522311;
	Wed, 20 Dec 2023 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMHLwvwz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA582136C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cd91cbd273so1001914a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031581; x=1703636381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6y8S+nSE7+9Tt9N3qq9zNMzLoztzpop33DDkxCG+ySI=;
        b=DMHLwvwzV0QMEKRQW3VVc+aHO1+pZvv5O4ncbQKM9YudvunIfshn2cOreE4tYxo+wd
         /lwQWioItjxo+B+xZ36oCRjGQxLwgbyITHKdYS1rS4XJY2/jxcwwlL/AO0GNeVmQmyuO
         Ie3fNaEuWpbHlvq28mrG06YtUmAtLcSC7Ozz2gK2MMv9DdHsUBs4maBINn5Qwhg3bpKp
         1JjOvCGP6l9Q/RUf+z9abgp8ZMpseeicKKnVzODmvRnt+2ytabJwBcw+Sq9hJ9OT2OlD
         IaQV0XF47cBmYzXmOM4m3D7FnvzmkVPuAQBYUUBdub5KFfbEatLAerUYb4nmYx0h089Z
         F5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031581; x=1703636381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6y8S+nSE7+9Tt9N3qq9zNMzLoztzpop33DDkxCG+ySI=;
        b=RipDc+lyIB3WzqH5i4ShBzIudn+tBiN5f7gJjIFk1rpZ+6bNdJ5qjHkJ/BkPPVp9nd
         Ot1vMnic6JGqXExnFKKr/yZ6TpqmYEf1grs7sELcea4dvjdqw7+hwxJCsFQ++6+myJfY
         GkVZMAaQgdwF20086x3nvuDe5rcJ5Hp85F1ffIUvUdVrt2vYObq19F1MfvmDHt9pqn09
         ZNzucZhW2l/gX1khylNORi62998tyvjdVQsyuErgf+2S7zyHbmIvfDuferPo1B5cTL4E
         u1ELvhLTSyRT3YVjqzDJe0QvHeNxL/HKQe1AzgTT8HmUP+L+L8UB6sURZjlMd3MvC74u
         Cs8Q==
X-Gm-Message-State: AOJu0YzmGqkhZL2WjSWAJhs90YOmxvPRzz7P3MpSSHG/gQHs8H/o2isl
	t00XOLVnYwCUq3Ht5RChJS1MLeMx7cdIi0x8poIeJ/A2wiRyQmZEVR23XgM9SHGpHhW51hlLvCa
	QSpwm+XpHe7GENRss4NQPeDDKAsAFkKS0qeR2EJom1betX1qLAq72p8PteD3aG6PdJt00xPM=
X-Google-Smtp-Source: AGHT+IFxYmvsF0VHJev0Gi/Z/vUlwephStqUcSLGlwMkwFIpbu2UuRc6ddNfrjreND8D2nC2xY9cm7pr0X5O
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:5c07:0:b0:5ca:4440:234c with SMTP id
 q7-20020a635c07000000b005ca4440234cmr772730pgb.12.1703031580069; Tue, 19 Dec
 2023 16:19:40 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:32 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-22-jstultz@google.com>
Subject: [PATCH v7 21/23] sched: Add find_exec_ctx helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Connor O'Brien" <connoro@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Connor O'Brien <connoro@google.com>

Add a helper to find the runnable owner down a chain of blocked waiters

This patch was broken out from a larger chain migration
patch originally by Connor O'Brien.

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
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: split out from larger chain migration patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/core.c     | 42 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/cpupri.c   | 11 ++++++++---
 kernel/sched/deadline.c | 15 +++++++++++++--
 kernel/sched/rt.c       |  9 ++++++++-
 kernel/sched/sched.h    | 10 ++++++++++
 5 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c212dcd4b7a..77a79d5f829a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3896,6 +3896,48 @@ static void activate_blocked_entities(struct rq *target_rq,
 	}
 	raw_spin_unlock_irqrestore(&owner->blocked_lock, flags);
 }
+
+static inline bool task_queued_on_rq(struct rq *rq, struct task_struct *task)
+{
+	if (!task_on_rq_queued(task))
+		return false;
+	smp_rmb();
+	if (task_rq(task) != rq)
+		return false;
+	smp_rmb();
+	if (!task_on_rq_queued(task))
+		return false;
+	return true;
+}
+
+/*
+ * Returns the unblocked task at the end of the blocked chain starting with p
+ * if that chain is composed entirely of tasks enqueued on rq, or NULL otherwise.
+ */
+struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
+{
+	struct task_struct *exec_ctx, *owner;
+	struct mutex *mutex;
+
+	if (!sched_proxy_exec())
+		return p;
+
+	lockdep_assert_rq_held(rq);
+
+	for (exec_ctx = p; task_is_blocked(exec_ctx) && !task_on_cpu(rq, exec_ctx);
+							exec_ctx = owner) {
+		mutex = exec_ctx->blocked_on;
+		owner = __mutex_owner(mutex);
+		if (owner == exec_ctx)
+			break;
+
+		if (!task_queued_on_rq(rq, owner) || task_current_selected(rq, owner)) {
+			exec_ctx = NULL;
+			break;
+		}
+	}
+	return exec_ctx;
+}
 #else /* !CONFIG_SCHED_PROXY_EXEC */
 static inline void do_activate_task(struct rq *rq, struct task_struct *p,
 				    int en_flags)
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 15e947a3ded7..53be78afdd07 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -96,12 +96,17 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 	if (skip)
 		return 0;
 
-	if (cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids)
+	if ((p && cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids) ||
+	    (!p && cpumask_any(vec->mask) >= nr_cpu_ids))
 		return 0;
 
 	if (lowest_mask) {
-		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
-		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
+		if (p) {
+			cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
+			cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
+		} else {
+			cpumask_copy(lowest_mask, vec->mask);
+		}
 
 		/*
 		 * We have to ensure that we have at least one bit
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 999bd17f11c4..21e56ac58e32 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1866,6 +1866,8 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 
 static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 {
+	struct task_struct *exec_ctx;
+
 	/*
 	 * Current can't be migrated, useless to reschedule,
 	 * let's hope p can move out.
@@ -1874,12 +1876,16 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), rq->curr, NULL))
 		return;
 
+	exec_ctx = find_exec_ctx(rq, p);
+	if (task_current(rq, exec_ctx))
+		return;
+
 	/*
 	 * p is migratable, so let's not schedule it and
 	 * see if it is pushed or pulled somewhere else.
 	 */
 	if (p->nr_cpus_allowed != 1 &&
-	    cpudl_find(&rq->rd->cpudl, p, p, NULL))
+	    cpudl_find(&rq->rd->cpudl, p, exec_ctx, NULL))
 		return;
 
 	resched_curr(rq);
@@ -2169,12 +2175,17 @@ static int find_later_rq(struct task_struct *sched_ctx, struct task_struct *exec
 /* Locks the rq it finds */
 static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 {
+	struct task_struct *exec_ctx;
 	struct rq *later_rq = NULL;
 	int tries;
 	int cpu;
 
 	for (tries = 0; tries < DL_MAX_TRIES; tries++) {
-		cpu = find_later_rq(task, task);
+		exec_ctx = find_exec_ctx(rq, task);
+		if (!exec_ctx)
+			break;
+
+		cpu = find_later_rq(task, exec_ctx);
 
 		if ((cpu == -1) || (cpu == rq->cpu))
 			break;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6371b0fca4ad..f8134d062fa3 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1640,6 +1640,11 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), rq->curr, NULL))
 		return;
 
+	/* No reason to preempt since rq->curr wouldn't change anyway */
+	exec_ctx = find_exec_ctx(rq, p);
+	if (task_current(rq, exec_ctx))
+		return;
+
 	/*
 	 * p is migratable, so let's not schedule it and
 	 * see if it is pushed or pulled somewhere else.
@@ -1933,12 +1938,14 @@ static int find_lowest_rq(struct task_struct *sched_ctx, struct task_struct *exe
 /* Will lock the rq it finds */
 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 {
+	struct task_struct *exec_ctx;
 	struct rq *lowest_rq = NULL;
 	int tries;
 	int cpu;
 
 	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
-		cpu = find_lowest_rq(task, task);
+		exec_ctx = find_exec_ctx(rq, task);
+		cpu = find_lowest_rq(task, exec_ctx);
 
 		if ((cpu == -1) || (cpu == rq->cpu))
 			break;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ef3d327e267c..6cd473224cfe 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3564,6 +3564,16 @@ int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
 
 	return 0;
 }
+
+#ifdef CONFIG_SCHED_PROXY_EXEC
+struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p);
+#else /* !CONFIG_SCHED_PROXY_EXEC */
+static inline
+struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
+{
+	return p;
+}
+#endif /* CONFIG_SCHED_PROXY_EXEC */
 #endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.43.0.472.g3155946c3a-goog


