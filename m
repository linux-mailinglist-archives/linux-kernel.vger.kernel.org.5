Return-Path: <linux-kernel+bounces-6144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC20819515
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E8F1C2101D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA7114A93;
	Wed, 20 Dec 2023 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hdc7kpd0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D473FBF9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e744f7ca3bso28795007b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031558; x=1703636358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cuXcWz7no4J7hYPFBrTfbHGW+LQBOb7rSCL/XXuOMcE=;
        b=Hdc7kpd0JSlaT6HaqU305GT9p2q+6sERQ+Tawqr7rtKFHHnhymgsIXAPPxiGdO0uEQ
         wrWzuDOQvYyE8HJkwjxRJBGs/KBtvF5EHixfSqxgxg5v89+/VZCf3pVlZDLIoPLEYdyn
         xREssLNiBELIXorXgCF58uuECIqIBEuftfN1RndRJ3bBw06XoJadHxmzhA6cAVoonx7f
         yJib8bO1AKl8nykmM2DUWOIdhnOeLdknNbkyIkryeikF0o8w+1/6tbel3HCbeEVYGY85
         GSx4Sp4pmsIBjblBsZqqOnJnZ7UxpwbNjuyEHEzdCfmn0D4kms5xZ/OjksFdsJwl77Bt
         MD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031558; x=1703636358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuXcWz7no4J7hYPFBrTfbHGW+LQBOb7rSCL/XXuOMcE=;
        b=I6ei6OQyHjjxoMH/m/jOJdvEtWqmRiAil5bPJbwkGqdOTA8kExAsloFQEqmoNX+CB8
         A6XedcFbveylXpKLMCbqm1rG/ZfqLrTiO1CCQeEI67E7P/XXUwX8WfVxmdTDkNxyG5Mq
         HW3BmCiNOQFwR3c/u6MJ9d8hKLqDk8LEA5rNsj/bFcG3rooPH0QoKNf4qvspwN8J5S8u
         JFd1Oi7u74fJVrsAp0XEbg33yydlrXUFbPLq6vJoG9ksJeSzmimc2xKv3paMTX68ssBL
         h84mjjNCZ8ZyfG7pWJDiKZLiWgk2Qd+Qv5hj/65RnRAAw8ZPL/sPJ6nWUfV4iZhDdb0d
         PXRQ==
X-Gm-Message-State: AOJu0YxJ+pzu4uY0QYWZ83Jiuw3TAI76oYpwVeUlp7hZiliycrRDGz6h
	XBd0zgbE+GWZ5KorFiz4Ena90SlerPSW/ndbsfwPvohCf1Ir3bb/eEGaZtKgJH2TIxWLHKT3yVD
	fNThN5cWWAZPFOfyucWvgLNgJXu8mR+Oyr7kZsCJL/jHa4CmEr70YjE34hdYTPz4fsWBOGjQ=
X-Google-Smtp-Source: AGHT+IFk3luOh4aXdlgpR2eInNYC3gaeKH4418CKXXWcfADelNswhEGx3is/G7wUOm6QsIm4FJztvzongW7F
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:f09:b0:5e6:27ee:67fb with SMTP id
 dc9-20020a05690c0f0900b005e627ee67fbmr1972577ywb.4.1703031558554; Tue, 19 Dec
 2023 16:19:18 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:20 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-10-jstultz@google.com>
Subject: [PATCH v7 09/23] sched: Fix runtime accounting w/ split exec & sched contexts
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

The idea here is we want to charge the scheduler-context task's
vruntime but charge the execution-context task's sum_exec_runtime.

This way cputime accounting goes against the task actually running
but vruntime accounting goes against the selected task so we get
proper fairness.

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
 kernel/sched/fair.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 07216ea3ed53..085941db5bf1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1129,22 +1129,35 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
+static s64 update_curr_se(struct rq *rq, struct sched_entity *se)
 {
 	u64 now = rq_clock_task(rq);
 	s64 delta_exec;
 
-	delta_exec = now - curr->exec_start;
+	/* Calculate the delta from selected se */
+	delta_exec = now - se->exec_start;
 	if (unlikely(delta_exec <= 0))
 		return delta_exec;
 
-	curr->exec_start = now;
-	curr->sum_exec_runtime += delta_exec;
+	/* Update selected se's exec_start */
+	se->exec_start = now;
+	if (entity_is_task(se)) {
+		struct task_struct *running = rq->curr;
+		/*
+		 * If se is a task, we account the time against the running
+		 * task, as w/ proxy-exec they may not be the same.
+		 */
+		running->se.exec_start = now;
+		running->se.sum_exec_runtime += delta_exec;
+	} else {
+		/* If not task, account the time against se */
+		se->sum_exec_runtime += delta_exec;
+	}
 
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
 
-		stats = __schedstats_from_se(curr);
+		stats = __schedstats_from_se(se);
 		__schedstat_set(stats->exec_max,
 				max(delta_exec, stats->exec_max));
 	}
-- 
2.43.0.472.g3155946c3a-goog


