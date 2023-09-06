Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBB67934A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjIFE61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjIFE6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:58:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BB7CF0;
        Tue,  5 Sep 2023 21:57:54 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3864ek46003061;
        Wed, 6 Sep 2023 04:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=+7hj4gLsfRMKQtMhpVBPOEY7Iu0H6+gWihqQC361lf0=;
 b=c+6hE56jYxHD+HlqVs3FYXMRT9sQuqF8CFT/6q3kI6os1PQqdU3U4DZ43RKZgHOPYJQr
 R5HtsyeNTQZKcZDzj4Rkm6+gRZZqn5heq0GOkMnVtPfBSDipIvoxkfwItCW5fICZ/aaR
 p86tAmq6wGPSauMa41oiL+qxD6qmA7TyS++KvLYJegMDqzobiJR5f6lwsYEisCOZxg7z
 yTDcTSTUt9UsQZZIF/pZAQ6dVOLsZMUNc6cmMNgniMqZAdZtP7YODkZLw5uSJNRQ+akP
 3c1AxjhIC5iYOyxbULZWrHUXFsckzrg9Nc7s6UpkJuiFpQkaArSvTTDowH/ynF3DTRhe dw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxha305jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 04:57:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3864v920023164
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 04:57:09 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 5 Sep 2023 21:57:04 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Wed, 6 Sep 2023 10:26:26 +0530
Subject: [PATCH RESEND 7/7] arm64: dts: qcom: include the GPLL0 as clock
 provider for IPQ mailbox
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230904-gpll_cleanup-v1-7-de2c448f1188@quicinc.com>
References: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
In-Reply-To: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693976190; l=3211;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=shym5TfdS8PDN/wjdg2Pbcgcv3yNaESO9SmPeEzEq/A=;
 b=J5q+8afVvBB3JGjv+EJBTH3MaXWI8tDcTQt3W1Y5OFxip+HFUACekJqEI2ipQkfC3C8JJ4Y/o
 /ImJ7D6GVPMByZ+qcb05UZdGUIYBo2mJQmXqneDPilxM/wlLfQJ6Flq
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MddWxxAkFxaVRra3J-tXDj3YRlERdWy0
X-Proofpoint-GUID: MddWxxAkFxaVRra3J-tXDj3YRlERdWy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=902 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the kernel is booting up, APSS PLL will be running at 800MHz with
GPLL0 as source. Once the cpufreq driver is available, APSS PLL will be
configured to the rate based on the opp table and the source also will be
changed to APSS_PLL_EARLY.

Also, dynamic scaling of CPUFreq is not supported on IPQ5332, so to switch
between the frequencies we need to park the APSS PLL in safe source,
here it is GPLL0 and then shutdown and bring up the APSS PLL in the
desired rate. So this patch is preparatory one to enable the CPUFreq on
IPQ5332.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 8bfc2db44624..82761ae199a9 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -335,8 +335,8 @@ apcs_glb: mailbox@b111000 {
 				     "qcom,ipq6018-apcs-apps-global";
 			reg = <0x0b111000 0x1000>;
 			#clock-cells = <1>;
-			clocks = <&a53pll>, <&xo_board>;
-			clock-names = "pll", "xo";
+			clocks = <&a53pll>, <&xo_board>, <&gcc GPLL0>;
+			clock-names = "pll", "xo", "gpll0";
 			#mbox-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 47b8b1d6730a..a30a5b893762 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -619,8 +619,8 @@ apcs_glb: mailbox@b111000 {
 			compatible = "qcom,ipq6018-apcs-apps-global";
 			reg = <0x0 0x0b111000 0x0 0x1000>;
 			#clock-cells = <1>;
-			clocks = <&a53pll>, <&xo>;
-			clock-names = "pll", "xo";
+			clocks = <&a53pll>, <&xo>, <&gcc GPLL0>;
+			clock-names = "pll", "xo", "gpll0";
 			#mbox-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 00ed71936b47..0be19267bdcf 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -719,8 +719,8 @@ apcs_glb: mailbox@b111000 {
 			compatible = "qcom,ipq8074-apcs-apps-global",
 				     "qcom,ipq6018-apcs-apps-global";
 			reg = <0x0b111000 0x1000>;
-			clocks = <&a53pll>, <&xo>;
-			clock-names = "pll", "xo";
+			clocks = <&a53pll>, <&xo>, <&gcc GPLL0>;
+			clock-names = "pll", "xo", "gpll0";
 
 			#clock-cells = <1>;
 			#mbox-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 51aba071c1eb..89edb4b852df 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -652,8 +652,8 @@ apcs_glb: mailbox@b111000 {
 				     "qcom,ipq6018-apcs-apps-global";
 			reg = <0x0b111000 0x1000>;
 			#clock-cells = <1>;
-			clocks = <&a73pll>, <&xo_board_clk>;
-			clock-names = "pll", "xo";
+			clocks = <&a73pll>, <&xo_board_clk>, <&gcc GPLL0>;
+			clock-names = "pll", "xo", "gpll0";
 			#mbox-cells = <1>;
 		};
 

-- 
2.34.1

