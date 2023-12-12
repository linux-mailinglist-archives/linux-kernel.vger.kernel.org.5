Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309B780E5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbjLLIWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346014AbjLLIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:22:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD9BE4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:22:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA240C433BB;
        Tue, 12 Dec 2023 08:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702369325;
        bh=Z4tt639XdL6asvWi7dDnieCdwJ5E4axJMvvm2VIbM3s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=RMhizo3u7A6iuqb9l93BXDRxWYfu1PLbqPURx9UPBdfIhh+5hCEpVv+bibXL0GVY3
         pdOLi3GTMmEQvdYH7At66hu19Xjtgf+G5FE65o9KHqGcdi3lNHTA4Tb+qxuAxB+fGk
         idBL7kozfMtFPpfkYeb6qA/L5/ZZDXrnnzf4vRvMOTsox04O8Uw55rLOV5RVXelHXw
         sxuOE+caUyobirXbFYMYSVIIWBwxod8NwbrVNCV+fxhaVxQJyNbLCTQkO/cAlOXMDJ
         AFJPPIub4UZUgkCq+1jwaSTa6LNDdl2yfjqVM56VaBqfOrvhQsuhc4Q8C783KCKSj2
         +epH1yQcuajPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id DA54CC4332F;
        Tue, 12 Dec 2023 08:22:04 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Tue, 12 Dec 2023 11:20:24 +0300
Subject: [PATCH v6 07/40] dt-bindings: soc: Add Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-ep93xx-v6-7-c307b8ac9aa8@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
In-Reply-To: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702369322; l=6021;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=MefvB3Int8nvp/lbfuIcYab5bRur5FE4KLgksenTtyA=; =?utf-8?q?b=3DlCxjFWTuhAzV?=
 =?utf-8?q?pwN3y6Sj+pjfOmxs+1yhJmihY+Da/FwGD5OTRwiJRKchcXo0n1JstAQgDYqWalGX?=
 FLX6L0X4DSwe1ggm23IDzIYW8aSrIi+tZRRw9oHzhHKBRylCtreG
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add device tree bindings for the Cirrus Logic EP93xx SoC.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/arm/cirrus/cirrus,ep9301.yaml         | 38 +++++++++
 .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  | 94 ++++++++++++++++++++++
 include/dt-bindings/clock/cirrus,ep9301-syscon.h   | 46 +++++++++++
 3 files changed, 178 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml b/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml
new file mode 100644
index 000000000000..170aad5dd7ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/cirrus/cirrus,ep9301.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP93xx platforms
+
+description:
+  The EP93xx SoC is a ARMv4T-based with 200 MHz ARM9 CPU.
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: The TS-7250 is a compact, full-featured Single Board
+          Computer (SBC) based upon the Cirrus EP9302 ARM9 CPU
+        items:
+          - const: technologic,ts7250
+          - const: cirrus,ep9301
+
+      - description: The Liebherr BK3 is a derivate from ts7250 board
+        items:
+          - const: liebherr,bk3
+          - const: cirrus,ep9301
+
+      - description: EDB302 is an evaluation board by Cirrus Logic,
+          based on a Cirrus Logic EP9302 CPU
+        items:
+          - const: cirrus,edb9302
+          - const: cirrus,ep9301
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml b/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml
new file mode 100644
index 000000000000..7cb1b4114985
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/cirrus/cirrus,ep9301-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP93xx Platforms System Controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+description: |
+  Central resources are controlled by a set of software-locked registers,
+  which can be used to prevent accidental accesses. Syscon generates
+  the various bus and peripheral clocks and controls the system startup
+  configuration.
+
+  The System Controller (Syscon) provides:
+  - Clock control
+  - Power management
+  - System configuration management
+
+  Syscon registers are common for all EP93xx SoC's, through some actual peripheral
+  may be missing depending on actual SoC model.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - cirrus,ep9302-syscon
+              - cirrus,ep9307-syscon
+              - cirrus,ep9312-syscon
+              - cirrus,ep9315-syscon
+          - const: cirrus,ep9301-syscon
+          - const: syscon
+      - items:
+          - const: cirrus,ep9301-syscon
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    items:
+      - description: reference clock
+
+patternProperties:
+  '^pins-':
+    type: object
+    description: pin node
+    $ref: /schemas/pinctrl/pinmux-node.yaml
+
+    properties:
+      function:
+        enum: [ spi, ac97, i2s, pwm, keypad, pata, lcd, gpio ]
+
+      groups:
+        enum: [ ssp, ac97, i2s_on_ssp, i2s_on_ac97, pwm1, gpio1agrp,
+                gpio2agrp, gpio3agrp, gpio4agrp, gpio6agrp, gpio7agrp,
+                rasteronsdram0grp, rasteronsdram3grp, keypadgrp, idegrp ]
+
+    required:
+      - function
+      - groups
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@80930000 {
+      compatible = "cirrus,ep9301-syscon", "syscon";
+      reg = <0x80930000 0x1000>;
+
+      #clock-cells = <1>;
+      clocks = <&xtali>;
+
+      spi_default_pins: pins-spi {
+        function = "spi";
+        groups = "ssp";
+      };
+    };
diff --git a/include/dt-bindings/clock/cirrus,ep9301-syscon.h b/include/dt-bindings/clock/cirrus,ep9301-syscon.h
new file mode 100644
index 000000000000..6bb8f532e7d0
--- /dev/null
+++ b/include/dt-bindings/clock/cirrus,ep9301-syscon.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+#ifndef DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
+#define DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
+
+#define EP93XX_CLK_PLL1		0
+#define EP93XX_CLK_PLL2		1
+
+#define EP93XX_CLK_FCLK		2
+#define EP93XX_CLK_HCLK		3
+#define EP93XX_CLK_PCLK		4
+
+#define EP93XX_CLK_UART		5
+#define EP93XX_CLK_SPI		6
+#define EP93XX_CLK_PWM		7
+#define EP93XX_CLK_USB		8
+
+#define EP93XX_CLK_M2M0		9
+#define EP93XX_CLK_M2M1		10
+
+#define EP93XX_CLK_M2P0		11
+#define EP93XX_CLK_M2P1		12
+#define EP93XX_CLK_M2P2		13
+#define EP93XX_CLK_M2P3		14
+#define EP93XX_CLK_M2P4		15
+#define EP93XX_CLK_M2P5		16
+#define EP93XX_CLK_M2P6		17
+#define EP93XX_CLK_M2P7		18
+#define EP93XX_CLK_M2P8		19
+#define EP93XX_CLK_M2P9		20
+
+#define EP93XX_CLK_UART1	21
+#define EP93XX_CLK_UART2	22
+#define EP93XX_CLK_UART3	23
+
+#define EP93XX_CLK_ADC		24
+#define EP93XX_CLK_ADC_EN	25
+
+#define EP93XX_CLK_KEYPAD	26
+
+#define EP93XX_CLK_VIDEO	27
+
+#define EP93XX_CLK_I2S_MCLK	28
+#define EP93XX_CLK_I2S_SCLK	29
+#define EP93XX_CLK_I2S_LRCLK	30
+
+#endif /* DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H */

-- 
2.41.0

