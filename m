Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480397E2CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjKFTgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjKFTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:35:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADD2D47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:35:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af9b0850fdso65781507b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299349; x=1699904149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E57J/i4cUWuAwfC7XG6AzrNtexVrU81CJufi+3vfKlM=;
        b=qXw7kJ5W0ifuJtSiQBRP27i2DJmvwdlsh9bncGmXbYBqDYYEhEuBOo5Cyjdowg7FC1
         Jhb56lpXVAGKmF23W3Lr2b6LWUQVVfH/uiyDSURF+9b+F2lm1TVf6PI2gAlcZk28FjNA
         r2/TjPFMz9+xSTpX9OrFKN1XcDX6WAt7VMFMi0K/Xs+Bv8NpjV9yQBkIUSD66D3cpg2z
         pVf1RvV4cIPrt48yP88jt+byUsYVm6bMZY1W+lrQ7Cogj1riaUOL9PFj4ikkfH0OVMkM
         ZYgdKsdUZ5lK0V6A1uXFuot2Vlb3ON+ix7ymyjPEQymtDHtsFIGMNylBLM3/ky/eiiN7
         PVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299349; x=1699904149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E57J/i4cUWuAwfC7XG6AzrNtexVrU81CJufi+3vfKlM=;
        b=WswFjBlqhuztzGjE/M7PP+uFuT8tLpSDkoXusnGxZv7nNRknTT0IHtSj8iqTWPCnuU
         9O7FPP92JiwqIPvj7dZPQFE5pX/oHZyU1nkfruEWcDVa/uE/qfhBB/jaBwB1Hhuwt8J3
         O/F6z5JcIRjCbZNsQ6sRsMzNs+RhUW84hB5aA0YdlSVdKAFl6W47WsP9e5/jTZeUfbgJ
         J3mid+MZsE4twpJPkjnLsdMVpwiLqtT7a/m7zWSzk2LtRnS40N0km0Fo4lLbrV36t+Zv
         KJNP9A8qWKP+JwBpcZyODoBIZ87z3uIdaOJ2MxJAeB5qzQxsIGbkKxLeM7HE5f3SsqPn
         5g7Q==
X-Gm-Message-State: AOJu0YzGrf6INBJZe4vMZmLRK7cxn5YxR9xbzEVR9R+L85Ac+UzWvLAN
        wQevlU4j2UaeZxTMiWwb3zdK6GttrECeBhYnpMJm8Pb5h3KuCSL3VHeheRKrWEtxB94ruhTJmEj
        LG1t936qa61ks6H/ojzGbHCGkBX5XsQ2PvwqVOwUldfE1Pm2p3mDfoha3GnFG+Pd0rfTvJsg=
X-Google-Smtp-Source: AGHT+IEp4vHO62WTZMDwX26JCgUwtSKYYeDVwtDwzdUlAENraqFn2qKaM1LQfz49GTp+jAgBqyhNrwEpfL/O
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP
 id v3-20020a056902108300b00d9ac3b84274mr698783ybu.7.1699299349407; Mon, 06
 Nov 2023 11:35:49 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:34:50 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-8-jstultz@google.com>
Subject: [PATCH v6 07/20] locking/mutex: Add p->blocked_on wrappers for
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index a9258dae00e0..81334677e008 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2248,6 +2248,28 @@ static inline int rwlock_needbreak(rwlock_t *lock)
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
index df186c0bf4a9..36e563f69705 100644
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
@@ -670,7 +670,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		/*
 		 * Gets reset by unlock path().
 		 */
-		current->blocked_on = lock;
+		set_task_blocked_on(current, lock);
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -699,7 +699,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		}
 	}
 acquired:
-	current->blocked_on = NULL;
+	set_task_blocked_on(current, NULL);
 	__set_current_state(TASK_RUNNING);
 
 	if (ww_ctx) {
@@ -731,7 +731,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	return 0;
 
 err:
-	current->blocked_on = NULL;
+	set_task_blocked_on(current, NULL);
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
@@ -950,7 +950,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
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
2.42.0.869.gea05f2083d-goog

