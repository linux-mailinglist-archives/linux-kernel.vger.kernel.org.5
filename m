Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB67F5063
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbjKVTPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjKVTPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:15:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2D8112;
        Wed, 22 Nov 2023 11:15:10 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMIjOeD015973;
        Wed, 22 Nov 2023 19:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=yM1W0sZmXw1xsAemDaUfHtg0sc3P89khPm6pITUp2KA=;
 b=ilVJjAUSQqdZdenwOH3hp9DXpSdFM2AXcOdjM9h5tIVd3RM1p4USKNCZtusGsddmIbKi
 QacEoDKfPIACCOSRG9hCa+iFuKGNfh9oB/7+M857Abn0vwmUeZGM00UxF99a4o5p5NO1
 Go+aPcLy9RiVAfHUXNM1tCyJAE/sIEMcpjTJkmOzNkdfskhL32/64i4bThw8wFH95fuA
 13Gbo3BO/HWhb/9Co4eUS2eS40Wtm/E0xxDarhf1vw36ocRh8aMRmZHUpJHEuliVY49H
 HsEX3H91Hpwn/axK1uIq89xtH3D7gkKGYZsyVndpIsBrxY2DF39mrLLxJB+PGHL2YcBV hQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhey59cug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 19:15:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMJF65h005461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 19:15:06 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 11:15:01 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_wcheng@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH 5/6] arm64: dts: qcom: Fix hs_phy_irq for SDM670/SDM845/SM6350
Date:   Thu, 23 Nov 2023 00:44:52 +0530
Message-ID: <20231122191452.3183-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 01symdIODD-064Tlo4RYvqdIl2p6ltn7
X-Proofpoint-GUID: 01symdIODD-064Tlo4RYvqdIl2p6ltn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_13,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=628
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For sm6350/sdm670/sdm845, although they are qusb2 phy targets, dp/dm
interrupts are used for wakeup instead of qusb2_phy irq. These targets
were part of a generation that were the last ones to implement QUSB2 PHY
and the design incorporated dedicated DP/DM interrupts which eventually
carried forward to the newer femto based targets.

Add the missing pwr_event irq for these targets.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi |  5 ++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++--
 arch/arm64/boot/dts/qcom/sm6350.dtsi |  7 +++++--
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index 6d9843d05cb3..b8888f71b1d6 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1296,10 +1296,13 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <150000000>;
 
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
+					  "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index bf5e6eb9d313..c3e90e54e329 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4054,10 +4054,13 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <150000000>;
 
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
+					  "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
@@ -4105,10 +4108,13 @@ usb_2: usb@a8f8800 {
 			assigned-clock-rates = <19200000>, <150000000>;
 
 			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
+					  "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_SEC_GDSC>;
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8fd6f4d03490..af788e30eb45 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1839,12 +1839,15 @@ usb_1: usb@a6f8800 {
 				      "sleep",
 				      "mock_utmi";
 
-			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>;
 
-			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
+					  "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
-- 
2.42.0

