Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86A7E2CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjKFTgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjKFTfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:35:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4243010E0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:35:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a5a3f2d4fso5597486276.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299348; x=1699904148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7MPkRceNH3DZ48m8K5H1aiiXD4O3G2rzC5nk4A0l5dQ=;
        b=RUTh5ND5THQ00isgSf+h1XSx89Nx2eHRZ5tDdhQxmu0cwQ5KgnDqquYLYk4lDps+Od
         VpmLhuCOXDwA0wy1e21L58M91i7YaB+swvNGEEpqpEW2MM/w7Rd3UzXPXZhxT4cYBitO
         KhO25GNLFMXrqd8OhuhVe7zTz3iyarw+ua/wy7ChGD5sQCE0ytfGBBv2jTn2hOQKV7Kg
         yhxlCIXiVVn8Na4fV1jUTEDC7InBTi72mlw5NQ2sLFoWALJW3I+oRvTv6vwJgCHxrHcC
         fYnHYfuytLGb7rAVXuUtactH6juORxdPAiDWO0mBq1Y2G1gRcRUtCh1uKR8cYg+TM9IY
         RDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299348; x=1699904148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MPkRceNH3DZ48m8K5H1aiiXD4O3G2rzC5nk4A0l5dQ=;
        b=oOgj8UtSJUNpIy6gHQVd4Lis8hFfx8CmgfdrXkoSZwV8aWJKDKWUCTU4UzzQoCn04v
         /o/rpI4VWGFp1GB8ZpeToLor832PxpvyRN3u1p3FJLChnDTIoxoKnBogTOFwL0FnzcVb
         Yzi6jemf8La8NxGW3qT89t6HGzF8YY78DCpJicJATIy27VNPW1Fi91D3p/YrLFdj5aFk
         lsK9s5V08ZXNj+jBxqi1xCvJMIZsU0oC2zcSa8zuU4xNpeZphO9WO44W6ETWX/Rclc06
         4abEjzw+OKgWaSuOJ9GtLk4EO22x3QraWGCKVMkSM90j5ZKp5QcHQpE47f+Lqc7IfLZt
         5PRw==
X-Gm-Message-State: AOJu0YxIUTfYWnpNjO4Ey49l1vLEYrzIj4nUpiB4h+2SAiI2NsMmfXoe
        GLen9So1wlqRd0Gfq7XyDzc109l2otkMiqQ3mhvhTo14ech/F46Wk5D+fxII+QgPUSzKN4V0H32
        79qwejdpy4XtLkZPnKDg8ArRlqYpZ8PWWNK44q73FOUH9tHiM7NpDvu7i2rAYcpEgYmx2peg=
X-Google-Smtp-Source: AGHT+IH2v0IY4Ooueuqum1UEnJEfRT9m5qDMVJhlOrt7jMHjxnXfjwd6dqtfMq+xdOOHjo8tQyjdxfnukRBx
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:b108:0:b0:d99:3750:d607 with SMTP id
 g8-20020a25b108000000b00d993750d607mr530175ybj.8.1699299347935; Mon, 06 Nov
 2023 11:35:47 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:34:49 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-7-jstultz@google.com>
Subject: [PATCH v6 06/20] locking/mutex: Add task_struct::blocked_lock to
 serialize changes to the blocked_on state
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
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
        Valentin Schneider <valentin.schneider@arm.com>,
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

From: Peter Zijlstra <peterz@infradead.org>

This patch was split out from the later "sched: Add proxy
execution" patch.

Adds blocked_lock to the task_struct so we can safely keep track
of which tasks are blocked on us.

This will be used for tracking blocked-task/mutex chains with
the prox-execution patch in a similar fashion to how priority
inheritence is done with rt_mutexes.

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[rebased, added comments and changelog]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Fixed rebase conflicts]
[squashed sched: Ensure blocked_on is always guarded by blocked_lock]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
[fix rebase conflicts, various fixes & tweaks commented inline]
[squashed sched: Use rq->curr vs rq->proxy checks]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Split out from bigger patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Split out into its own patch
v4:
* Remove verbose comments/questions to avoid review
  distractions, as suggested by Dietmar
