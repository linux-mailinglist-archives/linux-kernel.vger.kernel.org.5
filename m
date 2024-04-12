Return-Path: <linux-kernel+bounces-142397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D38A2B16
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AE328AE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA99E5789E;
	Fri, 12 Apr 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/kYj3Cl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kGN2Be4y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C059B51C34;
	Fri, 12 Apr 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913677; cv=none; b=siA9Og4qzbXm2TceH2VoEbsQi5al81/BvTrff4VwE2vH9leHTDC2cdhbu58ARm0TnL5sipkZrT5rQaRmzVniXiZzqaERT6isP82ACUyWA/NszEwU0OtuPcWBpTNNTYMg3dQYNhIBcmirNKDMRGgIU5MokQr4XlZTipohQNJ+TtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913677; c=relaxed/simple;
	bh=3vqlV7nuJVIxwLtggOR4FA9iApy/iGXT3+WyhuVqGEg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YpCGVnCEPNn9tEEAAh6PeAsO4dlrB9EpkAYwNoWnMLsGzebzf35RY/M8iNUfyiebeK8P0kmVxR62tgMAYHnkI0GpkPqntaiwTw60vbrRQuhUXubWIm/gd+1HiY7U+UiUmOUO4Nk5O9qVNqzNdTYhYPC6dINlNUQjhXfZMIorbP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/kYj3Cl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kGN2Be4y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 09:21:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712913668;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgmYgwwZi90eXTj5n/Q0qCknlWcNGDmvUBJwpSGubBQ=;
	b=h/kYj3ClLR5jFiDnChq4SNf4pNsDSeM8VV8prauwT6e0zvEy6C5mBSd/xfXPvmjFURiv4d
	MROtUhgGET0doDGIg59agxmEY3WRxDEPJBOQsf3C46+BFmKV+UkEbKrUtvrS9NIXPgTODk
	nielhAMwSxx5fne9QxLO8bE93//ruydLCK1s3IXeVf7qJXEaC5YXrTwRN7oE4a+dAhjLC8
	NjXIw5Idh58uvG8a9xmY/ISRMDylUn1NfusDXy0X9g6mpDIvTE4iLVX5iZCBvgiteh107q
	aQXF8uWF8r1BpKCNd3M2GH4gHra6blxnFOqmb2Mb51FTLlD23LL1ArudI8RKhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712913668;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgmYgwwZi90eXTj5n/Q0qCknlWcNGDmvUBJwpSGubBQ=;
	b=kGN2Be4y1KdK6fYDatpqFgVyKrN7giJzQ9cX2N5vk6om1fSDudetRNSTc+KwHOTZ+TsEOa
	Cn6gY/e8UBH9FODQ==
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
Message-ID: <171291366703.10875.3042491829353534171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e361be1ff2621493f5c638719d706e9789f7ab4c
Gitweb:        https://git.kernel.org/tip/e361be1ff2621493f5c638719d706e9789f7ab4c
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 11 Apr 2024 21:22:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 10:56:45 +02:00

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

