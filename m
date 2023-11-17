Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4330A7EED21
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbjKQIH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343963AbjKQIHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:07:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D611C130;
        Fri, 17 Nov 2023 00:07:47 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH5MtnW032090;
        Fri, 17 Nov 2023 08:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=fZPQhBggJBPdPM1rA8KmXr9rr0bBHYkTMlX9xe67dQY=;
 b=dFw1JMkxedXqEFos7TVbpZjMnK0m/wIHAC2B21AamtUh8yDWEvwuaLlv5s4jqjgcPEBH
 2AXVPeOKWx3G+9HT/8mxCp8MCr4eFKzePWbYl0csrRLz9NbPyOTVaugVJS3yn2Asbn40
 SuwmvH4bauXNcRUReuuwazA7eFktsQ9gWyIkIo3wYkoAVUjSDYpd7hALoSIlMn04o4HM
 ST8mUT7icYpjvjPJcHQ1llpPypuQzsu1kOSh9NpGw3X2d1eQU7uK51nFXAQhhhVJZRXe
 uJsS7SnNZjxIvhpMo+irbYktVmvCDBS3oeuZ3w3raqNGe6G1MToNd696U7jtWk8a3zdB Qw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udkqa286r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 08:07:43 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AH87dfW025931;
        Fri, 17 Nov 2023 08:07:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3ua2pmpnx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 08:07:39 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AH87dml025909;
        Fri, 17 Nov 2023 08:07:39 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3AH87dBw025902
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 08:07:39 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
        id 84B272211F; Fri, 17 Nov 2023 13:37:38 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v5 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
Date:   Fri, 17 Nov 2023 13:37:35 +0530
Message-Id: <20231117080737.606687-2-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117080737.606687-1-quic_rohiagar@quicinc.com>
References: <20231117080737.606687-1-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yUEaR0q0RAOgOD4Iyd2p6A6QFCnAUU_9
X-Proofpoint-GUID: yUEaR0q0RAOgOD4Iyd2p6A6QFCnAUU_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_06,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=761
 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170058
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 52 +++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index e180aa4023ec..b4723faf8655 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -8,6 +8,8 @@
 
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sdx75-gcc.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,sdx75.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -203,6 +205,19 @@ scm: scm {
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
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x0>;
@@ -434,6 +449,9 @@ qupv3_id_0: geniqup@9c0000 {
 			clock-names = "m-ahb",
 				      "s-ahb";
 			iommus = <&apps_smmu 0xe3 0x0>;
+			interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+					 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "qup-core";
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -444,6 +462,12 @@ uart1: serial@984000 {
 				reg = <0x0 0x00984000 0x0 0x4000>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
 				pinctrl-0 = <&qupv3_se1_2uart_active>;
 				pinctrl-1 = <&qupv3_se1_2uart_sleep>;
@@ -453,6 +477,20 @@ uart1: serial@984000 {
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
@@ -733,6 +771,20 @@ cpufreq_hw: cpufreq@17d91000 {
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
2.25.1

