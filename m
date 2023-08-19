Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2967B78179A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245479AbjHSGKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245254AbjHSGJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:09:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0998D420E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58e49935630so35458657b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425378; x=1693030178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7ovmdqeEmQW6/pL3Kbgfmvyn4MJCbruKVgSbhRxWls=;
        b=yF37Lo68GBKi1cuwMkbeVfcw2t9qfuJUDxhAidqRjeuMumSBviMBHofHw6sGVdnD4n
         ImjI8JAKWTJAqjQE7BI91YGw+nR4MMjWy84tNhvjP7yCbkc2p32m0DcnL5Psw/ACV+xw
         fk8PyMy4CZFesou0+pEs+7kKzT0PHV3fpTkgFt/mSXcd3A7I3FTQb0d6Xo2/BTEeOcmH
         iiOmxVgIA1+T6RgoLi51PtU3/wDeSPUSfR4riKey0GPO+1e7be6S7MjlEsXbTWhJ8nvj
         /avP44eXBT7QrFhCWWkIKSyPMP7Yx/HGcQ4s4KQmC5hF2Ed/obRP8cKUwyTzUubitRG4
         BSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425378; x=1693030178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7ovmdqeEmQW6/pL3Kbgfmvyn4MJCbruKVgSbhRxWls=;
        b=BmiwSzk5xyRI2XFXzLYKvFQ7i2zx9ulWDdJWLeMHoASsQ047uKYH+CfJQJVwfxp4ju
         lTIb6d4KdXP96aumfNW7RY6SSL1B2775zapZC0RNjWS3pFFHw8Y5F8SRJVG79O7LAgVT
         QFqVHVszWgrl0p3yFBufzlvPXJ5B3olQQ1nWjz6dPW9K95M+b5nViDuUlgD0oVlZULOw
         nMsPksnJhJS9Gl5ZD9mVctENWAQu3tsLcFv8dqz5evgSL/BBNFElsvTIIKSCW2ikayNA
         bXBTh721Li9lY0z23RiMvudeglevpxbe6x2IRgkzVBt/A7wjtZDiCWynShG8j47LN+4l
         CTBw==
X-Gm-Message-State: AOJu0YzErYJlQrieZg/mOrNxN7go+QKsXdC//vBdE5agNpR4f3D2sLcB
        ujuaIACMmlzuAphv7vGsZnOCN8gLjvNtjbbRTcpIKgGCKIDybiGJNNnVV2mm3VZ+DOPFktFRkIU
        VHu1JAlr1uUBkKk7JNwyyu7d0///ZvPsQAMN1apbuTbo0QyJyEyra4EPkA0Gf/PkgWKL427I=
X-Google-Smtp-Source: AGHT+IGJNiivTn2Q+lsbQjM5QSxq8/PLYgaEKXPaPp0cRGno8mfXTEI/FSnYezp4ghaJpkiavW4IcH5Uv62L
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:ad14:0:b0:58c:e8da:4d1a with SMTP id
 l20-20020a81ad14000000b0058ce8da4d1amr19638ywh.2.1692425378071; Fri, 18 Aug
 2023 23:09:38 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:40 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-7-jstultz@google.com>
Subject: [PATCH v5 06/19] locking/mutex: Add task_struct::blocked_lock to
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index 8b98e3933bd9..7dded1c09efa 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1141,6 +1141,7 @@ struct task_struct {
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
index 42b022fc3c4c..8bad899b6c6e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2356,6 +2356,7 @@ __latent_entropy struct task_struct *copy_process(
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
+	raw_spin_lock_init(&p->blocked_lock);
 
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 8af9269ce8d9..b5e5ed1a5eef 100644
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
 		wake_up_q(&wake_q);
@@ -662,6 +664,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+		raw_spin_lock(&current->blocked_lock);
 		/*
 		 * Gets reset by unlock path().
 		 */
@@ -676,15 +680,23 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
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
@@ -711,6 +723,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
@@ -723,6 +736,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 err_early_kill:
 	WARN_ON(current->blocked_on);
 	trace_contention_end(lock, ret);
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
@@ -932,8 +946,10 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
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
2.42.0.rc1.204.g551eb34607-goog

