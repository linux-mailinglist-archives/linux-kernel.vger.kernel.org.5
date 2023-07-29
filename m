Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF8767F8A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjG2NoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjG2NoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:44:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA05344A8;
        Sat, 29 Jul 2023 06:43:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686c06b806cso2213711b3a.2;
        Sat, 29 Jul 2023 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638236; x=1691243036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=struzozbJs/+NMsmtPPYJHdP8bBDVpFJYqkMv9RI114=;
        b=IoDYyDKfCh6C02rcAoiudzKXkjY1x3VDFFm9tcyT5VKVY8J59zHf8zSMujAtTDpRdp
         r/20K4/RZRMcYn6EqiaYujqbKCMtqXflKU/PJVsQUmWCRdbTTf60GWvU2I1uWfEz3W7d
         SWQyyknDs3xyrUfcjKgqnVNTkiiD6/BigY6DORhjOgBED4k3OQSqI2qWszWjEdkI7Bgy
         YGso8Jkm80YhDJxMscob8cRJWWat5VtpZNU17eBfoUYdaX5RfSs1FKHQTPBzRJWxgkHt
         tfRgYNsesPy2NeRrWYyjbh1fwK8hfLF0s8gbhye89hNM7YgfLE6yIJlJ2xncb0AOg5gW
         ihww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638236; x=1691243036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=struzozbJs/+NMsmtPPYJHdP8bBDVpFJYqkMv9RI114=;
        b=lwRvxsiECQTOAs3oe38+792Ssbt+FUeLBavplFIDyewthGIxcPMeVkRsoreQyikv03
         Wf0GC1yRZacAU5TiEn7taHRDWVnOe9fwcnuiF/Z7rAvLD3M4P5tWeUU8sjhjeEvqO3TG
         xxmlfnKYfhXszXfSMC7M1JQXGG9OUiw+l9X2y32H1citIJU7OMBAiRVG+XWLkYY3XNxw
         5Bnh7jo39uAgRsIjGCWQjH8o3vbnTYixILYr2tfr32Fq1JppeJcAC3eUse/0IoJMsCsU
         dp0B6X5lPh1IZo5KyO8YMJcMpnECV17U02hD9VwG3/pNKNMJIvahgoBBe9ryWCZAuUaT
         gk1g==
X-Gm-Message-State: ABy/qLbHD5LjzxMbBwjIUoGCxsr/P6cg/9f7PSp5xo3hyuy0Ttsfj8Gl
        /EnVER0nLJBjrbW2egeiGt7jLDNRTzrzOw==
X-Google-Smtp-Source: APBJJlHdMXiWLAaOxLLPn9fIhcVv9NFubhGVqddm/F3eCEswvVpcT4Hcj3qs7orZTYJ3iJwCGPr4/g==
X-Received: by 2002:a05:6a00:399c:b0:65a:710a:7855 with SMTP id fi28-20020a056a00399c00b0065a710a7855mr5175405pfb.26.1690638235907;
        Sat, 29 Jul 2023 06:43:55 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:43:55 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 06/17] MIPS: loongson32: Convert platform IRQ driver to DT
Date:   Sat, 29 Jul 2023 21:43:07 +0800
Message-Id: <20230729134318.1694467-7-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables Loongson-1 irqchip driver
by adding platform INTC device nodes.
And drop the legacy platform IRQ driver accordingly.

Based on previous patch by Jiaxun Yang.

Link: https://lore.kernel.org/all/20190411121915.8040-3-jiaxun.yang@flygoat.com
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/boot/dts/loongson/loongson1.dtsi  |  53 ++++++
 arch/mips/boot/dts/loongson/loongson1c.dtsi |  13 ++
 arch/mips/loongson32/common/Makefile        |   2 +-
 arch/mips/loongson32/common/irq.c           | 191 --------------------
 arch/mips/loongson32/init.c                 |   5 +
 5 files changed, 72 insertions(+), 192 deletions(-)
 delete mode 100644 arch/mips/loongson32/common/irq.c

diff --git a/arch/mips/boot/dts/loongson/loongson1.dtsi b/arch/mips/boot/dts/loongson/loongson1.dtsi
index a2b5c828bbbd..711c88fd2781 100644
--- a/arch/mips/boot/dts/loongson/loongson1.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1.dtsi
@@ -19,4 +19,57 @@ cpu_intc: interrupt-controller {
 		interrupt-controller;
 		#interrupt-cells = <1>;
 	};
