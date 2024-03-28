Return-Path: <linux-kernel+bounces-123052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D266989017D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A912294CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404784D1C;
	Thu, 28 Mar 2024 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDRrODgz"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551380C11;
	Thu, 28 Mar 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635543; cv=none; b=G86pAPeLy3KmSBPJyILSzCFq2q4LTuPkhz5pFjiqLpxWEVZrfxZ1giBNZ9A09uj3sBVF7F2yC67TZzgd+TXoI4EWYR5Gyb9X7vUCjoBSypM/h98Y+6DDEizq/Reo3OVFCp8qZNqjTGLg2GUUMAtKYXViLPD0B0pMqEKvhwaU+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635543; c=relaxed/simple;
	bh=ae0LXafyIZm0Th2BdudLAqF7ZyQZN+tWFlGqYrSW/18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z9SqD4NfWhJ3kyVQLaC2iPUwxIPs0F0IhRwmWGt8+7xpZVLnfP8MY9R6yKgenR6TaB/koGddIOs68QN+TAFnq9i2X3MwcD/thSS9ot+6WCQsH8mCqx10L7UzaLgoHoZHxmyuQ3roIYOpOrRNsGBG4CxLKoyY9Ami0TJZgQBFRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDRrODgz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41544650225so5068655e9.2;
        Thu, 28 Mar 2024 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711635540; x=1712240340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIVFwe4drmR7NpVMkZne2fOWlDQSED4Lnm/WcZI6CvA=;
        b=JDRrODgzgjg+0dtkQtcn/x6qzPU6CEXPHcoXjCzElDuU8+Iy8bv5ixB/Y+fjhd74PO
         CEWi+Dbxs6NwKBeFcXXMe/91T2A6VUsfRgFy71rDMVF8kvrnoO5+IK4Wcw4HYbglha8C
         P+A7pRHG1JX/NzDX14WwPSZ62cOzsn2EGQAfVGVqiCi3Relj7DUsWBZNzK6Pn/0pmkBF
         xf4NTLZmkj2r3p/ZpisI4/P8QlkIMT001N9wCFG1CzTYYhge8bwITYWmvmwp22diSUC1
         1rQAOanyrrhZ5oTd60/8c1jxZAw6WUX2PkmOKyXsudnu9nRLzpLhkxqh80k7C0RylCzf
         UuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635540; x=1712240340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIVFwe4drmR7NpVMkZne2fOWlDQSED4Lnm/WcZI6CvA=;
        b=enf8qOGCN6mC74PLNpmLlgA2AUVMPMwB12KderMIw5jHUGG+AGWMbAQG0vceg6ZMD/
         itzDm5gWa0o0e6HPvQsSsbGD079LBeU6Rks4sNJBMbNSG0C6QDaS7T88NVC48V67m9g3
         t4kPdhg6tpRobQfASnh1EonExsNDiWvaDkIvGsDbSUooDbUuJoUyPIowOSdwSt3F5s94
         dh+TEYhwiFR2SQym7UCqwiYSb3lPd05Z/Rakhv2VzjsEeQIRbHkYy5CE9gNhTOYiTZQ9
         JQS1O7yJU3lnUyKmkyQw/reW5guUqEJPy1CaRsm4C03cSr6s8mH07qCORzAUe5kK2jiY
         cCBg==
X-Forwarded-Encrypted: i=1; AJvYcCWSD0Gq1UPNTKhCOqegfEv0nnLR95ALroM8aRXB4JYFOD2jtnzQ87S0TxFwYhcXCLvsvCHwHt4ANaWMu1uzoZi3GsqXd/38jygyZ1t1yNx/WLYk2sDN0MVFs/ljFLFlU4Uughuk1WMpHC1eP2VBNoHy
X-Gm-Message-State: AOJu0Yx4eInWpOrpAPgZBoKRqoaeyCOS3iRGv9/dVBjM8oVUSYmBl4mI
	cVb4CShxjjSTqaALwvKw25ifgAqHAD+e61XGYXy84ggkAhCxn/ge
