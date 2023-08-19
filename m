Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5407781793
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245728AbjHSGKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245326AbjHSGJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:09:54 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FADC421A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:52 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-26b4020fa34so1943454a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425392; x=1693030192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9QZBnIOvvRKcJymm7mHhLuhxNL5lSp4zRHTf1kfTKc=;
        b=IrtwmFmYgbINHdLd0IVNiOYq9pNfuPUpL4dOIY2Xs63wsy5/r0NpNeK2scUIXKi8Pv
         MAq6281HQDJyw1Ue3t3+EXVOjakXtLX/KDbzUSIVF6Rxifk/+m5KoaFNK+vrFEmj4P+M
         ALD3GQR7FDgebehj/pG7lYKjRJYPxmsfybuEPZXRBhURvvBfIPBQzPaiwoTAGrytdE/U
         oAPg3dIkf4qjtp97OAZRbKaQ9NuuB+XA7lWytUM0W1J//P1j+10+raByfDejHCcZmQT8
         jNBllf652egoZhvRjWdz97AlZ2HrzKQFacjexFsFhGmlMgD8aA1uFVR52KkKycqWS5bT
         bwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425392; x=1693030192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9QZBnIOvvRKcJymm7mHhLuhxNL5lSp4zRHTf1kfTKc=;
        b=e0AiYBGjjA5Fy8ifTxF/9aMx71wJ538k9BDS0BKPxP2bLcqpDEGAMl5yta1Y2F01tl
         WM3XMnfoV/i88KnVEUKSM+UWqHrqSqlAHcs+mmBiG5/44C0yYlCjDAsLYn95DsMKr2+6
         JXsBI03e47ZkRNqe3d7+qnXx43qxyy/S8uIL+3/4RySZXMQkd3rYoip7+0az14kXPPRs
         ZEYovpegtlL3S8IZDzzJen4HScwQqDHYUQnbQGkPHWoKuzamhkRQ6bzTMMNVC+AMKWML
         ETa6qxdCjh3eeXmK0C/tL/+Y4YNiZDSS1BSUaaqaPEI9oDFEeWdhB2kmX8nEb7g0SstU
         eTtg==
X-Gm-Message-State: AOJu0YzSKuqDc4CfQ5C4jmoPAXdj0neKfgTwXJYMv0JNcWYTu9agab3I
        lrDWSqTaJSGW+QRgp+dGg9rWzmF3c3bN1+dwUUwTXK+kelBHznJtRMppk6NJ+leZhi8veUkTXon
        SK9r2AUmWdtqzo8xnIgMIkaqIG2O0ScVon/u1/GhkuhVL+LmFHl9bk5E8THcyS4fNL3rs6bM=
X-Google-Smtp-Source: AGHT+IEyWJ3HwuuFQjnqEhVPd9/PWgF6K3Vj7MaiiXRdAlnWHahkjywUWBSI2ssI8lTFkvr1ws+2AnQtx83W
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:e5cd:b0:1bf:cc5:7b57 with SMTP id
 u13-20020a170902e5cd00b001bf0cc57b57mr496179plf.3.1692425391735; Fri, 18 Aug
 2023 23:09:51 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:47 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-14-jstultz@google.com>
Subject: [PATCH v5 13/19] sched: Split out __sched() deactivate task logic
 into a helper
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
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
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/core.c | 65 +++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d957a14104a..76a42f21dda7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6562,6 +6562,41 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 # define SM_MASK_PREEMPT	SM_PREEMPT
 #endif
 
+bool try_to_deactivate_task(struct rq *rq, struct task_struct *p, unsigned long state)
+{
+	if (signal_pending_state(state, p)) {
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+	} else {
+		p->sched_contributes_to_load =
+			(state & TASK_UNINTERRUPTIBLE) &&
+			!(state & TASK_NOLOAD) &&
+			!(state & TASK_FROZEN);
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
@@ -6652,35 +6687,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
2.42.0.rc1.204.g551eb34607-goog

