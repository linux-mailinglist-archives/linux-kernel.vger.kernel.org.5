Return-Path: <linux-kernel+bounces-65539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE927854E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED1A1C290D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4481560DEA;
	Wed, 14 Feb 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VoTPslhm"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D095D49C;
	Wed, 14 Feb 2024 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928079; cv=none; b=jx72u5Ke/RrT479kH8rpl39bGGmnMUk8vhAfYt0xTxkc8hCJNGvT6X/gb84AY+RRNGKYPQq0Vt0G+C6wMpxaePXptk+f0qL7WaFFsoZhP6f/EtjCbzlDxDa3Z4v2s3hhPGr4YcI3pUtnU0j4h7MKRo7H9m4sUBb4rNQG8NeW5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928079; c=relaxed/simple;
	bh=vbLBV9LE8zcIhbVI3fmPgLheYia+c1A7rqBxXOQBaHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jvs/1ROqX7LIFyu7UcUPlMmizIcjc4HlrWxZVUGZUMblQZbwer8pJw1Iv3KO2RBEvqFoNxuoUe56UNSRDKFay95sorT1iSoYCpy2ilTwYOAbGnfVd82ykuTM1TMO63PipXV5hepLGx+x7Z+VcShy3FKnRsd4kATWrx0Tpz64BDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VoTPslhm; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 02E53C3891;
	Wed, 14 Feb 2024 16:24:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 847366000D;
	Wed, 14 Feb 2024 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+hLpp3Oh6aliFOkGNM1V8H7CBiD2VCJGavAJzYQllM=;
	b=VoTPslhmWmBZLJbhFH4jMyNyFwa8ugfgQK5Gy6gWKHlOKON+5BlKPwEZZ89m8vLxTg4FLU
	qxJv/IBu06uQj1pukH3FdH9gucaINTs4Kl90MMPa8VMVVKi5VOvyTQMCch0hVlV8O+Uce4
	SXnFe4KdAo5EP/ut5LhPLfvNY8WpUjz6gOa2lMe7kdBW/Zq3eazWYRa6pwCFbNA6J8egkw
	UdNcWdBwTnoVEUKqhHuEgdn9BmkgP/rkWcoPoEjrXIKO2H2nLNwSlW9Rk5jL1tT4CpDqER
	/EYfydIqJvd5DPpXJUETTJhYw02XM5vzlhLU3dxcISwFhCpRJl7Dkt8AHtMm4Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:23:54 +0100
Subject: [PATCH 01/23] dt-bindings: gpio: nomadik: convert into yaml format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-1-f88c0ccf372b@bootlin.com>
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Create gpio/st,nomadik-gpio.yaml json-schema dt-bindings file as a
direct translation from gpio-nmk.txt. Remove the txt file.

Add clocks and gpio-ranges properties which were missing and are being
used in Nomadik devicetrees.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../devicetree/bindings/gpio/gpio-nmk.txt          | 31 ---------
 .../devicetree/bindings/gpio/st,nomadik-gpio.yaml  | 75 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 76 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-nmk.txt b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
deleted file mode 100644
index 8315ac7780ef..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Nomadik GPIO controller
-
-Required properties:
-- compatible            : Should be "st,nomadik-gpio".
-- reg                   : Physical base address and length of the controller's registers.
-- interrupts            : The interrupt outputs from the controller.
-- #gpio-cells           : Should be two:
-                            The first cell is the pin number.
-                            The second cell is used to specify optional parameters:
-                              - bits[3:0] trigger type and level flags:
-                                  1 = low-to-high edge triggered.
-                                  2 = high-to-low edge triggered.
-                                  4 = active high level-sensitive.
-                                  8 = active low level-sensitive.
-- gpio-controller       : Marks the device node as a GPIO controller.
-- interrupt-controller  : Marks the device node as an interrupt controller.
-- gpio-bank             : Specifies which bank a controller owns.
-- st,supports-sleepmode : Specifies whether controller can sleep or not
-
-Example:
-
-                gpio1: gpio@8012e080 {
-                        compatible = "st,nomadik-gpio";
-                        reg =  <0x8012e080 0x80>;
-                        interrupts = <0 120 0x4>;
-                        #gpio-cells = <2>;
-                        gpio-controller;
-                        interrupt-controller;
-                        st,supports-sleepmode;
-                        gpio-bank = <1>;
-                };
diff --git a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
new file mode 100644
index 000000000000..a999908173d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/st,nomadik-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nomadik GPIO controller
+
+description:
+  The Nomadik GPIO driver handles Nomadik SoC GPIO blocks. This block has also
+  been called ST STA2X11. On the Nomadik platform, this driver is intertwined
+  with pinctrl-nomadik.
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  $nodename:
+    pattern: "^gpio@[0-9a-f]+$"
+
+  compatible:
+    const: st,nomadik-gpio
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  gpio-bank:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  st,supports-sleepmode:
+    description: Whether the controller can sleep or not.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  clocks:
+    maxItems: 1
+
+  gpio-ranges:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#gpio-cells"
+  - gpio-controller
+  - interrupt-controller
+  - gpio-bank
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gpio1: gpio@8012e080 {
+        compatible = "st,nomadik-gpio";
+        reg =  <0x8012e080 0x80>;
+        interrupts = <0 120 0x4>;
+        #gpio-cells = <2>;
+        gpio-controller;
+        interrupt-controller;
+        st,supports-sleepmode;
+        gpio-bank = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9134384171fe..0cb2c459d1cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2465,6 +2465,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
 F:	Documentation/devicetree/bindings/arm/ste-*
 F:	Documentation/devicetree/bindings/arm/ux500.yaml
 F:	Documentation/devicetree/bindings/arm/ux500/
+F:	Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
 F:	Documentation/devicetree/bindings/i2c/st,nomadik-i2c.yaml
 F:	arch/arm/boot/dts/st/ste-*
 F:	arch/arm/mach-nomadik/

-- 
2.43.1


