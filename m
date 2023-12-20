Return-Path: <linux-kernel+bounces-6145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED814819516
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643D3B24116
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE34D16424;
	Wed, 20 Dec 2023 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhvuaL8c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DBC12B86
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e6f42b1482so32899937b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031560; x=1703636360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mv/Ya0qyoH+vxh4Wg8EU7u8l2QsK4QPZg/dyROX2k8=;
        b=uhvuaL8cu8MJEgAZmbYYWpQgyXuA6Z3sDesm/yUhgHlCP26kruH1RnHgmnbQRJ9MBu
         i2Ggsfd8dFiQNtD2EJ97lTBrv+/fzBzRQP/zV/RWJRUkRbuqk1Giytc2pdpIXhyRU5hT
         DmH/4c08EFMz69/GJThJ9zSuK/KbDmspQ/I3CX82ucp5yUqZjzDvqlhrVNiBF5H3BkmP
         507j0fxua9GmPEcZNhPk3wbJGPRaEb6ra6a3LLge3uPJNC0/wYccIswabaKk0XBtA3Xi
         0sofs+QPDSKnoQb7n8hLb4U0EZ5K+4P5Hg5mXw3YjqjtXRkLfnSn3Oe2WgYMxCpRCsZS
         piiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031560; x=1703636360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mv/Ya0qyoH+vxh4Wg8EU7u8l2QsK4QPZg/dyROX2k8=;
        b=HDG+opzlbiVdQb9mQaonxtpRGfqdmuxi+1LMdn1/LATi7I1ehnGkKUzxtocoMG1t+C
         m0dMwDu/Qcp1mNNZ9yiVnIdO847i+skT/XbtvHzGSJvgkT0boPfGk7Xrq0iIMbAXyAzh
         IEE3nTciVHZqL8GHfEHcwlYJjhHCutmNytjaUsfZ5BP+LBpwjMvYf2mPYlbVzSqpknkC
         NrKBPSQ/XuVlKgeWyJLnzhGAio2MRaQbYt4LbeKr9PGTSJfTrKRTAKPByyNQnsS8C/1D
         aG39ji6hQgV5a+0YoAC5ScTDlvxt+KC7lwj94+jaji8+QWZhoV+raWBoMMrBQalSYrW9
         dQVg==
X-Gm-Message-State: AOJu0YyiOxFrpgNTVcYK9h2Y5DTx9Ou4jWUVssllYHGSuW+B5EQVJ6Sz
	a8kWU/w0ZGs+YqRiwfkMXkLkzsJbPShGf0LLYbchB40l2k3AjSlFAU3/Utn+OlBfnBQlKzTD2iS
	8omfVgGhWm2Yaqt04GgglqAkUB9sdoxrO1CnOOkBYSWLTZ44I6GWIBbumDPsoHS7CFqul4Lo=
X-Google-Smtp-Source: AGHT+IFQ0RfhWtQZ00CmejkVao8cQwKI3hSxcJKn/Ukt5j8xgAzlGvI1hKlnfgEC0MM8uSIt3AMM2g2tRiKE
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:c02:b0:5e6:28b2:8bf2 with SMTP id
 cl2-20020a05690c0c0200b005e628b28bf2mr1829905ywb.0.1703031560363; Tue, 19 Dec
 2023 16:19:20 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:21 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-11-jstultz@google.com>
Subject: [PATCH v7 10/23] sched: Split out __sched() deactivate task logic
 into a helper
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

As we're going to re-use the deactivation logic,
split it into a helper.

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
v6:
* Define function as static to avoid "no previous prototype"
  warnings as Reported-by: kernel test robot <lkp@intel.com>
v7:
* Rename state task_state to be more clear, as suggested by
  Metin Kaya
---
 kernel/sched/core.c | 66 +++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0ce34f5c0e0c..34acd80b6bd0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6571,6 +6571,42 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 # define SM_MASK_PREEMPT	SM_PREEMPT
 #endif
 
+static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
+				   unsigned long task_state)
+{
+	if (signal_pending_state(task_state, p)) {
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+	} else {
+		p->sched_contributes_to_load =
+			(task_state & TASK_UNINTERRUPTIBLE) &&
+			!(task_state & TASK_NOLOAD) &&
+			!(task_state & TASK_FROZEN);
+
+		if (p->sched_contributes_to_load)
+			rq->nr_uninterruptible++;
+
+		/*
+		 * __schedule()			ttwu()
+		 *   prev_state = prev->state;    if (p->on_rq && ...)
+		 *   if (prev_state)		    goto out;
+		 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
+		 *				  p->state = TASK_WAKING
+		 *
+		 * Where __schedule() and ttwu() have matching control dependencies.
+		 *
+		 * After this, schedule() must not care about p->state any more.
+		 */
+		deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
+
+		if (p->in_iowait) {
+			atomic_inc(&rq->nr_iowait);
+			delayacct_blkio_start();
+		}
+		return true;
+	}
+	return false;
+}
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6662,35 +6698,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	 */
 	prev_state = READ_ONCE(prev->__state);
 	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
-		if (signal_pending_state(prev_state, prev)) {
-			WRITE_ONCE(prev->__state, TASK_RUNNING);
-		} else {
-			prev->sched_contributes_to_load =
-				(prev_state & TASK_UNINTERRUPTIBLE) &&
-				!(prev_state & TASK_NOLOAD) &&
-				!(prev_state & TASK_FROZEN);
-
-			if (prev->sched_contributes_to_load)
-				rq->nr_uninterruptible++;
-
-			/*
-			 * __schedule()			ttwu()
-			 *   prev_state = prev->state;    if (p->on_rq && ...)
-			 *   if (prev_state)		    goto out;
-			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
-			 *				  p->state = TASK_WAKING
-			 *
-			 * Where __schedule() and ttwu() have matching control dependencies.
-			 *
-			 * After this, schedule() must not care about p->state any more.
-			 */
-			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
-
-			if (prev->in_iowait) {
-				atomic_inc(&rq->nr_iowait);
-				delayacct_blkio_start();
-			}
-		}
+		try_to_deactivate_task(rq, prev, prev_state);
 		switch_count = &prev->nvcsw;
 	}
 
-- 
2.43.0.472.g3155946c3a-goog


