Return-Path: <linux-kernel+bounces-118056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3988B313
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1771C3E37A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA571756;
	Mon, 25 Mar 2024 21:46:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8C33995;
	Mon, 25 Mar 2024 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403171; cv=none; b=M5aWr01K/9FMGeb72IqdHKpXNXil+2lJ8qCSAWM+4nYNXEPnqBVrPRYLpYEt1jxAB9Yhf164TLvCT5aH1Zfw4mosfTeTvNl6byz3urngc+0VuwChH+JRxCZytwBVrSb0wko3iBsDFJT48XwLn+mADyEtLHdv/ENqBbvSZmXfvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403171; c=relaxed/simple;
	bh=QmcrFjHsyLYA5YkEZPsztUH8CEd2ed/E9NAk9w9yOQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n4V/0h0fbEY/MHJvT404iAWKRuZCathYUIoPlse5rLEk6l19r0R0SjK4XNz8rOPjYDVavczwLqXuldlHm/Tr3qRTsidvw2l/0ZDsctiKxgZKxeOkXDR5CpJfpSsP0ne8/f94D4w1GYFFes15gcEslXoMEqwzSYWoRzwupS82uYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECFCC433C7;
	Mon, 25 Mar 2024 21:46:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A7F0D1060C59; Mon, 25 Mar 2024 22:46:07 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 25 Mar 2024 22:45:29 +0100
Subject: [PATCH 3/3] dt-bindings: hsi: omap-ssi: convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-hsi-dt-binding-v1-3-88e8e97c3aae@collabora.com>
References: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
In-Reply-To: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8551;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=QmcrFjHsyLYA5YkEZPsztUH8CEd2ed/E9NAk9w9yOQg=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmAfCeONHV0Vf/JS55qeIDQCbkyhC/+neYKfnzK
 cbB4o6MWqqJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgHwngAKCRDY7tfzyDv6
 mm+ND/9+dIsmQTiua4Fn6p1l4BRJ1/bzeRI+hWKnufspaFPql152TlDuMe58Cc0xhVe+e3ckF0l
 1Vkq33+Qg2itF+0yPjyB1UB2zVT16RtmHp16Jf81OhRddyJTZ7afgKmDUXTWcVcVDMw6mJTAHiO
 2T0x9YJwRKsrlzRd36fQfLvoXdalnvyxWe3AF5yusPuBWjUD5yNa114EIz/SK6U9xsemDwXMTAf
 WorllkXQvBD1mSPUIWZHCifDiAdOXJaGcqsZmEGGoUKlA0QhXu8i7g45rr+tE5cZT9JncrAPXxC
 iHL0ToxxMpBQylRMUfkB7VllsqFThAlenX8vCDpEdajqHFjqHUKVtYxGW8bodiEKok61nlHJ4HZ
 lBZBRwVKe23ckECpCpKVumWbdJxCSkehnruXI9p1gbK0WBAw9JKL1MQw9ObsShYJ+Nq39ZWl3LQ
 DnCIoUP9XjB2x6GF+ZVHtNecHrO+BlSSZrJDCQrxvWUEyszErZc3GTk8bf7w3b1Z/GTJyJ4/eQp
 C2vpIkD+VumhtTF+0YFtQwn8yk+QdWW+jGEowEzl+HNgieyT30jTQc8spHuWF9lewbEG6iIx70k
 3rtDwKbjgUi8U8SGWZiElpRLnne3Yz67XGxVvX15iFMDWEC28XBcSy/KF2lBR0cyhhkackYXeDp
 Qy4dndvCFuCAvkA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Convert the legacy txt binding to modern YAML.
No semantic change.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/hsi/omap-ssi.txt | 102 -----------
 .../devicetree/bindings/hsi/ti,omap-ssi.yaml       | 196 +++++++++++++++++++++
 2 files changed, 196 insertions(+), 102 deletions(-)

