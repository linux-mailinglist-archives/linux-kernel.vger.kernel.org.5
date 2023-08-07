Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFB7772619
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjHGNjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjHGNjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:39:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EB10E0;
        Mon,  7 Aug 2023 06:39:29 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3779UF3p004371;
        Mon, 7 Aug 2023 13:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=jh9XWdWP9vbNpuVI4af4NKmglUm1jhPm6b99yxUV0f4=;
 b=JyLrtCzPVjhxRkzbetDCUxN19YJlPBt6a0EgESbzVDBB+tthO/3Ol0XOE6D/JeyZHp9T
 f6qD/B6T4JdeltoonyGZUvQ5mWDdIoL2B4Qp5YxMBFuosrCaz3LFEKZuMtMhy8llY5ii
 Uit8r8VPQNHOgbeFf6yE9EB4xFpWiT74hsre5Bosv0bozNMsVquB1w5ewl6x2Zk7M2+6
 RIPtPFe6bPjYH6MXRWMZU6ZvpkxSl+C600SYbsq5gJksQtdoOseafgkT/TSbEJmu432J
 o9xiGdeUv3nywu0P8jOzquM4CEh28/RH3A6NcL33Fmw0U7rDQuJ+4FYIrrZRcOGXr96Z Fw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sax18rh0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 13:39:21 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 377Dcwta006458;
        Mon, 7 Aug 2023 13:38:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s9fgkp5tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 07 Aug 2023 13:38:58 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377DcvVT006297;
        Mon, 7 Aug 2023 13:38:57 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 377Dcvvp006278;
        Mon, 07 Aug 2023 13:38:57 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 09C5F1B56; Mon,  7 Aug 2023 19:08:57 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abel.vesa@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH RESEND v2 4/9] arm64: dts: qcom: Add pm7550ba PMIC dtsi
Date:   Mon,  7 Aug 2023 19:08:49 +0530
Message-Id: <1691415534-31820-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1691415534-31820-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1691415534-31820-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6z5inaBfhZGKhWQGNAYZ90R6K2sU_5Pk
X-Proofpoint-ORIG-GUID: 6z5inaBfhZGKhWQGNAYZ90R6K2sU_5Pk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=568 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070127
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dtsi for pm7550ba PMIC found in Qualcomm platforms.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/pm7550ba.dtsi | 70 ++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm7550ba.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm7550ba.dtsi b/arch/arm64/boot/dts/qcom/pm7550ba.dtsi
new file mode 100644
index 0000000..8b00ece
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm7550ba.dtsi
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pm7550ba-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm7550ba_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <145000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pm7550ba: pmic@7 {
+		compatible = "qcom,pm7550ba", "qcom,spmi-pmic";
+		reg = <7 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm7550ba_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x7 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm7550ba_gpios: gpio@8800 {
+			compatible = "qcom,pm7550ba-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm7550ba_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pm7550ba_eusb2_repeater: phy@fd00 {
+			compatible = "qcom,pm7550ba-eusb2-repeater", "qcom,pm8550b-eusb2-repeater";
+			reg = <0xfd00>;
+			#phy-cells = <0>;
+		};
+	};
+};
-- 
2.7.4

