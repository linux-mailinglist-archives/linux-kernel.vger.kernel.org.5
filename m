Return-Path: <linux-kernel+bounces-30071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766FA8318C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EF61C20DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3164424B38;
	Thu, 18 Jan 2024 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KVOdbaP0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eRJXjOOO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD75C24B2C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578896; cv=none; b=NJukDE9dATl2i5FGHkfVGAHg6k16Dr56GeT5b58pwbWRDXg43wTt5wyudKSIbmhcIQRtCnQXIXr0/FpiNCVwB92zGh3tgVNBcetH/IPqNXbDXOGDv6PPIADe6abb5FkGX+6TAdQ4zCuIO22pLn+4LKSvBMae+74dzuyDkZog588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578896; c=relaxed/simple;
	bh=KL3D6nF+EcTdA1XslZF8kY0lQsesqywyVVhbd711gAw=;
	h=Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=M1pSv1Ggbsp+uvVQ1fwkwqFvAskLgfjAADXXQczZrMuQWha+1g2ai5fLUuWipAqBmo9qdmjN0/DDOuM8yS997GwsDy/YRUMUUZyoSO/A2xyhPaVN0+rdlQR48vYY/aPWQLDSZlcn8Rx7gN7C8fLKMUmxK1Hynt0mf3Un7bI3PBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KVOdbaP0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eRJXjOOO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jan 2024 12:54:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705578892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0k9tV2fdGZXdBmJ9ubkFL7Z2lu4Lj7jGGCNYLeTsQ4=;
	b=KVOdbaP0F0xoMI2Ay65sbU45+7ZgmvrJSyldKXJRfjtrYX8dj0neEryfVae3v5Sn6qGrK5
	J9bd0cjHysfEH2qY7m/CTXsbai+TwFEQIb5zJOiaF7D4kVyplc2GqxpekwYHStSRIdsfdp
	DL+aBjUAInRx2Yeb8b7VEgvsJhzx6q3xwTclNJxy7JAgypHx7B7npm4n5Y3EtsBUx0w754
	6WJc6OoNYxRSo0CKggVi5jp8j+e3FQ6OwdIUoJbzLz2wOAm0y2DNx8hunVEKWG/WGkoFP7
	7ivyGmBtPWrAE6hCugRmyob35VLrzatH3gWEMG+udRUUb2YafMPtRMUHKW4yug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705578892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0k9tV2fdGZXdBmJ9ubkFL7Z2lu4Lj7jGGCNYLeTsQ4=;
	b=eRJXjOOOQ0IDMcCiNvll63+GWsINpScquiXvaISAJfcf03wqKPHbJCzf2tMWUfy7JmTtSY
	iJPtm+rRMsq+M8AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
	dietmar.eggemann@arm.com, jstultz@google.com, juri.lelli@redhat.com,
	longman@redhat.com, mgorman@suse.de, mingo@redhat.com,
	rostedt@goodmis.org, swood@redhat.com, vincent.guittot@linaro.org,
	vschneid@redhat.com, will@kernel.org
Subject: [PATCH v2] futex: Avoid reusing outdated pi_state.
Message-ID: <20240118115451.0TkD_ZhB@linutronix.de>
References: <20240116130810.ji1YCxpg@linutronix.de>
 <87wms7g62b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87wms7g62b.ffs@tglx>

Jiri Slaby reported a futex state inconsistency resulting in -EINVAL
during a lock operation for a PI futex. A requirement is that the lock
process is interrupted by a timeout or signal:

T1 Owns the futex in userland.

T2 Tries to acquire the futex in kernel (futex_lock_pi()). Allocates a
   pi_state and attaches itself to it.

T2 Times out and removes its rt_waiter from the rt_mutex.

T1 Unlocks the futex (futex_unlock_pi()). Finds a futex_q but no
   rt_waiter. Unlocks the futex (do_uncontended) and makes it available
   to userland.

