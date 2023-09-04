Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014327917F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349498AbjIDNXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbjIDNXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:23:18 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473FCCE0;
        Mon,  4 Sep 2023 06:23:05 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3848Rstt020316;
        Mon, 4 Sep 2023 15:22:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=iTRAlQX/n3iz+p8/WwFUFvJP/zaI4NOSV4I6/4psLwE=; b=zU
        DQtbrUhFazgVhuFYmiJuuQx58b0JAr+CuKPHolMYK0bS7ZUSD65dk8ECuFGxePOY
        g6gPrEzQUhDPZRx1w4RLS5BVLtEIShgaFmEmo4oCcrw4NwUQaYqCvMu8uoEZy9C0
        A0TKMXlkXNRJNRTn9zbyNIJndv1B3gtGnzBWbmSWY0uJ5D8b/5RC1RiH3GaUh++Q
        V0di6sWt03/5FJggQxhqfdfKA/l5MjaYaUVh1RiEFk6NRa5K1GPnPmMcnL3eacI2
        IoAfARxalfkodjCr/oSxm2lDxHL6+iVej2vlIJDpYGkIGSDPJwtrMlrIixOPxGl5
        AwAnkHtRsWGehi9V6SiA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sutff7bwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 15:22:53 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 886BF100058;
        Mon,  4 Sep 2023 15:22:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DE6821B52C;
        Mon,  4 Sep 2023 15:22:52 +0200 (CEST)
Received: from localhost (10.201.20.125) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 4 Sep
 2023 15:22:51 +0200
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 2/3] arm64: dts: st: add sdmmc1 pins for stm32mp25
Date:   Mon, 4 Sep 2023 15:22:11 +0200
Message-ID: <20230904132212.157405-3-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904132212.157405-1-yann.gautier@foss.st.com>
References: <20230904132212.157405-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.125]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pins used for SD-card on STM32MP257F-EV1 board.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
index d34a1d5e79c06..66791a974f8f2 100644
--- a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -6,6 +6,60 @@
 #include <dt-bindings/pinctrl/stm32-pinfunc.h>
 
 &pinctrl {
+	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 4, AF10)>, /* SDMMC1_D0 */
+				 <STM32_PINMUX('E', 5, AF10)>, /* SDMMC1_D1 */
+				 <STM32_PINMUX('E', 0, AF10)>, /* SDMMC1_D2 */
+				 <STM32_PINMUX('E', 1, AF10)>, /* SDMMC1_D3 */
+				 <STM32_PINMUX('E', 2, AF10)>; /* SDMMC1_CMD */
+			slew-rate = <2>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 3, AF10)>; /* SDMMC1_CK */
+			slew-rate = <3>;
+			drive-push-pull;
+			bias-disable;
+		};
+	};
+
+	sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 4, AF10)>, /* SDMMC1_D0 */
+				 <STM32_PINMUX('E', 5, AF10)>, /* SDMMC1_D1 */
+				 <STM32_PINMUX('E', 0, AF10)>, /* SDMMC1_D2 */
+				 <STM32_PINMUX('E', 1, AF10)>; /* SDMMC1_D3 */
+			slew-rate = <2>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 3, AF10)>; /* SDMMC1_CK */
+			slew-rate = <3>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('E', 2, AF10)>; /* SDMMC1_CMD */
+			slew-rate = <2>;
+			drive-open-drain;
+			bias-disable;
+		};
+	};
+
+	sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 4, ANALOG)>, /* SDMMC1_D0 */
+				 <STM32_PINMUX('E', 5, ANALOG)>, /* SDMMC1_D1 */
+				 <STM32_PINMUX('E', 0, ANALOG)>, /* SDMMC1_D2 */
+				 <STM32_PINMUX('E', 1, ANALOG)>, /* SDMMC1_D3 */
+				 <STM32_PINMUX('E', 3, ANALOG)>, /* SDMMC1_CK */
+				 <STM32_PINMUX('E', 2, ANALOG)>; /* SDMMC1_CMD */
+		};
+	};
+
 	usart2_pins_a: usart2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('A', 4, AF6)>; /* USART2_TX */
-- 
2.34.1

