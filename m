Return-Path: <linux-kernel+bounces-142433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863B38A2B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1615F28465B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7097853373;
	Fri, 12 Apr 2024 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yo0bSjLE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b1mgBzsd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7A51C34;
	Fri, 12 Apr 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915180; cv=none; b=iBsqHvnNGDehqCM8o/eqeB8f2Jhagn96VPsuaVrJ6rQ37HlzNY/OyU5rWx+ReJz/VPkNwyE11F0dRN4h3RkyeEDFnASMFRZUTmjdWipsDum0gWU/qhT9Z/Q7Czm1Q2kk9hnW+Z68AdFGjdTkTyWUekis69qvocf3ROPGLdwrCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915180; c=relaxed/simple;
	bh=/Us3vhKdB2/ROVstVTV5U/SGyd83c1WO34+U6z6ZpKk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YFlRVsMWo27A1UdpP4s5Nbhb2ZC+vDvZcikKzKSouiFZAod8y53BeI8Tgl8R5aSNyWp+GvWKnD7GGkHBOKQd7j2aQak1Mj3zQFKw0ane5BzG90BEydsEduFtu7vIOOMAouOl7sNx3o8oCEwF208ecbLJlyCoURpy6NEgq0H/1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yo0bSjLE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b1mgBzsd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 09:46:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712915177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6XRvPI1tYLBSmNwTmwjjmv92sbhGwJHc4BFKYQy6xA=;
	b=yo0bSjLEhCokMcnku9+1qy4nqzmV+u27aM8Au4K8KgD0jcryCmgkRDMLypHZIdDA7wxeSs
	lY141dgHsSALcBCNTEcfCs8GGVG5L+04CFBK/8qcQV7tDFLbDHp7wYrZnRupduomx0IhJo
	vodkyQKzm/RCHkc+LTJOGLGe1Pp9PbkJWofZv8etTuV3ySUUFZjGkeGRfAoa0F3QCDWfIu
	bXOkXj92EUU8w6kFkQVBzNol8ctlKlkPHgComo7sghljQNi7GiEDoA5dzqkkGiMceeexH1
	UwStvtdFahWo88eAyyILD1RQGuRqWw/2V7NtM7EVHZQafftGg8RI49tjS5kodw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712915177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6XRvPI1tYLBSmNwTmwjjmv92sbhGwJHc4BFKYQy6xA=;
	b=b1mgBzsdDVXtp20y76OYzL7k6USQx6ufsC0P6NVBro8Bs2mf/uGd8cxpuRVJeVhcVQB1/K
	eltbiwEcp7+ph4Ag==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/pvqspinlock: Use try_cmpxchg() in
 qspinlock_paravirt.h
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240411192317.25432-2-ubizjak@gmail.com>
References: <20240411192317.25432-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291517671.10875.5289616784830783285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fea0e1820b51fff95c85518eb9cf3386f367908d
Gitweb:        https://git.kernel.org/tip/fea0e1820b51fff95c85518eb9cf3386f367908d
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 11 Apr 2024 21:22:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:42:39 +02:00

locking/pvqspinlock: Use try_cmpxchg() in qspinlock_paravirt.h

Use try_cmpxchg(*ptr, &old, new) instead of
cmpxchg(*ptr, old, new) == old in qspinlock_paravirt.h
x86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240411192317.25432-2-ubizjak@gmail.com
---
 kernel/locking/qspinlock_paravirt.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 77ba80b..f5a36e6 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -86,9 +86,10 @@ static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
 	 */
 	for (;;) {
 		int val = atomic_read(&lock->val);
+		u8 old = 0;
 
 		if (!(val & _Q_LOCKED_PENDING_MASK) &&
-		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
+		    try_cmpxchg_acquire(&lock->locked, &old, _Q_LOCKED_VAL)) {
 			lockevent_inc(pv_lock_stealing);
 			return true;
 		}
@@ -211,8 +212,9 @@ static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
 	int hopcnt = 0;
 
 	for_each_hash_entry(he, offset, hash) {
+		struct qspinlock *old = NULL;
 		hopcnt++;
-		if (!cmpxchg(&he->lock, NULL, lock)) {
+		if (try_cmpxchg(&he->lock, &old, lock)) {
 			WRITE_ONCE(he->node, node);
 			lockevent_pv_hop(hopcnt);
 			return &he->lock;
@@ -355,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-
+	enum vcpu_state old = vcpu_halted;
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
 	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
@@ -372,8 +374,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * subsequent writes.
 	 */
 	smp_mb__before_atomic();
-	if (cmpxchg_relaxed(&pn->state, vcpu_halted, vcpu_hashed)
-	    != vcpu_halted)
+	if (!try_cmpxchg_relaxed(&pn->state, &old, vcpu_hashed))
 		return;
 
 	/*
@@ -541,15 +542,14 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 #ifndef __pv_queued_spin_unlock
 __visible __lockfunc void __pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	u8 locked;
+	u8 locked = _Q_LOCKED_VAL;
 
 	/*
 	 * We must not unlock if SLOW, because in that case we must first
 	 * unhash. Otherwise it would be possible to have multiple @lock
 	 * entries, which would be BAD.
 	 */
-	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
-	if (likely(locked == _Q_LOCKED_VAL))
+	if (try_cmpxchg_release(&lock->locked, &locked, 0))
 		return;
 
 	__pv_queued_spin_unlock_slowpath(lock, locked);

