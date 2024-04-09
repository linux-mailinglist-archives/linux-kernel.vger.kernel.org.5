Return-Path: <linux-kernel+bounces-136453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F8589D431
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754E5282B08
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A567EF02;
	Tue,  9 Apr 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HB71b7lw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gx0dM1x6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290656454;
	Tue,  9 Apr 2024 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651200; cv=none; b=DGH447r4ejUgfXTq2SV8sk40CjAykFJtBM/nAb8BH5QTfBhnRK8FD/c0H5dS0jnswnR0zePOGyGyjYnaBiedkQd/ARzvn/sZrN3ORUptr9PBXJ1LeuZuqRoQK6sdoaEb4vx9tRNdJHbcvhz1VPpthG2d+kzrwVliNbrhUOtgXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651200; c=relaxed/simple;
	bh=JejHKR0gHVu/eqF/L9HtuEJTVGLd0uBI/XfIBGNWRGY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LCEqFcF5kwgjckw5r0mbJa+FnteB2XqlqCY8fco9fqpuN44NGCG2eGp2/IGCM4Zc/rfq5XEGRlylRreE6LIdONB09QYVYUD2nEk4wBuxEUS4tfMEkkO0XPcOtID2loFi/gRBMEKpvyNP5TJ+TPGXljbCLqskJEi9EwcYZ0dNGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HB71b7lw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gx0dM1x6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 08:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712651196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=usxdulLKt5b3hOMpUquF1GHZZ707drbw5wxjSREMHLo=;
	b=HB71b7lwNeipQN0SQp9qYDyau5WNXfuQl42ksBd8j9/3Y4ui4i5cO21iz9no6klSJDZUEG
	BScNSbzH04NebY77Z3UIQEQApgkQEPaJmbuXfbJT946mA7k7pE32OS26RYVP35O4D2Gs9U
	iuhv1N7N+yxjtfpQhfllEC6wiNqARVc995GxFV1x2dhFdY5zCpBt8g8K7xJH+tlBq2UH5p
	NFpvNzeGLkCKKASzsZGtQayAEaM/HFkoQn5XXG/pGnFApKOCY9OX6hpFlGfDGvbVROZ2nY
	a/B/NkMfSCEsvMNdLlibZaiyDrFnp5lNXLlFFWrSqAOgEDCCcp+7AJ3NgYYoCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712651196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=usxdulLKt5b3hOMpUquF1GHZZ707drbw5wxjSREMHLo=;
	b=Gx0dM1x648DdKqMCu3Co/v2nq2rVw/ZtDwaTtgj15zBYmTK6CAqPqNVTJvThzT6jMJqrn1
	DfXbTE7MToPOaYCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Modernize x86_32
 arch_{,try_}_cmpxchg64{,_local}()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240408091547.90111-3-ubizjak@gmail.com>
References: <20240408091547.90111-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265119601.10875.15517936000118837045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7016cc5def44b9dcb28089efae4412fa0d6c78c2
Gitweb:        https://git.kernel.org/tip/7016cc5def44b9dcb28089efae4412fa0d6c78c2
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 08 Apr 2024 11:13:57 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 09 Apr 2024 09:51:03 +02:00

locking/atomic/x86: Modernize x86_32 arch_{,try_}_cmpxchg64{,_local}()

Commit:

  b23e139d0b66 ("arch: Introduce arch_{,try_}_cmpxchg128{,_local}()")

introduced arch_{,try_}_cmpxchg128{,_local}() for x86_64 targets.

Modernize existing x86_32 arch_{,try_}_cmpxchg64{,_local}() definitions
to follow the same structure as the definitions introduced by the
above commit.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240408091547.90111-3-ubizjak@gmail.com
---
 arch/x86/include/asm/cmpxchg_32.h | 179 ++++++++++++++++-------------
 1 file changed, 100 insertions(+), 79 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index b5731c5..fe40d06 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -3,103 +3,124 @@
 #define _ASM_X86_CMPXCHG_32_H
 
 /*
- * Note: if you use set64_bit(), __cmpxchg64(), or their variants,
+ * Note: if you use __cmpxchg64(), or their variants,
  *       you need to test for the feature in boot_cpu_data.
  */
 
-#ifdef CONFIG_X86_CMPXCHG64
-#define arch_cmpxchg64(ptr, o, n)					\
-	((__typeof__(*(ptr)))__cmpxchg64((ptr), (unsigned long long)(o), \
-					 (unsigned long long)(n)))
-#define arch_cmpxchg64_local(ptr, o, n)					\
-	((__typeof__(*(ptr)))__cmpxchg64_local((ptr), (unsigned long long)(o), \
-					       (unsigned long long)(n)))
-#define arch_try_cmpxchg64(ptr, po, n)					\
-	__try_cmpxchg64((ptr), (unsigned long long *)(po), \
-			(unsigned long long)(n))
-#endif
+union __u64_halves {
+	u64 full;
+	struct {
+		u32 low, high;
+	};
+};
+
+#define __arch_cmpxchg64(_ptr, _old, _new, _lock)			\
+({									\
+	union __u64_halves o = { .full = (_old), },			\
+			   n = { .full = (_new), };			\
+									\
+	asm volatile(_lock "cmpxchg8b %[ptr]"				\
+		     : [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high)			\
+		     : "memory");					\
+									\
+	o.full;								\
+})
 
