Return-Path: <linux-kernel+bounces-16700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 340AA8242A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AAF1F23D10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2522333;
	Thu,  4 Jan 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gC3AUGCe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D62111F;
	Thu,  4 Jan 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B74A740E01FE;
	Thu,  4 Jan 2024 13:25:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id r1x95oXWB4s5; Thu,  4 Jan 2024 13:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704374699; bh=mW8/6WyhqJjhljxP6XhSRhYts0OpZuRp9cBGzL263HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gC3AUGCeh2V6Qlk7v0bFHouNTHyUTP9DK5IQ222OI9i7D4EA8cTw36MT8rjsBtUYb
	 g3ddR1v1McA9zwhZWZ3AqGzMaECEB9X1wa0BnQeAcMJUJmh4bFGEqW9de+F1K7iPRU
	 njUb6IxNARfnWfbjr+e6dQWR9M+0l5nVENqRDxdETxXHXUE1+nwqFIrQawX4vvKR5/
	 wqjc/IXixH8mm57Bb5nsjfEo77kua/i8Dghurz+gcwUest3CutLTcE13xp5PdLrfHi
	 a4xKPdIehWD3Xz7+Ard/sBiumZ1qsv7WrsiGcOxZZ9lGf3ITiQdHvXvItRfsKRtvQ3
	 jtXQn0uHfPf7r2jJ3d2AhSzKDb1o91lhXzaNt4vzMFpHLDHMcN8KAtmNC8dZEJgf8t
	 tJdUrI5QsBGvkoW+ZZWHqjz2NU9cATrCqCIzMzAzEaFDa+Yxi/EH4WNhhFYtgpVFJ0
	 4m0W4NzkDB0KCJTBCxsuPxUmriQXFygco+DZvZl5Vk8Cx/ZjMbDk+MECcnKa47a1AY
	 XXSMhZRHcwaRz0fNk3LNv2hDDvr9nMp6rmG1hCmH4EbTnW2yxLfnaixqnZ0MTrMmHZ
	 8Ig28dff1Z18zR1GwzzwdgsCGVaT/8Jd+wEiqBLKttzQh3dVo/Qnns9nd5KyhtEgfl
	 ZlmkU7NjFgA3pAKx/OvRqL44=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89C8E40E0177;
	Thu,  4 Jan 2024 13:24:51 +0000 (UTC)
Date: Thu, 4 Jan 2024 14:24:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't used at
 runtime
Message-ID: <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
References: <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
 <20231019063527.iwgyioxi2gznnshp@treble>
 <20231019065928.mrvhtfaya22p2uzw@treble>
 <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
 <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
 <20231019152051.4u5xwhopbdisy6zl@treble>
 <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
 <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
 <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>

Thoughts? Complaints?

---
From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Wed, 3 Jan 2024 19:36:26 +0100

Make sure the default return thunk is not used after all return
instructions have been patched by the alternatives because the default
return thunk is insufficient when it comes to mitigating Retbleed or
SRSO.

Fix based on a earlier version by David Kaplan <david.kaplan@amd.com>.

  [ bp: Use the big-fat "NOTICE NOTICE" banner and fix the compilation
    error of warn_thunk_thunk being an invisible symbol. ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231010171020.462211-4-david.kaplan@amd.com
---
 arch/x86/entry/calling.h             | 33 ++++++++++++++++++++++++++++
 arch/x86/entry/entry.S               |  4 ++++
 arch/x86/entry/thunk_64.S            | 33 ----------------------------
 arch/x86/include/asm/nospec-branch.h |  2 ++
 arch/x86/kernel/cpu/bugs.c           | 16 ++++++++++++++
 arch/x86/lib/retpoline.S             | 15 +++++--------
 6 files changed, 61 insertions(+), 42 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index e59d3073e7cf..a4679e8f30ad 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -426,3 +426,36 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 
 #endif /* CONFIG_SMP */
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
index 691ff1ef701b..64b175f03cdb 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -348,6 +348,8 @@ extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
 
+extern void __warn_thunk(void);
+
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 extern void call_depth_return_thunk(void);
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bb0ab8466b91..b96483551299 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2849,3 +2849,19 @@ ssize_t cpu_show_gds(struct device *dev, struct device_attribute *attr, char *bu
 	return cpu_show_common(dev, attr, buf, X86_BUG_GDS);
 }
 #endif
+
+void __warn_thunk(void)
+{
+	pr_warn_once("\n");
+	pr_warn_once("**********************************************************\n");
+	pr_warn_once("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+	pr_warn_once("**                                                      **\n");
+	pr_warn_once("**   Unpatched return thunk in use. This should not     **\n");
+	pr_warn_once("**   happen on a production kernel. Please report this  **\n");
+	pr_warn_once("**   to x86@kernel.org.                                 **\n");
+	pr_warn_once("**                                                      **\n");
+	pr_warn_once("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+	pr_warn_once("**********************************************************\n");
+
+	dump_stack();
+}
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 7b2589877d06..5ed0c22f5351 100644
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
2.42.0.rc0.25.ga82fb66fed25

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

