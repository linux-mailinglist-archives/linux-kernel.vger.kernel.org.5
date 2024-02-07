Return-Path: <linux-kernel+bounces-56239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5FE84C7C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396D01F28B6E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515422338;
	Wed,  7 Feb 2024 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pmFBVayh"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747B2376C;
	Wed,  7 Feb 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298967; cv=none; b=S53PCiW22+mY4isrzG/fwTYi2z9RT/oyMIcoNLGP79LfVzC659G8kKrFkyJfUqUNLwHJpdC6xj22VjKiyo6sB9KFpVt9BJoqU4lRtr+rO+XUJBTJ190SZfBAS8ELCIVvgqAs6W+lROufLh0V0awDz+sa8Srbwb3+6hpooLlqL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298967; c=relaxed/simple;
	bh=eaPjoMfznAH4IZPj/39ikg5X854USdvackzLWMpCGwI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DIg6Kfz+kcv0geC004dwYEMnCBZLINNAQ9/lFwoJZo3wqHNCv+gs2/tFiNF/IfebLj3oPTj8oghsUa6PD60kLJQlSNc/XDj6J0vo4LGpiB1M9uoFLSKtRVMxY2kmEf6ubeGRC4Zpj/SAlDKs0VnBx5DHZ/FBW5KhMhcd4jOG0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pmFBVayh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707298964; x=1738834964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eaPjoMfznAH4IZPj/39ikg5X854USdvackzLWMpCGwI=;
  b=pmFBVayhw9A7DBhzegwByBBKtQt/h1IUSR+a4UHUePar1OFPhxMoQIaX
   ToBG/z6knZSgnrzP9Ja611bWSQkzwSTpiyymbMm7gxPXun2qAV4SA2EbV
   R0mfJux/hU6xFTKq/JdYrORXkuUBM8UM+RxKwqZOkKYx7qSe1HaIKgp46
   walrdMykclpBxduihHr4wBU9r6hQr2r0UvgDR1m+AYhqhwUz3L4v922Dg
   YU2QCKwiXbCYw1ROUhgWMCk4za4eWx9clOhrlA3gKoQc493jPljpvaOTO
   p0RRoAym0xoJvNeHJU1ioJ9/fY2Tk0wheO1h+anfdIa+TDinPRC4dxGjY
   w==;
X-CSE-ConnectionGUID: fRBUDne2SeOxScIZjr2Gpg==
X-CSE-MsgGUID: gMnZzN7ETgKrlsrBwpz63Q==
X-IronPort-AV: E=Sophos;i="6.05,250,1701154800"; 
   d="scan'208";a="15884586"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2024 02:42:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 02:41:55 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 02:41:49 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <dharma.b@microchip.com>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <hari.prasathge@microchip.com>
Subject: [PATCH] ASoC: dt-bindings: atmel,asoc-wm8904: Convert to json-schema
Date: Wed, 7 Feb 2024 15:11:44 +0530
Message-ID: <20240207094144.195397-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Convert atmel,asoc-wm8904 devicetree binding to json-schema.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 .../bindings/sound/atmel,asoc-wm8904.yaml     | 84 +++++++++++++++++++
 .../bindings/sound/atmel-wm8904.txt           | 55 ------------
 2 files changed, 84 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,asoc-wm8904.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-wm8904.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel,asoc-wm8904.yaml b/Documentation/devicetree/bindings/sound/atmel,asoc-wm8904.yaml
new file mode 100644
index 000000000000..89a67f8e33b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel,asoc-wm8904.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/atmel,asoc-wm8904.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel wm8904 audio codec complex
+
+maintainers:
+  - Dharma Balasubiramani <dharma.b@microchip.com>
+
+description:
+  The ASoC audio complex configuration for Atmel with WM8904 audio codec.
+
+properties:
+  compatible:
+    const: atmel,asoc-wm8904
+
+  atmel,model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The user-visible name of this sound complex.
+
+  atmel,ssc-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the SSC controller.
+
+  atmel,audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the WM8731 audio codec.
+
+  atmel,audio-routing:
+    description:
+      A list of the connections between audio components. Each entry is a pair
+      of strings, the first being the connection's sink, the second being the
+      connection's source.
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    items:
+      enum:
+        # Board Connectors
+        - Headphone Jack
+        - Line In Jack
+        - Mic
+        # WM8904 CODEC Pins
+        - IN1L
+        - IN1R
+        - IN2L
+        - IN2R
+        - IN3L
+        - IN3R
+        - HPOUTL
+        - HPOUTR
+        - LINEOUTL
+        - LINEOUTR
+        - MICBIAS
+
+required:
+  - compatible
+  - atmel,model
+  - atmel,audio-routing
+  - atmel,ssc-controller
+  - atmel,audio-codec
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "atmel,asoc-wm8904";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pck0_as_mck>;
+
+        atmel,model = "wm8904 @ AT91SAM9N12EK";
+
+        atmel,audio-routing =
+                "Headphone Jack", "HPOUTL",
+                "Headphone Jack", "HPOUTR",
+                "IN2L", "Line In Jack",
+                "IN2R", "Line In Jack",
+                "Mic", "MICBIAS",
+                "IN1L", "Mic";
+
+        atmel,ssc-controller = <&ssc0>;
+        atmel,audio-codec = <&wm8904>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
deleted file mode 100644
index 8bbe50c884b6..000000000000
--- a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-Atmel ASoC driver with wm8904 audio codec complex
-
-Required properties:
-  - compatible: "atmel,asoc-wm8904"
-  - atmel,model: The user-visible name of this sound complex.
-  - atmel,audio-routing: A list of the connections between audio components.
-    Each entry is a pair of strings, the first being the connection's sink,
-    the second being the connection's source. Valid names for sources and
-    sinks are the WM8904's pins, and the jacks on the board:
-
-    WM8904 pins:
-
-    * IN1L
-    * IN1R
-    * IN2L
-    * IN2R
-    * IN3L
-    * IN3R
-    * HPOUTL
-    * HPOUTR
-    * LINEOUTL
-    * LINEOUTR
-    * MICBIAS
-
-    Board connectors:
-
-    * Headphone Jack
-    * Line In Jack
-    * Mic
-
-  - atmel,ssc-controller: The phandle of the SSC controller
-  - atmel,audio-codec: The phandle of the WM8904 audio codec
-
-Optional properties:
-  - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
-
-Example:
-sound {
-	compatible = "atmel,asoc-wm8904";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pck0_as_mck>;
-
-	atmel,model = "wm8904 @ AT91SAM9N12EK";
-
-	atmel,audio-routing =
-		"Headphone Jack", "HPOUTL",
-		"Headphone Jack", "HPOUTR",
-		"IN2L", "Line In Jack",
-		"IN2R", "Line In Jack",
-		"Mic", "MICBIAS",
-		"IN1L", "Mic";
-
-	atmel,ssc-controller = <&ssc0>;
-	atmel,audio-codec = <&wm8904>;
-};
-- 
2.25.1