X-Google-Smtp-Source: AGHT+IGYZ4Qeg8sWs6IcbwollLNesIfKfarZj4RrcR1wKFN253KNF2e5EWMRlh/DTni728fzw+/JVQ==
X-Received: by 2002:a05:600c:28c:b0:414:6c34:9ba0 with SMTP id 12-20020a05600c028c00b004146c349ba0mr1817517wmk.16.1711635539584;
        Thu, 28 Mar 2024 07:18:59 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id je14-20020a05600c1f8e00b00414887d9329sm2424140wmb.46.2024.03.28.07.18.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:18:59 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Guo Ren <guoren@kernel.org>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Song Shuai <suagrfillet@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [RFC PATCH] ftrace: riscv: move from REGS to ARGS
Date: Thu, 28 Mar 2024 14:18:45 +0000
Message-Id: <20240328141845.128645-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit replaces riscv's support for FTRACE_WITH_REGS with support
for FTRACE_WITH_ARGS. This is required for the ongoing effort to stop
relying on stop_machine() for RISCV's implementation of ftrace.

The main relevant benefit that this change will bring for the above
use-case is that now we don't have separate ftrace_caller and
ftrace_regs_caller trampolines.  This will allow the callsite to call
ftrace_caller by modifying a single instruction. Now the callsite can
do something similar to:

When not tracing:            |             When tracing:

func:                                      func:
  auipc t0, ftrace_caller_top                auipc t0, ftrace_caller_top
  nop  <=========<Enable/Disable>=========>  jalr  t0, ftrace_caller_bottom
  [...]                                      [...]

The above assumes that we are dropping the support of calling a direct
trampoline from the callsite. We need to drop this as the callsite can't
change the target address to call, it can only enable/disable a call to
a preset target (ftrace_caller in the above diagram).

Currently, ftrace_regs_caller saves all CPU registers in the format of
struct pt_regs and allows the tracer to modify them. We don't need to
save all of the CPU registers because at function entry only a subset of
pt_regs is live:

|----------+----------+---------------------------------------------|
| Register | ABI Name | Description                                 |
|----------+----------+---------------------------------------------|
| x1       | ra       | Return address for traced function          |
| x2       | sp       | Stack pointer                               |
| x5       | t0       | Return address for ftrace_caller trampoline |
| x8       | s0/fp    | Frame pointer                               |
| x10-11   | a0-1     | Function arguments/return values            |
| x12-17   | a2-7     | Function arguments                          |
|----------+----------+---------------------------------------------|

See RISCV calling convention[1] for the above table.

Saving just the live registers decreases the amount of stack space
required from 288 Bytes to 112 Bytes.

Basic testing was done with this on the VisionFive 2 development board.

Note:
  - Moving from REGS to ARGS will mean that RISCV will stop supporting
    KPROBES_ON_FTRACE as it requires full pt_regs to be saved.

[1] https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/Kconfig              |   2 +-
 arch/riscv/include/asm/ftrace.h |  81 +++++++++++++--
 arch/riscv/kernel/asm-offsets.c |  18 ++++
 arch/riscv/kernel/ftrace.c      |  18 +---
 arch/riscv/kernel/mcount-dyn.S  | 171 ++++++++++----------------------
 include/linux/ftrace.h          |   3 +-
 6 files changed, 150 insertions(+), 143 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..da637fde2137 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -126,7 +126,7 @@ config RISCV
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_ARGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 1276d7d9ca8b..1e95bf4ded6c 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -124,20 +124,87 @@ struct dyn_ftrace;
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+#define arch_ftrace_get_regs(regs) NULL
 struct ftrace_ops;
-struct ftrace_regs;
+struct ftrace_regs {
+	unsigned long epc;
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long s0;
+	unsigned long t1;
+	union {
+		unsigned long args[8];
+		struct {
+			unsigned long a0;
+			unsigned long a1;
+			unsigned long a2;
+			unsigned long a3;
+			unsigned long a4;
+			unsigned long a5;
+			unsigned long a6;
+			unsigned long a7;
+		};
+	};
+};
+
+static __always_inline unsigned long
+ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
+{
+	return fregs->epc;
+}
+
+static __always_inline void
+ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
+				    unsigned long pc)
+{
+	fregs->epc = pc;
+}
+
+static __always_inline unsigned long
+ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
+{
+	return fregs->sp;
+}
+
+static __always_inline unsigned long
+ftrace_regs_get_argument(struct ftrace_regs *fregs, unsigned int n)
+{
+	if (n < 8)
+		return fregs->args[n];
+	return 0;
+}
+
+static __always_inline unsigned long
+ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
+{
+	return fregs->a0;
+}
+
+static __always_inline void
+ftrace_regs_set_return_value(struct ftrace_regs *fregs,
+			     unsigned long ret)
+{
+	fregs->a0 = ret;
+}
+
+static __always_inline void
+ftrace_override_function_with_return(struct ftrace_regs *fregs)
+{
+	fregs->epc = fregs->ra;
+}
+
+int ftrace_regs_query_register_offset(const char *name);
+
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #define ftrace_graph_func ftrace_graph_func
 
