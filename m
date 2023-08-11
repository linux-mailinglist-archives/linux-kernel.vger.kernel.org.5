Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6467779B6E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbjHKXgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbjHKXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:36:09 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A97910FB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:36:09 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563ab574cb5so3015763a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691796969; x=1692401769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZF+IDNpZAY/LDD7db/2FGsLr/FEvCnem9lcmfmloZ0=;
        b=mtVd1W3/3q051Qstg/rkwh22KJtXJgwRmJjPFHPrSUwrwcnjBaqya9IaLakBib/tGp
         MZTlDO3i3B4tO+B0FXZi24NgY0QmiN3TLRaIN/r9BVzhVd6lXdijvcEwht3QqyGFD25d
         iAg948H3L3HcDIX/PDfVlKzDxQL0FtAOPKhRa0fRjcPK/dRobJigKyFzAfEEvzpV65fs
         kGDPQqp+LC2W1h1PDbovFc73zR/ks5uXhEXNhFQtNnxEmYALG9EGpnOyEhYzt92Xo9Yq
         5nvT9GMKmOWUbwmKtjMTTTSyuaOqrL5J7LhfgrsQFnUpeCuAUc08CGdSsrD74A12oTl/
         4BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796969; x=1692401769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZF+IDNpZAY/LDD7db/2FGsLr/FEvCnem9lcmfmloZ0=;
        b=kXLKz/Yp8f9mr+bM8F1cTr8ti6PeK7y3tSejHads9DCxNdSk2YbGlKiMy1MWq18Mh0
         K7NKOZ5oBdVqkVRQRR0uJuUpkuJpJL40i+aDZF/xyj1PZY/TNaVizAsZVBRDLlTsYZ7W
         zKYD5G1ECNhSun0TIrHLsaSB4BvELBpcZTDh21ll9b97G31UWGNJSs9c5DUavCneFlA5
         E0B5/T1rYvcTZ9BV0Sj5hV4U55ZfdwFYIX0CmH/Ey4jh+h9tJu+vLWwWzGHSB85Ru7sK
         Pk2m7L5g8Lx7ivfnhLL6f0dwg1kWEHqkWp8L9oWUdFVs8QO7O9v1uTN6sAisNORp7KRq
         C6QQ==
X-Gm-Message-State: AOJu0Ywvh1+HogDXv9Eq2PPAeaWfGy40gm6retrg3kix1iSWtXHIScS4
        PmU18QUPP3qdsC5zMAig+VrnKWAsLK0+hoW91a0=
X-Google-Smtp-Source: AGHT+IHhsvuH2OM1UWszf4TCMu5qR06fZ9BwriEs9fj1OxjgnvZGnw/4HlxK/SLUtDQ7Phb6303mh2wjDyw9Z0/+bjA=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a63:8c57:0:b0:564:aeb6:c383 with SMTP
 id q23-20020a638c57000000b00564aeb6c383mr638656pgn.1.1691796969048; Fri, 11
 Aug 2023 16:36:09 -0700 (PDT)
Date:   Fri, 11 Aug 2023 23:36:02 +0000
In-Reply-To: <20230811233556.97161-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230811233556.97161-7-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3124; i=samitolvanen@google.com;
 h=from:subject; bh=wBRXjmNHfhdcdsjrWxKjQVM4d1RVOAig5wuWuTXp+sw=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk1sXcweRCoqkszjtNMVnBaMVhIhZi/o4cME2C4
 t5Qc51TbeWJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZNbF3AAKCRBMtfaEi7xW
 7oToC/0bVrByxxtfXjE7idOKMhQ47Ftkbwzrwd/qVpuGk5sKwMO1ZCCpNUD1WjHmpT9DM/jRjii
 ID7y7zSN8jMwvkBKVqWFcrA/Eaa0m5fWafqe4cjjWupJSB/ep6zYn/Rg6HLdIw7XP4JK/Vc4y4r
 TzWyrycXtowJuCYuF+VVNuP27Hv37AH2QTpPxcpmbb7m3TwnCZ3WQKLI40KhXg8gonXaggVqg3q
 X5caBqH0OE2M8dRrYxeDPBlFrqtmfu0hbgTF/flJQdHf2d68ZJHYv8m5rdu94Bnwwf6XZFg+Q0R
 ZQlYPtqVBdg6YwftizeZzNr6QjUFpqQ7A4buby+3pAI85S6NE4IF5Nces27nX/oKcSXM9+L4gog
 10WOtL3ybC+F9bnk4ud+g4NkqrfaEszHa/UYGP2doaSEY7wnGja38VeGjqq9XMANxgYlDyRpWrs vGsTNxyJYa2V8imEkZFgy9kgnfoyRyITlo1VmA8GQU3rxJACgMLpVtK/P/BITWXbgVKXU=
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811233556.97161-12-samitolvanen@google.com>
Subject: [PATCH 5/5] riscv: Use separate IRQ shadow call stacks
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
index ad34507d3c96..c86b76584d2d 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -238,12 +238,19 @@ SYM_FUNC_START(call_on_irq_stack)
 	REG_S	s0, (sp)
 	addi	s0, sp, 2*RISCV_SZPTR
 
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
 	addi	sp, s0, -2*RISCV_SZPTR
 	REG_L	s0, (sp)
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
2.41.0.640.ga95def55d0-goog

