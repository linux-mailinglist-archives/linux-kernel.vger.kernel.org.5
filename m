Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C7D7CB905
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjJQDMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjJQDLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:11:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5E8F5;
        Mon, 16 Oct 2023 20:11:39 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H1C1PR012467;
        Tue, 17 Oct 2023 03:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=Kjra/0cjyoiECp8232apcs6dm3Z9K3KJxcZmuOoDaWE=;
 b=MPLf45ZLexCDji1YwdjS0H1EPExLlVDKXLJIE34841qodtnzmACXGi052RokiFsEvZjt
 /yrw21Tf6AQTbBTgqxho1GJrugsoxajJHxOE9ZA1tnv6u57JtQfhqt20XLpmKFPHXCIO
 4zw6Ba8UXHGMbG2wYE9ZDzOeskw0wH1+AjyrAGseEN6Oip0hZzhym7LhPaOGV/LtlfaY
 gfWaEX111y6Dwr+jCXAC8oybLIR4ySvP8QOLGpAsuNZzPHrm7ATKO8GR0mRCvHPuQaQB
 WowKeX5GVZ5rFmuT0+Hspo+QMSWh633w9d6L86IAw1jD2mP0/DuuKjqngz5bU0nJVoPr mg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ts9jns3vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H3BUS8019829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:30 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 16 Oct 2023 20:11:29 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Mon, 16 Oct 2023 20:11:20 -0700
Subject: [PATCH 12/12] arm64: dts: qcom: sc8180x: flatten usb_sec node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231016-dwc3-refactor-v1-12-ab4a84165470@quicinc.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
In-Reply-To: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697512286; l=3529;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=j+nuiTuhRw0PN9TEIVeYlc1Ov8T3E/XhRqEGlOaFLek=;
 b=cvWeCl9CQmeilvcU/MoFGmc29UcSaMPvFM40iST0o6QJsPpGwNz6VcdsL5a+eJnepLVV7AVGYUzX
 GuXK+ZxqAiZK7m0x7YUlQJSatFfLmVzI2C9yy0+yVoKVWmNhqzZC
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OuvarfouHy9-Pb124F5IuywSYBKaHW1F
X-Proofpoint-ORIG-GUID: OuvarfouHy9-Pb124F5IuywSYBKaHW1F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flatten one of the USB controllers in the SC8180X platform, as an
example.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 .../arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts |  6 ++--
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts        |  6 ++--
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 34 +++++++++-------------
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 3ea07d094b60..91a9d822ea43 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -607,11 +607,9 @@ &usb_sec_role_switch {
 };
 
 &usb_sec {
-	status = "okay";
-};
-
-&usb_sec_dwc3 {
 	dr_mode = "host";
+
+	status = "okay";
 };
 
 &wifi {
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index fd2fab4895b3..a17c69b5aa57 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -684,11 +684,9 @@ &usb_sec_role_switch {
 };
 
 &usb_sec {
-	status = "okay";
-};
-
-&usb_sec_dwc3 {
 	dr_mode = "host";
+
+	status = "okay";
 };
 
 &wifi {
diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index a34f438ef2d9..f5e427789ad8 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2605,8 +2605,8 @@ usb_prim_role_switch: endpoint {
 		};
 
 		usb_sec: usb@a8f8800 {
-			compatible = "qcom,sc8180x-dwc3", "qcom,dwc3";
-			reg = <0 0x0a8f8800 0 0x400>;
+			compatible = "qcom,sc8180x-dwc3", "qcom,dwc3", "snps,dwc3";
+			reg = <0 0x0a800000 0 0x200000>;
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
 				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
@@ -2622,11 +2622,12 @@ usb_sec: usb@a8f8800 {
 				      "xo";
 			resets = <&gcc GCC_USB30_SEC_BCR>;
 			power-domains = <&gcc USB30_SEC_GDSC>;
-			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+			interrupt-names = "dwc_usb3", "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
 			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
@@ -2637,26 +2638,17 @@ usb_sec: usb@a8f8800 {
 					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3_1 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-			dma-ranges;
+			iommus = <&apps_smmu 0x160 0>;
 
-			status = "disabled";
+			snps,dis_u2_susphy_quirk;
+			snps,dis_enblslpm_quirk;
+			phys = <&usb_sec_hsphy>, <&usb_sec_ssphy>;
+			phy-names = "usb2-phy", "usb3-phy";
 
-			usb_sec_dwc3: usb@a800000 {
-				compatible = "snps,dwc3";
-				reg = <0 0x0a800000 0 0xcd00>;
-				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
-				iommus = <&apps_smmu 0x160 0>;
-				snps,dis_u2_susphy_quirk;
-				snps,dis_enblslpm_quirk;
-				phys = <&usb_sec_hsphy>, <&usb_sec_ssphy>;
-				phy-names = "usb2-phy", "usb3-phy";
+			status = "disabled";
 
-				port {
-					usb_sec_role_switch: endpoint {
-					};
+			port {
+				usb_sec_role_switch: endpoint {
 				};
 			};
 		};

-- 
2.25.1

