Return-Path: <linux-kernel+bounces-104051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DC687C84E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A8C1C21102
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40E13ADC;
	Fri, 15 Mar 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z0op849K"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40611CAB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710477629; cv=none; b=uveapG1CZ650J5lrtL8eMf46Bmv3csNW8/dzWZFzsjFdmqZvtB6mqmFstOrjELZmF5FoI7/ZcCWL87Cf4Vg7ETXxQ7TJoKfSgxYoaphrIoI1VVZ091yBujma5V4G36Ov6ovN2hcKm2Or0FC67IWZD9bxVQTin5e6lAyVxq306+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710477629; c=relaxed/simple;
	bh=jb2f62llGktcTJX7jZ9P27KJuhKLBVfyaQMjusGxT5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DcdGLgf4mKYEDwZTBGancqIxVydfuefYRkJWZdJwsd8FtrT33dDZFqMo9H31Tbg+i1lXqDetGbvXrh/jI02/nMrbDqyGhBH6aFzLznp0UCxCJ3vM+HfWJsy+YXjOmCUQoZDEqABDv/Nquw69mdJvLvu0aTVbZ64JkPHFkkpZnEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z0op849K; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dd72cc8590so18471185ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710477627; x=1711082427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rge6qMKoRypwUh+jBaE1ZlEEyDpmj0/zDUPqL1+MPa0=;
        b=z0op849KWpNDr04pXa+VxXw9mXNLwd4VIBOkkdcSuvBSv8qA5zRogHnQU1xZgs1WjL
         Plm1uZqg2Aw7Gf5w0CjjRMCcJFz0ReLo3eVyORCBReGyYWsE0gkj32nBJwkW09bJhVRl
         z0V2ZBiFQhwJzHkHP+faVm5Z7Hqf8258qUgWa519hh1sx1lWcxHHvWRBuZQZxPqLA1GE
         o90gACU8DKPRlKnh38A4fmRhmaLPiXQUjQT/kV+/HqXV6dJABpyKb7+5RgoXVTHKRcCq
         QH9p1HWhP+/WhVupe7TxSUR0jfnjXQzx5BzhEO2XG4JNgnt3GZuPaAGhP6Z0V6aszhuX
         EPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710477627; x=1711082427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rge6qMKoRypwUh+jBaE1ZlEEyDpmj0/zDUPqL1+MPa0=;
        b=QtItXRjuJxrLqK4ox7Mpz/G/tQtCb/mc8FNjaqnW/GHSAikpe69jUQA5+XfgBSHxV5
         rG1PfIyPWw8T2NvALMQHhc5EPkFWvKLku5xkt3efn3YHV2+7m26R690LHTbLskqapwuD
         CLH+xXBkeApV4SZT1Zrdm78Gm2oR6IK5Oq6RtA3H49/EyvppTWAcbgZzVfTY7cKgLBOq
         bCXtH4g+RvCL9g9Vn87ogdPLND3U6VXeDXWhBkLLNB94SpaptpnS41b5GbHOyB649d+a
         LrqiAuo8gQvQAu00l0nqzqGkDusaDRn2zp2TKtQbkcGOz9UW3Iw9NKbB6Tzdvyrm5fc6
         Am0Q==
X-Gm-Message-State: AOJu0YxJOA9FiQnrbM6avRtHrSm0PJzmnT7RFa6VCK1IGjolznU9i49H
	tRlExW+XBVEo19l2av14vCG1SZS1+BAgtq7OB7wbvStn0d1CqZSflDZ6c0gxCr1R6CL+W+7n/fT
	ZJ7lWsseKWl5UIEmX2zmhWfSj2z26li0KEcjlE4GazjpWZL8veyiJvn3SQrBoIyHs5wD095HdEn
	aNH6bqsgZHOQIPR6GAJlKBk0RfSNfHokxAlLIKYFkeNTEY
X-Google-Smtp-Source: AGHT+IGZZKdBItwhke0XJ5jnVNca7Nuw3P/L4a3fcqTkh4AtaklIXX7S1Pa+2nLOmmOtyqMD15S30DhUO3Na
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:fa0f:b0:1dd:6bd0:d279 with SMTP id
 la15-20020a170902fa0f00b001dd6bd0d279mr133435plb.7.1710477626432; Thu, 14 Mar
 2024 21:40:26 -0700 (PDT)
Date: Thu, 14 Mar 2024 21:39:49 -0700
In-Reply-To: <20240315044007.2778856-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315044007.2778856-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240315044007.2778856-5-jstultz@google.com>
Subject: [PATCH v9 4/7] sched: Add do_push_task helper
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
2.44.0.291.gc1ea87d7ee-goog


