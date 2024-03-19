Return-Path: <linux-kernel+bounces-107520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB387FD97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C845A1F23870
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824EB7FBB6;
	Tue, 19 Mar 2024 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3Cswu0R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0HC5NkWc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D832E400;
	Tue, 19 Mar 2024 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851505; cv=none; b=A9BbrRlShl912acAakpneR6sNqcEOsA7E8ehxAB+nZFcSwbAyvViWyLNxCbTyVzwdHyQTVXsx8L0mulZNRl5EyTDbqt7z6PN23H4hTtIcqhOkTkJaq1A0V9H+YnHWMkM1tfvdi6ENGYUvkdmKa1OGf/22fwCHMz2QBD33dI99Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851505; c=relaxed/simple;
	bh=nWsuFg+nvKimCB4J0dPbZBgLS5phK0OHmb1s7ySmek0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tl8Ed3mAIvSrvT7cz8Lk0B8hsQLopHNwKU2i8sYc7izOhJ8Paatc+VduxSHFt1pMuFNALc1H8Y1AvO8yIbjHLZ0jy1uiBcZhnIM8YHHdBUKI9lwIqe/5Dv67c6+8FZGvgZUy7h7NLjd2wSPqnMdxHgxRpyrearGkWZEyM2aKOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3Cswu0R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0HC5NkWc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Mar 2024 12:31:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710851502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRo7t5zANXrFccUKajJfOkGAnApTY+nXBuT6H9mcWZA=;
	b=v3Cswu0RojObyjeAcupo+7EBP4P30Swz41yHh550dhqDzCnrbSNo12A+0DP5wRRV0PaHgX
	Ks8bUFNZJasbICfDtkQYhX6AgsIQ+eq7WX/yxjAQCQo9wAjx7ljxTcIQFZmUGh2P8gDU1M
	sO1dwQTN/cb+gLTmlp3H/FmzzautQR3np83pdtYRUCk8HeEduZvR9EpZB6XMXne5iLUee4
	oaSQq1XP0TofyO+nL2yo5dlWw8HzF8l0C4VqeR1jwLVfY3rdB+Y3JlSpbesYJxCsLEOtgL
	p8YZ7clrIcdboos7cA87LJSavWjVoTiic8LFcC7Ee2GfcByHmiWvyD+FkyRxwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710851502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRo7t5zANXrFccUKajJfOkGAnApTY+nXBuT6H9mcWZA=;
	b=0HC5NkWcxwPf1F4YjEFEbsTSHaY2vTC178p06VgRUmFE97BjrYbAAvefAevoQ6YIEjm36V
	3NWnXhn/AmS8WYAg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Remove %P operand modifier from altinstr asm
 templates
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240319104418.284519-2-ubizjak@gmail.com>
References: <20240319104418.284519-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171085150114.10875.3719610470474227640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     a3ff53167cef2b5c6c8948246172d6f9279f037f
Gitweb:        https://git.kernel.org/tip/a3ff53167cef2b5c6c8948246172d6f9279f037f
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 19 Mar 2024 11:40:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Mar 2024 13:15:34 +01:00

x86/asm: Remove %P operand modifier from altinstr asm templates

The "P" asm operand modifier is a x86 target-specific modifier.

For x86_64, when used with a symbol reference, the "%P" modifier
emits "sym" instead of "sym(%rip)". This property is currently
used to prevent %RIP-relative addressing in .altinstr sections.

%RIP-relative addresses are nowadays correctly handled in .altinstr
sections, so remove %P operand modifier from altinstr asm templates.

Also note that unlike GCC, clang emits %rip-relative symbol
reference with "P" asm operand modifier, so the patch also unifies
symbol handling with both compilers.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240319104418.284519-2-ubizjak@gmail.com
---
 arch/x86/include/asm/apic.h          | 2 +-
 arch/x86/include/asm/processor.h     | 6 +++---
 arch/x86/include/asm/special_insns.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 94ce0f7..fa2e424 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -91,7 +91,7 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 {
 	volatile u32 *addr = (volatile u32 *)(APIC_BASE + reg);
 
-	alternative_io("movl %0, %P1", "xchgl %0, %P1", X86_BUG_11AP,
+	alternative_io("movl %0, %1", "xchgl %0, %1", X86_BUG_11AP,
 		       ASM_OUTPUT2("=r" (v), "=m" (*addr)),
 		       ASM_OUTPUT2("0" (v), "m" (*addr)));
 }
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f..438c0c8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -587,7 +587,7 @@ extern char			ignore_fpu_irq;
 # define BASE_PREFETCH		""
 # define ARCH_HAS_PREFETCH
 #else
-# define BASE_PREFETCH		"prefetcht0 %P1"
+# define BASE_PREFETCH		"prefetcht0 %1"
 #endif
 
 /*
@@ -598,7 +598,7 @@ extern char			ignore_fpu_irq;
  */
 static inline void prefetch(const void *x)
 {
-	alternative_input(BASE_PREFETCH, "prefetchnta %P1",
+	alternative_input(BASE_PREFETCH, "prefetchnta %1",
 			  X86_FEATURE_XMM,
 			  "m" (*(const char *)x));
 }
@@ -610,7 +610,7 @@ static inline void prefetch(const void *x)
  */
 static __always_inline void prefetchw(const void *x)
 {
-	alternative_input(BASE_PREFETCH, "prefetchw %P1",
+	alternative_input(BASE_PREFETCH, "prefetchw %1",
 			  X86_FEATURE_3DNOWPREFETCH,
 			  "m" (*(const char *)x));
 }
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2e9fc5c..0ee2ba5 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -182,8 +182,8 @@ static __always_inline void clflush(volatile void *__p)
 
 static inline void clflushopt(volatile void *__p)
 {
-	alternative_io(".byte 0x3e; clflush %P0",
-		       ".byte 0x66; clflush %P0",
+	alternative_io(".byte 0x3e; clflush %0",
+		       ".byte 0x66; clflush %0",
 		       X86_FEATURE_CLFLUSHOPT,
 		       "+m" (*(volatile char __force *)__p));
 }

