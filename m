Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7007BB105
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjJFEyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjJFEyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:54:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C61FA;
        Thu,  5 Oct 2023 21:54:02 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3964WfWP018286;
        Fri, 6 Oct 2023 04:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=/YzFw6eLuWOFuO8DOa3u8Qh2Yhef99sBkmqbC6T9aB4=;
 b=f2TSgLq4cDwV6SwCgPZdKA5FiHG1EPrVhKJQLk6TUxsELqJLI9yCTqdTaH67Ja1difqS
 1ijSmQ5O7F9DJAmAnW4c0Buv1lN0FbqXtbk2xWxDyXBgt99BDZl+gvfJb3OxblFTaq16
 YytTGVrCuBf9O8hAz1HuTZL2uuk61ZNVi1LSOazBzkS3rSGffA9WI6GlrR/kXQtVSHbL
 Z3BaykuuWy9fnD6r6t8eZyRpsfpKZbgNnWLtK4NLMBBjxRmFi836WmTSvBrwWYHtAU0l
 MfmekmqrqEC2NReOOI/wmNKssmR7I2hYTAy578HRNK0T0hzQV/EahHsU1zZ8zK275xL2 kA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tj38n8rem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 04:53:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3964rpB6028876
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 04:53:51 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 5 Oct 2023 21:53:46 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH 3/4] arm64: dts: qcom: ipq9574: Add pwm support
Date:   Fri, 6 Oct 2023 10:23:16 +0530
Message-ID: <20231006045317.1056625-4-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006045317.1056625-1-quic_devipriy@quicinc.com>
References: <20231006045317.1056625-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ywQB6DyHy_-d6w311jCjYxZQKtgkmhtz
X-Proofpoint-GUID: ywQB6DyHy_-d6w311jCjYxZQKtgkmhtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_01,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=870 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM is in the TCSR area. Make tcsr "simple-mfd" compatible
and add pwm as a child of tcsr.
Also, Enable pwm support in RDP418 of IPQ9574 SoC.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 15 ++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
index 2b093e02637b..d275c98b4df7 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
@@ -43,6 +43,12 @@ &blsp1_uart2 {
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-0 = <&pwm_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &rpm_requests {
 	regulators {
 		compatible = "qcom,rpm-mp5496-regulators";
@@ -79,6 +85,12 @@ &sleep_clk {
 };
 
 &tlmm {
+	pwm_pins: pwm-state {
+		pins = "gpio57";
+		function = "pwm";
+		drive-strength = <8>;
+	};
+
 	sdc_default_state: sdc-default-state {
 		clk-pins {
 			pins = "gpio5";
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 8a72ad4afd03..5465254fbdde 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -296,8 +296,21 @@ tcsr_mutex: hwlock@1905000 {
 		};
 
 		tcsr: syscon@1937000 {
-			compatible = "qcom,tcsr-ipq9574", "syscon";
+			compatible = "qcom,tcsr-ipq9574", "syscon", "simple-mfd";
 			reg = <0x01937000 0x21000>;
+			ranges = <0x0 0x01937000 0x21000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pwm: pwm@a010 {
+				compatible = "qcom,ipq9574-pwm", "qcom,ipq6018-pwm";
+				reg = <0xa010 0x20>;
+				clocks = <&gcc GCC_ADSS_PWM_CLK>;
+				assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+				assigned-clock-rates = <100000000>;
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		sdhc_1: mmc@7804000 {
-- 
2.34.1