-static inline void __arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
 {
-		regs->t1 = addr;
+	fregs->t1 = addr;
 }
-#define arch_ftrace_set_direct_caller(fregs, addr) \
-	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index a03129f40c46..b09ca5f944f7 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -9,6 +9,7 @@
 #include <linux/kbuild.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/ftrace.h>
 #include <linux/suspend.h>
 #include <asm/kvm_host.h>
 #include <asm/thread_info.h>
@@ -488,4 +489,21 @@ void asm_offsets(void)
 	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
 	OFFSET(STACKFRAME_FP, stackframe, fp);
 	OFFSET(STACKFRAME_RA, stackframe, ra);
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+	DEFINE(FREGS_SIZE_ON_STACK, ALIGN(sizeof(struct ftrace_regs), STACK_ALIGN));
+	DEFINE(FREGS_EPC,	    offsetof(struct ftrace_regs, epc));
+	DEFINE(FREGS_RA,	    offsetof(struct ftrace_regs, ra));
+	DEFINE(FREGS_SP,	    offsetof(struct ftrace_regs, sp));
+	DEFINE(FREGS_S0,	    offsetof(struct ftrace_regs, s0));
+	DEFINE(FREGS_T1,	    offsetof(struct ftrace_regs, t1));
+	DEFINE(FREGS_A0,	    offsetof(struct ftrace_regs, a0));
+	DEFINE(FREGS_A1,	    offsetof(struct ftrace_regs, a1));
+	DEFINE(FREGS_A2,	    offsetof(struct ftrace_regs, a2));
+	DEFINE(FREGS_A3,	    offsetof(struct ftrace_regs, a3));
+	DEFINE(FREGS_A4,	    offsetof(struct ftrace_regs, a4));
+	DEFINE(FREGS_A5,	    offsetof(struct ftrace_regs, a5));
+	DEFINE(FREGS_A6,	    offsetof(struct ftrace_regs, a6));
+	DEFINE(FREGS_A7,	    offsetof(struct ftrace_regs, a7));
+#endif
 }
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index f5aa24d9e1c1..cd144b0c3008 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -127,16 +127,11 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 {
 	int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
 				       (unsigned long)func, true, true);
-	if (!ret) {
-		ret = __ftrace_modify_call((unsigned long)&ftrace_regs_call,
-					   (unsigned long)func, true, true);
-	}
-
 	return ret;
 }
 #endif
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
@@ -178,16 +173,13 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
-	unsigned long *parent = (unsigned long *)&regs->ra;
-
-	prepare_ftrace_return(parent, ip, frame_pointer(regs));
+	prepare_ftrace_return(&fregs->ra, ip, fregs->s0);
 }
