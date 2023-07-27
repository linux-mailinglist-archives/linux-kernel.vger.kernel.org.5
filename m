Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E875B7656F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjG0PHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjG0PHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:07:30 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB433583;
        Thu, 27 Jul 2023 08:07:06 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RF3OLG027833;
        Thu, 27 Jul 2023 17:06:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=8kootPtuej1akXRgIZj40uYTNZjB/maQQhJwmvSicyU=;
 b=ukz8m6iJxzBb3Iryqt8KSx1TdcAXmPHXaXAnow3s4oMHhq4vyctKF8FRhPUc4weEnZhr
 egQPpPvzivCZQdhWOlR3B5ND4PUcUisSUzgcXbiqcgjrTsIrQqp0n29/5csw44YzeuxF
 j7pfEXdLbd6Aqe1AYrMCS5TL2WZZt5LBXmVc/loMIrsiLUCQzy1tUTwC2c73GcKMVLBN
 C2qzboWQ9hKtk6i2PRzkbCGsMgHkw1FxsTEvFFsCbMLnSV88fNJhMtMYpXhAYsBU/29X
 FCwJ3HesQuO9tQzkvATT1ZfzeTAQ6qXls61BSH75XYf0F/8TQ/tPA/Y6lnf/2RtTLZNB lQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s3kn2b2b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:06:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6E06D100049;
        Thu, 27 Jul 2023 17:06:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 65852209BA8;
        Thu, 27 Jul 2023 17:06:50 +0200 (CEST)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 27 Jul
 2023 17:06:50 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v2 11/11] ARM: dts: stm32: add dfsdm iio support on stm32mp157c-ev
Date:   Thu, 27 Jul 2023 17:03:22 +0200
Message-ID: <20230727150324.1157933-12-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This DT is an example of backend iio device used for STM32 DFSDM.
DFSDM filter1 has a single input channel, while filter0 is configured
to support scan mode with two input channels.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp157c-ev1.dts | 68 ++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-ev1.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
index af3800501875..edeac26f39a4 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
@@ -73,6 +73,27 @@ panel_backlight: panel-backlight {
 		default-on;
 		status = "okay";
 	};
+
+	sd_adc0: sd-adc0 {
+		compatible = "sd-modulator";
+		#io-backend-cells = <0>;
+		vref-supply = <&v3v3>;
+		status = "okay";
+	};
+
+	sd_adc1: sd-adc1 {
+		compatible = "sd-modulator";
+		#io-backend-cells = <0>;
+		vref-supply = <&v3v3>;
+		status = "okay";
+	};
+
+	sd_adc2: sd-adc2 {
+		compatible = "sd-modulator";
+		#io-backend-cells = <0>;
+		vref-supply = <&v3v3>;
+		status = "okay";
+	};
 };
 
 &cec {
@@ -99,6 +120,53 @@ dcmi_0: endpoint {
 	};
 };
 
+&dfsdm {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&dfsdm_clkout_pins_a
+		     &dfsdm_data1_pins_a &dfsdm_data3_pins_a>;
+	pinctrl-1 = <&dfsdm_clkout_sleep_pins_a
+		     &dfsdm_data1_sleep_pins_a &dfsdm_data3_sleep_pins_a>;
+	spi-max-frequency = <2048000>;
+	status = "okay";
+
+	dfsdm0: filter@0 {
+		compatible = "st,stm32-dfsdm-adc";
+		st,filter-order = <3>;
+		status = "okay";
+
+		channel@0 {
+			reg = <0>;
+			label = "in0";
+			st,adc-channel-types = "SPI_F";
+			st,adc-channel-clk-src = "CLKOUT";
+			st,adc-alt-channel;
+			io-backends = <&sd_adc0>;
+		};
+
+		channel@1 {
+			reg = <1>;
+			label = "in1";
+			st,adc-channel-types = "SPI_R";
+			st,adc-channel-clk-src = "CLKOUT";
+			io-backends = <&sd_adc1>;
+		};
+	};
+
+	dfsdm1: filter@1 {
+		compatible = "st,stm32-dfsdm-adc";
+		st,filter-order = <3>;
+		status = "okay";
+
+		channel@3 {
+			reg = <3>;
+			label = "in3";
+			st,adc-channel-types = "SPI_R";
+			st,adc-channel-clk-src = "CLKOUT";
+			io-backends = <&sd_adc2>;
+		};
+	};
+};
+
 &dsi {
 	phy-dsi-supply = <&reg18>;
 	#address-cells = <1>;
-- 
2.25.1

