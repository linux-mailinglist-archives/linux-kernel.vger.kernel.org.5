Return-Path: <linux-kernel+bounces-63118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB54852B26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5741F234D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7B0224D5;
	Tue, 13 Feb 2024 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ekIk+xBU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBEF21364;
	Tue, 13 Feb 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812872; cv=none; b=WIWLWIYqlSCgifdTC+M1TxD/aKgrdGUsgyJ/03BEOcnmanmMGZqSzvdMd6Ri4oj+0vF8vxyRVydtH5CwBXuAbPA5fOGgePbuKfFDiwznXVhKeZpoAgkibBSspEgGyCaY9NEpTkrNp6vDWSNMb1G8O+O8CHuaXqtpjGtbE2+Z/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812872; c=relaxed/simple;
	bh=q/hQM3vLKQ0kH5wHz/078deb+2M0ui5GWzSIObPddmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baeS95pObkKGvrAlBeMh8afWxl/WjquUnL5SxTmjGSYCG+uruZUiW1uAmw8weC9gshEBj09mxKgHQwxdlfXd7HqhzaiIVIKP8Sn6qktG5VykytuI2nFUffwYLTNPOsLsjSqkTkHIekttqAXU+BBXOoYRiuRqMZgATmxEuSCGy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ekIk+xBU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D7WNgl021522;
	Tue, 13 Feb 2024 08:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ebEnLGtxdvQ9BU1aamNWVJHMtfALLgzEIZ/kTA0keJM=; b=ek
	Ik+xBU1YEUM0khvudIKU/uWlQVvJEgkAqUQY9iIBiJF2bFd7WJiexzV3sx3Opvtt
	KOuvZxPoPiclwV8GO4mHKgwwqWMfjaWmcgIpWC2rj9B60HRLeDzOVhBadS+G4zB/
	Da/PjtymnpVZl2TRjiNA/ohth34s/mlEx4b5qzZ/a4wyJlSmMNgrZ4nIP0OQJJ3P
	WtGMGV/TfAXo0hDD00ldxnmF+a7eOXYYQpWmxOVKaz2uZd7eJxEntuEFn9aRDw93
	bPkOYjd8aPFsB2pbI07XcBXGPjOE3eiJZIy5LcamRCqfARf9NGTacW4576AnmGc6
	3v24FGl7Q+Mmd6qfKZQg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8448r2wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:27:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D8RkXR031258
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:27:46 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 00:27:42 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB ports
Date: Tue, 13 Feb 2024 13:57:24 +0530
Message-ID: <20240213082724.1789096-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213082724.1789096-1-quic_kriskura@quicinc.com>
References: <20240213082724.1789096-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5YjYtrDPVf7EICzgwMu8AI4kZe-4iSet
X-Proofpoint-GUID: 5YjYtrDPVf7EICzgwMu8AI4kZe-4iSet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=622
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402130065

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
index fd253942e5e5..49418843c214 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 #include "sa8540p.dtsi"
 #include "sa8540p-pmics.dtsi"
@@ -108,6 +109,46 @@ edp3_connector_in: endpoint {
 			};
 		};
 	};
+
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
 };
 
 &apps_rsc {
@@ -584,6 +625,10 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
+&usb_2 {
+	status = "okay";
+};
+
 &usb_2_hsphy0 {
 	vdda-pll-supply = <&vreg_l5a>;
 	vdda18-supply = <&vreg_l7g>;
@@ -636,6 +681,44 @@ &xo_board_clk {
 
 /* PINCTRL */
 
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