-#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 extern void ftrace_graph_call(void);
 int ftrace_enable_ftrace_graph_caller(void)
 {
@@ -200,6 +192,6 @@ int ftrace_disable_ftrace_graph_caller(void)
 	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, false, true);
 }
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index b7561288e8da..745dd4c4a69c 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -56,138 +56,77 @@
 	addi	sp, sp, ABI_SIZE_ON_STACK
 	.endm
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 
 /**
-* SAVE_ABI_REGS - save regs against the pt_regs struct
-*
-* @all: tell if saving all the regs
-*
-* If all is set, all the regs will be saved, otherwise only ABI
-* related regs (a0-a7,epc,ra and optional s0) will be saved.
+* SAVE_ABI_REGS - save regs against the ftrace_regs struct
 *
 * After the stack is established,
 *
 * 0(sp) stores the PC of the traced function which can be accessed
-* by &(fregs)->regs->epc in tracing function. Note that the real
+* by &(fregs)->epc in tracing function. Note that the real
 * function entry address should be computed with -FENTRY_RA_OFFSET.
 *
 * 8(sp) stores the function return address (i.e. parent IP) that
-* can be accessed by &(fregs)->regs->ra in tracing function.
+* can be accessed by &(fregs)->ra in tracing function.
 *
 * The other regs are saved at the respective localtion and accessed
-* by the respective pt_regs member.
+* by the respective ftrace_regs member.
 *
 * Here is the layout of stack for your reference.
 *
 * PT_SIZE_ON_STACK  ->  +++++++++
 *                       + ..... +
-*                       + t3-t6 +
-*                       + s2-s11+
 *                       + a0-a7 + --++++-> ftrace_caller saved
-*                       + s1    +   +
-*                       + s0    + --+
-*                       + t0-t2 +   +
-*                       + tp    +   +
-*                       + gp    +   +
+*                       + t1    + --++++-> direct tramp address
+*                       + s0    + --+ // frame pointer
 *                       + sp    +   +
 *                       + ra    + --+ // parent IP
 *               sp  ->  + epc   + --+ // PC
 *                       +++++++++
 **/
-	.macro SAVE_ABI_REGS, all=0
-	addi	sp, sp, -PT_SIZE_ON_STACK
-
-	REG_S	t0,  PT_EPC(sp)
-	REG_S	x1,  PT_RA(sp)
-
-	// save the ABI regs
-
-	REG_S	x10, PT_A0(sp)
-	REG_S	x11, PT_A1(sp)
-	REG_S	x12, PT_A2(sp)
-	REG_S	x13, PT_A3(sp)
-	REG_S	x14, PT_A4(sp)
-	REG_S	x15, PT_A5(sp)
-	REG_S	x16, PT_A6(sp)
-	REG_S	x17, PT_A7(sp)
-
-	// save the leftover regs
+	.macro SAVE_ABI_REGS
+	mv	t4, sp			// Save original SP in T4
+	addi	sp, sp, -FREGS_SIZE_ON_STACK
 
-	.if \all == 1
-	REG_S	x2, PT_SP(sp)
-	REG_S	x3, PT_GP(sp)
-	REG_S	x4, PT_TP(sp)
-	REG_S	x5, PT_T0(sp)
-	REG_S	x6, PT_T1(sp)
-	REG_S	x7, PT_T2(sp)
-	REG_S	x8, PT_S0(sp)
-	REG_S	x9, PT_S1(sp)
-	REG_S	x18, PT_S2(sp)
-	REG_S	x19, PT_S3(sp)
-	REG_S	x20, PT_S4(sp)
-	REG_S	x21, PT_S5(sp)
-	REG_S	x22, PT_S6(sp)
-	REG_S	x23, PT_S7(sp)
-	REG_S	x24, PT_S8(sp)
-	REG_S	x25, PT_S9(sp)
-	REG_S	x26, PT_S10(sp)
-	REG_S	x27, PT_S11(sp)
-	REG_S	x28, PT_T3(sp)
-	REG_S	x29, PT_T4(sp)
-	REG_S	x30, PT_T5(sp)
-	REG_S	x31, PT_T6(sp)
-
-	// save s0 if FP_TEST defined
-
-	.else
+	REG_S	t0,  FREGS_EPC(sp)
+	REG_S	x1,  FREGS_RA(sp)
+	REG_S	t4,  FREGS_SP(sp)	// Put original SP on stack
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	REG_S	x8, PT_S0(sp)
+	REG_S	x8,  FREGS_S0(sp)
 #endif
-	.endif
+	REG_S	x6,  FREGS_T1(sp)
+
+	// save the arguments
+	REG_S	x10, FREGS_A0(sp)
+	REG_S	x11, FREGS_A1(sp)
+	REG_S	x12, FREGS_A2(sp)
+	REG_S	x13, FREGS_A3(sp)
+	REG_S	x14, FREGS_A4(sp)
+	REG_S	x15, FREGS_A5(sp)
+	REG_S	x16, FREGS_A6(sp)
+	REG_S	x17, FREGS_A7(sp)
 	.endm
 
 	.macro RESTORE_ABI_REGS, all=0
