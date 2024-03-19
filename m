Return-Path: <linux-kernel+bounces-107519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5A087FD96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512EC28439D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F75A4CF;
	Tue, 19 Mar 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W7XxmfFw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b2z2le2c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D6D2747F;
	Tue, 19 Mar 2024 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851504; cv=none; b=FDWtqSt/bsahyMxsLIVgbHAyLzw09R/meGugR83TGzGVGsq3vNUXOh8RDZ8BbF1I8FMOVwnGN3g65XcqT9sjwzQ4A4HIlO232be1JnCljRJxDguFellzNjfQLYDlbrN7YXwDB5F3vZcog+Z0lCyLjBEH+z6RPhSWlZV0HWiLdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851504; c=relaxed/simple;
	bh=4E0p9OA+AHZegx1OjwFG/vtXoat+qET8byh1uV6fwSo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jQHpa2y7F/3mLeciD3Y7GKkYONf/BhWMXIFwHo597qC+IXlklxqgeZIqgyfWIaCkQIq5x0phaOcrXMwFLgp6NH6rfzzt/D5oVLjcNXxp+BC5dk6OxGpsAErCT34WgUmUjKvQ8vFXWk7dkBOhP6LUfafZ3g6IXTPI/wRbixggROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W7XxmfFw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b2z2le2c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Mar 2024 12:31:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710851501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaryC1gY0dJnWP4Ke9xeEFDxyiGl1erXSVWSmvFXd/8=;
	b=W7XxmfFwOBP4pgddzXsLhOe/xTi2+h6pgDITawjTppe+wqbTMlZpF68W1h6ZlNAP2M/iSS
	S8n0p/TFrVkYpXW94xZr7cnfCBlhHr6Uhv8FmGfv/WtzGt+EbRr1rmCmGiF31P1b+HtUbj
	cxjdzh63LxZLvyccZ1JWeeXF2f+d7Iza/3vDp6Ynmnshv2uvH8kADok6hWPwyv7m3jxlcx
	qs05ZOo4wMKca1kdCDlB3a04KfZi0rxkABCqMDWf1cOU9o2DYbsgZh0V6ORV0iEmbpx2H/
	keXGzSMPYQUMgbS1n0o5W4I1cXhBElekWWYOfEwCo+Vvfb1MSDvQtu2q2GpECw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710851501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaryC1gY0dJnWP4Ke9xeEFDxyiGl1erXSVWSmvFXd/8=;
	b=b2z2le2c9/k4MHXj5atQ3TV1ZWBpHCn5vZf9LpSiXUEpSRM6BYXSdQSI0NYURulRwSAQSQ
	ilaA4TRsyptLFlDQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Use %c/%n instead of %P operand modifier in
 asm templates
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240319104418.284519-3-ubizjak@gmail.com>
References: <20240319104418.284519-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171085150042.10875.11586176433790867976.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     41cd2e1ee96e56401a18dbce6f42f0bdaebcbf3b
Gitweb:        https://git.kernel.org/tip/41cd2e1ee96e56401a18dbce6f42f0bdaebcbf3b
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 19 Mar 2024 11:40:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Mar 2024 13:15:35 +01:00

x86/asm: Use %c/%n instead of %P operand modifier in asm templates

The "P" asm operand modifier is a x86 target-specific modifier.

When used with a constant, the "P" modifier emits "cst" instead of
"$cst". This property is currently used to emit the bare constant
without all syntax-specific prefixes.

