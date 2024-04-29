Return-Path: <linux-kernel+bounces-162675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC7F8B5ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65BE283EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA8D85636;
	Mon, 29 Apr 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="leRQ8974"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4D85276;
	Mon, 29 Apr 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407677; cv=none; b=mZT0ANPuANehTe1NigZ6Hao4gCjwNgm+xfS3L4p9HaX0IRR5Q9cJ9A78YBRddkPIf16uIi3u2nesZKgMyT68R+rECeHI8pdpVEmrPyn2FZhKgOPoPfZOl68Q0N7U1FH5poeOf0dd1KqgHw4Cfnqqb3Z4cBPY5eRT2PVr2oShDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407677; c=relaxed/simple;
	bh=S2+bljg/dN7FhKaPrRty3Sohv23EJUQGTSo2VYUFTjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuqbM/jbykklBvysNb0fD0lBkRToFyrSprJN58MpybuPTy2w1owmR+UlyMd5EsVwJWXj4Fu0n4jgZwS5teUUxXOrKi9oN5w0/T/nC670jn7dLh9vd8rkC5HW7vQRnOwvkNvZpbR64MtZNvhowTv89oDA4hicPRYB1C2p1Lh/yf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=leRQ8974; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T3e2tV002891;
	Mon, 29 Apr 2024 16:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jiMqpuAPIf5aVzRqr3dNx9UMTe5KUkaKinjBz4oAC1Y=; b=le
	RQ8974PEWywFtoot+YOAwZA4C4ylAcp1Sv29FiQd+jPGCpkdZSa6CnnN+ln0Qk1O
	OaQp9Gcsg7G6DU9U9Y7gRhgXnPvmh8EKKThaKGvWpysHGIjdx3LQh/HwrKyG4Xpo
	E+TY+neFgf8XDrXvsRiXDtKk2/nuC6ij9t8j7LW4lGY4sTAk4ItXZ8ttj9oy2/xq
	MFiY7K8NQkLO5sM9qV9eDTfxci9KqAcyOArwnaHLWrJXuAKyyCzHKuWjMpPN/GsA
	G4qzXhDmeutpl7Z9AN9jkfkYUrGEDHCRTU2fpcOqTjmAvxCsM3q5PEsAvtn9mQLf
	A3bUf1OSSEUdnLM+e0hQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrravndt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:21:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TGLBBP021312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:21:11 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 09:21:06 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Johan Hovold
	<johan@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v16 2/2] arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB ports
Date: Mon, 29 Apr 2024 21:50:48 +0530
Message-ID: <20240429162048.2133512-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429162048.2133512-1-quic_kriskura@quicinc.com>
References: <20240429162048.2133512-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3xUui24Bp0Gwyfz6y-u86qfDfwieELqU
X-Proofpoint-ORIG-GUID: 3xUui24Bp0Gwyfz6y-u86qfDfwieELqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=769 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290104

Multiport USB controller (host-only) of SA8295 ADP has 4 Type-A ports
exposed for connecting peripherals. The VBUS to these peripherals is
provided by TPS2559QWDRCTQ1 regulators connected to these ports. Each
regulator has an enable pin controlled by PMM8540. Since these regulators
are GPIO controlled regulators, model them as fixed regulators and keep
them Always-On at boot since we are wakeup capable and we don't need to
turn them off on suspend. Also since we don't enter device mode, these
regulators can be kept on.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 83 ++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 78e933c42c31..2fd1dafe63ce 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 #include "sa8540p.dtsi"
 #include "sa8540p-pmics.dtsi"
@@ -109,6 +110,46 @@ edp3_connector_in: endpoint {
 		};
 	};
 
+	regulator-usb2-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "USB2_VBUS";
+		gpio = <&pmm8540c_gpios 9 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb2_en>;
+		pinctrl-names = "default";
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	regulator-usb3-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "USB3_VBUS";
+		gpio = <&pmm8540e_gpios 5 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb3_en>;
+		pinctrl-names = "default";
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	regulator-usb4-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "USB4_VBUS";
+		gpio = <&pmm8540g_gpios 5 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb4_en>;
+		pinctrl-names = "default";
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	regulator-usb5-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "USB5_VBUS";
+		gpio = <&pmm8540g_gpios 9 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb5_en>;
+		pinctrl-names = "default";
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	reserved-memory {
 		gpu_mem: gpu-mem@8bf00000 {
 			reg = <0 0x8bf00000 0 0x2000>;
@@ -637,6 +678,10 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&usb_2 {
+	status = "okay";
+};
+
 &usb_2_hsphy0 {
 	vdda-pll-supply = <&vreg_l5a>;
 	vdda18-supply = <&vreg_l7g>;
@@ -697,6 +742,44 @@ max20411_en: max20411-en-state {
 	};
 };
 
+&pmm8540c_gpios {
+	usb2_en: usb2-en-state {
+		pins = "gpio9";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+		output-enable;
+		power-source = <0>;
+	};
+};
+
+&pmm8540e_gpios {
+	usb3_en: usb3-en-state {
+		pins = "gpio5";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+		output-enable;
+		power-source = <0>;
+	};
+};
+
+&pmm8540g_gpios {
+	usb4_en: usb4-en-state {
+		pins = "gpio5";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+		output-enable;
+		power-source = <0>;
+	};
+
+	usb5_en: usb5-en-state {
+		pins = "gpio9";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+		output-enable;
+		power-source = <0>;
+	};
+};
+
 &tlmm {
 	pcie2a_default: pcie2a-default-state {
 		clkreq-n-pins {
-- 
2.34.1


