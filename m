Return-Path: <linux-kernel+bounces-61809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BCF8516CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAEC28839F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F473AC14;
	Mon, 12 Feb 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O6M8R4K7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XNmOYAI6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729AC25740;
	Mon, 12 Feb 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747224; cv=none; b=n1P9gGBVcx2Shht4SGMuFUSwIx5WAswVVad6e08y0tfuoRyNx6qB/mGMthInWEPxUDlzGlyhXxJEhfxkRo4fQvx89iHqT11fE6mnnkMlqnuReHs0/kZEG1SBfbMxAI1RaCynpqXSC46iwBciG3cXaDDjyCtcpFcVlK8U3joywHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747224; c=relaxed/simple;
	bh=uI+LMNZYCq6kx+lc/OmKCSNQRSFIRHImLjt07bHMtxU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uH6bNuyjShHCcvaha8RgOoxjfwfQHqB++vT98JEGppT0fdpeRS7gdVcAo6aqOFieKRrY5YmEeit392hkDQOUKxhpg8RpKIo1U2tsGPLuVMnpcH+q8wPhO0YNHo7+PMGAH770I9U/H9b6Gyg3Aw/bDpwZlBf5dJi2Lh3Dwmwu2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O6M8R4K7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XNmOYAI6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Feb 2024 14:13:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707747220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/btgRaaXpwyohIzAiBllWU5S3huEnjVIWuh9P97HrI=;
	b=O6M8R4K7GoqhQdGuBgilF0r7S9P+uLX6Gz23AuksoEdBLRgKiMlvTjzxh60hcRUFuqGxl+
	bn1VupNfEGkrEw8J4C8tziNc7nR4ADd9QED+Zpdt3HyFEFUDqf1rZxvHhZBbgQe9w2LBEK
	+E3SRisWV60tv+iquZWjcoL7GNXjgJB/2ZGFGRdrzJReoqurCmuapUMJsn8ovcAKNSkwtF
	TnZeRWLuPw/3g5YELthqbHcoH5SqSt5uxIvN+VMbSAmAm4dURj6arKqO0UTyU008iJkUsk
	1kBai75n3urs2OfmF7xnRAEky68dhCfa+M1Za1PhHphx9E+N44r2qj6F/nf7Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707747220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/btgRaaXpwyohIzAiBllWU5S3huEnjVIWuh9P97HrI=;
	b=XNmOYAI6LfkJI/Zi8hzjfzQ7sHypZAIPr1ojm0chKEZL7GV74G6tbAYudqsCwOk0y3b8i7
	+fWNCyjxhdZrfACg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't used
 at runtime
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231010171020.462211-4-david.kaplan@amd.com>
References: <20231010171020.462211-4-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170774721951.398.8999401565129728535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     4461438a8405e800f90e0e40409e5f3d07eed381
Gitweb:        https://git.kernel.org/tip/4461438a8405e800f90e0e40409e5f3d07eed381
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 03 Jan 2024 19:36:26 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Feb 2024 11:42:15 +01:00

x86/retpoline: Ensure default return thunk isn't used at runtime

Make sure the default return thunk is not used after all return
instructions have been patched by the alternatives because the default
return thunk is insufficient when it comes to mitigating Retbleed or
SRSO.

