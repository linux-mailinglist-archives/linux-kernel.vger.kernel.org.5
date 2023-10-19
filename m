Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C267CF301
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbjJSImf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbjJSImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:42:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91291D52;
        Thu, 19 Oct 2023 01:42:04 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J89PrW005581;
        Thu, 19 Oct 2023 08:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=m0AmhCm0JSBrSdfidoMph5nAJXYnICf0M/MiA5Ja0yI=;
 b=j3x8eXfdtfkwjJr3mM4h+UuSsZMHUp+NeOXIQyNfLQSB3tKI7UjKfCtA69XX2IsmYfnA
 uMC29S1L9wlegkJYD3OhD+Ow5c6bgGbI90bfZ0pihJ8u+lC/4tPhwoKSgPx/Hc/Ias6Y
 UA38+gF1VMbuLPz+PkzM4Mbs9afZwJokvRI5tzFD8sSAQdfcbCq9yyakE2RYZffG+xO1
 spcwYopMByRYh1x8WikptJ/sJjmqtzqVYmRbjHTmeYRWq2VUSzdvsZdJTgeqwXs7/A2E
 VjwQU+cUQfEJ2tqSqP1PmI0LrtaAY3R+3TmfjeaBDO/Sux/SuhNecztD+mhelQAffWM7 jQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt8xsb9h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:39 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J8fcAj006334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:41:38 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 01:41:32 -0700
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
Subject: [PATCH v4 7/9] arm64: dts: qcom: ipq5332: populate the opp table based on the eFuse
Date:   Thu, 19 Oct 2023 14:10:41 +0530
Message-ID: <ce87f42a4f05d8e654059649040308f65e46db57.1697694811.git.quic_varada@quicinc.com>
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
X-Proofpoint-GUID: krJ20BW2be3AA6ouDvT0VFjoniL_qs28
X-Proofpoint-ORIG-GUID: krJ20BW2be3AA6ouDvT0VFjoniL_qs28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_06,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=961 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310190072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ53xx have different OPPs available for the CPU based on
SoC variant. This can be determined through use of an eFuse
register present in the silicon.

Add support to read the eFuse and populate the OPPs based on it.

	------------------------------------------------
	Frequency	BIT2	BIT1	opp-supported-hw
			1.1GHz	1.5GHz
	------------------------------------------------
	1100000000	1	1	0x7
	1500000000	0	1	0x3
	------------------------------------------------

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v4:	Change opp-supported-hw from 0xf to 0x7 in commit log
	and DT entry.
v2:	Fix inconsistencies in comment and move it to commit log
	as suggested
	Remove opp-microvolt entries as no regulator is managed by Linux
	cpu_speed_bin -> cpu-speed-bin in node name
	Remove "nvmem-cell-names" due to dtbs_check error
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 4206f05..42e2e48 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -91,11 +91,19 @@
 	};
 
 	cpu_opp_table: opp-table-cpu {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-kryo-cpu";
 		opp-shared;
+		nvmem-cells = <&cpu_speed_bin>;
 
-		opp-1488000000 {
-			opp-hz = /bits/ 64 <1488000000>;
+		opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-supported-hw = <0x3>;
 			clock-latency-ns = <200000>;
 		};
 	};
@@ -163,6 +171,11 @@
 			reg = <0x000a4000 0x721>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			cpu_speed_bin: cpu-speed-bin@1d {
+				reg = <0x1d 0x2>;
+				bits = <7 2>;
+			};
 		};
 
 		rng: rng@e3000 {
-- 
2.7.4

