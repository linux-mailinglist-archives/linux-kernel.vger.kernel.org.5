Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0E27DF508
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjKBOaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjKBO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:29:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE695D44
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:29:25 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A2ERWwfC3062438, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A2ERWwfC3062438
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Nov 2023 22:27:32 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Nov 2023 22:27:32 +0800
Received: from james-bs01.realtek.com.tw (172.21.190.247) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 2 Nov 2023 22:27:32 +0800
From:   James Tai <james.tai@realtek.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-realtek-soc@lists.infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: [PATCH 1/6] dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
Date:   Thu, 2 Nov 2023 22:27:26 +0800
Message-ID: <20231102142731.2087245-2-james.tai@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102142731.2087245-1-james.tai@realtek.com>
References: <20231102142731.2087245-1-james.tai@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.190.247]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: license violation
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the YAML documentation for Realtek DHC SoCs.

Change-Id: Ia619582e34fef6b2dbd5f98ba3f5edf70cf11dbf
Signed-off-by: James Tai <james.tai@realtek.com>
---
 .../interrupt-controller/realtek,intc.yaml    | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml
new file mode 100644
index 000000000000..cf063dcdd0b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/realtek,intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC SoCs Interrupt Controller Device Tree Bindings
+
+description:
+  This interrupt controller is a component of Realtek DHC SoCs and
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
+      - realtek,rtd1319d-intc-iso
+      - realtek,rtd1319d-intc-misc
+      - realtek,rtd1325-intc-iso
+      - realtek,rtd1325-intc-misc
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
+    iso_irq_mux: iso_irq_mux@40 {
+      compatible = "realtek,rtd1319-intc-iso";
+      reg = <0x00 0x40>;
+      interrupts-extended = <&gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+
+    misc_irq_mux: misc_irq_mux@80 {
+      compatible = "realtek,rtd1319-intc-misc";
+      reg = <0x00 0x80>;
+      interrupts-extended = <&gic GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+
+    iso_irq_mux: iso_irq_mux@40 {
+      compatible = "realtek,rtd1319d-intc-iso";
+      reg = <0x00 0x40>;
+      interrupts-extended = <&gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+
+    misc_irq_mux: misc_irq_mux@80 {
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
+
+    iso_irq_mux: iso_irq_mux@40 {
+      compatible = "realtek,rtd1325-intc-iso";
+      reg = <0x00 0x40>;
+      interrupts-extended = <&gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+
+    misc_irq_mux: misc_irq_mux@80 {
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
+
+    iso_irq_mux: iso_irq_mux@40 {
+      compatible = "realtek,rtd1619b-intc-iso";
+      reg = <0x00 0x40>;
+      interrupts-extended = <&gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+
+    misc_irq_mux: misc_irq_mux@80 {
+      compatible = "realtek,rtd1619b-intc-misc";
+      reg = <0x00 0x80>;
+      interrupts-extended = <&gic GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+                            <&gic GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+...
-- 
2.25.1

