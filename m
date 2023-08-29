Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB3D78C1D4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjH2JzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjH2JzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:55:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16551EA;
        Tue, 29 Aug 2023 02:55:01 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T9HUI8029775;
        Tue, 29 Aug 2023 09:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=zPbtcj0FpaA9PaKgCSPnfUKtUEcbBEbDOm2Avie5ssw=;
 b=StNhib5KQEO4w/ilL4c2EE9AgqEe3Il3/ToGX3Sm9vNICco7gCwCpkgMJeUvkj8lh46U
 f7scFnrvHwdG7acwc8LAo48OmLmaZb6mT9qcsYayE34epOHLsPKPKNd8/IuCwOsUCi3X
 5cypVJGSFYXgM/T7E9wAHJKndUTRxxczPN2zBBVIEP73sc8ti97XEuH8pVBirYpifcfT
 EfuYkkTaz0DQhPB25nrGBpmZ+p1TPaMjbw4TFwSLqYApaua3oX5p7qLs7t0hWoZRM+oM
 A0CugxS0eH6hEL0ahEWt3PGZ3wE3blbQ8lvqrZA6KgVMYbZXlxehneJcwTynvB9J2Hzg oA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss4g6h556-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 09:54:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T9stMO017964
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 09:54:55 GMT
Received: from hu-gokulsri-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 02:54:51 -0700
From:   Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>
Subject: [PATCH 3/3] arm64: dts: qcom: ipq5018: enable the CPUFreq support
Date:   Tue, 29 Aug 2023 15:24:23 +0530
Message-ID: <20230829095423.760641-4-quic_gokulsri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lFycexPWdyCXXcN3t7TACOzEuQLGS0dU
X-Proofpoint-GUID: lFycexPWdyCXXcN3t7TACOzEuQLGS0dU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_06,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the APCS, A53 PLL, cpu-opp-table nodes to set
the CPU frequency at optimal range.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 9f13d2dcdfd5..05843517312c 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
 #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
+#include <dt-bindings/clock/qcom,apss-ipq.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -36,6 +37,8 @@ CPU0: cpu@0 {
 			reg = <0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU1: cpu@1 {
@@ -44,6 +47,8 @@ CPU1: cpu@1 {
 			reg = <0x1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		L2_0: l2-cache {
@@ -54,6 +59,17 @@ L2_0: l2-cache {
 		};
 	};
 
+	cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <200000>;
+		};
+	};
+
 	firmware {
 		scm {
 			compatible = "qcom,scm-ipq5018", "qcom,scm";
@@ -181,6 +197,24 @@ v2m1: v2m@1000 {
 			};
 		};
 
+		a53pll: clock@b116000 {
+			compatible = "qcom,ipq5018-a53pll";
+			reg = <0x0b116000 0x40>;
+			#clock-cells = <0>;
+			clocks = <&xo_board_clk>;
+			clock-names = "xo";
+		};
+
+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq5018-apcs-apps-global",
+				     "qcom,ipq6018-apcs-apps-global";
+			reg = <0x0b111000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&a53pll>, <&xo_board_clk>;
+			clock-names = "pll", "xo";
+			#mbox-cells = <1>;
+		};
+
 		timer@b120000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0b120000 0x1000>;
-- 
2.34.1

