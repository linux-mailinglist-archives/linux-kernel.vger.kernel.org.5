Return-Path: <linux-kernel+bounces-140512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E6E8A159E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CAC1C21F60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2161509BD;
	Thu, 11 Apr 2024 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CmdTXFzX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JaRrBdqU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5514F103;
	Thu, 11 Apr 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842427; cv=none; b=mJXjf9+I9FoyUhbAjnM647Wggqo+HI0kzIahoERdztujEQr0YfEY7WL8c/T/v6wGI1ZTB0MIky1EG004eVyqVjAyx3sAwlew/6dlaSHUH3Y5UMbMXFPxPHNmTPbTdjRGJ6/4rSeUa5EaWt4SIEJ/ymgNF2xB9nh0VKnWrU/PtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842427; c=relaxed/simple;
	bh=92o/s1vjdKCCEAN7tCKADYk7AtNcGSvjS9LNsUv9+2Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DvOj47Q2oBpD3BfrM6s5SOsLvaLEhIPGGg8fQO4h2LsVApBrE2na+VCkLwbSQ0ZkKbJMXLU7/eCUwDUJMMlotPxYPKeMfJVwSgjX/sJbP7IW7Esso9FF5mWerdmOE1iaEmUVXKzgn1ISkxDvV6bmvm162SS57NcbM9I0G+q2p3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CmdTXFzX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JaRrBdqU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 13:33:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712842421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5wIEDLHP2BJVwrHrqk3PT7SL1PU/3MmNsD2H3lnyhM=;
	b=CmdTXFzXqa2VMuHxH10kwAOem/Rw2mk26b3buZa7RR/va8nIwUp3Y48UDmRghZXGz+0Tm5
	AQ3p6v2aXlu9erzUJKKoVQRILD8RAt91Z9KUefNr9dX3Hm2GHburZ0Nn/fjv4zTgbZvtOa
	vC0+UvY+ldTjxVAXPCJ0FAf9VLOh4Ck35wgpNg68ZujV/R8Nqpi1RQVtcVeIDt9NqeB2yn
	fm3SE8eas59IYkDfEeGXXwx7FcKUwUEw2xq6HyTZbZPlVQaHjw2vGQ7EaJLQ8/EadIjJNt
	VDUPAJidiWvyUp999OIzDJIGWMYuZGN9HQ7FuY60N+TjjVNQcFkYDFrXyitO5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712842421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5wIEDLHP2BJVwrHrqk3PT7SL1PU/3MmNsD2H3lnyhM=;
	b=JaRrBdqUhlqCsOR36ZwJXdBCmEXstnVHCTYdNSOEOojdUG5Fy2eiaucO5lVLFql0PmD0qY
	KuTpYd/zjttsmDAg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/qspinlock: Use
 atomic_try_cmpxchg_relaxed() in xchg_tail()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240321195309.484275-1-ubizjak@gmail.com>
References: <20240321195309.484275-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171284242106.10875.12200696780479010207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     79a34e3d8411050c3c7550c5163d6f9dc41e8f66
Gitweb:        https://git.kernel.org/tip/79a34e3d8411050c3c7550c5163d6f9dc41e8f66
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 21 Mar 2024 20:52:47 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 11 Apr 2024 15:14:54 +02:00

locking/qspinlock: Use atomic_try_cmpxchg_relaxed() in xchg_tail()

Use atomic_try_cmpxchg_relaxed(*ptr, &old, new) instead of
atomic_cmpxchg_relaxed (*ptr, old, new) == old in xchg_tail().

x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after CMPXCHG.

No functional change intended.

Since this code requires NR_CPUS >= 16k, I have tested it
by unconditionally setting _Q_PENDING_BITS to 1 in
<asm-generic/qspinlock_types.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240321195309.484275-1-ubizjak@gmail.com
---
 kernel/locking/qspinlock.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ebe6b8e..1df5fef 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -220,21 +220,18 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
  */
 static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 {
-	u32 old, new, val = atomic_read(&lock->val);
+	u32 old, new;
 
-	for (;;) {
-		new = (val & _Q_LOCKED_PENDING_MASK) | tail;
+	old = atomic_read(&lock->val);
+	do {
+		new = (old & _Q_LOCKED_PENDING_MASK) | tail;
 		/*
 		 * We can use relaxed semantics since the caller ensures that
 		 * the MCS node is properly initialized before updating the
 		 * tail.
 		 */
-		old = atomic_cmpxchg_relaxed(&lock->val, val, new);
-		if (old == val)
-			break;
+	} while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
 
-		val = old;
-	}
 	return old;
 }
 #endif /* _Q_PENDING_BITS == 8 */

