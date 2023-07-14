Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D5F753B04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbjGNMaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjGNMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:30:14 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322A3C1D;
        Fri, 14 Jul 2023 05:29:01 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 14 Jul 2023
 20:24:45 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <brgl@bgdev.pl>, <andy@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH V3 1/2] dt-bindings: pinctrl: Add compatibles for Amlogic C3 SoCs
Date:   Fri, 14 Jul 2023 20:24:40 +0800
Message-ID: <20230714122441.3098337-2-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230714122441.3098337-1-huqiang.qin@amlogic.com>
References: <20230714122441.3098337-1-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible name for Amlogic C3 pin controller, and add
a new dt-binding header file which document the detail pin names.

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
---

V1 -> V2:
  Unchanged.
V2 -> V3:
  Updated commit message, and compatible are sorted alphabetically.

 .../pinctrl/amlogic,meson-pinctrl-a1.yaml     |  1 +
 include/dt-bindings/gpio/amlogic-c3-gpio.h    | 72 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 include/dt-bindings/gpio/amlogic-c3-gpio.h

diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
index 99080c9eaac3..f64efa7ade08 100644
--- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
@@ -15,6 +15,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - amlogic,c3-periphs-pinctrl
       - amlogic,meson-a1-periphs-pinctrl
       - amlogic,meson-s4-periphs-pinctrl
 
diff --git a/include/dt-bindings/gpio/amlogic-c3-gpio.h b/include/dt-bindings/gpio/amlogic-c3-gpio.h
new file mode 100644
index 000000000000..75c8da6f505f
--- /dev/null
+++ b/include/dt-bindings/gpio/amlogic-c3-gpio.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
+ * Author: Huqiang Qin <huqiang.qin@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_C3_GPIO_H
+#define _DT_BINDINGS_AMLOGIC_C3_GPIO_H
+
+#define	GPIOE_0		0
+#define	GPIOE_1		1
+#define	GPIOE_2		2
+#define	GPIOE_3		3
+#define	GPIOE_4		4
+
+#define	GPIOB_0		5
+#define	GPIOB_1		6
+#define	GPIOB_2		7
+#define	GPIOB_3		8
+#define	GPIOB_4		9
+#define	GPIOB_5		10
+#define	GPIOB_6		11
+#define	GPIOB_7		12
+#define	GPIOB_8		13
+#define	GPIOB_9		14
+#define	GPIOB_10	15
+#define	GPIOB_11	16
+#define	GPIOB_12	17
+#define	GPIOB_13	18
+#define	GPIOB_14	19
+
+#define	GPIOC_0		20
+#define	GPIOC_1		21
+#define	GPIOC_2		22
+#define	GPIOC_3		23
+#define	GPIOC_4		24
+#define	GPIOC_5		25
+#define	GPIOC_6		26
+
+#define	GPIOX_0		27
+#define	GPIOX_1		28
+#define	GPIOX_2		29
+#define	GPIOX_3		30
+#define	GPIOX_4		31
+#define	GPIOX_5		32
+#define	GPIOX_6		33
+#define	GPIOX_7		34
+#define	GPIOX_8		35
+#define	GPIOX_9		36
+#define	GPIOX_10	37
+#define	GPIOX_11	38
+#define	GPIOX_12	39
+#define	GPIOX_13	40
+
+#define	GPIOD_0		41
+#define	GPIOD_1		42
+#define	GPIOD_2		43
+#define	GPIOD_3		44
+#define	GPIOD_4		45
+#define	GPIOD_5		46
+#define	GPIOD_6		47
+
+#define	GPIOA_0		48
+#define	GPIOA_1		49
+#define	GPIOA_2		50
+#define	GPIOA_3		51
+#define	GPIOA_4		52
+#define	GPIOA_5		53
+
+#define	GPIO_TEST_N	54
+
+#endif /* _DT_BINDINGS_AMLOGIC_C3_GPIO_H */
-- 
2.37.1