-static inline u64 __cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
+
+static __always_inline u64 __cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
 {
-	u64 prev;
-	asm volatile(LOCK_PREFIX "cmpxchg8b %1"
-		     : "=A" (prev),
-		       "+m" (*ptr)
-		     : "b" ((u32)new),
-		       "c" ((u32)(new >> 32)),
-		       "0" (old)
-		     : "memory");
-	return prev;
+	return __arch_cmpxchg64(ptr, old, new, LOCK_PREFIX);
 }
 
-static inline u64 __cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
+static __always_inline u64 __cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
 {
-	u64 prev;
-	asm volatile("cmpxchg8b %1"
-		     : "=A" (prev),
-		       "+m" (*ptr)
-		     : "b" ((u32)new),
-		       "c" ((u32)(new >> 32)),
-		       "0" (old)
-		     : "memory");
-	return prev;
+	return __arch_cmpxchg64(ptr, old, new,);
 }
 
-static inline bool __try_cmpxchg64(volatile u64 *ptr, u64 *pold, u64 new)
+#define __arch_try_cmpxchg64(_ptr, _oldp, _new, _lock)			\
+({									\
+	union __u64_halves o = { .full = *(_oldp), },			\
+			   n = { .full = (_new), };			\
+	bool ret;							\
+									\
+	asm volatile(_lock "cmpxchg8b %[ptr]"				\
+		     CC_SET(e)						\
+		     : CC_OUT(e) (ret),					\
+		       [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high)			\
+		     : "memory");					\
+									\
+	if (unlikely(!ret))						\
+		*(_oldp) = o.full;					\
+									\
+	likely(ret);							\
+})
+
+static __always_inline bool __try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
 {
-	bool success;
-	u64 old = *pold;
-	asm volatile(LOCK_PREFIX "cmpxchg8b %[ptr]"
-		     CC_SET(z)
-		     : CC_OUT(z) (success),
-		       [ptr] "+m" (*ptr),
-		       "+A" (old)
-		     : "b" ((u32)new),
-		       "c" ((u32)(new >> 32))
-		     : "memory");
-
-	if (unlikely(!success))
-		*pold = old;
-	return success;
+	return __arch_try_cmpxchg64(ptr, oldp, new, LOCK_PREFIX);
 }
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_CMPXCHG64
+
+#define arch_cmpxchg64 __cmpxchg64
+
+#define arch_cmpxchg64_local __cmpxchg64_local
+
+#define arch_try_cmpxchg64 __try_cmpxchg64
+
+#else
+
 /*
  * Building a kernel capable running on 80386 and 80486. It may be necessary
  * to simulate the cmpxchg8b on the 80386 and 80486 CPU.
  */
 
-#define arch_cmpxchg64(ptr, o, n)				\
-({								\
-	__typeof__(*(ptr)) __ret;				\
-	__typeof__(*(ptr)) __old = (o);				\
-	__typeof__(*(ptr)) __new = (n);				\
-	alternative_io(LOCK_PREFIX_HERE				\
-			"call cmpxchg8b_emu",			\
-			"lock; cmpxchg8b (%%esi)" ,		\
-		       X86_FEATURE_CX8,				\
-		       "=A" (__ret),				\
-		       "S" ((ptr)), "0" (__old),		\
-		       "b" ((unsigned int)__new),		\
-		       "c" ((unsigned int)(__new>>32))		\
-		       : "memory");				\
-	__ret; })
-
-
-#define arch_cmpxchg64_local(ptr, o, n)				\
-({								\
-	__typeof__(*(ptr)) __ret;				\
-	__typeof__(*(ptr)) __old = (o);				\
-	__typeof__(*(ptr)) __new = (n);				\
-	alternative_io("call cmpxchg8b_emu",			\
-		       "cmpxchg8b (%%esi)" ,			\
-		       X86_FEATURE_CX8,				\
-		       "=A" (__ret),				\
-		       "S" ((ptr)), "0" (__old),		\
-		       "b" ((unsigned int)__new),		\
-		       "c" ((unsigned int)(__new>>32))		\
-		       : "memory");				\
-	__ret; })
+#define __arch_cmpxchg64_emu(_ptr, _old, _new)				\
+({									\
+	union __u64_halves o = { .full = (_old), },			\
+			   n = { .full = (_new), };			\
+									\
+	asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE			\
+				 "call cmpxchg8b_emu",			\
+				 "lock; cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
+		     : [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
+		     : "memory");					\
+									\
+	o.full;								\
+})
+
+static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
+{
+	return __arch_cmpxchg64_emu(ptr, old, new);
+}
+#define arch_cmpxchg64 arch_cmpxchg64
+
+#define __arch_cmpxchg64_emu_local(_ptr, _old, _new)			\
+({									\
+	union __u64_halves o = { .full = (_old), },			\
+			   n = { .full = (_new), };			\
+									\
+	asm volatile(ALTERNATIVE("call cmpxchg8b_emu",			\
+				 "cmpxchg8b %[ptr]", X86_FEATURE_CX8)	\
+		     : [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
+		     : "memory");					\
+									\
+	o.full;								\
+})
+
+static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
+{
+	return __arch_cmpxchg64_emu_local(ptr, old, new);
+}
+#define arch_cmpxchg64_local arch_cmpxchg64_local
 
 #endif
 

