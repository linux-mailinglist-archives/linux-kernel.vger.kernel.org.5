Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1625D767FA7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjG2NpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjG2NpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:45:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9444680;
        Sat, 29 Jul 2023 06:44:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686b9920362so2219589b3a.1;
        Sat, 29 Jul 2023 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638263; x=1691243063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIII0aCOQoNgD25IbrV2eDFAjBzFNUmvZhTDfIjnSXE=;
        b=fgwXSaChGcGsn7cUu04jgm0uJ3JeKrhbZsKzd4c3w3ofY6IcN268q1YuysDLBTVCYx
         tK2V0uq82J4ffMbcop180KS8SCmk94eA72mLBlNv11cYa1WL1P3FA15nde0u0ZxeerHh
         fyfSRt7vA25iPOCxT4KOhWOFReeXQlTBjfchrjyi8s9fY8qzIV3ZNQudXUQLQhp1xcDd
         AYJC/HAkHW6EPt7LcODd6n9GkM3ig2NmmgmltG9FU4UpIUQUN2MVxJG53s6iNjxplaCh
         yAYTzCh2unsRmKaemTHwn1ztA+CirMSULj5or/PT26C9tH1p7q4USJeUkfV2VdIndHyP
         0WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638263; x=1691243063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIII0aCOQoNgD25IbrV2eDFAjBzFNUmvZhTDfIjnSXE=;
        b=PVRY7wQNn2MktKOcU5iiVZGqCoZqtYLdK3u3oyRpkXfDJzZnRX8PlUkcjmvSIT25Fq
         Og0rHhgTe9wasGBuYBqv/Oi4/3VuYa4aE7oFg36d7FHCagsoQPXnyiumBXeA7LMQ6lHn
         20HjE6B13xA0QcAVFtX+tk1AYq3s0QdQvnpeMrBQ+G9Rg+o7BWdwJJtA4nl3I3geX8/p
         YxAA7nTfaOzDe4Gobqa5pBkAhs55nK4XYJQVe6ufaagIrTLHh47sKT4xidp2BbKWFlKn
         L6oNzaU2GvxKKqpB/Xc1GfcijPDrdN1uOHhH2+OGXbj+nvFJ0lwuy01yiBcBWQlwVnrn
         RmKQ==
X-Gm-Message-State: ABy/qLZJNGN2iiW7VPaxGj2CX0uMrjjE6/+wK2RgE8n12aSQKbWN6YNH
        HhJnDvTIs1kuN7QD9ItehGOn6vFipxUOIA==
X-Google-Smtp-Source: APBJJlHGc7Dfre1v3spT/79M1DUMF8HLGrPsQvkEkrsNvG3lSWhByR0MRULwdE2oNfPixSNyWOahTA==
X-Received: by 2002:a05:6300:8001:b0:130:835b:e260 with SMTP id an1-20020a056300800100b00130835be260mr4540771pzc.52.1690638262831;
        Sat, 29 Jul 2023 06:44:22 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:44:22 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 15/17] MIPS: loongson32: Remove all the obsolete code of platform device
Date:   Sat, 29 Jul 2023 21:43:16 +0800
Message-Id: <20230729134318.1694467-16-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All platform devices of Loongson-1 was converted to devicetree.
Therefore, removes all the obsolete platform device related code,
header files and Kconfig options.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/include/asm/mach-loongson32/dma.h   |  21 ---
 arch/mips/include/asm/mach-loongson32/irq.h   | 107 ---------------
 .../include/asm/mach-loongson32/loongson1.h   |  50 -------
 arch/mips/include/asm/mach-loongson32/nand.h  |  26 ----
 .../include/asm/mach-loongson32/platform.h    |  26 ----
 .../include/asm/mach-loongson32/regs-mux.h    | 124 ------------------
 arch/mips/loongson32/Kconfig                  |   8 --
 arch/mips/loongson32/Makefile                 |  13 --
 arch/mips/loongson32/common/Makefile          |   6 -
 arch/mips/loongson32/common/platform.c        |  17 ---
 arch/mips/loongson32/ls1b/Makefile            |   6 -
 arch/mips/loongson32/ls1b/board.c             |  24 ----
 arch/mips/loongson32/ls1c/Makefile            |   6 -
 arch/mips/loongson32/ls1c/board.c             |  17 ---
 14 files changed, 451 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/dma.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/irq.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/loongson1.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/nand.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/platform.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-mux.h
 delete mode 100644 arch/mips/loongson32/common/Makefile
 delete mode 100644 arch/mips/loongson32/common/platform.c
 delete mode 100644 arch/mips/loongson32/ls1b/Makefile
 delete mode 100644 arch/mips/loongson32/ls1b/board.c
 delete mode 100644 arch/mips/loongson32/ls1c/Makefile
 delete mode 100644 arch/mips/loongson32/ls1c/board.c

