Return-Path: <linux-kernel+bounces-77989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E16D860DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6821C2121C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAFC59B76;
	Fri, 23 Feb 2024 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YbTwFox9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BD758122;
	Fri, 23 Feb 2024 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679801; cv=none; b=Spg2WeCRLDN0leUB6KYpyPwzdgh52zpDLKrkhorWOsVVpQ4SHA1v2kxuN6WaQrFyRuGNbaHJTxjvRpLjQnFTadyPhFZcNm03chUshWDDWHC5H62ni2ot2aWOOXt0sAwjls4FVM3bnQWAOs8jSGfQ99x2dHV5hxBQ0vFpCc77OGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679801; c=relaxed/simple;
	bh=cPPxo7jkF2p3psJPjcEDbR/kBoxbqjvyfNPaLWpnafA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fDkgvz44XY7OY61zGu/x0VRTteFIby7X/dtZ1JidwpH18vWAdPHlR0qLkib7MYNULhX791bzN4C5nujnctrtXYxckWE5Eh3XEBsHw9JYFzgfAj03Qpa0mKAaEnarX6CefAHB4OYC4uGtu/Zc/WtMSwXV6fEgKo0Dyxh9UTY/L+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YbTwFox9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708679799; x=1740215799;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cPPxo7jkF2p3psJPjcEDbR/kBoxbqjvyfNPaLWpnafA=;
  b=YbTwFox9FmbxmALK1uMP+ojK2jXWTnYMBChjjxm4B53Lx/iE2UibHAc7
   3PQmFd3xfZfE+2Ez8KDHzOCJUB12i2/hFL8/1dlOp0VFBSy/Iy8P+H/3p
   BR/i2SkFHYmG1WMCsPuNbksjia1M2DJaxi32DCz3YMjx0UJpE+zIOoffH
   6Gr5ckPu6X+K8tdo8626+a0BR1mXE6Jf/tlGVohHocDeJrgp5r0vOZkOU
   m92mGmcfbzxwAQ+/oDNaESt0q/lUE0PNF47Vq+b0ApQPZFTKPTGR4LC06
   4hg5ynfpzMytL9P8/ytwZiBNs4YPlWbZ0KetfIbR+BOhN2bxg9/HfP4h6
   Q==;
X-CSE-ConnectionGUID: SUKQ20MbQ6GrA9O5LD3Fww==
X-CSE-MsgGUID: 8kwuj3GjS1WdtJm6EiQexw==
X-IronPort-AV: E=Sophos;i="6.06,179,1705388400"; 
   d="scan'208";a="183987163"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 02:16:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 02:16:28 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 23 Feb 2024 02:16:23 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Fri, 23 Feb 2024 14:46:23 +0530
Subject: [PATCH v2 2/2] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-b4-sama5d2-flexcom-yaml-v2-2-7e96c60c7701@microchip.com>
References: <20240223-b4-sama5d2-flexcom-yaml-v2-0-7e96c60c7701@microchip.com>
In-Reply-To: <20240223-b4-sama5d2-flexcom-yaml-v2-0-7e96c60c7701@microchip.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, "Lee
 Jones" <lee@kernel.org>, Kavyasree Kotagiri
	<kavyasree.kotagiri@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0

Convert the Atmel flexcom device tree bindings to json schema.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 .../bindings/mfd/atmel,sama5d2-flexcom.yaml        | 99 ++++++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt      | 64 --------------
 2 files changed, 99 insertions(+), 64 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
new file mode 100644
index 000000000000..0dc6a40b63f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/atmel,sama5d2-flexcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Flexcom (Flexible Serial Communication Unit)
+
+maintainers:
+  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
+
+description:
+  The Microchip Flexcom is just a wrapper which embeds a SPI controller,
+  an I2C controller and an USART. Only one function can be used at a
+  time and is chosen at boot time according to the device tree.
+
+properties:
+  compatible:
+    oneOf:
+      - const: atmel,sama5d2-flexcom
+      - items:
+          - const: microchip,sam9x7-flexcom
+          - const: atmel,sama5d2-flexcom
+      - items:
+          - const: microchip,sama7g5-flexcom
+          - const: atmel,sama5d2-flexcom
+
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges:
+    description:
+      One range for the full I/O register region. (including USART,
+      TWI and SPI registers).
+    items:
+      maxItems: 3
+
+  atmel,flexcom-mode:
+    description: |
+      Specifies the flexcom mode as follows:
+      1: USART
+      2: SPI
+      3: I2C.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3]
+
+patternProperties:
+  "^serial@[0-9a-f]+$":
+    type: object
+    description:
+      Child node describing USART. See atmel-usart.txt for details
+      of USART bindings.
+
+  "^spi@[0-9a-f]+$":
+    type: object
+    description:
+      Child node describing SPI. See ../spi/spi_atmel.txt for details
+      of SPI bindings.
+
+  "^i2c@[0-9a-f]+$":
+    $ref: /schemas/i2c/atmel,at91sam-i2c.yaml
+    description:
+      Child node describing I2C.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - atmel,flexcom-mode
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    flx0: flexcom@f8034000 {
+        compatible = "atmel,sama5d2-flexcom";
+        reg = <0xf8034000 0x200>;
+        clocks = <&flx0_clk>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0xf8034000 0x800>;
+        atmel,flexcom-mode = <2>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
deleted file mode 100644
index af692e8833a5..000000000000
--- a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-* Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)
-
-The Atmel Flexcom is just a wrapper which embeds a SPI controller, an I2C
-controller and an USART. Only one function can be used at a time and is chosen
-at boot time according to the device tree.
-
-Required properties:
-- compatible:		Should be "atmel,sama5d2-flexcom"
-			or "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom"
-- reg:			Should be the offset/length value for Flexcom dedicated
-			I/O registers (without USART, TWI or SPI registers).
-- clocks:		Should be the Flexcom peripheral clock from PMC.
-- #address-cells:	Should be <1>
-- #size-cells:		Should be <1>
-- ranges:		Should be one range for the full I/O register region
-			(including USART, TWI and SPI registers).
-- atmel,flexcom-mode:	Should be one of the following values:
-			- <1> for USART
-			- <2> for SPI
-			- <3> for I2C
-
-Required child:
-A single available child device of type matching the "atmel,flexcom-mode"
-property.
-
-The phandle provided by the clocks property of the child is the same as one for
-the Flexcom parent.
-
-For other properties, please refer to the documentations of the respective
-device:
-- ../serial/atmel-usart.txt
-- ../spi/spi_atmel.txt
-- ../i2c/i2c-at91.txt
-
-Example:
-
-flexcom@f8034000 {
-	compatible = "atmel,sama5d2-flexcom";
-	reg = <0xf8034000 0x200>;
-	clocks = <&flx0_clk>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges = <0x0 0xf8034000 0x800>;
-	atmel,flexcom-mode = <2>;
-
-	spi@400 {
-		compatible = "atmel,at91rm9200-spi";
-		reg = <0x400 0x200>;
-		interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flx0_default>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&flx0_clk>;
-		clock-names = "spi_clk";
-		atmel,fifo-size = <32>;
-
-		flash@0 {
-			compatible = "atmel,at25f512b";
-			reg = <0>;
-			spi-max-frequency = <20000000>;
-		};
-	};
-};

-- 
2.25.1


