Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4075A8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjGTIJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGTIJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:09:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173D269F;
        Thu, 20 Jul 2023 01:09:20 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K5cMvp025361;
        Thu, 20 Jul 2023 08:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=eOHwRTYQWQHq3iWpDXYWI9GG/MjJVrzm+Hp09fXHPhc=;
 b=Z6202SkRjzpHwEF/opmAN85L1/7jiBDmWPEtAsXH/a7wedgWGWtpCewOexoBvZcyerG0
 ulHb+hBPMNAmfgOpTYdYTZvcJrGzwG2hrJCeT1AY89/Rlx3aPbJcWg780KgUew1mRUMU
 DxEWBjpV0UsaoOCMzeEwaj4g4vL9FiaEI7tYU4ksQPrFxwEhesWUbxRQEsiZ2JBU9yP5
 DeGS5UlpD/jVHojnSdzAuoGhHPrQTMV7TEBNZUE2U0awD91m3/ncji7Q6VLxahq9hJPP
 xYaDAIHGHRq58ajJeFczQnGQ/BNBvFu4b+hDeS+mkvUwd9nlSWJznKmiXzpGDS2htsMM 3A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxxxv89pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:09:16 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36K89Dad010203;
        Thu, 20 Jul 2023 08:09:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm8dbv-1;
        Thu, 20 Jul 2023 08:09:13 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36K89Cbh010150;
        Thu, 20 Jul 2023 08:09:13 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36K89DQM010192;
        Thu, 20 Jul 2023 08:09:13 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id C38751586; Thu, 20 Jul 2023 13:39:12 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 4/4] arm64: dts: qcom: sm8550: Update the RPMHPD bindings entry
Date:   Thu, 20 Jul 2023 13:39:05 +0530
Message-Id: <1689840545-5094-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aErxqgzulxy6FTwh1cmaiFKtA8yNz1cd
X-Proofpoint-ORIG-GUID: aErxqgzulxy6FTwh1cmaiFKtA8yNz1cd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200066
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the RPMHPD bindings entry as per the new generic bindings defined
in rpmhpd.h for SM8550 SoC.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 41d60af..59bd1c7 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
@@ -1989,8 +1990,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8550_CX>,
-					<&rpmhpd SM8550_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mss";
 
 			interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
@@ -2368,7 +2369,7 @@
 			iommus = <&apps_smmu 0x540 0>;
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
-			power-domains = <&rpmhpd SM8550_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 
 			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
@@ -2412,7 +2413,7 @@
 			reg = <0 0x0aaf0000 0 0x10000>;
 			clocks = <&bi_tcxo_div2>,
 				 <&gcc GCC_VIDEO_AHB_CLK>;
-			power-domains = <&rpmhpd SM8550_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -2471,7 +2472,7 @@
 					      "core",
 					      "vsync";
 
-				power-domains = <&rpmhpd SM8550_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
 				assigned-clock-rates = <19200000>;
@@ -2560,7 +2561,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp_opp_table>;
-				power-domains = <&rpmhpd SM8550_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 
@@ -2628,7 +2629,7 @@
 					      "iface",
 					      "bus";
 
-				power-domains = <&rpmhpd SM8550_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
 						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
@@ -2723,7 +2724,7 @@
 					      "iface",
 					      "bus";
 
-				power-domains = <&rpmhpd SM8550_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
 						  <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
@@ -2798,7 +2799,7 @@
 				 <0>,
 				 <0>, /* dp3 */
 				 <0>;
-			power-domains = <&rpmhpd SM8550_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -3933,8 +3934,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8550_LCX>,
-					<&rpmhpd SM8550_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC 0 &mc_virt SLAVE_EBI1 0>;
@@ -4065,9 +4066,9 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8550_CX>,
-					<&rpmhpd SM8550_MXC>,
-					<&rpmhpd SM8550_NSP>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_NSP>;
 			power-domain-names = "cx", "mxc", "nsp";
 
 			interconnects = <&nsp_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
-- 
2.7.4

