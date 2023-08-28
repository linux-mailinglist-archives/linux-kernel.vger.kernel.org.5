Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E7478B8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjH1T73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjH1T6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:58:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED8188
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5956735bdc3so2946917b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693252727; x=1693857527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=03jC+OBVw6NtqXGsEGvclVCdQhu3EQx6jlJc9yvphdo=;
        b=E+bfdH1lDaLKrKcjWlt3v7mLrI0mXX3/qYWVcii5PVVLZRAYiy1nsib+qeG6H8MOuT
         9OhEHYpNgvWxBky8trYBSEV2JubnwBjeu7di8zHvRoZf0j/YO3KJeryt/leOQaOk8U0+
         E0YLLPMtCwqk+7XZu6/A3/70OtYGnMDc9dICr0zRd4xccIbb8Fl0DxJGU04K1ySPvtRA
         rOrJmojR9TLloOAjWkHIpTDXARYBxhHwOkJ5h1zSqKkVSIGksfJHQ6WU6QjJ2FOyH2nJ
         Z25Phbti7WwdNvRX5aYN5oYcnIcIxNODEPr4eLAqGQxyHCx64dEv2WvC0HWZsxOdspdf
         wAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693252727; x=1693857527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03jC+OBVw6NtqXGsEGvclVCdQhu3EQx6jlJc9yvphdo=;
        b=h27BdhRzwZu3oHaLG3n2/K+Oy67LH4B3RuanjfXwnvNlkVNXQTnwCBHjrHScV6YnWU
         PwtLRviWeN0uGmIp9EGpZV5qXpuviJrGYCfrq0147PUEp0R9kx3qVrKHHUl2ccASs2th
         jGOLZxuc89//WLSNjcURHnZVJlgYZBRaac3LP4c82OjfQJsZ1Ot3daHTV2T+S8Wqa2p1
         MLAePBkSXiqN/dWDK3kzL2urvssWH1h8JXHD+s3UIez68ZIWeNYUddPI2k5CM1RxgyoW
         vsVOkedVfVkfTsml3S4GdmIEjk1Ank7XpvsTBHf0krLkL7mPQrEcbtRo3+apwPCMMcTi
         9cuQ==
X-Gm-Message-State: AOJu0Yw9qFtIDyRdwSYdbw7Ow7NcGI16NhJOD5ufCtNZVALCZvnIQd0a
        ntjaLOgrnZXgG8UNftVOmxt91cBLgmFSsu+ilBE=
X-Google-Smtp-Source: AGHT+IGX3a8SAyFuYllCKEJp1p8BAuBf4bX7iN13I4toDObzdsg0UQOHsOqXYzlSHWKRqNRQ4bgZw4/tHZOh9SXDs4o=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a81:a904:0:b0:576:8cb6:62a9 with SMTP
 id g4-20020a81a904000000b005768cb662a9mr947313ywh.6.1693252727342; Mon, 28
 Aug 2023 12:58:47 -0700 (PDT)
Date:   Mon, 28 Aug 2023 19:58:39 +0000
In-Reply-To: <20230828195833.756747-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230828195833.756747-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3226; i=samitolvanen@google.com;
 h=from:subject; bh=/mGBqVAJStUatVnFnltMn+I7N64iI2QEtl2iB/CZBSg=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk7PxqQdVKNNuAiMW7udPNqMcNpKCbHaCzUHSyh
 KrgH39THuGJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZOz8agAKCRBMtfaEi7xW
 7guJC/9ByIZj6HC9xt8M48iEuc3eleOXi7LLtLxGuUV5BC0aCnuet8/CP1zkrGWtv2JZ39aif62
 X2Lq1gXUXz4nIi7rwmDEz0XjtrBeZtsI5xghAkZCCubYNPWatl0y+0UTL0qa+VuYO+MUp7CwJ4q
 19Any1fNwFxVAXnOTh+0UAcjst/pmBxL9W1CG4VnyA9NHMX3EXKgrQw1SpC0g1+mUut9n6bcrJr
 W0ppsOU/Jqpc/8Xg4TgExx30gJgt1XpXcZSyNaDZk4jXED/GJ0cOupaFz/3bhVzR1J6/y9z3y70
 b9ZHkq5uFdJ6LPJDcdccev+aWmRxrkaw1vZ/4ksObnxApxpaGmFk+kc09Q4+Ab83M50knpeUZkB
 2lPPYgLx0SeP3+XQdiJywRmtKnipviQqot/8K0XYRWNukxdtd30QBKhYtlFI7f5uDYw2bpedKeO 5hPzmPQaQUqbOlLYrH/VXQIVhJ5BZDRq9B+djftJejiGDFObOFuxsPk6QpMbtOq6LFIVA=
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230828195833.756747-13-samitolvanen@google.com>
Subject: [PATCH v3 5/6] riscv: Use separate IRQ shadow call stacks
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both CONFIG_IRQ_STACKS and SCS are enabled, also use a separate
per-CPU shadow call stack.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/riscv/include/asm/scs.h |  7 +++++++
 arch/riscv/kernel/entry.S    |  7 +++++++
 arch/riscv/kernel/irq.c      | 21 +++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/riscv/include/asm/scs.h b/arch/riscv/include/asm/scs.h
