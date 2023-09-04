Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC5E791180
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352378AbjIDGhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjIDGho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:37:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0ABCD5;
        Sun,  3 Sep 2023 23:37:25 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38468quf024660;
        Mon, 4 Sep 2023 06:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=A8uUc3TL8ptpzW8y0hLYgY4gG267RxBj3hkuXe1Sa5c=;
 b=h/sINcR015hSHGEjq38sEZVL+oM5cepWFc24N0MBTn+020wdIvxbv9vByX3n9B6b3+qz
 5Lq3PvkK35lNOmEDSp4j0Ny0fHECSrxoPlmp7UwoKoe/Pxt3nwQWs2P7dhkM4cZ63Lu5
 cnfAmV0PacxDlzRBK5g7k43m2GNmrkDRBZmDgl773bHmyKf/RXOfX/OfWb0J+6F2Gy7d
 Lr1GHS1gO7cqwqJdULDbydNF96QdWoGNGKCqlxV4z7hRPdCcH1lpLQg9cTJEa+bUwgvF
 iT3glDEP/VkOzNDDAA1KRQ0X5Aa2MQmUJWRTU2IbAtWFpczeqS6M9tkuJ8pYnnrv0TVV IA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suw50tp20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 06:37:14 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3846bDPf021086
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 06:37:13 GMT
Received: from nsekar-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 3 Sep 2023 23:37:07 -0700
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
Subject: [PATCH V4 3/4] arm64: dts: qcom: ipq5018: Add USB related nodes
Date:   Mon, 4 Sep 2023 12:06:34 +0530
Message-ID: <20230904063635.24975-4-quic_nsekar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904063635.24975-1-quic_nsekar@quicinc.com>
References: <20230904063635.24975-1-quic_nsekar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3LTMfYaqSQJsjwvXZscDnNbXIkPdVwtF
X-Proofpoint-ORIG-GUID: 3LTMfYaqSQJsjwvXZscDnNbXIkPdVwtF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=863 clxscore=1015
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309040059
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
V3:
	Renamed usb2_0_dwc to usb_dwc.
V2:
	Fix ordering of the USB related nodes and use
	generic node names.
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 9f13d2dcdfd5..dbd3be82afe3 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -93,6 +93,19 @@
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
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
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5018-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -155,6 +168,47 @@
 			status = "disabled";
 		};
 
+		usb: usb@8af8800 {
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
+			usb_dwc: usb@8a00000 {
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
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			reg = <0x0b000000 0x1000>,  /* GICD */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

