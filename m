Return-Path: <linux-kernel+bounces-156602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28AF8B0571
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEDEFB2782B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF3E15990E;
	Wed, 24 Apr 2024 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hFMZ9DJ3"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2D158D90;
	Wed, 24 Apr 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949558; cv=none; b=KYr46g9wAzNmMOnc28Ph50IEgd6RYsBcW881vrI8HFAoRIcb9CBwyunKmM0QxqoQCiMarUBQrQffiu6IVsVR74qgihn23eGZT/ap+DdMzOc6EyM0Z4NjGRQHpz2AQuDpf07jv0iehpxlcFDl5/rl3kEYOKg45bj485w+eDlW2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949558; c=relaxed/simple;
	bh=oecI1I5F8ploSJtFJdVODKUb+t2YKq7ntuJtu7bZFnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLBj0PvvjjKiyHbHXdszUFWZAB/0ft9Nec4ebGK9HO0Cn70QsC+lVHdrz4yY234+hw6xmyx9Uk7X8tYG+2X179H6za3EGKMUjMLlgbIx+SIYq9j4ZzwVGB+jh38GWrN7qEpT6AExAovdwHdKJNYsKgcPd5v0Jmyo+7pShqUebws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hFMZ9DJ3; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4701720014;
	Wed, 24 Apr 2024 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713949551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzNqKTpVWMnrcgcJVGgyUqBdfYphefuKpHkJ0PXLDgQ=;
	b=hFMZ9DJ380NRh+LxCs/eAs/MyW3K01JfQsT/RZ/v5EhraNlMnRUV0FupHUbex7pFCCxTj0
	qn91YkqwDRhZx6VUbYONmo5UjAWNA7E+WGMk1aiOzbNjooubti+U+SxpydDrBmMcv62LFy
	BudIXE6UzYgKaproP2PjRfMHmd3a5DsKsE9vXIDZHIvILsxL9NN+3t4QzTLI/oPjDThQxa
	vLY612YbUoVVNzSZRLECK8fbGEf3dfDEhDlAZqhVtqhWmcgoC8UpAM7PJEoNB5iqkIozDm
	qi+svxxgk6UeydLcPwMPqZDJziuHkCCMY/7S49GsSrM36fdtwH6+Kf8Ps6GcgQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 24 Apr 2024 11:06:23 +0200
Subject: [PATCH net-next v4 5/5] ARM: dts: r9a06g032: describe GMAC1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-rzn1-gmac1-v4-5-852a5f2ce0c0@bootlin.com>
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

The r9a06g032 SoC of the RZ/N1 family features two GMAC devices named
GMAC1/2, that are based on Synopsys cores. GMAC1 is connected to a
RGMII/RMII converter that is already described in this device tree.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
[rgantois: commit log]
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 arch/arm/boot/dts/renesas/r9a06g032.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/renesas/r9a06g032.dtsi b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
index fa63e1afc4ef4..57c730f43442e 100644
--- a/arch/arm/boot/dts/renesas/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
@@ -316,6 +316,24 @@ dma1: dma-controller@40105000 {
 			data-width = <8>;
 		};
 
+		gmac1: ethernet@44000000 {
+			compatible = "renesas,r9a06g032-gmac", "renesas,rzn1-gmac", "snps,dwmac";
+			reg = <0x44000000 0x2000>;
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


