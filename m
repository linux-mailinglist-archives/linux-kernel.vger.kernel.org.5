Return-Path: <linux-kernel+bounces-167763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C668E8BAEEB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E70F1F215A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7526156C53;
	Fri,  3 May 2024 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="meO235jW"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D171552ED;
	Fri,  3 May 2024 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746083; cv=none; b=YWLxQJ9W9zqUDiRgx56QDrSGJozfLu/3jCpYXHT6uaB2bCADIapelMILzZ7Xcw1M58akIxiz9Yq6bbel1eV97FyWBcK7LyNraHs886p6w6wJx4AeV/47B7I3f2ghgWvV4+STuVUMT4SV3H4sYYg8WiyT+hKbOjbMCGWqcAhOQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746083; c=relaxed/simple;
	bh=YjbWlqN7MZ0jAzt3BcPRtlF5vCkg+Oj6MdEgyNmmhMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EsoaHcfDLUcTtT9PV1tvDMw+F/3tVaP4bryYFWQgjF6eS+BLPa6YRTfzsmCwLi8CKjOEkckeVWywUXUUon63Zk65+mgPhIau9BxQIAYwtcnkvJh5fGUhs+h0EsbfCZ+0qZNq38lc3RqjrcvGFVsy4+PX53V64O43vqp7VJI/tXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=meO235jW; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11ADCE0016;
	Fri,  3 May 2024 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714746071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8o8TsLYJjK8/HyhFOEmPWrSGUV0TlbVKMYvkZs9m9MI=;
	b=meO235jW1IBB7PsnF8SE5rba0mLtPqmIn9PJrz0t4Iz1IVeqIlPDQpiOo7nGVpBUk4obwZ
	pfBzYtid/qVTaxHXCMZroO6z/N1yJcYpeUB/xG46O4N4kfY3N1KjTBYAWh8YeqIbBROtF2
	ptLL0hvsoz8i7bb+WrH66Ova1JaqxQIQmh1oFVzjttg9icWTP+AFLsKPWnoOrC2R7bwHjc
	bg/aoRZLiHTIavOfxy5oM4lTZIDbBSgvASjJ4dd4DnzRbWaWjIUSZylqUP9aqf/b2olyYo
	qdS84Azy0TBI6VCsFroqhm/syKaWmOVyZ2i+6adpwfJOxJwNK5d+g+4JPuV6Dg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 03 May 2024 16:20:48 +0200
Subject: [PATCH v2 03/11] dt-bindings: soc: mobileye: add EyeQ OLB system
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240503-mbly-olb-v2-3-95ce5a1e18fe@bootlin.com>
References: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
In-Reply-To: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add documentation to describe the "Other Logic Block" system-controller.
It deals with three platforms: EyeQ5, EyeQ6L and EyeQ6H. First two have
a single instance, whereas EyeQ6H has seven named instances.

Features provided are:
 - Clocks, children to main crystal. Some PLLs and divider clocks.
 - Resets. EyeQ6H central, south, DDR0 and DDR1 do not have resets.
 - Pinctrl. Only EyeQ5 has such feature.

Those are NOT the only registers exposed in OLB system-controllers! Many
individual registers, related to IP block integration, can be found.

We simplify devicetree references to OLB in two ways:
 - Compatibles exposing a single clock do not ask for a index argument.
 - Compatibles exposing a single reset domain do not ask for a domain
   index, only a reset index.

About pinctrl subnodes: all pins have two functionality, either GPIO or
something-else. The latter is pin dependent, we express constraints
using many if-then.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 375 +++++++++++++++++++++
 MAINTAINERS                                        |   2 +
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  21 ++
 3 files changed, 398 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
