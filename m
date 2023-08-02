Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A1976D214
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjHBPeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjHBPd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:33:58 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D061BFD;
        Wed,  2 Aug 2023 08:33:55 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372FXhNL026515;
        Wed, 2 Aug 2023 10:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690990423;
        bh=D6RZBQlGpQ6aANeAtkpG01RL2+OkiYDOK6fsE47v/fo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ghZCnVXm6Gpcc4kgX8XfvrMbZUoJTeF0zkJwD0HWJL3iIGk7S1XUAOBbyn0g43Iy7
         tx852APIKy5d9ZEG3d0GrAPvq6NrgOSoT8wqJkYR/4+d8SynJ96ZcRgNMbzzVgU2Vj
         sbOKVqIT3AY1XARF/Dw0nVqK1Jt+twRaqoQDLyHo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372FXhh8012798
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 10:33:43 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 10:33:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 10:33:41 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372FXYq7072743;
        Wed, 2 Aug 2023 10:33:41 -0500
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v8 9/9] ARM: nspire: Remove unused header file mmio.h
Date:   Wed, 2 Aug 2023 10:33:33 -0500
Message-ID: <20230802153333.55546-10-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802153333.55546-1-afd@ti.com>
References: <20230802153333.55546-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nspire boardfile platform drivers have all been converted. None
of the definitions in this header are used anymore. Remove it.

While here lets remove all the other unused headers and the file
name from in the file itself.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-nspire/mmio.h   | 13 -------------
 arch/arm/mach-nspire/nspire.c | 14 --------------
 2 files changed, 27 deletions(-)
 delete mode 100644 arch/arm/mach-nspire/mmio.h

diff --git a/arch/arm/mach-nspire/mmio.h b/arch/arm/mach-nspire/mmio.h
deleted file mode 100644
index 2ce0656139ece..0000000000000
--- a/arch/arm/mach-nspire/mmio.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *	linux/arch/arm/mach-nspire/mmio.h
- *
- *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
- */
-
-#define NSPIRE_PWR_PHYS_BASE		0x900B0000
-#define NSPIRE_PWR_VIRT_BASE		0xFEEB0000
-#define NSPIRE_PWR_BUS_DISABLE1		0x18
-#define NSPIRE_PWR_BUS_DISABLE2		0x20
-
-#define NSPIRE_LCD_PHYS_BASE		0xC0000000
diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 1e13337972dd5..2fbfc23237ffe 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -1,23 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *	linux/arch/arm/mach-nspire/nspire.c
- *
  *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
-#include <linux/init.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/arm-vic.h>
-#include <linux/clkdev.h>
-#include <linux/amba/bus.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-#include <asm/mach/map.h>
-
-#include "mmio.h"
 
 static const char *const nspire_dt_match[] __initconst = {
 	"ti,nspire",
-- 
2.39.2

