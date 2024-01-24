Return-Path: <linux-kernel+bounces-36423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B183A08E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A195B29F62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810F17567;
	Wed, 24 Jan 2024 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PXkI2oux"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94CD514;
	Wed, 24 Jan 2024 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070331; cv=none; b=sCqAkWIcvldIkB6XY0pVfw4V184E3/ay3thGEFGREPEPwRYNP2+ICYHxir6k3oqEzLa0+lPh1txhck3bnlLWvI4YqFKEOfw9p5WYX+OeboZ6fQftNa+Dq/VgLU9nhpwRNW1jI/ITWmb3ctjUaXV/zZocrbjy4dWtcmEx3c8x32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070331; c=relaxed/simple;
	bh=cpwN3XiXaCX41NCkEGpr7RaCSMM8HTlY6C38ej5UOJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GELRHEJQ4x7tGzneH1j7I1PRR05p2CEO4cuDF9EkDitkb1bcVHwZiYGkfxXJ0rVSEuuCnFAji3kJR167hsh2gku4EyMlg6auZQcUwsLABgFPgVOSiZU1+QcZeyCFOchc7Oz8aB5+/qQIRf8dKl+M48Wdg0KCNOqJUfYWLUZXxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PXkI2oux; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O43bJQ005410;
	Wed, 24 Jan 2024 04:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=0j5pGIwLhtD91lN2lXVh5PkLfTuL6A7rRDx5ANvPmoo
	=; b=PXkI2ouxom7XSSUtUd6SwTyTIz5dtUjYfO87WmW+kmaUlcFGS15o4j5qALU
	1G46CR0MmJ/p3sZsEAgIbyFrCYpySJfez5v/4w6NO1vtBwm25zB7LMsxRtST5hau
	Dsvglx49YFebkCFerKMpXqthLkD82QtLuY1b6lrjSPnVOQlqyIKw3qvlAlEYVhJY
	2g6Kxme/pxrs1zVgIJ5hH4CQ9OUSpJekW9jnUkJd+EB029uSI8cQ/TdVJfrbobpr
	JzxtobD0X2pAYrJV0tq8Pz6rqA+eOa07LywM6mpqDF5xqSvHkeCeCdFI9UsWR10O
	BgZeh56hwtLg6FJCRepphYFufpg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmgwgr8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O4PIKg025235
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 04:25:18 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 20:25:17 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 23 Jan 2024 20:25:20 -0800
Subject: [PATCH v3 6/8] arm64: dts: qcom: sa8295p-adp: add max20411
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240123-sa8295p-gpu-v3-6-d5b4474c8f33@quicinc.com>
References: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
In-Reply-To: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706070315; l=1705;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=9G8OC71Bo5Qk4jp3jd+PoCQTayjd12YeJaxENqcceCg=;
 b=GJInQD+avu/NXm0xU5XUi6bCSoTs0yX4ds4Wa8gOz9sRj/RTk9vsQ9Z65jimgaL8nUkN0CZLJ
 Qg9XaItoBvwBG2VY+hlhnZSPZsp7neD97ufUe9JskKfZ5ZX7xGW5FwM
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tey7XA4f3ynTOIDyTt0qY68rfWfWK0_h
X-Proofpoint-ORIG-GUID: tey7XA4f3ynTOIDyTt0qY68rfWfWK0_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_01,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=963 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240029

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


