Return-Path: <linux-kernel+bounces-31127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB083295C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1283C1F24EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA164F214;
	Fri, 19 Jan 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HTUXwQsf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5m0FZKR8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF7A24B5E;
	Fri, 19 Jan 2024 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705666027; cv=none; b=Al+GDUT2bJi+cBTSgVIrPCAUL9pdBEyhemvGoV0ah6Wi81MVxqlpoeeUcmttnPZ2D+VMIBRWXswC/mxcsFbVbSWrhi4hEqb1rKDhgkFJ3vohRGA9MXxIzeg1XaSyNHWzbL2GeYtX3n5RMPDKQpqSRFZPK+kOs7Gw7two3iyXOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705666027; c=relaxed/simple;
	bh=+29CDlKuajfqGksTzlVhNvMqTuiT8XOUwD2uJoy9moU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TF2Owndmjz673T1xbRk8xdHkG+8m3yRkBYXOW+2tM/s+B1dSNVQmjOD71hJcmJQwfI5KhpIMw8nUAJt886O/faD5Y6tN3XrJgVKGOuBHFUU0VE1KMznWqXsQNIWiRaBZ3vHAfq6XowEMAgJdg7PyszfW28F38ZXZMp+s3AHxI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HTUXwQsf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5m0FZKR8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Jan 2024 12:06:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705666017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+V4QgH1BuYPBrs95fl76vL2gGCoC++TEKPMnLkodhc=;
	b=HTUXwQsfyAJnn5Sf/f7/aK80qCFKCOjQeWFNrHTdYGc7JbqQelN3bUqTCZyA/N6bVXnvp9
	0VAMD3j4jQi9EDuNFZikkOuE3zo3SuPSoN/6EmI9+BGY29Vz3Y6y5AR8ss8ueQy7+9Jr+H
	pGyctxcYZL/MJ/soBon4SNayFc80pefStpTGW1OyNLbKPWbQx+WyiBVt2yoaz4DEfN938p
	lMJSEKUs1rQi57sZutiX5RX1UTZ0UKTUWab1nRp+KOG6aNCg9Xgz1ZI36SqNQbmtU4VKnu
	EaUh2UaVuFWCU+Bc9o27HMqCjXM71u1zYpFaPvqBvrmVHd+cGMFC0En1drcNnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705666017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+V4QgH1BuYPBrs95fl76vL2gGCoC++TEKPMnLkodhc=;
	b=5m0FZKR8WWZwfclKJAabjzCBzFO+9HLnmmsSiMxQU334sPOrDND4f+0U3etI0XQjCBnL/h
	WlHL3RH/8CmQWCAQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Prevent the reuse of stale pi_state
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240118115451.0TkD_ZhB@linutronix.de>
References: <20240118115451.0TkD_ZhB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170566601687.398.7239390403231385135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     e626cb02ee8399fd42c415e542d031d185783903
Gitweb:        https://git.kernel.org/tip/e626cb02ee8399fd42c415e542d031d185783903
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 18 Jan 2024 12:54:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 19 Jan 2024 12:58:17 +01:00

futex: Prevent the reuse of stale pi_state

Jiri Slaby reported a futex state inconsistency resulting in -EINVAL during
a lock operation for a PI futex. It requires that the a lock process is
interrupted by a timeout or signal:

  T1 Owns the futex in user space.

  T2 Tries to acquire the futex in kernel (futex_lock_pi()). Allocates a
     pi_state and attaches itself to it.

  T2 Times out and removes its rt_waiter from the rt_mutex. Drops the
     rtmutex lock and tries to acquire the hash bucket lock to remove
     the futex_q. The lock is contended and T2 schedules out.

  T1 Unlocks the futex (futex_unlock_pi()). Finds a futex_q but no
     rt_waiter. Unlocks the futex (do_uncontended) and makes it available
     to user space.

  T3 Acquires the futex in user space.

  T4 Tries to acquire the futex in kernel (futex_lock_pi()). Finds the
     existing futex_q of T2 and tries to attach itself to the existing
     pi_state.  This (attach_to_pi_state()) fails with -EINVAL because uval
     contains the TID of T3 but pi_state points to T1.

It's incorrect to unlock the futex and make it available for user space to
acquire as long as there is still an existing state attached to it in the
kernel.

T1 cannot hand over the futex to T2 because T2 already gave up and started
to clean up and is blocked on the hash bucket lock, so T2's futex_q with
the pi_state pointing to T1 is still queued.

T2 observes the futex_q, but ignores it as there is no waiter on the
corresponding rt_mutex and takes the uncontended path which allows the
subsequent caller of futex_lock_pi() (T4) to observe that stale state.

To prevent this the unlock path must dequeue all futex_q entries which
point to the same pi_state when there is no waiter on the rt mutex. This
requires obviously to make the dequeue conditional in the locking path to
prevent a double dequeue. With that it's guaranteed that user space cannot
observe an uncontended futex which has kernel state attached.

Fixes: fbeb558b0dd0d ("futex/pi: Fix recursive rt_mutex waiter state")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20240118115451.0TkD_ZhB@linutronix.de
Closes: https://lore.kernel.org/all/4611bcf2-44d0-4c34-9b84-17406f881003@kernel.org
---
 kernel/futex/core.c | 15 ++++++++++++---
 kernel/futex/pi.c   | 11 ++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index e0e8534..1e78ef2 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -627,12 +627,21 @@ retry:
 }
 
 /*
- * PI futexes can not be requeued and must remove themselves from the
- * hash bucket. The hash bucket lock (i.e. lock_ptr) is held.
+ * PI futexes can not be requeued and must remove themselves from the hash
+ * bucket. The hash bucket lock (i.e. lock_ptr) is held.
  */
 void futex_unqueue_pi(struct futex_q *q)
 {
-	__futex_unqueue(q);
+	/*
+	 * If the lock was not acquired (due to timeout or signal) then the
+	 * rt_waiter is removed before futex_q is. If this is observed by
+	 * an unlocker after dropping the rtmutex wait lock and before
+	 * acquiring the hash bucket lock, then the unlocker dequeues the
+	 * futex_q from the hash bucket list to guarantee consistent state
+	 * vs. userspace. Therefore the dequeue here must be conditional.
+	 */
+	if (!plist_node_empty(&q->list))
+		__futex_unqueue(q);
 
 	BUG_ON(!q->pi_state);
 	put_pi_state(q->pi_state);
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 90e5197..5722467 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1135,6 +1135,7 @@ retry:
 
 	hb = futex_hash(&key);
 	spin_lock(&hb->lock);
+retry_hb:
 
 	/*
 	 * Check waiters first. We do not trust user space values at
@@ -1177,12 +1178,17 @@ retry:
 		/*
 		 * Futex vs rt_mutex waiter state -- if there are no rt_mutex
 		 * waiters even though futex thinks there are, then the waiter
-		 * is leaving and the uncontended path is safe to take.
+		 * is leaving. The entry needs to be removed from the list so a
+		 * new futex_lock_pi() is not using this stale PI-state while
+		 * the futex is available in user space again.
+		 * There can be more than one task on its way out so it needs
+		 * to retry.
 		 */
 		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
 		if (!rt_waiter) {
+			__futex_unqueue(top_waiter);
 			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-			goto do_uncontended;
+			goto retry_hb;
 		}
 
 		get_pi_state(pi_state);
@@ -1217,7 +1223,6 @@ retry:
 		return ret;
 	}
 
-do_uncontended:
 	/*
 	 * We have no kernel internal state, i.e. no waiters in the
 	 * kernel. Waiters which are about to queue themselves are stuck

