Return-Path: <linux-kernel+bounces-75272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5156585E5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DB52857B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F28686AC3;
	Wed, 21 Feb 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="itideOej"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41A8562A;
	Wed, 21 Feb 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539741; cv=none; b=te+lD4kCCF0n96wCdBmoj9to/Axpket2xE8PWKtQFp5mcWfVXRZn4uL3iG393ddW7KShfSsNf+3mhNHefBACvgYi8FAEorj6wBsV79WPFDDpPTBYt2Q6XPFrNfFjxT9Jlqw2Z1O8so4KRbCuXjShJQx3nt2HlCKIvD5jeUDPAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539741; c=relaxed/simple;
	bh=hlVwgMh6vQJLRhT70ZA+dY5Xj4I2r5nE/bOKjpoSlXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M07LVIjMBoVavFZP8YCHoJpwwlGCG1DG7Z28x8hA9jQziOTcGDYeXVutC35T4T59+eSADpXFlbjgoFaYWHdezfDpLnLs47JN2khPJ6b1AlKzi7pWnbEx2t6ElOV/kcDLfL/sCY8PVaY9qX7p93XPyKTtxVPFeOSDxySjz1oUUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=itideOej; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABB781C0009;
	Wed, 21 Feb 2024 18:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708539736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ObKOxx9XB93Vo9Nkq5fgZqM1lGObrm27AeQ2i1inbII=;
	b=itideOejB5NcywugFWWXYKPaXNvkaUqSIVm6Wp0236kwiCNVqBSnf6BkvgxmmS10R8idos
	wMWnn19nd9l8oqJWAkzh1RPKGOYxmspkYX+APuzzgDssDP9ICvi7EOqLUPjy2EAYStjGLK
	sbK7poyymAwy7sAerAlGHMnOald1AKwaB1Ti9E9ifcita41K42VXGPKyBqey0+7zEYPjH6
	lHTdJxFMwRjcpIae6yVvDuLpX1J7ok0LJ2/4umVcsJ9mN8onDBdPdKW0N6tDHZl7/2J1a7
	WspAj5ef8hlriM3fO1RIyyR9JzqSbTV/lqnXueFoSZyitXPiMOh7EWSjxfCZtQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 21 Feb 2024 19:22:13 +0100
Subject: [PATCH v7 05/14] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240221-mbly-clk-v7-5-31d4ce3630c3@bootlin.com>
References: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
In-Reply-To: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
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
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 242 +++++++++++++++++++++
 1 file changed, 242 insertions(+)

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

-- 
2.43.2


