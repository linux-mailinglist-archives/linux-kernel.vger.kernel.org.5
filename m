Return-Path: <linux-kernel+bounces-15878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 317758234DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FF91F25313
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70E1CA8F;
	Wed,  3 Jan 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c3Sq8IT1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A41C6AB;
	Wed,  3 Jan 2024 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 924E040E01F9;
	Wed,  3 Jan 2024 18:47:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ulIUv-Crr1qd; Wed,  3 Jan 2024 18:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704307630; bh=hz3DFDjsnEXnDSvp22dG+qc7i60h/ulZ5UFnu4SH3Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3Sq8IT1MouyopynoZmgpQkMjLvLg4KCp59EaV77HGfwUZbnHSUrPQOwhfFeaiXwe
	 jFDPAvc2P5MvNmWp1kHL3qebb6M3KwkURwCeZO6cLt9wCKY/4Oc4bZf7wtLcAthuza
	 ksnjqOAG42s1tmbvy63lxG4A/AaSB2jXKLnv/Y7XFyBn+wPmOguZ0gBWHcUreD/5iE
	 GmBWNSr5q2lOYk63vlCxchzL6TOWOOxdX/5+5Hin0J62DlQhRajlW9h0vEA2zl9hbU
	 SchiaGVIZ91FMnQUpnbAMhfCd0WbCV7D3qx8aN9pqofyplu17OmJUpF+fFGqhUOMpU
	 akAb9Z6KGID513KUVL2BXQhK1h8WK6RyhPc0qkzCGaa2nwudMeMNYZOPYiupdT0DWa
	 Gaw+lYdYdSFlTRUvmeySni5zmoPCr8uaW/BaUGMmlVa9OfWVY5nqDgMiB/QdXCiiVE
	 WTQDbhXq6Yh8UMMjcetRFT80AlWHQN+M99Tvgipcgkx22YW7Fafm7w6ppo5QA9vI+e
	 5ETM2xE5p45Ssl+1oQGODO6iEhSLrL4CZR1bWHwzTd/iBKK4r46s+tPwtT5fNOwCbj
	 KFfy/Z7XwDrzTeSTEorqk+pTKQvbcDm0oFgpXw142oeLM6rUUornDWdrNK9VcE+hf3
	 x4PkdkGGElcPVK+LqsAZGM2U=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A88340E01F7;
	Wed,  3 Jan 2024 18:47:02 +0000 (UTC)
Date: Wed, 3 Jan 2024 19:46:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
References: <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
 <20231019063527.iwgyioxi2gznnshp@treble>
 <20231019065928.mrvhtfaya22p2uzw@treble>
 <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
 <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
 <20231019152051.4u5xwhopbdisy6zl@treble>
 <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>

On Tue, Oct 24, 2023 at 10:19:13PM +0200, Borislav Petkov wrote:
> On Thu, Oct 19, 2023 at 08:20:51AM -0700, Josh Poimboeuf wrote:
> > GCC doesn't read asm.  Even if it did that wouldn't fix things for
> > callers of custom-ABI return-thunk-using functions.
> > 
> > The below seems to work.
> 
> Right, I guess we can do something like that. Linker is not happy here
> about that symbol, tho:
> 
> ld: arch/x86/lib/retpoline.o:(.altinstr_replacement+0x95): undefined reference to `warn_thunk_thunk'
> make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
> make[1]: *** [/mnt/kernel/kernel/5th/linux/Makefile:1165: vmlinux] Error 2
> make: *** [Makefile:234: __sub-make] Error 2

Ok, back to playing with this. A fix below along with a beefed up
warning message.

If only I can remember now how we did trigger the warning in the first
place in order to test it...

---

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
index bb0ab8466b91..00a6d024ddf7 100644
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
+	pr_warn_once("**   unpatched return thunk in use. This should not     **\n");
+	pr_warn_once("**   on a production kernel. Please report this to      **\n");
+	pr_warn_once("**   x86@kernel.org.                                    **\n");
+	pr_warn_once("**                                                      **\n");
+	pr_warn_once("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+	pr_warn_once("**********************************************************\n");
+
+	dump_stack();
+}
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 7b2589877d06..dfcb7d64d05a 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -369,19 +369,14 @@ SYM_FUNC_END(call_depth_return_thunk)
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
+ * The RET is replaced with a WARN_ONCE() to ensure it is never used at
+ * runtime.  Alternative instructions are applied after apply_returns().
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

