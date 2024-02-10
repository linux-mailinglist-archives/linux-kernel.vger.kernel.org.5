Return-Path: <linux-kernel+bounces-60182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92B6850116
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE12F1C226CE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596586AD9;
	Sat, 10 Feb 2024 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7hylp7P"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E3440E
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524626; cv=none; b=sHeH73DpK3FTUesCpXiChthhRSvbptpYZXJQArRP1HANUEHBAVCBnfDvZC8ooTNcPMoSKoHM7QcDtsEFeJcQbbrGvDsIVAIWpqWwsPfyL6hbwRMWLP7/32lOUWMO53RHi0CmRPNsin/sWagrHog0XMYFaXgcR/4m5xpNSB0dfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524626; c=relaxed/simple;
	bh=M0EQp4w0btavUbmp0WUrlEWQstIAdnxSA4WvzN2eeyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YRcs1/hxpjl3VR2b0x8xAYbL8XZBgY44mMowR1qPk/YhQrK3pM9uxm7emSOwqI4qIMz55lJCWHYpTF+oKB7NPmcqKQu+QFeHS+Wo7tgNXpdIxtadafj4qO3pUqPrEXjQgEUaQbwFfpSXbPm3HnddgRrfBYnhEQcm1vmAvtPqyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B7hylp7P; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604a4923adaso28027877b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707524623; x=1708129423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHWaFb2dLNabyhWAVRZBb4OwekggJuLpGLrM9aWYM2E=;
        b=B7hylp7PkYfyBx8nhneEFcn+/hdJFNH/mza1eHbGu1vSRkxx8qKWk/oQURI6+/7PpD
         GqkCdTUYQMz1pJEkzi/WRsQ8l1MCjMJ3diz5pCfnmQEQ9qV9CtRxIQnRtypziBAUu7ar
         fWJS5W4rgDweesYLjMmN45R99Pqd72wbGFiq0AVguFOQisDvqoCoyMFch7/jzCSBJVC0
         R9AQ+TSnCSSQPR4prCd6TStJpAfR4k+SQHjn+xhZsyJVGWFL8r0tNhP34eauBqHY5YtH
         X0goGkzK0DUUyisApfuALWnUsFEHgodKvt8Yvev2OLl6TOU1nseA0dHmHGT+3hEbpYGf
         vwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524623; x=1708129423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHWaFb2dLNabyhWAVRZBb4OwekggJuLpGLrM9aWYM2E=;
        b=HsGoCQ0P7ivoWHaUXWqtVOdz0NUYrgorVCfjBgYnGeclZ5/0skbi6VjE7onQ3z2zHj
         yfy8Ydn3YgeWDs0KH67Q6+z+Qg9pUCGzKkoI0l8nBh+LouYu3B8lt/50IccqeWANu9N8
         DbJgOTKkjO2P02UY/wBvvVvyIXUUQZTfjFos/sZyRZKTTHHHcfcoId2bv2CCvr5Nhfk0
         58tWyYNPoNIb4p6lMvve/4WzUrBMFK0RKLqgkLYwuMxdETM++zTBYfNc+in5t+P+yxXK
         jXrOq+kSjpDrPZCVeTDwDBhg3QSwuRqimfmTQyBBRYPU3RvlWyxUJ53jGeJouDD+eZiP
         mE0Q==
X-Gm-Message-State: AOJu0YxjUpm82Si7fD7eApmZBuiaYmFKqFYVuoYe67tCEogylAr7M1YO
	rFQSLkTHOpuOxk+HFHSuomRrwgHVCIPODtk7WmTmN2WKM8LkRwhAibQhKLsiN0yEAa0tuF+wBt+
	DVjQv69hUaFlN+9zjlnBe+Tsh8UCLGQDlkq5mGEqpZQUYgVZ6EvcX+Vfr0uzpsaTg5sjVLelq/s
	WY89DMjrCQ8evXv9A21npxxwA5qwfNNZCJOo9hG0X3Z5/n
X-Google-Smtp-Source: AGHT+IHPnP2ADQYpLyh+gF1V8jl7YyxDsnex2kU6X7XoGOg9HSfSpCUotk8EvnVW9dehhAzH/Gp17LGaMU7E
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:1027:b0:dc6:207c:dc93 with SMTP
 id x7-20020a056902102700b00dc6207cdc93mr29352ybt.2.1707524622932; Fri, 09 Feb
 2024 16:23:42 -0800 (PST)
Date: Fri,  9 Feb 2024 16:23:13 -0800
In-Reply-To: <20240210002328.4126422-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210002328.4126422-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240210002328.4126422-5-jstultz@google.com>
Subject: [PATCH v8 4/7] sched: Add do_push_task helper
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

Switch logic that deactivates, sets the task cpu,
and reactivates a task on a different rq to use a
helper that will be later extended to push entire
blocked task chains.

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
v8:
* Renamed from push_task_chain to do_push_task so it makes
  more sense without proxy-execution
---
 kernel/sched/core.c     | 4 +---
 kernel/sched/deadline.c | 8 ++------
 kernel/sched/rt.c       | 8 ++------
 kernel/sched/sched.h    | 9 +++++++++
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..ad4748327651 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2714,9 +2714,7 @@ int push_cpu_stop(void *arg)
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
-		deactivate_task(rq, p, 0);
-		set_task_cpu(p, lowest_rq->cpu);
-		activate_task(lowest_rq, p, 0);
+		do_push_task(rq, lowest_rq, p);
 		resched_curr(lowest_rq);
 	}
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a04a436af8cc..e68d88963e89 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2443,9 +2443,7 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, later_rq->cpu);
-	activate_task(later_rq, next_task, 0);
+	do_push_task(rq, later_rq, next_task);
 	ret = 1;
 
 	resched_curr(later_rq);
@@ -2531,9 +2529,7 @@ static void pull_dl_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				do_push_task(src_rq, this_rq, p);
 				dmin = p->dl.deadline;
 				resched = true;
 			}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3261b067b67e..dd072d11cc02 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2106,9 +2106,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, lowest_rq->cpu);
-	activate_task(lowest_rq, next_task, 0);
+	do_push_task(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;
 
@@ -2379,9 +2377,7 @@ static void pull_rt_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				do_push_task(src_rq, this_rq, p);
 				resched = true;
 			}
 			/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001fe047bd5d..6ca83837e0f4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3472,5 +3472,14 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
+#ifdef CONFIG_SMP
+static inline
+void do_push_task(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
+{
+	deactivate_task(rq, task, 0);
+	set_task_cpu(task, dst_rq->cpu);
+	activate_task(dst_rq, task, 0);
+}
+#endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.43.0.687.g38aa6559b0-goog


