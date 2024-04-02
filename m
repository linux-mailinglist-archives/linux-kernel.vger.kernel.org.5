Return-Path: <linux-kernel+bounces-127980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D318953F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11041F24C55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9AA823DD;
	Tue,  2 Apr 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RgHIg8WV"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBEB7A151;
	Tue,  2 Apr 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062525; cv=none; b=oTuJc8WWbpNUZ/eW9YUaWyuGNDCXrBhMCC1ibQz0jJbyOmJGF9Js47Y4F8mX31aHyEvyzu81cQ0trtlxSjcMeuhuvcZzmZDOqQI/UKyEccj5RpXcPR3Y6VOIcRrOqLmQJ5QUUwh1nOp8C8jalpKH1rMDTxxKd2P1vqawKEh6/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062525; c=relaxed/simple;
	bh=c4s8OsmjUGLvGQpKlUOCJ6Zy+20N2yx++tNv310tsME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5CZ3CSuXRV7T7lO0DNGahrXK7YAMS9459b9x6KWEVuvwFXN8tD2gWxEZVFUz3Rv3cQ1p/DRvZkOKze+MNLnjg6UIDzIDd3t4T3wn6js4Ln8B1JW+BIXFTRMF3awunU0IC1vrywODxgRIah4irpo1YGHpOh6S6GRFnKGtj50Aic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RgHIg8WV; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432Ai7SI020800;
	Tue, 2 Apr 2024 14:55:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=hKislKxnW7bDWoDYssDOxiVgE9aR5W6wE8Gb1TrL33s=; b=Rg
	HIg8WVHZgcQjBtIqxfg0eYo/Du53bT2f3+af81YQR0paznEh3SfYj2tKg4NlYrZw
	eZut+YiLMQ6gFRbuJFgAtZcdTBRrulO67PaURqRxlF1rlVYJtb9tsIIL8054CTAG
	rzzkrJxiFF0T6uEKKK4INZjxcUXavbjoVCRynuVO6ugMvLHIVmmBzDzThEBOsD+N
	Uuqh5p0jKaUABQlU7zO9Bn4iiVCMbK3QWeLQRu2KTjP/kK98xFqipRrb5as4qbMy
	a1nVy+idauoZ0jrn8Fe3/cG8M7fFi/HrwL4OU+DNQAhOALEGt8OwBRzWilWDcsSb
	0vXk20YgsappD32x0TVg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x6w651qda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 14:55:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4331740044;
	Tue,  2 Apr 2024 14:55:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 99A242207D8;
	Tue,  2 Apr 2024 14:54:18 +0200 (CEST)
