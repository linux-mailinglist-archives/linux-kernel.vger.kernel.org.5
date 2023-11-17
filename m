Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD5F7EF007
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345816AbjKQKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345919AbjKQKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:19:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C32D6E;
        Fri, 17 Nov 2023 02:19:25 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH9npLv024010;
        Fri, 17 Nov 2023 10:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=I3t47yaVD6IJz32a48hMFWHw3n9QIHnVpYmbG/QO3zE=;
 b=Po8MxI0vcmYcOk1BEU0xtAUL/gZ51LjWBNM8VanAmc/zgp1kwtdqmokpi0AD3fDtS3fB
 0a1VeY8Vt8iHHm7yfJK1FbJOPeZ5YBeleJl/XPlEeHXaInlVWYCx55NchW1gK65shnpa
 ELYSDjQr09aVr45BQA9qLU1rEneaCX607zrd4YNDQdDa6XdvSqfXTdg39uAUks5Ajdh7
 bPXAh5FJOdgG216rsqvYkQbNoL+tsfRaNNGy607++rEh8/DgS85OyFlfWXl/NGFhHS6t
 EFTJNBbclkJ06lApV3WgQ5hcnrmkDE++879LgHLt6nDK8NCkkp5iNTxj6cvoVzJJAou7 ew== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udxs38wnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:19:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHAJ7BH011895
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:19:07 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 17 Nov 2023 02:19:03 -0800
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <-cc=kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 07/16] arm64: dts: qcom: sm8550-aim300: add PCIe0
Date:   Fri, 17 Nov 2023 18:18:08 +0800
Message-ID: <20231117101817.4401-8-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231117101817.4401-1-quic_tengfan@quicinc.com>
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dqo6agc68k6FcBSPHMDVAKE2sTIvbObg
X-Proofpoint-ORIG-GUID: Dqo6agc68k6FcBSPHMDVAKE2sTIvbObg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_08,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=825 mlxscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe0 nodes used with WCN7851 device.  The PCIe1 is not connected,
thus skip pcie_1_phy_aux_clk input clock to GCC.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550-aim300.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
index 202b979da8ca..3aca0a433a00 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
@@ -393,6 +393,38 @@
 	};
 };
 
+&gcc {
+	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
+		 <&pcie0_phy>,
+		 <&pcie1_phy>,
+		 <0>,
+		 <&ufs_mem_phy 0>,
+		 <&ufs_mem_phy 1>,
+		 <&ufs_mem_phy 2>,
+		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
+};
+
+&pcie_1_phy_aux_clk {
+	status = "disabled";
+};
+
+&pcie0 {
+	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l1e_0p88>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
 &pm8550b_eusb2_repeater {
 	vdd18-supply = <&vreg_l15b_1p8>;
 	vdd3-supply = <&vreg_l5b_3p1>;
-- 
2.17.1

