Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427CF7636CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjGZMwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjGZMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:52:10 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77FA1FEC;
        Wed, 26 Jul 2023 05:51:43 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7835ae70e46so260662639f.3;
        Wed, 26 Jul 2023 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690375903; x=1690980703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K08HZ0wP88kJ24DUN04rOEiQl67m2taT/uDkslecpyg=;
        b=RE2/N6Oanps2a6G1w3dhAJFVD5rSAIq+7w3QrykrDSlapizV1qPc7+YfHTQb1BPkI/
         8nXcTpxXL5lnotnaXxoHfwXyoghQqskV8M7O7WOfiQfYeYiLEJAfERojSMxOsyc7Nve4
         M/KUXtE4SXQj0D9wlDZuJSIs8ftd7hMMj7Q76AhmEBuJ7bOOFETNs1LG+KBuXvDXgvEy
         uo17HtmDwm7EGIHQriTbJ9exoTw/b2ulhDCMgQ27TdXb+EuYmVw1YQ/S111ugLuTb0Yk
         WGhGgAphQGvzIPyMdHd4Vyn98xqUaJ/ilJ2i/bEp+i+O0oZ6sMK2kHdcdDtYOOvDjvYh
         1y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690375903; x=1690980703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K08HZ0wP88kJ24DUN04rOEiQl67m2taT/uDkslecpyg=;
        b=bpzYvfIjT8uFBlGi0xPyO2Voc4MNvGHEo4pWhTWYAXhzAL3anqzx5wUyEVI3uWgOIg
         4U0Ae6nzWcGJx1bJf5Dfr6AdPFHyCaftiDd2g5dkOsvCamDMrJIJPhzIxCtBjSb+Cww5
         onrq9iYXIOToLAKXihR9/6KSeoRbxfB3DscTZzBwRl27bDlnT6MIr22QwSsMaIQb5D/X
         0+4A0wy65tTRrLcvmQBAGPbMb5KbbTMPVBfyFILIKUv0XHbHI5aAXVEClnkrE+YUuDDH
         Kr6UHP6yLSc8OIGC6e1SUhHcUsiha0bk6+KfE6pv/YYJ2D5Q9kk8jKr+s7xwnMY8981e
         rmrg==
X-Gm-Message-State: ABy/qLZwy9UHZfuTum+FdjXYoc+2wZFvjvg5+F7u7bJpH+bXOtcVqoGA
        Uz/LW2fGeUBngSxjgYWNHT/kdqEBEFE=
X-Google-Smtp-Source: APBJJlFAxTPYBCLpS7DmOYpcgxfrwUjhMLi2naO5VPNJC755Vko/VJLxkXSXpVKOb6k6gJ/SqdY4sA==
X-Received: by 2002:a5d:8a11:0:b0:787:8cf:fd8e with SMTP id w17-20020a5d8a11000000b0078708cffd8emr1981416iod.11.1690375902915;
        Wed, 26 Jul 2023 05:51:42 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id u4-20020a02cb84000000b0042afd174c62sm4161593jap.99.2023.07.26.05.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:51:42 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 1/2] MIPS: loongson32: Remove regs-clk.h
Date:   Wed, 26 Jul 2023 20:51:30 +0800
Message-Id: <20230726125131.462257-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230726125131.462257-1-keguang.zhang@gmail.com>
References: <20230726125131.462257-1-keguang.zhang@gmail.com>
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

