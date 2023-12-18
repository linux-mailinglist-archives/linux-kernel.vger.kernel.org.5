Return-Path: <linux-kernel+bounces-4004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD59A81768D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D511C23A14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8D3D566;
	Mon, 18 Dec 2023 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="IDo2TrcH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEAF3D563;
	Mon, 18 Dec 2023 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BIBeUUB023897;
	Mon, 18 Dec 2023 16:59:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=fhGge2JsRZjLohzjz+u4cyKgjQ34XoxqgeIEvyeSSGI=; b=ID
	o2TrcHpmAxD5woQJ7aavNPHn8EICSt5VbFsp3EXm808fYcZl3SKT8NKazOgJdsLP
	rQVzxI+nQHBD9wkcXzk3yTqrrfKANjVArbwEvdlnPqndV9F/+spqtFV5CxLh75ce
	WN1h8MiGRvtM9s/H1L/8JEv/b9k9MHwlMwqBn9k0govfnazvMqoraEXMcQqZO12/
	j/ADxBR4Cc+hp9UJ4Lst+7gxBt7c864cZTxGPg51YeZce3vDcuGj/D0mgj1ovW0o
	R3rXWK+Qba7LJOgAZIgLlmaZdyrUWQ2jdexW0Y7hBBzshK4mDxd4++NjgfFtgDwM
	Gro5PFexEPfJ5Su0fhsA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v1pb4egpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 16:59:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C106510005E;
	Mon, 18 Dec 2023 16:59:02 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7F5225F4AD;
	Mon, 18 Dec 2023 16:59:02 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Dec
 2023 16:59:02 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat
	<alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice
 Gasnier <fabrice.gasnier@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] arm64: dts: st: add all 8 spi nodes on stm32mp251
Date: Mon, 18 Dec 2023 16:57:16 +0100
Message-ID: <20231218155721.359198-5-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218155721.359198-1-alain.volmat@foss.st.com>
References: <20231218155721.359198-1-alain.volmat@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_10,2023-12-14_01,2023-05-22_02

Add the 8 nodes for all spi instances available on the stm32mp251.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 88 ++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index dfbdb3a773e4..feb30c6fb183 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -108,6 +108,28 @@ rifsc: rifsc-bus@42080000 {
 			#size-cells = <1>;
 			ranges;
 
+			spi2: spi@400b0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "st,stm32mp25-spi";
+				reg = <0x400b0000 0x400>;
+				interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_SPI2>;
+				resets = <&rcc SPI2_R>;
+				status = "disabled";
+			};
+
+			spi3: spi@400c0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "st,stm32mp25-spi";
+				reg = <0x400c0000 0x400>;
+				interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_SPI3>;
+				resets = <&rcc SPI3_R>;
+				status = "disabled";
+			};
+
 			usart2: serial@400e0000 {
 				compatible = "st,stm32h7-uart";
 				reg = <0x400e0000 0x400>;
@@ -116,6 +138,72 @@ usart2: serial@400e0000 {
 				status = "disabled";
 			};
 
+			spi1: spi@40230000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "st,stm32mp25-spi";
+				reg = <0x40230000 0x400>;
+				interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_SPI1>;
+				resets = <&rcc SPI1_R>;
+				status = "disabled";
+			};
+
+			spi4: spi@40240000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "st,stm32mp25-spi";
+				reg = <0x40240000 0x400>;
+				interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_SPI4>;
+				resets = <&rcc SPI4_R>;
+				status = "disabled";
+			};
+
+			spi5: spi@40280000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "st,stm32mp25-spi";
+				reg = <0x40280000 0x400>;
+				interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_SPI5>;
+				resets = <&rcc SPI5_R>;
+				status = "disabled";
+			};
+
+			spi6: spi@40350000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "st,stm32mp25-spi";
+				reg = <0x40350000 0x400>;
+				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_SPI6>;
+				resets = <&rcc SPI6_R>;
+				status = "disabled";
+			};
+
+			spi7: spi@40360000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "st,stm32mp25-spi";
+				reg = <0x40360000 0x400>;
+				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_SPI7>;
+				resets = <&rcc SPI7_R>;
+				status = "disabled";
+			};
+
+			spi8: spi@46020000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "st,stm32mp25-spi";
+				reg = <0x46020000 0x400>;
+				interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_SPI8>;
+				resets = <&rcc SPI8_R>;
+				status = "disabled";
+			};
+
 			sdmmc1: mmc@48220000 {
 				compatible = "st,stm32mp25-sdmmc2", "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00353180>;
-- 
2.25.1