Received: from localhost (10.201.21.240) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 2 Apr
 2024 14:54:18 +0200
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
Subject: [RESEND PATCH v9 4/4] arm64: dts: st: add rcc support for STM32MP25
Date: Tue, 2 Apr 2024 14:53:12 +0200
Message-ID: <20240402125312.277052-5-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402125312.277052-1-gabriel.fernandez@foss.st.com>
References: <20240402125312.277052-1-gabriel.fernandez@foss.st.com>
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
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_06,2024-04-01_01,2023-05-22_02

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Add RCC support to manage clocks and resets on the STM32MP25.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 144 ++++++++++++++++++-------
 arch/arm64/boot/dts/st/stm32mp255.dtsi |   4 +-
 2 files changed, 110 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 5dd4f3580a60..15b79d26d1c6 100644
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
@@ -35,34 +37,16 @@ arm_wdt: watchdog {
 	};
 
 	clocks {
-		ck_flexgen_08: ck-flexgen-08 {
+		clk_dsi_txbyte: txbyteclk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
-			clock-frequency = <100000000>;
+			clock-frequency = <0>;
 		};
 
-		ck_flexgen_51: ck-flexgen-51 {
+		clk_rcbsec: clk-rcbsec {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-		};
-
-		ck_icn_ls_mcu: ck-icn-ls-mcu {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-		};
-
-		ck_icn_p_vdec: ck-icn-p-vdec {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-		};
-
-		ck_icn_p_venc: ck-icn-p-venc {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
+			clock-frequency = <64000000>;
 		};
 	};
 
@@ -134,7 +118,7 @@ usart2: serial@400e0000 {
 				compatible = "st,stm32h7-uart";
 				reg = <0x400e0000 0x400>;
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ck_flexgen_08>;
+				clocks = <&rcc CK_KER_USART2>;
 				status = "disabled";
 			};
 
@@ -143,8 +127,9 @@ sdmmc1: mmc@48220000 {
 				arm,primecell-periphid = <0x00353180>;
 				reg = <0x48220000 0x400>, <0x44230400 0x8>;
 				interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ck_flexgen_51>;
+				clocks = <&rcc CK_KER_SDMMC1 >;
 				clock-names = "apb_pclk";
+				resets = <&rcc SDMMC1_R>;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
 				max-frequency = <120000000>;
@@ -168,6 +153,93 @@ package_otp@1e8 {
 			};
 		};
 
+		rcc: clock-controller@44200000 {
+			compatible = "st,stm32mp25-rcc";
+			reg = <0x44200000 0x10000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			clocks = <&scmi_clk CK_SCMI_HSE>,
+				<&scmi_clk CK_SCMI_HSI>,
+				<&scmi_clk CK_SCMI_MSI>,
+				<&scmi_clk CK_SCMI_LSE>,
+				<&scmi_clk CK_SCMI_LSI>,
+				<&scmi_clk CK_SCMI_HSE_DIV2>,
+				<&scmi_clk CK_SCMI_ICN_HS_MCU>,
+				<&scmi_clk CK_SCMI_ICN_LS_MCU>,
+				<&scmi_clk CK_SCMI_ICN_SDMMC>,
+				<&scmi_clk CK_SCMI_ICN_DDR>,
+				<&scmi_clk CK_SCMI_ICN_DISPLAY>,
+				<&scmi_clk CK_SCMI_ICN_HSL>,
+				<&scmi_clk CK_SCMI_ICN_NIC>,
+				<&scmi_clk CK_SCMI_ICN_VID>,
+				<&scmi_clk CK_SCMI_FLEXGEN_07>,
+				<&scmi_clk CK_SCMI_FLEXGEN_08>,
+				<&scmi_clk CK_SCMI_FLEXGEN_09>,
+				<&scmi_clk CK_SCMI_FLEXGEN_10>,
+				<&scmi_clk CK_SCMI_FLEXGEN_11>,
+				<&scmi_clk CK_SCMI_FLEXGEN_12>,
+				<&scmi_clk CK_SCMI_FLEXGEN_13>,
+				<&scmi_clk CK_SCMI_FLEXGEN_14>,
+				<&scmi_clk CK_SCMI_FLEXGEN_15>,
+				<&scmi_clk CK_SCMI_FLEXGEN_16>,
+				<&scmi_clk CK_SCMI_FLEXGEN_17>,
+				<&scmi_clk CK_SCMI_FLEXGEN_18>,
+				<&scmi_clk CK_SCMI_FLEXGEN_19>,
+				<&scmi_clk CK_SCMI_FLEXGEN_20>,
+				<&scmi_clk CK_SCMI_FLEXGEN_21>,
+				<&scmi_clk CK_SCMI_FLEXGEN_22>,
+				<&scmi_clk CK_SCMI_FLEXGEN_23>,
+				<&scmi_clk CK_SCMI_FLEXGEN_24>,
+				<&scmi_clk CK_SCMI_FLEXGEN_25>,
+				<&scmi_clk CK_SCMI_FLEXGEN_26>,
+				<&scmi_clk CK_SCMI_FLEXGEN_27>,
+				<&scmi_clk CK_SCMI_FLEXGEN_28>,
+				<&scmi_clk CK_SCMI_FLEXGEN_29>,
+				<&scmi_clk CK_SCMI_FLEXGEN_30>,
+				<&scmi_clk CK_SCMI_FLEXGEN_31>,
+				<&scmi_clk CK_SCMI_FLEXGEN_32>,
+				<&scmi_clk CK_SCMI_FLEXGEN_33>,
+				<&scmi_clk CK_SCMI_FLEXGEN_34>,
+				<&scmi_clk CK_SCMI_FLEXGEN_35>,
+				<&scmi_clk CK_SCMI_FLEXGEN_36>,
+				<&scmi_clk CK_SCMI_FLEXGEN_37>,
+				<&scmi_clk CK_SCMI_FLEXGEN_38>,
+				<&scmi_clk CK_SCMI_FLEXGEN_39>,
+				<&scmi_clk CK_SCMI_FLEXGEN_40>,
+				<&scmi_clk CK_SCMI_FLEXGEN_41>,
+				<&scmi_clk CK_SCMI_FLEXGEN_42>,
+				<&scmi_clk CK_SCMI_FLEXGEN_43>,
+				<&scmi_clk CK_SCMI_FLEXGEN_44>,
+				<&scmi_clk CK_SCMI_FLEXGEN_45>,
+				<&scmi_clk CK_SCMI_FLEXGEN_46>,
+				<&scmi_clk CK_SCMI_FLEXGEN_47>,
+				<&scmi_clk CK_SCMI_FLEXGEN_48>,
+				<&scmi_clk CK_SCMI_FLEXGEN_49>,
+				<&scmi_clk CK_SCMI_FLEXGEN_50>,
+				<&scmi_clk CK_SCMI_FLEXGEN_51>,
+				<&scmi_clk CK_SCMI_FLEXGEN_52>,
+				<&scmi_clk CK_SCMI_FLEXGEN_53>,
+				<&scmi_clk CK_SCMI_FLEXGEN_54>,
+				<&scmi_clk CK_SCMI_FLEXGEN_55>,
+				<&scmi_clk CK_SCMI_FLEXGEN_56>,
+				<&scmi_clk CK_SCMI_FLEXGEN_57>,
+				<&scmi_clk CK_SCMI_FLEXGEN_58>,
+				<&scmi_clk CK_SCMI_FLEXGEN_59>,
+				<&scmi_clk CK_SCMI_FLEXGEN_60>,
+				<&scmi_clk CK_SCMI_FLEXGEN_61>,
+				<&scmi_clk CK_SCMI_FLEXGEN_62>,
+				<&scmi_clk CK_SCMI_FLEXGEN_63>,
+				<&scmi_clk CK_SCMI_ICN_APB1>,
+				<&scmi_clk CK_SCMI_ICN_APB2>,
+				<&scmi_clk CK_SCMI_ICN_APB3>,
+				<&scmi_clk CK_SCMI_ICN_APB4>,
+				<&scmi_clk CK_SCMI_ICN_APBDBG>,
+				<&scmi_clk CK_SCMI_TIMG1>,
+				<&scmi_clk CK_SCMI_TIMG2>,
+				<&scmi_clk CK_SCMI_PLL3>,
+				<&clk_dsi_txbyte>;
+		};
+
 		syscfg: syscon@44230000 {
 			compatible = "st,stm32mp25-syscfg", "syscon";
 			reg = <0x44230000 0x10000>;
@@ -186,7 +258,7 @@ gpioa: gpio@44240000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x0 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOA>;
 				st,bank-name = "GPIOA";
 				status = "disabled";
 			};
@@ -197,7 +269,7 @@ gpiob: gpio@44250000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x10000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOB>;
 				st,bank-name = "GPIOB";
 				status = "disabled";
 			};
