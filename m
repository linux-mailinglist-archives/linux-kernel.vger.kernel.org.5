Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899B47E2D01
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjKFTgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjKFTgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:36:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7188173F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:36:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso5882315276.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299361; x=1699904161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8WchLjhxzR8hLwmAM2b8K3LlHrmaAbxbI1VulbCNAg=;
        b=ng3201E88f0muoa/itwNYD0l/qp/0PZVu723T1YVJth0r44XVnz6xyJNcpzjn2Ounw
         7SlVT0xm2+5eh+2RXgTGEj/GhLGe5x45UPPm+JT1n6LmItMQUNHtfyq+9d3pltLZRjvF
         /uN/O3S7LMUfIJ3LMb/bpVcDVwLnXk6MoTLHWRoIgis56FXzjg3HLT0ph+nFM8zzP7ft
         SZYg+J6J/HODFwShn98jWrV3dsoRnH4FffgaLqveuC2qH1pRDRI49AWIQUbt/yviW12o
         mJaXJd5pofJC17aPaWKp17Y31c/IYysIYPF55aO3gu5hWCX8nXw/zcFhDjxDiabQHgjM
         Wd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299361; x=1699904161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8WchLjhxzR8hLwmAM2b8K3LlHrmaAbxbI1VulbCNAg=;
        b=EQHWJdTEJ2+nJCra4aZMl4t4fP8RqJtKbzISaGO/Hmt0luGjuEXqcTRhh61gZmv5Yn
         ZLMhf8PPTAQA88TEVDljwKnx3nDRC8HFsoFlpkC+9TnsgywP2wppF6IlFUgagN1PKrKM
         DTUzHDw53J8ER+aXr7REj5h2/sHhqy2ykNu3OOvizuxgAfeQRMhMMP1Q4PdzEYqOuy5e
         oeJAshFdCtmNV+Yr2rQ3MaehGRy/hPWWTiHw5ypvHKq8LVynAt0ECBcnvjS3JVMq5iRW
         mzesQUdNyKNXTyWRNWZV80IFz8Z2ncVr+FzUtZrxBS+qIGDbKUhlSJJXNaR7he1yN5Gw
         jsmw==
X-Gm-Message-State: AOJu0Ywsg6amn+jwMqk170gaCZkDZIBkC4fljXWY8zMP3+SrN4UqkXzj
        UrEtQkZHpAOikQ6FqLgCfgXRX2djXqACnUtq8HjPRnVL1USPpouJDx0ayHR+L+5TPqtz7iberji
        NTo6dYks3bXA0mFtlzFUaisrpSV+7ieh1wQFtYnxmYQ4M6u/dI6IYysuTZHPLWzoj6ScfwN8=
X-Google-Smtp-Source: AGHT+IE2LagPZOXLu2Dujz9sY/wkyg+vRcsLP1Mi7QOxbjwhBOs+j0G+W0ghI1VCLGiX1IJn3Kb0v07PkhGQ
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:aae7:0:b0:da0:5a30:6887 with SMTP id
 t94-20020a25aae7000000b00da05a306887mr537996ybi.4.1699299361477; Mon, 06 Nov
 2023 11:36:01 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:34:56 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-14-jstultz@google.com>
Subject: [PATCH v6 13/20] sched: Split out __sched() deactivate task logic
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
v6:
* Define function as static to avoid "no previous prototype"
  warnings as Reported-by: kernel test robot <lkp@intel.com>
---
 kernel/sched/core.c | 65 +++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9931940ba474..1b38b34d3f64 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6575,6 +6575,41 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 # define SM_MASK_PREEMPT	SM_PREEMPT
 #endif
 
+static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p, unsigned long state)
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
@@ -6665,35 +6700,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
2.42.0.869.gea05f2083d-goog

