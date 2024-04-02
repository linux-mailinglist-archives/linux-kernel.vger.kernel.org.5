Return-Path: <linux-kernel+bounces-127479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0C6894C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F68B284094
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA91D3B29A;
	Tue,  2 Apr 2024 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="itUJfzVY"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E8364BE;
	Tue,  2 Apr 2024 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041943; cv=none; b=H73qqGtDXOnLptIdbH5p6deJo/0szMtfZcum7Vl492HJcLyMwm1a1WaECMMlcsLcdywA9lyOfVwiKqTFEEAV2xaj/B52ysgJD5WNK1TwWHIAVEfH4F5r2u+RLB/FnyZ+puubs/ozxq7Z+fFaGRm1bVISsSKyNWfggfpslm4Qb0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041943; c=relaxed/simple;
	bh=Mh2LHM8oJ/CJGsfoIFwaaxA758nlCt7jqRreMW4pp4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFreB7bUAoB9XQInVkNOc5pQX1s8QEXECJsjEj55PcPWSS1hsjYChjOXANpxcWxxWKV1PAkrgcbMtKkav/35CuJTLIDFGfon1yyQ6yU91QADc4OoZdYPEED+2esgSyFETSgjKcHCjPj5YGY5cOnhO8Qupl3We9gNuDsXITIEm9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=itUJfzVY; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 57E66FF803;
	Tue,  2 Apr 2024 07:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVsKOWPb4Rd565bWpf2m06Y2VAlQVW0XhgGG23AgwRw=;
	b=itUJfzVYv3klqtnyEMVDg2E7rjmPA6DSQihARuQk91eujLgf+NwVEhY5Bba8ooIpVjc5Hw
	pd1mYqT02lr9JJ2OETE6UJnI6y0bXTWmG0gR3BUU/Oz4xy/ZRaoJuoY/flkrf3mXHHMv6E
	pERRfbxVkjAWAiuKyOdftboq9DruynMe6Pdx2Qh6MwpoUZeRoQ6LkZ3nFpQjbIhkpslhjV
	GOuDD+faS8tKSfQavrPBL6Owt56Bu/ooMgFcjO9YdRo6cgf5D8rDsm4TQhInzChGRy44oK
	d7RES5xaxraH0X/9Dcb8bmrg8rFli9S75f+IAMWPw1LLuv25Vfglq7rzATSS1g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v2 01/13] ASoC: dt-bindings: davinci-mcbsp: convert McBSP bindings to yaml schema
Date: Tue,  2 Apr 2024 09:12:01 +0200
Message-ID: <20240402071213.11671-2-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
References: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/davinci-mcbsp.txt          | 50 ----------
 .../bindings/sound/davinci-mcbsp.yaml         | 95 +++++++++++++++++++
 2 files changed, 95 insertions(+), 50 deletions(-)
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
index 000000000000..139b594dd192
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
@@ -0,0 +1,95 @@
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
+    mcbsp0@1d10000 {
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
+      dmas = <&edma0 3 1>,
+             <&edma0 2 1>;
+      dma-names = "tx", "rx";
+
+      clocks = <&psc1 14>;
+    };
-- 
2.44.0


