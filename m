Return-Path: <linux-kernel+bounces-64805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E8854305
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07247B284BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF70C12B6D;
	Wed, 14 Feb 2024 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FSncoOkU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92CA12B6C;
	Wed, 14 Feb 2024 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892818; cv=none; b=mHxG0wMCFx3ltxNDwgzWkpToYKMi+fnUshpFafqXaKaLzHcxe4FFZ9Ou3/oM4/htwIGkrbT5G86Vus/4ZKWGkIClTp4bN1i5ORL/41RTqa6dgAF8vsVRNjhCzixJfvPN1e48pHpotVyQ1IDqVxBLokpN0SKyrhqLxmxAUlR8bXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892818; c=relaxed/simple;
	bh=wsHVfr8hdZBYZbP2L9EO1WVTmS/EVBmRVwV/3aRh+cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=auyhQVlpjDI2o0iiPVotAa/HxqOwFw/KnsSKR7QNwTXJCRdVO9EqiwR1I1HegDpnxGyXuMLFCHBrLhVCtoGw9d7GjmZdlH5YMN2Ro3uZkZuxPrNrS2eiZTCgppL3hZoCPCIaVPQICWc/r5aOaqZW6r3LKcs0X/BFkzWMwmOW/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FSncoOkU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707892815; x=1739428815;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=wsHVfr8hdZBYZbP2L9EO1WVTmS/EVBmRVwV/3aRh+cQ=;
  b=FSncoOkUqcdbw6ryAhUeDYsgK/U/h7zWOTJxONx7sUlw+VU1rJ3PN4H8
   tIDvSpBQB2gvlPQtzW1Y9+ZadJyfVIg6qK6A5kFzDdPisLCGVJGrA1tA9
   EtRcvq0i+IvcuudBQpnzDjx+1MSXeywenmcT3UX0booabf0p2y33WAtnP
   jlYAw3t1i+xQwxEDIcCsDBdbdRinxXon9pYYiKeIY1yz7pFYQEtDrrpNe
   KgasEPlLdnp+zg8rfxwDxy3HHWuMsdIcxqlZRA7vK8chh6X28lvUluMQH
   jhO0/tynSuETTN6sEkW+A7rV9GqPobfSf4wYkNAWd/arWiH2VZLx2znod
   A==;
X-CSE-ConnectionGUID: Ym+jSPJASQmf8byUSlOr0w==
X-CSE-MsgGUID: B+vCBEvPTBmYybQn1ZsH9A==
X-IronPort-AV: E=Sophos;i="6.06,159,1705388400"; 
   d="scan'208";a="17663685"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 23:40:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 23:40:12 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 23:40:07 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Wed, 14 Feb 2024 12:10:06 +0530
Subject: [PATCH] dt-bindings: sound:atmel-at91sam9g20ek: convert bindings
 to json-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com>
X-B4-Tracking: v=1; b=H4sIAEVgzGUC/x2MywqDMBAAf0X23IVsDNj4K8XDqltdaqwk4gPx3
 xs6tznMXJAkqiSoiwuibJr0O2ehRwHdyPMgqH12sMY6Y8khr54SBz9YIx/cw7MqCU8OEzrj+kz
 bemLI/RLlrcf//Wru+wcz//ayawAAAA==
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>
X-Mailer: b4 0.12.4

Convert atmel-at91sam9g20ek-wm8731-audio DT binding to yaml
based json-schema.Change file name to match json-scheme naming.

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 .../bindings/sound/atmel,at91sam9g20ek-wm8731.yaml | 60 ++++++++++++++++++++++
 .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     | 26 ----------
 2 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml b/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml
new file mode 100644
index 000000000000..f6330707fe1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/atmel,at91sam9g20ek-wm8731.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel at91sam9g20ek wm8731 audio complex
+
+maintainers:
+  - Balakrishnan Sambath <balakrishnan.s@microchip.com>
+
+properties:
+  compatible:
+    const: atmel,at91sam9g20ek-wm8731-audio
+
+  atmel,model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The user-visible name of this sound complex.
+  atmel,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: A list of the connections between audio components.
+    minItems: 2
+    items:
+      enum:
+        # Board Connectors
+        - "Ext Spk"
+        - "Int MIC"
+
+        # CODEC Pins
+        - LHPOUT
+        - MICIN
+  atmel,ssc-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the SSC controller
+  atmel,audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of WM8731 audio codec
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
+        compatible = "atmel,at91sam9g20ek-wm8731-audio";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pck0_as_mck>;
+        atmel,model = "wm8731 @ AT91SAMG20EK";
+        atmel,audio-routing =
+            "Ext Spk", "LHPOUT",
+            "Int MIC", "MICIN";
+        atmel,ssc-controller = <&ssc0>;
+        atmel,audio-codec = <&wm8731>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt b/Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt
deleted file mode 100644
index 9c5a9947b64d..000000000000
--- a/Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* Atmel at91sam9g20ek wm8731 audio complex
-
-Required properties:
-  - compatible: "atmel,at91sam9g20ek-wm8731-audio"
-  - atmel,model: The user-visible name of this sound complex.
-  - atmel,audio-routing: A list of the connections between audio components.
-  - atmel,ssc-controller: The phandle of the SSC controller
-  - atmel,audio-codec: The phandle of the WM8731 audio codec
-Optional properties:
-  - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
-
-Example:
-sound {
-	compatible = "atmel,at91sam9g20ek-wm8731-audio";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pck0_as_mck>;
-
-	atmel,model = "wm8731 @ AT91SAMG20EK";
-
-	atmel,audio-routing =
-		"Ext Spk", "LHPOUT",
-		"Int MIC", "MICIN";
-
-	atmel,ssc-controller = <&ssc0>;
-	atmel,audio-codec = <&wm8731>;
-};

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240214-at91sam9g20ek-wm8731-yaml-404ddddbb91a

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>