* Fixed nested block_on locking for ww_mutex access
---
 include/linux/sched.h     |  1 +
 init/init_task.c          |  1 +
 kernel/fork.c             |  1 +
 kernel/locking/mutex.c    | 24 ++++++++++++++++++++----
 kernel/locking/ww_mutex.h |  6 ++++++
 5 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 22a6ac47d5fb..a9258dae00e0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1146,6 +1146,7 @@ struct task_struct {
 #endif
 
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	int				non_block_count;
diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe6b..189ce67e9704 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -130,6 +130,7 @@ struct task_struct init_task
 	.journal_info	= NULL,
 	INIT_CPU_TIMERS(init_task)
 	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
+	.blocked_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.blocked_lock),
 	.timer_slack_ns = 50000, /* 50 usec default slack */
 	.thread_pid	= &init_struct_pid,
 	.thread_group	= LIST_HEAD_INIT(init_task.thread_group),
diff --git a/kernel/fork.c b/kernel/fork.c
index 1c3f7eaa9239..47b76ed5ddf6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2353,6 +2353,7 @@ __latent_entropy struct task_struct *copy_process(
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
+	raw_spin_lock_init(&p->blocked_lock);
 
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 73064e4865b7..df186c0bf4a9 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -592,6 +592,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	raw_spin_lock(&current->blocked_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -653,6 +654,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
+		raw_spin_unlock(&current->blocked_lock);
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		/* Make sure we do wakeups before calling schedule */
 		if (!wake_q_empty(&wake_q)) {
@@ -663,6 +665,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+		raw_spin_lock(&current->blocked_lock);
 		/*
 		 * Gets reset by unlock path().
 		 */
@@ -677,15 +681,23 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			break;
 
 		if (first) {
+			bool acquired;
+
+			/*
+			 * mutex_optimistic_spin() can schedule, so  we need to
+			 * release these locks before calling it.
+			 */
+			raw_spin_unlock(&current->blocked_lock);
+			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
-			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
+			acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
+			raw_spin_lock_irqsave(&lock->wait_lock, flags);
+			raw_spin_lock(&current->blocked_lock);
+			if (acquired)
 				break;
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
-
-		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
 	current->blocked_on = NULL;
 	__set_current_state(TASK_RUNNING);
@@ -712,6 +724,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
@@ -724,6 +737,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 err_early_kill:
 	WARN_ON(current->blocked_on);
 	trace_contention_end(lock, ret);
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
@@ -934,8 +948,10 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
+		raw_spin_lock(&next->blocked_lock);
 		WARN_ON(next->blocked_on != lock);
 		next->blocked_on = NULL;
+		raw_spin_unlock(&next->blocked_lock);
 		wake_q_add(&wake_q, next);
 	}
 
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 8bb334491732..2929a95b4272 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -281,6 +281,8 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		return false;
 
 	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
+		/* nested as we should hold current->blocked_lock already */
+		raw_spin_lock_nested(&waiter->task->blocked_lock, SINGLE_DEPTH_NESTING);
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
@@ -292,6 +294,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		WARN_ON(waiter->task->blocked_on != lock);
 		waiter->task->blocked_on = NULL;
 		wake_q_add(wake_q, waiter->task);
+		raw_spin_unlock(&waiter->task->blocked_lock);
 	}
 
 	return true;
@@ -339,6 +342,8 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner != current) {
+			/* nested as we should hold current->blocked_lock already */
+			raw_spin_lock_nested(&owner->blocked_lock, SINGLE_DEPTH_NESTING);
 			/*
 			 * When waking up the task to wound, be sure to clear the
 			 * blocked_on pointer. Otherwise we can see circular
@@ -346,6 +351,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			 */
 			owner->blocked_on = NULL;
 			wake_q_add(wake_q, owner);
+			raw_spin_unlock(&owner->blocked_lock);
 		}
 		return true;
 	}
-- 
2.42.0.869.gea05f2083d-goog

