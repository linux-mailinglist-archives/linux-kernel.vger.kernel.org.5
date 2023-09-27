Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7D27AFB47
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjI0Gns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjI0Gnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:43:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C798BD6;
        Tue, 26 Sep 2023 23:43:42 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R6N8tJ010265;
        Wed, 27 Sep 2023 06:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=grcXiU1rL1JdS3rjmP6yCf5YGtPt8aKV6reb5EDsOg0=;
 b=jTf7utlPdjOicgq5Rnc7pidKp7dwFRg1JGq02Vc4ZR02aEPY1zaPPMxTw//3NP8y7/hy
 uK8SyVZPF3ZT/od62H3wpXVtZCW3k6I6O0Vfl7JH7IyqgjzLGlsDEXXUccc1SHH617ND
 HleRZ1BBiwtKDZCpe6JIw0nHLA8A1iyz46IDhv00HrEX1d8Xtk/O96eMGkN+7mbncHLL
 dikfTb+U4UE9cjM/VbJ6K0IOIRYQG5HiAIBtJmHum5pvl0yQNqxlcpg8PPVyLIFRKNB1
 6qwd4IRBNSGm655V7mZC/UQuS6JHBxFDuS76Da5ufYddl3HPucwU300snRVyVaaWNCtO NQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc00rhxw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:43:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R6hc5v021476
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:43:38 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 23:43:34 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Wed, 27 Sep 2023 12:13:19 +0530
Subject: [PATCH v3 2/2] arm64: dts: qcom: ipq9574: Enable WPS buttons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230927-common-rdp-v3-2-3d07b3ff6d42@quicinc.com>
References: <20230927-common-rdp-v3-0-3d07b3ff6d42@quicinc.com>
In-Reply-To: <20230927-common-rdp-v3-0-3d07b3ff6d42@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695797006; l=1579;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=CgtyJQqks67uuPF7+643S8H8nwUn6ZAhsJOBh3t6R14=;
 b=0b3yJurcZA6mHoAO7TjLdciU9CF78GRlOe4btm0HMWNcAiv+S3OU82/6VX6FwbvVmPbkY/Jbg
 eLRw4Modmx4BTI5lCF+U/ceX1OqMHS8Cf2j2IT51Rkqgm2uAymCT/3D
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MzHtgwQPqEog6PMTi0QnhSeUCJL1GWpV
X-Proofpoint-ORIG-GUID: MzHtgwQPqEog6PMTi0QnhSeUCJL1GWpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=716 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anusha Rao <quic_anusha@quicinc.com>

Add support for wps buttons on GPIO 37.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 Changes in V3:
	- None
 Changes in V2:
	- Removed linux,input-type from button-wps.
	- Picked up Reviewed-by tag.
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi | 22 ++++++++++++++++++++++
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
@@ -36,6 +38,19 @@ regulator_fixed_0p925: s0925 {
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
@@ -95,6 +110,13 @@ spi_0_pins: spi-0-state {
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
2.34.1

