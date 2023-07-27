Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16E77656F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjG0PHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjG0PH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:07:29 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646333A99;
        Thu, 27 Jul 2023 08:07:05 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RAGCGk027809;
        Thu, 27 Jul 2023 17:06:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=cHJNhS5VpKNo5Y4bSY2x6zUc/+E49ZZVtd0aUR299gM=;
 b=ve2AIh0qTQh8YWjBZD9RLiywztDKv6ciGlP7kjkD4DhKWNfj0l7SeS3tqY4PYr83bift
 /oWSNgEw8v1B/OZCH9yEHbO6A97N/4T2MgAscuGF9IBohhHb75XHhCdL8vx7iY3iNecg
 p7FLQB5a6etgQxJBt/wuzi/u3wIgJkrMZcSZjX8LHu/DCwDapvsqwfZKSpmEGcXjiN2Z
 DueUSzVd8qgcuxEJo6t+Ihx76bh/tGVRtFnYzWxUFm8PVRKctGm2J5usA8e4mwZvJuBs
 bWYckD7nTC4/xHTQjrW0Q2FKDl4qD/QVYe9V3T3GdxE9/a9+ybZfewAO+53RX10ZIK16 Tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s3kn2b2ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:06:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE1A6100049;
        Thu, 27 Jul 2023 17:06:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B663E209BA8;
        Thu, 27 Jul 2023 17:06:47 +0200 (CEST)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 27 Jul
 2023 17:06:47 +0200
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
Subject: [RFC v2 09/11] ARM: dts: stm32: adopt new dfsdm bindings on stm32mp151
Date:   Thu, 27 Jul 2023 17:03:20 +0200
Message-ID: <20230727150324.1157933-10-olivier.moysan@foss.st.com>
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

Adapt STM32MP151 device tree to match DFSDM new bindings.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp151.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index 61508917521c..338457357248 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -970,7 +970,8 @@ dfsdm: dfsdm@4400d000 {
 
 			dfsdm0: filter@0 {
 				compatible = "st,stm32-dfsdm-adc";
-				#io-channel-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0>;
 				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&dmamux1 101 0x400 0x01>;
@@ -980,7 +981,8 @@ dfsdm0: filter@0 {
 
 			dfsdm1: filter@1 {
 				compatible = "st,stm32-dfsdm-adc";
-				#io-channel-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <1>;
 				interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&dmamux1 102 0x400 0x01>;
@@ -990,7 +992,8 @@ dfsdm1: filter@1 {
 
 			dfsdm2: filter@2 {
 				compatible = "st,stm32-dfsdm-adc";
-				#io-channel-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <2>;
 				interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&dmamux1 103 0x400 0x01>;
@@ -1000,7 +1003,8 @@ dfsdm2: filter@2 {
 
 			dfsdm3: filter@3 {
 				compatible = "st,stm32-dfsdm-adc";
-				#io-channel-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <3>;
 				interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&dmamux1 104 0x400 0x01>;
@@ -1010,7 +1014,8 @@ dfsdm3: filter@3 {
 
 			dfsdm4: filter@4 {
 				compatible = "st,stm32-dfsdm-adc";
-				#io-channel-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <4>;
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&dmamux1 91 0x400 0x01>;
@@ -1020,7 +1025,8 @@ dfsdm4: filter@4 {
 
 			dfsdm5: filter@5 {
 				compatible = "st,stm32-dfsdm-adc";
-				#io-channel-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <5>;
 				interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&dmamux1 92 0x400 0x01>;
-- 
2.25.1

