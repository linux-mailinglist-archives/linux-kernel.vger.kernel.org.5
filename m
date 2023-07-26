Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E7A7636CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjGZMwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGZMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:52:10 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0C32707;
        Wed, 26 Jul 2023 05:51:46 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3466725f0beso36854845ab.1;
        Wed, 26 Jul 2023 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690375905; x=1690980705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJrF1Hh7lu0hPyCNrpWc3D5E3pFxpQWmLpBPm0aJvj4=;
        b=VQx17tzlsvEGVL3xz4mVzvlJ7MBBdSdSQNEt6JjqX4PFiNmVGJL74ZepryuDwV1kNC
         JJ5lnRet7VcJthW4cggwSJq9Q+NseC5efDTGS76oVsaAMF84hphdN7zryqyRWAMCTupv
         x90mpm9BLBJYkErVPCpZodHLd0t8aoqaH8lamm5xTSv4C7lj7jBjA80XungnnCdIMSoL
         QLJbA3pod6GLSTzZht0d9URLBKTNwACRa+o2GmC1bHbO+EjQkNQAlYSqfun8Dlo2AwYV
         9GiJTN4s6P6z8Fv4bIkI0PX2WBWn72eHVRRLK2PbnRFYRTsa66eqgfr/sysNfPz+UMbR
         6Epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690375905; x=1690980705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJrF1Hh7lu0hPyCNrpWc3D5E3pFxpQWmLpBPm0aJvj4=;
        b=O9eOeTBWu2judfciOafJdM78gzd7WtT5lEmW53Gf7weixaBxneUv3FW4il7IkGTpcy
         v6qoqR3NjGiY7n+3BK7nuYDIgJAP7+WXNZ5hxLCUgc+oetkql+yPxJlmPySoSCCXxcRz
         S8mUhjvwXEIZDey4Xr/Of0gSv1hCySvCAJ9luNt1qESW9jZRJhNvbLAYO471Ey3hEydA
         QDm3jeDGKRfIGBOotFDXQR8IdS5zysRo3fGABgopGYKBwnfdHGBfgq4J3EaUMEE5eeDc
         qgpwFUgjbnwXjzCdB45Ha9VGYYMV6L2Xrvb1QqO73KYPRkUTfq0XX7n1oEXu8HuT9Hh4
         KsQw==
X-Gm-Message-State: ABy/qLbbjJcxkA2Fh/yZQ6weEo8mLO3dUHeVRHukw2rMTN0qWMrhvL3I
        VO2FiIIkoR3UHMBNVlzcFzCvhkFVWzY=
X-Google-Smtp-Source: APBJJlGnwQo1WT+7PwOQCSAQRtaRWMu0VYi3YHUgBLvIZkpSlB335++4nKD569XONeODTI5DOuEcsA==
X-Received: by 2002:a05:6e02:13c7:b0:348:8da5:879f with SMTP id v7-20020a056e0213c700b003488da5879fmr1650328ilj.27.1690375905052;
        Wed, 26 Jul 2023 05:51:45 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id u4-20020a02cb84000000b0042afd174c62sm4161593jap.99.2023.07.26.05.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:51:44 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 2/2] MIPS: loongson32: Remove regs-rtc.h
Date:   Wed, 26 Jul 2023 20:51:31 +0800
Message-Id: <20230726125131.462257-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230726125131.462257-1-keguang.zhang@gmail.com>
References: <20230726125131.462257-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since commit 35508d242409 ("MIPS: loongson32: ls1c: Fix hang
during startup"), no one is calling ls1x_rtc_set_extclk().
Therefore, remove this obsolete function.

Since commit 9fb23090658a ("rtc: Remove the Loongson-1
RTC driver"), no one is using regs-rtc.h.
Therefore, remove this obsolete header file.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: fix the build error of "‘LS1X_RTC_CTRL’ undeclared"

 .../include/asm/mach-loongson32/loongson1.h   |  1 -
 .../include/asm/mach-loongson32/regs-rtc.h    | 19 -------------------
 arch/mips/loongson32/common/platform.c        |  8 --------
 3 files changed, 28 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index bc27fcee3176..84f45461c832 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -46,6 +46,5 @@
 #define LS1X_CLK_BASE			0x1fe78030
 
 #include <regs-mux.h>
-#include <regs-rtc.h>
 
 #endif /* __ASM_MACH_LOONGSON32_LOONGSON1_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-rtc.h b/arch/mips/include/asm/mach-loongson32/regs-rtc.h
deleted file mode 100644
index a3d096be1607..000000000000
--- a/arch/mips/include/asm/mach-loongson32/regs-rtc.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
- *
- * Loongson 1 RTC timer Register Definitions.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_REGS_RTC_H
-#define __ASM_MACH_LOONGSON32_REGS_RTC_H
-
-#define LS1X_RTC_REG(x) \
-		((void __iomem *)KSEG1ADDR(LS1X_RTC_BASE + (x)))
-
-#define LS1X_RTC_CTRL	LS1X_RTC_REG(0x40)
-
-#define RTC_EXTCLK_OK	(BIT(5) | BIT(8))
-#define RTC_EXTCLK_EN	BIT(8)
-
-#endif /* __ASM_MACH_LOONGSON32_REGS_RTC_H */
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 64d7979394e6..8075590a9f83 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -265,14 +265,6 @@ struct platform_device ls1x_ehci_pdev = {
 };
 
 /* Real Time Clock */
-void __init ls1x_rtc_set_extclk(struct platform_device *pdev)
-{
-	u32 val = __raw_readl(LS1X_RTC_CTRL);
-
-	if (!(val & RTC_EXTCLK_OK))
-		__raw_writel(val | RTC_EXTCLK_EN, LS1X_RTC_CTRL);
-}
-
 struct platform_device ls1x_rtc_pdev = {
 	.name		= "ls1x-rtc",
 	.id		= -1,
-- 
2.39.2

