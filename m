Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D2B7B0F11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjI0WsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjI0WsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:48:07 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B5126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:48:05 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c725aa19eeso27301675ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695854885; x=1696459685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CSH8j6rxC8KfbRVvtZuqLTVmkQvpSCOmXR9/i25FaVY=;
        b=kGQHEavv4aCtzuiFmPY/87hdCCTxaURY59k+Gaw6uArkcYBQpEbQjiujnleGbkfhNK
         g1thMzNmhJ8fpiPReH8/g3XgNRJL8vbJS6nuTs+VoXMc4m6Ly9jFf99NOQH6QLK1b0r5
         DHqPeHrvnEqL4nNDI0KVJyAUL06yAvKd95ntUEqKj0tLRJiK0iq0lFvR2hfKeThiGBKu
         17rtSCTzk3Ods5QfvSJt0vT091UQPUzWefPp8v7fKH+JI+ADhcjeTvVWPiMXvV86m8nf
         24oC+2lhshb2CWb++MMMYkAg/WDnI8zKyERSHqGUo6MRLv8KMC9tEWBGdaMOIGEY65eU
         l8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695854885; x=1696459685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSH8j6rxC8KfbRVvtZuqLTVmkQvpSCOmXR9/i25FaVY=;
        b=TbefT93s9AvQJ9uSegTS8+9L4xWUKWdruSJQaad+LtQejumu4pdB+h3q8Rg45k4E3e
         s6KSB8B5i/lX9S66zS8JVEqq8H4iyegAtdgnYOonGtWm4hSE4ZHLuEVErMoNjXPu+yoi
         ZMK0/SM44uDdf/s9dQ8fcHZNrgwDvH8hMQG254VQiVAMe/lb5YOpb1HSMMOvv4AXOKah
         b6+WIMUSjdVErLcFi22KrvufmMwoVAdXWrXZdtSGrAX8GgfAcXTRZZTTydbU03G/KOQ6
         bMadaQEQJtEepQ8j1h0Hsxo0+gRSYFzT5KC2DY4loeTt2pu3sMEf2lZf8OD6j40JRYlV
         xn2g==
X-Gm-Message-State: AOJu0Yw8uRheMiwETZUnqrJCcHYwCfFHRAh2N6ki+DQxEeTrpDTCuMZ6
        uKITlJduSQxSdVcJrVMX5J9G+zYbC/Li8lwbcVo=
X-Google-Smtp-Source: AGHT+IH7PD7jqQwzq+3UfJE/KtoLpFvk7X9AsLbDucuHHIyGkgvGvHtFfrhSw+uO6TNSsANucKfu5Jctd8fDuJcFxX0=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:e812:b0:1c5:5ca3:a5ff with
 SMTP id u18-20020a170902e81200b001c55ca3a5ffmr40178plg.7.1695854885335; Wed,
 27 Sep 2023 15:48:05 -0700 (PDT)
