Return-Path: <linux-kernel+bounces-84878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C947E86AD04
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8E2B214FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEA11384B4;
	Wed, 28 Feb 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pBoQZ29x"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120D12EBF2;
	Wed, 28 Feb 2024 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119701; cv=none; b=DjjOM7RHiiF0ShxwxZwnOVueTretlzHzORZJyFb+HVKTmF5Hg1uLhKxzEmKkJVUnjgqOb+4g21X6R00neVmq+s2yZHPtLOZapYFuz6Zrwvk6LvYH0Ige+8GsNexUSaUeaEZ8jtwlc16Zv5B1GGyj+uuQNcSQVIB+NBrOT5avre8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119701; c=relaxed/simple;
	bh=Vz9SPJE8farhIihvENIryv9IAcRYm/mAPepMAz2P3kE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u5jdQZ4omk0J9FBa1kB+LoYCjIgnwCi1l8QNtw1V69JHG/cuI3TZN+x36jIiMIISmd0/EAgtHeGLBxXOgtjseV/lrL52Nm/112DrUyTAL50sST+CNioDVzlnW+cJ/5TWT5o3ju0iF+4urRoVTr4Jwo9i4PEuyGgEjGxjpMn//Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pBoQZ29x; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD8DC1BF204;
	Wed, 28 Feb 2024 11:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+8O51qGAeyL9mM1QtsKVOAqzV8blYa5X3FlS/3MyRU=;
	b=pBoQZ29x7JzynEauavVMcRHTUx9I2fRW982GdqGJnzY/EjCA6mKjSCCPNY/asIg7JqOvm4
	XDmMdt43MthuDDY4qNbXXD/P3pAwlbROlOJ1L8DfmkbFJ0GChOpVoX9+oBU9q+HWM2zKIh
	93YM5GN7rcjOMQ8eAaQsMMaG95uhVO8StoeB85At8TVNB8JGvRAelV3wkinqtJmEgfq4S0
	ZD4s63d4UzZK21L/UvohgUdv7kI53Lg3sorcQJLtvny3fvAd+R05/YJYNxbus1wDwjG/To
	WMGBJXV8RLWl9p7ZA2/uIONLA0UZmSJ9/932z8u7XJ8UcZtDfxPPq9oH843YEg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:27:59 +0100
Subject: [PATCH v2 01/30] dt-bindings: gpio: nomadik: convert into yaml
 format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-1-3ba757474006@bootlin.com>
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
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
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Create gpio/st,nomadik-gpio.yaml json-schema dt-bindings file as a
direct translation from gpio-nmk.txt. Remove the txt file.

Add clocks and gpio-ranges properties which were missing and are being
used in Nomadik devicetrees.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../devicetree/bindings/gpio/gpio-nmk.txt          | 31 ---------
 .../devicetree/bindings/gpio/st,nomadik-gpio.yaml  | 76 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 77 insertions(+), 31 deletions(-)

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
index 000000000000..69774f36e03f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
@@ -0,0 +1,76 @@
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
+    description: System-wide GPIO bank index.
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
index 73bd2851eb4c..854b41ee4dcc 100644
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
2.44.0


