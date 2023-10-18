Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F9D7CD828
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjJRJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjJRJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:31:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20001996;
        Wed, 18 Oct 2023 02:31:12 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I58Vu6013865;
        Wed, 18 Oct 2023 09:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Q39nesa3iokJWBjY0DCM/z0AaNrX5/NIO6hWDZsdE/o=;
 b=NzvRc23zPVSMfaBzsPLMylVgPC885YC+eM34GHUflSA6GoMtFvmpK4KA9kW3wXFWLGYh
 4K0urSDkp+bN1k+L9hCVy3d0YIPq1mWg7BGgZJeLwnNz2G68sKc9zW9wABBjBBNKeFQg
 mVql52Mcm48alS4ncQPKKGsoBfDFDCVp/W8TStqpblvPVpq4BePxxfDCGDgocro9Qw/8
 E7SdRuGfNbnccdxmVeT8mAjmPB+FZeppivYZFlLPa5r9WJRaYykiF3B08BM4r+gSxsLS
 f+bmC0hp0SY+1O8tM9PXefi0hnCy29FZR3sSSBCCDXJPDNzai6wiLqI64IPKPEzZQ3pD cQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt8xs8hm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 09:31:09 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39I9V8PG019004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 09:31:08 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 18 Oct 2023 02:31:02 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 8/8] arm64: dts: qcom: ipq9574: populate the opp table based on the eFuse
Date:   Wed, 18 Oct 2023 14:59:21 +0530
Message-ID: <5d1bf44de58db10a20d1b116c7fd4b073d01271e.1697600121.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1697600121.git.quic_varada@quicinc.com>
References: <cover.1697600121.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vFowdpO-XE0_bRX19b5wnuQfH8no5yPv
X-Proofpoint-ORIG-GUID: vFowdpO-XE0_bRX19b5wnuQfH8no5yPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_07,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=924 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310180080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

