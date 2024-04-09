Return-Path: <linux-kernel+bounces-136128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C4A89D053
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F993B23172
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88624F606;
	Tue,  9 Apr 2024 02:24:09 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C84A2C;
	Tue,  9 Apr 2024 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629449; cv=none; b=JiRWE59sb5uy2IDKapmlzqft5SU5xdtQXFOQOvV6hRyDocJ1URJTPPzgSyJf1HXkx6SJnbGj7IYLylAr3uN2CSNz2KN1R7793Ln60ztMDyziqYlUTUMb3eb9CMWKZE7nUteZJRYjh6l+06nq1BUZXJZUQYdRlkt0VSKLmKRcpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629449; c=relaxed/simple;
	bh=MljgnSDWU7dplQLrY9QDBH9fo3xA3ecNaTh4ie6HiWk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mM7mV7vketQyPPXG4a3laPja9cBQCa35dvl6gHVmUQCVQWihPqcB/XSoTrLX2ADn3+ADaSjtjw9CdEG9IS/iieqvOlysJPHyCuQGRUWEPnr8OE3Bqny+yqaDh5KcF4Ijh5f94gN80EwhaxtX2dyUor01UMiW2lDg6bg2z3+4Bzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ru19S-0007X1-0q;
	Tue, 09 Apr 2024 02:23:58 +0000
Date: Tue, 9 Apr 2024 03:23:54 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	John Crispin <john@phrozen.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: [PATCH v4 1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add new
 bindings
Message-ID: <da5498096f71a40ca1eac4124b7bb601c82396fb.1712625857.git.daniel@makrotopia.org>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v4: no changes
v3: Add reference to MediaTek-internal "pextp" name, better explain reset as
    well as 10GBase-R tuning work-around.
v2: unify filename and compatible as requested

 .../phy/mediatek,mt7988-xfi-tphy.yaml         | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7988-xfi-tphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7988-xfi-tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt7988-xfi-tphy.yaml
new file mode 100644
index 00000000000000..cfb3ca97f87c68
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt7988-xfi-tphy.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,mt7988-xfi-tphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7988 XFI T-PHY
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+description:
+  The MediaTek XFI SerDes T-PHY provides the physical SerDes lanes
+  used by the (10G/5G) USXGMII PCS and (1G/2.5G) LynxI PCS found in
+  MediaTek's 10G-capabale MT7988 SoC.
+  In MediaTek's SDK sources, this unit is referred to as "pextp".
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
+      - description: Reset controller corresponding to the phy instance.
+
+  mediatek,usxgmii-performance-errata:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      One instance of the T-PHY on MT7988 suffers from a performance
+      problem in 10GBase-R mode which needs a work-around in the driver.
+      This flag enables a work-around ajusting an analog phy setting and
+      is required for XFI Port0 of the MT7988 SoC to be in compliance with
+      the SFP specification.
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
2.44.0

