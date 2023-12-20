Return-Path: <linux-kernel+bounces-6135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C2D819509
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138571C2510A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF96A440B;
	Wed, 20 Dec 2023 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JPTksi+1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652123B8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c1b986082dso147474a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031545; x=1703636345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUHnww5ktcUEm6gbdUuCZMr5JgxeUPAZP1Uwwm4gSJs=;
        b=JPTksi+1QkpwIp9mYQ42y/GKuFXCfknzAretgW5L6UmlJPxOJIOL0VN+vdKY4nxSKS
         f1GbT4A9g7hZNUnkn8IKsEWFvhw7WYQtE5SXPgbq9vFPHRoHuKpjjl1poFKG000EcSXV
         g1N1nBZTfDleN4xBL4n6P2WdBH+XpSg388RjD6w5TiOV2ZiuXSpXRy/x22lInm4iIVbM
         1s8qAxjZANGOs3Yd/e4nNgQFu2cQD4O0NJspVoWypSmZhQBAS6Y69ohXpzWEZ2g6c9OC
         3zWqA8hRuN14BcZVDc0Dhbo/nlo4L0Xhv8v5Z36CJG3fgJPKiDBg5T2ku8h0D0TcMYCs
         9qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031545; x=1703636345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUHnww5ktcUEm6gbdUuCZMr5JgxeUPAZP1Uwwm4gSJs=;
        b=tIUSEbxI9Fl+2y+ZBnAHPGpDUfz+4GinBCQnEr9pAmT7iclZIu9qswUqjcp4HQlb/a
         1ExLsrrU3g8ttap/bPmLOH4vjPZ5qlBROYuNYHZdjBWFoFZ/n82fpHqtF2rt0rJ2I1zc
         zLER9WoUGR+1MDOFCyM4sq9GsFBWlU6G1OcKXNMPFPCMo6z1lMpSojtTEAPOb9HXLjAj
         CWx85YeCfmLRxFcvOlscmd9PUOO30Xy7msXzAq84svzyx3FtHqcHzyu8SI3hNeIpZkh3
         G3r+79gJ+PwcwHWe3AbxzxpUB6Mmpt0Ud2D1mQY6STbI1BTcmcFHJzDsLdNDxgVsKUjr
         ubLg==
X-Gm-Message-State: AOJu0Yx9c2cghaR0EhuvjlsTFa2mrBmBGX9Y5B0FvJ2XQ1Q1MT1ncU8s
	JaX1zuEGyCKJ5PC3jUgF3ZHZwEk/TMrcBhmFG+Xp1DRB4PQWe1DHyie3UdHsm4uOdrpGGpeGFQR
	y7C8piCYBdVBtXKgM0TvZsqJzBle4LYTBQMx3820sIgiVDC+A0opv71Xh8kpWskuuwQzJ+Oo=
X-Google-Smtp-Source: AGHT+IGo5rlZ2EWtcahUdEV5X1N/1i4O/tPYFCTuxXZMdv3cH1dn2fb15eyFgZxhI9LlgzkQX2rpajQ9NpOr
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a02:6a1:b0:5cd:9acb:a4a2 with SMTP id
 ca33-20020a056a0206a100b005cd9acba4a2mr42196pgb.2.1703031543770; Tue, 19 Dec
 2023 16:19:03 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:12 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-2-jstultz@google.com>
Subject: [PATCH v7 01/23] sched: Unify runtime accounting across classes
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
	"Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

All classes use sched_entity::exec_start to track runtime and have
copies of the exact same code around to compute runtime.

