Return-Path: <linux-kernel+bounces-4010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F9D81769A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8F71F21CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D373A1CD;
	Mon, 18 Dec 2023 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5jH1ySEq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410433D556;
	Mon, 18 Dec 2023 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BIBCCXM009225;
	Mon, 18 Dec 2023 16:59:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=A9I1OaOMp4aeHeobaTb4X5FuVGgSQpYDzuJxwDpylOI=; b=5j
	H1ySEq7AkB2ERlUUxjKaNTN5VmiWP75WtMortxrz0FEP5k5TPBw1JSGmXNtUaB0l
	KN0p+kEdhNre6mCOs9eNK4VK0oXhiGf/48Wu/gDcqYZUG3puMDvowPsCysGNQF35
	GrWGsSZF9K5Hy6RXfMZhp55N1bQ0G+SVbu8mHI7T49TMzCB4jRJhUHmMbsNnhpry
	thXI+dXBXM1Ith1zJF8ARI3auyDMEoNjdjToO9yJERDRjMAkVqzE+lxmnnpW64Rg
	mxArf+WmpAfRfnrEo74bQC0l5sVabWFJteco5u6EiOC8XieN2tAcZAUFKPbRi/AL
	WlNtZMAU+aoOGt3QRgOg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v126ks3pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 16:59:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F143100062;
	Mon, 18 Dec 2023 16:59:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8717125E53E;
	Mon, 18 Dec 2023 16:59:53 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Dec
 2023 16:59:53 +0100
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
Subject: [PATCH 5/6] arm64: dts: st: add spi3/spi8 pins for stm32mp25
Date: Mon, 18 Dec 2023 16:57:17 +0100
Message-ID: <20231218155721.359198-6-alain.volmat@foss.st.com>
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

Add the spi3 and spi8 pins used on STM32MP257F-EV1 board.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
index 66791a974f8f..e669bfc8c3f1 100644
--- a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -60,6 +60,28 @@ pins {
 		};
 	};
 
+	spi3_pins_a: spi3-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 7, AF1)>, /* SPI3_SCK */
+				 <STM32_PINMUX('B', 8, AF1)>; /* SPI3_MOSI */
+			drive-push-pull;
+			bias-disable;
+			slew-rate = <1>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 10, AF1)>; /* SPI3_MISO */
+			bias-disable;
+		};
+	};
+
+	spi3_sleep_pins_a: spi3-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 7, ANALOG)>, /* SPI3_SCK */
+				 <STM32_PINMUX('B', 8, ANALOG)>, /* SPI3_MOSI */
+				 <STM32_PINMUX('B', 10, ANALOG)>; /* SPI3_MISO */
+		};
+	};
+
 	usart2_pins_a: usart2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('A', 4, AF6)>; /* USART2_TX */
@@ -90,3 +112,27 @@ pins {
 		};
 	};
 };
+
+&pinctrl_z {
+	spi8_pins_a: spi8-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('Z', 2, AF3)>, /* SPI8_SCK */
+				 <STM32_PINMUX('Z', 0, AF3)>; /* SPI8_MOSI */
+			drive-push-pull;
+			bias-disable;
+			slew-rate = <1>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('Z', 1, AF3)>; /* SPI8_MISO */
+			bias-disable;
+		};
+	};
+
+	spi8_sleep_pins_a: spi8-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('Z', 2, ANALOG)>, /* SPI8_SCK */
+				 <STM32_PINMUX('Z', 0, ANALOG)>, /* SPI8_MOSI */
+				 <STM32_PINMUX('Z', 1, ANALOG)>; /* SPI8_MISO */
+		};
+	};
+};
-- 
2.25.1


