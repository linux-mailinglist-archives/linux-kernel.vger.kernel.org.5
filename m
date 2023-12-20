Return-Path: <linux-kernel+bounces-6154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D030819525
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02F2284B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214C210E7;
	Wed, 20 Dec 2023 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7YCRIpB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A8208DA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e617562a65so44910647b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031574; x=1703636374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGhThAZPlKuA3DG9SjSGW+fpPhrooALxVkfxxcKParw=;
        b=L7YCRIpB6vKiiJgC63DQSXvgdbkErP0jGYoJAjBj/lr5eBFz68Hko82Z37XnqWEW2v
         7olIuzPZQQjfQcL2TKFxLubLWQRUyQ0CYsPN4AcGuhq+VJo8E3nZeI5csinnaJ7conEU
         CptNzn6/zW0FBak0vq35O1oU5c4BnVRFZ0YUkISJVW4griuqvNxtzRN+8y7ArI2dOMVW
         +lQDtXfpyHEQNgbtPoIowsIBEq920WPJHwW0XtNsuMFbrVs8hQnJQt14enJTKLqe+VZr
         Q3rduyTQ22yyRhntoFlrt71CyLeXSuneoP1FaxGAxbr3ACkiEtL2uQU8xCOe5OtaVaCQ
         zuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031574; x=1703636374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGhThAZPlKuA3DG9SjSGW+fpPhrooALxVkfxxcKParw=;
        b=vpE5r7p25mFmenXTHzRu3l9Lk7zv9305zYHgcNVWZ50YYxo54o9Qidyo6sd3CKwPVW
         /sfCStSN741RU48K20qt9g2GN32kRi5092RNkO/LZ40GjEAO+ClMfuQ7+imEHqJn0cA1
         v0EaN74GJNyu1w/a2Zh+h8OZO8b0I4nX/rpbyNCV9+nsfonDwaYMT8dlrBYl9hDzyAkK
         N/Lpg9qgkp2QPS58jrZesSVJncPt4RiIHCJ6vvKwHIMyvKGfTFidtR9TvKBb+NllWmdH
         UEVoiI2fuf3CZd1eE3tmMIIw12qCsNkX2wTVM3DvNoVlqIub/GXOg83wMA/ygWJ6LLWT
         dZ3w==
X-Gm-Message-State: AOJu0YyuspeXdTYAGjmuzhUYeixAQERcah91gp19dnxx9nTLYPbT2Pq5
	Cs0fM70eSPGAWls3lvKsA1Cv7ZAkUkW0FPsy5L5Dg7K+cQ5KGugdMoiTGBH60gibbCwdYtDBV7e
	ZQzsUxphmPcBznI3XHZrcORzG1N3cTINLhudN+SHRWdrdyS1xZQjpYKA/zuFoxoI1wnqEgNU=
X-Google-Smtp-Source: AGHT+IHyKlq58eERpBcLB7I11Bb4HermitDwI1gx5J6zFvTyMlHHWSwbUdgG2IY5MsXykKlPExet0+cL7E19
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:d93:b0:5d4:3013:25d4 with SMTP id
 da19-20020a05690c0d9300b005d4301325d4mr3569079ywb.5.1703031574440; Tue, 19
 Dec 2023 16:19:34 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:29 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-19-jstultz@google.com>
Subject: [PATCH v7 18/23] sched: Add push_task_chain helper
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
 kernel/sched/core.c     | 4 +---
 kernel/sched/deadline.c | 8 ++------
 kernel/sched/rt.c       | 8 ++------
 kernel/sched/sched.h    | 9 +++++++++
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0cd63bd0bdcd..0c212dcd4b7a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2721,9 +2721,7 @@ int push_cpu_stop(void *arg)
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
-		deactivate_task(rq, p, 0);
-		set_task_cpu(p, lowest_rq->cpu);
-		activate_task(lowest_rq, p, 0);
+		push_task_chain(rq, lowest_rq, p);
 		resched_curr(lowest_rq);
 	}
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4f998549ea74..def1eb23318b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2313,9 +2313,7 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, later_rq->cpu);
-	activate_task(later_rq, next_task, 0);
+	push_task_chain(rq, later_rq, next_task);
 	ret = 1;
 
 	resched_curr(later_rq);
@@ -2401,9 +2399,7 @@ static void pull_dl_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				push_task_chain(src_rq, this_rq, p);
 				dmin = p->dl.deadline;
 				resched = true;
 			}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a7b51a021111..cf0eb4aac613 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2128,9 +2128,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, lowest_rq->cpu);
-	activate_task(lowest_rq, next_task, 0);
+	push_task_chain(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;
 
@@ -2401,9 +2399,7 @@ static void pull_rt_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				push_task_chain(src_rq, this_rq, p);
 				resched = true;
 			}
 			/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 765ba10661de..19afe532771f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3546,5 +3546,14 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
+#ifdef CONFIG_SMP
+static inline
+void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
+{
+	deactivate_task(rq, task, 0);
+	set_task_cpu(task, dst_rq->cpu);
+	activate_task(dst_rq, task, 0);
+}
+#endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.43.0.472.g3155946c3a-goog