Fix based on an earlier version by David Kaplan <david.kaplan@amd.com>.

  [ bp: Fix the compilation error of warn_thunk_thunk being an invisible
        symbol, hoist thunk macro into calling.h ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231010171020.462211-4-david.kaplan@amd.com
Link: https://lore.kernel.org/r/20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local
---
 arch/x86/entry/calling.h             | 60 +++++++++++++++++++++++++++-
 arch/x86/entry/entry.S               |  4 ++-
 arch/x86/entry/thunk_32.S            | 34 +++------------
 arch/x86/entry/thunk_64.S            | 33 +---------------
 arch/x86/include/asm/nospec-branch.h |  2 +-
 arch/x86/kernel/cpu/bugs.c           |  5 ++-
 arch/x86/lib/retpoline.S             | 15 ++-----
 7 files changed, 85 insertions(+), 68 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 39e069b..bd31b25 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -426,3 +426,63 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 
 #endif /* CONFIG_SMP */
+
+#ifdef CONFIG_X86_64
+
+/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
+.macro THUNK name, func
+SYM_FUNC_START(\name)
+	pushq %rbp
+	movq %rsp, %rbp
+
+	pushq %rdi
+	pushq %rsi
+	pushq %rdx
+	pushq %rcx
+	pushq %rax
+	pushq %r8
+	pushq %r9
+	pushq %r10
+	pushq %r11
+
+	call \func
+
+	popq %r11
+	popq %r10
+	popq %r9
+	popq %r8
+	popq %rax
+	popq %rcx
+	popq %rdx
+	popq %rsi
+	popq %rdi
+	popq %rbp
+	RET
+SYM_FUNC_END(\name)
+	_ASM_NOKPROBE(\name)
+.endm
+
+#else /* CONFIG_X86_32 */
+
+/* put return address in eax (arg1) */
+.macro THUNK name, func, put_ret_addr_in_eax=0
+SYM_CODE_START_NOALIGN(\name)
+	pushl %eax
+	pushl %ecx
+	pushl %edx
+
+	.if \put_ret_addr_in_eax
+	/* Place EIP in the arg1 */
+	movl 3*4(%esp), %eax
+	.endif
+
+	call \func
+	popl %edx
+	popl %ecx
+	popl %eax
+	RET
+	_ASM_NOKPROBE(\name)
+SYM_CODE_END(\name)
+	.endm
+
+#endif
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index 8c8d38f..582731f 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -7,6 +7,8 @@
 #include <linux/linkage.h>
 #include <asm/msr-index.h>
 
+#include "calling.h"
+
 .pushsection .noinstr.text, "ax"
 
 SYM_FUNC_START(entry_ibpb)
@@ -20,3 +22,5 @@ SYM_FUNC_END(entry_ibpb)
 EXPORT_SYMBOL_GPL(entry_ibpb);
 
 .popsection
+
+THUNK warn_thunk_thunk, __warn_thunk
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index 0103e10..da37f42 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -4,33 +4,15 @@
  * Copyright 2008 by Steven Rostedt, Red Hat, Inc
  *  (inspired by Andi Kleen's thunk_64.S)
  */
-	#include <linux/export.h>
-	#include <linux/linkage.h>
-	#include <asm/asm.h>
 
-	/* put return address in eax (arg1) */
-	.macro THUNK name, func, put_ret_addr_in_eax=0
-SYM_CODE_START_NOALIGN(\name)
-	pushl %eax
-	pushl %ecx
-	pushl %edx
+#include <linux/export.h>
+#include <linux/linkage.h>
+#include <asm/asm.h>
 
-	.if \put_ret_addr_in_eax
-	/* Place EIP in the arg1 */
-	movl 3*4(%esp), %eax
-	.endif
+#include "calling.h"
 
-	call \func
-	popl %edx
-	popl %ecx
-	popl %eax
-	RET
-	_ASM_NOKPROBE(\name)
-SYM_CODE_END(\name)
-	.endm
-
-	THUNK preempt_schedule_thunk, preempt_schedule
-	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
-	EXPORT_SYMBOL(preempt_schedule_thunk)
-	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
+THUNK preempt_schedule_thunk, preempt_schedule
+THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
+EXPORT_SYMBOL(preempt_schedule_thunk)
+EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
 
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 416b400..119ebdc 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -9,39 +9,6 @@
 #include "calling.h"
 #include <asm/asm.h>
 
-	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
-	.macro THUNK name, func
-SYM_FUNC_START(\name)
-	pushq %rbp
-	movq %rsp, %rbp
-
-	pushq %rdi
-	pushq %rsi
-	pushq %rdx
-	pushq %rcx
-	pushq %rax
-	pushq %r8
-	pushq %r9
-	pushq %r10
-	pushq %r11
-
-	call \func
-
-	popq %r11
-	popq %r10
-	popq %r9
-	popq %r8
-	popq %rax
-	popq %rcx
-	popq %rdx
-	popq %rsi
-	popq %rdi
-	popq %rbp
-	RET
-SYM_FUNC_END(\name)
-	_ASM_NOKPROBE(\name)
-	.endm
-
 THUNK preempt_schedule_thunk, preempt_schedule
 THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 EXPORT_SYMBOL(preempt_schedule_thunk)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 2c0679e..5575461 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -357,6 +357,8 @@ extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
 
+extern void __warn_thunk(void);
+
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 extern void call_depth_return_thunk(void);
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f277541..a78892b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2850,3 +2850,8 @@ ssize_t cpu_show_gds(struct device *dev, struct device_attribute *attr, char *bu
 	return cpu_show_common(dev, attr, buf, X86_BUG_GDS);
 }
 #endif
+
+void __warn_thunk(void)
+{
+	WARN_ONCE(1, "Unpatched return thunk in use. This should not happen!\n");
+}
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 0045153..721b528 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -369,19 +369,16 @@ SYM_FUNC_END(call_depth_return_thunk)
  * 'JMP __x86_return_thunk' sites are changed to something else by
  * apply_returns().
  *
- * This should be converted eventually to call a warning function which
- * should scream loudly when the default return thunk is called after
- * alternatives have been applied.
- *
- * That warning function cannot BUG() because the bug splat cannot be
- * displayed in all possible configurations, leading to users not really
- * knowing why the machine froze.
+ * The ALTERNATIVE below adds a really loud warning to catch the case
+ * where the insufficient default return thunk ends up getting used for
+ * whatever reason like miscompilation or failure of
+ * objtool/alternatives/etc to patch all the return sites.
  */
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	ANNOTATE_UNRET_SAFE
-	ret
+	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
+		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
 	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)

