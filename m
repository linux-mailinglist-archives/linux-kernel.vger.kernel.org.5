Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A757EDF56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345093AbjKPLPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345061AbjKPLPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:15:04 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867FEAA;
        Thu, 16 Nov 2023 03:15:00 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AGBElEM22392433, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AGBElEM22392433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 19:14:48 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 16 Nov 2023 19:14:48 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 16 Nov 2023 19:14:47 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Thu, 16 Nov 2023 19:14:47 +0800
From:   Tzuyi Chang <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, TY Chang <tychang@realtek.com>
Subject: [PATCH v2 1/2] dt-bindings: gpio: realtek: Add realtek,rtd-gpio
Date:   Thu, 16 Nov 2023 19:14:39 +0800
Message-ID: <20231116111441.2339-2-tychang@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116111441.2339-1-tychang@realtek.com>
References: <20231116111441.2339-1-tychang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXDAG01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree bindings for the Realtek DHC(Digital Home Center)
RTD SoCs GPIO controllers.

Signed-off-by: Tzuyi Chang <tychang@realtek.com>
---
v1 to v2 change:
    1. Add description for DHC RTD SoCs.
    2. Revise the compatible names.
    3. Add descriptions for reg and interrupts properties.
---
 .../bindings/gpio/realtek,rtd-gpio.yaml       | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml b/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
new file mode 100644
index 000000000000..11c8278801c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/realtek,rtd-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC GPIO controller
+
+maintainers:
+  - Tzuyi Chang <tychang@realtek.com>
+
+description:
+  The GPIO controller is designed for the Realtek DHC (Digital Home Center)
+  RTD SoC family, which are high-definition media processor SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - realtek,rtd1295-misc-gpio
+              - realtek,rtd1295-iso-gpio
+              - realtek,rtd1395-iso-gpio
+              - realtek,rtd1619-iso-gpio
+      - items:
+          - enum:
+              - realtek,rtd1319-iso-gpio
+              - realtek,rtd1619b-iso-gpio
+              - realtek,rtd1319d-iso-gpio
+              - realtek,rtd1315e-iso-gpio
+          - const: realtek,rtd-gpio
+
+  reg:
+    items:
+      - description: GPIO controller registers
+      - description: GPIO interrupt registers
+
+  interrupts:
+    items:
+      - description: Interrupt number of the assert GPIO interrupt, which is
+                     triggered when there is a rising edge.
+      - description: Interrupt number of the deassert GPIO interrupt, which is
+                     triggered when there is a falling edge.
+
+  gpio-ranges: true
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - gpio-ranges
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio@100 {
+      compatible = "realtek,rtd1319d-iso-gpio", "realtek,rtd-gpio";
+      reg = <0x100 0x100>,
+            <0x000 0x0b0>;
+      interrupt-parent = <&iso_irq_mux>;
+      interrupts = <19>, <20>;
+      gpio-ranges = <&pinctrl 0 0 82>;
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
-- 
2.42.0

