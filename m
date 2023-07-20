Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88D275A8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjGTIJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjGTIJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:09:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135B726A6;
        Thu, 20 Jul 2023 01:09:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K6oW14008770;
        Thu, 20 Jul 2023 08:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=KRWmgpgDNXLh28kgcNoO08Pj/tIfi8+T3pDdzAo5EhU=;
 b=UjZ1anY0twr7d8H+sWfHLLy9HBD0vZtN5gOPE4xsS93EyZ4ZH7vV3UgOo6lZhM/iLX/m
 AF67AnfxiNaVxKWw+421pDnYH8+ixLtOyAFSfPYLYjwtOwx+s3Hl8F1Ul5104472lhFQ
 2QWcHlKcBjyboW6eyvFG+n2vOxeiloSJ7z3fXgLbey78vTBzdbvqjIoV8Yj+7nKZwL0i
 cmW42bl335aPzlKKVOskGzTNGhfX1GiezIj8OlohFC813m0rm5CciFlDoE8vU/HW3AzE
 UvtfYTaJR1I7E/iKkL9NI95DSFL1tQPWGoX2Isy2O4ZazDEmDL1R9XxxnharnOsEI79t kQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxd98jf77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:09:21 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36K89C5V010167;
        Thu, 20 Jul 2023 08:09:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm8db8-1;
        Thu, 20 Jul 2023 08:09:12 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36K89Cbf010150;
        Thu, 20 Jul 2023 08:09:12 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36K89CgS010147;
        Thu, 20 Jul 2023 08:09:12 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 82CCC1961; Thu, 20 Jul 2023 13:39:11 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 1/4] arm64: dts: qcom: sm8250: Update the RPMHPD bindings entry
Date:   Thu, 20 Jul 2023 13:39:02 +0530
Message-Id: <1689840545-5094-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ST64uLpyjUHN2kCchjh9aPZGaIMtT-ut
X-Proofpoint-ORIG-GUID: ST64uLpyjUHN2kCchjh9aPZGaIMtT-ut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=785 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200067
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the RPMHPD bindings entry as per the new generic bindings defined in
rpmhpd.h for SM8250 SoC.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 77 ++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 83ab6de..22bf99c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/interconnect/qcom,sm8250.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
@@ -1036,7 +1037,7 @@
 				dmas = <&gpi_dma2 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 0 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1068,7 +1069,7 @@
 				dmas = <&gpi_dma2 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 1 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1100,7 +1101,7 @@
 				dmas = <&gpi_dma2 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1132,7 +1133,7 @@
 				dmas = <&gpi_dma2 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 3 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1147,7 +1148,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart17_default>;
 				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
@@ -1177,7 +1178,7 @@
 				dmas = <&gpi_dma2 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 4 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1192,7 +1193,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart18_default>;
 				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
@@ -1222,7 +1223,7 @@
 				dmas = <&gpi_dma2 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 5 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1290,7 +1291,7 @@
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1322,7 +1323,7 @@
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1354,7 +1355,7 @@
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1369,7 +1370,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart2_default>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
@@ -1399,7 +1400,7 @@
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1431,7 +1432,7 @@
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1463,7 +1464,7 @@
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1495,7 +1496,7 @@
 				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1510,7 +1511,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_default>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
@@ -1540,7 +1541,7 @@
 				dmas = <&gpi_dma0 0 7 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 7 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1605,7 +1606,7 @@
 				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1637,7 +1638,7 @@
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1669,7 +1670,7 @@
 				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1701,7 +1702,7 @@
 				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1733,7 +1734,7 @@
 				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1748,7 +1749,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart12_default>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
@@ -1778,7 +1779,7 @@
 				dmas = <&gpi_dma1 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 5 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -2743,8 +2744,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8250_LCX>,
-					<&rpmhpd SM8250_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;
@@ -3463,7 +3464,7 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8250_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 
 			memory-region = <&cdsp_mem>;
 
@@ -3660,7 +3661,7 @@
 			iommus = <&apps_smmu 0x4a0 0x0>;
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
-			power-domains = <&rpmhpd SM8250_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 
 			status = "disabled";
@@ -3836,7 +3837,7 @@
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&videocc MVS0C_GDSC>,
 					<&videocc MVS0_GDSC>,
-					<&rpmhpd SM8250_MX>;
+					<&rpmhpd RPMHPD_MX>;
 			power-domain-names = "venus", "vcodec0", "mx";
 			operating-points-v2 = <&venus_opp_table>;
 
@@ -3897,7 +3898,7 @@
 			clocks = <&gcc GCC_VIDEO_AHB_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>;
-			power-domains = <&rpmhpd SM8250_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			clock-names = "iface", "bi_tcxo", "bi_tcxo_ao";
 			#clock-cells = <1>;
@@ -4177,7 +4178,7 @@
 				 <&rpmhcc RPMH_CXO_CLK_A>,
 				 <&sleep_clk>;
 			clock-names = "iface", "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
-			power-domains = <&rpmhpd SM8250_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			status = "disabled";
 			#clock-cells = <1>;
@@ -4230,7 +4231,7 @@
 				assigned-clock-rates = <19200000>;
 
 				operating-points-v2 = <&mdp_opp_table>;
-				power-domains = <&rpmhpd SM8250_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
@@ -4305,7 +4306,7 @@
 				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SM8250_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi0_phy>;
 
@@ -4397,7 +4398,7 @@
 				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
 
 				operating-points-v2 = <&dsi_opp_table>;
-				power-domains = <&rpmhpd SM8250_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi1_phy>;
 
@@ -4448,7 +4449,7 @@
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sm8250-dispcc";
 			reg = <0 0x0af00000 0 0x10000>;
-			power-domains = <&rpmhpd SM8250_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&mdss_dsi0_phy 0>,
@@ -5413,8 +5414,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8250_LCX>,
-					<&rpmhpd SM8250_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&adsp_mem>;
-- 
2.7.4

