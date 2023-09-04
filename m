Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024087917F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbjIDNXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjIDNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:23:21 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD34C1;
        Mon,  4 Sep 2023 06:23:18 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3848SBCM020068;
        Mon, 4 Sep 2023 15:23:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=6ZJLtOXcg0MVIVlkS4dM0g9LSUrmW6socPhD8UPYamI=; b=vd
        E+GzH4HgueAyD5pvF3PppZUwwuMCkl8SQIKhrWoB27uGDf0uT+2aBgpZ6ZolvQaz
        JJPBHtodOo4+y9y6ddh9b1Vrv42luBlFkcN5WtQPW6E27Tck8Kl26bEa7qopc/vz
        1AlQJqw83qIEtgSOAplB2SsTZYpgi4mTG6dBzyPFTYpurLDNXipNJgmoMKek+MGa
        YrvHzwcpUh+49V959OC18Vwv4zl6+2x7kBq+jGm/drVf07kFnM7aQ98Qfz+/jfn3
        wECiHQ4b02/klR2CRImmh/zu76Mvu3EFCOwgjfu4wmEH6a+8eojZkbezg17+jMt+
        1np018AOUSd2qjyh2AzA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3svg0hd81w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 15:23:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B3A0B100058;
        Mon,  4 Sep 2023 15:23:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC23221B52C;
        Mon,  4 Sep 2023 15:23:08 +0200 (CEST)
Received: from localhost (10.201.20.125) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 4 Sep
 2023 15:23:05 +0200
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
Subject: [PATCH 3/3] arm64: dts: st: add SD-card support on STM32MP257F-EV1 board
Date:   Mon, 4 Sep 2023 15:22:12 +0200
Message-ID: <20230904132212.157405-4-yann.gautier@foss.st.com>
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

Add the configuration node for SD-card support on STM32MP257F-EV1 board.
For the moment it uses a fixed regulator for vmmc, and vqmmc is skipped
until regulator driver is available.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 39b4726cc0986..6c3b83c2b48fa 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "stm32mp257.dtsi"
 #include "stm32mp25xf.dtsi"
 #include "stm32mp25-pinctrl.dtsi"
@@ -39,6 +40,27 @@ fw@80000000 {
 			no-map;
 		};
 	};
+
+	vdd_sdcard: vdd-sdcard {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_sdcard";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	cd-gpios = <&gpiod 9 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	disable-wp;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&vdd_sdcard>;
+	status = "okay";
 };
 
 &usart2 {
-- 
2.34.1

