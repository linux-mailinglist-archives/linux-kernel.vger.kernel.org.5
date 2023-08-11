Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D190B779B65
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbjHKXgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbjHKXgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:36:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA29D10E6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:36:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1d9814b89fso2526364276.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691796964; x=1692401764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=00MDTkG4twmkTIj7hahtsfZCe3BOd3kJWcjxWEDZHsc=;
        b=hNk/V5V9Cl0RBDK/xApOCjB9hBugkkuVSUe0CaeEJvfxUWOY/dHs5BlzQK0Ht8K4GW
         wz4FNlEdTQbu49jXP5WDdQc5jl3P8kYStgDJp1EcsRF0QdkshXrIub2xylJHtkojk4ne
         JShRPYJ8B6jOJlbiGmGCSfFSWOsj0WF/PLyolSwVOkDevRJrdhjhTjMhtDy5vO90G201
         BIsKD+9tYPjZm8FB3dSatCzIyzW2fFKtOhxoCYTY/u6aLh+wHQ07/9w4+qNAMfEp2iEg
         XPjLPfnAf3gGHWk9mdXr635RhY2oJpJnb8Al7Qq+/hRH3xOIMkEcrstW5KQCxtb2FE+i
         EG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796964; x=1692401764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00MDTkG4twmkTIj7hahtsfZCe3BOd3kJWcjxWEDZHsc=;
        b=Dpj9taDn5aoUZCkGG6O/DShdyvpuhApur94u5x08Q/8u+WIfUZ58GkM+p6IBvggips
         X7W/GqYc6Jmn41qsr7IbYKyaJsEV0/TNMKceSmPDUWsVfgBp/wmC+Yx8NGJHlNdK/92r
         hnOe7IDo2XSegndi6HpHpEcyQmZ8A3EcEwgR8VgENu+Kq4NnoSRdmU+sNTBThcl1p5Bz
         yqavAwBjETjP9LX8jipOc57P5lIzi9K4fiUv82Y9hRBUhlOX0vyFFdubkfL5XaOxgABC
         aXXS8n/yWBCt4PISkcJMS7JswoXzqaUszaxlWdZ8PavqfrSjRYSWxFK9rWaZp/+OQJBr
         L+Ww==
X-Gm-Message-State: AOJu0Yw+VSQI11+eLf5uAwHLWpVQWhuZIBr3BOsImRstOMEevB5jvBgz
        DyrzOh4BB9kK7ow7ypOgNShWC+IXO8JlYLIwXCw=
X-Google-Smtp-Source: AGHT+IHeXZ1GvUHF8fQxxXYXGJIgPf+CIJhhtBADyb3Qi5fzWeoLDsuAKhTKM89XtClgD4ndzhOFK9PQ7mjh0lJHrlE=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:2d0d:0:b0:d4f:638b:d7fd with SMTP
 id t13-20020a252d0d000000b00d4f638bd7fdmr52997ybt.9.1691796964113; Fri, 11
 Aug 2023 16:36:04 -0700 (PDT)
Date:   Fri, 11 Aug 2023 23:35:59 +0000
In-Reply-To: <20230811233556.97161-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230811233556.97161-7-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5591; i=samitolvanen@google.com;
 h=from:subject; bh=iC4KVySOHJXm7MoqeVidxpUrvxa6iA/di8sMVQphPro=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk1sXcl+4pMbxsusEsJNlSct/N38MSVxyzWytYj
 3gXIn1dRb6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZNbF3AAKCRBMtfaEi7xW
 7u94C/9i14LHcJc+kPonuHpc/Sr6RicO+kf9zaXFzOL2MKaPq9BaDmMLL6nuG2iHksvhI5boWFV
 +nA3tePX//NgpDNCfDQUBkwGSEiGRRxy58McWFflyS40n4keNX4+P5qJZekqHzDfH69pmaUE0MQ
 xrxUzYYyWBD7TxyTGewSmEAqP6bRWJhI6FL0zGPkEvDSw+KIQCWYSIcEOMVhgiw8sGyIZRDS2Pd
 y6Keo6flOy8SX/b6Si5H2Xoczfh4JZCkLMAQCC/LL8zA24db+TJRrNv+lB+1FW6hCXB+4+t3Zr2
 DzINx6H3f+B5qU++tKwqqnCG5qXEbyWLKpLIZqyUNTtp2KtfoW1XbXUXE8BIFc8NWNeNUFEo138
 LaBbrdBcscNR9th2G2TBWCjHWmXmWXzb2hGZFTSPg0drLr8BP3MHqva3BhkAKQiLpKttkUqExGH uowMH9lPJ+i7mTffOnRwkH9X1FO6d6TkI0etUkvRZhky2/6KfeNUx8nKV3LGflV/YYs64=
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811233556.97161-9-samitolvanen@google.com>
Subject: [PATCH 2/5] riscv: Deduplicate IRQ stack switching
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Guo Ren <guoren@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
instead of redudant inline assembly.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/include/asm/asm.h       |  5 +++++
 arch/riscv/include/asm/irq_stack.h |  3 +++
 arch/riscv/kernel/entry.S          | 32 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/irq.c            | 32 ++++++++----------------------
 arch/riscv/kernel/traps.c          | 29 ++++-----------------------
 5 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index f403e46e04f2..13815a7f907a 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -98,6 +98,11 @@
 	add   \dst, \dst, \tmp
 .endm
 
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
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 3d11aa3af105..39875f5e08a6 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -218,6 +218,38 @@ SYM_CODE_START(ret_from_fork)
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
+	addi	sp, sp, -RISCV_SZPTR
+	REG_S	ra, (sp)
+	addi	sp, sp, -RISCV_SZPTR
+	REG_S	s0, (sp)
+	addi	s0, sp, 2*RISCV_SZPTR
+
+	/* Switch to the per-CPU IRQ stack and call the handler */
+	load_per_cpu t0, irq_stack_ptr, t1
+	li	t1, IRQ_STACK_SIZE
+	add	sp, t0, t1
+	jalr	a1
+
+	/* Switch back to the thread stack and restore ra and s0 */
+	addi	sp, s0, -2*RISCV_SZPTR
+	REG_L	s0, (sp)
+	addi	sp, sp, RISCV_SZPTR
+	REG_L	ra, (sp)
+	addi	sp, sp, RISCV_SZPTR
+
+	ret
+SYM_FUNC_END(call_on_irq_stack)
+#endif /* CONFIG_IRQ_STACKS */
+
 /*
  * Integer register context switch
  * The callee-saved registers must be saved and restored.
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index d0577cc6a081..95dafdcbd135 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -61,32 +61,16 @@ static void init_irq_stacks(void)
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
index deb2144d9143..83319b6816da 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -350,31 +350,10 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
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
2.41.0.640.ga95def55d0-goog

