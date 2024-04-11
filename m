Return-Path: <linux-kernel+bounces-140678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CAD8A17AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8931F222D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231FDDDC;
	Thu, 11 Apr 2024 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rKYRyW0S"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F03BA29;
	Thu, 11 Apr 2024 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846483; cv=none; b=K6Cle/pMvdfkOkJf7C/OynA+Z52nVSP18akYEqga7QievnVERftGl8VUIohP648Sr1QmICoy3315XVmgO3lbWPYES4LufwnnuPSNpEj75lZzFTWy86nnCkEA29s9wN5ydjJ2f0/0owxFDb/sdliStg9Tex7PYqiznoWngIhvIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846483; c=relaxed/simple;
	bh=YBy+HppunEgAE+gfqfIN9i3Tfcx9kEtkFQu/480s7B8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDj3RuMc6A4LeqFrqXWQrsmeiavAE5mtXoI0RJVgNiRwg6GBrKZLwmL430Xn5ATYBubF1gRYJbXSG6SsPx6veX4U7QJ2q3Sr30T3bxjAAR++Xadq+VV1MAZYmGeCUSaij9A4yOBHiKc49Mh49XpROvPmu8e9y+kVlId/u8t+9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rKYRyW0S; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BDPB8J021039;
	Thu, 11 Apr 2024 16:41:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=aW6pD9GMow6qNOrzULfAHxIMlLpLjXmjFKQWv9X55rw=; b=rK
	YRyW0S48Nkw3zrrFM403hTXqHl/n3n/0JC7noAdr3DvvyAUSsnwY8/3c8mE/UbSJ
	vMR/Xa6WL620A0vztGX/gNB91Q3aBBSZ3PxFW2hwxqOQHq5ouf78+r3hlM0OOB8h
	XT18KwmZCkeAn3nBO1+/VgOHYC+60LvYAz4A/tLJPyx5G5Mi0laylcdfzRlGkeAO
	QkLfkRoCDy+S9wpG2MVIZZjlORFKucKb4s2m2QmVWsEpEHfX6otj8txAqR2Gzd47
	Q/jHjP7QKwB/ToChDR/KachonjOrft2CdsNpm9sfx3cLZwPV+EoWVq4LcQ/W+HVE
	j9iqbDq1jf9PgARpaonw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xauh5dd5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 16:41:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 54C4B40044;
	Thu, 11 Apr 2024 16:40:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A21FF216821;
	Thu, 11 Apr 2024 16:39:49 +0200 (CEST)
Received: from localhost (10.48.86.106) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Apr
 2024 16:39:49 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/11] ARM: dts: stm32: add ethernet1 and ethernet2 for STM32MP135F-DK board
Date: Thu, 11 Apr 2024 16:36:57 +0200
Message-ID: <20240411143658.1049706-11-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
References: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02

Add dual Ethernet:
-Ethernet1: RMII with crystal
-Ethernet2: RMII without crystal
PHYs used are SMSC (LAN8742A)

With Ethernet1, we can performed WoL from PHY instead of GMAC point
of view.
(in this case IRQ for WoL is managed as wakeup pin and configured
in OS secure).

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 52171214a3087..faa7212637dc0 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -19,6 +19,8 @@ / {
 	compatible = "st,stm32mp135f-dk", "st,stm32mp135";
 
 	aliases {
+		ethernet0 = &ethernet1;
+		ethernet1 = &ethernet2;
 		serial0 = &uart4;
 		serial1 = &usart1;
 		serial2 = &uart8;
@@ -101,6 +103,52 @@ &cryp {
 	status = "okay";
 };
 
+&ethernet1 {
+	status = "okay";
+	pinctrl-0 = <&eth1_rmii_pins_a>;
+	pinctrl-1 = <&eth1_rmii_sleep_pins_a>;
+	pinctrl-names = "default", "sleep";
+	phy-mode = "rmii";
+	max-speed = <100>;
+	phy-handle = <&phy0_eth1>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0_eth1: ethernet-phy@0 {
+			compatible = "ethernet-phy-id0007.c131";
+			reset-gpios =  <&mcp23017 9 GPIO_ACTIVE_LOW>;
+			reg = <0>;
+			wakeup-source;
+		};
+	};
+};
+
+&ethernet2 {
+	status = "okay";
+	pinctrl-0 = <&eth2_rmii_pins_a>;
+	pinctrl-1 = <&eth2_rmii_sleep_pins_a>;
+	pinctrl-names = "default", "sleep";
+	phy-mode = "rmii";
+	max-speed = <100>;
+	phy-handle = <&phy0_eth2>;
+	st,ext-phyclk;
+	phy-supply = <&scmi_v3v3_sw>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0_eth2: ethernet-phy@0 {
+			compatible = "ethernet-phy-id0007.c131";
+			reset-gpios = <&mcp23017 10 GPIO_ACTIVE_LOW>;
+			reg = <0>;
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c1_pins_a>;
-- 
2.25.1


