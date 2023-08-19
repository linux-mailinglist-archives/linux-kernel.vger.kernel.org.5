Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77A781794
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245508AbjHSGKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245260AbjHSGJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:09:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA28B420E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d74829dd58fso201776276.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425380; x=1693030180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YF321kdqmJK5VFYpCHF4TrG1PYTtBULB6yWSc5xhnHI=;
        b=v/FMyuvaaMekoOObXsbpJdkHyHygksXIzWkW3Vt2dtmhTtLZ3P/+Fj4kEi/tg9KKwP
         uWCUtfpH9LNH9R+BILCAR/0kfsqAcbWGhMRxDcPFJ+T0kuDQwX6K534lylQr4PiBN7zV
         YgAeB++4nEDe59lpcoPYPAmJy2pNH5jVg5XjJM14GWl8fiU8E/MlLP8AbknfkklcwV/N
         QOSE4KY63r/Lx2e6AiyGctsOMNpaTR+AfR35rQLde3c/23Cag5u6xyqFfQRHC1IGD2Pp
         rbFxwAewpdRNaykb2HlYI8LTilC1OUUeZAGHItjEP56mr8e4YGbd+wnDauPE5meUVJh3
         5qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425380; x=1693030180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YF321kdqmJK5VFYpCHF4TrG1PYTtBULB6yWSc5xhnHI=;
        b=jMcyAsa/lIczVHn/yMvt2BBvuPtgMqhY52IgMsdpiGU6N1qAC3gN95dEgGvYEOmhRZ
         Dwp3J3Nyo1OTbmH2GmNVoc53jDSZ1C2FTBfivv7AwVov+iaqU5Y00VaaKmGzjRoDdypj
         WjquxJ/ga0vssNECOduwLm+py1MGwvO4KTKazrAG7swICpAqtMXnIqIyk/a4sUTy7yej
         lk33cWgEzDW4n9fsMt33O+n2Hq1CA7mci9WdBd3hYlyyp+Fc3Tc7NgziZ05U1lIyH8UY
         2gSJZ+GvPOj4SXU8pGJND/H31TSMiRCI00+d5JMsz58fFx+Zqq0oRLfjMbXIzTytJGPm
         FzBg==
X-Gm-Message-State: AOJu0YwGhlDw75iSG/dIxALBwT5L4r6IfNd5Fd99PQRFpRq3bbtI/EKm
        d/7V7FZAzTUJbQhAxhfLmfAdisf29hw70CHFR8cFAY1LVnSICTwokcKMiHKeboUOTBxEPHVdXTx
        57/i4+/+ybYQ49ZIi/hpWJZ6esiy6ya5pa8cTml2+e+f0P+d/L+6cv+KtutoUkoyqVwZhxVQ=
X-Google-Smtp-Source: AGHT+IG/cuTAfnCPiLltFKWkFLQHa/6/MGp7Sa6nthUciDijQ3gQt3kVT1dSWLQxawIVvNYJZBEhdruNFpJN
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:9c44:0:b0:d1e:721b:469d with SMTP id
 x4-20020a259c44000000b00d1e721b469dmr10473ybo.7.1692425379671; Fri, 18 Aug
 2023 23:09:39 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:41 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-8-jstultz@google.com>
Subject: [PATCH v5 07/19] locking/mutex: Add p->blocked_on wrappers for
 correctness checks
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
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

From: Valentin Schneider <valentin.schneider@arm.com>

This lets us assert p->blocked_lock is held whenever we access
p->blocked_on, as well as warn us for unexpected state changes.

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
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
[fix conflicts, call in more places]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: tweaked commit subject, added get_task_blocked_on() as well]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Added get_task_blocked_on() accessor
v4:
* Address READ_ONCE usage that was dropped in v2
* Reordered to be a later add on to the main patch series as
  Peter was unhappy with similar wrappers in other patches.
v5:
* Added some extra correctness checking in wrappers
---
 include/linux/sched.h        | 22 ++++++++++++++++++++++
 kernel/locking/mutex-debug.c |  4 ++--
 kernel/locking/mutex.c       | 10 +++++-----
 kernel/locking/ww_mutex.h    |  4 ++--
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7dded1c09efa..0f32bea47e5e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2233,6 +2233,28 @@ static inline int rwlock_needbreak(rwlock_t *lock)
 #endif
 }
 
+static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	lockdep_assert_held(&p->blocked_lock);
+
+	/* We should be setting values to NULL or NULL to values */
+	WARN_ON((!m && !p->blocked_on) || (m && p->blocked_on));
+
+	p->blocked_on = m;
+}
+
+static inline struct mutex *get_task_blocked_on(struct task_struct *p)
+{
+	lockdep_assert_held(&p->blocked_lock);
+
+	return p->blocked_on;
+}
+
+static inline struct mutex *get_task_blocked_on_once(struct task_struct *p)
+{
+	return READ_ONCE(p->blocked_on);
+}
+
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 7228909c3e62..1eedf7c60c00 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -53,13 +53,13 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	lockdep_assert_held(&lock->wait_lock);
 
 	/* Current thread can't be already blocked (since it's executing!) */
-	DEBUG_LOCKS_WARN_ON(task->blocked_on);
+	DEBUG_LOCKS_WARN_ON(get_task_blocked_on(task));
 }
 
 void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
-	struct mutex *blocked_on = READ_ONCE(task->blocked_on);
+	struct mutex *blocked_on = get_task_blocked_on_once(task);
 
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index b5e5ed1a5eef..04b0ea45cc01 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -623,7 +623,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
-	current->blocked_on = lock;
+	set_task_blocked_on(current, lock);
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -669,7 +669,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		/*
 		 * Gets reset by unlock path().
 		 */
-		current->blocked_on = lock;
+		set_task_blocked_on(current, lock);
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -698,7 +698,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		}
 	}
 acquired:
-	current->blocked_on = NULL;
+	set_task_blocked_on(current, NULL);
 	__set_current_state(TASK_RUNNING);
 
 	if (ww_ctx) {
@@ -730,7 +730,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	return 0;
 
 err:
-	current->blocked_on = NULL;
+	set_task_blocked_on(current, NULL);
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
@@ -948,7 +948,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		debug_mutex_wake_waiter(lock, waiter);
 		raw_spin_lock(&next->blocked_lock);
 		WARN_ON(next->blocked_on != lock);
-		next->blocked_on = NULL;
+		set_task_blocked_on(current, NULL);
 		raw_spin_unlock(&next->blocked_lock);
 		wake_q_add(&wake_q, next);
 	}
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 2929a95b4272..44a532dda927 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -292,7 +292,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		 * blocked_on relationships that can't resolve.
 		 */
 		WARN_ON(waiter->task->blocked_on != lock);
-		waiter->task->blocked_on = NULL;
+		set_task_blocked_on(waiter->task, NULL);
 		wake_q_add(wake_q, waiter->task);
 		raw_spin_unlock(&waiter->task->blocked_lock);
 	}
@@ -349,7 +349,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			 * blocked_on pointer. Otherwise we can see circular
 			 * blocked_on relationships that can't resolve.
 			 */
-			owner->blocked_on = NULL;
+			set_task_blocked_on(owner, NULL);
 			wake_q_add(wake_q, owner);
 			raw_spin_unlock(&owner->blocked_lock);
 		}
-- 
2.42.0.rc1.204.g551eb34607-goog

