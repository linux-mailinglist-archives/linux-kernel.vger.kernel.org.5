Return-Path: <linux-kernel+bounces-63374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D66F852E59
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4577A2847FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F366C364CF;
	Tue, 13 Feb 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QP6jlXZ2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE5168AC;
	Tue, 13 Feb 2024 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821310; cv=none; b=FEWuYK3sePa5i+5gOe5oqs9mKkDHL4e7GZGiUE4PKuxLJ8GEXhQrDzp3KfUs9lSMbgdYafBmcjv7Gw/l+6eqHRuIUyJGD952U+I88M6VVwlFIywSdDU7hhVnkNLhKIBglLNO7P4yQBDSX9sWgLhI5Os99s3wy4DjjUN3yzFJTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821310; c=relaxed/simple;
	bh=1Wz6Vq9ipmxV3B1zmAiMO5cISSM7jOm3HEHm4AzEAlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e1DrBEELwH+3PUpEUHW24fPV93lReodiUr8lLtLkTDbRjwN/Z6PL2f5AjtvFysw8Sq8NG8jygonVRtAyulUH7kv/jhcXz1oS9zSGoLqgHKAcyf5y8vnB+t/WE+eapESN+1Q2RbQkMBHSUAe+/qtUM7NmMIWi3+WFAyMMdd+R4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QP6jlXZ2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D9PUrH017717;
	Tue, 13 Feb 2024 10:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=YBpvfgQxESVcOkvfp4PTvuoK/aWY6cpvu/EBt9W/HUo=; b=QP
	6jlXZ23jvxny8CwL/boYvdAunlpQxup+WEiUi0hI5z0pGSOv5uS874SQ+tGPpTjj
	rTfP2mEM+YlhGq3cus0sQgjrSCeDlPKeBJoVTRt809FfRocm4a5x7ctEbFP66BI/
	uhn+8BKIQuem36yi9VPG99/3Db7xI/Cul6r/U7QfdjtoXMYInwuklbLEVSn/fdJV
	/Dc0AiwPNlkB7QPqS8N6BjlC1Mq//rgHCFmBEnvGxLT6aQv5hG3cwM/efzFjzPOf
	6MiCkz3tqKAOifEN0tRw/+B656S10ZPZPjF39HO6Gg14WIBwom5dVAgXDe4WXA1p
	GDY0Iz+SHxV8fs2sXZFA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ju7afp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:48:04 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41DAlxqf032074;
	Tue, 13 Feb 2024 10:47:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3w627kvyne-1;
	Tue, 13 Feb 2024 10:47:59 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DAlxfM032058;
	Tue, 13 Feb 2024 10:47:59 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41DAlwh4032052;
	Tue, 13 Feb 2024 10:47:59 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id B3316617D90; Tue, 13 Feb 2024 16:17:57 +0530 (+0530)
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
Subject: [PATCH v2 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
Date: Tue, 13 Feb 2024 16:17:54 +0530
Message-Id: <20240213104754.8195-3-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240213104754.8195-1-quic_riteshk@quicinc.com>
References: <20240213104754.8195-1-quic_riteshk@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fH_50kQHOqPtlDLrNWZ7CXjfDirkt2V1
X-Proofpoint-GUID: fH_50kQHOqPtlDLrNWZ7CXjfDirkt2V1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130085
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Enable Display Subsystem with Novatek NT36672E Panel
on qcm6490 idp platform.

Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>

---
v2: Fixed review comments from Dmitry and Konrad
      - moved pinctrl-names after pinctrl-0 property.
      - removed gpu disablement change after validating gpu.
    Rebased the patch
      - rebased the patch to resolve conflicts.
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 92 ++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 502a5a383bde..0054b2a8d6c7 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -10,6 +10,7 @@
 #define PM7250B_SID1 9
 
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
 #include "pm7250b.dtsi"
@@ -39,6 +40,25 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	lcd_disp_bias: lcd-disp-bias-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_disp_bias";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+		gpio = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-0 = <&lcd_disp_bias_en>;
+		pinctrl-names = "default";
+	};
+
+	pm8350c_pwm_backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pm8350c_pwm 3 65535>;
+		enable-gpios = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pmic_lcd_bl_en>;
+		pinctrl-names = "default";
+	};
+
 	reserved-memory {
 		xbl_mem: xbl@80700000 {
 			reg = <0x0 0x80700000 0x0 0x100000>;
@@ -421,7 +441,79 @@
 	};
 };
 
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
 &pm8350c_pwm {
+	pinctrl-0 = <&pmic_lcd_bl_pwm>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	multi-led {
-- 
2.17.1


