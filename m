Return-Path: <linux-kernel+bounces-59465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E6684F779
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139131C222F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBB7BAE2;
	Fri,  9 Feb 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bAPxabmH"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89DA6D1D4;
	Fri,  9 Feb 2024 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489117; cv=none; b=nv7M2r9iTeI+DHcfmGG/CfuSyZ2nOxw21rtKoKCRaPPZGAGsR6Y0lV9MhNZ/vGUow/vpwswHvrIoI11+KRk6F0oxKKVbSWk0PlQSyBysIiEd8TgfP560kRlt3U9LZ9o8P1XD9vpkQjEsxpS5D4aM9u3gy1uINC+Vbjn/fTFPzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489117; c=relaxed/simple;
	bh=pzJfrinjIDxBTHW1NQtKke7bnQ5u/8w10fV7kImjVII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vhx2BqAJqmosRkxFyD+/K8+Mn40Ga4FzRqAQtuXDZAIa5RulwOrjGtb+Gchhrq0qdwg1s3Rx2h38HoTeOdyUPHnrXWzgC/xeGyXjxVk+zl97PDppT8j5WXjuyn2oQV2dj4/7os70mc5KOoaVpo0LDRqU+/UsVzO7vhAuMV/H+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bAPxabmH; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A171240010;
	Fri,  9 Feb 2024 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707489113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQI1tDyU/5DevDA510arVwNDwXyynUTeTAbpUDAxeCQ=;
	b=bAPxabmHLvUbZ5TfuOyX+Bqd4ho7o2eP2gqdOF6Umr6GhennS38lLy7jJO7p7qZ7A34fhk
	Be3ps2J5vI51z8vToIwn3CNAWHgKZ9VN5x1LN6ijZt6QhGfHxciiCzhe4r1v0xXB2PC7aO
	ZWAB2QaKCvnv2eIlIH7Ax1ASFPPOADixmfziuH1HAD6R6J2wSS7/h+EobVBrLM8PmGeps1
	8HrZSQns/1iktPgB7yaFO8t7PVgOdr1Ero2eDty+CK4TJ/3JiP53OiEzrpLuyOXpv0NrbL
	MiyQMEFp2zmy3BMo35ehW0aQ8w+Cx8KekJm48SZMgfy1d12T2rKpPO8KYuqPyw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 15:31:41 +0100
Subject: [PATCH v5 05/13] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-mbly-clk-v5-5-f094ee5e918a@bootlin.com>
References: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
In-Reply-To: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 242 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 243 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
new file mode 100644
index 000000000000..5f00604bf48c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
@@ -0,0 +1,242 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye EyeQ5 pin controller
+
+description: >
+  The EyeQ5 pin controller handles the two pin banks of the system. It belongs
+  to a system-controller block called OLB.
+
+  Pin control is about bias (pull-down, pull-up), drive strength and muxing. Pin
+  muxing supports two functions for each pin: first is GPIO, second is
+  pin-dependent.
+
+  Pins and groups are bijective.
+
+maintainers:
+  - Grégory Clement <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+
+$ref: pinctrl.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mobileye,eyeq5-pinctrl
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "-pins?$":
+    type: object
+    description: Pin muxing configuration.
+    $ref: pinmux-node.yaml#
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
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index d5348fbbace6..a09899acfa6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14791,6 +14791,7 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
 F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig

-- 
2.43.0