diff --git a/arch/mips/include/asm/mach-loongson32/dma.h b/arch/mips/include/asm/mach-loongson32/dma.h
deleted file mode 100644
index e917b3ccb2c2..000000000000
--- a/arch/mips/include/asm/mach-loongson32/dma.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2015 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 NAND platform support.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_DMA_H
-#define __ASM_MACH_LOONGSON32_DMA_H
-
-#define LS1X_DMA_CHANNEL0	0
-#define LS1X_DMA_CHANNEL1	1
-#define LS1X_DMA_CHANNEL2	2
-
-struct plat_ls1x_dma {
-	int nr_channels;
-};
-
-extern struct plat_ls1x_dma ls1b_dma_pdata;
-
-#endif /* __ASM_MACH_LOONGSON32_DMA_H */
diff --git a/arch/mips/include/asm/mach-loongson32/irq.h b/arch/mips/include/asm/mach-loongson32/irq.h
deleted file mode 100644
index 6115f025ba21..000000000000
--- a/arch/mips/include/asm/mach-loongson32/irq.h
+++ /dev/null
@@ -1,107 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * IRQ mappings for Loongson 1
- */
-
-#ifndef __ASM_MACH_LOONGSON32_IRQ_H
-#define __ASM_MACH_LOONGSON32_IRQ_H
-
-/*
- * CPU core Interrupt Numbers
- */
-#define MIPS_CPU_IRQ_BASE		0
-#define MIPS_CPU_IRQ(x)			(MIPS_CPU_IRQ_BASE + (x))
-
-#define SOFTINT0_IRQ			MIPS_CPU_IRQ(0)
-#define SOFTINT1_IRQ			MIPS_CPU_IRQ(1)
-#define INT0_IRQ			MIPS_CPU_IRQ(2)
-#define INT1_IRQ			MIPS_CPU_IRQ(3)
-#define INT2_IRQ			MIPS_CPU_IRQ(4)
-#define INT3_IRQ			MIPS_CPU_IRQ(5)
-#define INT4_IRQ			MIPS_CPU_IRQ(6)
-#define TIMER_IRQ			MIPS_CPU_IRQ(7)		/* cpu timer */
-
-#define MIPS_CPU_IRQS		(MIPS_CPU_IRQ(7) + 1 - MIPS_CPU_IRQ_BASE)
-
-/*
- * INT0~3 Interrupt Numbers
- */
-#define LS1X_IRQ_BASE			MIPS_CPU_IRQS
-#define LS1X_IRQ(n, x)			(LS1X_IRQ_BASE + (n << 5) + (x))
-
-#define LS1X_UART0_IRQ			LS1X_IRQ(0, 2)
-#if defined(CONFIG_LOONGSON1_LS1B)
-#define LS1X_UART1_IRQ			LS1X_IRQ(0, 3)
-#define LS1X_UART2_IRQ			LS1X_IRQ(0, 4)
-#define LS1X_UART3_IRQ			LS1X_IRQ(0, 5)
-#elif defined(CONFIG_LOONGSON1_LS1C)
-#define LS1X_UART1_IRQ			LS1X_IRQ(0, 4)
-#define LS1X_UART2_IRQ			LS1X_IRQ(0, 5)
-#endif
-#define LS1X_CAN0_IRQ			LS1X_IRQ(0, 6)
-#define LS1X_CAN1_IRQ			LS1X_IRQ(0, 7)
-#define LS1X_SPI0_IRQ			LS1X_IRQ(0, 8)
-#define LS1X_SPI1_IRQ			LS1X_IRQ(0, 9)
-#define LS1X_AC97_IRQ			LS1X_IRQ(0, 10)
-#define LS1X_DMA0_IRQ			LS1X_IRQ(0, 13)
-#define LS1X_DMA1_IRQ			LS1X_IRQ(0, 14)
-#define LS1X_DMA2_IRQ			LS1X_IRQ(0, 15)
-#if defined(CONFIG_LOONGSON1_LS1C)
-#define LS1X_NAND_IRQ			LS1X_IRQ(0, 16)
-#endif
-#define LS1X_PWM0_IRQ			LS1X_IRQ(0, 17)
-#define LS1X_PWM1_IRQ			LS1X_IRQ(0, 18)
-#define LS1X_PWM2_IRQ			LS1X_IRQ(0, 19)
-#define LS1X_PWM3_IRQ			LS1X_IRQ(0, 20)
-#define LS1X_RTC_INT0_IRQ		LS1X_IRQ(0, 21)
-#define LS1X_RTC_INT1_IRQ		LS1X_IRQ(0, 22)
-#define LS1X_RTC_INT2_IRQ		LS1X_IRQ(0, 23)
-#if defined(CONFIG_LOONGSON1_LS1B)
-#define LS1X_TOY_INT0_IRQ		LS1X_IRQ(0, 24)
-#define LS1X_TOY_INT1_IRQ		LS1X_IRQ(0, 25)
-#define LS1X_TOY_INT2_IRQ		LS1X_IRQ(0, 26)
-#define LS1X_RTC_TICK_IRQ		LS1X_IRQ(0, 27)
-#define LS1X_TOY_TICK_IRQ		LS1X_IRQ(0, 28)
-#define LS1X_UART4_IRQ			LS1X_IRQ(0, 29)
-#define LS1X_UART5_IRQ			LS1X_IRQ(0, 30)
-#elif defined(CONFIG_LOONGSON1_LS1C)
-#define LS1X_UART3_IRQ			LS1X_IRQ(0, 29)
-#define LS1X_ADC_IRQ			LS1X_IRQ(0, 30)
-#define LS1X_SDIO_IRQ			LS1X_IRQ(0, 31)
-#endif
-
-#define LS1X_EHCI_IRQ			LS1X_IRQ(1, 0)
-#define LS1X_OHCI_IRQ			LS1X_IRQ(1, 1)
-#if defined(CONFIG_LOONGSON1_LS1B)
-#define LS1X_GMAC0_IRQ			LS1X_IRQ(1, 2)
-#define LS1X_GMAC1_IRQ			LS1X_IRQ(1, 3)
-#elif defined(CONFIG_LOONGSON1_LS1C)
-#define LS1X_OTG_IRQ			LS1X_IRQ(1, 2)
-#define LS1X_GMAC0_IRQ			LS1X_IRQ(1, 3)
-#define LS1X_CAM_IRQ			LS1X_IRQ(1, 4)
-#define LS1X_UART4_IRQ			LS1X_IRQ(1, 5)
-#define LS1X_UART5_IRQ			LS1X_IRQ(1, 6)
-#define LS1X_UART6_IRQ			LS1X_IRQ(1, 7)
-#define LS1X_UART7_IRQ			LS1X_IRQ(1, 8)
-#define LS1X_UART8_IRQ			LS1X_IRQ(1, 9)
-#define LS1X_UART9_IRQ			LS1X_IRQ(1, 13)
-#define LS1X_UART10_IRQ			LS1X_IRQ(1, 14)
-#define LS1X_UART11_IRQ			LS1X_IRQ(1, 15)
-#define LS1X_I2C0_IRQ			LS1X_IRQ(1, 17)
-#define LS1X_I2C1_IRQ			LS1X_IRQ(1, 18)
-#define LS1X_I2C2_IRQ			LS1X_IRQ(1, 19)
-#endif
-
-#if defined(CONFIG_LOONGSON1_LS1B)
-#define INTN	4
-#elif defined(CONFIG_LOONGSON1_LS1C)
-#define INTN	5
-#endif
-
-#define LS1X_IRQS		(LS1X_IRQ(INTN, 31) + 1 - LS1X_IRQ_BASE)
-
-#define NR_IRQS			(MIPS_CPU_IRQS + LS1X_IRQS)
-
-#endif /* __ASM_MACH_LOONGSON32_IRQ_H */
diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
deleted file mode 100644
index 84f45461c832..000000000000
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Register mappings for Loongson 1
- */
-
-#ifndef __ASM_MACH_LOONGSON32_LOONGSON1_H
-#define __ASM_MACH_LOONGSON32_LOONGSON1_H
-
-#if defined(CONFIG_LOONGSON1_LS1B)
-#define DEFAULT_MEMSIZE			64	/* If no memsize provided */
-#elif defined(CONFIG_LOONGSON1_LS1C)
-#define DEFAULT_MEMSIZE			32
-#endif
-
-/* Loongson 1 Register Bases */
-#define LS1X_MUX_BASE			0x1fd00420
-#define LS1X_INTC_BASE			0x1fd01040
-#define LS1X_GPIO0_BASE			0x1fd010c0
-#define LS1X_GPIO1_BASE			0x1fd010c4
-#define LS1X_DMAC_BASE			0x1fd01160
-#define LS1X_CBUS_BASE			0x1fd011c0
-#define LS1X_EHCI_BASE			0x1fe00000
-#define LS1X_OHCI_BASE			0x1fe08000
-#define LS1X_GMAC0_BASE			0x1fe10000
-#define LS1X_GMAC1_BASE			0x1fe20000
-
-#define LS1X_UART0_BASE			0x1fe40000
-#define LS1X_UART1_BASE			0x1fe44000
-#define LS1X_UART2_BASE			0x1fe48000
-#define LS1X_UART3_BASE			0x1fe4c000
-#define LS1X_CAN0_BASE			0x1fe50000
-#define LS1X_CAN1_BASE			0x1fe54000
-#define LS1X_I2C0_BASE			0x1fe58000
-#define LS1X_I2C1_BASE			0x1fe68000
-#define LS1X_I2C2_BASE			0x1fe70000
-#define LS1X_PWM0_BASE			0x1fe5c000
-#define LS1X_PWM1_BASE			0x1fe5c010
-#define LS1X_PWM2_BASE			0x1fe5c020
-#define LS1X_PWM3_BASE			0x1fe5c030
-#define LS1X_WDT_BASE			0x1fe5c060
-#define LS1X_RTC_BASE			0x1fe64000
-#define LS1X_AC97_BASE			0x1fe74000
-#define LS1X_NAND_BASE			0x1fe78000
-#define LS1X_CLK_BASE			0x1fe78030
-
-#include <regs-mux.h>
-
-#endif /* __ASM_MACH_LOONGSON32_LOONGSON1_H */
diff --git a/arch/mips/include/asm/mach-loongson32/nand.h b/arch/mips/include/asm/mach-loongson32/nand.h
deleted file mode 100644
index aaf5ed19d78d..000000000000
--- a/arch/mips/include/asm/mach-loongson32/nand.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2015 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 NAND platform support.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_NAND_H
-#define __ASM_MACH_LOONGSON32_NAND_H
-
-#include <linux/dmaengine.h>
-#include <linux/mtd/partitions.h>
-
-struct plat_ls1x_nand {
-	struct mtd_partition *parts;
-	unsigned int nr_parts;
-
-	int hold_cycle;
-	int wait_cycle;
-};
-
-extern struct plat_ls1x_nand ls1b_nand_pdata;
-
-bool ls1x_dma_filter_fn(struct dma_chan *chan, void *param);
-
-#endif /* __ASM_MACH_LOONGSON32_NAND_H */
diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
deleted file mode 100644
index 2cdcfb5f6012..000000000000
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#ifndef __ASM_MACH_LOONGSON32_PLATFORM_H
-#define __ASM_MACH_LOONGSON32_PLATFORM_H
-
-#include <linux/platform_device.h>
-
-#include <dma.h>
-#include <nand.h>
-
-extern struct platform_device ls1x_uart_pdev;
-extern struct platform_device ls1x_eth0_pdev;
-extern struct platform_device ls1x_eth1_pdev;
-extern struct platform_device ls1x_ehci_pdev;
-extern struct platform_device ls1x_gpio0_pdev;
-extern struct platform_device ls1x_gpio1_pdev;
-extern struct platform_device ls1x_rtc_pdev;
-extern struct platform_device ls1x_wdt_pdev;
-
-void __init ls1x_rtc_set_extclk(struct platform_device *pdev);
-void __init ls1x_serial_set_uartclk(struct platform_device *pdev);
-
-#endif /* __ASM_MACH_LOONGSON32_PLATFORM_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-mux.h b/arch/mips/include/asm/mach-loongson32/regs-mux.h
deleted file mode 100644
index 95788a4f03a0..000000000000
--- a/arch/mips/include/asm/mach-loongson32/regs-mux.h
+++ /dev/null
@@ -1,124 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 MUX Register Definitions.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_REGS_MUX_H
-#define __ASM_MACH_LOONGSON32_REGS_MUX_H
-
-#define LS1X_MUX_REG(x) \
-		((void __iomem *)KSEG1ADDR(LS1X_MUX_BASE + (x)))
-
-#define LS1X_MUX_CTRL0			LS1X_MUX_REG(0x0)
-#define LS1X_MUX_CTRL1			LS1X_MUX_REG(0x4)
-
-#if defined(CONFIG_LOONGSON1_LS1B)
-/* MUX CTRL0 Register Bits */
-#define UART0_USE_PWM23			BIT(28)
-#define UART0_USE_PWM01			BIT(27)
-#define UART1_USE_LCD0_5_6_11		BIT(26)
-#define I2C2_USE_CAN1			BIT(25)
-#define I2C1_USE_CAN0			BIT(24)
-#define NAND3_USE_UART5			BIT(23)
-#define NAND3_USE_UART4			BIT(22)
-#define NAND3_USE_UART1_DAT		BIT(21)
-#define NAND3_USE_UART1_CTS		BIT(20)
-#define NAND3_USE_PWM23			BIT(19)
-#define NAND3_USE_PWM01			BIT(18)
-#define NAND2_USE_UART5			BIT(17)
-#define NAND2_USE_UART4			BIT(16)
-#define NAND2_USE_UART1_DAT		BIT(15)
-#define NAND2_USE_UART1_CTS		BIT(14)
-#define NAND2_USE_PWM23			BIT(13)
-#define NAND2_USE_PWM01			BIT(12)
-#define NAND1_USE_UART5			BIT(11)
-#define NAND1_USE_UART4			BIT(10)
-#define NAND1_USE_UART1_DAT		BIT(9)
-#define NAND1_USE_UART1_CTS		BIT(8)
-#define NAND1_USE_PWM23			BIT(7)
-#define NAND1_USE_PWM01			BIT(6)
-#define GMAC1_USE_UART1			BIT(4)
-#define GMAC1_USE_UART0			BIT(3)
-#define LCD_USE_UART0_DAT		BIT(2)
-#define LCD_USE_UART15			BIT(1)
-#define LCD_USE_UART0			BIT(0)
-
-/* MUX CTRL1 Register Bits */
-#define USB_RESET			BIT(31)
-#define SPI1_CS_USE_PWM01		BIT(24)
-#define SPI1_USE_CAN			BIT(23)
-#define DISABLE_DDR_CONFSPACE		BIT(20)
-#define DDR32TO16EN			BIT(16)
-#define GMAC1_SHUT			BIT(13)
-#define GMAC0_SHUT			BIT(12)
-#define USB_SHUT			BIT(11)
-#define UART1_3_USE_CAN1		BIT(5)
-#define UART1_2_USE_CAN0		BIT(4)
-#define GMAC1_USE_TXCLK			BIT(3)
-#define GMAC0_USE_TXCLK			BIT(2)
-#define GMAC1_USE_PWM23			BIT(1)
-#define GMAC0_USE_PWM01			BIT(0)
-
-#elif defined(CONFIG_LOONGSON1_LS1C)
-
-/* SHUT_CTRL Register Bits */
-#define UART_SPLIT			GENMASK(31, 30)
-#define OUTPUT_CLK			GENMASK(29, 26)
-#define ADC_SHUT			BIT(25)
-#define SDIO_SHUT			BIT(24)
-#define DMA2_SHUT			BIT(23)
-#define DMA1_SHUT			BIT(22)
-#define DMA0_SHUT			BIT(21)
-#define SPI1_SHUT			BIT(20)
-#define SPI0_SHUT			BIT(19)
-#define I2C2_SHUT			BIT(18)
-#define I2C1_SHUT			BIT(17)
-#define I2C0_SHUT			BIT(16)
-#define AC97_SHUT			BIT(15)
-#define I2S_SHUT			BIT(14)
-#define UART3_SHUT			BIT(13)
-#define UART2_SHUT			BIT(12)
-#define UART1_SHUT			BIT(11)
-#define UART0_SHUT			BIT(10)
-#define CAN1_SHUT			BIT(9)
-#define CAN0_SHUT			BIT(8)
-#define ECC_SHUT			BIT(7)
-#define GMAC_SHUT			BIT(6)
-#define USBHOST_SHUT			BIT(5)
-#define USBOTG_SHUT			BIT(4)
-#define SDRAM_SHUT			BIT(3)
-#define SRAM_SHUT			BIT(2)
-#define CAM_SHUT			BIT(1)
-#define LCD_SHUT			BIT(0)
-
-#define UART_SPLIT_SHIFT                        30
-#define OUTPUT_CLK_SHIFT                        26
-
-/* MISC_CTRL Register Bits */
-#define USBHOST_RSTN			BIT(31)
-#define PHY_INTF_SELI			GENMASK(30, 28)
-#define AC97_EN				BIT(25)
-#define SDIO_DMA_EN			GENMASK(24, 23)
-#define ADC_DMA_EN			BIT(22)
-#define SDIO_USE_SPI1			BIT(17)
-#define SDIO_USE_SPI0			BIT(16)
-#define SRAM_CTRL			GENMASK(15, 0)
-
-#define PHY_INTF_SELI_SHIFT                     28
-#define SDIO_DMA_EN_SHIFT                       23
-#define SRAM_CTRL_SHIFT				0
-
-#define LS1X_CBUS_REG(n, x) \
-		((void __iomem *)KSEG1ADDR(LS1X_CBUS_BASE + (n * 0x04) + (x)))
-
-#define LS1X_CBUS_FIRST(n)		LS1X_CBUS_REG(n, 0x00)
-#define LS1X_CBUS_SECOND(n)		LS1X_CBUS_REG(n, 0x10)
-#define LS1X_CBUS_THIRD(n)		LS1X_CBUS_REG(n, 0x20)
-#define LS1X_CBUS_FOURTHT(n)		LS1X_CBUS_REG(n, 0x30)
-#define LS1X_CBUS_FIFTHT(n)		LS1X_CBUS_REG(n, 0x40)
-
-#endif
-
-#endif /* __ASM_MACH_LOONGSON32_REGS_MUX_H */
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 75c1f4061700..22449d57f744 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -6,20 +6,12 @@ choice
 
 config MACH_LSGZ_1B_DEV
 	bool "LSGZ 1B DEV board"
