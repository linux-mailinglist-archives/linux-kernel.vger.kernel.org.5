Return-Path: <linux-kernel+bounces-160018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9528B37C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A2F1F21411
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6F1487D5;
	Fri, 26 Apr 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="pgHQbm50"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6E148314;
	Fri, 26 Apr 2024 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136466; cv=none; b=fYXN7/bPlOkWenuLuS7ag3xcgZQ6xZ6NtL3sD5WbRMq+NgoCZZP7pfybcBE9Rov3Di5Kf5eXKSDI91/iz/68eJPICFPc7ETMtohgFILgklSBW1bDWRObDv/hBLOjFqisxplRFaVNPZLTET0PHr2dvLugoAzPgrL07g0ejmM/bfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136466; c=relaxed/simple;
	bh=B13FwRdbFg5Cc9wEWSRdjZ5FIgUDWQU7JaLEUrjpG5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtKIU5h2iAlvQBJAibVMJdqe7DgBLrfHR2EJ4E4HDVfZCOaQflE6k0NmWhjnkv/QCx5iQQiN3WdenUuzd2+QvDltB8k65ycZSt5jrpPXIo+Y/BBrH2Zxbbv6jykh0yjS4gNOt24FLUYWowBtWHrwNXK3Pytq5ac7iEGhtw25g7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=pgHQbm50; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q9NA1D032395;
	Fri, 26 Apr 2024 15:00:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=8xuQ4kG4Mw+l79FaSdV3rqMtEDDLZ1u0dsn2BV0iCm8=; b=pg
	HQbm50inoSN81JDN9zfYYwY3Bo6zlVnZgvoG7VbCWhac3YNGg/lCJOfM2GbXaHDm
	UwnR79QB/syMz4gFbF41JQ1y3mzidDXFUzI6zbjpI36TtwcswASNxSk4r8mlCifW
	sarwh4JmiBO3DP2l7Fii6Lbbszc/ZDaq4ibWfbmWAZ1Du2LwH7QSd9XHA3kalTp0
	VaF/hQt31kwwh+vC8+HOIAhGAdRRNm9MStcNSCPxarMLDaAifImrm0t53SBiyH8Q
	SJAVrJK9wuiP/tFlb1vHFDLBbyQbMCuq5zLRwUM8HLlatrQEhIMW2tW9McHJ3aTg
	JOx7Tv1z3PAFSA2Hx3NA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4kbhsdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 15:00:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B73C340048;
	Fri, 26 Apr 2024 15:00:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D1016222C9B;
	Fri, 26 Apr 2024 14:59:20 +0200 (CEST)
Received: from localhost (10.252.17.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 14:59:19 +0200
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
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/11] ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
Date: Fri, 26 Apr 2024 14:57:05 +0200
Message-ID: <20240426125707.585269-10-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426125707.585269-1-christophe.roullier@foss.st.com>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

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
index 32c5d8a1e06a..7f72c62da0a6 100644
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