new file mode 100644
index 000000000000..bbd75b81166e
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
@@ -0,0 +1,375 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye EyeQ SoC system controller
+
+maintainers:
+  - Grégory Clement <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+
+description:
+  OLB ("Other Logic Block") is a hardware block grouping smaller blocks. Clocks,
+  resets, pinctrl are being handled from here. EyeQ5 and EyeQ6L host a single
+  instance. EyeQ6H hosts seven instances.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mobileye,eyeq5-olb
+          - mobileye,eyeq6l-olb
+          - mobileye,eyeq6h-acc-olb
+          - mobileye,eyeq6h-central-olb
+          - mobileye,eyeq6h-east-olb
+          - mobileye,eyeq6h-west-olb
+          - mobileye,eyeq6h-south-olb
+          - mobileye,eyeq6h-ddr0-olb
+          - mobileye,eyeq6h-ddr1-olb
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    description:
+      First cell is domain and optional if compatible has a single reset domain.
+      Second cell is reset index inside that domain.
+    enum: [ 1, 2 ]
+
+  '#clock-cells':
+    description:
+      Cell is clock index. Optional if compatible has a single clock.
+    enum: [ 0, 1 ]
+
+  clocks:
+    maxItems: 1
+    description:
+      Input parent clock to all PLLs. Expected to be the main crystal.
+
+  clock-names:
+    const: ref
+
+patternProperties:
+  '-pins?$':
+    type: object
+    description: Pin muxing configuration.
+    $ref: /schemas/pinctrl/pinmux-node.yaml#
+    additionalProperties: false
+    properties:
+      pins: true
+      function:
+        enum: [gpio,
+               # Bank A
+               timer0, timer1, timer2, timer5, uart0, uart1, can0, can1, spi0,
+               spi1, refclk0,
+               # Bank B
+               timer3, timer4, timer6, uart2, can2, spi2, spi3, mclk0]
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      drive-strength: true
+    required:
+      - pins
+      - function
+    allOf:
+      - if:
+          properties:
+            function:
+              const: gpio
+        then:
+          properties:
+            pins:
+              items: # PA0 - PA28, PB0 - PB22
+                pattern: '^(P(A|B)1?[0-9]|PA2[0-8]|PB2[0-2])$'
+      - if:
+          properties:
+            function:
+              const: timer0
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PA0, PA1]
+      - if:
+          properties:
+            function:
+              const: timer1
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PA2, PA3]
+      - if:
+          properties:
+            function:
+              const: timer2
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PA4, PA5]
+      - if:
+          properties:
+            function:
+              const: timer5
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PA6, PA7, PA8, PA9]
+      - if:
+          properties:
+            function:
+              const: uart0
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PA10, PA11]
+      - if:
+          properties:
+            function:
+              const: uart1
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PA12, PA13]
+      - if:
+          properties:
+            function:
+              const: can0
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PA14, PA15]
+      - if:
+          properties:
+            function:
+              const: can1
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PA16, PA17]
+      - if:
+          properties:
+            function:
+              const: spi0
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PA18, PA19, PA20, PA21, PA22]
+      - if:
+          properties:
+            function:
+              const: spi1
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PA23, PA24, PA25, PA26, PA27]
+      - if:
+          properties:
+            function:
+              const: refclk0
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PA28]
+      - if:
+          properties:
+            function:
+              const: timer3
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PB0, PB1]
+      - if:
+          properties:
+            function:
+              const: timer4
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PB2, PB3]
+      - if:
+          properties:
+            function:
+              const: timer6
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PB4, PB5, PB6, PB7]
+      - if:
+          properties:
+            function:
+              const: uart2
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PB8, PB9]
+      - if:
+          properties:
+            function:
+              const: can2
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PB10, PB11]
+      - if:
+          properties:
+            function:
+              const: spi2
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PB12, PB13, PB14, PB15, PB16]
+      - if:
+          properties:
+            function:
+              const: spi3
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PB17, PB18, PB19, PB20, PB21]
+      - if:
+          properties:
+            function:
+              const: mclk0
+        then:
+          properties:
+            pins:
+              items:
+                enum: [PB22]
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+allOf:
+    # Compatibles exposing a single reset domain.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mobileye,eyeq6h-acc-olb
+              - mobileye,eyeq6h-east-olb
+              - mobileye,eyeq6h-west-olb
+    then:
+      properties:
+        '#reset-cells':
+          const: 1
+      required:
+        - '#reset-cells'
+
+    # Compatibles exposing two reset domains.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mobileye,eyeq5-olb
+              - mobileye,eyeq6l-olb
+    then:
+      properties:
+        '#reset-cells':
+          const: 2
+      required:
+        - '#reset-cells'
+
+    # Compatibles not exposing resets.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mobileye,eyeq6h-central-olb
+              - mobileye,eyeq6h-south-olb
+              - mobileye,eyeq6h-ddr0-olb
+              - mobileye,eyeq6h-ddr1-olb
+    then:
+      properties:
+        '#reset-cells': false
+
+    # Compatibles exposing a single clock.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mobileye,eyeq6h-central-olb
+              - mobileye,eyeq6h-east-olb
+              - mobileye,eyeq6h-west-olb
+              - mobileye,eyeq6h-ddr0-olb
+              - mobileye,eyeq6h-ddr1-olb
+    then:
+      properties:
+        '#clock-cells':
+          const: 0
+    else:
+      properties:
+        '#clock-cells':
+          const: 1
+
+    # Only EyeQ5 has pinctrl in OLB.
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: mobileye,eyeq5-olb
+    then:
+      patternProperties:
+        '-pins?$': false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      system-controller@e00000 {
+        compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
+        reg = <0 0xe00000 0x0 0x400>;
+        #reset-cells = <2>;
+        #clock-cells = <1>;
+        clocks = <&xtal>;
+        clock-names = "ref";
+      };
+    };
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      system-controller@d2003000 {
+        compatible = "mobileye,eyeq6h-acc-olb", "syscon", "simple-mfd";
+        reg = <0x0 0xd2003000 0x0 0x1000>;
+        #reset-cells = <1>;
+        #clock-cells = <1>;
+        clocks = <&xtal>;
+        clock-names = "ref";
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..fcc9f4364a5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14926,9 +14926,11 @@ M:	Théo Lebrun <theo.lebrun@bootlin.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S
+F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
diff --git a/include/dt-bindings/clock/mobileye,eyeq5-clk.h b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
index 26d8930335e4..b433c1772c28 100644
--- a/include/dt-bindings/clock/mobileye,eyeq5-clk.h
+++ b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
@@ -19,4 +19,25 @@
 
 #define EQ5C_DIV_OSPI	10
 
+#define EQ6LC_PLL_DDR		0
+#define EQ6LC_PLL_CPU		1
+#define EQ6LC_PLL_PER		2
+#define EQ6LC_PLL_VDI		3
+
+#define EQ6HC_SOUTH_PLL_VDI		0
+#define EQ6HC_SOUTH_PLL_PCIE		1
+#define EQ6HC_SOUTH_PLL_PER		2
+#define EQ6HC_SOUTH_PLL_ISP		3
+
+#define EQ6HC_SOUTH_DIV_EMMC		4
+#define EQ6HC_SOUTH_DIV_OSPI_REF	5
+#define EQ6HC_SOUTH_DIV_OSPI_SYS	6
+#define EQ6HC_SOUTH_DIV_TSU		7
+
+#define EQ6HC_ACC_PLL_XNN		0
+#define EQ6HC_ACC_PLL_VMP		1
+#define EQ6HC_ACC_PLL_PMA		2
+#define EQ6HC_ACC_PLL_MPC		3
+#define EQ6HC_ACC_PLL_NOC		4
+
 #endif

-- 
2.45.0


