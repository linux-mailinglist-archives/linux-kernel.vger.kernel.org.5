Return-Path: <linux-kernel+bounces-21944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170E18296F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CC1B26301
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F46405C1;
	Wed, 10 Jan 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzTtdHuX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q28UW1ZF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883A3FB02;
	Wed, 10 Jan 2024 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jan 2024 10:09:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704881391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kt/9TKxvSxFDgZm31Oj/hdzcq5RIMSt0HWaUTe9MWY4=;
	b=kzTtdHuXqU36bH6Q0KX7PTki8gp0SHLZhLHLs1lKpuSxltRNDkhqZaJ0ehaMPPEJtQEAl8
	Zs8SZKOM3i48HWnkVMq5tpkxeZXkwwCi2kLQ7n3ixVf950Qv+O67a6813ELBxXhQ6h0AAw
	jZ7FfXmK//y1hPDR9lkZpSlHziKYSMG/YqVlVZvHCAtWfjRXZbVzzfiATkmmu7fbdzTS4O
	Y/DOKZ/+5wd0JWR48LfCa8CZWo1Rws1Cj55d0ZIwRmZoGiRXngNquamfExMuyQmI+nL/ud
	K1BcmLlDxz02/4WRY0cQB+DWgV2g795M6G9a3QwZg5M1n2r53Hs1qD6QWrRuDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704881391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kt/9TKxvSxFDgZm31Oj/hdzcq5RIMSt0HWaUTe9MWY4=;
	b=q28UW1ZFLhcYHkkjVjeOPgVLxnt51VybXKVa9YgXyCLc0qcr+R2fhFBP5WAIZw7jOelhk1
	zX71r8h+YAPUgzAQ==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Rename CONFIG_SLS => CONFIG_MITIGATION_SLS
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121160740.1249350-7-leitao@debian.org>
References: <20231121160740.1249350-7-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170488139109.398.14392416950988911381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     7b75782ffd8243288d0661750b2dcc2596d676cb
Gitweb:        https://git.kernel.org/tip/7b75782ffd8243288d0661750b2dcc2596d676cb
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 21 Nov 2023 08:07:33 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Jan 2024 10:52:28 +01:00

x86/bugs: Rename CONFIG_SLS                  => CONFIG_MITIGATION_SLS

Step 6/10 of the namespace unification of CPU mitigations related Kconfig options.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231121160740.1249350-7-leitao@debian.org
---
 arch/x86/Kconfig               | 2 +-
 arch/x86/Makefile              | 2 +-
 arch/x86/include/asm/linkage.h | 4 ++--
 arch/x86/kernel/alternative.c  | 4 ++--
 arch/x86/kernel/ftrace.c       | 3 ++-
 arch/x86/net/bpf_jit_comp.c    | 4 ++--
 scripts/Makefile.lib           | 2 +-
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2a3ebd6..ba45465 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2577,7 +2577,7 @@ config CPU_SRSO
 	help
 	  Enable the SRSO mitigation needed on AMD Zen1-4 machines.
 
-config SLS
+config MITIGATION_SLS
 	bool "Mitigate Straight-Line-Speculation"
 	depends on CC_HAS_SLS && X86_64
 	select OBJTOOL if HAVE_OBJTOOL
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b8d23ed..5ce8c30 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -205,7 +205,7 @@ ifdef CONFIG_MITIGATION_RETPOLINE
   endif
 endif
 
-ifdef CONFIG_SLS
+ifdef CONFIG_MITIGATION_SLS
   KBUILD_CFLAGS += -mharden-sls=all
 endif
 
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index c516520..09e2d02 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -43,7 +43,7 @@
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
 #else /* CONFIG_MITIGATION_RETPOLINE */
-#ifdef CONFIG_SLS
+#ifdef CONFIG_MITIGATION_SLS
 #define RET	ret; int3
 #else
 #define RET	ret
@@ -55,7 +55,7 @@
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define ASM_RET	"jmp __x86_return_thunk\n\t"
 #else /* CONFIG_MITIGATION_RETPOLINE */
-#ifdef CONFIG_SLS
+#ifdef CONFIG_MITIGATION_SLS
 #define ASM_RET	"ret; int3\n\t"
 #else
 #define ASM_RET	"ret\n\t"
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 08c182f..f5442d0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -708,8 +708,8 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	/*
 	 * The compiler is supposed to EMIT an INT3 after every unconditional
 	 * JMP instruction due to AMD BTC. However, if the compiler is too old
-	 * or SLS isn't enabled, we still need an INT3 after indirect JMPs
-	 * even on Intel.
+	 * or MITIGATION_SLS isn't enabled, we still need an INT3 after
+	 * indirect JMPs even on Intel.
 	 */
 	if (op == JMP32_INSN_OPCODE && i < insn->length)
 		bytes[i++] = INT3_INSN_OPCODE;
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 93bc52d..70139d9 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -307,7 +307,8 @@ union ftrace_op_code_union {
 	} __attribute__((packed));
 };
 
-#define RET_SIZE	(IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) ? 5 : 1 + IS_ENABLED(CONFIG_SLS))
+#define RET_SIZE \
+	(IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) ? 5 : 1 + IS_ENABLED(CONFIG_MITIGATION_SLS))
 
 static unsigned long
 create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ad1396b..63b7aa4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -469,7 +469,7 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 			emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
 	} else {
 		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
-		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_SLS))
+		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_MITIGATION_SLS))
 			EMIT1(0xCC);		/* int3 */
 	}
 
@@ -484,7 +484,7 @@ static void emit_return(u8 **pprog, u8 *ip)
 		emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */
-		if (IS_ENABLED(CONFIG_SLS))
+		if (IS_ENABLED(CONFIG_MITIGATION_SLS))
 			EMIT1(0xCC);	/* int3 */
 	}
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 615f261..b272ca6 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -264,7 +264,7 @@ endif
 objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
 objtool-args-$(CONFIG_MITIGATION_RETPOLINE)		+= --retpoline
 objtool-args-$(CONFIG_RETHUNK)				+= --rethunk
-objtool-args-$(CONFIG_SLS)				+= --sls
+objtool-args-$(CONFIG_MITIGATION_SLS)			+= --sls
 objtool-args-$(CONFIG_STACK_VALIDATION)			+= --stackval
 objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess

