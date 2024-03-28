Return-Path: <linux-kernel+bounces-111294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC57886A51
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F93A1C2221C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473603F8F4;
	Fri, 22 Mar 2024 10:30:21 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE7A3CF79;
	Fri, 22 Mar 2024 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103420; cv=none; b=UDYMfInfJbauam4ZoEHfyiuqwoxkGSei/GJfbJOw73NLJvIXB1/MW0y1x6oSDckiI3i5eonTC9liKDx6UFFgnQfKFXfvJWleap1YyUXTerLtzaWafxWzk9mBR9F2AE4bV9SqJek18k/zvHYgc5HvkPZqPtv3N339E+Ra/WZdSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103420; c=relaxed/simple;
	bh=Ir6UgQpxRd3H2lL0X+fpaDtwZNgzUoLJRkTmekBFT9Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=acYXqz6P/8pa4qm/29zjaJ8Eg6zOY61Oi937LL+GkXsOYoJrHYnOK4cT2a/EysZuycs0lSURKd5ifEZTB/Q6cmiSBr86WLOy+IufIKZSUYLRtL7q7CZukRS7dne2QbGf+zIzAf3JfxZHFekVbyGslAq21QIYWDkBccLXS6Mymok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E1342200FAA;
	Fri, 22 Mar 2024 11:30:10 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4EEB4200831;
	Fri, 22 Mar 2024 11:30:10 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 19CBC183AD17;
	Fri, 22 Mar 2024 18:30:08 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] ASoC: dt-bindings: fsl-asoc-card: convert to YAML
Date: Fri, 22 Mar 2024 18:13:25 +0800
Message-Id: <1711102406-8399-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711102406-8399-1-git-send-email-shengjiu.wang@nxp.com>
References: <1711102406-8399-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Convert the fsl-asoc-card binding to YAML.

In order to pass the checking, add some used compatible
string from devicetree.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../bindings/sound/fsl-asoc-card.txt          | 117 -----------
 .../bindings/sound/fsl-asoc-card.yaml         | 196 ++++++++++++++++++
 2 files changed, 196 insertions(+), 117 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
