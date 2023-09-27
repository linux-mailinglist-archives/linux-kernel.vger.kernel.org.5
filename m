Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B197B0F14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjI0WsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjI0WsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:48:13 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1E1FB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:48:11 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c725aa19eeso27302875ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695854891; x=1696459691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3UA3PzXciXcLUc7CxJsx04dBK4in+Q1qERJTsVZ4p+I=;
        b=mQFtQvNx3OjJt8dEyvzofTGIoYMOtISxmii6C6W3QMTiJw5tKlhyCnlpx/0eDPLE4O
         t2R3zWXilyeMcKbqZKT2fOmb0hTC4LzUA7Hj+MaUaAcB9GIS7JcJ3V84QqR9j+szZleY
         UHswGqEebOHy8UxgzlUVUaGXg0Ga57f5bDrgyls9O9xJ2iTx459bauGxgBg8fE3DEiMe
         xm5q+5LaWJ9J37vatZ+N16hbQQULiUZPU1gRyVaDnnDYFDJ3YzA71OE/ov3QWSqALd08
         iKBjvgjeRCrAvJByItud/r/iaIsjpiGSm1oxRCdE0bVzs4uuVMxBy+HIhK1epuHxGOZc
         6UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695854891; x=1696459691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UA3PzXciXcLUc7CxJsx04dBK4in+Q1qERJTsVZ4p+I=;
        b=iWup7YGr5VmCewcQXvNM7mbVhC7IWWvph3icSvx4GF6HMrQ4BRVHUfPNFyHiynNloi
         V6qYWW1IFFK5AY8LddKscBTc9OuSpZcBCT/9U4SCs5aYQmiIxhU1ezsB7fRW0qU9Rlys
         FHpBq8iRYMLKlap+3U672g7Z2UEURjUwDwfe4tgT5dzeMxhheABOrycYO9+crxckVtNq
         1xbxiNpSZscZ6OYIat5mhXNcLoNkzpvMEvJjHHyHHI6M9CeUnMyL6lkK89ZlcnRO1CEZ
         S9jMXw12iLf2y6EuyB7ElX7+Apb3qqIi60wB+VgWLjwHmDQGtadfcHrh3H/NGl/HvCKs
         x2Fg==
X-Gm-Message-State: AOJu0Yx7KQC6z3GHOtvRVGhWixk352dAda3BfYKYOJ3pspz350KpbLo+
        J3BYqg8bgidd1EBGKDgnQQl3Ffo0dGMtBU6fMFU=
X-Google-Smtp-Source: AGHT+IGnHh7mzMqcUnQLuZVLiDPicZpub6WK4SE1LILyGIfzVy1iJYFLVk2P+ycVcj9fl1t/gaT0ECVaBFtwa8dcsJ4=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:d4ce:b0:1c0:ac09:4032 with
 SMTP id o14-20020a170902d4ce00b001c0ac094032mr40690plg.9.1695854890733; Wed,
 27 Sep 2023 15:48:10 -0700 (PDT)
Date:   Wed, 27 Sep 2023 22:48:03 +0000
In-Reply-To: <20230927224757.1154247-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230927224757.1154247-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3222; i=samitolvanen@google.com;
 h=from:subject; bh=4iP9jD07sRLKZy9z4wycr0gGeMqN4nW8GVhSWT+pt0c=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBlFLEdc0ndW+W8xAwxA/Cqwr/zGM8KrW/4U7Qvn
 D6/24dFgZmJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZRSxHQAKCRBMtfaEi7xW
 7j/TC/9QYIFVRwBHilpMvJsGF5ZuLLmHXC+6PyGWcKJr1nfV4YChcnH2AyhrR3Jtsn0GDJrOc8N
 35cE87DH6HMvHXoAdjwYFdSZfEOQUulLMiyIZ37pg2TWFbhI4B0s95x/8KXGpIgMnApDq8FRKkr
 dkX4ZyFmhTYLNIpmNAleOednmNBtzsKapufJKcTpmhCq8SwzCTpkINVE7MsKmugeis556J8Sq9n
 py+Q6LsRmlhB7THYIcqHSiye89YKOv7oCvgahLR8miSX2x9iG7s8Mla1J5GqT274t3WrXdNPy6l
 B1nug8SBfJtw7s7N8My+43WNYyLLeJEzZwbPjTn9WGY1jqgcPbMigApDdUKe8Fdxb/oCiX/DVXC
 Tky38rffJrp5N9fn0HexYQXlNxa1ATOdk1/RRB9kKz6Er1hZRieQWrM4xBxWZMV5cd3WF1d0HmP PtTL6WVk+2I7pBm+006Qa1nQBDboCBjiHxppqh3VuXLq2JGFPc5C2ycM/tKhII8IFb28E=
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927224757.1154247-13-samitolvanen@google.com>
Subject: [PATCH v4 5/6] riscv: Use separate IRQ shadow call stacks
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
2.42.0.515.g380fc7ccd1-goog

