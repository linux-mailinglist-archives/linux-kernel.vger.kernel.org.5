Return-Path: <linux-kernel+bounces-6142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2895819513
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69681C24C22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62256B658;
	Wed, 20 Dec 2023 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0QZBpvV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2DBE5E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5b8d4a559ddso4791559a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031555; x=1703636355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqtrdKGdXzPBlRqPKaGseSxeIbziY2YKYdkpRUpxJXI=;
        b=L0QZBpvVE4egwCYGoVKmekFicU1eN+/jX8NhbaC9y6zeoXV7Coom4tfZCV5T7bHAkt
         hN9AVz71jmlide+HDAJ+scTkXo01KzLTX6QlcC25WUXUVVsHBln5q3fTItJlLKJI0lAg
         UQfGzxbHLOwFeIpC0x3I8u0vuX8+2vMq8xzkTKL5Qkdaw6So7nZgLie5o/ZvC7+Ru0OJ
         PbDgZokMXUTKKh2RMZE7raVk3fOdktOwaYqwSwrg9yH1gVvg4sfXTaTU4FSMkMPpYQZj
         sih4ch7ZOddIA7g5pTZf5wcaRnTLxvNRRHkkcTVf/sYHabgvenxJsJ91LzudcgA1qWSA
         NdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031555; x=1703636355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqtrdKGdXzPBlRqPKaGseSxeIbziY2YKYdkpRUpxJXI=;
        b=RffBlS8mTh2A+V0mDB0rg6VOObmFEv5QVzNDVhfWGsEvnOTlK7PXI5cGLwlt2Z75x1
         5ZKk8uZf8XpLnIsBro8uQTnocyNtx128i6eOACbm6HEMojUzbN6A4Kti/MXApZmFGUva
         NCvwPvugosZJ/JAT3mZADiFU2i4fxd2qdvE9E7g9NOPV+0RPrOSqcr/4zF8y9JFus9Pf
         yLlE/SDh4GdF7r4S4kUR5Z/OYL9QkhnAfwQwUf+BCx7k2SCfndfVQPhXbz8MNAaE9T1r
         /MyxHwk51u4YwsAS3QtduaqGWXdpMc1Mq4cLyzfCFf6oNQHOKt7fNDEpf6rMLp3zMjej
         xi3g==
X-Gm-Message-State: AOJu0YxPu1LRYhjoYYlStUe1BDFgHsnIcKaZkS9qIwI3lttvBmwVywTE
	d1n4AgfglgnNKNASkui01wvUT3ZuZFAATqoMVOyCeCdGcn2mHoYB3cgqi0m7G8+phJmdA5y0Zsa
	VgN+3DEhdFzwxlrK3uJzokK6tOazQDSSigkVENP2FB95i4U1kQGMkuRC6wLP5e7+DRo5eYNw=
X-Google-Smtp-Source: AGHT+IGJGRW20FQTpSzMUETOc8VLHgus+2mKiWZqcqFPC9niibUzBp0U2arOsydUEASTq4yFR4zS1TYqr0ZQ
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:18a8:b0:6d6:35f0:19c5 with SMTP
 id x40-20020a056a0018a800b006d635f019c5mr59554pfh.0.1703031554968; Tue, 19
 Dec 2023 16:19:14 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:18 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-8-jstultz@google.com>
Subject: [PATCH v7 07/23] locking/mutex: Switch to mutex handoffs for CONFIG_SCHED_PROXY_EXEC
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	Valentin Schneider <valentin.schneider@arm.com>, "Connor O'Brien" <connoro@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

Since with SCHED_PROXY_EXEC, we will want to hand off locks to
the tasks we are running on behalf of, switch to using mutex
handoffs.

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
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
[jstultz: Split out only the very basic initial framework
 for proxy logic from a larger patch.]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split out from core proxy patch
v6:
* Rework to use sched_proxy_exec() instead of #ifdef CONFIG_PROXY_EXEC
v7:
* Avoid disabling optimistic spinning at compile time so booting
  with sched_proxy_exec=off matches prior performance
* Add comment in mutex-design.rst as suggested by Metin Kaya
---
 Documentation/locking/mutex-design.rst |  3 ++
 kernel/locking/mutex.c                 | 42 +++++++++++++++-----------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
index 78540cd7f54b..57a5cb03f409 100644
--- a/Documentation/locking/mutex-design.rst
+++ b/Documentation/locking/mutex-design.rst
@@ -61,6 +61,9 @@ taken, depending on the state of the lock:
      waiting to spin on mutex owner, only to go directly to slowpath upon
      obtaining the MCS lock.
 
+     NOTE: Optimistic spinning will be avoided when using proxy execution
+     (SCHED_PROXY_EXEC) as we want to hand the lock off to the task that was
+     boosting the current owner.
 
 (iii) slowpath: last resort, if the lock is still unable to be acquired,
       the task is added to the wait-queue and sleeps until woken up by the
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 6084470773f6..11dc5cb7a5a3 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -416,6 +416,9 @@ static __always_inline bool
 mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
 		      struct mutex_waiter *waiter)
 {
+	if (sched_proxy_exec())
+		return false;
+
 	if (!waiter) {
 		/*
 		 * The purpose of the mutex_can_spin_on_owner() function is
@@ -914,26 +917,31 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 	mutex_release(&lock->dep_map, ip);
 
-	/*
-	 * Release the lock before (potentially) taking the spinlock such that
-	 * other contenders can get on with things ASAP.
-	 *
-	 * Except when HANDOFF, in that case we must not clear the owner field,
-	 * but instead set it to the top waiter.
-	 */
-	owner = atomic_long_read(&lock->owner);
-	for (;;) {
-		MUTEX_WARN_ON(__owner_task(owner) != current);
-		MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
-
-		if (owner & MUTEX_FLAG_HANDOFF)
-			break;
+	if (sched_proxy_exec()) {
+		/* Always force HANDOFF for Proxy Exec for now. Revisit. */
+		owner = MUTEX_FLAG_HANDOFF;
+	} else {
+		/*
+		 * Release the lock before (potentially) taking the spinlock
+		 * such that other contenders can get on with things ASAP.
+		 *
+		 * Except when HANDOFF, in that case we must not clear the
+		 * owner field, but instead set it to the top waiter.
+		 */
+		owner = atomic_long_read(&lock->owner);
+		for (;;) {
+			MUTEX_WARN_ON(__owner_task(owner) != current);
+			MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
 
-		if (atomic_long_try_cmpxchg_release(&lock->owner, &owner, __owner_flags(owner))) {
-			if (owner & MUTEX_FLAG_WAITERS)
+			if (owner & MUTEX_FLAG_HANDOFF)
 				break;
 
-			return;
+			if (atomic_long_try_cmpxchg_release(&lock->owner, &owner,
+							    __owner_flags(owner))) {
+				if (owner & MUTEX_FLAG_WAITERS)
+					break;
+				return;
+			}
 		}
 	}
 
-- 
2.43.0.472.g3155946c3a-goog


