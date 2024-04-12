Return-Path: <linux-kernel+bounces-142434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE5B8A2B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8411F23B38
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2B7535C4;
	Fri, 12 Apr 2024 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FVJzn917";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KCe+HV/B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968E51C4C;
	Fri, 12 Apr 2024 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915181; cv=none; b=C0AN1M1g4I1CWGTDfJB5gUeVQTHc5Ia+o/rlsB3OIHDEqEECluUgtLbmlZ1wtminKX1/8zNAeVxgEx0YyJ3NEPn82DMpDDl3INPC+0Bgt88nDASbvmcL0GUy1S0kz5hnLoMZ/ymbFYE97EycJ1+omjEkXr2iSuRCR2UILObJSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915181; c=relaxed/simple;
	bh=jBz/HMkvv+0sd3mP9PWjxg83skYoEgnXTTpvRUB3Uio=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EDGCERXWLTBo1qAXXKKcHWygbtxu8HJgSwFB04hHfx1SW1bJfCQvng7zHJtf0im7q1CXeFXQtNOLHhSDhpWlJw2b5RijawBMAaldft3q+STgjeVGCMP5ie06outDlh75VHUFbkgIfaFj3vTm1e+MT4rR1lhSu2vno9ad84/kfI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FVJzn917; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KCe+HV/B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 09:46:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712915178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGIyutRBqWNV7XA/uAedtweAqsJl0yr6qyftNGTuIhs=;
	b=FVJzn917NS1CVQi8naX5qipSsjrMP7efbw9VJs2Fk2yzwNfWfV+qR9adtaAf2uh7uaYPxg
	15YWRA9rqe2mQeVBeRlmWt6ajGKbXfbG3Jd1Z5NJxl9JMfZN7SaQzOyraOG2Hht4I8svPn
	CDR2u1W2gW9hHelWJr5NX4ukGDmObrUdqU8z/JmVYPv2qpG3a9MSZxICcAy0kB+gmDzv93
	T3oGLmaUKN9gVTPrVjlIZ8/5+dH+YKra5Q4tdc2GlLB772oVa7PBD/Dua/7PkBqXe9zNoZ
	Efwi4PTFDu31pf1Y9j/XPyhq3b25ydyZAJWekBTg+0q1uUxIwCoLyexuW58/PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712915178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGIyutRBqWNV7XA/uAedtweAqsJl0yr6qyftNGTuIhs=;
	b=KCe+HV/BB4o3pjH0b/BfztkXNfIdSNEvWFPAEgFCuhOVB5rBwm1OJBsONp5jLrP/g+XuoJ
	yj5A1xx9RUKCtFBQ==
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
Message-ID: <171291517748.10875.14791822256739905706.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6a97734f2222e0352f1900e3eb3167e9069b91bb
Gitweb:        https://git.kernel.org/tip/6a97734f2222e0352f1900e3eb3167e9069b91bb
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 25 Mar 2024 15:09:32 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:40:51 +02:00

locking/pvqspinlock: Use try_cmpxchg_acquire() in trylock_clear_pending()

Replace this pattern in trylock_clear_pending():

    cmpxchg_acquire(*ptr, old, new) == old

.. with the simpler and faster:

    try_cmpxchg_acquire(*ptr, &old, new)

The x86 CMPXCHG instruction returns success in the ZF flag, so this change
saves a compare after the CMPXCHG.

Also change the return type of the function to bool and streamline
the control flow in the _Q_PENDING_BITS == 8 variant a bit.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Linus Torvalds <torvalds@linux-foundation.org>
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
 

