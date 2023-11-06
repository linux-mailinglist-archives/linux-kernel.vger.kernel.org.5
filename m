Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D967E2D05
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjKFThM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjKFTgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:36:42 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EAB198D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:36:09 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b31e000e97so66741107b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299368; x=1699904168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvEjJWcD2rwHfLNLtqnw1VcwI8/iMYn+p32Qq0ErP5M=;
        b=hBNwZUJgExXdTjKGaNRrvKwIHWOo60MChEK7WMdG/2r+L4o4t0Bg1Njw9JfBLwvpmH
         QIWsbO0c+G4aB9WoDuDIUodTfYY0qXYA8iy4nhXBfA/26qq6ep6r4/gJgUMzOwVordxk
         cxzBvFoq2Iz1tIarlUwGKg5kkSsXBxiQ4zSoEFjMGm3fnmpLIAFVIYP1IrGyPeDFs0fb
         VS9Jhw3IdhTtZQV//aKiVdjUrdRODufnWradbJ+sn+Hp6OxZThesKguPSQ8qbLsipfMl
         vsOuCn25bUaI5vwmt0EBu5dX7sRZCBg6GZYBIsU14pMh3s8W6OXvswbYAXo3CgFfbNqL
         Fpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299368; x=1699904168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvEjJWcD2rwHfLNLtqnw1VcwI8/iMYn+p32Qq0ErP5M=;
        b=Oa4uJvzo+y5dege3s0QFRJCDL6Dm5Dw8CywamUGcFrZ5MCAQR+koOC4uiRIbLeiuwk
         eR4+B41QsdukKrte502bq3jD55i3nl3V0JwwixLFYPvURXJNMpSmv9n2KYCdGo2KbBTe
         FQCMv51AEt+2bYPn/vpPya02YbFqgNK5U+CeIvg5PL96RrcXD4pL+uMmpcP8rg9W4g0Y
         CFd+mTm30ObERGVtIIq1tJnLJPrDUEBL4jeYGESVFueTPZQDwn7DUXJ76jPPkNmZSnvV
         tRE8WWSyYXJg+J9I8SuTlfP3SNSMUZY3zVxtS4XOT89CvfeiT9OYR8++rQLnjLhT5FXr
         ZpEA==
X-Gm-Message-State: AOJu0YysDUBXrp747K9vlsOkS4Jx2UwEjxv1YghZPKl/jdSnA3WYXBth
        xZZ6q87Xn7zLNZrfbd/wbJWRU4Ndz4epAo2gY4brGpQ8WnZuQWQdXfcyWU5ow7AAFgHmXKiAhfd
        4F4sJTgYAWBlZxBb8GA/BgSCDVsQ71iUHPz2z+LGO93ACr1ayTIUnc8OikNb7nEUzZkYoSMo=
X-Google-Smtp-Source: AGHT+IFWpn9/uxIES+a+vBpl6VRwj4UwUuGBp85gPDVfQBsopGfvAbPF3nY8SktB3xMf8rS6Kctbh3hDkuJ4
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:9385:0:b0:da0:59f7:3c97 with SMTP id
 a5-20020a259385000000b00da059f73c97mr546655ybm.12.1699299368307; Mon, 06 Nov
 2023 11:36:08 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:34:59 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-17-jstultz@google.com>
Subject: [PATCH v6 16/20] sched: Fix proxy/current (push,pull)ability
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
* Rework the wording of the commit message to match selected/
  proxy terminology and expand a bit to make it more clear how
  it works.
v6:
* Droped now-unused proxied value, to be re-added later in the
  series when it is used, as caught by Dietmar
---
 kernel/sched/core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1b84d612332e..c148ee5dcf7e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6669,6 +6669,21 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
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
@@ -6676,6 +6691,8 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	BUG(); // This should never be called in the !PROXY case
 	return next;
 }
+
+static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next) { }
 #endif /* PROXY_EXEC */
 
 /*
@@ -6799,6 +6816,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
@@ -6823,6 +6844,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
2.42.0.869.gea05f2083d-goog

