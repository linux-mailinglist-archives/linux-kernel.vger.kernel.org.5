Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B147E2D04
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjKFThI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjKFTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:36:40 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC371707
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:36:07 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ae5b12227fso67172917b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299366; x=1699904166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0t48YFx0UVkNi0jaFWpek94vC78jiuGmEf4m+wee/fQ=;
        b=C0tmMvW6EDloKdIqfq6GmYrjwV31rwd00BAc5YzsVqYfSReZHw0VOD2LNj6hDMaNR+
         mcxx9ogkukKMM4MfNVh+FX2DQYlItetz2AzR0IsxlcfgsJEVHa5DQCe6D3wNiSWEcLHM
         8JIU/jSTh4C3NHmwZETY97Y8UIQjhNAuTNbW9XppccP98o3j7sh5LBVqoD8Tyf/525d+
         6TcyjfG/8NYOfK4PYHDcMuPKkBDezK90h42vNgLEUBbJUS3ps+PiburhiPKf3xYFdY6X
         sFbzm4OtE2nImHOlnYHfeIA6C7fmOvwUT/5fAIiZ2jaHDnrHhRasrDBROmh8WDPI/jIo
         GP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299366; x=1699904166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0t48YFx0UVkNi0jaFWpek94vC78jiuGmEf4m+wee/fQ=;
        b=eH0eOz2NkAVFbdemG5VLReZjubpgEllj835O4S+aaVIKUJNZUAqB+V69k91MGAFk4A
         ZIhuRUcHdq5tdweKVUYwzTFxQxIm5zA8duI27GRQfhHt5Brcdn3Wvd4Puz0V4P8Hk9TH
         zHJ/RY67IZikUCbkJTiv/bRSMwgLSLavbQ9CiPnppgXUdux3gmzj/rjaYShhv8AjZAnw
         kqjOfeoFcMQZycUzQzn+GzXxVelv0O+HkrY1tTCWhr2TyfCdExs+AtLR9vVCD+7liLRy
         rp/R7nIftTTwWww72FQ3Nn1e53fseNP4ljXA8LFsBfFhtFNtrArFOwQmSHtyG22siJ+W
         dkVw==
X-Gm-Message-State: AOJu0YxplOcN1udXeds8mxl202HfvMh5MdSj2XzgUmHiQbEj2x5zPyZh
        4k8qgSnEJnBNkDiXcj4wxHHvY2cMtZKNG+d+7Gz3uetMUeO+MPrbcvzJymqCY0jSLWNmRgkS8PH
        ItmmHFc4Pm2cwzXnFX2YA4Jgd58bzDNz08qMWl7rRVbxckSJbXDIkJ/RpC29LFlWlQgYNOlU=
X-Google-Smtp-Source: AGHT+IGNLfe0+euHxIci+tIjggk76N+xFg2VyEIJgcQl313pCoDUTxW/eJMMRAm747JUNmEl2yiynWjX68CD
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:4855:0:b0:592:83d2:1f86 with SMTP id
 v82-20020a814855000000b0059283d21f86mr221121ywa.4.1699299365819; Mon, 06 Nov
 2023 11:36:05 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:34:58 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-16-jstultz@google.com>
Subject: [PATCH v6 15/20] sched: Add proxy deactivate helper
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

Add small helper for deactivating the selected task

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
 kernel/sched/core.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5770656b898d..1b84d612332e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6612,6 +6612,22 @@ static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
 }
 
 #ifdef CONFIG_PROXY_EXEC
+
+bool proxy_deactivate(struct rq *rq, struct task_struct *next)
+{
+	unsigned long state = READ_ONCE(next->__state);
+
+	/* Don't deactivate if the state has been changed to TASK_RUNNING */
+	if (!state)
+		return false;
+	if (!try_to_deactivate_task(rq, next, state, true))
+		return false;
+	put_prev_task(rq, next);
+	rq_set_selected(rq, rq->idle);
+	resched_curr(rq);
+	return true;
+}
+
 /*
  * Initial simple proxy that just returns the task if its waking
  * or deactivates the blocked task so we can pick something that
@@ -6620,10 +6636,9 @@ static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
 static struct task_struct *
 proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
+	struct task_struct *ret = NULL;
 	struct task_struct *p = next;
 	struct mutex *mutex;
-	unsigned long state;
-
 	mutex = p->blocked_on;
 	/* Something changed in the chain, pick_again */
 	if (!mutex)
@@ -6645,30 +6660,14 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		 */
 		raw_spin_unlock(&p->blocked_lock);
 		raw_spin_unlock(&mutex->wait_lock);
-		return NULL;
-	}
-
-	state = READ_ONCE(p->__state);
-	/* Don't deactivate if the state has been changed to TASK_RUNNING */
-	if (!state) {
-		raw_spin_unlock(&p->blocked_lock);
-		raw_spin_unlock(&mutex->wait_lock);
-		return p;
+		return ret;
 	}
 
-	try_to_deactivate_task(rq, next, state, true);
-
-	/*
-	 * If next is the selected task, then remove lingering
-	 * references to it from rq and sched_class structs after
-	 * dequeueing.
-	 */
-	put_prev_task(rq, next);
-	rq_set_selected(rq, rq->idle);
-	resched_curr(rq);
+	if (!proxy_deactivate(rq, next))
+		ret = p;
 	raw_spin_unlock(&p->blocked_lock);
 	raw_spin_unlock(&mutex->wait_lock);
-	return NULL;
+	return ret;
 }
 #else /* PROXY_EXEC */
 static struct task_struct *
-- 
2.42.0.869.gea05f2083d-goog

