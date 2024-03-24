Return-Path: <linux-kernel+bounces-112987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8098688804A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A494C1C21241
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916C512D762;
	Sun, 24 Mar 2024 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkeZupro"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84E12D748;
	Sun, 24 Mar 2024 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319799; cv=none; b=TPgsFLQyz+/TPhAqA/dHys2ZazqGLDGX+8eyD0kkK2H2Y1P5/0djODUoQKWqOZCG/aPsFPS/rcmyq3T+HuzQD8AfqDJICxyoKasni5Jr/VLXoS3iP7gBUmrhKj6256a3wzNRyrLowdaCIt6jJUESkd8DcvALXsHwVm9mlFYR8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319799; c=relaxed/simple;
	bh=o8+OYAOS1Tf089+igt6V9qtzuWQuHbNGYmwkAGlL+cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zb+3WFXCu3ULtCPlMzmKhenieYFM9j5Lp0GMDmxdcStGNPbqjpuZWEDQwoF7SGjMTczr1cJyYTuWlBKsRyMfHJhiKEZHpc9v2TgmwwN/wR6dsmPfpPcLdU0kyPslDPr4yFiNPOP2rpaDqIUtMzKNAMIjhlOhZIIkXcrvFKYYIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkeZupro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3CCC433F1;
	Sun, 24 Mar 2024 22:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319799;
	bh=o8+OYAOS1Tf089+igt6V9qtzuWQuHbNGYmwkAGlL+cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkeZupropQs29JnBgcyenZIQle8ByF0I7b0de4rCYDpq/+IcEmmfZGRo76gC4f/ij
	 4rXxIYd8gm+HPzIgekL5Yx1VVY1OeP+Ctd+1mkDvSWmc515BbV2XGEogGGo1kl0UsB
	 koMikrS7WwTFZ5C/RUcAqi8SyrWHqVVKsp+VekI7tqkL9SzTmSfLx5sRBU0PYfHOeH
	 SGn9Os1yJs0T5sGqYjOP78XDY/FGKOKF7D5yzm4RG7mMRMDiK+qL18qyhk/cPkXe0Y
	 ecmyqTULGQ9TNlCYDyVOtw3Yap3XVARu/bFY2IDq2TUxQRIwhwfLx9B1DzwXW3EjPv
	 yBw+6awJEO54Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 100/715] arm64: dts: qcom: rename PM2250 to PM4125
Date: Sun, 24 Mar 2024 18:24:39 -0400
Message-ID: <20240324223455.1342824-101-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 39e62f41c3ce210554cc054f345d4135ef4e587b ]

It seems, the only actual mentions of PM2250 can be found are related to
the Qualcomm RB1 platform. However even RB1 schematics use PM4125 as a
PMIC name. Rename PM2250 to PM4125 to follow the documentation.

Note, this doesn't change the compatible strings. There was a previous
argument regarding renaming of compat strings.

Fixes: c309b9a54039 ("arm64: dts: qcom: Add initial PM2250 device tree")
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240128-pm2250-pm4125-rename-v2-2-d51987e9f83a@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/qcom/{pm2250.dtsi => pm4125.dtsi}     |  8 +-
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts      | 78 +++++++++----------
 2 files changed, 43 insertions(+), 43 deletions(-)
 rename arch/arm64/boot/dts/qcom/{pm2250.dtsi => pm4125.dtsi} (91%)

