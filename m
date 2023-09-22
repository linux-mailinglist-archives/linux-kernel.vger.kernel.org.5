Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30D7AB153
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjIVLu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjIVLuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:50:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A83102;
        Fri, 22 Sep 2023 04:50:46 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MBV4gO023156;
        Fri, 22 Sep 2023 11:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=EQBYP9wnO3A4vyh2riticlhqszcLB6pFZBnBpfFIMlE=;
 b=AkGwefejM/rNfG40jNib3t9EBZB5dNK3oDMRMUJDyGEQ8BxF9rPPXQOvhE2LPaAT2d5L
 qTF2VYI/S1p2omtkWZwgq8xyB2Eju/9UbuwbFQcy7sDjDPegokmiek/HdskhgDSQRY7z
 clouZxo/8dvJivuS4klOzej++36nqc07XdKQr1BRuOK0YrcKz82Gk2FMx1Cb/IKL5blG
 pIhqPPXAWvXj0gcq/RvevZFnW2V8WUJeYcuDSN9f3655M3etUp0VCcsHn0ItA7N0BMmf
 MYHU5Az2tTt6ZNImrc8d1lgNZuj6uFYlW72Su+SAu7pfNxrFlJbPmhZnXVSUAfxgtEKa kw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9a3e81bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:50:40 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38MBobWF027202;
        Fri, 22 Sep 2023 11:50:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3t55eman8w-1;
        Fri, 22 Sep 2023 11:50:37 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MBoaDv027188;
        Fri, 22 Sep 2023 11:50:36 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 38MBoaAQ027176;
        Fri, 22 Sep 2023 11:50:36 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id EE6B01E3C; Fri, 22 Sep 2023 17:20:35 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/3] arm64: dts: qcom: Add USB3 and PHY support
Date:   Fri, 22 Sep 2023 17:20:33 +0530
Message-Id: <1695383434-24705-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695383434-24705-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1695383434-24705-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sb66zP8VzLZPI65N74wmnNOlO6m4SBc4
X-Proofpoint-GUID: sb66zP8VzLZPI65N74wmnNOlO6m4SBc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_10,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220100
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree nodes for enabling USB3 controller, Qcom QMP PHY and
HS PHY on SDX75.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 116 ++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index dd3a525..c44cdd1 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -473,6 +473,47 @@
 			};
 		};
 
+		usb_hsphy: phy@ff4000 {
+			compatible = "qcom,sdx75-snps-eusb2-phy", "qcom,sm8550-snps-eusb2-phy";
+			reg = <0x0 0x00ff4000 0x0 0x154>;
+			#phy-cells = <0>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_qmpphy: phy@ff6000 {
+			compatible = "qcom,sdx75-qmp-usb3-uni-phy";
+			reg = <0x0 0x00ff6000 0x0 0x2000>;
+
+			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+				 <&gcc GCC_USB2_CLKREF_EN>,
+				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "cfg_ahb",
+				      "pipe";
+
+			power-domains = <&gcc GCC_USB3_PHY_GDSC>;
+
+			resets = <&gcc GCC_USB3_PHY_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "phy_phy";
+
+			#clock-cells = <0>;
+			clock-output-names = "usb3_uni_phy_pipe_clk_src";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		system_noc: interconnect@1640000 {
 			compatible = "qcom,sdx75-system-noc";
 			reg = <0x0 0x01640000 0x0 0x4b400>;
@@ -493,6 +534,81 @@
 			#hwlock-cells = <1>;
 		};
 
+		usb: usb@a6f8800 {
+			compatible = "qcom,sdx75-dwc3", "qcom,dwc3";
+			reg = <0x0 0x0a6f8800 0x0 0x400>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_USB30_SLV_AHB_CLK>,
+				 <&gcc GCC_USB30_MASTER_CLK>,
+				 <&gcc GCC_USB30_MSTR_AXI_CLK>,
+				 <&gcc GCC_USB30_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
+
+			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 9 IRQ_TYPE_EDGE_RISING>,
+					      <&pdc 10 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
+
+			power-domains = <&gcc GCC_USB30_GDSC>;
+
+			resets = <&gcc GCC_USB30_BCR>;
+
+			interconnects = <&system_noc MASTER_USB3_0 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_USB3 0>;
+			interconnect-names = "usb-ddr",
+					     "apps-usb";
+
+			status = "disabled";
+
+			usb_dwc3: usb@a600000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x0a600000 0x0 0xcd00>;
+				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x80 0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_hsphy>,
+				       <&usb_qmpphy>;
+				phy-names = "usb2-phy",
+					    "usb3-phy";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_dwc3_ss: endpoint {
+						};
+					};
+				};
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sdx75-pdc", "qcom,pdc";
 			reg = <0x0 0xb220000 0x0 0x30000>,
-- 
2.7.4

