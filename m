Return-Path: <linux-kernel+bounces-12439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0474481F4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0598E1C21B73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD273FDD;
	Thu, 28 Dec 2023 06:09:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F29423A2;
	Thu, 28 Dec 2023 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BS690Dl81766919, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BS690Dl81766919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 14:09:00 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 28 Dec 2023 14:09:01 +0800
Received: from james-bs01.realtek.com.tw (172.21.190.247) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 14:09:00 +0800
From: James Tai <james.tai@realtek.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, James Tai <james.tai@realtek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/6] dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
Date: Thu, 28 Dec 2023 14:08:20 +0800
Message-ID: <20231228060825.1380439-2-james.tai@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231228060825.1380439-1-james.tai@realtek.com>
References: <20231228060825.1380439-1-james.tai@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add the YAML documentation for Realtek DHC (Digital Home Center) SoCs.

Signed-off-by: James Tai <james.tai@realtek.com>
---
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Marc Zyngier <maz@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: linux-kernel@vger.kernel.org
CC: devicetree@vger.kernel.org

v3 to v4 change:
- Adjusted the allOf block to add constraints on the interrupts per variant

v2 to v3 change:
- Retested the bindings using the new version of the dtschema
- Fixed the order of property items
- Removed redundant files and replaced them with 'realtek,intc.yaml'
- Replaced 'interrupts-extended' with 'interrupts'
- Added a description for 'interrupts'
- Reduced the example code

v1 to v2 change:
- Tested the bindings using 'make dt_binding_check'
- Fixed code style issues

 .../interrupt-controller/realtek,intc.yaml    | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml
new file mode 100644
index 000000000000..d3e4919850cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/realtek,intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC SoCs Interrupt Controller
+
+maintainers:
+  - James Tai <james.tai@realtek.com>
+
+description:
+  This interrupt controller is a component of Realtek DHC (Digital Home Center)
+  SoCs and is designed to receive interrupts from peripheral devices.
+
+  Each DHC SoC has two sets of interrupt controllers, each capable of
+  handling up to 32 interrupts.
+
+properties:
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
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+  '#address-cells':
+    const: 0
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+    description:
+      Contains the GIC SPI IRQs mapped to the external interrupt lines.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - '#address-cells'
+  - interrupts
+
+additionalProperties: false
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - realtek,rtd1319-intc-iso
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          items:
+            - description: isolation irqs
+            - description: rtc irq
+  - if:
+      properties:
+        compatible:
+          enum:
+            - realtek,rtd1319d-intc-iso
+            - realtek,rtd1325-intc-iso
+            - realtek,rtd1619b-intc-iso
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          items:
+            - description: isolation irqs
+            - description: watchdog irq
+  - if:
+      properties:
+        compatible:
+          enum:
+            - realtek,rtd1319-intc-misc
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+          items:
+            - description: miscellaneous irqs
+            - description: watchdog irq
+            - description: uart1 irq
+            - description: uart2 irq
+  - if:
+      properties:
+        compatible:
+          enum:
+            - realtek,rtd1319d-intc-misc
+            - realtek,rtd1325-intc-misc
+            - realtek,rtd1619b-intc-misc
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+          items:
+            - description: miscellaneous irqs
+            - description: uart1 irq
+            - description: uart2 irq
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    realtek_iso_intc: interrupt-controller@40 {
+      compatible = "realtek,rtd1319-intc-iso";
+      reg = <0x00 0x40>;
+      interrupt-parent = <&gic>;
+      interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-controller;
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+    };
+...
-- 
2.25.1


