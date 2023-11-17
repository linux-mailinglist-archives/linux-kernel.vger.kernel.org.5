Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24087EF629
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjKQQ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjKQQ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:28:20 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2F7196;
        Fri, 17 Nov 2023 08:28:15 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AHGRxPrA3225388, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AHGRxPrA3225388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Nov 2023 00:27:59 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 18 Nov 2023 00:28:00 +0800
Received: from james-bs01.realtek.com.tw (172.21.190.247) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 18 Nov 2023 00:27:59 +0800
From:   James Tai <james.tai@realtek.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        James Tai <james.tai@realtek.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
Date:   Sat, 18 Nov 2023 00:27:04 +0800
Message-ID: <20231117162709.1096585-2-james.tai@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117162709.1096585-1-james.tai@realtek.com>
References: <20231117162709.1096585-1-james.tai@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.190.247]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the YAML documentation for Realtek DHC SoCs.

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Marc Zyngier <maz@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: linux-kernel@vger.kernel.org
CC: devicetree@vger.kernel.org
Signed-off-by: James Tai <james.tai@realtek.com>
---
v1 to v2 change:
- Tested the bindings using 'make dt_binding_check'
- Fixed code style issues

 .../realtek,rtd1319-intc.yaml                 | 79 +++++++++++++++++++
 .../realtek,rtd1319d-intc.yaml                | 79 +++++++++++++++++++
 .../realtek,rtd1325-intc.yaml                 | 79 +++++++++++++++++++
 .../realtek,rtd1619b-intc.yaml                | 78 ++++++++++++++++++
 4 files changed, 315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319d-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1325-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1619b-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319-intc.yaml
new file mode 100644
index 000000000000..b88f3ac07cd9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319-intc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/realtek,rtd1319-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC RTD1319 Interrupt Controller Device Tree Bindings
+
+description:
+  This interrupt controller is a component of Realtek DHC RTD1319 and
+  is designed to receive interrupts from peripheral devices.
+
+  Each DHC SoC has two sets of interrupt controllers, each capable of
+  handling up to 32 interrupts.
+
+maintainers:
+  - James Tai <james.tai@realtek.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  "#interrupt-cells":
+    const: 1
+
+  compatible:
+    enum:
+      - realtek,rtd1319-intc-iso
+      - realtek,rtd1319-intc-misc
+
+  "#address-cells":
+    const: 0
+
+  interrupt-controller: true
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4
+
+  reg:
+    maxItems: 1
+
+required:
+  - "#interrupt-cells"
+  - "#address-cells"
+  - compatible
+  - interrupt-controller
+  - interrupts-extended
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    rtd1319_iso_irq: interrupt-controller@40 {
+      compatible = "realtek,rtd1319-intc-iso";
+      reg = <0x00 0x40>;
+      interrupts-extended = <&gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+
+    rtd1319_misc_irq: interrupt-controller@80 {
+      compatible = "realtek,rtd1319-intc-misc";
+      reg = <0x00 0x80>;
+      interrupts-extended = <&gic GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319d-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319d-intc.yaml
new file mode 100644
index 000000000000..75aba448baf7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319d-intc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/realtek,rtd1319d-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC RTD1319D Interrupt Controller Device Tree Bindings
+
+description:
+  This interrupt controller is a component of Realtek DHC RTD1319D and
+  is designed to receive interrupts from peripheral devices.
+
+  Each DHC SoC has two sets of interrupt controllers, each capable of
+  handling up to 32 interrupts.
+
+maintainers:
+  - James Tai <james.tai@realtek.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  "#interrupt-cells":
+    const: 1
+
+  compatible:
+    enum:
+      - realtek,rtd1319d-intc-iso
+      - realtek,rtd1319d-intc-misc
+
+  "#address-cells":
+    const: 0
+
+  interrupt-controller: true
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4
+
+  reg:
+    maxItems: 1
+
+required:
+  - "#interrupt-cells"
+  - "#address-cells"
+  - compatible
+  - interrupt-controller
+  - interrupts-extended
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    rtd1319d_iso_irq: interrupt-controller@40 {
+      compatible = "realtek,rtd1319d-intc-iso";
+      reg = <0x00 0x40>;
+      interrupts-extended = <&gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+
+    rtd1319d_misc_irq: interrupt-controller@80 {
+      compatible = "realtek,rtd1319d-intc-misc";
+      reg = <0x00 0x80>;
+      interrupts-extended = <&gic GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1325-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1325-intc.yaml
new file mode 100644
index 000000000000..49e71d17390a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1325-intc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/realtek,rtd1325-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC RTD1325 Interrupt Controller Device Tree Bindings
+
+description:
+  This interrupt controller is a component of Realtek DHC RTD1325 and
+  is designed to receive interrupts from peripheral devices.
+
+  Each DHC SoC has two sets of interrupt controllers, each capable of
+  handling up to 32 interrupts.
+
+maintainers:
+  - James Tai <james.tai@realtek.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  "#interrupt-cells":
+    const: 1
+
+  compatible:
+    enum:
+      - realtek,rtd1325-intc-iso
+      - realtek,rtd1325-intc-misc
+
+  "#address-cells":
+    const: 0
+
+  interrupt-controller: true
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4
+
+  reg:
+    maxItems: 1
+
+required:
+  - "#interrupt-cells"
+  - "#address-cells"
+  - compatible
+  - interrupt-controller
+  - interrupts-extended
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    rtd1325_iso_irq: interrupt-controller@40 {
+      compatible = "realtek,rtd1325-intc-iso";
+      reg = <0x00 0x40>;
+      interrupts-extended = <&gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+
+    rtd1325_misc_irq: interrupt-controller@80 {
+      compatible = "realtek,rtd1325-intc-misc";
+      reg = <0x00 0x80>;
+      interrupts-extended = <&gic GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1619b-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1619b-intc.yaml
new file mode 100644
index 000000000000..79d855d15893
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1619b-intc.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/realtek,rtd1619b-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC RTD1619B Interrupt Controller Device Tree Bindings
+
+description:
+  This interrupt controller is a component of Realtek DHC RTD1619B and
+  is designed to receive interrupts from peripheral devices.
+
+  Each DHC SoC has two sets of interrupt controllers, each capable of
+  handling up to 32 interrupts.
+
+maintainers:
+  - James Tai <james.tai@realtek.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  "#interrupt-cells":
+    const: 1
+
+  compatible:
+    enum:
+      - realtek,rtd1619b-intc-iso
+      - realtek,rtd1619b-intc-misc
+
+  "#address-cells":
+    const: 0
+
+  interrupt-controller: true
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4
+
+  reg:
+    maxItems: 1
+
+required:
+  - "#interrupt-cells"
+  - "#address-cells"
+  - compatible
+  - interrupt-controller
+  - interrupts-extended
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    rtd1619b_iso_irq: interrupt-controller@40 {
+      compatible = "realtek,rtd1619b-intc-iso";
+      reg = <0x00 0x40>;
+      interrupts-extended = <&gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+
+    rtd1619b_misc_irq: interrupt-controller@80 {
+      compatible = "realtek,rtd1619b-intc-misc";
+      reg = <0x00 0x80>;
+      interrupts-extended = <&gic GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+...
-- 
2.25.1

