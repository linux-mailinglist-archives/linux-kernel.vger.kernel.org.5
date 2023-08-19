Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F89781790
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245679AbjHSGKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245307AbjHSGJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:09:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD88F420E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6411f96b35so2366770276.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425390; x=1693030190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+RyzJfjvmQPTF1c97vj85wjmpXiRjlCN+3XsIWpPbE=;
        b=0bfRHx4yYkMl4d4xeoYiZIS/8Ww2NcflEoptxFlHQsa6SMycijwWINkNTPP3XwoYpZ
         3JOEiZ/nxs8HuyOcfFHpee3n+OhWhFex744v8K+ZHhOQqbaJqDtoxjIlcO0RFfXJyC88
         w2prxNxvzp4Rx5+TCkHMV7is6ZG59fVO+B+E9TYGboIReZg+J890L9L1l0jYWy7n3ur8
         XrG2/wBJ70tVeC+9cHw/hL/CW0UZ0MYd+/p9C1efIeNEA8iawC8wlRk3KLezZhc1JnGy
         XiuGznmbPelUG7IKAmedYgdXWFlICbP5piA4ThAyTBjukuG7qaSnqtglRckRTv+pFZ95
         85AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425390; x=1693030190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+RyzJfjvmQPTF1c97vj85wjmpXiRjlCN+3XsIWpPbE=;
        b=QCjMW7Nm+GVoiLGXjWwGZU5Eb8b2M2H+fVkKQ9QOueGWXPSolBA8BQBxYzxGZ/1sxz
         x8HSCsxMCDE93qDB0henCOHigcstiiHj7cb/jt4TtnDemQbkTLh6iI8VGGg+Sglb2DRk
         JRo4xH5js9K/wZFChbreBtP90uAKpwLXWzTGsyUSbVFdWQfjOWKrR14aMAWHgZdhxlMb
         W3PC1bdyiTdMl5wvsbMmleAyupfTTXSOBmLrRjmnZg9e5Ur4ln6Wf6/o8T/BklGGfTdU
         3/Hc+tZjL5WGqy6jhM6lU5tQKfJ/zd+qv2VN7/Ufh/2FvRG9vqqzrPv0ukIzB/CMR1W2
         z+dw==
X-Gm-Message-State: AOJu0YzNugGNv3kIebt1fE9FKyMEEOkohY2PLbNUvTwhDiBIVLUo5KDV
        VxekKPzhRD1YIA5TZbwck3n0n9bhv+YkUqYO3wPfucmaFxsechyyua6GbsD5NkeLveuIKufTnD6
        1uiImMx1SvYldY5IMTSmr37+GZYJLDKT7YRt36jAAGAEOgnyA2V+n5tJECT1BflnSKAMpTVM=
X-Google-Smtp-Source: AGHT+IFz3s84rQQ7riL99o85ry/SEzRrOwslxTZlvR9vhXdInSIl9fzrup8+rG3OGVRTq7BPaBd1Mjr33X00
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:add5:0:b0:d46:45a1:b775 with SMTP id
 d21-20020a25add5000000b00d4645a1b775mr10143ybe.3.1692425389804; Fri, 18 Aug
 2023 23:09:49 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:46 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-13-jstultz@google.com>
Subject: [PATCH v5 12/19] sched: Unnest ttwu_runnable in prep for proxy-execution
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

Slightly rework ttwu_runnable to minimize the nesting to help
make the proxy-execution changes easier to read.

Should be no logical change here.

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
 kernel/sched/core.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ea0a7fb144fd..2d957a14104a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3840,18 +3840,20 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 	int ret = 0;
 
 	rq = __task_rq_lock(p, &rf);
-	if (task_on_rq_queued(p)) {
-		if (!task_on_cpu(rq, p)) {
-			/*
-			 * When on_rq && !on_cpu the task is preempted, see if
-			 * it should preempt the task that is current now.
-			 */
-			update_rq_clock(rq);
-			check_preempt_curr(rq, p, wake_flags);
-		}
-		ttwu_do_wakeup(p);
-		ret = 1;
+	if (!task_on_rq_queued(p))
+		goto out_unlock;
+
+	if (!task_on_cpu(rq, p)) {
+		/*
+		 * When on_rq && !on_cpu the task is preempted, see if
+		 * it should preempt the task that is current now.
+		 */
+		update_rq_clock(rq);
+		check_preempt_curr(rq, p, wake_flags);
 	}
+	ttwu_do_wakeup(p);
+	ret = 1;
+out_unlock:
 	__task_rq_unlock(rq, &rf);
 
 	return ret;
-- 
2.42.0.rc1.204.g551eb34607-goog

