Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303CF7A1E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjIOMQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbjIOMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:16:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B13F271D;
        Fri, 15 Sep 2023 05:16:07 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F4G2Hr017789;
        Fri, 15 Sep 2023 12:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=kXBJMB7bcEXDJM+JIcHmj9M9N9IZAo83EHKFYXq4ZfY=;
 b=PedBfwnBwbQmaZCb0MGBlBg0nx3MAs3Vzsq+Ejv2o36dpBfrSI2OoPNWc5IpfO6uRlPx
 ti0cDNlBwsjj/489mrCONy5aNcERz9/QtyfeOxbneczeOB5g4g4eydQhKmZmMH26pxb+
 0Zjbz7CCERme9xuf3dWxcZySLbnIDz52ukbIqjolEmqxbACJq8tx0+4zlZDn70BzJuuW
 gSrc+0lWNg3fzBlVEG0U3MRUyongXawdXmsGR62pelPC2kASQAtNOIiFs4kDOWfgj76o
 MFS2SrwUqJcIIB2nVHAE3YeslpwlwVZeM6D1SMJbRMiTAKyuWBOrdnvtED/Q5c7bUwRo Mw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g2xgyxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:15:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FCFuKO004584
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 12:15:56 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 05:15:51 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH V2 4/4] arm64: dts: qcom: ipq5018: Add tsens node
Date:   Fri, 15 Sep 2023 17:45:04 +0530
Message-ID: <20230915121504.806672-5-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915121504.806672-1-quic_srichara@quicinc.com>
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BBPFcswH7OTAcstoA94LwHU1NzcJtGMy
X-Proofpoint-ORIG-GUID: BBPFcswH7OTAcstoA94LwHU1NzcJtGMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_08,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 mlxlogscore=843 bulkscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 has tsens V1.0 IP with 4 sensors.
There is no RPM, so tsens has to be manually enabled. Adding the tsens
and nvmem node and IPQ5018 has 4 thermal sensors (zones). With the
critical temperature being 120'C and action is to reboot. Adding all
the 4 zones here. 

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v2] Fixed node names, order and added qfprom cells for points
      seperately to use the calibrate_common and squashed thermal_zone
      nodes here

 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 169 ++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 9f13d2dcdfd5..d53aea5342e2 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -93,6 +93,117 @@ soc: soc@0 {
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		qfprom: qfprom@a0000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "qcom,ipq5018-qfprom", "qcom,qfprom";
+			reg = <0xa0000 0x1000>;
+
+			tsens_base1: base1@249 {
+				reg = <0x249 2>;
+				bits = <3 8>;
+			};
+
+			tsens_base2: base2@24a {
+				reg = <0x24a 2>;
+				bits = <3 8>;
+			};
+
+			tsens_mode: mode@249 {
+				reg = <0x249 1>;
+				bits = <0 3>;
+			};
+
+			tsens_s0_p1: s0-p1@24b {
+				reg = <0x24b 0x2>;
+				bits = <2 6>;
+			};
+
+			tsens_s0_p2: s0-p2@24c {
+				reg = <0x24c 0x1>;
+				bits = <1 6>;
+			};
+
+			tsens_s1_p1: s1-p1@24c {
+				reg = <0x24c 0x2>;
+				bits = <7 6>;
+			};
+
+			tsens_s1_p2: s1-p2@24d {
+				reg = <0x24d 0x2>;
+				bits = <5 6>;
+			};
+
+			tsens_s2_p1: s2-p1@24e {
+				reg = <0x24e 0x2>;
+				bits = <3 6>;
+			};
+
+			tsens_s2_p2: s2-p2@24f {
+				reg = <0x24f 0x1>;
+				bits = <1 6>;
+			};
+
+			tsens_s3_p1: s3-p1@24f {
+				reg = <0x24f 0x2>;
+				bits = <7 6>;
+			};
+
+			tsens_s3_p2: s3-p2@250 {
+				reg = <0x250 0x2>;
+				bits = <5 6>;
+			};
+
+			tsens_s4_p1: s4-p1@251 {
+				reg = <0x251 0x2>;
+				bits = <3 6>;
+			};
+
+			tsens_s4_p2: s4-p2@254 {
+				reg = <0x254 0x1>;
+				bits = <0 6>;
+			};
+		};
+
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq5018-tsens", "qcom,tsens-v1";
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SORT */
+
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base1>,
+				      <&tsens_base2>,
+				      <&tsens_s0_p1>,
+				      <&tsens_s0_p2>,
+				      <&tsens_s1_p1>,
+				      <&tsens_s1_p2>,
+				      <&tsens_s2_p1>,
+				      <&tsens_s2_p2>,
+				      <&tsens_s3_p1>,
+				      <&tsens_s3_p2>,
+				      <&tsens_s4_p1>,
+				      <&tsens_s4_p2>;
+
+			nvmem-cell-names = "mode",
+					   "base1",
+					   "base2",
+					   "s0_p1",
+					   "s0_p2",
+					   "s1_p1",
+					   "s1_p2",
+					   "s2_p1",
+					   "s2_p2",
+					   "s3_p1",
+					   "s3_p2",
+					   "s4_p1",
+					   "s4_p2";
+
+			interrupts = <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "uplow";
+			#qcom,sensors = <5>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5018-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -240,6 +351,64 @@ frame@b128000 {
 		};
 	};
 
+	thermal-zones {
+		ubi32-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 1>;
+
+			trips {
+				ubi32-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+
+		top-glue-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				top_glue-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+
+		gephy-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				gephy-critical {
+					temperature = <120000>;
+					hysteresis = <2>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.34.1

