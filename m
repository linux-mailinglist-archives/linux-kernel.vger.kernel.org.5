Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374A7781797
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbjHSGKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245288AbjHSGJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:09:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283AC420F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589bbefa960so23801787b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425388; x=1693030188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhWUfDYFiFR0g9UssCut9sOnUGF6ZibWUHaZlROgj5E=;
        b=vperNweReJtowhfbJTjDzu8/bLwN3Amu8yHOwh38O5IGuY4DNKpbYEdyPwoLa1k8R0
         BStYWlXTltBEn2sGnesMsuXMJsmiUwtbyl8tIXmeADW2/9tw/IX0BPWcgdG6njm5J1Uu
         1grKmDWJ6mZf0GoRTPvahweNJ1HoCyLVG4/ypL0+r0IVRL6i1ON/CKS5q08qhH87CYoP
         RxxnydOthk1B3uoUE6eEpUyYVjNcA8F/4n/EbfV36FjhScnBzVcXkyzuKjYhY25h7FN4
         uW1mrVBGneLSpSz+29j6g2GWIVb8vOZ11WqOf72PJ0ejaXexR5fKoKcptBoIDam6nWjO
         mhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425388; x=1693030188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhWUfDYFiFR0g9UssCut9sOnUGF6ZibWUHaZlROgj5E=;
        b=RpoLRsZi61c1q82Rd08vjYahBaDsVVEVHVhBtWUfK7+itkVpyFBc+zMFjlMbs1nEuN
         jEDbOMZ7qVfrSsdeNlMWrgx0lbFzTVZDb8lZqr+757L4cehiUzPyIfiNgvzAdDbzwCZc
         8mqayHo1BsD7MXCNdtjruNLDVsfn65nXm8vu2rf48/NH0sdRMZ7B0ZMFEz/oOumuRhay
         aTgtToZvAFulZT2fc1Tnpmz1f13Dmrgu52Q8pgcWKCBY4x2LXt060Q681ZfQe2WVhwhx
         K2bwflAqVVxXhqRwf5GEh/333bj62Jro9294dMtwcLNCH/LDUeDXMwGzCGEEkkKfsghe
         NI7Q==
X-Gm-Message-State: AOJu0YywrpV+ggDKg+chvJsg+6PLIuafR+WN6G5VvU/WlkwFXiqOhvqO
        rxx1cZu7sBX7Szpw3cFHAAD2k/E1E8ODXLxTH2A2Di+7bYT9M7A+5QWky/SJvya8PQcr3EZIlWk
        Fi00Gmi9w2Yqy8YOhcid+leL8okqHAUrLqDqMCcgljPwyZu6TwXB4+MZd0586jErVU4qWz/4=
X-Google-Smtp-Source: AGHT+IGTiV+1SINjoePAgr8RNfPEvrfwnKOXgbCYsAnS5eSqEEWulUHB8i/2MQWHZbsvqQZMwpmWGs7Yw2vV
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:ef4c:0:b0:d4c:fe4d:31ff with SMTP id
 w12-20020a25ef4c000000b00d4cfe4d31ffmr9804ybm.8.1692425387943; Fri, 18 Aug
 2023 23:09:47 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:45 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-12-jstultz@google.com>
Subject: [PATCH v5 11/19] sched: Fix runtime accounting w/ split exec & sched contexts
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

The idea here is we want to charge the scheduler-context task's
vruntime but charge the execution-context task's sum_exec_runtime.

This way cputime accounting goes against the task actually running
but vruntime accounting goes against the selected task so we get
proper fairness.

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
 kernel/sched/fair.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 808a91ba6a5e..6385693f1da6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -891,22 +891,36 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
+static s64 update_curr_se(struct rq *rq, struct sched_entity *se)
 {
 	u64 now = rq_clock_task(rq);
 	s64 delta_exec;
 
-	delta_exec = now - curr->exec_start;
+	/* Calculate the delta from selected se */
+	delta_exec = now - se->exec_start;
 	if (unlikely(delta_exec <= 0))
 		return delta_exec;
 
-	curr->exec_start = now;
-	curr->sum_exec_runtime += delta_exec;
+	/* Update selected se's exec_start */
+	se->exec_start = now;
+	if (entity_is_task(se)) {
+		struct task_struct *running = rq->curr;
+		/*
+		 * If se is a task, we account the time
+		 * against the running task, as w/ proxy-exec
+		 * they may not be the same.
+		 */
+		running->se.exec_start = now;
+		running->se.sum_exec_runtime += delta_exec;
+	} else {
+		/* If not task, account the time against se */
+		se->sum_exec_runtime += delta_exec;
+	}
 
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
 
-		stats = __schedstats_from_se(curr);
+		stats = __schedstats_from_se(se);
 		__schedstat_set(stats->exec_max,
 				max(delta_exec, stats->exec_max));
 	}
-- 
2.42.0.rc1.204.g551eb34607-goog

