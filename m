Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7939C7A68E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjISQbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjISQbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:31:02 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F19A9;
        Tue, 19 Sep 2023 09:30:56 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38JCak6Y004702;
        Tue, 19 Sep 2023 18:30:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=zYvfK74alrh48fiNyFcGgJCqh5Wb2lHksVR/hhospKg=; b=ok
        1noQ6xa3XqYyMResXNAWzxnbKo/oSe3qQDyX1ZzTfLSsO4GBhi+6oo75IJVteuB2
        bsikxN2i2ly9LTT25r0C8CMRRfQYmdU+CWF9qi272aSLay2+CdDu/guC+WzKEO+W
        lsNDB9y673MTYPUpc1W8++SYHm5EPS2iVdA+1jBAblLI5+qW6/D/z10D2fJzz2gw
        5+U1rBNFybpxrqxk2K5ofkFe+NgJA9wC+k9eStCBOOjZUin1/XM8bF7EDaUkXMRI
        jxrwTLgny9AA0ryGJPnnVTwKHEIiH5WiBfJXO2T1ph9W3Xc/0PNqru7zKzfkjSPf
        7NE7YRpGeMDLPQ5snYvg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t5nx0hu68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 18:30:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B0F3100057;
        Tue, 19 Sep 2023 18:30:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 21C02268467;
        Tue, 19 Sep 2023 18:30:41 +0200 (CEST)
Received: from localhost (10.252.1.15) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 18:30:40 +0200
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
Subject: [PATCH 2/2] ARM: dts: stm32: add pins muxing for dfsdm on stm32mp13
Date:   Tue, 19 Sep 2023 18:30:09 +0200
Message-ID: <20230919163009.203752-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919163009.203752-1-olivier.moysan@foss.st.com>
References: <20230919163009.203752-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.1.15]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_08,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These pins are used for DFSDM on STM32MP13x Disco boards expansion
connector.
Pins mapping:
- EXP_GPIO27	DFSDM1_CKOUT
- EXP_GPIO22	DFSDM1_DATIN3
- EXP_GPIO4	 DFSDM1_DATIN1	(shared with TIM3_CH4)

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 39 +++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
index 5e3e627ceb54..50490053f03d 100644
--- a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
@@ -13,6 +13,45 @@ pins {
 		};
 	};
 
+	dfsdm_clkout_pins_a: dfsdm-clkout-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 3, AF3)>; /* DFSDM_CKOUT */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	dfsdm_clkout_sleep_pins_a: dfsdm-clkout-sleep-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 3, ANALOG)>; /* DFSDM_CKOUT */
+		};
+	};
+
+	dfsdm_datin1_pins_a: dfsdm-datin1-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 1, AF6)>; /* DFSDM_DATIN1 */
+		};
+	};
+
+	dfsdm_datin1_sleep_pins_a: dfsdm-datin1-sleep-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 1, ANALOG)>; /* DFSDM_DATIN1 */
+		};
+	};
+
+	dfsdm_datin3_pins_a: dfsdm-datin3-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 13, AF6)>; /* DFSDM_DATIN3 */
+		};
+	};
+
+	dfsdm_datin3_sleep_pins_a: dfsdm-datin3-sleep-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 13, ANALOG)>; /* DFSDM_DATIN3 */
+		};
+	};
+
 	i2c1_pins_a: i2c1-0 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
-- 
2.25.1

