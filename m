Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CEC7CF30A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbjJSInE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345119AbjJSIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:42:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B18182;
        Thu, 19 Oct 2023 01:42:17 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J7ubCM007234;
        Thu, 19 Oct 2023 08:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JIk2gX/el4YSdpH3SijmN7XQ28M3iMt/ElM1C5zqP/E=;
 b=edzZrsGlGsYvwDvJfEwcNJYEyryLrmtrF8qh2cQWTb0rxi6W+mRSDhrJ487QllGrF8Ot
 bnLTR8L4z/P64QFN7AqhgmJNDJcKb+nNczDHJat7brMsVE52q0O3JenG2omek89oztkZ
 WsH5cpj5J3Byq7CUjubOJjH08Ka57JrXXloGMhD30XO1KKqcbzMv282RPp+C3RrC6Dre
 5wbcRCI+PiRKwxzW332ncb4uLdemWVXVxDdCs77WWDZuyE9YLrCNN/+R3yHyMAP9u3pr
 RfoteK+6sCJ8MUX/VGkc1MJll3LTmUihQ/if3L5AhJi05fbEgg9BH4L1H5lHcWZPqPjh Lw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt5v83fyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:51 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J8foNx023731
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:50 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 01:41:44 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <sivaprak@codeaurora.org>, <quic_kathirav@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v4 9/9] arm64: dts: qcom: ipq9574: populate the opp table based on the eFuse
Date:   Thu, 19 Oct 2023 14:10:43 +0530
Message-ID: <64535a8aeadbfa2cd0699175e262ec9bc70d1df9.1697694811.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1697694811.git.quic_varada@quicinc.com>
References: <cover.1697694811.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3Jc1PkdEsKbISKzlinlG2gcdnMVkI0I-
X-Proofpoint-ORIG-GUID: 3Jc1PkdEsKbISKzlinlG2gcdnMVkI0I-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_06,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=983 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ95xx SoCs have different OPPs available for the CPU based on
SoC variant. This can be determined from an eFuse register
present in the silicon.

Add support to read the eFuse and populate the OPPs based on it.

Frequency	1.2GHz	1.8GHz	1.5GHz	No	opp-supported-hw
					Limit
------------------------------------------------------------
936000000	1	1	1	1	0xf
1104000000	1	1	1	1	0xf
1200000000	1	1	1	1	0xf
1416000000	0	1	1	1	0x7
1488000000	0	1	1	1	0x7
1800000000	0	1	0	1	0x5
2208000000	0	0	0	1	0x1
-----------------------------------------------------------

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2:	cpu_speed_bin -> cpu-speed-bin in node name
	Move comment to commit log
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index cc84f25..5f83ee4 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -106,42 +106,56 @@
 	};
 
 	cpu_opp_table: opp-table-cpu {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-kryo-cpu";
 		opp-shared;
+		nvmem-cells = <&cpu_speed_bin>;
 
 		opp-936000000 {
 			opp-hz = /bits/ 64 <936000000>;
 			opp-microvolt = <725000>;
+			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
 		};
 
 		opp-1104000000 {
 			opp-hz = /bits/ 64 <1104000000>;
 			opp-microvolt = <787500>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <862500>;
+			opp-supported-hw = <0xf>;
 			clock-latency-ns = <200000>;
 		};
 
 		opp-1416000000 {
 			opp-hz = /bits/ 64 <1416000000>;
 			opp-microvolt = <862500>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 
 		opp-1488000000 {
 			opp-hz = /bits/ 64 <1488000000>;
 			opp-microvolt = <925000>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 
 		opp-1800000000 {
 			opp-hz = /bits/ 64 <1800000000>;
 			opp-microvolt = <987500>;
+			opp-supported-hw = <0x5>;
 			clock-latency-ns = <200000>;
 		};
 
 		opp-2208000000 {
 			opp-hz = /bits/ 64 <2208000000>;
 			opp-microvolt = <1062500>;
+			opp-supported-hw = <0x1>;
 			clock-latency-ns = <200000>;
 		};
 	};
@@ -223,6 +237,11 @@
 			reg = <0x000a4000 0x5a1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			cpu_speed_bin: cpu-speed-bin@15 {
+				reg = <0x15 0x2>;
+				bits = <7 2>;
+			};
 		};
 
 		cryptobam: dma-controller@704000 {
-- 
2.7.4

