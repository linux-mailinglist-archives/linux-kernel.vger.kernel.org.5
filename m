Return-Path: <linux-kernel+bounces-35909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809268398BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2E6294AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32F12CD91;
	Tue, 23 Jan 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oBJTq/7+"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66022129A7F;
	Tue, 23 Jan 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035637; cv=none; b=sYs/6fk03Xd7gIalZTcGU6fd+nAVkqtkVMgZiz95gJ1nzKy5gmcfLay80gftY+oG7FRSsBQ2zO24+U2NFRnKYojol5wcumUxmvVEVr12RRr7n6LW9vVYuY3PI4mNAC7WCRWcjymp7h4AUBqYdxDU887pBn5iURDuvI2HgI7c2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035637; c=relaxed/simple;
	bh=7WcXDg5t/3XbLK3EnQt+WvRz/bq4Y0tTaOW60QXqr60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tw8DoC0+xjt+hNJdq9TtUGC/wlCOQSaSkBq1iBsLom0CKtl6ndauA7YjB3IATozrqSZCVle/hNk/Z3AgoIKFJ7bOPR1encSbcBrDc4NvLczrkxHZkWIyTxq3ca76JLtJe+YQMeIyF3J9r5SFfPuKKGDefzcSNgqgVwEmag/38sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oBJTq/7+; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78385C000E;
	Tue, 23 Jan 2024 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EoXVzRU8tMK5r+v/y/TpmxjnhsGj5DLA8C8P2m7JZ+Y=;
	b=oBJTq/7+39RZKzglo4ahofoPt/TApanFy4TxJWhUG3/udJDdEX+1WfVbD8zzSRXRbIEJOh
	nYXlG7wU9p8t2F9akD3fwCeO9Yv50BtWGKoEWwvFGBUUQa4ENuZjDIOOMSJL7YVWqudw5h
	9fLC3juaLHvvB+KFlqUmTsWL7lCfyyGh3ze8P0fGSDhnLmtS9dP5oVT0QKRU2V+Wwu/Vkm
	DdJghIm3oUU5kO9KiJ1TWz4tG83lAt/U3okXV6vAeBzY4eW/gd/rVjFdeDbLBF71bEUmie
	KNq/Ni1eXaSdrqYaDzO8b8OxLF7uk6uVd0MlT+VQKlJQwylb0rw0g93SGrtdvQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:52 +0100
Subject: [PATCH v3 07/17] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-7-392b010b8281@bootlin.com>
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
In-Reply-To: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 77 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 78 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
new file mode 100644
index 000000000000..db62919053b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye EyeQ5 pin controller
+
+description:
+  The EyeQ5 pin controller handles a pin bank. It is custom to this platform,
+  its registers live in a shared region called OLB.
+  There are two pin banks on the platform, each having a specific compatible.
+  Pins and groups are bijective.
+
+maintainers:
+  - Grégory Clement <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+
+properties:
+  compatible:
+    enum:
+      - mobileye,eyeq5-a-pinctrl
+      - mobileye,eyeq5-b-pinctrl
+
+  "#pinctrl-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#pinctrl-cells"
+
+patternProperties:
+  "-pins?$":
+    type: object
+    description: Pin muxing configuration.
+    $ref: pinmux-node.yaml#
+    additionalProperties: false
+    properties:
+      pins: true
+      function: true
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      drive-strength: true
+    required:
+      - pins
+      - function
+
+allOf:
+  - $ref: pinctrl.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mobileye,eyeq5-a-pinctrl
+    then:
+      patternProperties:
+        "-pins?$":
+          properties:
+            function:
+              enum: [gpio, timer0, timer1, timer2, timer5, uart0, uart1, can0,
+                     can1, spi0, spi1, refclk0]
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mobileye,eyeq5-b-pinctrl
+    then:
+      patternProperties:
+        "-pins?$":
+          properties:
+            function:
+              enum: [gpio, timer3, timer4, timer6, uart2, can2, spi2, spi3,
+                     mclk0]
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e0eae9d6243..6dc4251e1ac2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14787,6 +14787,7 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
 F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
 F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/

-- 
2.43.0


