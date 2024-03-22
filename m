Return-Path: <linux-kernel+bounces-111341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3448A886AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661491C220CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261573E47A;
	Fri, 22 Mar 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dTuTLc4x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mdg7VRgf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A33DB9A;
	Fri, 22 Mar 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105202; cv=none; b=WCwCd1dLt+NKB87ZHtlMChGl452+wi+xecvg9BQQSf2/G+t5YtAi9i0WdtZwjcDkMNOqHqtNDl9j4gpOkUSwY0O5qsnELw5RHZM9BfZKfhdSTvUZXkbUzz7ggIxIl58xvhGolJHUlQciudEBc9tVzZI7i9FB5uKkH/kX7F6LUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105202; c=relaxed/simple;
	bh=jR1XNcvsHwjnd4It71umk/+CV4lbR2TTav/lz40gfKU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M9pmXUKg5aedxUl6NUSAR47DR4xzT6RlIT3qKMjpu44ADxrmOOFlMymT75/6682QFCuFcQPnoVHBqtyF1Q4yZiLaPUTBIDNjzx0RFM/Xca9I5J9/Jn4So6JTc4TsuoV20Cri/MqHx/wDDUdEd7kw0a2dpf1w6otWlJe9v9z6x10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dTuTLc4x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mdg7VRgf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:59:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1e0+gmYX8Kxbp4o62Y+EmKIpRm/NrTSIkt3j9nSUXmk=;
	b=dTuTLc4xN4rkUXO1tk3cGZclRuXX9URbwRcYZU/ppoKQ1f/RlP1Lb+IYAVO1N/QfDNT2Cr
	QTlhktGBk+PSyBTuqZCqJRWYrz+DzCeZ9yFYnHnt5FEs/R/2NLvfWhHtkIK0Xz7mGTvVQd
	zGCf/PKUYEvTzd0y3+HQgd9XrzaXz00d20i/DATMd0NyKRPWO523xDn9VDLTYtxpVanaa2
	FZs3wobwYZke+oqVVO9iquktixxOo1xRy0ILT3xpRS0rc7wrcAMDKFPo56c0zkQUUEhWIR
	Hf5je4udNQTAXZ9GudiD2YndXWFMpuhwd2sk5SPH/tdn5xiAqV2PSgOF3/C4Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1e0+gmYX8Kxbp4o62Y+EmKIpRm/NrTSIkt3j9nSUXmk=;
	b=Mdg7VRgfzWo4qzaCWUjCR4T9UGMC0LIVGsfHLSS12uvDgkMym4NEY3yU7ScCDFhxvNCEfZ
	MlG/jIn3YGHyh3Aw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Unify arch_raw_cpu_ptr() defines
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240322102730.209141-1-ubizjak@gmail.com>
References: <20240322102730.209141-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110519683.10875.9761392357975582831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     4e5b0e8003df05983b6dabcdde7ff447d53b49d7
Gitweb:        https://git.kernel.org/tip/4e5b0e8003df05983b6dabcdde7ff447d53b49d7
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 22 Mar 2024 11:27:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 11:34:12 +01:00

x86/percpu: Unify arch_raw_cpu_ptr() defines

When building a 32-bit vDSO for a 64-bit kernel, games are played with
CONFIG_X86_64. {this,raw}_cpu_read_8() macros are conditionally defined
on CONFIG_X86_64 and when CONFIG_X86_64 is undefined in fake_32bit_build.h
various build failures in generic percpu header files can happen. To make
things worse, the build of 32-bit vDSO for a 64-bit kernel grew dependency
on arch_raw_cpu_ptr() macro and the build fails if arch_raw_cpu_ptr()
macro is not defined.

To mitigate these issues, x86 carefully defines arch_raw_cpu_ptr() to
avoid any dependency on raw_cpu_read_8() and thus CONFIG_X86_64. W/o
segment register support, the definition uses size-agnostic MOV asm
mnemonic and hopes that _ptr argument won't ever be 64-bit size on
32-bit targets (although newer GCCs warn for this situation with
"unsupported size for integer register"), and w/ segment register
support the definition uses size-agnostic __raw_cpu_read() macro.

Fortunately, raw_cpu_read() is not used in 32-bit vDSO for a 64-bit kernel.
However, we can't simply omit the definition of arch_raw_cpu_read(),
since the build will fail when building vdso/vdso32/vclock_gettime.o.

The patch defines arch_raw_cpu_ptr to BUILD_BUG() when BUILD_VDSO32_64
macro is defined. This way, we are sure that arch_raw_cpu_ptr() won't
actually be used in 32-bit VDSO for a 64-bit kernel, but it is still
defined to prevent build failure.

Finally, we can unify arch_raw_cpu_ptr() between builds w/ and w/o
x86 segment register support, substituting two tricky macro definitions
with a straightforward implementation.

There is no size difference and no difference in number of this_cpu_off
accesses between patched and unpatched kernel when the kernel is built
either w/ and w/o segment register support.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240322102730.209141-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 42 ++++++++++++++--------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 7563e69..f6ddbaa 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -59,36 +59,30 @@
 #define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
-#ifdef CONFIG_USE_X86_SEG_SUPPORT
-/*
- * Efficient implementation for cases in which the compiler supports
- * named address spaces.  Allows the compiler to perform additional
- * optimizations that can save more instructions.
- */
-#define arch_raw_cpu_ptr(ptr)					\
-({								\
-	unsigned long tcp_ptr__;				\
-	tcp_ptr__ = __raw_cpu_read(, this_cpu_off);		\
-								\
-	tcp_ptr__ += (unsigned long)(ptr);			\
-	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
-})
-#else /* CONFIG_USE_X86_SEG_SUPPORT */
+#ifdef CONFIG_X86_64
+#define __raw_my_cpu_offset	raw_cpu_read_8(this_cpu_off);
+#else
+#define __raw_my_cpu_offset	raw_cpu_read_4(this_cpu_off);
+#endif
+
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
+ *
+ * arch_raw_cpu_ptr should not be used in 32-bit VDSO for a 64-bit
+ * kernel, because games are played with CONFIG_X86_64 there and
+ * sizeof(this_cpu_off) becames 4.
  */
-#define arch_raw_cpu_ptr(ptr)					\
+#ifndef BUILD_VDSO32_64
+#define arch_raw_cpu_ptr(_ptr)					\
 ({								\
-	unsigned long tcp_ptr__;				\
-	asm ("mov " __percpu_arg(1) ", %0"			\
-	     : "=r" (tcp_ptr__)					\
-	     : "m" (__my_cpu_var(this_cpu_off)));		\
-								\
-	tcp_ptr__ += (unsigned long)(ptr);			\
-	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
+	unsigned long tcp_ptr__ = __raw_my_cpu_offset;		\
+	tcp_ptr__ += (unsigned long)(_ptr);			\
+	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;		\
 })
-#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+#else
+#define arch_raw_cpu_ptr(_ptr) ({ BUILD_BUG(); (typeof(_ptr))0; })
+#endif
 
 #define PER_CPU_VAR(var)	%__percpu_seg:(var)__percpu_rel
 

