Return-Path: <linux-kernel+bounces-104333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114DC87CC43
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5572328274A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261F51B81C;
	Fri, 15 Mar 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UpJMKl+T"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5AE1B295;
	Fri, 15 Mar 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502080; cv=none; b=FN0MP9+U6CLAbBPFqzr+n9bAMar+7ixdrXPIZaZT7rmB7mV6f27RKt/nuH1FwhrP+PgRu9XHGfoM7ca54e10iT3v3AlZP1OmPOT5dUrNfF57VwjLfncDgNZ+Mk4CNz2rqjq41OBkD/rAOzbL1ZpoOCQTpaG9txhnuyf6n0swisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502080; c=relaxed/simple;
	bh=H4RG/XZrAHW/3xUIR1pTsc+DN9COf1TDojyeYAQW0cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1eGcM8mcwoF8CFpyy/S1yLk1ethll3A9Vw/dA7ZcYy1osBIn4l9NoEVx84GDVa3TJHY/oiFEdlueAtaCOX4oiDugXciF0Qk+0DQsKketqVxPN3oXKSqvKtFcGttelO55Tl76MM2iqyTV7MOVP86YRHt9m8oaAqvs/tUkH5gDmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UpJMKl+T; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 3D771E0003;
	Fri, 15 Mar 2024 11:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUAcXFtPdRzxlgNNFBRR/Bz60z5XFsvCtl6oMmi/Tnk=;
	b=UpJMKl+Tk1kwzSGv27hqthWfNw3H5waB3ZX7b7gxVp9N4uF3iz5yzlx444ZmmD6qbYECIT
	nZBjQavUzL/LwuU4+Zc0WprIbPgQVVrgHbyjhXWSzBpfjLqZDjIHn10ZVSAODEkDMjBnrQ
	dcFqjCJG+32dXyce2ExLOQ7bnjlPeoO/9sFeZso9bjsL98edt3vmEb0gdKXfLTApzXt+52
	xeWKkGVToHRTLT60/8FtRzPC49xtiKEwdPDvWinuOX69KoIY9mNBMKoq6gUp4RSQqL/cK5
	qa8WowHGk63UGwHquYrLK3OMBAsLNJYDymfbVuC6FUULl1aV4BncJsZyXyVnbA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH 01/13] ASoC: dt-bindings: davinci-mcbsp: convert McBSP bindings to yaml schema
Date: Fri, 15 Mar 2024 12:27:33 +0100
Message-ID: <20240315112745.63230-2-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Convert the binding for McBSP controllers for TI SoCs from txt
to YAML schema.

Add properties 'clocks', 'clock-names', 'power-domains' and
'#sound-dai-cells' which were missing from the txt file.
Add '#sound-dai-cells' and 'clocks' in the example which were missing
from the txt file.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 .../bindings/sound/davinci-mcbsp.txt          | 50 ----------
 .../bindings/sound/davinci-mcbsp.yaml         | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
deleted file mode 100644
index 3ffc2562fb31..000000000000
--- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-Texas Instruments DaVinci McBSP module
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-This binding describes the "Multi-channel Buffered Serial Port" (McBSP)
-audio interface found in some TI DaVinci processors like the OMAP-L138 or AM180x.
-
-
-Required properties:
-~~~~~~~~~~~~~~~~~~~~
-- compatible :
-        "ti,da850-mcbsp" : for DA850, AM180x and OPAM-L138 platforms
-
-- reg : physical base address and length of the controller memory mapped
-        region(s).
-- reg-names : Should contain:
-        * "mpu" for the main registers (required).
-        * "dat" for the data FIFO (optional).
-
-- dmas: three element list of DMA controller phandles, DMA request line and
-	TC channel ordered triplets.
-- dma-names: identifier string for each DMA request line in the dmas property.
-	These strings correspond 1:1 with the ordered pairs in dmas. The dma
-	identifiers must be "rx" and "tx".
-
-Optional properties:
-~~~~~~~~~~~~~~~~~~~~
-- interrupts : Interrupt numbers for McBSP
-- interrupt-names : Known interrupt names are "rx" and "tx"
-
-- pinctrl-0: Should specify pin control group used for this controller.
-- pinctrl-names: Should contain only one value - "default", for more details
-        please refer to pinctrl-bindings.txt
-
-Example (AM1808):
-~~~~~~~~~~~~~~~~~
-
-mcbsp0: mcbsp@1d10000 {
-	compatible = "ti,da850-mcbsp";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcbsp0_pins>;
-
-	reg = 	<0x00110000 0x1000>,
-		<0x00310000 0x1000>;
-	reg-names = "mpu", "dat";
-	interrupts = <97 98>;
-	interrupt-names = "rx", "tx";
-	dmas = <&edma0 3 1
-		&edma0 2 1>;
-	dma-names = "tx", "rx";
-};
diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
new file mode 100644
index 000000000000..8b0e9b5da08f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/davinci-mcbsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: McBSP Controller for TI SoCs
+
+maintainers:
+  - Bastien Curutchet <bastien.curutchet@bootlin.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,da850-mcbsp
+
+  reg:
+    minItems: 1
+    items:
+      - description: CFG registers
+      - description: data registers
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: mpu
+      - const: dat
+
+  dmas:
+    items:
+      - description: transmission DMA channel
+      - description: reception DMA channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  interrupts:
+    items:
+      - description: RX interrupt
+      - description: TX interrupt
+
+  interrupt-names:
+    items:
+      - const: rx
+      - const: tx
+
+  clocks:
+    items:
+      - description: functional clock
+
+  clock-names:
+    items:
+      - const: fck
+
+  power-domains:
+    description: phandle to the corresponding power-domain
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - reg-names
+  - dmas
+  - dma-names
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mcbsp0: mcbsp0@1d10000 {
+      #sound-dai-cells = <0>;
+      compatible = "ti,da850-mcbsp";
+      pinctrl-names = "default";
+      pinctrl-0 = <&mcbsp0_pins>;
+
+      reg = <0x111000 0x1000>,
+            <0x311000 0x1000>;
+      reg-names = "mpu", "dat";
+      interrupts = <97>, <98>;
+      interrupt-names = "rx", "tx";
+      dmas = <&edma0 3 1
+              &edma0 2 1>;
+      dma-names = "tx", "rx";
+
+      clocks = <&psc1 14>;
+    };
-- 
2.43.2


