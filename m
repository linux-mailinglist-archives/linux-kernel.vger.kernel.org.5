Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A78751BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjGMIiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjGMIht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:37:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD474EE0;
        Thu, 13 Jul 2023 01:31:53 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D3IrVx007276;
        Thu, 13 Jul 2023 08:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=OvVpve00te1ZwJQ/bOJmWVnItW8H6mKEdRfBTfyFYKo=;
 b=kZFVe1wr7FeYlgrTTILJMwqIA8N9gKsGpZgq/TnEjAbwkrFGUEsYbxKFHc+1awRAR4PF
 /Xxr5YKrmCJBajEjtKTBTjqyS2WOL7S8wHhWSx3P3SZPTy9ORVVREznRidcqLu77LLZU
 nLEP0USo1GjOtRQHon2W+7RUW8ovrbRkX3k4XsCxFrChSK66BttU4g0U7M+6yWa1Zscs
 I+48JrTqTs6/yr5GLhSvxGmiOr1GkGnX7pKln6Py40Kz5gKlQ0rN2SBpC8lC9Mk8dk4e
 bvfd6LHKZ301Xz0eOJHxLng9Q4o9JdlB6yJCQSytep6xVGr1RhfWNAlhd/m9p1OEV3lM 9w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rshyubcsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 08:31:49 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D8VmLO032381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 08:31:48 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 01:31:18 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH 1/1] arm64: dts: qcom: ipq9574: Add cpu cooling maps
Date:   Thu, 13 Jul 2023 14:01:01 +0530
Message-ID: <20230713083101.971525-2-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713083101.971525-1-quic_ipkumar@quicinc.com>
References: <20230713083101.971525-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RdJODU28XW7RkrD-tIHrTsduXvLDBOnP
X-Proofpoint-ORIG-GUID: RdJODU28XW7RkrD-tIHrTsduXvLDBOnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=859 phishscore=0
 clxscore=1015 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu cooling maps for passive trip points. The cpu cooling
device states are mapped to cpufreq based scaling frequencies.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 61 +++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index f120c7c52351..45b24c7d5ac3 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -42,6 +43,7 @@ CPU0: cpu@0 {
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-supply = <&ipq9574_s1>;
+			#cooling-cells = <2>;
 		};
 
 		CPU1: cpu@1 {
@@ -54,6 +56,7 @@ CPU1: cpu@1 {
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-supply = <&ipq9574_s1>;
+			#cooling-cells = <2>;
 		};
 
 		CPU2: cpu@2 {
@@ -66,6 +69,7 @@ CPU2: cpu@2 {
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-supply = <&ipq9574_s1>;
+			#cooling-cells = <2>;
 		};
 
 		CPU3: cpu@3 {
@@ -78,6 +82,7 @@ CPU3: cpu@3 {
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-supply = <&ipq9574_s1>;
+			#cooling-cells = <2>;
 		};
 
 		L2_0: l2-cache {
@@ -727,18 +732,28 @@ cpu0-thermal {
 			thermal-sensors = <&tsens 10>;
 
 			trips {
-				cpu-critical {
+				cpu0_crit: cpu-critical {
 					temperature = <120000>;
 					hysteresis = <10000>;
 					type = "critical";
 				};
 
-				cpu-passive {
+				cpu0_alert: cpu-passive {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu0_alert>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu1-thermal {
@@ -747,18 +762,28 @@ cpu1-thermal {
 			thermal-sensors = <&tsens 11>;
 
 			trips {
-				cpu-critical {
+				cpu1_crit: cpu-critical {
 					temperature = <120000>;
 					hysteresis = <10000>;
 					type = "critical";
 				};
 
-				cpu-passive {
+				cpu1_alert: cpu-passive {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu1_alert>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu2-thermal {
@@ -767,18 +792,28 @@ cpu2-thermal {
 			thermal-sensors = <&tsens 12>;
 
 			trips {
-				cpu-critical {
+				cpu2_crit: cpu-critical {
 					temperature = <120000>;
 					hysteresis = <10000>;
 					type = "critical";
 				};
 
-				cpu-passive {
+				cpu2_alert: cpu-passive {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu2_alert>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu3-thermal {
@@ -787,18 +822,28 @@ cpu3-thermal {
 			thermal-sensors = <&tsens 13>;
 
 			trips {
-				cpu-critical {
+				cpu3_crit: cpu-critical {
 					temperature = <120000>;
 					hysteresis = <10000>;
 					type = "critical";
 				};
 
-				cpu-passive {
+				cpu3_alert: cpu-passive {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu3_alert>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		wcss-phyb-thermal {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

