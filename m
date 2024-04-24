Return-Path: <linux-kernel+bounces-156598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82808B0561
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1EB1C23AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE767158DBF;
	Wed, 24 Apr 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y0nLf11P"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED313A406;
	Wed, 24 Apr 2024 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949551; cv=none; b=tLVzYr6iMK2QSMdr4V5ndUSmcs6YwgQLOK9pcZZ3x+sp+TfyMnxiWZTns/5YpowEoYsngjlf6bMv/fO6jGdu0EF014VAt7m3/LsJ3fN1x5r+lu3XICDl52fKqQse6zJAaDDIC9hmIHQnhsh6e52VpDTxlMzUyJvT3SSqzZPXdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949551; c=relaxed/simple;
	bh=8ENOqewMW99QWcS2EvbxlHeThnWJBf0dwQB/ui5W9gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MzHobD3pYx0O989DQ1M0MWjuGPBpcGp8uWjwHNVvkezVNzPemN2S3mr/TQ7HWT+Wn/bl0WdZNuDRj+ZrLpo3X2X8BtqhfTWqISMTksXRQXjPs2AeC3+w4/zFLhdfKFZ5yBT8jKHTk0mVUsJ5KDWifbVcRBQKkKjE4w3NbmcTAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y0nLf11P; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71F7120015;
	Wed, 24 Apr 2024 09:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713949545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXa4EdnQqRxUOEPvkBPgsUUIstZOOeI7Xe83F05iy1I=;
	b=Y0nLf11PnZo+TTNfH9m1AI10Yl+Jd72zlVvKBq/8npXtbJ28DAwGHyTISoZZqyZ/wvf52L
	mFVPXugyr8G2eh8JRo4bg6MstVtCGPWcTqRM+qq2oIIaVIiq66iNx0HdSCOTvnnXDobPx+
	0SJFjkLGcLnq4vMJevgAZUiN3NXnd3NkJ/sN3VQuL36czt2ouj3ew4bVBinFKy2fPEeGCY
	Q9jP9JMyhDX6zX0n4R+aBxUbu5CY+JB86gO8PP+ydP4PW7Wn5VeGkIfC0ArVGG7qAbpMqB
	e2xliDLAuAmZ4+zPiwN8v9AnmJgrYqLHB6WzotjNjlPMK+hVhKCRvef86iQbWA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 24 Apr 2024 11:06:19 +0200
Subject: [PATCH net-next v4 1/5] dt-bindings: net: renesas,rzn1-gmac:
 Document RZ/N1 GMAC support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-rzn1-gmac1-v4-1-852a5f2ce0c0@bootlin.com>
References: <20240424-rzn1-gmac1-v4-0-852a5f2ce0c0@bootlin.com>
In-Reply-To: <20240424-rzn1-gmac1-v4-0-852a5f2ce0c0@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Serge Semin <fancer.lancer@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: romain.gantois@bootlin.com

From: Clément Léger <clement.leger@bootlin.com>

The RZ/N1 series of MPUs feature up to two Gigabit Ethernet controllers.
These controllers are based on Synopsys IPs. They can be connected to
RZ/N1 RGMII/RMII converters.

Add a binding that describes these GMAC devices.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
[rgantois: commit log]
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml b/Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml
new file mode 100644
index 0000000000000..d9a8d586e260c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/renesas,rzn1-gmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas GMAC
+
+maintainers:
+  - Romain Gantois <romain.gantois@bootlin.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,r9a06g032-gmac
+          - renesas,rzn1-gmac
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a06g032-gmac
+      - const: renesas,rzn1-gmac
+      - const: snps,dwmac
+
+  pcs-handle:
+    description:
+      phandle pointing to a PCS sub-node compatible with
+      renesas,rzn1-miic.yaml#
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a06g032-sysctrl.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    ethernet@44000000 {
+      compatible = "renesas,r9a06g032-gmac", "renesas,rzn1-gmac", "snps,dwmac";
+      reg = <0x44000000 0x2000>;
+      interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
+      clock-names = "stmmaceth";
+      clocks = <&sysctrl R9A06G032_HCLK_GMAC0>;
+      power-domains = <&sysctrl>;
+      snps,multicast-filter-bins = <256>;
+      snps,perfect-filter-entries = <128>;
+      tx-fifo-depth = <2048>;
+      rx-fifo-depth = <4096>;
+      pcs-handle = <&mii_conv1>;
+      phy-mode = "mii";
+    };
+
+...

-- 
2.44.0


