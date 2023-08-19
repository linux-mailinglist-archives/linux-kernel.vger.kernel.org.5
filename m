Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D4F781795
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245341AbjHSGKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244561AbjHSGJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:09:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCFB420E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6861869bcdso2365442276.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425369; x=1693030169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwgwmVR486foym+iuxa2d5QRKdNKq0L0vHF/EWahWOc=;
        b=qHWEGYuUCMXeQ4NBbwwJJq7ltMbIvAO5NhhA8wXeeDFCEKOCB+luEtLhE8LXsyifwY
         XlOj/gmZL8r2b/kdCZVjktETNGKbivUeod1hXhCfnxh0u2lTmb3n+95+OxryYhZOuwWB
         DmzaN/UBHwV8SIi/8uK5qk/aeS3aHYcZNp2NKYvCfTBuvghu2CzTFsCnETB5ci4dvSzS
         3j4ti+QMZPwroyCQbwwWtGHwbk5V92/v2pym2fdt60ILCt/1nI4rQI6bIm+EGN+CtD7X
         19gC11XVe5q+TR7fd6zdyZI7vp+++uC7ZrkC4DjXNeZ7NnIv7i9H86vWTe10X5b3QHjQ
         lC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425369; x=1693030169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwgwmVR486foym+iuxa2d5QRKdNKq0L0vHF/EWahWOc=;
        b=A9+NM0qT0JkxCMPRPt3UIIoSyyJu1QVq86QDAYjfJXNyb2jWhJDAlOjKiQKwh6W7ct
         +FEhGOxVatraC/EAMxneSa9J5dD/Kt3C8wQARXjVIrPuUy3HJ8xQZ6wxPVzA7etIXvXq
         SkP2q1NA+Bw1i+45ZvlEFeiSbO82otRqsii/RsoFiuYqLKaeIvEaOBcUYd9Ux9TFWoqy
         iLsww4kS0r5BPi2ReucAaWuVc9bgELQIxBjwTsZRTxfQglE4ye3G1hLoCuHdyWiOCu/8
         AY527FzniDMMKdC6K0pF+lBrQ3XUNmth42kQK8LbCs2p+MKWd4IvUrruyG9LSujDbswC
         2YEQ==
X-Gm-Message-State: AOJu0YzbtreQNye6Ou4lG1SzhDkNdS98lydzWxTonr+YwpjNyx2e7CxU
        A4ZQJCsag4gBTT2tB4voQipjwFs2ydt3rgRrjechE+Uin4gDoVRWeHdsQv5dSJzCjmHihR/pzKz
        0gb8uVQqV1zYNI7YpqHj2stlNiXvBm7UdKNmO5NA5Ar+iGRKpW+p8caBsWFadAk6R/2sEtr8=
X-Google-Smtp-Source: AGHT+IG8EMbClzPosTamJx/wB1hOYiezUQgXOO+kclC7zduuudrhBOUG72qnPXRvMUhGy1B4865DrjdY8K7e
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:ce44:0:b0:d72:8661:ee25 with SMTP id
 x65-20020a25ce44000000b00d728661ee25mr10977ybe.2.1692425368271; Fri, 18 Aug
 2023 23:09:28 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:35 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-2-jstultz@google.com>
Subject: [PATCH v5 01/19] sched: Unify runtime accounting across classes
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
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[fix conflicts, fold in update_current_exec_runtime]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: rebased, resovling minor conflicts]
Signed-off-by: John Stultz <jstultz@google.com>
---
NOTE: This patch is a general cleanup and if no one objects
could be merged at this point. If needed, I'll resend separately
if it isn't picked up on its own.
---
 include/linux/sched.h    |  2 +-
 kernel/sched/deadline.c  | 13 +++-------
 kernel/sched/fair.c      | 56 ++++++++++++++++++++++++++++++----------
 kernel/sched/rt.c        | 13 +++-------
 kernel/sched/sched.h     | 12 ++-------
 kernel/sched/stop_task.c | 13 +---------
 6 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814cb0..4bc8a4912539 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -520,7 +520,7 @@ struct sched_statistics {
 	u64				block_max;
 	s64				sum_block_runtime;
 
-	u64				exec_max;
+	s64				exec_max;
 	u64				slice_max;
 
 	u64				nr_migrations_cold;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 58b542bf2893..9522e6607754 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1299,9 +1299,8 @@ static void update_curr_dl(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_dl_entity *dl_se = &curr->dl;
-	u64 delta_exec, scaled_delta_exec;
+	s64 delta_exec, scaled_delta_exec;
 	int cpu = cpu_of(rq);
-	u64 now;
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1314,21 +1313,15 @@ static void update_curr_dl(struct rq *rq)
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
index b3e25be58e2b..80f74ec20fb8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -891,23 +891,17 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
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
@@ -917,9 +911,43 @@ static void update_curr(struct cfs_rq *cfs_rq)
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
 	update_min_vruntime(cfs_rq);
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e5074115..0d0b276c447d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1046,24 +1046,17 @@ static void update_curr_rt(struct rq *rq)
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
index e93e006a942b..33ad47a093ae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2204,6 +2204,8 @@ struct affinity_context {
 	unsigned int flags;
 };
 
+extern s64 update_curr_common(struct rq *rq);
+
 struct sched_class {
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -3235,16 +3237,6 @@ extern int sched_dynamic_mode(const char *str);
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
index 85590599b4d6..7595494ceb6d 100644
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
2.42.0.rc1.204.g551eb34607-goog