deleted file mode 100644
index 4e8dbc5abfd1..000000000000
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ /dev/null
@@ -1,117 +0,0 @@
-Freescale Generic ASoC Sound Card with ASRC support
-
-The Freescale Generic ASoC Sound Card can be used, ideally, for all Freescale
-SoCs connecting with external CODECs.
-
-The idea of this generic sound card is a bit like ASoC Simple Card. However,
-for Freescale SoCs (especially those released in recent years), most of them
-have ASRC (Documentation/devicetree/bindings/sound/fsl,asrc.txt) inside. And
-this is a specific feature that might be painstakingly controlled and merged
-into the Simple Card.
-
-So having this generic sound card allows all Freescale SoC users to benefit
-from the simplification of a new card support and the capability of the wide
-sample rates support through ASRC.
-
-Note: The card is initially designed for those sound cards who use AC'97, I2S
-      and PCM DAI formats. However, it'll be also possible to support those non
-      AC'97/I2S/PCM type sound cards, such as S/PDIF audio and HDMI audio, as
-      long as the driver has been properly upgraded.
-
-
-The compatible list for this generic sound card currently:
- "fsl,imx-audio-ac97"
-
- "fsl,imx-audio-cs42888"
-
- "fsl,imx-audio-cs427x"
- (compatible with CS4271 and CS4272)
-
- "fsl,imx-audio-wm8962"
-
- "fsl,imx-audio-sgtl5000"
- (compatible with Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt)
-
- "fsl,imx-audio-wm8960"
-
- "fsl,imx-audio-mqs"
-
- "fsl,imx-audio-wm8524"
-
- "fsl,imx-audio-tlv320aic32x4"
-
- "fsl,imx-audio-tlv320aic31xx"
-
- "fsl,imx-audio-si476x"
-
- "fsl,imx-audio-wm8958"
-
- "fsl,imx-audio-nau8822"
-
-Required properties:
-
-  - compatible		: Contains one of entries in the compatible list.
-
-  - model		: The user-visible name of this sound complex
-
-  - audio-cpu		: The phandle of an CPU DAI controller
-
-  - audio-codec		: The phandle of an audio codec
-
-Optional properties:
-
-  - audio-asrc		: The phandle of ASRC. It can be absent if there's no
-			  need to add ASRC support via DPCM.
-
-  - audio-routing	: A list of the connections between audio components.
-			  Each entry is a pair of strings, the first being the
-			  connection's sink, the second being the connection's
-			  source. There're a few pre-designed board connectors:
-			   * Line Out Jack
-			   * Line In Jack
-			   * Headphone Jack
-			   * Mic Jack
-			   * Ext Spk
-			   * AMIC (stands for Analog Microphone Jack)
-			   * DMIC (stands for Digital Microphone Jack)
-
-			  Note: The "Mic Jack" and "AMIC" are redundant while
-			        coexisting in order to support the old bindings
-				of wm8962 and sgtl5000.
-
-  - hp-det-gpio		: The GPIO that detect headphones are plugged in
-  - mic-det-gpio	: The GPIO that detect microphones are plugged in
-  - bitclock-master	: Indicates dai-link bit clock master; for details see simple-card.yaml.
-  - frame-master	: Indicates dai-link frame master; for details see simple-card.yaml.
-  - dai-format		: audio format, for details see simple-card.yaml.
-  - frame-inversion	: dai-link uses frame clock inversion, for details see simple-card.yaml.
-  - bitclock-inversion	: dai-link uses bit clock inversion, for details see simple-card.yaml.
-  - mclk-id		: main clock id, specific for each card configuration.
-
-Optional unless SSI is selected as a CPU DAI:
-
-  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX)
-
-  - mux-ext-port	: The external port of the i.MX audio muxer
-
-Example:
-sound-cs42888 {
-	compatible = "fsl,imx-audio-cs42888";
-	model = "cs42888-audio";
-	audio-cpu = <&esai>;
-	audio-asrc = <&asrc>;
-	audio-codec = <&cs42888>;
-	audio-routing =
-		"Line Out Jack", "AOUT1L",
-		"Line Out Jack", "AOUT1R",
-		"Line Out Jack", "AOUT2L",
-		"Line Out Jack", "AOUT2R",
-		"Line Out Jack", "AOUT3L",
-		"Line Out Jack", "AOUT3R",
-		"Line Out Jack", "AOUT4L",
-		"Line Out Jack", "AOUT4R",
-		"AIN1L", "Line In Jack",
-		"AIN1R", "Line In Jack",
-		"AIN2L", "Line In Jack",
-		"AIN2R", "Line In Jack";
-};
diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml b/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
new file mode 100644
index 000000000000..48051655230d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
@@ -0,0 +1,196 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl-asoc-card.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Generic ASoC Sound Card with ASRC support
+
+description:
+  The Freescale Generic ASoC Sound Card can be used, ideally,
+  for all Freescale SoCs connecting with external CODECs.
+
+  The idea of this generic sound card is a bit like ASoC Simple Card.
+  However, for Freescale SoCs (especially those released in recent years),
+  most of them have ASRC
+  (Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml) inside. And
+  this is a specific feature that might be painstakingly controlled and
+  merged into the Simple Card.
+
+  So having this generic sound card allows all Freescale SoC users to
+  benefit from the simplification of a new card support and the capability
+  of the wide sample rates support through ASRC.
+
+  Note, The card is initially designed for those sound cards who use AC'97, I2S
+  and PCM DAI formats. However, it'll be also possible to support those non
+  AC'97/I2S/PCM type sound cards, such as S/PDIF audio and HDMI audio, as
+  long as the driver has been properly upgraded.
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx-sgtl5000
+              - fsl,imx53-cpuvo-sgtl5000
+              - fsl,imx51-babbage-sgtl5000
+              - fsl,imx53-m53evk-sgtl5000
+              - fsl,imx53-qsb-sgtl5000
+              - fsl,imx53-voipac-sgtl5000
+              - fsl,imx6-armadeus-sgtl5000
+              - fsl,imx6-rex-sgtl5000
+              - fsl,imx6-sabreauto-cs42888
+              - fsl,imx6-wandboard-sgtl5000
+              - fsl,imx6dl-nit6xlite-sgtl5000
+              - fsl,imx6q-ba16-sgtl5000
+              - fsl,imx6q-nitrogen6_max-sgtl5000
+              - fsl,imx6q-nitrogen6_som2-sgtl5000
+              - fsl,imx6q-nitrogen6x-sgtl5000
+              - fsl,imx6q-sabrelite-sgtl5000
+              - fsl,imx6q-sabresd-wm8962
+              - fsl,imx6q-udoo-ac97
+              - fsl,imx6q-ventana-sgtl5000
+              - fsl,imx6sl-evk-wm8962
+              - fsl,imx6sx-sdb-mqs
+              - fsl,imx6sx-sdb-wm8962
+              - fsl,imx7d-evk-wm8960
+              - karo,tx53-audio-sgtl5000
+              - tq,imx53-mba53-sgtl5000
+          - enum:
+              - fsl,imx-audio-ac97
+              - fsl,imx-audio-cs42888
+              - fsl,imx-audio-mqs
+              - fsl,imx-audio-sgtl5000
+              - fsl,imx-audio-wm8960
+              - fsl,imx-audio-wm8962
+      - items:
+          - enum:
+              - fsl,imx-audio-ac97
+              - fsl,imx-audio-cs42888
+              - fsl,imx-audio-cs427x
+              - fsl,imx-audio-mqs
+              - fsl,imx-audio-nau8822
+              - fsl,imx-audio-sgtl5000
+              - fsl,imx-audio-si476x
+              - fsl,imx-audio-tlv320aic31xx
+              - fsl,imx-audio-tlv320aic32x4
+              - fsl,imx-audio-wm8524
+              - fsl,imx-audio-wm8960
+              - fsl,imx-audio-wm8962
+              - fsl,imx-audio-wm8958
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The user-visible name of this sound complex
+
+  audio-asrc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of ASRC. It can be absent if there's no
+      need to add ASRC support via DPCM.
+
+  audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of an audio codec
+
+  audio-cpu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of an CPU DAI controller
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source. There're a few pre-designed board
+      connectors.
+        * Line Out Jack
+        * Line In Jack
+        * Headphone Jack
+        * Mic Jack
+        * Ext Spk
+        * AMIC (stands for Analog Microphone Jack)
+        * DMIC (stands for Digital Microphone Jack)
+      Note, The "Mic Jack" and "AMIC" are redundant while coexisting in
+      order to support the old bindings of wm8962 and sgtl5000.
+
+  hp-det-gpio:
+    maxItems: 1
+    description: The GPIO that detect headphones are plugged in
+
+  hp-det-gpios:
+    maxItems: 1
+    description: The GPIO that detect headphones are plugged in
+
+  mic-det-gpio:
+    maxItems: 1
+    description: The GPIO that detect microphones are plugged in
+
+  mic-det-gpios:
+    maxItems: 1
+    description: The GPIO that detect microphones are plugged in
+
+  bitclock-master:
+    description: Indicates dai-link bit clock master; for details see simple-card.yaml.
+
+  frame-master:
+    description: Indicates dai-link frame master; for details see simple-card.yaml.
+
+  dai-format:
+    description: audio format, for details see simple-card.yaml.
+
+  frame-inversion:
+    description: dai-link uses frame clock inversion, for details see simple-card.yaml.
+
+  bitclock-inversion:
+    description: dai-link uses bit clock inversion, for details see simple-card.yaml.
+
+  mclk-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: main clock id, specific for each card configuration.
+
+  mux-int-port:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 7]
+    description: The internal port of the i.MX audio muxer (AUDMUX)
+
+  mux-ext-port:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [3, 4, 5, 6]
+    description: The external port of the i.MX audio muxer
+
+  ssi-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of an CPU DAI controller
+
+required:
+  - compatible
+  - model
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sound-cs42888 {
+        compatible = "fsl,imx-audio-cs42888";
+        model = "cs42888-audio";
+        audio-cpu = <&esai>;
+        audio-asrc = <&asrc>;
+        audio-codec = <&cs42888>;
+        audio-routing =
+             "Line Out Jack", "AOUT1L",
+             "Line Out Jack", "AOUT1R",
+             "Line Out Jack", "AOUT2L",
+             "Line Out Jack", "AOUT2R",
+             "Line Out Jack", "AOUT3L",
+             "Line Out Jack", "AOUT3R",
+             "Line Out Jack", "AOUT4L",
+             "Line Out Jack", "AOUT4R",
+             "AIN1L", "Line In Jack",
+             "AIN1R", "Line In Jack",
+             "AIN2L", "Line In Jack",
+             "AIN2R", "Line In Jack";
+    };
-- 
2.34.1


