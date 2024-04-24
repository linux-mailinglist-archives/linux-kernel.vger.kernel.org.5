Return-Path: <linux-kernel+bounces-156691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D928B06E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA13D281E16
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6C0159216;
	Wed, 24 Apr 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HDJm9Ro6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qXrSmrYu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D102158DDC;
	Wed, 24 Apr 2024 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953079; cv=none; b=eG1MJup4qaDDO2AyxmtxTmDx5RpaL0xCfHbSdHY5kcsh7viFbphObM/2dzCnBV8Qy+RxkQ5widEwOfumqWhGT0fawvRf6Xz5PJAefOuh11Mvge+ZFywr64Lv35wUwz70IdwGE2rGtMgYHMCiKfOeIEtVfcRFogNVwck3L79sWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953079; c=relaxed/simple;
	bh=gvCRJc7Vl5sSkNeFuRS44MOSMhBghTLZALAiwpcMrHk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OWEAy+dbINVAVYrG9G5l5vD1jYQTmrjgTLsA+lGT4UBSCYkEoIs7ibKc2HhOOJ63CJEoIeJoY/txaLU+EJivoyB5T0x4+woOcliW34XjYUynPgFG9SYoxnfjs+PIc1BJ4Tl0pV2d3HYgLgR53WLjK2x2jrIsr4MjkV60k+iIglc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HDJm9Ro6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qXrSmrYu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 10:04:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713953067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OelZoFz8WpDRzkyvDR4X73zTTNcDag/PPb+K94UZAA=;
	b=HDJm9Ro68cu0i9qU7ubtej/AbrfXS67EJoNKs5/VuN7T37CYcKw+++RaGxKuJr//qdcJ7M
	guh9IH2ykY8HFgHFTKPSOSYWQRK9qpJlGNUVT4Xb3rwRxfwOgiRfGCnwjkRiu+IESJlARL
	Hh6T5ZWwazk07SCvNx0UCw4dmm847GxiQpr070CD7Q+zBDKtyKkaZWpgdf6Y7PQxvxvBhP
	TpK2cjJmbyMLZTl7Cs52qBLMr6h9XPest/ZdtcBDZJGjVU4y25qJjDpw0EMkb04uZZMauO
	uk31g5+r94wBNyNE9baLnQEnz/qcB10epeeFGkXU0LkVhLmL7PWHamrXWm+oEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713953067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OelZoFz8WpDRzkyvDR4X73zTTNcDag/PPb+K94UZAA=;
	b=qXrSmrYus1SNcDdPd+ex9FNsFuAGRy1WoOeoRiQPvJG+7GJcRylMwIg205kJA2uAGRU8c1
	whLU+RNYroX0q6AQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/qspinlock/x86: Micro-optimize virt_spin_lock()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240422120054.199092-1-ubizjak@gmail.com>
References: <20240422120054.199092-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171395306631.10875.1846466008666455267.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     94af3a04e3f386d4f060d903826e85aa006ce252
Gitweb:        https://git.kernel.org/tip/94af3a04e3f386d4f060d903826e85aa006ce252
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 22 Apr 2024 14:00:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Apr 2024 11:46:28 +02:00

locking/qspinlock/x86: Micro-optimize virt_spin_lock()

Optimize virt_spin_lock() to use simpler and faster:

  atomic_try_cmpxchg(*ptr, &val, new)

instead of:

  atomic_cmpxchg(*ptr, val, new) == val

The x86 CMPXCHG instruction returns success in the ZF flag, so
this change saves a compare after the CMPXCHG.

Also optimize retry loop a bit. atomic_try_cmpxchg() fails iff
&lock->val != 0, so there is no need to load and compare the
lock value again - cpu_relax() can be unconditinally called in
this case. This allows us to generate optimized:

  1f:	ba 01 00 00 00       	mov    $0x1,%edx
  24:	8b 03                	mov    (%rbx),%eax
  26:	85 c0                	test   %eax,%eax
  28:	75 63                	jne    8d <...>
  2a:	f0 0f b1 13          	lock cmpxchg %edx,(%rbx)
  2e:	75 5d                	jne    8d <...>
..
  8d:	f3 90                	pause
  8f:	eb 93                	jmp    24 <...>

instead of:

  1f:	ba 01 00 00 00       	mov    $0x1,%edx
  24:	8b 03                	mov    (%rbx),%eax
  26:	85 c0                	test   %eax,%eax
  28:	75 13                	jne    3d <...>
  2a:	f0 0f b1 13          	lock cmpxchg %edx,(%rbx)
  2e:	85 c0                	test   %eax,%eax
  30:	75 f2                	jne    24 <...>
..
  3d:	f3 90                	pause
  3f:	eb e3                	jmp    24 <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240422120054.199092-1-ubizjak@gmail.com
---
 arch/x86/include/asm/qspinlock.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index cde8357..a053c12 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -85,6 +85,8 @@ DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
 #define virt_spin_lock virt_spin_lock
 static inline bool virt_spin_lock(struct qspinlock *lock)
 {
+	int val;
+
 	if (!static_branch_likely(&virt_spin_lock_key))
 		return false;
 
@@ -94,10 +96,13 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
 	 * horrible lock 'holder' preemption issues.
 	 */
 
-	do {
-		while (atomic_read(&lock->val) != 0)
-			cpu_relax();
-	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
+ __retry:
+	val = atomic_read(&lock->val);
+
+	if (val || !atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)) {
+		cpu_relax();
+		goto __retry;
+	}
 
 	return true;
 }