T3 Acquires the futex in userland.

T4 Tries to acquire the futex in kernel (futex_lock_pi()). Finds the
   existing futex_q and tries to attach itself to the existing pi_state.
   This (attach_to_pi_state()) fails with -EINVAL because uval contains
   the pid of T3 but pi_state points to T1.

We must not unlock the futex and make it available for userland as long
as there is still an existing state in kernel. It can be used by further
futex_lock_pi() caller and observe inconsistent state.

The lock can not be handed over to T1 because it already gave up and
started to clean up.
All futex_q entries point to the same pi_state and the pi_mutex has no
waiters. A waiter can not be enqueued because hb->lock +
pi_mutex.wait_lock is acquired (by the unlock operation) and the same
ordering is used by futex_lock_pi() during locking.

Remove all futex_q entries from the hb list which point to the futex if
no waiter has been observed in the futex_unlock_pi() path. This closes
the race window by removing all pointer to the previous in-kernel state.

The leaving futex_lock_pi() caller can clean up the pi-state once it
acquires hb->lock. During the process futex_unqueue_pi() must remove
the futex_q item from the hb list only if not yet happened.

Fixes: fbeb558b0dd0d ("futex/pi: Fix recursive rt_mutex waiter state")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: https://lore.kernel.org/all/4611bcf2-44d0-4c34-9b84-17406f881003@ke=
rnel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
---
v1=E2=80=A6v2:
  - Removed the argument to futex_unqueue_pi(). __futex_unqueue() is now
    always invoked conditionally.
  - Rewrote the patch description and comments in the patch.
  - Corrected the Closes: link and added Tested-by.

 kernel/futex/core.c |  7 ++++++-
 kernel/futex/pi.c   | 11 ++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index dad981a865b84..fd56a84b163a1 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -628,10 +628,15 @@ int futex_unqueue(struct futex_q *q)
 /*
  * PI futexes can not be requeued and must remove themselves from the
  * hash bucket. The hash bucket lock (i.e. lock_ptr) is held.
+ * If the lock was not acquired (due to timeout or signal) then the rt_wai=
ter
+ * is removed before futex_q is. If this is observed by unlocker then it w=
ill
+ * remove futex_q from the hash bucket list. Thefore the removal here is
+ * optional.
  */
 void futex_unqueue_pi(struct futex_q *q)
 {
-	__futex_unqueue(q);
+	if (!plist_node_empty(&q->list))
+		__futex_unqueue(q);
=20
 	BUG_ON(!q->pi_state);
 	put_pi_state(q->pi_state);
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 90e5197f4e569..50008b7b38e7e 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1135,6 +1135,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
=20
 	hb =3D futex_hash(&key);
 	spin_lock(&hb->lock);
+retry_hb:
=20
 	/*
 	 * Check waiters first. We do not trust user space values at
@@ -1177,12 +1178,17 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int=
 flags)
 		/*
 		 * Futex vs rt_mutex waiter state -- if there are no rt_mutex
 		 * waiters even though futex thinks there are, then the waiter
-		 * is leaving and the uncontended path is safe to take.
+		 * is leaving. The entry needs to be removed from the list so a
+		 * new futex_lock_pi() is not using this outdated PI-state while
+		 * the futex is available in userland again.
+		 * There can be more than one task on its way out so it needs
+		 * to retry.
 		 */
 		rt_waiter =3D rt_mutex_top_waiter(&pi_state->pi_mutex);
 		if (!rt_waiter) {
+			__futex_unqueue(top_waiter);
 			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-			goto do_uncontended;
+			goto retry_hb;
 		}
=20
 		get_pi_state(pi_state);
@@ -1217,7 +1223,6 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 		return ret;
 	}
=20
-do_uncontended:
 	/*
 	 * We have no kernel internal state, i.e. no waiters in the
 	 * kernel. Waiters which are about to queue themselves are stuck
--=20
2.43.0


