Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81847781792
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbjHSGK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245396AbjHSGKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:10:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68017420E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6b66b41232so2249510276.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425395; x=1693030195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncvKoH6sf/PCzVuSyD3Igzt/6x5kYeoqdIlMIk/5YEc=;
        b=DV0X2Hy9Od7cM66+eII29AbOZjYpPKW9SDJyayjHTkLSCQ07vlfKZgbzI+FLGWI9fx
         hm6698Sc2Q4K+txTIjgVnW2+lEAvPddNtqoslR6RGLJl8f6ZSe/qNEOWMk4oWQV9wBet
         bZyly41vDC9QoZ+rpr8Q2bdCzY3tW8eRzHalJ9eHVxuXCo05XN3pThjh1MK+pTywr4/q
         K6p0IwuwFAAlkChPMCDAIrCX9jpJsyMe3W8oZeSbb/IBQg3FBZ46qLIddsCeUAmqlarf
         z08hwmBBndPd7UjYbgej6El9y+KRBWqS5QZohVyVRD0obo1DIa7c4u++A7f4DbFA+AQs
         fgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425395; x=1693030195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncvKoH6sf/PCzVuSyD3Igzt/6x5kYeoqdIlMIk/5YEc=;
        b=e1Yqt6QRTGSNBAmTA9w169pbqVjZyIAGKPWvaXUvBzOov3C9KhfHlDAJjdsdXwlDux
         4YrejZ6BqIG4r5dRm2sdtvfDehp5B3BNGxaHPM3sxKdDPYzCcETHA3x0YnbYtDdPo/zF
         K/HofrHVEekKUhRtLIkzE79cDo2h66zeD3T31nAeHiS5eugK5KzIV+E0tDa06OMSWn5B
         QOWagytfJ4D3ll6Qg/7gJZfpuoO6IsVl2l+dUA4tfnjZn8vi/mzbu4Py2xyTNwK9BGfU
         /NcYUZZUhmxSnFcIiQcr/SLqvfNyyOTFQcQh6RlhOEHko661wM2N94TSwzOgxFAwGb5f
         kFdQ==
X-Gm-Message-State: AOJu0Yww/c2GdVG8D94Fgh6PpSDrNy2StNiZRjpTyu7x/3uY5WQVt4m/
        pPddXKtDXAD54M2n2mG8nCmNCyGwNBZU89++Dyivy337qyJCmlPdbO48Ccak3WzPA+/08TORUA9
        r/hGNhnNim6DMYFH4wvQ1UarBSsACWKwotC7iLGgNJvZCG2ZsZ/oUrgRXiUfrgXne0LnFYA8=
X-Google-Smtp-Source: AGHT+IHnpgfQLfvQ7spuyWowrDhtej92N6k+Fkuj/lLh41SjSTvPgOfG5Rit0qJTH2bkK1lGbaeF5lnm/m34
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:1612:b0:d47:f09c:cc8e with SMTP
 id bw18-20020a056902161200b00d47f09ccc8emr9093ybb.10.1692425395416; Fri, 18
 Aug 2023 23:09:55 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:49 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-16-jstultz@google.com>
Subject: [PATCH v5 15/19] sched: Add proxy deactivate helper
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
index 72d0803c7d47..bee7082b294f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6599,6 +6599,22 @@ bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
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
@@ -6607,10 +6623,9 @@ bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
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
@@ -6632,30 +6647,14 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
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
2.42.0.rc1.204.g551eb34607-goog

