Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8B07AE937
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjIZJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjIZJ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:29:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97059EB;
        Tue, 26 Sep 2023 02:29:37 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q4B7fF007565;
        Tue, 26 Sep 2023 09:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=UxWctFinzxWPtTE82baPUgrf/I8UrWY8qGX4uCt/zbA=;
 b=HXspxwGy4Ql/DFHbQSfL8bA2b8L3uIELO3WygdAWGehiEA19V4J14sDhMljF2bPeA5HV
 QMcxkLUKnWueAqAvSiRdjnh7wruNaUfCq01dXpj0T6oT9hiRihXa7v5IngbU0GsjUtxA
 c5OLJDZCm+GBK3q50kcJDhanmJL1aKZQP6fB+V/AWqDsyxo5h7E9vJL3ofqHqDnHjeZV
 zuXrc6ewSd3Amof5EjCIDdvh/4Irlef2F85FNowFxaBC92W2+LoAMcxHOpxKCQI2mtve
 ZqM1ClN3HpZ1wmlvdUYohNdkrV9ikGnUmiu1gsqa/P+WN7M6NsYhqJBw0UVSBDOAgJ9Z lQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbgfv1dus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 09:29:31 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38Q9TRjm001614;
        Tue, 26 Sep 2023 09:29:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3t9s3knfx1-1;
        Tue, 26 Sep 2023 09:29:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38Q9TRu5001599;
        Tue, 26 Sep 2023 09:29:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 38Q9TQ1X001595;
        Tue, 26 Sep 2023 09:29:27 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 28E331E55; Tue, 26 Sep 2023 14:59:26 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
Date:   Tue, 26 Sep 2023 14:59:22 +0530
Message-Id: <1695720564-2978-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695720564-2978-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1695720564-2978-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9_EM_9oKG9EaddEfkGU_ed7DabM3JhuL
X-Proofpoint-ORIG-GUID: 9_EM_9oKG9EaddEfkGU_ed7DabM3JhuL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=777 mlxscore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260082
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnect nodes to support interconnects on SDX75.
Also parallely add the interconnect property for UART required
so that the bootup to shell does not break with interconnects
in place.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index e180aa4..dd3a525 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sdx75-gcc.h>
+#include <dt-bindings/interconnect/qcom,sdx75.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -197,6 +198,19 @@
 		};
 	};
 
+	clk_virt: interconnect-0 {
+		compatible = "qcom,sdx75-clk-virt";
+		#interconnect-cells = <2>;
+		qcom,bcm-voters = <&apps_bcm_voter>;
+		clocks = <&rpmhcc RPMH_QPIC_CLK>;
+	};
+
+	mc_virt: interconnect-1 {
+		compatible = "qcom,sdx75-mc-virt";
+		#interconnect-cells = <2>;
+		qcom,bcm-voters = <&apps_bcm_voter>;
+	};
+
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-sdx75", "qcom,scm";
@@ -434,6 +448,8 @@
 			clock-names = "m-ahb",
 				      "s-ahb";
 			iommus = <&apps_smmu 0xe3 0x0>;
+			interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>;
+			interconnect-names = "qup-core";
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -444,6 +460,10 @@
 				reg = <0x0 0x00984000 0x0 0x4000>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
 				pinctrl-0 = <&qupv3_se1_2uart_active>;
 				pinctrl-1 = <&qupv3_se1_2uart_sleep>;
@@ -453,6 +473,20 @@
 			};
 		};
 
+		system_noc: interconnect@1640000 {
+			compatible = "qcom,sdx75-system-noc";
+			reg = <0x0 0x01640000 0x0 0x4b400>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		pcie_anoc: interconnect@16c0000 {
+			compatible = "qcom,sdx75-pcie-anoc";
+			reg = <0x0 0x016c0000 0x0 0x14200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
@@ -733,6 +767,20 @@
 			#freq-domain-cells = <1>;
 			#clock-cells = <1>;
 		};
+
+		dc_noc: interconnect@190e0000 {
+			compatible = "qcom,sdx75-dc-noc";
+			reg = <0x0 0x190e0000 0x0 0x8200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gem_noc: interconnect@19100000 {
+			compatible = "qcom,sdx75-gem-noc";
+			reg = <0x0 0x19100000 0x0 0x34080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
 	};
 
 	timer {
-- 
2.7.4

