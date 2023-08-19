Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F40678178F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245540AbjHSGKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245272AbjHSGJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:09:44 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61960420E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:43 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26b73f475c0so1878496a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425383; x=1693030183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCpl6ncMy3h7CP8c7GjC2hKAFGGJIM+ogC/ZIK1+0S0=;
        b=BE16sOHQ6DzVyQudvKJFa9ixHjZmPqvgE8yz6S1ItGhVBn7aSBvzEHo30j7rHcpCQr
         CR5amgZ8Bg0hOXMhG1mnMAoUVpUNDT1iFChoJCIWX9LMVOAp0PkhmqvLYzBk7tvqSYBR
         5keYieYUuWX5sCe/PefQxaDVC+IAaiI0l+DON8IPERLqblHgqp6W0POyKyqC8uU+pJJ8
         KKCozgMBAdomdZoJM8/QpwM5+CIutm3391EK3rp2ZYyETSuUwhsj4SK1DwPWUG+RAG5d
         YoysTrz+ejpIUm4pbEsrVlR9+6BLPWaqBwum2K6Fc115ViYJogPo8/AXpJaImTUCzKp3
         lUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425383; x=1693030183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCpl6ncMy3h7CP8c7GjC2hKAFGGJIM+ogC/ZIK1+0S0=;
        b=TqPZqCLrKXYxfcoqIRc9rR/IXxM7l7BoM5IxeDrGhxsjO6S9y7q4pvuFyOMHzdZyY0
         UBYxRfuxFU1a8PlOqf+4EFGzYUN2suikNEpQ42ZeabGN79lg8h1Ls6//sV+VqjOWx6gV
         c8TeLz7cOeUdpW4cAj+CG9gR9T927vW4BgFxDUNB9VjdSIXmS4uvw7RFfv6LPDXNwl3p
         UjlOIFsaA7LnsIT8ZA6SehW9G9sGdKAkg/V9CyjnkibQiQepTKxo1hngtRrfhvlXj8kJ
         H463DG3ds7yRqc1LclNXwwXplpYlTXhu3PIWwpg6q24eeS9dTcJY4VTWJ/3K8OH/c1KC
         fm/w==
X-Gm-Message-State: AOJu0YyCdO5RNbJJ9AtGjORqP1T+MnEBtIqSs5+b5hp2aEf/HiHgb7QC
        dIE9xy/t8onfFhOIhWGjyQSY12EdBqt1pTIGXHpuzN0qs9EEQKn+3cfD4KQqMSagoq9l2OwxxuL
        YHTW7VXR/2QBSe06TzxxGYOsKabbsluGR5XJNssy0PUU48G81HPrjvj+YJpZLslXrhpzWcZ4=
X-Google-Smtp-Source: AGHT+IHqGWIGekHWhDR8qamM2lxOLOe/YulJbAKIRYIrlhUaoYcRKta0vG5xeLAzGfvED6NPmPcNMusCEF+k
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:ca16:b0:268:2de3:e6b2 with SMTP id
 x22-20020a17090aca1600b002682de3e6b2mr310689pjt.5.1692425381550; Fri, 18 Aug
 2023 23:09:41 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:42 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-9-jstultz@google.com>
Subject: [PATCH v5 08/19] locking/mutex: Split blocked_on logic into two
 states (blocked_on and blocked_on_waking)
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

This patch adds blocked_on_waking so we can track separately if
the task should be able to try to aquire the lock separately
from the lock it is blocked on.

This avoids some of the subtle magic where the blocked_on state
gets cleared, only to have it re-added by the
mutex_lock_slowpath call when it tries to aquire the lock on
wakeup

This should make dealing with the ww_mutex issue cleaner.

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
 include/linux/sched.h     |  2 ++
 kernel/fork.c             |  1 +
 kernel/locking/mutex.c    |  7 ++++---
 kernel/locking/ww_mutex.h | 12 ++++++------
 kernel/sched/sched.h      | 12 ++++++++++++
 5 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0f32bea47e5e..3b7f26df2496 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1141,6 +1141,7 @@ struct task_struct {
 #endif
 
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	bool				blocked_on_waking; /* blocked on, but waking */
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
@@ -2241,6 +2242,7 @@ static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
 	WARN_ON((!m && !p->blocked_on) || (m && p->blocked_on));
 
 	p->blocked_on = m;
+	p->blocked_on_waking = false;
 }
 
 static inline struct mutex *get_task_blocked_on(struct task_struct *p)
diff --git a/kernel/fork.c b/kernel/fork.c
index 8bad899b6c6e..5b11ead90b12 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2460,6 +2460,7 @@ __latent_entropy struct task_struct *copy_process(
 #endif
 
 	p->blocked_on = NULL; /* not blocked yet */
+	p->blocked_on_waking = false; /* not blocked yet */
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 04b0ea45cc01..687009eca2d1 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -666,10 +666,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 		raw_spin_lock(&current->blocked_lock);
+
 		/*
-		 * Gets reset by unlock path().
+		 * Clear blocked_on_waking flag set by the unlock path().
 		 */
-		set_task_blocked_on(current, lock);
+		current->blocked_on_waking = false;
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -948,7 +949,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		debug_mutex_wake_waiter(lock, waiter);
 		raw_spin_lock(&next->blocked_lock);
 		WARN_ON(next->blocked_on != lock);
-		set_task_blocked_on(current, NULL);
+		next->blocked_on_waking = true;
 		raw_spin_unlock(&next->blocked_lock);
 		wake_q_add(&wake_q, next);
 	}
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 44a532dda927..3b0a68d7e308 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -287,12 +287,12 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
 		/*
-		 * When waking up the task to die, be sure to clear the
-		 * blocked_on pointer. Otherwise we can see circular
+		 * When waking up the task to die, be sure to set the
+		 * blocked_on_waking flag. Otherwise we can see circular
 		 * blocked_on relationships that can't resolve.
 		 */
 		WARN_ON(waiter->task->blocked_on != lock);
-		set_task_blocked_on(waiter->task, NULL);
+		waiter->task->blocked_on_waking = true;
 		wake_q_add(wake_q, waiter->task);
 		raw_spin_unlock(&waiter->task->blocked_lock);
 	}
@@ -345,11 +345,11 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			/* nested as we should hold current->blocked_lock already */
 			raw_spin_lock_nested(&owner->blocked_lock, SINGLE_DEPTH_NESTING);
 			/*
-			 * When waking up the task to wound, be sure to clear the
-			 * blocked_on pointer. Otherwise we can see circular
+			 * When waking up the task to wound, be sure to set the
+			 * blocked_on_waking flag. Otherwise we can see circular
 			 * blocked_on relationships that can't resolve.
 			 */
-			set_task_blocked_on(owner, NULL);
+			owner->blocked_on_waking = true;
 			wake_q_add(wake_q, owner);
 			raw_spin_unlock(&owner->blocked_lock);
 		}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 33ad47a093ae..95900ccaaf82 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2111,6 +2111,18 @@ static inline int task_current(struct rq *rq, struct task_struct *p)
 	return rq->curr == p;
 }
 
+#ifdef CONFIG_PROXY_EXEC
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	return !!p->blocked_on && !p->blocked_on_waking;
+}
+#else /* !PROXY_EXEC */
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	return false;
+}
+#endif /* PROXY_EXEC */
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
-- 
2.42.0.rc1.204.g551eb34607-goog

