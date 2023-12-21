Return-Path: <linux-kernel+bounces-7813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD7181AD8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7448C1F23BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F11F8F48;
	Thu, 21 Dec 2023 03:32:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8FAD2C;
	Thu, 21 Dec 2023 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 59C7B24E280;
	Thu, 21 Dec 2023 11:32:25 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 11:32:25 +0800
Received: from localhost.localdomain (113.72.145.47) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 11:32:24 +0800
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>
CC: Walker Chen <walker.chen@starfivetech.com>, Xingyu Wu
	<xingyu.wu@starfivetech.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: ASoC: Add Cadence I2S controller for StarFive JH8100 SoC
Date: Thu, 21 Dec 2023 11:32:22 +0800
Message-ID: <20231221033223.73201-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
References: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add bindings for the Multi-Channel I2S controller of Cadence
on the StarFive JH8100 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../bindings/sound/cdns,jh8100-i2s.yaml       | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cdns,jh8100-i=
2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/cdns,jh8100-i2s.yaml=
 b/Documentation/devicetree/bindings/sound/cdns,jh8100-i2s.yaml
new file mode 100644
index 000000000000..5d95d9ab3e45
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cdns,jh8100-i2s.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cdns,jh8100-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence multi-channel I2S controller for StarFive JH8100 SoC
+
+description: |
+  The Cadence I2S Controller implements a function of the multi-channel
+  (up to 8-channel) bus. It combines functions of a transmitter and a re=
ceiver.
+  It is used in the StarFive JH8100 SoC.
+
+maintainers:
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+  - Walker Chen <walker.chen@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-i2s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      The interrupt line number for the I2S controller. Add this
+      parameter if the I2S controller that you are using does not
+      support DMA.
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bit clock
+      - description: Main ICG clock
+      - description: Inner master clock
+
+  clock-names:
+    items:
+      - const: bclk
+      - const: icg
+      - const: mclk_inner
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+    minItems: 1
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+    minItems: 1
+
+  cdns,i2s-max-channels:
+    description: |
+      Number of I2S max stereo channels supported by the hardware.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 8
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+
+oneOf:
+  - required:
+      - dmas
+      - dma-names
+  - required:
+      - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2s@122b0000 {
+      compatible =3D "starfive,jh8100-i2s";
+      reg =3D <0x122b0000 0x1000>;
+      clocks =3D <&syscrg_ne 133>,
+               <&syscrg_ne 170>,
+               <&syscrg 50>;
+      clock-names =3D "bclk", "icg",
+                    "mclk_inner";
+      resets =3D <&syscrg_ne 43>;
+      dmas =3D <&dma 7>, <&dma 6>;
+      dma-names =3D "tx", "rx";
+      cdns,i2s-max-channels =3D <2>;
+      #sound-dai-cells =3D <0>;
+    };
--=20
2.25.1


