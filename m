Return-Path: <linux-kernel+bounces-142432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEDB8A2B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F9D2846D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A71B51C5F;
	Fri, 12 Apr 2024 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eera+E5N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kh9Ezgy/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC55029E;
	Fri, 12 Apr 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915179; cv=none; b=a/5OaRfR/0bh8FuQ+1Bt7MDneiEQrCJ6lXdYbvdKff+jhtKl/MptUJSRaOiHF/5hq3H3FARQw7XOMkwYhzAgRX4jykwQ1+0PxreIdeRk2OScnoXdOR4J943O0TAQ/AYqb9nPVFnooIYCX7WXQd+cI3KS3ic6mpQk/HJonyFoLE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915179; c=relaxed/simple;
	bh=nY2HZ1f8wNsbOBID8Qb2flqd7tg0W3IWGl9YIBHIA+k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WLF51S8pcgHoNlxCL51uU5e2Klalyyt8nCMwJ2ad+N9aipdwWhlcxGNdRrOvunw4YebEoE3gTJer9VCV+hgo2IO/PZFjeLXcztht/2rmwb2isUMYp+O9kjIUARQ+1FzkZnBNHRrcjapNC2/V38VYQV4ys5JvEmbJGW5xapDmT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eera+E5N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kh9Ezgy/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 09:46:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712915176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/dDRHBZviqKDdaJhSeFyGu0sUlyJFV7Gn5NgSYg+H4=;
	b=Eera+E5N4APbhLI29EwB1PvImApb/6sRDmac935doEtjBtXSuQMHs73pOSiyw2LBr8rmwC
	xS46SEr8RwLtYWPeVgbZ9kC3vdymSPa0ZV4iATPYGBFRcLb6pLt7oiLXBdWeE9wPyw4yPl
	po9iDswrZkleNod59Y8YCiImGQsTF61XLmx7IhuV79ni0kHs4EF3RZAQcP/J+LmT3mge8l
	IDOFO9pTueXc7mjfcL5Q9/ePrmXtQ9mZP3ECKCxtY7VNGhU5Gq9S/3G2hjM9tgYX5m8oaT
	+QGlfkchWQe6Cm5Jy8+ajd53msZDsHRVP+3I3PA87lcVliCVeGwYc1UrvvUCZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712915176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/dDRHBZviqKDdaJhSeFyGu0sUlyJFV7Gn5NgSYg+H4=;
	b=Kh9Ezgy/uRlidrqWx6f7VEaXFRoR+dn219sUxpHoqa1FNCkY3oLxY1ffxBk21+UXMXq3AQ
	zuCUZTSgF89aHnCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/pvqspinlock/x86: Remove redundant CMP
 after CMPXCHG in __raw_callee_save___pv_queued_spin_unlock()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240412083908.282802-1-ubizjak@gmail.com>
References: <20240412083908.282802-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291517494.10875.13395064705936119876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     91095666125a666c8f20c2323b742c53165c0325
Gitweb:        https://git.kernel.org/tip/91095666125a666c8f20c2323b742c53165c0325
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 12 Apr 2024 10:38:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:42:39 +02:00

locking/pvqspinlock/x86: Remove redundant CMP after CMPXCHG in __raw_callee_save___pv_queued_spin_unlock()

x86 CMPXCHG instruction returns success in the ZF flag. Remove
redundant CMP instruction after CMPXCHG that performs the same check.

Also update the function comment to mention the modern version
of the equivalent C code.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240412083908.282802-1-ubizjak@gmail.com
---
 arch/x86/include/asm/qspinlock_paravirt.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index ef9697f..466af57 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -25,9 +25,9 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
  *
  * void __lockfunc __pv_queued_spin_unlock(struct qspinlock *lock)
  * {
- *	u8 lockval = cmpxchg(&lock->locked, _Q_LOCKED_VAL, 0);
+ *	u8 lockval = _Q_LOCKED_VAL;
  *
- *	if (likely(lockval == _Q_LOCKED_VAL))
+ *	if (try_cmpxchg(&lock->locked, &lockval, 0))
  *		return;
  *	pv_queued_spin_unlock_slowpath(lock, lockval);
  * }
@@ -43,7 +43,6 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
 	"mov   $0x1,%eax\n\t"						\
 	"xor   %edx,%edx\n\t"						\
 	LOCK_PREFIX "cmpxchg %dl,(%rdi)\n\t"				\
-	"cmp   $0x1,%al\n\t"						\
 	"jne   .slowpath\n\t"						\
 	"pop   %rdx\n\t"						\
 	FRAME_END							\

