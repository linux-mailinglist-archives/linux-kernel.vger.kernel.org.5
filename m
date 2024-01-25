Return-Path: <linux-kernel+bounces-39280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 902AD83CE19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD591F287F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FD113B7B1;
	Thu, 25 Jan 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n/1wJo5K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294F13A25F;
	Thu, 25 Jan 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216723; cv=none; b=N2eGGrMP1HYLvjvlkZJPh3gt2PrVELooYyJiV+33qfwySeclwFyM4awSmGcptRQwvW5GN7eIhKAPvqFH9SfwUDGV5TH+oITvlf1uMMr5tAsMt0DVxzMey9ugcJxLazEUwEfUn0KgNo+po7z48yUZOlREBYqCAU9ksv+njdDDqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216723; c=relaxed/simple;
	bh=cpwN3XiXaCX41NCkEGpr7RaCSMM8HTlY6C38ej5UOJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T1Qi/qr/qjHRgxJz59iKDfp0VoUijD24SQfo6oFBzI2te8W4/jPgHSNjOHN8PYAGHVCq7ATOMiSOu6F1odsx05uDaASME1gKFRXN6Z3BhZYKzdRctJt6NlcqJwBMhdFf5YJgbV2tLdu/VFsOz/h625L7y9APawowWS6Kpi8jFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n/1wJo5K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PKNFXP026820;
	Thu, 25 Jan 2024 21:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=0j5pGIwLhtD91lN2lXVh5PkLfTuL6A7rRDx5ANvPmoo
	=; b=n/1wJo5KN2lhSMd7Sa5PfDaK2h7JR9EIpijJA7wqwXL27BHtFiZ0EW/KZ8/
	w8q4UEeFpdw2KdgZA0ETwNdsBL93T9DkkF+DyOVPgPkvYWMH8ihg/uTJef+K4Xnq
	4SAwc72qyOgd6wXkyeCLwB4z26HFdLES/eLIsT4uc/TVDLg9e2LiPIDBXTe4cIx3
	D8fNN3+tCLO3zoZOeif/itFIqiX1klfDq+yIU0i7fEuj+FldxtXBJCKNJxo6jPMb
	11I5bsXjQCg4AIJ2FzokRdn6zu0SVGe6u85SB3wX6D6MpT949jomT0YLHBeji9MR
	7H1aBZCZ7xt0SajEgLIhGlBw9Ew==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vufwxag4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PL5D6D031719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:05:13 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 13:05:13 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 25 Jan 2024 13:05:12 -0800
Subject: [PATCH v4 6/8] arm64: dts: qcom: sa8295p-adp: add max20411
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240125-sa8295p-gpu-v4-6-7011c2a63037@quicinc.com>
References: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
In-Reply-To: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
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
        Johan Hovold
	<johan+linaro@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706216711; l=1705;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=9G8OC71Bo5Qk4jp3jd+PoCQTayjd12YeJaxENqcceCg=;
 b=aVyBszSnzdnKMLTHUTvTQeyLl5ubMqWhGYxhqO8v3osfhn5hW46km3jDN/NUoO/FOmGXiMXlp
 fKHQTLFLqptAVJbfYKzs6IQypzx9XjIFHOO8Gl3AzBNbR0pW+T3rXyC
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6EKjI-qxYskyzFuNApGyF-nIBXaD1zEd
X-Proofpoint-ORIG-GUID: 6EKjI-qxYskyzFuNApGyF-nIBXaD1zEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxlogscore=963 impostorscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401250152

From: Bjorn Andersson <andersson@kernel.org>

The SA8295P ADP has a MAX20411 LDO regulator on I2C 12, supplying the
VDD_GFX pads. Enable the bus and add the maxim,max20411 device on the
bus.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index fd253942e5e5..bd0962f39fc5 100644
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
@@ -728,4 +760,11 @@ wake-n-pins {
 			bias-pull-up;
 		};
 	};
+
+	qup1_i2c4_state: qup1-i2c4-state {
+		pins = "gpio0", "gpio1";
+		function = "qup12";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };

-- 
2.25.1