diff --git a/arch/arm64/boot/dts/qcom/pm2250.dtsi b/arch/arm64/boot/dts/qcom/pm4125.dtsi
similarity index 91%
rename from arch/arm64/boot/dts/qcom/pm2250.dtsi
rename to arch/arm64/boot/dts/qcom/pm4125.dtsi
index 5f1d15db5c993..d886a9e4b0918 100644
--- a/arch/arm64/boot/dts/qcom/pm2250.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm4125.dtsi
@@ -19,7 +19,7 @@ pon@800 {
 			compatible = "qcom,pm8916-pon";
 			reg = <0x800>;
 
-			pm2250_pwrkey: pwrkey {
+			pm4125_pwrkey: pwrkey {
 				compatible = "qcom,pm8941-pwrkey";
 				interrupts-extended = <&spmi_bus 0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
 				linux,code = <KEY_POWER>;
@@ -27,7 +27,7 @@ pm2250_pwrkey: pwrkey {
 				bias-pull-up;
 			};
 
-			pm2250_resin: resin {
+			pm4125_resin: resin {
 				compatible = "qcom,pm8941-resin";
 				interrupts-extended = <&spmi_bus 0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
 				debounce = <15625>;
@@ -43,11 +43,11 @@ rtc@6000 {
 			interrupts-extended = <&spmi_bus 0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
 		};
 
-		pm2250_gpios: gpio@c000 {
+		pm4125_gpios: gpio@c000 {
 			compatible = "qcom,pm2250-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
-			gpio-ranges = <&pm2250_gpios 0 0 10>;
+			gpio-ranges = <&pm4125_gpios 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index aa53b6af6d9cb..64b2ab2862793 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -7,7 +7,7 @@
 
 #include <dt-bindings/leds/common.h>
 #include "qcm2290.dtsi"
-#include "pm2250.dtsi"
+#include "pm4125.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. Robotics RB1";
@@ -226,7 +226,7 @@ &mdss {
 };
 
 &mdss_dsi0 {
-	vdda-supply = <&pm2250_l5>;
+	vdda-supply = <&pm4125_l5>;
 	status = "okay";
 };
 
@@ -239,7 +239,7 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
-&pm2250_resin {
+&pm4125_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";
 };
@@ -263,23 +263,23 @@ regulators {
 		compatible = "qcom,rpm-pm2250-regulators";
 		vdd_s3-supply = <&vph_pwr>;
 		vdd_s4-supply = <&vph_pwr>;
-		vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12-supply = <&pm2250_s3>;
+		vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12-supply = <&pm4125_s3>;
 		vdd_l4_l17_l18_l19_l20_l21_l22-supply = <&vph_pwr>;
-		vdd_l13_l14_l15_l16-supply = <&pm2250_s4>;
+		vdd_l13_l14_l15_l16-supply = <&pm4125_s4>;
 
 		/*
 		 * S1 - VDD_APC
 		 * S2 - VDD_CX
 		 */
 
-		pm2250_s3: s3 {
+		pm4125_s3: s3 {
 			/* 0.4V-1.6625V -> 1.3V (Power tree requirements) */
 			regulator-min-microvolt = <1352000>;
 			regulator-max-microvolt = <1352000>;
 			regulator-boot-on;
 		};
 
-		pm2250_s4: s4 {
+		pm4125_s4: s4 {
 			/* 1.2V-2.35V -> 2.05V (Power tree requirements) */
 			regulator-min-microvolt = <2072000>;
 			regulator-max-microvolt = <2072000>;
@@ -288,7 +288,7 @@ pm2250_s4: s4 {
 
 		/* L1 - VDD_MX */
 
-		pm2250_l2: l2 {
+		pm4125_l2: l2 {
 			/* LPDDR4X VDD2 */
 			regulator-min-microvolt = <1136000>;
 			regulator-max-microvolt = <1136000>;
@@ -296,7 +296,7 @@ pm2250_l2: l2 {
 			regulator-boot-on;
 		};
 
-		pm2250_l3: l3 {
+		pm4125_l3: l3 {
 			/* LPDDR4X VDDQ */
 			regulator-min-microvolt = <616000>;
 			regulator-max-microvolt = <616000>;
@@ -304,14 +304,14 @@ pm2250_l3: l3 {
 			regulator-boot-on;
 		};
 
-		pm2250_l4: l4 {
+		pm4125_l4: l4 {
 			/* max = 3.05V -> max = 2.7 to disable 3V signaling (SDHCI2) */
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <2700000>;
 			regulator-allow-set-load;
 		};
 
-		pm2250_l5: l5 {
+		pm4125_l5: l5 {
 			/* CSI/DSI */
 			regulator-min-microvolt = <1232000>;
 			regulator-max-microvolt = <1232000>;
@@ -319,7 +319,7 @@ pm2250_l5: l5 {
 			regulator-boot-on;
 		};
 
-		pm2250_l6: l6 {
+		pm4125_l6: l6 {
 			/* DRAM PLL */
 			regulator-min-microvolt = <928000>;
 			regulator-max-microvolt = <928000>;
@@ -327,7 +327,7 @@ pm2250_l6: l6 {
 			regulator-boot-on;
 		};
 
-		pm2250_l7: l7 {
+		pm4125_l7: l7 {
 			/* Wi-Fi CX/MX */
 			regulator-min-microvolt = <664000>;
 			regulator-max-microvolt = <664000>;
@@ -338,20 +338,20 @@ pm2250_l7: l7 {
 		 * L9 - VDD_LPI_MX
 		 */
 
-		pm2250_l10: l10 {
+		pm4125_l10: l10 {
 			/* Wi-Fi RFA */
 			regulator-min-microvolt = <1304000>;
 			regulator-max-microvolt = <1304000>;
 		};
 
-		pm2250_l11: l11 {
+		pm4125_l11: l11 {
 			/* GPS RF1 */
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
 			regulator-boot-on;
 		};
 
-		pm2250_l12: l12 {
+		pm4125_l12: l12 {
 			/* USB PHYs */
 			regulator-min-microvolt = <928000>;
 			regulator-max-microvolt = <928000>;
@@ -359,7 +359,7 @@ pm2250_l12: l12 {
 			regulator-boot-on;
 		};
 
-		pm2250_l13: l13 {
+		pm4125_l13: l13 {
 			/* USB/QFPROM/PLLs */
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
@@ -367,7 +367,7 @@ pm2250_l13: l13 {
 			regulator-boot-on;
 		};
 
-		pm2250_l14: l14 {
+		pm4125_l14: l14 {
 			/* SDHCI1 VQMMC */
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
@@ -376,7 +376,7 @@ pm2250_l14: l14 {
 			regulator-always-on;
 		};
 
-		pm2250_l15: l15 {
+		pm4125_l15: l15 {
 			/* WCD/DSI/BT VDDIO */
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
@@ -385,38 +385,38 @@ pm2250_l15: l15 {
 			regulator-boot-on;
 		};
 
-		pm2250_l16: l16 {
+		pm4125_l16: l16 {
 			/* GPS RF2 */
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-boot-on;
 		};
 
-		pm2250_l17: l17 {
+		pm4125_l17: l17 {
 			regulator-min-microvolt = <3000000>;
 			regulator-max-microvolt = <3000000>;
 		};
 
-		pm2250_l18: l18 {
+		pm4125_l18: l18 {
 			/* VDD_PXn */
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
 
-		pm2250_l19: l19 {
+		pm4125_l19: l19 {
 			/* VDD_PXn */
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 		};
 
-		pm2250_l20: l20 {
+		pm4125_l20: l20 {
 			/* SDHCI1 VMMC */
 			regulator-min-microvolt = <2400000>;
 			regulator-max-microvolt = <3600000>;
 			regulator-allow-set-load;
 		};
 
-		pm2250_l21: l21 {
+		pm4125_l21: l21 {
 			/* SDHCI2 VMMC */
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <3300000>;
@@ -424,7 +424,7 @@ pm2250_l21: l21 {
 			regulator-boot-on;
 		};
 
-		pm2250_l22: l22 {
+		pm4125_l22: l22 {
 			/* Wi-Fi */
 			regulator-min-microvolt = <3312000>;
 			regulator-max-microvolt = <3312000>;
@@ -433,8 +433,8 @@ pm2250_l22: l22 {
 };
 
 &sdhc_1 {
-	vmmc-supply = <&pm2250_l20>;
-	vqmmc-supply = <&pm2250_l14>;
+	vmmc-supply = <&pm4125_l20>;
+	vqmmc-supply = <&pm4125_l14>;
 	pinctrl-0 = <&sdc1_state_on>;
 	pinctrl-1 = <&sdc1_state_off>;
 	pinctrl-names = "default", "sleep";
@@ -446,8 +446,8 @@ &sdhc_1 {
 };
 
 &sdhc_2 {
-	vmmc-supply = <&pm2250_l21>;
-	vqmmc-supply = <&pm2250_l4>;
+	vmmc-supply = <&pm4125_l21>;
+	vqmmc-supply = <&pm4125_l4>;
 	cd-gpios = <&tlmm 88 GPIO_ACTIVE_LOW>;
 	pinctrl-0 = <&sdc2_state_on &sd_det_in_on>;
 	pinctrl-1 = <&sdc2_state_off &sd_det_in_off>;
@@ -518,8 +518,8 @@ &usb {
 };
 
 &usb_qmpphy {
-	vdda-phy-supply = <&pm2250_l12>;
-	vdda-pll-supply = <&pm2250_l13>;
+	vdda-phy-supply = <&pm4125_l12>;
+	vdda-pll-supply = <&pm4125_l13>;
 	status = "okay";
 };
 
@@ -528,17 +528,17 @@ &usb_dwc3 {
 };
 
 &usb_hsphy {
-	vdd-supply = <&pm2250_l12>;
-	vdda-pll-supply = <&pm2250_l13>;
-	vdda-phy-dpdm-supply = <&pm2250_l21>;
+	vdd-supply = <&pm4125_l12>;
+	vdda-pll-supply = <&pm4125_l13>;
+	vdda-phy-dpdm-supply = <&pm4125_l21>;
 	status = "okay";
 };
 
 &wifi {
-	vdd-0.8-cx-mx-supply = <&pm2250_l7>;
-	vdd-1.8-xo-supply = <&pm2250_l13>;
-	vdd-1.3-rfa-supply = <&pm2250_l10>;
-	vdd-3.3-ch0-supply = <&pm2250_l22>;
+	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
+	vdd-1.8-xo-supply = <&pm4125_l13>;
+	vdd-1.3-rfa-supply = <&pm4125_l10>;
+	vdd-3.3-ch0-supply = <&pm4125_l22>;
 	qcom,ath10k-calibration-variant = "Thundercomm_RB1";
 	status = "okay";
 };
-- 
2.43.0