Collapse all that.

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
[fix conflicts, fold in update_current_exec_runtime]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: rebased, resolving minor conflicts]
Signed-off-by: John Stultz <jstultz@google.com>
---
v7:
* Minor typo fixup suggested by Metin Kaya
---
 include/linux/sched.h    |  2 +-
 kernel/sched/deadline.c  | 13 +++-------
 kernel/sched/fair.c      | 56 ++++++++++++++++++++++++++++++----------
 kernel/sched/rt.c        | 13 +++-------
 kernel/sched/sched.h     | 12 ++-------
 kernel/sched/stop_task.c | 13 +---------
 6 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..1e80c330f755 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -523,7 +523,7 @@ struct sched_statistics {
 	u64				block_max;
 	s64				sum_block_runtime;
 
-	u64				exec_max;
+	s64				exec_max;
 	u64				slice_max;
 
 	u64				nr_migrations_cold;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b28114478b82..6140f1f51da1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1275,9 +1275,8 @@ static void update_curr_dl(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_dl_entity *dl_se = &curr->dl;
-	u64 delta_exec, scaled_delta_exec;
+	s64 delta_exec, scaled_delta_exec;
 	int cpu = cpu_of(rq);
-	u64 now;
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1290,21 +1289,15 @@ static void update_curr_dl(struct rq *rq)
 	 * natural solution, but the full ramifications of this
 	 * approach need further study.
 	 */
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec <= 0)) {
+	delta_exec = update_curr_common(rq);
+	if (unlikely(delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
 		return;
 	}
 
-	schedstat_set(curr->stats.exec_max,
-		      max(curr->stats.exec_max, delta_exec));
-
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	update_current_exec_runtime(curr, now, delta_exec);
-
 	if (dl_entity_is_special(dl_se))
 		return;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..1251fd01a555 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1129,23 +1129,17 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-/*
- * Update the current task's runtime statistics.
- */
-static void update_curr(struct cfs_rq *cfs_rq)
+static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 {
-	struct sched_entity *curr = cfs_rq->curr;
-	u64 now = rq_clock_task(rq_of(cfs_rq));
-	u64 delta_exec;
-
-	if (unlikely(!curr))
-		return;
+	u64 now = rq_clock_task(rq);
+	s64 delta_exec;
 
 	delta_exec = now - curr->exec_start;
-	if (unlikely((s64)delta_exec <= 0))
-		return;
+	if (unlikely(delta_exec <= 0))
+		return delta_exec;
 
 	curr->exec_start = now;
+	curr->sum_exec_runtime += delta_exec;
 
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
@@ -1155,9 +1149,43 @@ static void update_curr(struct cfs_rq *cfs_rq)
 				max(delta_exec, stats->exec_max));
 	}
 
-	curr->sum_exec_runtime += delta_exec;
-	schedstat_add(cfs_rq->exec_clock, delta_exec);
+	return delta_exec;
+}
+
+/*
+ * Used by other classes to account runtime.
+ */
+s64 update_curr_common(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	s64 delta_exec;
 
+	delta_exec = update_curr_se(rq, &curr->se);
+	if (unlikely(delta_exec <= 0))
+		return delta_exec;
+
+	account_group_exec_runtime(curr, delta_exec);
+	cgroup_account_cputime(curr, delta_exec);
+
+	return delta_exec;
+}
+
+/*
+ * Update the current task's runtime statistics.
+ */
+static void update_curr(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	s64 delta_exec;
+
+	if (unlikely(!curr))
+		return;
+
+	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
+	if (unlikely(delta_exec <= 0))
+		return;
+
+	schedstat_add(cfs_rq->exec_clock, delta_exec);
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..9cdea3ea47da 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1002,24 +1002,17 @@ static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_rt_entity *rt_se = &curr->rt;
-	u64 delta_exec;
-	u64 now;
+	s64 delta_exec;
 
 	if (curr->sched_class != &rt_sched_class)
 		return;
 
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec <= 0))
+	delta_exec = update_curr_common(rq);
+	if (unlikely(delta_exec < 0))
 		return;
 
-	schedstat_set(curr->stats.exec_max,
-		      max(curr->stats.exec_max, delta_exec));
-
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	update_current_exec_runtime(curr, now, delta_exec);
-
 	if (!rt_bandwidth_enabled())
 		return;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..3e0e4fc8734b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2212,6 +2212,8 @@ struct affinity_context {
 	unsigned int flags;
 };
 
+extern s64 update_curr_common(struct rq *rq);
+
 struct sched_class {
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -3261,16 +3263,6 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
-static inline void update_current_exec_runtime(struct task_struct *curr,
-						u64 now, u64 delta_exec)
-{
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
-}
-
 #ifdef CONFIG_SCHED_MM_CID
 
 #define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 6cf7304e6449..b1b8fe61c532 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -70,18 +70,7 @@ static void yield_task_stop(struct rq *rq)
 
 static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 {
-	struct task_struct *curr = rq->curr;
-	u64 now, delta_exec;
-
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec < 0))
-		delta_exec = 0;
-
-	schedstat_set(curr->stats.exec_max,
-		      max(curr->stats.exec_max, delta_exec));
-
-	update_current_exec_runtime(curr, now, delta_exec);
+	update_curr_common(rq);
 }
 
 /*
-- 
2.43.0.472.g3155946c3a-goog