The generic "c" resp. "n" operand modifier should be used instead.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240319104418.284519-3-ubizjak@gmail.com
---
 arch/x86/boot/main.c               |  4 ++--
 arch/x86/include/asm/alternative.h | 22 +++++++++++-----------
 arch/x86/include/asm/atomic64_32.h |  2 +-
 arch/x86/include/asm/cpufeature.h  |  2 +-
 arch/x86/include/asm/irq_stack.h   |  2 +-
 arch/x86/include/asm/uaccess.h     |  4 ++--
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index c4ea525..9049f39 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -119,8 +119,8 @@ static void init_heap(void)
 	char *stack_end;
 
 	if (boot_params.hdr.loadflags & CAN_USE_HEAP) {
-		asm("leal %P1(%%esp),%0"
-		    : "=r" (stack_end) : "i" (-STACK_SIZE));
+		asm("leal %n1(%%esp),%0"
+		    : "=r" (stack_end) : "i" (STACK_SIZE));
 
 		heap_end = (char *)
 			((size_t)boot_params.hdr.heap_end_ptr + 0x200);
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index fcd20c6..9943269 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -294,10 +294,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, if CPU has feature1, newinstr1 is used.
  * Otherwise, oldinstr is used.
  */
-#define alternative_input_2(oldinstr, newinstr1, ft_flags1, newinstr2,	     \
-			   ft_flags2, input...)				     \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1,     \
-		newinstr2, ft_flags2)					     \
+#define alternative_input_2(oldinstr, newinstr1, ft_flags1, newinstr2,	\
+			   ft_flags2, input...)				\
+	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, \
+		newinstr2, ft_flags2)					\
 		: : "i" (0), ## input)
 
 /* Like alternative_input, but with a single output argument */
@@ -307,7 +307,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile (ALTERNATIVE("call %P[old]", "call %P[new]", ft_flags) \
+	asm_inline volatile (ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
@@ -316,12 +316,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, if CPU has feature1, function1 is used.
  * Otherwise, old function is used.
  */
-#define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,   \
-			   output, input...)				      \
-	asm_inline volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", ft_flags1,\
-		"call %P[new2]", ft_flags2)				      \
-		: output, ASM_CALL_CONSTRAINT				      \
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
+#define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2, \
+			   output, input...)				\
+	asm_inline volatile (ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1, \
+		"call %c[new2]", ft_flags2)				\
+		: output, ASM_CALL_CONSTRAINT				\
+		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		\
 		  [new2] "i" (newfunc2), ## input)
 
 /*
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 3486d91..d510405 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -24,7 +24,7 @@ typedef struct {
 
 #ifdef CONFIG_X86_CMPXCHG64
 #define __alternative_atomic64(f, g, out, in...) \
-	asm volatile("call %P[func]" \
+	asm volatile("call %c[func]" \
 		     : out : [func] "i" (atomic64_##g##_cx8), ## in)
 
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index a127369..fa938ed 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -169,7 +169,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 static __always_inline bool _static_cpu_has(u16 bit)
 {
 	asm goto(
-		ALTERNATIVE_TERNARY("jmp 6f", %P[feature], "", "jmp %l[t_no]")
+		ALTERNATIVE_TERNARY("jmp 6f", %c[feature], "", "jmp %l[t_no]")
 		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
 		" testb %[bitnum]," _ASM_RIP(%P[cap_byte]) "\n"
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 7981838..b71ad17 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -100,7 +100,7 @@
 }
 
 #define ASM_CALL_ARG0							\
-	"call %P[__func]				\n"		\
+	"call %c[__func]				\n"		\
 	ASM_REACHABLE
 
 #define ASM_CALL_ARG1							\
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 237dc8c..0f9bab9 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -78,7 +78,7 @@ extern int __get_user_bad(void);
 	int __ret_gu;							\
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
 	__chk_user_ptr(ptr);						\
-	asm volatile("call __" #fn "_%P4"				\
+	asm volatile("call __" #fn "_%c4"				\
 		     : "=a" (__ret_gu), "=r" (__val_gu),		\
 			ASM_CALL_CONSTRAINT				\
 		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
@@ -177,7 +177,7 @@ extern void __put_user_nocheck_8(void);
 	__chk_user_ptr(__ptr);						\
 	__ptr_pu = __ptr;						\
 	__val_pu = __x;							\
-	asm volatile("call __" #fn "_%P[size]"				\
+	asm volatile("call __" #fn "_%c[size]"				\
 		     : "=c" (__ret_pu),					\
 			ASM_CALL_CONSTRAINT				\
 		     : "0" (__ptr_pu),					\

