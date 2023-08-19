Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B75781798
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbjHSGK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245412AbjHSGKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:10:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1B04218
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58caf216c55so55815377b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425397; x=1693030197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfSztIqO4TPTcNopxRp5cjl/PE9B2fPBfqgi/7V0jdM=;
        b=lJs/ccTkWWGzVMVSVu2ZNAC5sYkpkDcnlBoeBlArxi9XIUdYkyjHzUewuzprH4GU0z
         pOuo5Oyb+gmbFCz7yVNw7BbobJtaqL3BEjghoxA7CfBAxSiEO4ncqeoeRYbGOwSB4m7i
         yOwC2cplbHpqeaBb8t+eYUClHskdQZ1AKkzpQIUlX7AsO7iI321JgqcXjS8yydbw3Xc1
         heKKfFhZdK26oC3uFg/QfOqLOBJ8tyH4rGji3RZ+LiLN8H2biSGbMvuLsPIxgDVzR64A
         8ooMgB4YlV03D0WSeSisJrt6mLmdchgYiv5Q8VusrAD9Qs8MZKC7DttamcRu2Epeq1mx
         JZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425397; x=1693030197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfSztIqO4TPTcNopxRp5cjl/PE9B2fPBfqgi/7V0jdM=;
        b=CAFzdv/29aRsNcAUsqR9WtLxTKtVAhbK7I4dddx99cbMBX2AyJktzxt+5L37sOLPtA
         X1eciiRlLrhulMdgZPeVu0I9pGRPWTpz+9T63NV1p8GjQz386skOBdIZUy2TJOMIL12T
         8krnw9rEGSue+D2ZOEdlkbiAN1VeR0/dylBKW6VZ8LZevVOYo88h37sPdRVSE8x/ahig
         C2NNocqzcgCjLx6eWCTtSakXHcQ905MA8vAtw3uWAhc+4DJvFjlZq+rNmCwwTiMiU1iY
         xZHlyfG0g7E8oUzFAb7oxosFXkgyzPCu02RVHC5EY1Lpj6HDgZ5qQ5HXoiSHHcnPFKaV
         V3Gg==
X-Gm-Message-State: AOJu0YwlDxV72H5JPP6UGdpLbJL+/AmhjH1DYd8UWcWhQv38dXVIbonl
        wrD1rSasctLLTDmc3KT4vzVz6o2N2hHgcjq15kyFcZC8X6azfKxO6+70DhaATwswixV4rzXAJco
        wlWwy/2DqKGxc7/cfvcxO9CgtVyp2ZnnAf4PcMIKeD4+EGxI0I3y2nccPAli16AtFt3i16YI=
X-Google-Smtp-Source: AGHT+IHvKlLtWX6bdBLuB4CBnHpVc1ycApK/53UYbZicwJNOnGOItQdz0Gk/Z6ZuMikk9oX3wtq+sOKrGSvu
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:ad14:0:b0:58c:e8da:4d1a with SMTP id
 l20-20020a81ad14000000b0058ce8da4d1amr19656ywh.2.1692425397167; Fri, 18 Aug
 2023 23:09:57 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:50 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-17-jstultz@google.com>
Subject: [PATCH v5 16/19] sched: Fix proxy/current (push,pull)ability
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

From: Valentin Schneider <valentin.schneider@arm.com>

Proxy execution forms atomic pairs of tasks: The selected task
(scheduling context) and an proxy (execution context). The
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
Cc: "Paul E . McKenney" <paulmck@kernel.org>
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
* Rework the wording of the commit message to match selected/proxy
  terminology and expand a bit to make it more clear how it works.
---
 kernel/sched/core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bee7082b294f..e8065fc5c894 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6656,6 +6656,21 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	raw_spin_unlock(&mutex->wait_lock);
 	return ret;
 }
+
+static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next)
+{
+	/*
+	 * pick_next_task() calls set_next_task() on the selected task
+	 * at some point, which ensures it is not push/pullable.
+	 * However, the selected task *and* the ,mutex owner form an
+	 * atomic pair wrt push/pull.
+	 *
+	 * Make sure owner is not pushable. Unfortunately we can only
+	 * deal with that by means of a dequeue/enqueue cycle. :-/
+	 */
+	dequeue_task(rq, next, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
+	enqueue_task(rq, next, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
+}
 #else /* PROXY_EXEC */
 static struct task_struct *
 proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
@@ -6663,6 +6678,8 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	BUG(); // This should never be called in the !PROXY case
 	return next;
 }
+
+static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next) { }
 #endif /* PROXY_EXEC */
 
 /*
@@ -6711,6 +6728,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool proxied;
 	int cpu;
 
 	cpu = smp_processor_id();
@@ -6760,6 +6778,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		switch_count = &prev->nvcsw;
 	}
 
+	proxied = (rq_selected(rq) != prev);
 pick_again:
 	next = pick_next_task(rq, rq_selected(rq), &rf);
 	rq_set_selected(rq, next);
@@ -6786,6 +6805,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 * changes to task_struct made by pick_next_task().
 		 */
 		RCU_INIT_POINTER(rq->curr, next);
+
+		if (unlikely(!task_current_selected(rq, next)))
+			proxy_tag_curr(rq, next);
+
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
@@ -6810,6 +6833,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
+		/* In case next was already curr but just got blocked_donor*/
+		if (unlikely(!task_current_selected(rq, next)))
+			proxy_tag_curr(rq, next);
+
 		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
 
 		rq_unpin_lock(rq, &rf);
-- 
2.42.0.rc1.204.g551eb34607-goog

