Return-Path: <linux-kernel+bounces-53103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD41184A0B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E761F23DFB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DDC44C7B;
	Mon,  5 Feb 2024 17:28:44 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A2344C66;
	Mon,  5 Feb 2024 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154123; cv=none; b=tgpnQJy07VmxnZscr0jp13G761I6M0jVBQhDm8xedOZzWFXEehGWPRYYOmxouF05mcx44e8zFxSpySok9dMjxHGBpepkqNvLe4s1aRkF8kifn29OwBK+bXPLt1DOK6xQzaTcKgmEcX73c/M/dmyN+KqPfBTx8kN4/9NiSny+fL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154123; c=relaxed/simple;
	bh=mlrjZuog6v94ZLezXrGvG5aQ50FyFFhxMe3KiPzrb6E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TkyceT6JVwJt52RUdRen0lujjKb6fwrgIvqg5suOke5gZ+crkiVqGDYRfjIckgVgYV8B42iXmaiMzYDOHsgv3g1HS1wJC9EHZ9egAlkWYnG/Zgotivr2LdzNwkOhCzUxhy1cLNdCM5kaEnIiB/iYFbUuPn25KZifF+KievzHgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rX2lZ-0000ND-05;
	Mon, 05 Feb 2024 17:28:21 +0000
Date: Mon, 5 Feb 2024 17:28:17 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add new
 bindings
Message-ID: <3251ac3db1a739e0c18ded0a824edae981c1e2df.1707153425.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add bindings for the MediaTek XFI Ethernet SerDes T-PHY found in the
MediaTek MT7988 SoC which can operate at various interfaces modes:

via USXGMII PCS:
 * USXGMII
 * 10GBase-R
 * 5GBase-R

via LynxI SGMII PCS:
 * 2500Base-X
 * 1000Base-X
 * Cisco SGMII (MAC side)

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: unify filename and compatible as requested

 .../phy/mediatek,mt7988-xfi-tphy.yaml         | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7988-xfi-tphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7988-xfi-tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt7988-xfi-tphy.yaml
new file mode 100644
index 0000000000000..e897118dcf7e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt7988-xfi-tphy.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,mt7988-xfi-tphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek XFI T-PHY
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+description:
+  The MediaTek XFI SerDes T-PHY provides the physical SerDes lanes
+  used by the (10G/5G) USXGMII PCS and (1G/2.5G) LynxI PCS found in
+  MediaTek's 10G-capabale MT7988 SoC.
+
+properties:
+  compatible:
+    const: mediatek,mt7988-xfi-tphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XFI PHY clock
+      - description: XFI register clock
+
+  clock-names:
+    items:
+      - const: xfipll
+      - const: topxtal
+
+  resets:
+    items:
+      - description: PEXTP reset
+
+  mediatek,usxgmii-performance-errata:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      One instance of the T-PHY on MT7988 suffers from a performance
+      problem in 10GBase-R mode which needs a work-around in the driver.
+      The work-around is enabled using this flag.
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt7988-clk.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      phy@11f20000 {
+        compatible = "mediatek,mt7988-xfi-tphy";
+        reg = <0 0x11f20000 0 0x10000>;
+        clocks = <&xfi_pll CLK_XFIPLL_PLL_EN>,
+                 <&topckgen CLK_TOP_XFI_PHY_0_XTAL_SEL>;
+        clock-names = "xfipll", "topxtal";
+        resets = <&watchdog 14>;
+        mediatek,usxgmii-performance-errata;
+        #phy-cells = <0>;
+      };
+    };
+
+...
-- 
2.43.0

