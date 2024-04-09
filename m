Return-Path: <linux-kernel+bounces-136539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219AD89D558
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B791C2193F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4CE80034;
	Tue,  9 Apr 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ihcxW5Re"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAE7F478;
	Tue,  9 Apr 2024 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654481; cv=none; b=HgGBGeZuiCYwIrtC2Q4zwjUi3cEf2pds79SwRlAeCug/3ljE2EvPTbixrWBejiA4o/xssj8XS7aDUC5Tok20s2u0NhRHpM4y8QCgD9Nk2Ynrgq8hiRb9tlRe+lYOSDFJy8t0IowT47rg1Lbkkrs+v+yFyuGlwRJz94kqrLSWMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654481; c=relaxed/simple;
	bh=RgQ+mZW3M5pg9bHIByJF6UqZHSarQFZlT0mB2JICOgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tAr3NXVc8YqXr0AZUa2hBsEDcliqtHQMTMION/DGSp3a+JTlD5gunfccNAaw1pdLhn2/vmm7mvcCGbr4Epk5zGLAvHQAIoKnP6TLqVMxDxDhWzWUxNL7FPeZ71etud327FDc+DapWEnHabGa5wUlClXOGyEKDVB97Yk2Z9mjBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ihcxW5Re; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F3361BF20A;
	Tue,  9 Apr 2024 09:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712654472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1AjpgLZrq5VOp+FpLofqafK5+WZ3KagtEpDGsQo+mE=;
	b=ihcxW5ReqtChDthPOHkgaed9vPCmR0VWCI0k4pH681rFtekp8WwYbY9aVeMLm/yPbhg1ir
	ZV0P7AA2vtVWe9L/gKQRGp56+0iS9nWfymX2Cnk1NQOrhzJGJa3Zo7zWOBuTgA0JVWFldB
	KQgiHELOQN9iOOY/VM/KEepSZO1p/uAAjIVRsWC+zmw4M9CtMIj3tLYWaGTE78QTZkZlwy
	iUUmgDMsP8JLRfWbyrGceobTDREaU9C7hTOyPy2gGETOxsE6j9d0CxXe9BP6IuYo5xhD5r
	vKoJss1VYfP8ZhC29M04mD8Vz867huuIlWgn3vehMLqrGX2d9wkr9mBozdQzxw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 09 Apr 2024 11:21:44 +0200
Subject: [PATCH net-next v2 1/5] dt-bindings: net: renesas,rzn1-gmac:
 Document RZ/N1 GMAC support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240409-rzn1-gmac1-v2-1-79ca45f2fc79@bootlin.com>
References: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com>
In-Reply-To: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com>
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
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>
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

Signed-off-by: "Clément Léger" <clement.leger@bootlin.com>
[rgantois: commit log]
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml b/Documentation/devicetree/bindings/net/renesas,rzn1-gmac.yaml
new file mode 100644
index 000000000000..d9a8d586e260
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


