Return-Path: <linux-kernel+bounces-6155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECFD819526
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C33B249F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC65121119;
	Wed, 20 Dec 2023 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7fx3AG0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751420B31
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbd59ddfd66so326407276.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031576; x=1703636376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VR583+vpJaLMIO4BHBgJSftKDpKeZ1SmQDLq2jDxSZY=;
        b=r7fx3AG0MvIL59CalkTGEjBoDV7JayZCs0cvTIpF/VkFBkGGhXI1co8eTjs6qkn5Og
         fTLZEmnCZweQ3Hcuo3zcxl32xBhz4lgA7hupHNhdcVYH31mM60v83pAtoieEq+h3KzWu
         WGw8BrKxQvRkNykwv10i/6F4mgYmALkvyqnKAE6ZdupmaLf0Wrx6Hsv9JqIyJFsE6AOb
         niDPrxJ1yRnErZbdd3nLLVz6pSUlHoeBCV0uGeapUhPFIl5Q3fidaJYbHUZllxGV7GFo
         SA0XEn0kxAbfLWIPxkstx5OgGnwIrR50DYQpDTiPhjf8AV9E1mItZMo2/bNtil8NTRgc
         /cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031576; x=1703636376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VR583+vpJaLMIO4BHBgJSftKDpKeZ1SmQDLq2jDxSZY=;
        b=JU+xkWZYKVFd2jSrrz1OsCwTCIENp2IdYd/EepGLTspANcSNfIlyqV6iSBWP2acjxN
         LHVHD5K8FWkH3lNw7hrVyzZTBaJNxlLGDuRoKy50+m7yWEBB5qhxlHl5YuxGhMwVr4/X
         ZjAhKgIfzQ9Qkxr40edo58gDgfIVaYtPVKW4AfNPh2DRa1VQPpsgi/PrOrxfHi/4fQ9z
         c7r+M3/0stRuc1qjlHqqqhmWKbdWGbu0yeRDkItJLvyeoDASsAcj+987WhPG/NQP9D+s
         ZMCkJV+DpKEoVcBW/FXu9Xv5EBbBnnSi7MoO7bR8UtnyAtNLwD2b2Y/N7PwSY5Q6nJHl
         nIJw==
X-Gm-Message-State: AOJu0Ywq3TlwE49BT0UfeYJACANbD8vK00k0Cm40D1rbV8fyc6AxL5Zr
	uhiLd4/1Z9bY/GNBNmkDx7Zejz3/YZXrdJktgqREX6Dxsv60c+A3MdbXtlxfGtAtiDVaDGcUMnF
	66jxzKkvpIcfrnGujOWp+HRpzdqirtnaqqjto8os14FHOZbUaP81dlfcfbygPixgPEMm7qA2IOZ
	zHXg==
X-Google-Smtp-Source: AGHT+IEqG+gJz/xwB/OHfoi7sJmUugFdhVQmAZNN7AOpm+rKtnYuyTIpwms1FJD6FuvYbXbcjdFjvgywAP2O
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:27c5:b0:dbc:c5f8:ae16 with SMTP
 id ec5-20020a05690227c500b00dbcc5f8ae16mr726852ybb.5.1703031576267; Tue, 19
 Dec 2023 16:19:36 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:30 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-20-jstultz@google.com>
Subject: [PATCH v7 19/23] sched: Consolidate pick_*_task to task_is_pushable helper
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

This patch consolidates rt and deadline pick_*_task functions to
a task_is_pushable() helper

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
[jstultz: split out from larger chain migration patch,
 renamed helper function]
Signed-off-by: John Stultz <jstultz@google.com>
---
v7:
* Split from chain migration patch
* Renamed function
---
 kernel/sched/deadline.c | 10 +---------
 kernel/sched/rt.c       | 11 +----------
 kernel/sched/sched.h    | 10 ++++++++++
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index def1eb23318b..1f3bc50de678 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2049,14 +2049,6 @@ static void task_fork_dl(struct task_struct *p)
 /* Only try algorithms three times */
 #define DL_MAX_TRIES 3
 
-static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-	return 0;
-}
-
 /*
  * Return the earliest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise:
@@ -2075,7 +2067,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
-		if (pick_dl_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu) == 1)
 			return p;
 
 		next_node = rb_next(next_node);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index cf0eb4aac613..15161de88753 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1812,15 +1812,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 /* Only try algorithms three times */
 #define RT_MAX_TRIES 3
 
-static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-
-	return 0;
-}
-
 /*
  * Return the highest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise
@@ -1834,7 +1825,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 		return NULL;
 
 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (pick_rt_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu) == 1)
 			return p;
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 19afe532771f..ef3d327e267c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3554,6 +3554,16 @@ void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
 	set_task_cpu(task, dst_rq->cpu);
 	activate_task(dst_rq, task, 0);
 }
+
+static inline
+int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
+{
+	if (!task_on_cpu(rq, p) &&
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
+		return 1;
+
+	return 0;
+}
 #endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.43.0.472.g3155946c3a-goog