+
+	ahb: bus@1f000000 {
+		compatible = "simple-bus";
+		reg = <0x1f000000 0xe40000>;
+		ranges;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		intc0: interrupt-controller@1fd01040 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01040 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>;
+		};
+
+		intc1: interrupt-controller@1fd01058 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01058 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <3>;
+		};
+
+		intc2: interrupt-controller@1fd01070 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01070 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <4>;
+		};
+
+		intc3: interrupt-controller@1fd01088 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01088 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <5>;
+		};
+	};
 };
diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/boot/dts/loongson/loongson1c.dtsi
index d552e1668984..8570c4c72677 100644
--- a/arch/mips/boot/dts/loongson/loongson1c.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
@@ -27,3 +27,16 @@ clkc: clock-controller@1fe78030 {
 		#clock-cells = <1>;
 	};
 };
+
+&ahb {
+	intc4: interrupt-controller@1fd010a0 {
+		compatible = "loongson,ls1x-intc";
+		reg = <0x1fd010a0 0x18>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&cpu_intc>;
+		interrupts = <6>;
+	};
+};
diff --git a/arch/mips/loongson32/common/Makefile b/arch/mips/loongson32/common/Makefile
index b5c2f4e0f4cc..25e54b4fca7c 100644
--- a/arch/mips/loongson32/common/Makefile
+++ b/arch/mips/loongson32/common/Makefile
@@ -3,4 +3,4 @@
 # Makefile for common code of loongson1 based machines.
 #
 
