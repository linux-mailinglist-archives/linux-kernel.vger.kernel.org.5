Return-Path: <linux-kernel+bounces-121888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C969488EEFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DA61F3392E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D9152528;
	Wed, 27 Mar 2024 19:11:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29601514F7;
	Wed, 27 Mar 2024 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566710; cv=none; b=YwB/v5aYVlquUEg1ymUM+H15KkObmfPdkYbavnWMZ/JTi4+hcZFJrznGCtWgyck8J4SCYR6EhE6ZpwSOIb96EGYAJFwJV7W3rLLJZ7oTrGFuEojFeXjkR212a3A8nNLWmJ+vEiq0ol2pyU3b8xz90+ATdyJdv+IhvP2fDKcNWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566710; c=relaxed/simple;
	bh=QEypX0koF50hLwLiw3vI6BhqvWJKBNcpPHUeY0AUQ/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiN2X6QBC16SBd5Cx7QAb5zsqnsU90IgEbe5JjtEYdIk/8+zFdvzIsYvysPIURnYmL/gBPZfLfSAkn9JHhZDMTvXrL/Q61TlvMEiPMwRx5C5YJvcsniGDiBrLOt9nbYSr2KDZ0P/Vxphb3DFSge/IWGlw2/nccRX9T5/cYRe93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34982C433C7;
	Wed, 27 Mar 2024 19:11:50 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id AD5BB1060993; Wed, 27 Mar 2024 20:11:47 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 27 Mar 2024 20:11:34 +0100
Subject: [PATCH v2 3/7] dt-bindings: hsi: omap-ssi: convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-hsi-dt-binding-v2-3-110fab4c32ae@collabora.com>
References: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
In-Reply-To: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8354;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=QEypX0koF50hLwLiw3vI6BhqvWJKBNcpPHUeY0AUQ/8=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmBG9yaxeLOrJKcUkBJ9mYhbqP+EYCaLKDPcv20
 Je3kFZMTfqJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgRvcgAKCRDY7tfzyDv6
 mnRjD/9JsnxIhUBlP7y7H5W0vxIBYCOv4cbIbjYh0QA+01RAPM6V9LHrT8/oCXLJBp8tCO0Hqia
 Bx1zdBUfI5YrMncpsYk8cSW3k97fytOAHguRe5Omk4sQgVnorClyx3/HdXVNMXlCO3pZ3gciRBa
 AumsUcZdR8dOU3FPytqRNyLTd+ODS8nAvRV4UEawo2fAwko28i/RHqxOGxcjYybFCWRa+gfHKFO
 Evgke9ccDWbjMKax/eFyipzKyfiii8cfKLOVPKqPfrfHCR0+e9aUiIog2+0pC7y4Tm+elaGobxI
 CkIx8iZr3hSQscAszbpBVAsUWGc2gNJU0rquZokm9MmZ14y9YLsa8lpYDm4qIcb+yVQufOHJ43M
 hNskVe7/vMdwjuLj/eD3+wenlT66m2wHSN71mp7Sjdoib0gOWKwOYmmc+GvDeCETXMrC8n8kqGh
 BD6jKNFofObQ8ooVy4aSiS++V4Cn0PsLD7Ek9m7sTmLcsqxxX5FJ3Bfx+L6L/j4gl2iy9AO5IyG
 d7sIqJKX/2whA9XlLRSgjmk3zem+RELRSuKUR9J2gX4MMuhPoW2ObyyeEkLNpwQwJGBWqCOofnv
 OrtgMv2XfQ02TOEpm7hE/cEikNrBrSFBgnrYfz27SPEY1fsCdd0eG2nOlz/DsTZDdVOBqcBBajl
 RBo/Oa0rVSDXYIg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Convert the legacy txt binding to modern YAML.
There are a couple of semantic changes:
 - hsi-port@<addr> and ssi-port@<addr> node name
   changed to port@<addr>
 - ti,hwmods was marked as deprecated. This is supposed to go away
   once OMAP3 gets the same treatment as OMAP4.
 - changed ti,cawake-gpio to ti,cawake-gpios
 - describe peripheral requirements for the port node

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/hsi/omap-ssi.txt | 102 ------------
 .../devicetree/bindings/hsi/ti,omap-ssi.yaml       | 177 +++++++++++++++++++++
 2 files changed, 177 insertions(+), 102 deletions(-)

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
index 000000000000..433e2b2c36ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/hsi/ti,omap-ssi.yaml
@@ -0,0 +1,177 @@
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
+  "port@[0-9a-f]+":
+    type: object
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
+      ti,ssi-cawake-gpios:
+        description: GPIO signifying CAWAKE events
+        maxItems: 1
+
+    patternProperties:
+      "^(modem|mcu)$":
+        type: object
+        $ref: /schemas/hsi/hsi-client.yaml#
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+      - interrupts
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
+additionalProperties: false
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
+        port@4805a000 {
+            compatible = "ti,omap3-ssi-port";
+            reg = <0x4805a000 0x800>,
+                  <0x4805a800 0x800>;
+            reg-names = "tx", "rx";
+            interrupt-parent = <&intc>;
+            interrupts = <67>, <68>;
+            ti,ssi-cawake-gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>;
+        };
+
+        port@4805b000 {
+            compatible = "ti,omap3-ssi-port";
+            reg = <0x4805b000 0x800>,
+                  <0x4805b800 0x800>;
+            reg-names = "tx", "rx";
+            interrupt-parent = <&intc>;
+            interrupts = <69>, <70>;
+        };
+    };

-- 
2.43.0


