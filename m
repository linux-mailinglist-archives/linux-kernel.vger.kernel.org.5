Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95375935C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGSKmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjGSKmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:42:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB732102;
        Wed, 19 Jul 2023 03:41:55 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J9UEiU021477;
        Wed, 19 Jul 2023 10:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Ecbg2OnmIs4vBJmhjhujdBsdYzb+rzTk4ywKEpnttLk=;
 b=iN7OGaKZYA0NA9R8jF8W3xT/sz+QBPH/reAsO68EWXxNmnkoxcfOp2EkrQtWF8E93VEg
 WE/j+Bcug6F2Z7QuAoQAH1F17vDYFIj89xYm44WR7gbbwH9hlOuTN6w3nNRlRhpwUVT6
 tsQQFB4HS1TTg86xMEw0eSGe1q8ItaZWx1E7ZXhfMyJAWi3nzDHrD6OuWxhOlYSfKvsV
 uagr7VJMr615bf61q13KHtZpVdPu9gYgh++5bFdmzxjjktG0pCO2Sqov11DNLztAVIFO
 scz37jdcUdNxShrZBC/OQnZLnM2f/0UNNHz1f62jYqLGi6B13SvAWMVkJU+dP2Y8zBg6 ng== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxd7ur435-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 10:41:49 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36JAfmWn006809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 10:41:48 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 03:41:43 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH v4 4/5] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Date:   Wed, 19 Jul 2023 16:10:40 +0530
Message-ID: <20230719104041.126718-5-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719104041.126718-1-quic_ipkumar@quicinc.com>
References: <20230719104041.126718-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rsrJP7omJPOjqwKg1zo5hsUbl8Zm6VDm
X-Proofpoint-ORIG-GUID: rsrJP7omJPOjqwKg1zo5hsUbl8Zm6VDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds thermal zone nodes for sensors present in
IPQ5332.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
[v4]:
	No changes.
[v3]:
	Pick up R-b tag
[v2]:
	Added passive trips and alignment change.

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 78 +++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 026f99fda00c..fe9f0fdd44ee 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -480,4 +480,82 @@ timer {
 			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	thermal-zones {
+		rfa-0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 11>;
+
+			trips {
+				rfa-0-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		rfa-1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 12>;
+
+			trips {
+				rfa-1-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		misc-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 13>;
+
+			trips {
+				misc-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-top-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 14>;
+
+			trips {
+				cpu-top-critical {
+					temperature = <115000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+
+				cpu-passive {
+					temperature = <105000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		top-glue-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 15>;
+
+			trips {
+				top-glue-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

