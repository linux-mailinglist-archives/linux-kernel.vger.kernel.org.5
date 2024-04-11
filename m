Return-Path: <linux-kernel+bounces-140676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4170B8A17A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC913283600
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB038FBC;
	Thu, 11 Apr 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Sr8cqwDB"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467822C6B2;
	Thu, 11 Apr 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846422; cv=none; b=aRJo4PmaDF3spC/xB5c+QDfY50cIunIV3kiELBW/fmQXM8go5DPrXVst0igaoJD77IERisPCyW6XZlC9WRDwZbrQwMITb5yusjWoVCVUANJ317eyMq/T/7416PTNXIX8C0zP4w3cLq7ikRNFW0aYmak4eWc1O+TZvRpE8oCBA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846422; c=relaxed/simple;
	bh=GbQ2nQ7+TdDQc2XJ/ebPuv9itFE/gprywyjzyllp7A0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgdsyOP8kCun3z2McGdguzqRgzNfwcsCczPmKUMr5Z9SukmE0Le6zkdUQ3nIAx9BPKqKNvk6mcaYGpNolxaAJKArm+lrDgAAV2KIDnt+lOHmi1gTzwZvDj3ggoHXuYvhAHkXqlJeyeSSvYqJ2ytzOzy8/5eRn/I54Y2HULwYpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Sr8cqwDB; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BCBImr019272;
	Thu, 11 Apr 2024 16:39:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=em1iavzcmoXt7sbQ99esOEY41Vxo8iurL0awxGXDL90=; b=Sr
	8cqwDBbL8GTrJSESyIqhYjzxk5YgaAJhTd7qaLT2J2w7+9CvlmNPGRFZyOAsFYGE
	ixsLLia8kD+UNA9a6qqkkrccHOxE2lqEpqA3sUgudVtZlrw3XvoTUj1dm9zUkJZG
	s7wR+JOx2NRCLnI8axEX2jfgz11EfLxEHNMpXarREVHn8NcZC+4kbzk58xSTYlXf
	PSbUC1SwTvFX1xaWOhJK1IS24rKMo8SG4FVDttyEvMKPoRHwm4/U356XnZqoTFJc
	Et8hjT2hkmANIFeuvl8g//UUf8eN+pbmlAeXVgnQK4GyNftclwtSgUpXH1hjp1Zr
	zRB8VhrtRWIkeu8V1k9g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xbhbjb8kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 16:39:53 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9D07B40047;
	Thu, 11 Apr 2024 16:39:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E6E1021BF56;
	Thu, 11 Apr 2024 16:38:40 +0200 (CEST)
Received: from localhost (10.48.86.106) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Apr
 2024 16:38:38 +0200
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
Subject: [PATCH 09/11] ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
Date: Thu, 11 Apr 2024 16:36:56 +0200
Message-ID: <20240411143658.1049706-10-christophe.roullier@foss.st.com>
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

Those pins are used for Ethernet 1 and 2 on STM32MP13F-DK board.
ethernet1: RMII with crystal.
ethernet2: RMII without crystal.
Add analog gpio pin configuration ("sleep") to manage power mode on
stm32mp13.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 71 +++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
index 27e0c3826789d..b2583df813af8 100644
--- a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
@@ -13,6 +13,77 @@ pins {
 		};
 	};
 
+	eth1_rmii_pins_a: eth1-rmii-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH_RMII_TXD0 */
+				 <STM32_PINMUX('G', 14, AF11)>, /* ETH_RMII_TXD1 */
+				 <STM32_PINMUX('B', 11, AF11)>, /* ETH_RMII_TX_EN */
+				 <STM32_PINMUX('A', 1, AF11)>, /* ETH_RMII_REF_CLK */
+				 <STM32_PINMUX('A', 2, AF11)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 2, AF11)>; /* ETH_MDC */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('C', 4, AF11)>, /* ETH_RMII_RXD0 */
+				 <STM32_PINMUX('C', 5, AF11)>, /* ETH_RMII_RXD1 */
+				 <STM32_PINMUX('C', 1, AF10)>; /* ETH_RMII_CRS_DV */
+			bias-disable;
+		};
+
+	};
+
+	eth1_rmii_sleep_pins_a: eth1-rmii-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 13, ANALOG)>, /* ETH_RMII_TXD0 */
+				 <STM32_PINMUX('G', 14, ANALOG)>, /* ETH_RMII_TXD1 */
+				 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH_RMII_TX_EN */
+				 <STM32_PINMUX('A', 1, ANALOG)>, /* ETH_RMII_REF_CLK */
+				 <STM32_PINMUX('A', 2, ANALOG)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 2, ANALOG)>, /* ETH_MDC */
+				 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RMII_RXD0 */
+				 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH_RMII_RXD1 */
+				 <STM32_PINMUX('C', 1, ANALOG)>; /* ETH_RMII_CRS_DV */
+		};
+	};
+
+	eth2_rmii_pins_a: eth2-rmii-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 7, AF11)>, /* ETH_RMII_TXD0 */
+				 <STM32_PINMUX('G', 11, AF10)>, /* ETH_RMII_TXD1 */
+				 <STM32_PINMUX('G', 8, AF13)>, /* ETH_RMII_ETHCK */
+				 <STM32_PINMUX('F', 6, AF11)>, /* ETH_RMII_TX_EN */
+				 <STM32_PINMUX('B', 2, AF11)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 5, AF10)>; /* ETH_MDC */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 4, AF11)>, /* ETH_RMII_RXD0 */
+				 <STM32_PINMUX('E', 2, AF10)>, /* ETH_RMII_RXD1 */
+				 <STM32_PINMUX('A', 12, AF11)>; /* ETH_RMII_CRS_DV */
+			bias-disable;
+		};
+	};
+
+	eth2_rmii_sleep_pins_a: eth2-rmii-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 7, ANALOG)>, /* ETH_RMII_TXD0 */
+				 <STM32_PINMUX('G', 11, ANALOG)>, /* ETH_RMII_TXD1 */
+				 <STM32_PINMUX('G', 8, ANALOG)>, /* ETH_RMII_ETHCK */
+				 <STM32_PINMUX('F', 6, ANALOG)>, /* ETH_RMII_TX_EN */
+				 <STM32_PINMUX('B', 2, ANALOG)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_MDC */
+				 <STM32_PINMUX('F', 4, ANALOG)>, /* ETH_RMII_RXD0 */
+				 <STM32_PINMUX('E', 2, ANALOG)>, /* ETH_RMII_RXD1 */
+				 <STM32_PINMUX('A', 12, ANALOG)>; /* ETH_RMII_CRS_DV */
+		};
+	};
+
 	i2c1_pins_a: i2c1-0 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
-- 
2.25.1


