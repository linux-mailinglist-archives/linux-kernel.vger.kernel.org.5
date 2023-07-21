Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EA175BFCF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGUHe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGUHew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:34:52 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD122710;
        Fri, 21 Jul 2023 00:34:50 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 21 Jul 2023
 15:34:32 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH 2/3] pinctrl: Replace the IRQ number in the driver with the IRQID macro definition
Date:   Fri, 21 Jul 2023 15:32:13 +0800
Message-ID: <20230721073214.1876417-3-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
References: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing IRQ numbers with IRQID macro definitions makes driver code
easier to understand.

Associated platforms:
- Amlogic Meson-G12A
- Amlogic Meson-G12B
- Amlogic Meson-SM1

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
---
 drivers/pinctrl/meson/pinctrl-meson-g12a.c | 35 +++++++++++-----------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index d182a575981e..25d2b8fe89e9 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -8,6 +8,7 @@
  */
 
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/interrupt-controller/irq-meson-g12a-gpio.h>
 #include "pinctrl-meson.h"
 #include "pinctrl-meson-axg-pmx.h"
 
@@ -1318,31 +1319,31 @@ static struct meson_pmx_func meson_g12a_aobus_functions[] = {
 
 static struct meson_bank meson_g12a_periphs_banks[] = {
 	/* name  first  last  irq  pullen  pull  dir  out  in  ds */
-	BANK_DS("Z",    GPIOZ_0,    GPIOZ_15, 12, 27,
-		4,  0,  4,  0,  12,  0,  13, 0,  14, 0, 5, 0),
-	BANK_DS("H",    GPIOH_0,    GPIOH_8, 28, 36,
-		3,  0,  3,  0,  9,  0,  10,  0,  11,  0, 4, 0),
-	BANK_DS("BOOT", BOOT_0,     BOOT_15,  37, 52,
-		0,  0,  0,  0,  0, 0,  1, 0,  2, 0, 0, 0),
-	BANK_DS("C",    GPIOC_0,    GPIOC_7,  53, 60,
-		1,  0,  1,  0,  3, 0,  4, 0,  5, 0, 1, 0),
-	BANK_DS("A",    GPIOA_0,    GPIOA_15,  61, 76,
-		5,  0,  5,  0,  16,  0,  17,  0,  18,  0, 6, 0),
-	BANK_DS("X",    GPIOX_0,    GPIOX_19,   77, 96,
-		2,  0,  2,  0,  6,  0,  7,  0,  8,  0, 2, 0),
+	BANK_DS("Z",    GPIOZ_0,  GPIOZ_15,  IRQID_GPIOZ_0,  IRQID_GPIOZ_15,
+		4,  0,  4,  0,  12,  0, 13,  0,  14,  0,  5, 0),
+	BANK_DS("H",    GPIOH_0,  GPIOH_8,   IRQID_GPIOH_0,  IRQID_GPIOH_8,
+		3,  0,  3,  0,   9,  0, 10,  0,  11,  0,  4, 0),
+	BANK_DS("BOOT", BOOT_0,   BOOT_15,   IRQID_BOOT_0,   IRQID_BOOT_15,
+		0,  0,  0,  0,   0,  0,  1,  0,   2,  0,  0, 0),
+	BANK_DS("C",    GPIOC_0,  GPIOC_7,   IRQID_GPIOC_0,  IRQID_GPIOC_7,
+		1,  0,  1,  0,   3,  0,  4,  0,   5,  0,  1, 0),
+	BANK_DS("A",    GPIOA_0,  GPIOA_15,  IRQID_GPIOA_0,  IRQID_GPIOA_15,
+		5,  0,  5,  0,  16,  0, 17,  0,  18,  0,  6, 0),
+	BANK_DS("X",    GPIOX_0,  GPIOX_19,  IRQID_GPIOX_0,  IRQID_GPIOX_19,
+		2,  0,  2,  0,   6,  0,  7,  0,   8,  0,  2, 0),
 };
 
 static struct meson_bank meson_g12a_aobus_banks[] = {
 	/* name  first  last  irq  pullen  pull  dir  out  in  ds */
-	BANK_DS("AO", GPIOAO_0, GPIOAO_11, 0, 11, 3, 0, 2, 0, 0, 0, 4, 0, 1, 0,
-		0, 0),
+	BANK_DS("AO",   GPIOAO_0, GPIOAO_11, IRQID_GPIOAO_0, IRQID_GPIOAO_11,
+		3,  0,  2,  0,   0,  0,  4,  0,   1,  0,  0, 0),
 	/* GPIOE actually located in the AO bank */
-	BANK_DS("E", GPIOE_0, GPIOE_2, 97, 99, 3, 16, 2, 16, 0, 16, 4, 16, 1,
-		16, 1, 0),
+	BANK_DS("E",    GPIOE_0,  GPIOE_2,   IRQID_GPIOE_0,  IRQID_GPIOE_2,
+		3, 16,  2, 16,   0, 16,  4, 16,   1, 16,  1, 0),
 };
 
 static struct meson_pmx_bank meson_g12a_periphs_pmx_banks[] = {
-	/*	 name	 first		lask	   reg	offset  */
+	/*	 name	 first	  last	    reg	 offset  */
 	BANK_PMX("Z",    GPIOZ_0, GPIOZ_15, 0x6, 0),
 	BANK_PMX("H",    GPIOH_0, GPIOH_8,  0xb, 0),
 	BANK_PMX("BOOT", BOOT_0,  BOOT_15,  0x0, 0),
-- 
2.37.1

