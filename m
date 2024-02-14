Return-Path: <linux-kernel+bounces-64758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FEE854280
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11403B21D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4D101FA;
	Wed, 14 Feb 2024 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s71ahCeE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34FC11183;
	Wed, 14 Feb 2024 05:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707889478; cv=none; b=e4m8F/mk5j4KPWslL6SK/pXT0FE25/GG4yl/PQnMUst4A9ehI5s5vSckMT3YNCsXEH8ol5MvJm8OLVtoPFvpPXfeZdCiwChXbOxRa/pSzGCXbiZ26TxCpAEie/ViviS+kSyXv2BPdmELmE15n9+7gfvlXHjo8U4S/BmtETfypWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707889478; c=relaxed/simple;
	bh=GNw4J/KFvcmUundha/TAxbmJFey7T/uVB6L9JYLTTIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=WCc1XpkK6kqkcDEGusCZyjQOUfwHX7xBYML0dHJ58d8PNghF3/S4xaDxF5ixVqhf+p/aYZI+tpveg0kDZfz8jWrlAbabdkm0aiGjCWQPJT/qnMxsl4Ote75HGsUri1mci4S+FYnOWy6ToRNcvBehweAVsJeL+sGMXXPfHliAF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s71ahCeE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707889475; x=1739425475;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=GNw4J/KFvcmUundha/TAxbmJFey7T/uVB6L9JYLTTIU=;
  b=s71ahCeEqszShbMVFCBX0ZBtim0LrwsyFsYMr1rUMVYCPybwsGwgbYZu
   //Uy5B4yqxvziSYQRkix89d+R3c8imUAGbOMlYuVIuLfTFhbATP/PE4XG
   SQhnmguDYdzhWUx4JwpjhvkMMAus1uBZakfc4pGUoYZ/wXmffxRfrJsF1
   Q2OJzEEuSBk+/M1bc0J1SkIEMeqdRheQ0u6xsZfMfPEEqOu/1Qelsa6QF
   q3Z+/3HA7udcyM5UToX8DiLhUROqydraN2qjHRvlL7CKF+9FBKVV+hwH+
   LnylHbXS5R9SxvY1JwcoqDdPHZrN6FgxvYQLwrlqDNLS/3BVM2oVUBAXC
   g==;
X-CSE-ConnectionGUID: YUbQA9s/RgiTYXtTM1m92A==
X-CSE-MsgGUID: waKejkziQUyMUj0I4zCgQw==
X-IronPort-AV: E=Sophos;i="6.06,159,1705388400"; 
   d="scan'208";a="17662184"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 22:44:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 22:44:03 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 22:43:59 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Wed, 14 Feb 2024 11:13:43 +0530
Subject: [PATCH] dt-bindings: mfd: Convert atmel-flexcom to json-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240214-sama5d2-flexcom-yaml-v1-1-5dedd0eba08e@microchip.com>
X-B4-Tracking: v=1; b=H4sIAA5TzGUC/x3MQQqAIBBA0avErBswzaiuEi1ExxrICoUworsnL
 d/i/wcSRaYEY/VApIsTH3tBU1dgV7MvhOyKQQrZCtkoTCYY7ST6jbI9At4mbKiEtb4bhk7pHkp
 6RvKc/+00v+8HFcdF6mYAAAA=
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Kavyasree Kotagiri
	<kavyasree.kotagiri@microchip.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Hari Prasath Gujulan Elango
	<hari.prasathge@microchip.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>
X-Mailer: b4 0.12.4

From: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>

Convert the Atmel flexcom device tree bindings to json schema.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
The yaml DT bindings for the atmel-flexcom driver were submitted
upstream in a separate patch series in 2022 [1] which was Acked-by
Krzysztof Kozlowski. However, it has been observed recently that the
patch has not been merged into the mainline codebase.When attempting to
apply the patch to the latest upstream kernel,a conflict arose due to a
recent addition to the original device tree binding in text format. The
conflict has now been resolved and we are sending a updated version of
the patch. 
[1]https://lore.kernel.org/linux-arm-kernel/22063373-6060-d605-62af-35d82ba1729c@linaro.org/
---
 .../bindings/mfd/atmel,sama5d2-flexcom.yaml        | 92 ++++++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt      | 64 ---------------
 2 files changed, 92 insertions(+), 64 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
new file mode 100644
index 000000000000..f28522cd987a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/atmel,sama5d2-flexcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Flexcom (Flexible Serial Communication Unit)
+
+maintainers:
+  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
+
+description:
+  The Atmel Flexcom is just a wrapper which embeds a SPI controller,
+  an I2C controller and an USART. Only one function can be used at a
+  time and is chosen at boot time according to the device tree.
+
+properties:
+  compatible:
+    enum:
+      - atmel,sama5d2-flexcom
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

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240213-sama5d2-flexcom-yaml-30ccf6996358

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>


