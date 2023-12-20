Return-Path: <linux-kernel+bounces-6158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD8819529
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E482A1C24699
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDBD224C7;
	Wed, 20 Dec 2023 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+mESWIH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF5219E4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6d64b546e7eso1791598b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031583; x=1703636383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma+3AbQ8bkO0LeZ0x4L+yPA6KTJo2YRmJIGPc7lQ3VM=;
        b=3+mESWIHpeKZxqJBcV8G9HW/poxO52h/+lJYw57Cw+JwIg8AiCH9EkSGdKRxUSsr17
         7nSKmNY28xXTgcDlCoY7Nrg+BpWyasE1WfrpAynbj2RA6TpeK2AtcXEfmDrKvjhK8/sq
         Dd7fb2GzmOISaDnEtfVMAaBKaLaCs8+IfUwbjvkmQVNSVn2/EgKdWGHwsWpKUViSerPN
         RtPrWy3WhWwzQPnlOWGngEgC2QMXX3e0a9BmIIcsooy4Mb1FuRUs7MAECp972TxOxgJ7
         beyUAqGwej9ya9JgdHX5HKkCbgeng4aGZE6rEJ/wQASJM5M7KSBh89xt6E746PvDwBAh
         E6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031583; x=1703636383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma+3AbQ8bkO0LeZ0x4L+yPA6KTJo2YRmJIGPc7lQ3VM=;
        b=EcycwKA9QGL2xb7+M16A0tPS6j4Wz3rrwhKfTI11wgK3TQYTdB8G4q5vZswGyDD17o
         E1Fmov0BNlZYV4PyqbeKLEqjJ5g4NSZClyIirAS1QmyEYhoM+j5HVHkTinnJMNtoly/h
         iOA1X4Max1L186AnXGvaY0MDJMkt6AqKYVSfMUH65qHCX3JfxGz8l5uzTiF/yrQpQeF7
         CY/OEcO5pj8wEe67carb5jaJOzp9m6n7RIDzOZQYGUUiZ+Oq68tDCetsUz2VNva8suiO
         0zPdBKwWFWDTvYlARIfi2gNun8HJHSWnofttqrf0gDs0cD4go1HDqCd/wspSLxQRt/KQ
         KdHg==
X-Gm-Message-State: AOJu0YzQ64kiZQlhoMOks4Vy1TOkA7rkVc5TKjnEKLjCrWi4fpWIldP4
	RB8Fo1ZHzybhbENrrI8/gGwqWyt/7ozdtPUlmFQvCfUsA/IOG4cSyqRPmz+ADIRjGtIBYTRFMR7
	WcUgxiT8JXHTV9402X+wrcK6trP428QKnC7GNdhDuhNVoVDVNEQLu9vMLtVs87cRql15UPLo=
X-Google-Smtp-Source: AGHT+IHi/7DMb6bi2lndxhzyg+zWbC/oUkKFAaeQms9i1nU22B4vG0I4/VrQBTIy0/6NHvOybXKkr3clE5f2
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:aa7:8486:0:b0:6d8:a6fd:dc98 with SMTP id
 u6-20020aa78486000000b006d8a6fddc98mr81353pfn.6.1703031581731; Tue, 19 Dec
 2023 16:19:41 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:33 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-23-jstultz@google.com>
Subject: [PATCH v7 22/23] sched: Refactor dl/rt find_lowest/latest_rq logic
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

This pulls re-validation logic done in find_lowest_rq
and find_latest_rq after re-acquiring the rq locks out into its
own function.

This allows us to later use a more complicated validation
check for chain-migration when using proxy-exectuion.

TODO: It seems likely we could consolidate this two functions
further and leave the task_is_rt()/task_is_dl() checks externally?

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
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/deadline.c | 31 ++++++++++++++++++++-----
 kernel/sched/rt.c       | 50 ++++++++++++++++++++++++++++-------------
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 21e56ac58e32..8b5701727342 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2172,6 +2172,30 @@ static int find_later_rq(struct task_struct *sched_ctx, struct task_struct *exec
 	return -1;
 }
 
+static inline bool dl_revalidate_rq_state(struct task_struct *task, struct rq *rq,
+					  struct rq *later)
+{
+	if (task_rq(task) != rq)
+		return false;
+
+	if (!cpumask_test_cpu(later->cpu, &task->cpus_mask))
+		return false;
+
+	if (task_on_cpu(rq, task))
+		return false;
+
+	if (!dl_task(task))
+		return false;
+
+	if (is_migration_disabled(task))
+		return false;
+
+	if (!task_on_rq_queued(task))
+		return false;
+
+	return true;
+}
+
 /* Locks the rq it finds */
 static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 {
@@ -2204,12 +2228,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
-			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !dl_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+			if (unlikely(!dl_revalidate_rq_state(task, rq, later_rq))) {
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
 				break;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f8134d062fa3..fabb19891e95 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1935,6 +1935,39 @@ static int find_lowest_rq(struct task_struct *sched_ctx, struct task_struct *exe
 	return -1;
 }
 
+static inline bool rt_revalidate_rq_state(struct task_struct *task, struct rq *rq,
+					  struct rq *lowest)
+{
+	/*
+	 * We had to unlock the run queue. In
+	 * the mean time, task could have
+	 * migrated already or had its affinity changed.
+	 * Also make sure that it wasn't scheduled on its rq.
+	 * It is possible the task was scheduled, set
+	 * "migrate_disabled" and then got preempted, so we must
+	 * check the task migration disable flag here too.
+	 */
+	if (task_rq(task) != rq)
+		return false;
+
+	if (!cpumask_test_cpu(lowest->cpu, &task->cpus_mask))
+		return false;
+
+	if (task_on_cpu(rq, task))
+		return false;
+
+	if (!rt_task(task))
+		return false;
+
+	if (is_migration_disabled(task))
+		return false;
+
+	if (!task_on_rq_queued(task))
+		return false;
+
+	return true;
+}
+
 /* Will lock the rq it finds */
 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 {
@@ -1964,22 +1997,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 
 		/* if the prio of this runqueue changed, try again */
 		if (double_lock_balance(rq, lowest_rq)) {
-			/*
-			 * We had to unlock the run queue. In
-			 * the mean time, task could have
-			 * migrated already or had its affinity changed.
-			 * Also make sure that it wasn't scheduled on its rq.
-			 * It is possible the task was scheduled, set
-			 * "migrate_disabled" and then got preempted, so we must
-			 * check the task migration disable flag here too.
-			 */
-			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !rt_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
-
+			if (unlikely(!rt_revalidate_rq_state(task, rq, lowest_rq))) {
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
 				break;
-- 
2.43.0.472.g3155946c3a-goog


