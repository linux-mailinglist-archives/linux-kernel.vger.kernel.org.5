Return-Path: <linux-kernel+bounces-7823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B1681ADCB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16B92861E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B360114F7B;
	Thu, 21 Dec 2023 03:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZZtfraEM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EE579DC;
	Thu, 21 Dec 2023 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL3nDES020761;
	Thu, 21 Dec 2023 03:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=rr9r9gWxhO4lMOjEkKreNfvWKgKBiYqYX4s9TmL7zcQ
	=; b=ZZtfraEMM+C9hJeHXHu0wsytwhZK/1knz38pGjYDyVntREPd2bKCgJDquDm
	f6Ia2tBGaCvZth9rdd7Il8u8Q2UtxRaDT/LxxQ0/flHVCNNWcVi+APikkWmyGtTB
	cvu5zygqR1+3m/67sA8JgOLRyco5W4z/PDaGWCsMcUGiLUXTgZktgpCp/ecOZq90
	Fr5Z+i6jHOOBIQSiISZZ7g6xbcsakHgp8k9KQj3fJgCx6cadu9qyLLHELL4lu41q
	oOC7LXDlMQpzZlxGW8LTuvmu2TVkjq4c+rKrq8N7eyuttdxtbRtO37aOH1cDYRk3
	WKAEX8ohqfk5+AKejMKd/xr+LyQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3r6ru9m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:50:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL3opK2020560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 03:50:51 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 19:50:51 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 20 Dec 2023 19:50:40 -0800
Subject: [PATCH 6/8] arm64: dts: qcom: sa8295p-adp: add max20411
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-sa8295p-gpu-v1-6-d8cdf2257f97@quicinc.com>
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703130649; l=1576;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=iuhv7P68f++bs7xsess+Ut/fTJIye+b8NI9cCDTyLVc=;
 b=up+NYbS/7WM3RyIz183b67hkzTM4B+OxT3FeiOsRy7DKP/j7O7czuFnmznVDSKWIy3nQMV/XgEDy
 erOT+Ci2DAPf4unP6aUx+vpjqUlXheYer2PriM2JqsGSTG8WGsfU
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TaqN9-nB1Vy7tNOm2EgLwry4Nc5tp4yW
X-Proofpoint-GUID: TaqN9-nB1Vy7tNOm2EgLwry4Nc5tp4yW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=988 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210026

From: Bjorn Andersson <andersson@kernel.org>

The SA8295P ADP has a MAX20411 LDO regulator on I2C 12, supplying the
VDD_GFX pads. Enable the bus and add the maxim,max20411 device on the
bus.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index fd253942e5e5..e16406c9c19d 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -266,6 +266,26 @@ &dispcc1 {
 	status = "okay";
 };
 
+&i2c12 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup1_i2c4_state>;
+
+	status = "okay";
+
+	vdd_gfx: regulator@39 {
+		compatible = "maxim,max20411";
+		reg = <0x39>;
+
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <968750>;
+
+		enable-gpios = <&pmm8540a_gpios 2 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&max20411_en>;
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
@@ -728,4 +752,20 @@ wake-n-pins {
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
+};
+
+&pmm8540a_gpios {
+	max20411_en: max20411-en-state {
+		pins = "gpio2";
+		function = "normal";
+		output-enable;
+	};
 };

-- 
2.25.1