Date:   Wed, 27 Sep 2023 22:48:00 +0000
In-Reply-To: <20230927224757.1154247-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230927224757.1154247-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=6693; i=samitolvanen@google.com;
 h=from:subject; bh=S1G6SXUek1nxAO4+E1Y770ytvcISKUGnRC45RExsZQA=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBlFLEdLlQn+/m+f+Rv1Ps+71ZLlxyOG0Umtpt0F
 TAPtQdnM/eJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZRSxHQAKCRBMtfaEi7xW
 7g35DACh9uowckTh2GQEknUhXHLoRfrqjfx/Tg5AwtpmVbYHOqemhl12rqv9/7QxBySlJPeVDuz
 eoIHca7ZU2ZbvolXE9Hsd/hxeC1gykiiTt8nv8DXoBviiysUZnjshjIcRx1aQBWyWmD4rRnVFK0
 gI8aJdvizXSFgwTXd2q0DO93bxGfm3qOYjttbcr+33zUD7J/No7kmqjdovARcvPGILmGohBGMac
 agcXDsK7z7fIhQR45QNGDFctpC967S5kcuomQRELrUXKYqSt5AtMeZpzkz4vlZFwcdJubVg7HTv
 TNBjBNW6yWDxZ14qSMhdOs3UqXB29Sx7HgsYFd1j+C96Ixq9Ott1cu3M4W2/z/QWPLsvwa0g2DV
 DA1PumQjHIC5M9Z4wKVUHxnxGVcYcDvZRgD4V2jnk1Zn94kDan3tK4bzd4w3E6qFOSEj/N2qXXX vWXz9AJMC6z9Tsn/BD3mSfBfc63N917W3vV1y+j52PRWhM7gbD3krWtu8IID5CgnoPyow=
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927224757.1154247-10-samitolvanen@google.com>
Subject: [PATCH v4 2/6] riscv: Deduplicate IRQ stack switching
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Clement Leger <cleger@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_IRQ_STACKS, we switch to a separate per-CPU IRQ stack
before calling handle_riscv_irq or __do_softirq. We currently
have duplicate inline assembly snippets for stack switching in
both code paths. Now that we can access per-CPU variables in
assembly, implement call_on_irq_stack in assembly, and use that
instead of redundant inline assembly.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/asm.h       |  5 +++++
 arch/riscv/include/asm/irq_stack.h |  3 +++
 arch/riscv/kernel/asm-offsets.c    |  5 +++++
 arch/riscv/kernel/entry.S          | 30 +++++++++++++++++++++++++
 arch/riscv/kernel/irq.c            | 35 +++++++-----------------------
 arch/riscv/kernel/traps.c          | 32 ++++-----------------------
 6 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index bfb4c26f113c..8e446be2d57c 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -104,6 +104,11 @@
 .endm
 #endif /* CONFIG_SMP */
 
+.macro load_per_cpu dst ptr tmp
+	asm_per_cpu \dst \ptr \tmp
+	REG_L \dst, 0(\dst)
+.endm
+
 	/* save all GPs except x1 ~ x5 */
 	.macro save_from_x6_to_x31
 	REG_S x6,  PT_T1(sp)
diff --git a/arch/riscv/include/asm/irq_stack.h b/arch/riscv/include/asm/irq_stack.h
index e4042d297580..6441ded3b0cf 100644
--- a/arch/riscv/include/asm/irq_stack.h
+++ b/arch/riscv/include/asm/irq_stack.h
@@ -12,6 +12,9 @@
 
 DECLARE_PER_CPU(ulong *, irq_stack_ptr);
 
+asmlinkage void call_on_irq_stack(struct pt_regs *regs,
+				  void (*func)(struct pt_regs *));
+
 #ifdef CONFIG_VMAP_STACK
 /*
  * To ensure that VMAP'd stack overflow detection works correctly, all VMAP'd
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 9f535d5de33f..0af8860f9d68 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -14,6 +14,7 @@
 #include <asm/thread_info.h>
 #include <asm/ptrace.h>
 #include <asm/cpu_ops_sbi.h>
+#include <asm/stacktrace.h>
 #include <asm/suspend.h>
 
 void asm_offsets(void);
@@ -480,4 +481,8 @@ void asm_offsets(void)
 	OFFSET(KERNEL_MAP_VIRT_ADDR, kernel_mapping, virt_addr);
 	OFFSET(SBI_HART_BOOT_TASK_PTR_OFFSET, sbi_hart_boot_data, task_ptr);
 	OFFSET(SBI_HART_BOOT_STACK_PTR_OFFSET, sbi_hart_boot_data, stack_ptr);
+
+	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
+	OFFSET(STACKFRAME_FP, stackframe, fp);
+	OFFSET(STACKFRAME_RA, stackframe, ra);
 }
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 3d11aa3af105..a306562636e4 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -218,6 +218,36 @@ SYM_CODE_START(ret_from_fork)
 	tail syscall_exit_to_user_mode
 SYM_CODE_END(ret_from_fork)
 
+#ifdef CONFIG_IRQ_STACKS
+/*
+ * void call_on_irq_stack(struct pt_regs *regs,
+ * 		          void (*func)(struct pt_regs *));
+ *
+ * Calls func(regs) using the per-CPU IRQ stack.
+ */
+SYM_FUNC_START(call_on_irq_stack)
+	/* Create a frame record to save ra and s0 (fp) */
+	addi	sp, sp, -STACKFRAME_SIZE_ON_STACK
+	REG_S	ra, STACKFRAME_RA(sp)
+	REG_S	s0, STACKFRAME_FP(sp)
+	addi	s0, sp, STACKFRAME_SIZE_ON_STACK
+
+	/* Switch to the per-CPU IRQ stack and call the handler */
+	load_per_cpu t0, irq_stack_ptr, t1
+	li	t1, IRQ_STACK_SIZE
+	add	sp, t0, t1
+	jalr	a1
+
+	/* Switch back to the thread stack and restore ra and s0 */
+	addi	sp, s0, -STACKFRAME_SIZE_ON_STACK
+	REG_L	ra, STACKFRAME_RA(sp)
+	REG_L	s0, STACKFRAME_FP(sp)
+	addi	sp, sp, STACKFRAME_SIZE_ON_STACK
+
+	ret
+SYM_FUNC_END(call_on_irq_stack)
+#endif /* CONFIG_IRQ_STACKS */
+
 /*
  * Integer register context switch
  * The callee-saved registers must be saved and restored.
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index a8efa053c4a5..95dafdcbd135 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -61,35 +61,16 @@ static void init_irq_stacks(void)
 #endif /* CONFIG_VMAP_STACK */
 
 #ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
