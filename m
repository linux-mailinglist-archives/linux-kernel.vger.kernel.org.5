Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E3C7656F6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjG0PH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjG0PHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:07:22 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409833A8D;
        Thu, 27 Jul 2023 08:07:01 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RBDDmt020326;
        Thu, 27 Jul 2023 17:06:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=8ilBa9ENL6W8qkN0huPj8difUZwDj7XXO0BtfO8LZt0=;
 b=TrOjk7VSKIuMIgTb6XMQC61nQWauKcz+zT/GAotTJt7FpjvT7+ibD4Ef340qd9nVuKxG
 c3lxHSqcwnZdFGzaiz+IALEc7yLV+utyfoCigHL43CjCO8R9FtraT9HVJZ3vbOqTUd5A
 UG4YxufAcMQa842sGasuWa97EiA3aSs/UQw/QAKR2tsj1QqzAYZbstJDWDvoM3A6BzYk
 UG2bwWfTXL8obP1nV/y5ihciMEyk33QCX9f/pC+ycj7r+SPOMrA8maEJ4ANd9tT+D02t
 yDfI6aEF8yEcFanJREJQz7tMQqwOYqqfnzPtZMjy+2Vr8dSSWhltX5RFcg8z82gTenFK Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s3qgy98ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:06:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1A37D10002A;
        Thu, 27 Jul 2023 17:06:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 12B50209BA8;
        Thu, 27 Jul 2023 17:06:49 +0200 (CEST)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 27 Jul
 2023 17:06:48 +0200
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
Subject: [RFC v2 10/11] ARM: dts: stm32: add dfsdm pins muxing on stm32mp15
Date:   Thu, 27 Jul 2023 17:03:21 +0200
Message-ID: <20230727150324.1157933-11-olivier.moysan@foss.st.com>
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

Add STM32 DFSDM pin muxings to STM32MP15.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 39 +++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
index 05c9c4f8064c..f4dd46c176f9 100644
--- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
@@ -188,6 +188,45 @@ pins {
 		};
 	};
 
+	dfsdm_clkout_pins_a: dfsdm-clkout-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 13, AF3)>; /* DFSDM_CKOUT */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	dfsdm_clkout_sleep_pins_a: dfsdm-clkout-sleep-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 13, ANALOG)>; /* DFSDM_CKOUT */
+		};
+	};
+
+	dfsdm_data1_pins_a: dfsdm-data1-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 3, AF3)>; /* DFSDM_DATA1 */
+		};
+	};
+
+	dfsdm_data1_sleep_pins_a: dfsdm-data1-sleep-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 3, ANALOG)>; /* DFSDM_DATA1 */
+		};
+	};
+
+	dfsdm_data3_pins_a: dfsdm-data3-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 13, AF6)>; /* DFSDM_DATA3 */
+		};
+	};
+
+	dfsdm_data3_sleep_pins_a: dfsdm-data3-sleep-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 13, ANALOG)>; /* DFSDM_DATA3 */
+		};
+	};
+
 	ethernet0_rgmii_pins_a: rgmii-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
-- 
2.25.1

