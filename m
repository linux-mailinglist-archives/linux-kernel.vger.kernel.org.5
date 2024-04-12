Return-Path: <linux-kernel+bounces-142396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 232178A2B14
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ECB2B20FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F138E53373;
	Fri, 12 Apr 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QAUIUl4T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v30Ka9lu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130030673;
	Fri, 12 Apr 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913676; cv=none; b=t0ZUgXPC9X4KcLeYohyONYXdBQR1G2C/aaj1nuMRhL7/P++c9qA5gxQwVFjJS8o+G5EW8oRSUgr1bxN1d7vfniNZsOO3iRgtUPX8fXksgotxqHFUHsHjJ4Y+vnHtsfk+vNJ2cV3tGorWffSinS5qElW02jiRiuPpiu0TvM5vcb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913676; c=relaxed/simple;
	bh=eS6alrJrOHEZiEj5dc7a7A5wTet5RFhvCr5aeiTu6+U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cKW2TENaBjEjj2IIBBIpCZgN+Pqs1OL7ixs1XgV5WYJPN675RVAWed3iyGUj00XhIMgB1jabpBOuFuFv57bNigfdqO7UwGiNzyFyxrGx8lmQO9hnu8pnm2Ut9eOmD8ysP5qacAhkpVKqkt0zexZ/c/Ap51WNwD1O5HvhIZgtlug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QAUIUl4T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v30Ka9lu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 09:21:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712913667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/FHUquWuddHgfqIj0/BPX+NYU/ipObBibu7br3NzAg=;
	b=QAUIUl4TGf556WS9MVEzN5xD80k/Yp6MntgGPh8yeilsLZ/ZhdeKDqBPK29WAg5PEdC/Jb
	VU7qMxoSsfURhCcUuGYzQs6jZqNLmqLHCkV1bnRDRviLhVoFSAvS6vwWaHCcTOUpv5Wk0r
	jJUKB0mzKB9hAV8L8X9LHNz21dXnMmzFYuMbhLuFbJuw8t+plneaL6rvHj5ndKYxE9HVIr
	zLqW4mBXaPz55NrNwxe/LSRzA/HL6DR+hQOv1pN7x8qMkhsItxDYUZIno2cJ85HDTcW0mN
	97arDs7nbDYkZfvp49GLD3POBq8vGvhkEyHYJsHoAJqejy/VspWHxZrFtVeIFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712913667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/FHUquWuddHgfqIj0/BPX+NYU/ipObBibu7br3NzAg=;
	b=v30Ka9luA8Rv2YDn5s3eRl6WOHYhorWN/GLjOpnxPoWxrYoseOACMvIvuLQJpwUeQS55U+
	//gbDpW2/Jws6mCQ==
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
Message-ID: <171291366605.10875.10498022147272421254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8793f85688fee3c6640f1cc3c9feab54c0910fc1
Gitweb:        https://git.kernel.org/tip/8793f85688fee3c6640f1cc3c9feab54c0910fc1
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 12 Apr 2024 10:38:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 10:56:45 +02:00

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

