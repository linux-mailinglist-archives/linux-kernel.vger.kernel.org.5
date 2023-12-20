Return-Path: <linux-kernel+bounces-6147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D81D81951C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD5F3B2500B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1E5BE4E;
	Wed, 20 Dec 2023 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CN3eC1b8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E1168C4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28b6a78a164so3269242a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031563; x=1703636363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJZ0zBDHStU6K3+8MFmMAIsVcwSpztLmjKA4OaYGSSc=;
        b=CN3eC1b8cDs50wBw0TKGRLWUljQS7QAHezN8cauNxoTPio+leTvL9ng2q9JkHFUzyc
         qU5+8QZiu6FnH94cr6H/iWm4HS7Vtr7bse5vFSlYXvtoPRsDmjTxPjxEMHUYWTWmm1YE
         4AxW7Ao8DLaGPwlHL/dnUW/YiFtfSyHssUQbwfVuaaXEJSRT2Kcs5Mde/n7oAgzQkzQJ
         O9XU46GssCRtleqt/+pxewzRZn6t7985edCRsBc7n3AG1DR8W1I9QkvsaYFiz5NutTmr
         AJ1RVwxLg4zLR5qnTB2yFR5zjCecmJrQ59nQ5wD9PogSFgcCpIwWRHcAs+x1hamBCc0a
         mE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031563; x=1703636363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJZ0zBDHStU6K3+8MFmMAIsVcwSpztLmjKA4OaYGSSc=;
        b=t2v+jI2+WVBFBnLqsC9ckpKLwc70HxHj3b/TS0jwpXonkDsE5yCDWgJfVaXz2PJK9W
         6SbKvON4T2CcJPW6qHcgJBwgfzoL0IUKJboHadQIU8ZDVW/LXh2fU2jIFJ/I0h+urlox
         K6jqGR8nOTjU0S76wD9KUSyf0sWkv20p1LLFnrbyZTxuIy8AHZhBszRjdZbwcKOoL1fq
         pmSuIFulypB/9VsTacntmUspWy21ZoKLaT4cBJ2ouWfNuUSpLDe+3ngEwtI4Ip67pr2R
         Sc2iCchzBd5454EC3quKL46SdbVPUD7msgkFmD6Ibg4eADgwvigRlTbssh3QT3DRIRIE
         u1Fg==
X-Gm-Message-State: AOJu0YykkLqbhPhY6kQR21RVprBrZU2BUBORyrSn6mlZhn6iYbp1THfD
	X5SFtOKC+jR+bMjewdPZVI7ATJFoE4CR76Pw5PE47OIjw+xXtfZ7gBIv4ojtyfptJVfqTYNJBHy
	9SnaoX7Q1WyDOXKJ6EdB9Ey0WPLoWemPhIRNiHHrlLjWS+dGzCgJYIsNWjClpFvARNn184oo=
X-Google-Smtp-Source: AGHT+IGzRywgAhtbebax+3YKrye4FWAcGffQ0efj4jXwyF8sgDKKZZBDdhKiOBOPTqQRlXM+IXL7ywPIuyBM
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90b:1b09:b0:28b:4d36:522 with SMTP id
 nu9-20020a17090b1b0900b0028b4d360522mr884613pjb.8.1703031563577; Tue, 19 Dec
 2023 16:19:23 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:23 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-13-jstultz@google.com>
Subject: [PATCH v7 12/23] sched: Fix proxy/current (push,pull)ability
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>, Joel Fernandes <joelaf@google.com>, 
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
	"Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Valentin Schneider <valentin.schneider@arm.com>

Proxy execution forms atomic pairs of tasks: The selected task
(scheduling context) and a proxy (execution context). The
selected task, along with the rest of the blocked chain,
follows the proxy wrt CPU placement.

They can be the same task, in which case push/pull doesn't need any
modification. When they are different, however,
FIFO1 & FIFO42:

	      ,->  RT42
	      |     | blocked-on
	      |     v
blocked_donor |   mutex
	      |     | owner
	      |     v
	      `--  RT1

   RT1
   RT42

  CPU0            CPU1
   ^                ^
   |                |
  overloaded    !overloaded
  rq prio = 42  rq prio = 0

RT1 is eligible to be pushed to CPU1, but should that happen it will
"carry" RT42 along. Clearly here neither RT1 nor RT42 must be seen as
push/pullable.

Unfortunately, only the selected task is usually dequeued from the
rq, and the proxy'ed execution context (rq->curr) remains on the rq.
This can cause RT1 to be selected for migration from logic like the
rt pushable_list.

This patch adds a dequeue/enqueue cycle on the proxy task before
__schedule returns, which allows the sched class logic to avoid
adding the now current task to the pushable_list.

Furthermore, tasks becoming blocked on a mutex don't need an explicit
dequeue/enqueue cycle to be made (push/pull)able: they have to be running
to block on a mutex, thus they will eventually hit put_prev_task().

XXX: pinned tasks becoming unblocked should be removed from the push/pull
lists, but those don't get to see __schedule() straight away.

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
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v3:
* Tweaked comments & commit message
v5:
* Minor simplifications to utilize the fix earlier
  in the patch series.
* Rework the wording of the commit message to match selected/
  proxy terminology and expand a bit to make it more clear how
  it works.
v6:
* Droped now-unused proxied value, to be re-added later in the
  series when it is used, as caught by Dietmar
v7:
* Unused function argument fixup
* Commit message nit pointed out by Metin Kaya
* Droped unproven unlikely() and use sched_proxy_exec()
  in proxy_tag_curr, suggested by Metin Kaya
---
 kernel/sched/core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 12f5a0618328..f6bf3b62194c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6674,6 +6674,23 @@ find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 }
 #endif /* SCHED_PROXY_EXEC */
 
+static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next)
+{
+	if (sched_proxy_exec()) {
+		/*
+		 * pick_next_task() calls set_next_task() on the selected task
+		 * at some point, which ensures it is not push/pullable.
+		 * However, the selected task *and* the ,mutex owner form an
+		 * atomic pair wrt push/pull.
+		 *
+		 * Make sure owner is not pushable. Unfortunately we can only
+		 * deal with that by means of a dequeue/enqueue cycle. :-/
+		 */
+		dequeue_task(rq, next, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
+		enqueue_task(rq, next, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
+	}
+}
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6796,6 +6813,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 * changes to task_struct made by pick_next_task().
 		 */
 		RCU_INIT_POINTER(rq->curr, next);
+
+		if (!task_current_selected(rq, next))
+			proxy_tag_curr(rq, next);
+
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
@@ -6820,6 +6841,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
+		/* In case next was already curr but just got blocked_donor*/
+		if (!task_current_selected(rq, next))
+			proxy_tag_curr(rq, next);
+
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
-- 
2.43.0.472.g3155946c3a-goog


