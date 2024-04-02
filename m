Return-Path: <linux-kernel+bounces-127950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDDC895336
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A58282A7D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFE181742;
	Tue,  2 Apr 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cWL8yP95"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DC7A15D;
	Tue,  2 Apr 2024 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061404; cv=none; b=FaaU17W/Y69xyaIsDI6za9GpxO8WebLJJipXHqbkyHbOFZ/7xgtu/4U8bagbbgEcsYsUvUcPiIusMs/19x66rVe7mUJ/H0A6vCybL8TbLHHlhfJrQ+IsynWikq56xZK4c6Z9fUMtQLGCTfZXUwJwArYF+dONllgu76InHKweDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061404; c=relaxed/simple;
	bh=FVkMdCniS3BTtD7oRAnww+Bl/gOvrHmNVzYCjDIJFKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o22XzdI6T+nYXfV4+xqjJUloIZukbZFmk4BULlcg6Njz0h3W9r20A8P3Bvra2CWILThbG9GCtWI2PeCVoqR/Ur4MZt22kdQFUKDbrcUrtkBj/APlz8tQsZBN1fD+CKUJGcxYR2TP4VjMl5hT2EWeqt0eP+mzP88+HpL0V4GrsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cWL8yP95; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49495FF80D;
	Tue,  2 Apr 2024 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712061394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjnkMvjoSKQM99Rq/QD1RS/YQciw7dznZZawKPOEQ6k=;
	b=cWL8yP95jqUKwoyOm+ruKIKEPlITLTJ1yaoBdMOPGcqtPTmkYms8WIAw+1iNicP05Nbfc6
	Zdt9nF/ngly5cICWwmPPeDO9/FkqaAiOGJmTSNnqHXggKGcYF2732p2YrJqgmM1jFTymac
	hNLZFtGIftfLFg+puyHnZpmlOYaDCDkUV+eUhHKfi7e7RuEf3VLyLZ3Ph1v9VvJb4xVuq0
	9JTHIckghor5WPk+QP42jsekuznfHitxImYWgAjDTQpEOAs1Jhbwn7H9srf3vt1AK8+vxx
	+7W6UKV8MI/k180ezK9uB+u9njsh2ayc5U3IWGciKHXHSCpRYG+v8KV6aHoDQA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 02 Apr 2024 14:37:00 +0200
Subject: [PATCH net-next 1/3] dt-bindings: net: renesas,rzn1-gmac: Document
 RZ/N1 GMAC support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240402-rzn1-gmac1-v1-1-5be2b2894d8c@bootlin.com>
References: <20240402-rzn1-gmac1-v1-0-5be2b2894d8c@bootlin.com>
In-Reply-To: <20240402-rzn1-gmac1-v1-0-5be2b2894d8c@bootlin.com>
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
index 000000000000..c6f61fb1e5b0
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
+      interrupt-parent = <&gic>;
+      interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
+      clock-names = "stmmaceth";
+      clocks = <&sysctrl R9A06G032_HCLK_GMAC0>;
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