-obj-y	+= irq.o platform.o
+obj-y	+= platform.o
diff --git a/arch/mips/loongson32/common/irq.c b/arch/mips/loongson32/common/irq.c
deleted file mode 100644
index 9a50070f74f7..000000000000
--- a/arch/mips/loongson32/common/irq.c
+++ /dev/null
@@ -1,191 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <asm/irq_cpu.h>
-
-#include <loongson1.h>
-#include <irq.h>
-
-#define LS1X_INTC_REG(n, x) \
-		((void __iomem *)KSEG1ADDR(LS1X_INTC_BASE + (n * 0x18) + (x)))
-
-#define LS1X_INTC_INTISR(n)		LS1X_INTC_REG(n, 0x0)
-#define LS1X_INTC_INTIEN(n)		LS1X_INTC_REG(n, 0x4)
-#define LS1X_INTC_INTSET(n)		LS1X_INTC_REG(n, 0x8)
-#define LS1X_INTC_INTCLR(n)		LS1X_INTC_REG(n, 0xc)
-#define LS1X_INTC_INTPOL(n)		LS1X_INTC_REG(n, 0x10)
-#define LS1X_INTC_INTEDGE(n)		LS1X_INTC_REG(n, 0x14)
-
-static void ls1x_irq_ack(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
-			| (1 << bit), LS1X_INTC_INTCLR(n));
-}
-
-static void ls1x_irq_mask(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
-			& ~(1 << bit), LS1X_INTC_INTIEN(n));
-}
-
-static void ls1x_irq_mask_ack(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
-			& ~(1 << bit), LS1X_INTC_INTIEN(n));
-	__raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
-			| (1 << bit), LS1X_INTC_INTCLR(n));
-}
-
-static void ls1x_irq_unmask(struct irq_data *d)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
-			| (1 << bit), LS1X_INTC_INTIEN(n));
-}
-
-static int ls1x_irq_settype(struct irq_data *d, unsigned int type)
-{
-	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
-	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
-
-	switch (type) {
-	case IRQ_TYPE_LEVEL_HIGH:
-		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
-			| (1 << bit), LS1X_INTC_INTPOL(n));
-		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
-			& ~(1 << bit), LS1X_INTC_INTEDGE(n));
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
-			& ~(1 << bit), LS1X_INTC_INTPOL(n));
-		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
-			& ~(1 << bit), LS1X_INTC_INTEDGE(n));
-		break;
-	case IRQ_TYPE_EDGE_RISING:
-		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
-			| (1 << bit), LS1X_INTC_INTPOL(n));
-		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
-			| (1 << bit), LS1X_INTC_INTEDGE(n));
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
-			& ~(1 << bit), LS1X_INTC_INTPOL(n));
-		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
-			| (1 << bit), LS1X_INTC_INTEDGE(n));
-		break;
-	case IRQ_TYPE_EDGE_BOTH:
-		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
-			& ~(1 << bit), LS1X_INTC_INTPOL(n));
-		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
-			| (1 << bit), LS1X_INTC_INTEDGE(n));
-		break;
-	case IRQ_TYPE_NONE:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct irq_chip ls1x_irq_chip = {
-	.name		= "LS1X-INTC",
-	.irq_ack	= ls1x_irq_ack,
-	.irq_mask	= ls1x_irq_mask,
-	.irq_mask_ack	= ls1x_irq_mask_ack,
-	.irq_unmask	= ls1x_irq_unmask,
-	.irq_set_type   = ls1x_irq_settype,
-};
-
-static void ls1x_irq_dispatch(int n)
-{
-	u32 int_status, irq;
-
-	/* Get pending sources, masked by current enables */
-	int_status = __raw_readl(LS1X_INTC_INTISR(n)) &
-			__raw_readl(LS1X_INTC_INTIEN(n));
-
-	if (int_status) {
-		irq = LS1X_IRQ(n, __ffs(int_status));
-		do_IRQ(irq);
-	}
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending;
-
-	pending = read_c0_cause() & read_c0_status() & ST0_IM;
-
-	if (pending & CAUSEF_IP7)
-		do_IRQ(TIMER_IRQ);
-	else if (pending & CAUSEF_IP2)
-		ls1x_irq_dispatch(0); /* INT0 */
-	else if (pending & CAUSEF_IP3)
-		ls1x_irq_dispatch(1); /* INT1 */
-	else if (pending & CAUSEF_IP4)
-		ls1x_irq_dispatch(2); /* INT2 */
-	else if (pending & CAUSEF_IP5)
-		ls1x_irq_dispatch(3); /* INT3 */
-	else if (pending & CAUSEF_IP6)
-		ls1x_irq_dispatch(4); /* INT4 */
-	else
-		spurious_interrupt();
-
-}
-
-static void __init ls1x_irq_init(int base)
-{
-	int n;
-
-	/* Disable interrupts and clear pending,
-	 * setup all IRQs as high level triggered
-	 */
-	for (n = 0; n < INTN; n++) {
-		__raw_writel(0x0, LS1X_INTC_INTIEN(n));
-		__raw_writel(0xffffffff, LS1X_INTC_INTCLR(n));
-		__raw_writel(0xffffffff, LS1X_INTC_INTPOL(n));
-		/* set DMA0, DMA1 and DMA2 to edge trigger */
-		__raw_writel(n ? 0x0 : 0xe000, LS1X_INTC_INTEDGE(n));
-	}
-
-
-	for (n = base; n < NR_IRQS; n++) {
-		irq_set_chip_and_handler(n, &ls1x_irq_chip,
-					 handle_level_irq);
-	}
-
-	if (request_irq(INT0_IRQ, no_action, IRQF_NO_THREAD, "cascade", NULL))
-		pr_err("Failed to request irq %d (cascade)\n", INT0_IRQ);
-	if (request_irq(INT1_IRQ, no_action, IRQF_NO_THREAD, "cascade", NULL))
-		pr_err("Failed to request irq %d (cascade)\n", INT1_IRQ);
-	if (request_irq(INT2_IRQ, no_action, IRQF_NO_THREAD, "cascade", NULL))
-		pr_err("Failed to request irq %d (cascade)\n", INT2_IRQ);
-	if (request_irq(INT3_IRQ, no_action, IRQF_NO_THREAD, "cascade", NULL))
-		pr_err("Failed to request irq %d (cascade)\n", INT3_IRQ);
-#if defined(CONFIG_LOONGSON1_LS1C)
-	if (request_irq(INT4_IRQ, no_action, IRQF_NO_THREAD, "cascade", NULL))
-		pr_err("Failed to request irq %d (cascade)\n", INT4_IRQ);
-#endif
-}
-
-void __init arch_init_irq(void)
-{
-	mips_cpu_irq_init();
-	ls1x_irq_init(LS1X_IRQ_BASE);
-}
diff --git a/arch/mips/loongson32/init.c b/arch/mips/loongson32/init.c
index 1aada785a4a3..d8ef5362c74b 100644
--- a/arch/mips/loongson32/init.c
+++ b/arch/mips/loongson32/init.c
@@ -76,3 +76,8 @@ void __init plat_time_init(void)
 
 	timer_probe();
 }
+
+void __init arch_init_irq(void)
+{
+	irqchip_init();
+}
-- 
2.39.2

