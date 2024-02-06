Return-Path: <linux-kernel+bounces-54377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB7B84AE76
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964151F23C23
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4511128803;
	Tue,  6 Feb 2024 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QW0XFVx0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EAB74E03;
	Tue,  6 Feb 2024 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201889; cv=none; b=WukSVx9l/AKtS9hkbPgglbtOFXWjhmkz/rCt/sDsr292Ivuvmj6hSorHE2sAkSAcsI6pApW6d4AvegnKI+jwJ3d+qP5pdpVkzdAwdRuInNh1qZp3pnYXdkbg0Ofxf44jc8F7DVTXPalDz7isw+Q3HRHBQnXFQB8WMwmP+2uAGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201889; c=relaxed/simple;
	bh=6NTsi8MTHhKSU1zdGgcR2NazjNxpJ4OkB7k2y0vpsVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Um/SOg5awqsqq+yAT21qfAy+vWHDQMNZVmbQ4K1zmYM5k64PucXoMdsOQXnD2eo+0fSQz/MYDeS9z+1W5BLMQECuY0RRnoccXde2vI2jI/0VJZH1vb8b46xqUNV5h690ulvUY6ceQiwPW/TlCIR7mIfVczP6Kgef7CuJvrWn5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QW0XFVx0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707201887; x=1738737887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6NTsi8MTHhKSU1zdGgcR2NazjNxpJ4OkB7k2y0vpsVc=;
  b=QW0XFVx0W4bIgxRyjfqq+pFfEuYe3xkNBsylx+bukq8ijz1jYcK2i7w0
   zls27XP7hxNrS78lLTpMY6SFpeOkNY4txX+J9LHpNvSuHSCfB1VgxveoR
   Nq6z+Fh1U1JUYeLP4zLdfZZDSr/Z/ipJGYOD5tjLV4WiEJJf/vET3Q7/1
   NKZxz4ffTR9iOZ06aM69rRM8oETJ9JkMbss7mZMDGxhK2pHHhYeXeT+ev
   wATix8nzKjbCS0Oz9LmVmjA4X8PVGBPRFAmiQlgcM4qS6WK1HmJVc791/
   +QczhlXcTWtv9iS2Wauj5fI2GV4txOZ9hlBiQ8QdEA/zgPAo7NWoHoa7x
   A==;
X-CSE-ConnectionGUID: 5cKW/z4QQq6KFQyHa1Y4Bg==
X-CSE-MsgGUID: xRRXybZ8QuS7vPMPAREMRA==
X-IronPort-AV: E=Sophos;i="6.05,246,1701154800"; 
   d="scan'208";a="15812734"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 23:44:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 23:44:29 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 23:44:23 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <dharma.b@microchip.com>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <hari.prasathge@microchip.com>
Subject: [linux][PATCH] ASoC: dt-bindings: atmel,sam9x5-wm8731: Convert to json-schema
Date: Tue, 6 Feb 2024 12:14:18 +0530
Message-ID: <20240206064418.237377-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Convert atmel sam9x5-wm8731-audio devicetree binding to json-schema.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 .../sound/atmel,sam9x5-wm8731-audio.yaml      | 76 +++++++++++++++++++
 .../sound/atmel-sam9x5-wm8731-audio.txt       | 35 ---------
 2 files changed, 76 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,sam9x5-wm8731-audio.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel,sam9x5-wm8731-audio.yaml b/Documentation/devicetree/bindings/sound/atmel,sam9x5-wm8731-audio.yaml
new file mode 100644
index 000000000000..33717b728f63
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel,sam9x5-wm8731-audio.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/atmel,sam9x5-wm8731-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel at91sam9x5ek wm8731 audio complex
+
+maintainers:
+  - Dharma Balasubiramani <dharma.b@microchip.com>
+
+description:
+  The audio complex configuration for Atmel at91sam9x5ek with WM8731 audio codec.
+
+properties:
+  compatible:
+    const: atmel,sam9x5-wm8731-audio
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
+
+        # CODEC Pins
+        - LOUT
+        - ROUT
+        - LHPOUT
+        - RHPOUT
+        - LLINEIN
+        - RLINEIN
+        - MICIN
+
+required:
+  - compatible
+  - atmel,model
+  - atmel,ssc-controller
+  - atmel,audio-codec
+  - atmel,audio-routing
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "atmel,sam9x5-wm8731-audio";
+
+        atmel,model = "wm8731 @ AT91SAM9X5EK";
+
+        atmel,audio-routing =
+                "Headphone Jack", "RHPOUT",
+                "Headphone Jack", "LHPOUT",
+                "LLINEIN", "Line In Jack",
+                "RLINEIN", "Line In Jack";
+
+        atmel,ssc-controller = <&ssc0>;
+        atmel,audio-codec = <&wm8731>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt b/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
deleted file mode 100644
index 8facbce53db8..000000000000
--- a/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* Atmel at91sam9x5ek wm8731 audio complex
-
-Required properties:
-  - compatible: "atmel,sam9x5-wm8731-audio"
-  - atmel,model: The user-visible name of this sound complex.
-  - atmel,ssc-controller: The phandle of the SSC controller
-  - atmel,audio-codec: The phandle of the WM8731 audio codec
-  - atmel,audio-routing: A list of the connections between audio components.
-    Each entry is a pair of strings, the first being the connection's sink,
-    the second being the connection's source.
-
-Available audio endpoints for the audio-routing table:
-
-Board connectors:
- * Headphone Jack
- * Line In Jack
-
-wm8731 pins:
-cf Documentation/devicetree/bindings/sound/wlf,wm8731.yaml
-
-Example:
-sound {
-	compatible = "atmel,sam9x5-wm8731-audio";
-
-	atmel,model = "wm8731 @ AT91SAM9X5EK";
-
-	atmel,audio-routing =
-		"Headphone Jack", "RHPOUT",
-		"Headphone Jack", "LHPOUT",
-		"LLINEIN", "Line In Jack",
-		"RLINEIN", "Line In Jack";
-
-	atmel,ssc-controller = <&ssc0>;
-	atmel,audio-codec = <&wm8731>;
-};
-- 
2.25.1


