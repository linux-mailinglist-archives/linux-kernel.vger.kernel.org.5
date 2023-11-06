Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E937E2CFF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjKFTgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjKFTgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:36:09 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC21723
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:36:01 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-280465be3c9so3227574a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299360; x=1699904160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlM0fUGrXkJ77vpxrL8Ua3abDkMWMrcPq7YvjnZzG1k=;
        b=RK/X8K9qOxJs3epYdFPaemyKI7J1R12sGYnQSKcCYMnAzRGStO1qECjUhuu9m/2no+
         jT3qummZDFbo/w4tGzL4t3uD+f1kSEAjF0shzjvcNvhrGYhDDBMWe+l5OkjS78lmnZ7N
         KFJNHuwDZ2H6KvskuOnzyhWz19C6+2d+Un3DhxFKReFYi5W/wk+V722W8dP7tN7RHmri
         PSYbBBYITsCCD/jWtYamBpSH3yF2pY1YPGVHNDzX57eB3wMhRmhJwGjLDCvh2URAM+Ix
         AC3mm6rXaXvgCz315aIPTeoYwyZvWK1F6HKbUxefyNXigAhRudpk6ymPxlNeS93xQ13n
         kvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299360; x=1699904160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlM0fUGrXkJ77vpxrL8Ua3abDkMWMrcPq7YvjnZzG1k=;
        b=qyYMmo+e/hAVeJHtFFqwVDUK36INljF+89IkgTk8icVj+qVhoIzrma7YJ7QjGTjanf
         lxyFoeL2njJauHOswNCOk+5zGMOd/yRkQ3SHx/AxqB6aGwFgJeDr14Gd3lz/yXzBYDEB
         sHybPOmBDZZzk7zDbnJHp1l8nYyU8i/sZSRHZ3js3+InCQCY8H+tzEjlqQOub0v+l/9z
         RuCPCPj4aG80O+SaFoQA467ce8yjPExsCuyXfvkbrZpTv0aC5WWerYMAPfJgxyyeewFF
         hP37F5uHX7l7xqcf5+ud0VJtgK6yaJLfta7XHjhWTYOlmjlkAgXvR3TzPX2WJkC6DJHe
         jSJw==
X-Gm-Message-State: AOJu0YyClRRnkL0/WV5xu2RsXyU547J+uq6cansDYl5BBQlgy4nNduDR
        FbKPlGB/6EsFYlz+X7CAbRn7UTQtPp0KfcNaUUs6IPnw/oGJlM8qqquMhx5eyCxOFLsjc9ZrC3p
        lLcV/JUwo7R3exEi/9viNmd2ANWphd1GrECz+06Ek6lyCM0fs7TGCtnwmn70jL7xVAPkYo1A=
X-Google-Smtp-Source: AGHT+IFuSY4TKULEwQRlAhcK4DIy+tTFWR3TVxo3zbojlzz0Z6KY40zo8comijA7uSLG852mFFc+HVZbfhED
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:c708:b0:280:47ba:7685 with SMTP id
 o8-20020a17090ac70800b0028047ba7685mr14653pjt.0.1699299359325; Mon, 06 Nov
 2023 11:35:59 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:34:55 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-13-jstultz@google.com>
Subject: [PATCH v6 12/20] sched: Fix runtime accounting w/ split exec & sched contexts
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
index 3d5c1ec34bf7..1aca675985b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1144,22 +1144,36 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
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
2.42.0.869.gea05f2083d-goog

