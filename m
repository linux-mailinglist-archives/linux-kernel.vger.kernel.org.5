Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A3675A8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjGTIJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjGTIJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:09:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097C4269A;
        Thu, 20 Jul 2023 01:09:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K7f6Am008355;
        Thu, 20 Jul 2023 08:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=gfBh3OrlTiQrsYPreEUZtdma+CaG40p0sx8ny7Tulf8=;
 b=fCWPGasAcVJd/jjkicDsS1vOYGzFnEPGHaEQ03r9VVWeQVKgmTHsme2AvRGDatBRFR88
 Lpi8o7zkqEsft8BLV8xe4RPYHU/pCxG/kj9vn+OO4mqZwfpjLn0xsyFfPzUXsx5Hml5r
 fiH3H4brvyAKqF5ePCChMxaKRNnykLEcWJ1IhEDqo5jktsjo166bYajZJANo4B033+xV
 VbmiANaGL/xxtZJWm2o4tpQDch2HEqRPR5vJJlftIoZcNyGJj16BIrMcv/sKn6VLxzG4
 8PweANJKTMk2op+jg6eABSCaTW/J4OV8nHk9xoGWAqKX3/G5sWzPuvQ4CWntG21IcmGo zw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxummrmdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:09:15 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36K89CpA010170;
        Thu, 20 Jul 2023 08:09:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm8dbb-1;
        Thu, 20 Jul 2023 08:09:12 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36K89C9k010155;
        Thu, 20 Jul 2023 08:09:12 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36K89Ctx010148;
        Thu, 20 Jul 2023 08:09:12 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id DAEC6199E; Thu, 20 Jul 2023 13:39:11 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/4] arm64: dts: qcom: sm8350: Update the RPMHPD bindings entry
Date:   Thu, 20 Jul 2023 13:39:03 +0530
Message-Id: <1689840545-5094-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689840545-5094-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: w3xZGNoaHYB6Kf2wU9DgY1_XGW7ds94C
X-Proofpoint-GUID: w3xZGNoaHYB6Kf2wU9DgY1_XGW7ds94C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200066
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the RPMHPD bindings entry as per the new generic bindings defined in
rpmhpd.h for SM8350 SoC.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 75 ++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 88ef478..edc072e 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/interconnect/qcom,sm8350.h>
@@ -737,7 +738,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
 				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_120mhz>;
 				dmas = <&gpi_dma2 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 0 QCOM_GPI_SPI>;
@@ -769,7 +770,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
 				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_120mhz>;
 				dmas = <&gpi_dma2 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 1 QCOM_GPI_SPI>;
@@ -801,7 +802,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
 				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma2 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 2 QCOM_GPI_SPI>;
@@ -833,7 +834,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
 				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma2 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 3 QCOM_GPI_SPI>;
@@ -851,7 +852,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
 				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma2 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 4 QCOM_GPI_SPI>;
@@ -869,7 +870,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart18_default>;
 				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				status = "disabled";
 			};
@@ -896,7 +897,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
 				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma2 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 5 QCOM_GPI_SPI>;
@@ -963,7 +964,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
@@ -995,7 +996,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
@@ -1027,7 +1028,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
@@ -1045,7 +1046,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart3_default_state>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				status = "disabled";
 			};
@@ -1058,7 +1059,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
@@ -1090,7 +1091,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
@@ -1122,7 +1123,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
@@ -1154,7 +1155,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
@@ -1172,7 +1173,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_default>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				status = "disabled";
 			};
@@ -1199,7 +1200,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma0 0 7 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 7 QCOM_GPI_SPI>;
@@ -1266,7 +1267,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_120mhz>;
 				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
@@ -1298,7 +1299,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
@@ -1330,7 +1331,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
@@ -1362,7 +1363,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
@@ -1394,7 +1395,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
@@ -1426,7 +1427,7 @@
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
-				power-domains = <&rpmhpd SM8350_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				operating-points-v2 = <&qup_opp_table_100mhz>;
 				dmas = <&gpi_dma1 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 5 QCOM_GPI_SPI>;
@@ -2003,8 +2004,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8350_CX>,
-					<&rpmhpd SM8350_MSS>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
 			power-domain-names = "cx", "mss";
 
 			interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
@@ -2044,8 +2045,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8350_LCX>,
-					<&rpmhpd SM8350_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&pil_slpi_mem>;
@@ -2114,7 +2115,7 @@
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
 			iommus = <&apps_smmu 0x4a0 0x0>;
-			power-domains = <&rpmhpd SM8350_CX>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			bus-width = <4>;
 			dma-coherent;
@@ -2475,7 +2476,7 @@
 				assigned-clock-rates = <19200000>;
 
 				operating-points-v2 = <&dpu_opp_table>;
-				power-domains = <&rpmhpd SM8350_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
@@ -2538,7 +2539,7 @@
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp_opp_table>;
-				power-domains = <&rpmhpd SM8350_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 
@@ -2606,7 +2607,7 @@
 							 <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&dsi0_opp_table>;
-				power-domains = <&rpmhpd SM8350_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi0_phy>;
 
@@ -2704,7 +2705,7 @@
 							 <&mdss_dsi1_phy 1>;
 
 				operating-points-v2 = <&dsi1_opp_table>;
-				power-domains = <&rpmhpd SM8350_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				phys = <&mdss_dsi1_phy>;
 
@@ -2795,7 +2796,7 @@
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 
-			power-domains = <&rpmhpd SM8350_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 		};
 
 		pdc: interrupt-controller@b220000 {
@@ -3188,8 +3189,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8350_LCX>,
-					<&rpmhpd SM8350_LMX>;
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&pil_adsp_mem>;
@@ -3417,8 +3418,8 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SM8350_CX>,
-					<&rpmhpd SM8350_MXC>;
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>;
 			power-domain-names = "cx", "mxc";
 
 			interconnects = <&compute_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
-- 
2.7.4

