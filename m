Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8893C7E2CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjKFTgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjKFTf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:35:58 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD3AD79
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:35:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afbcffe454so98456937b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299353; x=1699904153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWj20OWbsgaFfuYnHKg9vRj05US4KuJfwuDjDU63DiY=;
        b=jiJ2t/S71PZg0fJ6lFp9DFGSi1BftrjUORhUUOoakAMaN32Jpgce5pm0zSYKlzp+To
         Hu7nxAqIC0f4C8ocf6J2i3hICZCC8xCmWTJiTpKCerNaEwm/APA5SgKshfchErI2tIZA
         M7NCwtZb4KUmjGN4xhOAQZXtDFXWl+d0/NqppjRWjoq31zqFSSKWU5kpC3hzrTDuImup
         Kqco33Wt+DghEFX+Y5GUv1FmK/1/rNtEj8s9YCOVpt407uko1UdPIEWqR1SMKe9RKlW1
         Mai9jOLibhhU6e+ODWkXZT3a9eA9jdPpOhpnN6iFAuNvQCco2/VIBcKBFRcHtzylNYG5
         WrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299353; x=1699904153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWj20OWbsgaFfuYnHKg9vRj05US4KuJfwuDjDU63DiY=;
        b=IgiHftonNFJKuN5lzyw8lp3BHkxl2zVAJ9S5yM9p2oWeiUfQMGRuC8zMK0NDIidqOa
         vX767SIStbLdm06u+BGnNbANx739XySk9CJu3QT8dIcHQQD0nbgtYplK91TJWiCRYQ7t
         I9OEebxlwxdGkyvC15kNkdqpegjUAtAs0ovBQwclQRNu9NinVBr2n+sa/b9vqS5bZisl
         A1oE51Sfmk1lHPEiHUgOSHpUFN3CkVy3m+5DocboCjYJJGAIZ/g7szyIR86O3ZrEQ1+m
         b/ts9SlVNJpDWuSk8ONhvrBZsy/UQ0jpcKWbXvcr8cItVDKdi6zlD9MDwXeWRCONfkcV
         5pkg==
X-Gm-Message-State: AOJu0YyY4ywVZ6p9UvlgIZ0lQPQGaDQZQtxFEhL0OvD9BhBL0XnfkTNT
        tVQoW4K520VDF2EmjD3GVNRCOBCKe8lMXfD4qteBx7w/pT4toUp1NaJVk5rup6z2oxAi5g4QcnZ
        NmES8SLV6cxGlMy113hEQt5liRWPpwBlpI+I45wSmV6/k/b/G3MlNf1hlePqJMXTzSt/BYaU=
X-Google-Smtp-Source: AGHT+IE9x5bWgSFi4G8HfQl/9l7DD67dhpm9VoN0fFQvAH07er21wyHh46EoCLNwxJzlzIoQm6swCP0Vp7xi
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a0d:d591:0:b0:583:4f82:b9d9 with SMTP id
 x139-20020a0dd591000000b005834f82b9d9mr225159ywd.5.1699299353337; Mon, 06 Nov
 2023 11:35:53 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:34:52 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-10-jstultz@google.com>
Subject: [PATCH v6 09/20] locking/mutex: Split blocked_on logic into two
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index 5f05d9a4cc3f..47c7095b918a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1146,6 +1146,7 @@ struct task_struct {
 #endif
 
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	bool				blocked_on_waking; /* blocked on, but waking */
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
@@ -2269,6 +2270,7 @@ static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
 	WARN_ON((!m && !p->blocked_on) || (m && p->blocked_on));
 
 	p->blocked_on = m;
+	p->blocked_on_waking = false;
 }
 
 static inline struct mutex *get_task_blocked_on(struct task_struct *p)
diff --git a/kernel/fork.c b/kernel/fork.c
index 47b76ed5ddf6..930947bf4569 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2457,6 +2457,7 @@ __latent_entropy struct task_struct *copy_process(
 #endif
 
 	p->blocked_on = NULL; /* not blocked yet */
+	p->blocked_on_waking = false; /* not blocked yet */
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 36e563f69705..f37b7afe8aa5 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -667,10 +667,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
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
@@ -950,7 +951,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
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
index 1def5b7fa1df..7c37d478e0f8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2133,6 +2133,18 @@ static inline int task_current(struct rq *rq, struct task_struct *p)
 	return rq->curr == p;
 }
 
+#ifdef CONFIG_PROXY_EXEC
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	return sched_proxy_exec() && !!p->blocked_on && !p->blocked_on_waking;
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
2.42.0.869.gea05f2083d-goog

