Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0B47883E9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244354AbjHYJhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244000AbjHYJgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:36:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E74D1FD4;
        Fri, 25 Aug 2023 02:36:38 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P90g9s008013;
        Fri, 25 Aug 2023 09:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PM5ftXXX4VwCTXje2+2+jAsSfPxDxbFo0LAMIiTVimU=;
 b=XFWyovR/bIUaD0twmuyU01q17l/+PrCmAOQ7Wm4ngUgyLmYqoRrCMBP7/j0BGAEWVlud
 v/MFAiAln4leMPdDbG0gLb5CmfIqPHMaY6L7QXY3b0vfiNJfLfM0bg0m9C/z4yihWKcY
 wWIuw6APFXLTWHN6aUXhhVXBHrR7IyA22osYmbWC6DNyROHwBKV8HxWYmov9xSQMBVOr
 6qZXc637DNRX1OiO1y7oIA72lIfZQauLoTPNUZzXGIuyHEKSszQHl+B7NhyT/SvnR5oE
 LYe69D+LzCGZ2LLqzfYi5nGubkycMFepkPCbUuOMMMDEh9EcUTL5zCtTEwfcuR8SAmb4 aQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmnm8mbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 09:36:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37P9aTt9009202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 09:36:29 GMT
Received: from nsekar-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 25 Aug 2023 02:36:23 -0700
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Amandeep Singh <quic_amansing@quicinc.com>
Subject: [PATCH 4/5] arm64: dts: qcom: ipq5018: Add USB related nodes
Date:   Fri, 25 Aug 2023 15:05:30 +0530
Message-ID: <20230825093531.7399-5-quic_nsekar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825093531.7399-1-quic_nsekar@quicinc.com>
References: <20230825093531.7399-1-quic_nsekar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N--r3SX-1iiFNZ-6fR0zkSTL98ZNDYCN
X-Proofpoint-ORIG-GUID: N--r3SX-1iiFNZ-6fR0zkSTL98ZNDYCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_07,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=755 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB phy and controller nodes.

Co-developed-by: Amandeep Singh <quic_amansing@quicinc.com>
Signed-off-by: Amandeep Singh <quic_amansing@quicinc.com>
Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 9f13d2dcdfd5..ff477923a823 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -238,6 +238,60 @@
 				status = "disabled";
 			};
 		};
+
+		usbphy0: phy@5b000 {
+			compatible = "qcom,ipq5018-usb-hsphy";
+			reg = <0x0005b000 0x120>;
+
+			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
+
+			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		usb: usb2@8a00000 {
+			compatible = "qcom,ipq5018-dwc3", "qcom,dwc3";
+			reg = <0x08af8800 0x400>;
+
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq";
+
+			clocks = <&gcc GCC_USB0_MASTER_CLK>,
+				 <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
+				 <&gcc GCC_USB0_SLEEP_CLK>,
+				 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+			clock-names = "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
+
+			resets = <&gcc GCC_USB0_BCR>;
+
+			qcom,select-utmi-as-pipe-clk;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			status = "disabled";
+
+			usb2_0_dwc: usb@8a00000 {
+				compatible = "snps,dwc3";
+				reg = <0x08a00000 0xe000>;
+				clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+				clock-names = "ref";
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				phy-names = "usb2-phy";
+				phys = <&usbphy0>;
+				tx-fifo-resize;
+				snps,is-utmi-l1-suspend;
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+			};
+		};
 	};
 
 	timer {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