@@ -208,7 +280,7 @@ gpioc: gpio@44260000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x20000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOC>;
 				st,bank-name = "GPIOC";
 				status = "disabled";
 			};
@@ -219,7 +291,7 @@ gpiod: gpio@44270000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x30000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOD>;
 				st,bank-name = "GPIOD";
 				status = "disabled";
 			};
@@ -230,7 +302,7 @@ gpioe: gpio@44280000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x40000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOE>;
 				st,bank-name = "GPIOE";
 				status = "disabled";
 			};
@@ -241,7 +313,7 @@ gpiof: gpio@44290000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x50000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOF>;
 				st,bank-name = "GPIOF";
 				status = "disabled";
 			};
@@ -252,7 +324,7 @@ gpiog: gpio@442a0000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x60000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOG>;
 				st,bank-name = "GPIOG";
 				status = "disabled";
 			};
@@ -263,7 +335,7 @@ gpioh: gpio@442b0000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x70000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOH>;
 				st,bank-name = "GPIOH";
 				status = "disabled";
 			};
@@ -274,7 +346,7 @@ gpioi: gpio@442c0000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x80000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOI>;
 				st,bank-name = "GPIOI";
 				status = "disabled";
 			};
@@ -285,7 +357,7 @@ gpioj: gpio@442d0000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x90000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOJ>;
 				st,bank-name = "GPIOJ";
 				status = "disabled";
 			};
@@ -296,7 +368,7 @@ gpiok: gpio@442e0000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0xa0000 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOK>;
 				st,bank-name = "GPIOK";
 				status = "disabled";
 			};
@@ -315,7 +387,7 @@ gpioz: gpio@46200000 {
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0 0x400>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&scmi_clk CK_SCMI_GPIOZ>;
 				st,bank-name = "GPIOZ";
 				st,bank-ioport = <11>;
 				status = "disabled";
diff --git a/arch/arm64/boot/dts/st/stm32mp255.dtsi b/arch/arm64/boot/dts/st/stm32mp255.dtsi
index 17f197c5b22b..d5175a1f339c 100644
--- a/arch/arm64/boot/dts/st/stm32mp255.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp255.dtsi
@@ -12,14 +12,14 @@ vdec: vdec@480d0000 {
 				compatible = "st,stm32mp25-vdec";
 				reg = <0x480d0000 0x3c8>;
 				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ck_icn_p_vdec>;
+				clocks = <&rcc CK_BUS_VDEC>;
 			};
 
 			venc: venc@480e0000 {
 				compatible = "st,stm32mp25-venc";
 				reg = <0x480e0000 0x800>;
 				interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ck_icn_ls_mcu>;
+				clocks = <&rcc CK_BUS_VENC>;
 			};
 		};
 	};
-- 
2.25.1


