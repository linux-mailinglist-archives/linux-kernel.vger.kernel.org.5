Return-Path: <linux-kernel+bounces-136543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF72789D568
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA76C281EAD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B085631;
	Tue,  9 Apr 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EvT9N+/+"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE98063B;
	Tue,  9 Apr 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654485; cv=none; b=gTMpb8O1ea0Tvk8d2NPDAH6kxDHhnQcDRgLfKO5WqebmWPemjXUe8ujrfNbNJUpiC81oS+D3k9qeyHMGVPZh5DydkbsWLRHg9+WQ4jKjMthddKZLW+M5NSfgZMZbL7c/QJTbOw4ocENXa5/RcpKox1RER3oREovqRHJt86SQYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654485; c=relaxed/simple;
	bh=C7wvbq7Dl7vRv/z7yWDMGXVmSzEb8Uka7KOqvcx6I1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jAJYKbU9SDECcOy6wiaZLwB4RcG5e+CFybZa1s1KzfbOaX3kYe7slIYa70iQhBX9vuL8D/LcMlgeBfUBSMU0+EUxdFXfG3liCMmDfAO2WtmPchsnlzlwkwPpr5TGeFq+gqJ3nmpP1Pf90uZNWvgzpnRWS5b90tUaWrfo02W65tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EvT9N+/+; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 731251BF206;
	Tue,  9 Apr 2024 09:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712654476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxX4gGO1cf6dYcz+BOp+BvU3IyOz8Kkdye9gsRIK7QY=;
	b=EvT9N+/+7ILUTywV2Nhw36YQ3yVnZcKQtU+7IS1lfhBz9fkx+/3MDQMX4/pK2jTmgTVrDg
	FiITDLcJ5oqh/5pTYCa8DWKnjiDMzVpqegyrFpycEFLB+g4gO2o6cCLtYaRGs+8LnS+tfs
	pMY99Vqa19fRXQvaMcUd//WHRf7/KVR2gjR9EC7SoJKdA+gWNIj3fF8XgmcLXGju0wHBQk
	yG3A4ZOAiZnrJDYeoKxxCCN36UWRUXw4P0uvrPR0XAt2pvMibDGVjAMK4Xc+kllcTgpc3e
	OBfiMB31z2NBmFdwdfL9BSa1ZPZJ49o7b199aZN4s4ewu9KYXDa63rnY06Ip6w==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 09 Apr 2024 11:21:48 +0200
Subject: [PATCH net-next v2 5/5] ARM: dts: r9a06g032: describe GMAC1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240409-rzn1-gmac1-v2-5-79ca45f2fc79@bootlin.com>
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

The r9a06g032 SoC of the RZ/N1 family features two GMAC devices named
GMAC1/2, that are based on Synopsys cores. GMAC1 is connected to a
RGMII/RMII converter that is already described in this device tree.

Signed-off-by: "Clément Léger" <clement.leger@bootlin.com>
[rgantois: commit log]
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 arch/arm/boot/dts/renesas/r9a06g032.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/renesas/r9a06g032.dtsi b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
index fa63e1afc4ef..cab7a641f95b 100644
--- a/arch/arm/boot/dts/renesas/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
@@ -316,6 +316,25 @@ dma1: dma-controller@40105000 {
 			data-width = <8>;
 		};
 
+		gmac1: ethernet@44000000 {
+			compatible = "renesas,r9a06g032-gmac", "renesas,rzn1-gmac", "snps,dwmac";
+			reg = <0x44000000 0x2000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
+			clocks = <&sysctrl R9A06G032_HCLK_GMAC0>;
+			clock-names = "stmmaceth";
+			power-domains = <&sysctrl>;
+			snps,multicast-filter-bins = <256>;
+			snps,perfect-filter-entries = <128>;
+			tx-fifo-depth = <2048>;
+			rx-fifo-depth = <4096>;
+			pcs-handle = <&mii_conv1>;
+			status = "disabled";
+		};
+
 		gmac2: ethernet@44002000 {
 			compatible = "renesas,r9a06g032-gmac", "renesas,rzn1-gmac", "snps,dwmac";
 			reg = <0x44002000 0x2000>;

-- 
2.44.0