Since commit c46496119ed0 ("clk: loongson1: Remove
the outdated driver"), no one is using regs-clk.h.
Therefore, remove this obsolete header file.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: None

 .../include/asm/mach-loongson32/loongson1.h   |  1 -
 .../include/asm/mach-loongson32/regs-clk.h    | 81 -------------------
 2 files changed, 82 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-clk.h

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 7971272345d3..bc27fcee3176 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -45,7 +45,6 @@
 #define LS1X_NAND_BASE			0x1fe78000
 #define LS1X_CLK_BASE			0x1fe78030
 
-#include <regs-clk.h>
 #include <regs-mux.h>
 #include <regs-rtc.h>
 
diff --git a/arch/mips/include/asm/mach-loongson32/regs-clk.h b/arch/mips/include/asm/mach-loongson32/regs-clk.h
deleted file mode 100644
index 98136fa8bee1..000000000000
--- a/arch/mips/include/asm/mach-loongson32/regs-clk.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 Clock Register Definitions.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_REGS_CLK_H
-#define __ASM_MACH_LOONGSON32_REGS_CLK_H
-
-#define LS1X_CLK_REG(x) \
-		((void __iomem *)KSEG1ADDR(LS1X_CLK_BASE + (x)))
-
-#define LS1X_CLK_PLL_FREQ		LS1X_CLK_REG(0x0)
-#define LS1X_CLK_PLL_DIV		LS1X_CLK_REG(0x4)
-
-#if defined(CONFIG_LOONGSON1_LS1B)
-/* Clock PLL Divisor Register Bits */
-#define DIV_DC_EN			BIT(31)
-#define DIV_DC_RST			BIT(30)
-#define DIV_CPU_EN			BIT(25)
-#define DIV_CPU_RST			BIT(24)
-#define DIV_DDR_EN			BIT(19)
-#define DIV_DDR_RST			BIT(18)
-#define RST_DC_EN			BIT(5)
-#define RST_DC				BIT(4)
-#define RST_DDR_EN			BIT(3)
-#define RST_DDR				BIT(2)
-#define RST_CPU_EN			BIT(1)
-#define RST_CPU				BIT(0)
-
-#define DIV_DC_SHIFT			26
-#define DIV_CPU_SHIFT			20
-#define DIV_DDR_SHIFT			14
-
-#define DIV_DC_WIDTH			4
-#define DIV_CPU_WIDTH			4
-#define DIV_DDR_WIDTH			4
-
-#define BYPASS_DC_SHIFT			12
-#define BYPASS_DDR_SHIFT		10
-#define BYPASS_CPU_SHIFT		8
-
-#define BYPASS_DC_WIDTH			1
-#define BYPASS_DDR_WIDTH		1
-#define BYPASS_CPU_WIDTH		1
-
-#elif defined(CONFIG_LOONGSON1_LS1C)
-/* PLL/SDRAM Frequency configuration register Bits */
-#define PLL_VALID			BIT(31)
-#define FRAC_N				GENMASK(23, 16)
-#define RST_TIME			GENMASK(3, 2)
-#define SDRAM_DIV			GENMASK(1, 0)
-
-/* CPU/CAMERA/DC Frequency configuration register Bits */
-#define DIV_DC_EN			BIT(31)
-#define DIV_DC				GENMASK(30, 24)
-#define DIV_CAM_EN			BIT(23)
-#define DIV_CAM				GENMASK(22, 16)
-#define DIV_CPU_EN			BIT(15)
-#define DIV_CPU				GENMASK(14, 8)
-#define DIV_DC_SEL_EN			BIT(5)
-#define DIV_DC_SEL			BIT(4)
-#define DIV_CAM_SEL_EN			BIT(3)
-#define DIV_CAM_SEL			BIT(2)
-#define DIV_CPU_SEL_EN			BIT(1)
-#define DIV_CPU_SEL			BIT(0)
-
-#define DIV_DC_SHIFT			24
-#define DIV_CAM_SHIFT			16
-#define DIV_CPU_SHIFT			8
-#define DIV_DDR_SHIFT			0
-
-#define DIV_DC_WIDTH			7
-#define DIV_CAM_WIDTH			7
-#define DIV_CPU_WIDTH			7
-#define DIV_DDR_WIDTH			2
-
-#endif
-
-#endif /* __ASM_MACH_LOONGSON32_REGS_CLK_H */
-- 
2.39.2