-	REG_L	t0, PT_EPC(sp)
-	REG_L	x1, PT_RA(sp)
-	REG_L	x10, PT_A0(sp)
-	REG_L	x11, PT_A1(sp)
-	REG_L	x12, PT_A2(sp)
-	REG_L	x13, PT_A3(sp)
-	REG_L	x14, PT_A4(sp)
-	REG_L	x15, PT_A5(sp)
-	REG_L	x16, PT_A6(sp)
-	REG_L	x17, PT_A7(sp)
-
-	.if \all == 1
-	REG_L	x2, PT_SP(sp)
-	REG_L	x3, PT_GP(sp)
-	REG_L	x4, PT_TP(sp)
-	REG_L	x6, PT_T1(sp)
-	REG_L	x7, PT_T2(sp)
-	REG_L	x8, PT_S0(sp)
-	REG_L	x9, PT_S1(sp)
-	REG_L	x18, PT_S2(sp)
-	REG_L	x19, PT_S3(sp)
-	REG_L	x20, PT_S4(sp)
-	REG_L	x21, PT_S5(sp)
-	REG_L	x22, PT_S6(sp)
-	REG_L	x23, PT_S7(sp)
-	REG_L	x24, PT_S8(sp)
-	REG_L	x25, PT_S9(sp)
-	REG_L	x26, PT_S10(sp)
-	REG_L	x27, PT_S11(sp)
-	REG_L	x28, PT_T3(sp)
-	REG_L	x29, PT_T4(sp)
-	REG_L	x30, PT_T5(sp)
-	REG_L	x31, PT_T6(sp)
-
-	.else
+	REG_L	t0, FREGS_EPC(sp)
+	REG_L	x1, FREGS_RA(sp)
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	REG_L	x8, PT_S0(sp)
+	REG_L	x8, FREGS_S0(sp)
 #endif
-	.endif
-	addi	sp, sp, PT_SIZE_ON_STACK
+	REG_L	x6,  FREGS_T1(sp)
+
+	// restore the arguments
+	REG_L	x10, FREGS_A0(sp)
+	REG_L	x11, FREGS_A1(sp)
+	REG_L	x12, FREGS_A2(sp)
+	REG_L	x13, FREGS_A3(sp)
+	REG_L	x14, FREGS_A4(sp)
+	REG_L	x15, FREGS_A5(sp)
+	REG_L	x16, FREGS_A6(sp)
+	REG_L	x17, FREGS_A7(sp)
+
+	addi	sp, sp, FREGS_SIZE_ON_STACK
 	.endm
 
 	.macro PREPARE_ARGS
@@ -198,9 +137,9 @@
 	mv	a3, sp
 	.endm
 
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
-#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 SYM_FUNC_START(ftrace_caller)
 	SAVE_ABI
 
@@ -227,33 +166,23 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 	jr	t0
 SYM_FUNC_END(ftrace_caller)
 
-#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
-SYM_FUNC_START(ftrace_regs_caller)
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
+SYM_FUNC_START(ftrace_caller)
 	mv	t1, zero
-	SAVE_ABI_REGS 1
+	SAVE_ABI_REGS
 	PREPARE_ARGS
 
-SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
+SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	call	ftrace_stub
 
-	RESTORE_ABI_REGS 1
+	RESTORE_ABI_REGS
 	bnez	t1, .Ldirect
 	jr	t0
 .Ldirect:
 	jr	t1
-SYM_FUNC_END(ftrace_regs_caller)
-
-SYM_FUNC_START(ftrace_caller)
-	SAVE_ABI_REGS 0
-	PREPARE_ARGS
-
-SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
-	call	ftrace_stub
-
-	RESTORE_ABI_REGS 0
-	jr	t0
 SYM_FUNC_END(ftrace_caller)
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 SYM_CODE_START(ftrace_stub_direct_tramp)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 54d53f345d14..1272264d2e9e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -822,7 +822,8 @@ static inline int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 extern int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr);
 
 #if defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) || \
-	defined(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS)
+	defined(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS) || \
+	defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS)
 /**
  * ftrace_modify_call - convert from one addr to another (no nop)
  * @rec: the call site record (e.g. mcount/fentry)
-- 
2.40.1