diff --git a/Documentation/devicetree/bindings/hsi/omap-ssi.txt b/Documentation/devicetree/bindings/hsi/omap-ssi.txt
deleted file mode 100644
index 77a0c3c3036e..000000000000
--- a/Documentation/devicetree/bindings/hsi/omap-ssi.txt
+++ /dev/null
@@ -1,102 +0,0 @@
-OMAP SSI controller bindings
-
-OMAP3's Synchronous Serial Interface (SSI) controller implements a
-legacy variant of MIPI's High Speed Synchronous Serial Interface (HSI),
-while the controller found inside OMAP4 is supposed to be fully compliant
-with the HSI standard.
-
-Required properties:
-- compatible:		Should include "ti,omap3-ssi" or "ti,omap4-hsi"
-- reg-names:		Contains the values "sys" and "gdd" (in this order).
-- reg:			Contains a matching register specifier for each entry
-			in reg-names.
-- interrupt-names:	Contains the value "gdd_mpu".
-- interrupts: 		Contains matching interrupt information for each entry
-			in interrupt-names.
-- ranges:		Represents the bus address mapping between the main
-			controller node and the child nodes below.
-- clock-names:		Must include the following entries:
-  "ssi_ssr_fck": The OMAP clock of that name
-  "ssi_sst_fck": The OMAP clock of that name
-  "ssi_ick": The OMAP clock of that name
-- clocks:		Contains a matching clock specifier for each entry in
-			clock-names.
-- #address-cells:	Should be set to <1>
-- #size-cells:		Should be set to <1>
-
-Each port is represented as a sub-node of the ti,omap3-ssi device.
-
-Required Port sub-node properties:
-- compatible:		Should be set to the following value
-			ti,omap3-ssi-port (applicable to OMAP34xx devices)
-			ti,omap4-hsi-port (applicable to OMAP44xx devices)
-- reg-names:		Contains the values "tx" and "rx" (in this order).
-- reg:			Contains a matching register specifier for each entry
-			in reg-names.
-- interrupts:		Should contain interrupt specifiers for mpu interrupts
-			0 and 1 (in this order).
-- ti,ssi-cawake-gpio:	Defines which GPIO pin is used to signify CAWAKE
-			events for the port. This is an optional board-specific
-			property. If it's missing the port will not be
-			enabled.
-
-Optional properties:
-- ti,hwmods:		Shall contain TI interconnect module name if needed
-			by the SoC
-
-Example for Nokia N900:
-
-ssi-controller@48058000 {
-	compatible = "ti,omap3-ssi";
-
-	/* needed until hwmod is updated to use the compatible string */
-	ti,hwmods = "ssi";
-
-	reg = <0x48058000 0x1000>,
-	      <0x48059000 0x1000>;
-	reg-names = "sys",
-		    "gdd";
-
-	interrupts = <55>;
-	interrupt-names = "gdd_mpu";
-
-	clocks = <&ssi_ssr_fck>,
-		 <&ssi_sst_fck>,
-		 <&ssi_ick>;
-	clock-names = "ssi_ssr_fck",
-		      "ssi_sst_fck",
-		      "ssi_ick";
-
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-
-	ssi-port@4805a000 {
-		compatible = "ti,omap3-ssi-port";
-
-		reg = <0x4805a000 0x800>,
-		      <0x4805a800 0x800>;
-		reg-names = "tx",
-			    "rx";
-
-		interrupt-parent = <&intc>;
-		interrupts = <67>,
-			     <68>;
-
-		ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
-	}
-
-	ssi-port@4805a000 {
-		compatible = "ti,omap3-ssi-port";
-
-		reg = <0x4805b000 0x800>,
-		      <0x4805b800 0x800>;
-		reg-names = "tx",
-			    "rx";
-
-		interrupt-parent = <&intc>;
-		interrupts = <69>,
-			     <70>;
-
-	}
-}
diff --git a/Documentation/devicetree/bindings/hsi/ti,omap-ssi.yaml b/Documentation/devicetree/bindings/hsi/ti,omap-ssi.yaml
new file mode 100644
index 000000000000..eb82f85c25b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/hsi/ti,omap-ssi.yaml
@@ -0,0 +1,196 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hsi/ti,omap-ssi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SSI Controller on OMAP SoCs
+
+description:
+  OMAP3's Synchronous Serial Interface (SSI) controller implements a
+  legacy variant of MIPI's High Speed Synchronous Serial Interface (HSI),
+  while the controller found inside OMAP4 is supposed to be fully compliant
+  with the HSI standard.
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - ti,omap3-ssi
+      - ti,omap4-hsi
+
+  reg:
+    items:
+      - description: registers for sys
+      - description: registers for gdd
+
+  reg-names:
+    items:
+      - const: sys
+      - const: gdd
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: gdd_mpu
+
+  ti,hwmods:
+    const: ssi
+    deprecated: true
+
+patternProperties:
+  "[hs]si-port@[0-9a-f]+":
+    type: object
+
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          - ti,omap3-ssi-port
+          - ti,omap4-hsi-port
+
+      reg:
+        items:
+          - description: TX registers
+          - description: RX registers
+
+      reg-names:
+        items:
+          - const: tx
+          - const: rx
+
+      interrupts:
+        items:
+          - description: MPU interrupt 0
+          - description: MPU interrupt 1
+        minItems: 1
+
+      ti,ssi-cawake-gpio:
+        description: GPIO signifying CAWAKE events
+        maxItems: 1
+
+      hsi-client:
+        type: object
+        $ref: /schemas/hsi/hsi-client.yaml#
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+      - interrupts
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: ti,omap3-ssi-port
+        then:
+          properties:
+            $nodename:
+              pattern: "^ssi-port@(.*)?$"
+            interrupts:
+              minItems: 2
+        else:
+          properties:
+            $nodename:
+              pattern: "^hsi-port@(.*)?$"
+            interrupts:
+              maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,omap3-ssi
+    then:
+      properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          items:
+            - const: ssi_ssr_fck
+            - const: ssi_sst_fck
+            - const: ssi_ick
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: hsi_fck
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    ssi-controller@48058000 {
+        compatible = "ti,omap3-ssi";
+        reg = <0x48058000 0x1000>,
+              <0x48059000 0x1000>;
+        reg-names = "sys", "gdd";
+        ranges;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        clocks = <&ssi_ssr_fck>,
+                 <&ssi_sst_fck>,
+                 <&ssi_ick>;
+        clock-names = "ssi_ssr_fck",
+                      "ssi_sst_fck",
+                      "ssi_ick";
+        interrupts = <55>;
+        interrupt-names = "gdd_mpu";
+
+        ssi-port@4805a000 {
+                compatible = "ti,omap3-ssi-port";
+                reg = <0x4805a000 0x800>,
+                      <0x4805a800 0x800>;
+                reg-names = "tx", "rx";
+                interrupt-parent = <&intc>;
+                interrupts = <67>, <68>;
+                ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>;
+        };
+
+        ssi-port@4805b000 {
+                compatible = "ti,omap3-ssi-port";
+                reg = <0x4805b000 0x800>,
+                      <0x4805b800 0x800>;
+                reg-names = "tx", "rx";
+                interrupt-parent = <&intc>;
+                interrupts = <69>, <70>;
+        };
+    };

-- 
2.43.0


