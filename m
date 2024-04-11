Return-Path: <linux-kernel+bounces-140513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E158A159F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98C01C21F99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33141509B9;
	Thu, 11 Apr 2024 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ylU+1+Wr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jxOaslzx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9B14F13C;
	Thu, 11 Apr 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842427; cv=none; b=BBTZprAdwEkL2wkwxVDhBKqUbFwJ9J83GnxqGMHceZ/LVtEQowA1RKwepqT5Qk1IJThmLZRxCNoWsfOFCscG/TPoMWIqQp9yigRwcAg+9DikL7OaRzwLEdHhIIxEz5cAu9qGyXlIqt05jUI2VkdKRJY28MHcxx2Vg/+UFyMRKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842427; c=relaxed/simple;
	bh=CTsZ3geEpyeUBeF8httS+4YkKLB1Eb9XdorTHopdmCc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lHLowZEeikZJwDcBOdhQc05AEMcvGWdf0sntjn1V64M9kqXW2SythQoXMBdwe09HlMqXu+TYGeyFdR6gYBOTF27f7xrKc9T/HmPKf4ymbbJkcMNytbzL5CdgI6GyaTAgB1TFMxl32yJSlJlfwtthjo+O5gG59jgcZVQGjlS7+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ylU+1+Wr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jxOaslzx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 13:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712842421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNqR9Y5JGQ4CxyKKvoYHU90nk2eqTzymbAxs2+eiH6A=;
	b=ylU+1+WrvMf5/yZvF5uuF7u3q+k5yokybOyi/Y9FspYg1l9MnGeKXpLh0tY4SxglsuXeDM
	SdPu1J2PwK9412z1wLHgvhK+Qpgk7mwjcKymnigeMmanxJadfyCyMK4f2t6bOeASoyop92
	9tDnj3HjnPmPC6i0HRT0wWZw7cnumUR2748r69At9z3SSezasdZf9ZCUeGUUPtfOtooz0V
	IQMA3kaK9vII58cqOYC0ChnWtqUdOSFxVT3LQO5dqY3fJko2xVvic7sMXkovxnMY85OPWO
	Z+v6bRGjPaHQeY+XZj6LIpO/qXyMRh7iSu0EBrIbOfb6wqGDmC+6yGEuQ42zvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712842421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNqR9Y5JGQ4CxyKKvoYHU90nk2eqTzymbAxs2+eiH6A=;
	b=jxOaslzxHo+/x/OO53FDxfxmgkMHXAJ+zcqWj8aHIJ7mNhYwpj+gq+Ly5VnOow3+WxwgVM
	TGUCPb8ZNP29qeCA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/pvqspinlock: Use try_cmpxchg_acquire() in
 trylock_clear_pending()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325140943.815051-1-ubizjak@gmail.com>
References: <20240325140943.815051-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171284242025.10875.1534973785149780371.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7316aec453e4f5cb7bd0d7b856c01ed71d64eafc
Gitweb:        https://git.kernel.org/tip/7316aec453e4f5cb7bd0d7b856c01ed71d64eafc
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 25 Mar 2024 15:09:32 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 11 Apr 2024 15:19:08 +02:00

locking/pvqspinlock: Use try_cmpxchg_acquire() in trylock_clear_pending()

Use try_cmpxchg_acquire(*ptr, &old, new) instead of
cmpxchg_relaxed(*ptr, old, new) == old in trylock_clear_pending().

x86 CMPXCHG instruction returns success in ZF flag, so this change
saves a compare after CMPXCHG.

Also change the return type of the function to bool.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240325140943.815051-1-ubizjak@gmail.com
---
 kernel/locking/qspinlock_paravirt.h | 31 +++++++++++-----------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 169950f..77ba80b 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -116,11 +116,12 @@ static __always_inline void set_pending(struct qspinlock *lock)
  * barrier. Therefore, an atomic cmpxchg_acquire() is used to acquire the
  * lock just to be sure that it will get it.
  */
-static __always_inline int trylock_clear_pending(struct qspinlock *lock)
+static __always_inline bool trylock_clear_pending(struct qspinlock *lock)
 {
+	u16 old = _Q_PENDING_VAL;
+
 	return !READ_ONCE(lock->locked) &&
-	       (cmpxchg_acquire(&lock->locked_pending, _Q_PENDING_VAL,
-				_Q_LOCKED_VAL) == _Q_PENDING_VAL);
+	       try_cmpxchg_acquire(&lock->locked_pending, &old, _Q_LOCKED_VAL);
 }
 #else /* _Q_PENDING_BITS == 8 */
 static __always_inline void set_pending(struct qspinlock *lock)
@@ -128,27 +129,21 @@ static __always_inline void set_pending(struct qspinlock *lock)
 	atomic_or(_Q_PENDING_VAL, &lock->val);
 }
 
-static __always_inline int trylock_clear_pending(struct qspinlock *lock)
+static __always_inline bool trylock_clear_pending(struct qspinlock *lock)
 {
-	int val = atomic_read(&lock->val);
-
-	for (;;) {
-		int old, new;
-
-		if (val  & _Q_LOCKED_MASK)
-			break;
+	int old, new;
 
+	old = atomic_read(&lock->val);
+	do {
+		if (old & _Q_LOCKED_MASK)
+			return false;
 		/*
 		 * Try to clear pending bit & set locked bit
 		 */
-		old = val;
-		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
-		val = atomic_cmpxchg_acquire(&lock->val, old, new);
+		new = (old & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
+	} while (!atomic_try_cmpxchg_acquire (&lock->val, &old, new));
 
-		if (val == old)
-			return 1;
-	}
-	return 0;
+	return true;
 }
 #endif /* _Q_PENDING_BITS == 8 */
 

