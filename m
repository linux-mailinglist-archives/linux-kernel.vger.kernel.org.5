Return-Path: <linux-kernel+bounces-66685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85195856032
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105341F27258
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66431136641;
	Thu, 15 Feb 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UzvQjEur"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B78131740;
	Thu, 15 Feb 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993599; cv=none; b=oWQpeAo+jXXUyDWv8XCENA15B1QOvhSna9v/nk9Lhsqz+go5aKRNty60zbsHHOw9ceIR5wEynLWN2sLCq0uVe3DQTUXPZeVuX/biD4XPkOW3Bc93Vgl+Hk9aUIYEfuyWDShvuYLuEgmll1NJNb4C6EElFig6WBr9yWzRf5APKZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993599; c=relaxed/simple;
	bh=PWvpQJPxH3xmC8dQKZixZdp+i+vn1PGn7VfkDpTt55g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=vA3VBMFLvadwYFx0Z4rZEB5U/XothujyO4XDmFbK1fuhBb8KIRTZpCnTtYO/iuOJNDN+qoQQxaQo/VgNbWpPkSiSKAaY3YEec68KMEcrejzoxRhwM77FmcJa32Nh50Qb5HEDp+Hx1lC0DhOrEXR+fWm3093lbs5uZVGBQwfgssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UzvQjEur; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FAM7sw031367;
	Thu, 15 Feb 2024 10:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=nqQ2C714mkmBgSBS/ZClViH3gWgHWlEzu2KUBDeXZfY=; b=Uz
	vQjEurdou77XyMh5cZhpcJfaVac/WwF9bvxlqGV5QZBFMTZGScRU4w0q2VgGEcYH
	9lctyJoEH7yFyO+7YsUG9kfxBdTXJ+g2JKRETqhr3WGJgL73w7zJC8I6rmr3jqM+
	saonZsKJjt5oBssfxRLajkmtSLa0xPEoqAsdsF+dT1NsIppGBVp/ZDT2fE++RGa3
	RWL1+c0YbTjUwzQAhp/SJXbHrD4baiA4NtSSkmKjkYP9EjeEYaq/bQ9UoK11yRLl
	TxihFe0d5IGHR3JR7oQyxFVMrzc12SqVqUnjJRHyxLW8LwVm88oteNT7auRcGepz
	0rhG6eoKnM7XU+rN+0Og==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9342hjmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:39:38 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41FAdXBx013846;
	Thu, 15 Feb 2024 10:39:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3w627mab7e-1;
	Thu, 15 Feb 2024 10:39:33 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FAdXkM013834;
	Thu, 15 Feb 2024 10:39:33 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41FAdXTT013826;
	Thu, 15 Feb 2024 10:39:33 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id E0D5E601431; Thu, 15 Feb 2024 16:09:31 +0530 (+0530)
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
Subject: [PATCH v3 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
Date: Thu, 15 Feb 2024 16:09:29 +0530
Message-Id: <20240215103929.19357-3-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240215103929.19357-1-quic_riteshk@quicinc.com>
References: <20240215103929.19357-1-quic_riteshk@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SKuUTy1KAZjSvVts8D14l_l3ZTjT8FpH
X-Proofpoint-GUID: SKuUTy1KAZjSvVts8D14l_l3ZTjT8FpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150084
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
v3: Fixed review comments from Dmitry
      - renamed panel supply to regulator-lcd-disp-bias.
      - moved backlight as per sort order.
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 92 ++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 502a5a383bde..6d6506726827 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -10,6 +10,7 @@
 #define PM7250B_SID1 9
 
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
 #include "pm7250b.dtsi"
@@ -35,10 +36,29 @@
 		serial0 = &uart5;
 	};
 
+	pm8350c_pwm_backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pm8350c_pwm 3 65535>;
+		enable-gpios = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pmic_lcd_bl_en>;
+		pinctrl-names = "default";
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	lcd_disp_bias: regulator-lcd-disp-bias {
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