index 94726ea773e3..0e45db78b24b 100644
--- a/arch/riscv/include/asm/scs.h
+++ b/arch/riscv/include/asm/scs.h
@@ -13,6 +13,11 @@
 	XIP_FIXUP_OFFSET gp
 .endm
 
+/* Load the per-CPU IRQ shadow call stack to gp. */
+.macro scs_load_irq_stack tmp
+	load_per_cpu gp, irq_shadow_call_stack_ptr, \tmp
+.endm
+
 /* Load task_scs_sp(current) to gp. */
 .macro scs_load_current
 	REG_L	gp, TASK_TI_SCS_SP(tp)
@@ -34,6 +39,8 @@
 
 .macro scs_load_init_stack
 .endm
+.macro scs_load_irq_stack tmp
+.endm
 .macro scs_load_current
 .endm
 .macro scs_load_current_if_task_changed prev
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 52793193a763..3a0db310325a 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -237,12 +237,19 @@ SYM_FUNC_START(call_on_irq_stack)
 	REG_S	s0, STACKFRAME_FP(sp)
 	addi	s0, sp, STACKFRAME_SIZE_ON_STACK
 
+	/* Switch to the per-CPU shadow call stack */
+	scs_save_current
+	scs_load_irq_stack t0
+
 	/* Switch to the per-CPU IRQ stack and call the handler */
 	load_per_cpu t0, irq_stack_ptr, t1
 	li	t1, IRQ_STACK_SIZE
 	add	sp, t0, t1
 	jalr	a1
 
+	/* Switch back to the thread shadow call stack */
+	scs_load_current
+
 	/* Switch back to the thread stack and restore ra and s0 */
 	addi	sp, s0, -STACKFRAME_SIZE_ON_STACK
 	REG_L	ra, STACKFRAME_RA(sp)
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 95dafdcbd135..7bfea97ee7e7 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -9,6 +9,7 @@
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
+#include <linux/scs.h>
 #include <linux/seq_file.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
@@ -34,6 +35,24 @@ EXPORT_SYMBOL_GPL(riscv_get_intc_hwnode);
 #ifdef CONFIG_IRQ_STACKS
 #include <asm/irq_stack.h>
 
+DECLARE_PER_CPU(ulong *, irq_shadow_call_stack_ptr);
+
+#ifdef CONFIG_SHADOW_CALL_STACK
+DEFINE_PER_CPU(ulong *, irq_shadow_call_stack_ptr);
+#endif
+
+static void init_irq_scs(void)
+{
+	int cpu;
+
+	if (!scs_is_enabled())
+		return;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(irq_shadow_call_stack_ptr, cpu) =
+			scs_alloc(cpu_to_node(cpu));
+}
+
 DEFINE_PER_CPU(ulong *, irq_stack_ptr);
 
 #ifdef CONFIG_VMAP_STACK
@@ -76,6 +95,7 @@ void do_softirq_own_stack(void)
 #endif /* CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK */
 
 #else
+static void init_irq_scs(void) {}
 static void init_irq_stacks(void) {}
 #endif /* CONFIG_IRQ_STACKS */
 
@@ -87,6 +107,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 void __init init_IRQ(void)
 {
+	init_irq_scs();
 	init_irq_stacks();
 	irqchip_init();
 	if (!handle_arch_irq)
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

