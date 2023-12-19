Return-Path: <linux-kernel+bounces-5239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4798681885F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DDF285251
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC7E18EB0;
	Tue, 19 Dec 2023 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lqnzPhbl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FAE19BDE;
	Tue, 19 Dec 2023 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BJAp10R026374;
	Tue, 19 Dec 2023 14:09:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=ZwAhwLqmgIynr7yNMrRCWN8vMO2DN9rz2YgSfmJmnkI=; b=lq
	nzPhbl6xwQjpx0NvxAV/IkZawGsBdZoCjTnyhwPacxest4u+YMcOfKBwtaDbPEna
	vvUJvRfszzNu6YJU/1+Mhe1nH6szwFzuEDOV5SksxDy2Dkg89IVGSQwrCv3L0e8H
	u/YmzParyYOL1I48/tA2QtgewF3QpkUkKCJrfRQ9b+j5cPFq4hAKUjuPOOFQtEBr
	lvifKEKvoyaZyb6XK7CNLNGfugdM08h7Gfc5nz/O17DxSpRAn8MWIEBHpeVRgldf
	zZY5WUMn32Mxazo3ISyB+q2Gf4eGpGxWoNaonU30mmCZAOfrJtFOLxH78XCrjBDM
	wkpLwqbqw8+Q+Fq3Hlpg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v126kw19g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 14:09:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6386C100059;
	Tue, 19 Dec 2023 14:09:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5603F227896;
	Tue, 19 Dec 2023 14:09:21 +0100 (CET)
Received: from localhost (10.201.21.240) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Dec
 2023 14:09:21 +0100
From: <gabriel.fernandez@foss.st.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/2] arm64: dts: st: add rcc support in stm32mp251
Date: Tue, 19 Dec 2023 14:09:09 +0100
Message-ID: <20231219130909.265091-3-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219130909.265091-1-gabriel.fernandez@foss.st.com>
References: <20231219130909.265091-1-gabriel.fernandez@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Add RCC support to manage clocks and resets on the STM32MP251.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 59 ++++++++++++++------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 96859d098ef8..ce51dbcdf0bb 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -3,7 +3,9 @@
  * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
  * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
  */
+#include <dt-bindings/clock/st,stm32mp25-rcc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/st,stm32mp25-rcc.h>
 
 / {
 	#address-cells = <2>;
@@ -35,22 +37,10 @@ arm_wdt: watchdog {
 	};
 
 	clocks {
-		ck_flexgen_08: ck-flexgen-08 {
+		clk_rcbsec: clk-rcbsec {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
-			clock-frequency = <100000000>;
-		};
-
-		ck_flexgen_51: ck-flexgen-51 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-		};
-
-		ck_icn_ls_mcu: ck-icn-ls-mcu {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
+			clock-frequency = <64000000>;
 		};
 	};
 
@@ -122,7 +112,7 @@ usart2: serial@400e0000 {
 				compatible = "st,stm32h7-uart";
 				reg = <0x400e0000 0x400>;
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ck_flexgen_08>;
+				clocks = <&rcc CK_KER_USART2>;
 				status = "disabled";
 			};
 
@@ -131,7 +121,7 @@ sdmmc1: mmc@48220000 {
 				arm,primecell-periphid = <0x00353180>;
 				reg = <0x48220000 0x400>, <0x44230400 0x8>;
 				interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ck_flexgen_51>;
+				clocks = <&rcc CK_KER_SDMMC1 >;
 				clock-names = "apb_pclk";
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
@@ -156,6 +146,19 @@ package_otp@1e8 {
 			};
 		};
 
+		rcc: clock-controller@44200000 {
+			compatible = "st,stm32mp25-rcc";
+			reg = <0x44200000 0x10000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			clock-names = "hse", "hsi", "msi", "lse", "lsi";
+			clocks = <&scmi_clk CK_SCMI_HSE>,
+				<&scmi_clk CK_SCMI_HSI>,
+				<&scmi_clk CK_SCMI_MSI>,
+				<&scmi_clk CK_SCMI_LSE>,
+				<&scmi_clk CK_SCMI_LSI>;
+		};
+
 		syscfg: syscon@44230000 {
 			compatible = "st,stm32mp25-syscfg", "syscon";
 			reg = <0x44230000 0x10000>;
@@ -174,7 +177,7 @@ gpioa: gpio@44240000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x0 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOA>;
 				st,bank-name = "GPIOA";
 				status = "disabled";
 			};
@@ -185,7 +188,7 @@ gpiob: gpio@44250000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x10000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOB>;
 				st,bank-name = "GPIOB";
 				status = "disabled";
 			};
@@ -196,7 +199,7 @@ gpioc: gpio@44260000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x20000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOC>;
 				st,bank-name = "GPIOC";
 				status = "disabled";
 			};
@@ -207,7 +210,7 @@ gpiod: gpio@44270000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x30000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOD>;
 				st,bank-name = "GPIOD";
 				status = "disabled";
 			};
@@ -218,7 +221,7 @@ gpioe: gpio@44280000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x40000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOE>;
 				st,bank-name = "GPIOE";
 				status = "disabled";
 			};
@@ -229,7 +232,7 @@ gpiof: gpio@44290000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x50000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOF>;
 				st,bank-name = "GPIOF";
 				status = "disabled";
 			};
@@ -240,7 +243,7 @@ gpiog: gpio@442a0000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x60000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOG>;
 				st,bank-name = "GPIOG";
 				status = "disabled";
 			};
@@ -251,7 +254,7 @@ gpioh: gpio@442b0000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x70000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOH>;
 				st,bank-name = "GPIOH";
 				status = "disabled";
 			};
@@ -262,7 +265,7 @@ gpioi: gpio@442c0000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x80000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOI>;
 				st,bank-name = "GPIOI";
 				status = "disabled";
 			};
@@ -273,7 +276,7 @@ gpioj: gpio@442d0000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x90000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOJ>;
 				st,bank-name = "GPIOJ";
 				status = "disabled";
 			};
@@ -284,7 +287,7 @@ gpiok: gpio@442e0000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0xa0000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOK>;
 				st,bank-name = "GPIOK";
 				status = "disabled";
 			};
@@ -303,7 +306,7 @@ gpioz: gpio@46200000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOZ>;
 				st,bank-name = "GPIOZ";
 				st,bank-ioport = <11>;
 				status = "disabled";
-- 
2.25.1


