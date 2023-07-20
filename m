Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0574E75A8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGTIJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjGTIJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:09:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B27426A3;
        Thu, 20 Jul 2023 01:09:22 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K4vLY3032721;
        Thu, 20 Jul 2023 08:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=K8DlcxEYI973HM+T5su4oMY2fO11c9TXyss6IznUf3Y=;
 b=hlDuu2DBwYhgvNHs2WF0KTm62GIuL0R+ytALFOPmDP5voy/I0rAGTcwurFdDz0N/lfx1
 LB4yLQ7/I9aL1D4JE9SMiKK5dKQh7O1ckKiLRbI7/S7UV2mGPr63S5odB+mmYjcsu3T1
 wI2Cl0KYcVdehJiiUU4CvbJZwhjlJxem8/WKN/q5T48feX2Hv1t+oIpf3OLU4fygQnLf
 a3S38T0t5SeeALDdSfhVPliToiQC+kRI0vL8aoEAHwIJQAxKh6cBxFf+/a+ZZJ6084nj
 WmUZ8y/YsWvnTIlx5mU9RXVy0OvBBwP4DXJSPv264lfREupgnWfZOV3+lhofviHyV68p Xg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxg3va0d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:09:18 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36K89D0h010191;
        Thu, 20 Jul 2023 08:09:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm8dbn-1;
        Thu, 20 Jul 2023 08:09:13 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36K89Cdw010149;
        Thu, 20 Jul 2023 08:09:13 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36K89CPn010169;
        Thu, 20 Jul 2023 08:09:13 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 43FA719A0; Thu, 20 Jul 2023 13:39:12 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 3/4] arm64: dts: qcom: sm8450: Update the RPMHPD bindings entry
Date:   Thu, 20 Jul 2023 13:39:04 +0530
Message-Id: <1689840545-5094-4-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1yUleyvKMgV2ne5fy1u8nXERnMfOUkcu
X-Proofpoint-ORIG-GUID: 1yUleyvKMgV2ne5fy1u8nXERnMfOUkcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=955 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200067
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the RPMHPD bindings entry as per the new generic bindings defined
in rpmhpd.h for SM8450 SoC.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 37 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 5cd7296..6bd6a6c 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/interconnect/qcom,sm8450.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -1149,7 +1150,7 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi0_data_clk>, <&qup_spi0_cs>;
-				power-domains = <&rpmhpd SM8450_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
@@ -1312,7 +1313,7 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_spi4_data_clk>, <&qup_spi4_cs>;
-				power-domains = <&rpmhpd SM8450_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
@@ -2097,8 +2098,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8450_LCX>,
-					<&rpmhpd SM8450_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;
@@ -2372,8 +2373,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8450_LCX>,
-					<&rpmhpd SM8450_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&adsp_mem>;
@@ -2477,8 +2478,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8450_CX>,
-					<&rpmhpd SM8450_MXC>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>;
 			power-domain-names = "cx", "mxc";
 
 			memory-region = <&cdsp_mem>;
@@ -2584,8 +2585,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8450_CX>,
-					<&rpmhpd SM8450_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mss";
 
 			memory-region = <&mpss_mem>;
@@ -2613,7 +2614,7 @@
 			reg = <0 0x0aaf0000 0 0x10000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_VIDEO_AHB_CLK>;
-			power-domains = <&rpmhpd SM8450_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -2705,7 +2706,7 @@
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>,
 				 <&sleep_clk>;
-			power-domains = <&rpmhpd SM8450_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -2767,7 +2768,7 @@
 				assigned-clock-rates = <19200000>;
 
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmhpd SM8450_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
@@ -2859,7 +2860,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp_opp_table>;
-				power-domains = <&rpmhpd SM8450_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 
@@ -2925,7 +2926,7 @@
 				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&mdss_dsi_opp_table>;
-				power-domains = <&rpmhpd SM8450_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi0_phy>;
 				phy-names = "dsi";
@@ -3017,7 +3018,7 @@
 				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
 
 				operating-points-v2 = <&mdss_dsi_opp_table>;
-				power-domains = <&rpmhpd SM8450_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi1_phy>;
 				phy-names = "dsi";
@@ -3085,7 +3086,7 @@
 				 <0>,
 				 <0>, /* dp3 */
 				 <0>;
-			power-domains = <&rpmhpd SM8450_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -4243,7 +4244,7 @@
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
 			iommus = <&apps_smmu 0x4a0 0x0>;
-			power-domains = <&rpmhpd SM8450_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			bus-width = <4>;
 			dma-coherent;
-- 
2.7.4