+static void ___do_softirq(struct pt_regs *regs)
+{
+	__do_softirq();
+}
+
 void do_softirq_own_stack(void)
 {
-#ifdef CONFIG_IRQ_STACKS
-	if (on_thread_stack()) {
-		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id())
-					+ IRQ_STACK_SIZE/sizeof(ulong);
-		__asm__ __volatile(
-		"addi	sp, sp, -"RISCV_SZPTR  "\n"
-		REG_S"  ra, (sp)		\n"
-		"addi	sp, sp, -"RISCV_SZPTR  "\n"
-		REG_S"  s0, (sp)		\n"
-		"addi	s0, sp, 2*"RISCV_SZPTR "\n"
-		"move	sp, %[sp]		\n"
-		"call	__do_softirq		\n"
-		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
-		REG_L"  s0, (sp)		\n"
-		"addi	sp, sp, "RISCV_SZPTR   "\n"
-		REG_L"  ra, (sp)		\n"
-		"addi	sp, sp, "RISCV_SZPTR   "\n"
-		:
-		: [sp] "r" (sp)
-		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
-#ifndef CONFIG_FRAME_POINTER
-		  "s0",
-#endif
-		  "memory");
-	} else
-#endif
+	if (on_thread_stack())
+		call_on_irq_stack(NULL, ___do_softirq);
+	else
 		__do_softirq();
 }
 #endif /* CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK */
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 0063a195deca..cda6dcdb0376 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -352,34 +352,10 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
 asmlinkage void noinstr do_irq(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
-#ifdef CONFIG_IRQ_STACKS
-	if (on_thread_stack()) {
-		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id())
-					+ IRQ_STACK_SIZE/sizeof(ulong);
-		__asm__ __volatile(
-		"addi	sp, sp, -"RISCV_SZPTR  "\n"
-		REG_S"  ra, (sp)		\n"
-		"addi	sp, sp, -"RISCV_SZPTR  "\n"
-		REG_S"  s0, (sp)		\n"
-		"addi	s0, sp, 2*"RISCV_SZPTR "\n"
-		"move	sp, %[sp]		\n"
-		"move	a0, %[regs]		\n"
-		"call	handle_riscv_irq	\n"
-		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
-		REG_L"  s0, (sp)		\n"
-		"addi	sp, sp, "RISCV_SZPTR   "\n"
-		REG_L"  ra, (sp)		\n"
-		"addi	sp, sp, "RISCV_SZPTR   "\n"
-		:
-		: [sp] "r" (sp), [regs] "r" (regs)
-		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
-#ifndef CONFIG_FRAME_POINTER
-		  "s0",
-#endif
-		  "memory");
-	} else
-#endif
+
+	if (IS_ENABLED(CONFIG_IRQ_STACKS) && on_thread_stack())
+		call_on_irq_stack(regs, handle_riscv_irq);
+	else
 		handle_riscv_irq(regs);
 
 	irqentry_exit(regs, state);
-- 
2.42.0.515.g380fc7ccd1-goog

