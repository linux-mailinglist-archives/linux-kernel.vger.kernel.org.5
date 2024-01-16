Return-Path: <linux-kernel+bounces-27204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486C082EC27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C7CB23807
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013B513AD2;
	Tue, 16 Jan 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IzVl8V+8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04170125BC;
	Tue, 16 Jan 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G7xBZW006658;
	Tue, 16 Jan 2024 09:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=wQAX+VhAFdlMCGP8X0aXUlSO5dSynGBqLOMB5EIi+c0=; b=Iz
	Vl8V+8rellap5+ZCBBWVu4RT5fxmQ5cybHN0TztDyoyQi7Q6yk+U/IOhSOQc4Uf3
	5BEDzGGkfJRWz9AN3XTa5Li7JbyVYD+eEJlMY3H/02uW9vi08yDKY3WUUQJTV5N6
	rI/HPqwDgl07dpr/bwlbrM2yOfZ8VGy8FM7l8Ks/FA0I4ICkpXAoJjlJplxSgIiW
	s4CGLVn0u7cUUHXXuvlDbiq2evMa5xPOinbSEAb7RpY4lHtEjmyAcamKLTTZmDg0
	5QpXoIRY6sQCekkOfZt3SRp1db0UJlRotHuZn1muDLWdsKXBbGBtSsoW2EJjg1+a
	A6q7vqea6N35wuZG/BGg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnnvbg6wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 09:49:45 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40G9nfs0006270;
	Tue, 16 Jan 2024 09:49:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3vkkkkmgev-1;
	Tue, 16 Jan 2024 09:49:41 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40G9nfIj006250;
	Tue, 16 Jan 2024 09:49:41 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 40G9neYq006247;
	Tue, 16 Jan 2024 09:49:41 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id A6ADB601957; Tue, 16 Jan 2024 15:19:39 +0530 (+0530)
From: Ritesh Kumar <quic_riteshk@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com,
        geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com
Cc: Ritesh Kumar <quic_riteshk@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_abhinavk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com
Subject: [PATCH 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
Date: Tue, 16 Jan 2024 15:19:35 +0530
Message-Id: <20240116094935.9988-3-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116094935.9988-1-quic_riteshk@quicinc.com>
References: <20240116094935.9988-1-quic_riteshk@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SEevayCsF1JDhR8GJCr30yUJJZMM-uWv
X-Proofpoint-ORIG-GUID: SEevayCsF1JDhR8GJCr30yUJJZMM-uWv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160077
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Enable Display Subsystem with Novatek NT36672E Panel
on qcm6490 idp platform.

Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 100 +++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 2a6e4907c5ee..efa5252130a1 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -9,6 +9,7 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
 #include "pm7250b.dtsi"
@@ -38,6 +39,25 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	lcd_disp_bias: lcd-disp-bias-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_disp_bias";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+		gpio = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_disp_bias_en>;
+	};
+
+	pm8350c_pwm_backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pm8350c_pwm 3 65535>;
+		enable-gpios = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_lcd_bl_en>;
+	};
+
 	reserved-memory {
 		xbl_mem: xbl@80700000 {
 			reg = <0x0 0x80700000 0x0 0x100000>;
@@ -420,6 +440,86 @@
 	};
 };
 
+&gpu {
+	status = "disabled";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi {
+	vdda-supply = <&vreg_l6b_1p2>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "novatek,nt36672e";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 44 GPIO_ACTIVE_HIGH>;
+
+		vddi-supply = <&vreg_l8c_1p62>;
+		avdd-supply = <&lcd_disp_bias>;
+		avee-supply = <&lcd_disp_bias>;
+
+		backlight = <&pm8350c_pwm_backlight>;
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi_phy {
+	vdds-supply = <&vreg_l10c_0p88>;
+	status = "okay";
+};
+
+&pm7250b_gpios {
+	lcd_disp_bias_en: lcd-disp-bias-en-state {
+		pins = "gpio2";
+		function = "func1";
+		bias-disable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		input-disable;
+		output-enable;
+		power-source = <0>;
+	};
+};
+
+&pm8350c_gpios {
+	pmic_lcd_bl_en: pmic-lcd-bl-en-state {
+		pins = "gpio7";
+		function = "normal";
+		bias-disable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		output-low;
+		power-source = <0>;
+	};
+
+	pmic_lcd_bl_pwm: pmic-lcd-bl-pwm-state {
+		pins = "gpio8";
+		function = "func1";
+		bias-disable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		output-low;
+		power-source = <0>;
+	};
+};
+
+&pm8350c_pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmic_lcd_bl_pwm>;
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.17.1


