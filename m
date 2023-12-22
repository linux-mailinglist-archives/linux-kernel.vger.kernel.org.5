Return-Path: <linux-kernel+bounces-9333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458BD81C440
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AB01C2476E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385014A9A;
	Fri, 22 Dec 2023 04:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lDGi4b4t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA31799C;
	Fri, 22 Dec 2023 04:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM3shF0030751;
	Fri, 22 Dec 2023 04:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=hw7HGZ4exnMXpD9AmefP41ZdwmPHWHk+V/vvTvvfyWw
	=; b=lDGi4b4tDHRjHL1pTRCiMvYMt6CtF8t0lNlkhYZL03xJ3iNd/xBAEalsnPw
	wzsF/ElA9FSD0MbEWDLu1WkrPL1KWjDQlDcKTx9yKlvUx5evSIni5IHr/YCnXqyM
	t/YMBEOviw7TrttWAq28uzRqWBd5l4UuU+iHgTUOiyHtTVrplycAxgSiqrfwTrDF
	q62SqNqsUXsH3bOQYaugfGI2UXnKPVan0h4PRag0ljTmzaVn1nruvTPUJIsVwh2k
	EZCL+3IwKv9OfZuhYKWw/1yERGhMX4d3bD+fjAbq5Z5BQPici22rjK2tnkhv2g7q
	5ZvF3F3dVBpUayrHe0P3Q0G0cAQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4vfwgtd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:39:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM4dPQX029451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:39:25 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 20:39:25 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 21 Dec 2023 20:39:27 -0800
Subject: [PATCH v2 6/8] arm64: dts: qcom: sa8295p-adp: add max20411
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-sa8295p-gpu-v2-6-4763246b72c0@quicinc.com>
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703219963; l=1708;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=uPJEZ29q+1XtW/ItxiqcpfhaLAFT2zlIpEFXYJ/C7Fg=;
 b=/zQLnoX9FkqGjzbkNqxnEhVHFu7+XO2GW5uQpuZ+ANwwIk6Ppw5LvWDa2d35nbcj0M7ImUjJ0aeL
 Q3jNh4wCBCXXlQFKnQB122A+KeCsX3nvCCu6Hgu7vrxysMN8/0sW
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ny9iJbg2T8fGeNzuRkhVLNA-Bg5rQxTs
X-Proofpoint-GUID: ny9iJbg2T8fGeNzuRkhVLNA-Bg5rQxTs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=982
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312220029

From: Bjorn Andersson <andersson@kernel.org>

The SA8295P ADP has a MAX20411 LDO regulator on I2C 12, supplying the
VDD_GFX pads. Enable the bus and add the maxim,max20411 device on the
bus.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index fd253942e5e5..14327c697116 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -266,6 +266,26 @@ &dispcc1 {
 	status = "okay";
 };
 
+&i2c12 {
+	pinctrl-0 = <&qup1_i2c4_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	vdd_gfx: regulator@39 {
+		compatible = "maxim,max20411";
+		reg = <0x39>;
+
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <800000>;
+
+		enable-gpios = <&pmm8540a_gpios 2 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&max20411_en>;
+		pinctrl-names = "default";
+	};
+};
+
 &mdss0 {
 	status = "okay";
 };
@@ -476,6 +496,10 @@ &pcie4_phy {
 	status = "okay";
 };
 
+&qup1 {
+	status = "okay";
+};
+
 &qup2 {
 	status = "okay";
 };
@@ -636,6 +660,14 @@ &xo_board_clk {
 
 /* PINCTRL */
 
+&pmm8540a_gpios {
+	max20411_en: max20411-en-state {
+		pins = "gpio2";
+		function = "normal";
+		output-enable;
+	};
+};
+
 &tlmm {
 	pcie2a_default: pcie2a-default-state {
 		clkreq-n-pins {
@@ -728,4 +760,12 @@ wake-n-pins {
 			bias-pull-up;
 		};
 	};
+
+	qup1_i2c4_state: qup1-i2c4-state {
+		pins = "gpio0", "gpio1";
+		function = "qup12";
+
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };

-- 
2.25.1


