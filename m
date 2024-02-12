Return-Path: <linux-kernel+bounces-61341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E371E851149
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2C0282E09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D938DE6;
	Mon, 12 Feb 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DyrPx6QE"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34738DDB;
	Mon, 12 Feb 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734655; cv=none; b=eS4k2Tny/bzAwW27YIoBUxb6ReSewq8/nujvOVAYkxjvjkrwyfkUf0eqKcVCcXvFDk+dcRl2kt+rBv60XdWvVtzvYAYuGdjNBjJ9no7eFhodFWdUyJHYNljGczUshmF4ba88tMbn+hUAtmRh5g46oZlkMfA7XrpHg0m7VBlPtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734655; c=relaxed/simple;
	bh=CrOYH9a+uL00kaq5dqCGBi5Zww5IQFNLMv5KG/VwCo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrExlDHMbviSWmko06RfpJEr/Xhp8fWLS/RI5sFnBFzJmwNWksKcJIw3FbQ2cbnyStNWe24rBWDHdpwDlPqc2gXPIaWB5nAew2kDR4zbMH20zntoUUI/MKOom9gXrDCZ6JsR0OnVdXotnciczlKJZPbpWokPR62pbBpfExKis6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DyrPx6QE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5384140E01BB;
	Mon, 12 Feb 2024 10:44:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oI1myRAYt05M; Mon, 12 Feb 2024 10:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707734641; bh=jzm/aR7NBcXNN2Dg+AOCM49HtsHX6x1Lpil3z+Aeggc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyrPx6QE8LWS9Pk5EGpBgIIDlzaJn+wxIDisYGEjxFbwU1kZVB/SqIMCkDZFde1Jw
	 vjYSEEhcvnkDe4Nrl6/droFonEwLSV1rnk91R8hfK0UkzoKISpdUwMQImNey6o83/g
	 lgpSPTKI/8Uidqx/DLEl/gufJehy74y0ZkswitKiQJ3XpMb/GKVZEqlx5TCexW4FTI
	 R+H5xy4PbQ411LFNcBexJekQb6Cj3pMicWw+4BY3FiGJjO1iEt4njHQR4R5YhHzCe8
	 kvoHkqke3bSaKAyI0ATJ02ybqi5Fx75ViUEfVg8l1vfoevb1w3wSO8+Rgs6CgJ2+LW
	 juUjG48VgytpBi6YcQzvpkWezt+zoTYKTGy3v+xQ+0yuYeKArLrVlLSwt/oS0h9Jc1
	 bPd7PUF1B2UbyaEWYRbGIWnw13+t3EN2WhquDBNXV0qe2q73sLRXLC7E3wGN5UgxI4
	 vNUrBcFmy0ZaghA5CE9AdM2BhuYFTjrYKotv1loQU43kCctU5Mqj4zNfEymrwIyGsG
	 SjqMII68yuMHDfRSQqDdBcLPJZhQerGZ2xOaVWJ0YhD9Uf99W9AObkj8fKgu4Xhvm3
	 1f2Xk7vpx74saAw4rm3KWC4Ey1v+8yolikdbNaFFcjqaemHCjE+VQM7i8KrYgK2xvW
	 drfO4VXP/3ikBjv1OJtsn4EM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C2E740E0192;
	Mon, 12 Feb 2024 10:43:53 +0000 (UTC)
Date: Mon, 12 Feb 2024 11:43:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20240212104348.GCZcn2ZPr445KUyQ7k@fat_crate.local>
References: <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
 <20231019152051.4u5xwhopbdisy6zl@treble>
 <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
 <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
 <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
 <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
 <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
 <20240207175010.nrr34b2pp3ewe3ga@treble>
 <20240207185328.GEZcPRqPsNInRXyNMj@fat_crate.local>
 <20240207194919.qw4jk2ykadjn5d4e@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207194919.qw4jk2ykadjn5d4e@treble>

On Wed, Feb 07, 2024 at 11:49:19AM -0800, Josh Poimboeuf wrote:
> LGTM, thanks!

Thanks, had to hoist up both THUNK macros into the header to make that
nuisance 32-bit build too :)

---

commit 4461438a8405e800f90e0e40409e5f3d07eed381 (HEAD -> refs/heads/tip-x86-bugs)
Author: Josh Poimboeuf <jpoimboe@kernel.org>
Date:   Wed Jan 3 19:36:26 2024 +0100

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

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 39e069b68c6e..bd31b2534053 100644
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
index 8c8d38f0cb1d..582731f74dc8 100644
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
index 0103e103a657..da37f42f4549 100644
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
index 416b400f39db..119ebdc3d362 100644
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
index 2c0679ebe914..55754617eaee 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -357,6 +357,8 @@ extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
 
+extern void __warn_thunk(void);
+
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 extern void call_depth_return_thunk(void);
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f2775417bda2..a78892b0f823 100644
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
index 0045153ba222..721b528da9ac 100644
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

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

