Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9283F7F505F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbjKVTPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjKVTPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:15:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3A6112;
        Wed, 22 Nov 2023 11:14:55 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMHptGA003524;
        Wed, 22 Nov 2023 19:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=CGxajvSqnsJS4AEbRPpU3p9Qm9mAX8i38DAN4NnJgjA=;
 b=jOoD4FjKzFHuuJeMKawxCxX4tCBdqtBmncbq7lFWQAaTQaYP2PQCCcZB3btlbh2WDsp6
 FQpoUmBjgDIyAWFxxEwkKqEWH47OA6FdCryggmqLaXErcxcl2GMgJCbpMZh5y5DzEKtO
 D0UAs2wv4kCwtdWLUpWO4gzeW7ksh5dnKWCn/GSq31CN3XmTWAc2KlOZQoaLt/vB3iBW
 CMFNje139SPbCvP5esOVBEEc7wezSi+Mw0uPDZFNKeAD1EXjwylYO0dZMzA6YBU9Grms
 mpA2V8jJCrRhfF5+4nmZipy3HAJ87g3sdwXMDu4KTaBDSq4hOzW6LIKNPnoGWcRZvVAy MQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhey59ctx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 19:14:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMJEotR005044
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 19:14:50 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 11:14:46 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_wcheng@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH 4/6] arm64: dts: qcom: Fix hs_phy_irq for non-QUSB2 targets
Date:   Thu, 23 Nov 2023 00:44:36 +0530
Message-ID: <20231122191436.3146-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cbnsFjJiIN2VsNubvNO477o3M-6PTuCo
X-Proofpoint-GUID: cbnsFjJiIN2VsNubvNO477o3M-6PTuCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_13,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=484
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1011 phishscore=0
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

On non-QUSB2 targets (like the ones that use femto phys, M31 phy, eusb2
phy), many of the QCOM DTs are missing the IRQ for either hs_phy_irq or
pwr_event. In one case, the hs_phy_irq was incorrectly defined with the
latter's IRQ number. Since the DT must describe the hw whether or not
the driver uses these interrupts, fix and add the missing entries in order
to describe the HW completely and accurately.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi |  5 ++++-
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi |  2 ++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi  | 20 +++++++++++++-------
 arch/arm64/boot/dts/qcom/sc7180.dtsi   |  3 ++-
 arch/arm64/boot/dts/qcom/sc7280.dtsi   |  6 +++++-
 arch/arm64/boot/dts/qcom/sm6375.dtsi   |  4 +++-
 arch/arm64/boot/dts/qcom/sm8150.dtsi   | 10 ++++++++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi   |  4 ++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi   |  4 ++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi   |  4 +++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi   |  4 +++-
 11 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 2aa5089a8513..7962d28cff01 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -586,10 +586,13 @@ usb: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>
 				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
+					  "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_GDSC>;
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index e559adaaeee7..e6b3cfa5a575 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -499,10 +499,12 @@ usb: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 76 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 18 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 19 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "ss_phy_irq",
 					  "dm_hs_phy_irq",
 					  "dp_hs_phy_irq";
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 13dd44dd9ed1..14dd916e6566 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -1614,11 +1614,13 @@ usb_0: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 14 IRQ_TYPE_EDGE_RISING>,
 					      <&pdc 15 IRQ_TYPE_EDGE_RISING>,
 					      <&pdc 12 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "pwr_event",
+			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
 					  "ss_phy_irq";
@@ -1701,11 +1703,13 @@ usb_1: usb@a8f8800 {
 					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 8 IRQ_TYPE_EDGE_RISING>,
 					      <&pdc 7 IRQ_TYPE_EDGE_RISING>,
 					      <&pdc 13 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "pwr_event",
+			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
 					  "ss_phy_irq";
@@ -1747,7 +1751,7 @@ usb_2_hsphy: phy@88e7000 {
 		};
 
 		usb_2: usb@a4f8800 {
-			compatible = "qcom,sa8775p-dwc3", "qcom,dwc3";
+			compatible = "qcom,sa8775p-dwc3-ter", "qcom,dwc3";
 			reg = <0 0x0a4f8800 0 0x400>;
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -1764,10 +1768,12 @@ usb_2: usb@a4f8800 {
 					  <&gcc GCC_USB20_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 10 IRQ_TYPE_EDGE_RISING>,
 					      <&pdc 9 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "pwr_event",
+			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 11f353d416b4..87c346127abb 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2965,10 +2965,11 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <150000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 8 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 9 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+			interrupt-names = "hs_phy_irq", "pwr_event","ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 04bf85b0399a..5b7ad3890018 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3433,7 +3433,7 @@ usb_dp_qmpphy_dp_in: endpoint {
 		};
 
 		usb_2: usb@8cf8800 {
-			compatible = "qcom,sc7280-dwc3", "qcom,dwc3";
+			compatible = "qcom,sc7280-dwc3-sec", "qcom,dwc3";
 			reg = <0 0x08cf8800 0 0x400>;
 			status = "disabled";
 			#address-cells = <2>;
@@ -3457,9 +3457,11 @@ usb_2: usb@8cf8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 12 IRQ_TYPE_EDGE_RISING>,
 					      <&pdc 13 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq";
 
@@ -3712,10 +3714,12 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 14 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 17 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
 					  "ss_phy_irq";
diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 2fba0e7ea4e6..45be399dca8e 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1403,11 +1403,13 @@ usb_1: usb@4ef8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <133333333>;
 
-			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "ss_phy_irq",
 					  "dm_hs_phy_irq",
 					  "dp_hs_phy_irq";
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 97623af13464..2e19ce0c738f 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3566,10 +3566,13 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
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
@@ -3619,10 +3622,13 @@ usb_2: usb@a8f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
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
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index be970472f6c4..ac0e96152aa7 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4132,10 +4132,12 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "ss_phy_irq",
 					  "dm_hs_phy_irq",
 					  "dp_hs_phy_irq";
@@ -4200,10 +4202,12 @@ usb_2: usb@a8f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "ss_phy_irq",
 					  "dm_hs_phy_irq",
 					  "dp_hs_phy_irq";
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index b46236235b7f..dfe87affe57d 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2322,10 +2322,12 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "ss_phy_irq",
 					  "dm_hs_phy_irq",
 					  "dp_hs_phy_irq";
@@ -2395,10 +2397,12 @@ usb_2: usb@a8f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "ss_phy_irq",
 					  "dm_hs_phy_irq",
 					  "dp_hs_phy_irq";
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index bde9c1093384..be8e28c53098 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4302,11 +4302,13 @@ usb_1: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "ss_phy_irq",
 					  "dm_hs_phy_irq",
 					  "dp_hs_phy_irq";
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7bafb3d88d69..06dcfba46cd7 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2926,11 +2926,13 @@ usb_1: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_RISING>,
 					      <&pdc 14 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "hs_phy_irq",
+					  "pwr_event",
 					  "ss_phy_irq",
 					  "dm_hs_phy_irq",
 					  "dp_hs_phy_irq";
-- 
2.42.0

