Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146C2751F68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjGMK7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjGMK7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:59:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFD5210A;
        Thu, 13 Jul 2023 03:59:35 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DAhQTT001857;
        Thu, 13 Jul 2023 10:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=aPNkDFlXMcQyNATzxXITLjy5X6Gk43qdNU3oEpnkxcg=;
 b=Wy0Ad2BoyMKVjNa/Yvlm//HzBjjZZiS3xHhLPEhKh4e8gPRYrX+G4Oetl7Z/99hXL5sn
 s80YpZcrG736LP6G2MJiAsxPVefma32yvyD+75X6JxouM/HSh75BFEUcfx6HxLF39KAA
 Sif3AZOaal2RVgxp+xHfyfQU08vTkNi5ndkl7WJI/iTN2+RAhNPWW0YytxoaRqwRX6e+
 jGa8c18Ffu9Rjb4xhD4wsYtKnDGl33d/CZO+UxvJHG1jDomyGpS0iGtVSRWRLIOVmKbt
 ungkGxXj8W66ktFIIG7Fvb8g4uUoL9L+e1ihAZ6Ar3SEKTm3XaIj3GU+mnMvGId2qpFm IA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtfah828p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 10:59:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DAxV76016827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 10:59:31 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 03:59:27 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH V2 2/2] arm64: dts: qcom: ipq9574: Enable WPS buttons
Date:   Thu, 13 Jul 2023 16:29:09 +0530
Message-ID: <20230713105909.14209-3-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230713105909.14209-1-quic_anusha@quicinc.com>
References: <20230713105909.14209-1-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: coq-HhQxNozQu7Cn7bjy2Q_zpvf48fqi
X-Proofpoint-ORIG-GUID: coq-HhQxNozQu7Cn7bjy2Q_zpvf48fqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=920 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for wps buttons on GPIO 37.

Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Changes in V2:
	- Removed linux,input-type from button-wps.
	- Picked up Reviewed-by tag.

 .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
index 40a7aefd0540..49c9b6478357 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
@@ -8,6 +8,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "ipq9574.dtsi"
 
 / {
@@ -36,6 +38,19 @@
 		regulator-always-on;
 		regulator-name = "fixed_0p925";
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
+
+		button-wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
+			debounce-interval = <60>;
+		};
+	};
 };
 
 &blsp1_spi0 {
@@ -95,6 +110,13 @@
 		drive-strength = <8>;
 		bias-disable;
 	};
+
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio37";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
 };
 
 &usb_0_dwc3 {
-- 
2.17.1

