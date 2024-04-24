Return-Path: <linux-kernel+bounces-156692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068068B06E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD671C234A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE68B159573;
	Wed, 24 Apr 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jkMDpSwl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vKkx5wSI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61101E898;
	Wed, 24 Apr 2024 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953080; cv=none; b=MeR+iMtBIoQuBjYVK6KhWnA0SPioIQyl+HLQOUmA9N7fQ1AZj/A804v8x+AulAQQsd3gkfR9kNSMpAz/6sZoJeiqNJ7664GDwkEtYHJvbDFjVg90aimVYXr47jikFt8RiJOeDPLJW1q3EkJw5TYPhvAiRE6H17aDXTRU/ycXRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953080; c=relaxed/simple;
	bh=Mk9yY1IVzMkCwg8ukBt2cjctBsXnx5bLjRDBsb/8D8A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eVkoIX6VZk+skc8T+dfvH9y3RRUPtsyb3LbQGhjVpO3ml8CXQmHAWlentrOTrLpxDlOD6u5Mwp5mrmgB2ladpKIOydbfd232gXLTYAOVKPce24uGbj6ja6Ex2sE01Pfhaj+BMCRaf2JLtCC0Z4bSZoJuT1qMuoGJFKsMYyc8kAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jkMDpSwl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vKkx5wSI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 10:04:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713953067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYTo7tuDJQz2R+7uScgPU0yIuBe0fZ67igOX6Mgcv0M=;
	b=jkMDpSwlAlP8EgX5yazNew1VcV3sqECmy8Na+7NLOjNp64lRd+ymLn4XYpb3xRXTwzoy1Q
	gTZpPi41bvMqvhfZq2PKsQM6VB6vwaBMbOi+KODH48AeiuIVJeVuV2dz2PYoF/pm4ToXA5
	FaPNcKNQm9i9EczLh48ka2C/iObgCM+q09Iqves7oQV6kBW+v6a+cFO4ZSlmlKOtZxjJGr
	r4wx9+Y0zA+BEKGlouieaW4BSUJDzExQZ1XiyJlnO8thf0twv/wBwGg4mZr44TtH7EXfpB
	eSRl+IcK+B+RHtrPrRl1GoLgWchsVbmdr/rFBu/L6407+2zMGYJ17ajQxuybRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713953067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYTo7tuDJQz2R+7uScgPU0yIuBe0fZ67igOX6Mgcv0M=;
	b=vKkx5wSIbwtcN4fpzSyjNhEJhQeSdOwyeQhe5o8Zd6YzH/5Gb7Oh2soB7/CqGIQE7oGdMI
	b6AMlr0WbS8Q7+BQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Merge
 __arch{,_try}_cmpxchg64_emu_local() with __arch{,_try}_cmpxchg64_emu()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240417175830.161561-1-ubizjak@gmail.com>
References: <20240417175830.161561-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171395306701.10875.170965990896741924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     33eb8ab4ec83cf0975d0113966c7e71cd6be60b2
Gitweb:        https://git.kernel.org/tip/33eb8ab4ec83cf0975d0113966c7e71cd6be60b2
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 17 Apr 2024 19:58:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Apr 2024 11:45:13 +02:00

locking/atomic/x86: Merge __arch{,_try}_cmpxchg64_emu_local() with __arch{,_try}_cmpxchg64_emu()

Macros __arch{,_try}_cmpxchg64_emu() are almost identical to their
local variants __arch{,_try}_cmpxchg64_emu_local(), differing only
by lock prefixes.

Merge these two macros by introducing additional macro parameters
to pass lock location and lock prefix from their respective static
inline functions.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240417175830.161561-1-ubizjak@gmail.com
---
 arch/x86/include/asm/cmpxchg_32.h | 56 +++++-------------------------
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 9dedc13..ed2797f 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -86,14 +86,14 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, 
  * to simulate the cmpxchg8b on the 80386 and 80486 CPU.
  */
 
-#define __arch_cmpxchg64_emu(_ptr, _old, _new)				\
+#define __arch_cmpxchg64_emu(_ptr, _old, _new, _lock_loc, _lock)	\
 ({									\
 	union __u64_halves o = { .full = (_old), },			\
 			   n = { .full = (_new), };			\
 									\
-	asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE			\
+	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
-				 "lock; cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
+				 _lock "cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
 		     : [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
@@ -104,40 +104,25 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, 
 
 static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
 {
-	return __arch_cmpxchg64_emu(ptr, old, new);
+	return __arch_cmpxchg64_emu(ptr, old, new, LOCK_PREFIX_HERE, "lock; ");
 }
 #define arch_cmpxchg64 arch_cmpxchg64
 
-#define __arch_cmpxchg64_emu_local(_ptr, _old, _new)			\
-({									\
-	union __u64_halves o = { .full = (_old), },			\
-			   n = { .full = (_new), };			\
-									\
-	asm volatile(ALTERNATIVE("call cmpxchg8b_emu",			\
-				 "cmpxchg8b %[ptr]", X86_FEATURE_CX8)	\
-		     : [ptr] "+m" (*(_ptr)),				\
-		       "+a" (o.low), "+d" (o.high)			\
-		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
-		     : "memory");					\
-									\
-	o.full;								\
-})
-
 static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
 {
-	return __arch_cmpxchg64_emu_local(ptr, old, new);
+	return __arch_cmpxchg64_emu(ptr, old, new, ,);
 }
 #define arch_cmpxchg64_local arch_cmpxchg64_local
 
-#define __arch_try_cmpxchg64_emu(_ptr, _oldp, _new)			\
+#define __arch_try_cmpxchg64_emu(_ptr, _oldp, _new, _lock_loc, _lock)	\
 ({									\
 	union __u64_halves o = { .full = *(_oldp), },			\
 			   n = { .full = (_new), };			\
 	bool ret;							\
 									\
-	asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE			\
+	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
-				 "lock; cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
+				 _lock "cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
 		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
@@ -153,34 +138,13 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 
 
 static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
 {
-	return __arch_try_cmpxchg64_emu(ptr, oldp, new);
+	return __arch_try_cmpxchg64_emu(ptr, oldp, new, LOCK_PREFIX_HERE, "lock; ");
 }
 #define arch_try_cmpxchg64 arch_try_cmpxchg64
 
-#define __arch_try_cmpxchg64_emu_local(_ptr, _oldp, _new)		\
-({									\
-	union __u64_halves o = { .full = *(_oldp), },			\
-			   n = { .full = (_new), };			\
-	bool ret;							\
-									\
-	asm volatile(ALTERNATIVE("call cmpxchg8b_emu",			\
-				 "cmpxchg8b %[ptr]", X86_FEATURE_CX8)	\
-		     CC_SET(e)						\
-		     : CC_OUT(e) (ret),					\
-		       [ptr] "+m" (*(_ptr)),				\
-		       "+a" (o.low), "+d" (o.high)			\
-		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
-		     : "memory");					\
-									\
-	if (unlikely(!ret))						\
-		*(_oldp) = o.full;					\
-									\
-	likely(ret);							\
-})
-
 static __always_inline bool arch_try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, u64 new)
 {
-	return __arch_try_cmpxchg64_emu_local(ptr, oldp, new);
+	return __arch_try_cmpxchg64_emu(ptr, oldp, new, ,);
 }
 #define arch_try_cmpxchg64_local arch_try_cmpxchg64_local
 