-	select LOONGSON1_LS1B
 	help
 	  Enable this to include the FDT for the LSGZ 1B DEV board.
 
 config MACH_SMARTLOONG_1C
 	bool "Smartloong 1C board"
-	select LOONGSON1_LS1C
 	help
 	  Enable this to include the FDT for the Smartloong 1C board.
 
 endchoice
-
-config LOONGSON1_LS1B
-	bool
-
-config LOONGSON1_LS1C
-	bool
diff --git a/arch/mips/loongson32/Makefile b/arch/mips/loongson32/Makefile
index 2d1b985dad71..53a97b2b8d77 100644
--- a/arch/mips/loongson32/Makefile
+++ b/arch/mips/loongson32/Makefile
@@ -4,16 +4,3 @@
 #
 
 obj-$(CONFIG_MACH_LOONGSON32) += init.o proc.o
-obj-$(CONFIG_MACH_LOONGSON32) += common/
-
-#
-# Loongson LS1B board
-#
-
-obj-$(CONFIG_LOONGSON1_LS1B)  += ls1b/
-
-#
-# Loongson LS1C board
-#
-
-obj-$(CONFIG_LOONGSON1_LS1C)  += ls1c/
diff --git a/arch/mips/loongson32/common/Makefile b/arch/mips/loongson32/common/Makefile
deleted file mode 100644
index 25e54b4fca7c..000000000000
--- a/arch/mips/loongson32/common/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for common code of loongson1 based machines.
-#
-
-obj-y	+= platform.o
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
deleted file mode 100644
index 9783c34f39b4..000000000000
--- a/arch/mips/loongson32/common/platform.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2011-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#include <linux/clk.h>
-#include <linux/dma-mapping.h>
-#include <linux/err.h>
-#include <linux/mtd/partitions.h>
-#include <linux/sizes.h>
-#include <linux/usb/ehci_pdriver.h>
-
-#include <platform.h>
-#include <loongson1.h>
-#include <dma.h>
-#include <nand.h>
-#include <irq.h>
diff --git a/arch/mips/loongson32/ls1b/Makefile b/arch/mips/loongson32/ls1b/Makefile
deleted file mode 100644
index 33c574dc0f7f..000000000000
--- a/arch/mips/loongson32/ls1b/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for loongson1B based machines.
-#
-
-obj-y += board.o
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
deleted file mode 100644
index ff28f44fa687..000000000000
--- a/arch/mips/loongson32/ls1b/board.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2011-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#include <linux/leds.h>
-#include <linux/mtd/partitions.h>
-#include <linux/sizes.h>
-
-#include <loongson1.h>
-#include <dma.h>
-#include <nand.h>
-#include <platform.h>
-
-static struct platform_device *ls1b_platform_devices[] __initdata = {
-};
-
-static int __init ls1b_platform_init(void)
-{
-	return platform_add_devices(ls1b_platform_devices,
-				   ARRAY_SIZE(ls1b_platform_devices));
-}
-
-arch_initcall(ls1b_platform_init);
diff --git a/arch/mips/loongson32/ls1c/Makefile b/arch/mips/loongson32/ls1c/Makefile
deleted file mode 100644
index 1cf3aa264d55..000000000000
--- a/arch/mips/loongson32/ls1c/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for loongson1C based machines.
-#
-
-obj-y += board.o
diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
deleted file mode 100644
index e0b0eb94077e..000000000000
--- a/arch/mips/loongson32/ls1c/board.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
- */
-
-#include <platform.h>
-
-static struct platform_device *ls1c_platform_devices[] __initdata = {
-};
-
-static int __init ls1c_platform_init(void)
-{
-	return platform_add_devices(ls1c_platform_devices,
-				   ARRAY_SIZE(ls1c_platform_devices));
-}
-
-arch_initcall(ls1c_platform_init);
-- 
2.39.2

