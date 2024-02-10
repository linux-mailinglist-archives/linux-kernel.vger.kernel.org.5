Return-Path: <linux-kernel+bounces-60457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B33850532
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50161C2224A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3505CDCC;
	Sat, 10 Feb 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Zu9gx05P"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80836AFB;
	Sat, 10 Feb 2024 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582598; cv=none; b=E10pDihHm116anNt7K2J7qCXU4QfQuT6JyF2NKth4gokOo6x6Ehlral7XqTkI7hSkDpGT4Da1QLPnRIb9TNpTtz/z3Yf6SnYMYkKWoduNvAuBtuBt/16faQFbPY1f/Y01PDnlP6rztECLu6rPBPOI57DDoBu3c/RXJ0q7R0MdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582598; c=relaxed/simple;
	bh=TPvoF5bnQ58TbHs+9fkmDdCXcoMqMd35IEyCI3+bzJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DTQqRaBVuQZ3tQvGQ+koDYMsOTWGVJahuBFdTqZFBCe5M61lMXHEZUH0Xr2wsMGgVAI7FxilgG8ksu3qFaDJxUmanm0EFiISjRd+DNkYkG4IaWHjHZjP0B6Al0E+EfHo96jbXAl190YmDyic4d0wCbmiE2UgE5dGClJQ1B8EO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=Zu9gx05P; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707582594; bh=TPvoF5bnQ58TbHs+9fkmDdCXcoMqMd35IEyCI3+bzJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zu9gx05Pcgg/LU4G4MaRj06R7YnR5X6ZFKRqyHnQGbvyc1JLhk5v7F0f5+st9n2FT
	 P5lTcwjtVYmi724tjL2MNcFiXTU9d77SdBxQZvHi8tj4TFpbnr9vt7h6jvmOphx9nE
	 okVfvmmJnzeCSQMJBG5KCP2/IWvst3+6TXpykfu0=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 10 Feb 2024 17:28:53 +0100
Subject: [PATCH v2 2/3] ARM: dts: qcom: msm8226: Sort and clean up nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240210-msm8226-cpu-v2-2-5d9cb4c35204@z3ntu.xyz>
References: <20240210-msm8226-cpu-v2-0-5d9cb4c35204@z3ntu.xyz>
In-Reply-To: <20240210-msm8226-cpu-v2-0-5d9cb4c35204@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>, 
 =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=21372; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=YW/ZUY4zJmIBMcdiJkTe7f8WTCgEoJcDfdppu2LHzGE=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx6R/Rfhkt67tOEgaoSHFL3lrGnsXJS87UX+PX
 Cy7EYjEspuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZcekfwAKCRBy2EO4nU3X
 VlZ8D/9P15Y2kNu/3BQ5a6NCBhNbxEfg9NxyBY3UamxC5OpAwCRxQ9ZNWSpX4p0clvbDXa8ppNA
 piEd1eG+bdb+SZMaOXTqQfjssyJvAldCkphyZ+YEqXYsqvSQRb3CHnBCT2x/+iRqIAzfw7Bw+f8
 a87FK3kCngJFye27aFlrEeOhAUZyx/HBU7PCaLQLb7pf3LsVeb+hpZseFc+8qumgdD7Ip1LxxWA
 nwNhgd2ygtyyzL4llygp5ZMuMzpQmtw89NhIxt2N4KYbY7VoMdZHG6GOpmA5BbsaLNF4q6RCSij
 6gLetrXtm+/VEVAftt3+rrvqgXXBWTpk3/bDyEZzNDuetnIKOazqwrsbIGqM7ksCIsOd1nsKTg/
 7PvNbhL6prOGG9YSkONnZ+47r4IYl2l4HGCahSizedsFOBxwmAFPx1YaBUFswHcOJ+8aeXDpBM+
 HjItQ4WIw+Ti75orVUa/yieykB85SqAPaX41Trw5MZjraUr6WAOfY3qtxjOlZKHQNCN2uS+Y9h2
 7HMAb4fu9mJCwdgjlcCwIpWJ++tNOcjM4IJ/53Co6W0ujtghm5zTdB0uhQAs+kufK3i1288e+Gt
 5LodHMb0w5vGpx84GvuR6ZNU4ewCAyQZDLZ4N/CaZRQd+kWggAWwvy3FBnFzUwm15qOYeiZ5Zgp
 8hy+pW8OkXE13og==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Matti Lehtimäki <matti.lehtimaki@gmail.com>

Quite a few nodes haven't been sorted correctly by reg, so let's do this
now so that future nodes can be added at the correct place.

Also at the same time, move the status property last.

No functional change intended.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
[luca: add more text to commit message]
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 660 +++++++++++++++----------------
 1 file changed, 330 insertions(+), 330 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index b492c95e5d30..6896318e6612 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -20,11 +20,6 @@ / {
 
 	chosen { };
 
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x0>;
-	};
-
 	clocks {
 		xo_board: xo_board {
 			compatible = "fixed-clock";
@@ -47,6 +42,11 @@ scm {
 		};
 	};
 
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
 	pmu {
 		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) |
@@ -185,6 +185,64 @@ apcs: syscon@f9011000 {
 			reg = <0xf9011000 0x1000>;
 		};
 
+		timer@f9020000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0xf9020000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			frame@f9021000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf9021000 0x1000>,
+				      <0xf9022000 0x1000>;
+			};
+
+			frame@f9023000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf9023000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@f9024000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf9024000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@f9025000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf9025000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@f9026000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf9026000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@f9027000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf9027000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@f9028000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf9028000 0x1000>;
+				status = "disabled";
+			};
+		};
+
 		sdhc_1: mmc@f9824900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
@@ -201,22 +259,6 @@ sdhc_1: mmc@f9824900 {
 			status = "disabled";
 		};
 
-		sdhc_2: mmc@f98a4900 {
-			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
-			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
-			reg-names = "hc", "core";
-			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
-				 <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
-			clock-names = "iface", "core", "xo";
-			pinctrl-names = "default";
-			pinctrl-0 = <&sdhc2_default_state>;
-			status = "disabled";
-		};
-
 		sdhc_3: mmc@f9864900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
@@ -233,6 +275,22 @@ sdhc_3: mmc@f9864900 {
 			status = "disabled";
 		};
 
+		sdhc_2: mmc@f98a4900 {
+			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
+			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
+			reg-names = "hc", "core";
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface", "core", "xo";
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdhc2_default_state>;
+			status = "disabled";
+		};
+
 		blsp1_uart1: serial@f991d000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991d000 0x1000>;
@@ -272,7 +330,6 @@ blsp1_uart4: serial@f9920000 {
 		};
 
 		blsp1_i2c1: i2c@f9923000 {
-			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9923000 0x1000>;
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
@@ -282,10 +339,10 @@ blsp1_i2c1: i2c@f9923000 {
 			pinctrl-0 = <&blsp1_i2c1_pins>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		blsp1_i2c2: i2c@f9924000 {
-			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9924000 0x1000>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
@@ -295,10 +352,10 @@ blsp1_i2c2: i2c@f9924000 {
 			pinctrl-0 = <&blsp1_i2c2_pins>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		blsp1_i2c3: i2c@f9925000 {
-			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9925000 0x1000>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
@@ -308,10 +365,10 @@ blsp1_i2c3: i2c@f9925000 {
 			pinctrl-0 = <&blsp1_i2c3_pins>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		blsp1_i2c4: i2c@f9926000 {
-			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9926000 0x1000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -321,10 +378,10 @@ blsp1_i2c4: i2c@f9926000 {
 			pinctrl-0 = <&blsp1_i2c4_pins>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		blsp1_i2c5: i2c@f9927000 {
-			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9927000 0x1000>;
 			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
@@ -334,6 +391,7 @@ blsp1_i2c5: i2c@f9927000 {
 			pinctrl-0 = <&blsp1_i2c5_pins>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		blsp1_i2c6: i2c@f9928000 {
@@ -351,33 +409,6 @@ blsp1_i2c6: i2c@f9928000 {
 			status = "disabled";
 		};
 
-		cci: cci@fda0c000 {
-			compatible = "qcom,msm8226-cci";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0xfda0c000 0x1000>;
-			interrupts = <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
-				 <&mmcc CAMSS_CCI_CCI_AHB_CLK>,
-				 <&mmcc CAMSS_CCI_CCI_CLK>;
-			clock-names = "camss_top_ahb",
-				      "cci_ahb",
-				      "cci";
-
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&cci_default>;
-			pinctrl-1 = <&cci_sleep>;
-
-			status = "disabled";
-
-			cci_i2c0: i2c-bus@0 {
-				reg = <0>;
-				clock-frequency = <400000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
-		};
-
 		usb: usb@f9a55000 {
 			compatible = "qcom,ci-hdrc";
 			reg = <0xf9a55000 0x200>,
@@ -417,6 +448,18 @@ usb_hs_phy: phy {
 			};
 		};
 
+		rng@f9bff000 {
+			compatible = "qcom,prng";
+			reg = <0xf9bff000 0x200>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
+		sram@fc190000 {
+			compatible = "qcom,msm8226-rpm-stats";
+			reg = <0xfc190000 0x10000>;
+		};
+
 		gcc: clock-controller@fc400000 {
 			compatible = "qcom,gcc-msm8226";
 			reg = <0xfc400000 0x4000>;
@@ -430,146 +473,28 @@ gcc: clock-controller@fc400000 {
 				      "sleep_clk";
 		};
 
-		mmcc: clock-controller@fd8c0000 {
-			compatible = "qcom,mmcc-msm8226";
-			reg = <0xfd8c0000 0x6000>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			#power-domain-cells = <1>;
+		rpm_msg_ram: sram@fc428000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0xfc428000 0x4000>;
 
-			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
-				 <&gcc GCC_MMSS_GPLL0_CLK_SRC>,
-				 <&gcc GPLL0_VOTE>,
-				 <&gcc GPLL1_VOTE>,
-				 <&rpmcc RPM_SMD_GFX3D_CLK_SRC>,
-				 <&mdss_dsi0_phy 1>,
-				 <&mdss_dsi0_phy 0>;
-			clock-names = "xo",
-				      "mmss_gpll0_vote",
-				      "gpll0_vote",
-				      "gpll1_vote",
-				      "gfx3d_clk_src",
-				      "dsi0pll",
-				      "dsi0pllbyte";
-		};
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xfc428000 0x4000>;
 
-		tlmm: pinctrl@fd510000 {
-			compatible = "qcom,msm8226-pinctrl";
-			reg = <0xfd510000 0x4000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&tlmm 0 0 117>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-
-			blsp1_i2c1_pins: blsp1-i2c1-state {
-				pins = "gpio2", "gpio3";
-				function = "blsp_i2c1";
-				drive-strength = <2>;
-				bias-disable;
+			apss_master_stats: sram@150 {
+				reg = <0x150 0x14>;
 			};
 
-			blsp1_i2c2_pins: blsp1-i2c2-state {
-				pins = "gpio6", "gpio7";
-				function = "blsp_i2c2";
-				drive-strength = <2>;
-				bias-disable;
+			mpss_master_stats: sram@b50 {
+				reg = <0xb50 0x14>;
 			};
 
-			blsp1_i2c3_pins: blsp1-i2c3-state {
-				pins = "gpio10", "gpio11";
-				function = "blsp_i2c3";
-				drive-strength = <2>;
-				bias-disable;
+			lpss_master_stats: sram@1550 {
+				reg = <0x1550 0x14>;
 			};
 
-			blsp1_i2c4_pins: blsp1-i2c4-state {
-				pins = "gpio14", "gpio15";
-				function = "blsp_i2c4";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			blsp1_i2c5_pins: blsp1-i2c5-state {
-				pins = "gpio18", "gpio19";
-				function = "blsp_i2c5";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			blsp1_i2c6_pins: blsp1-i2c6-state {
-				pins = "gpio22", "gpio23";
-				function = "blsp_i2c6";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			cci_default: cci-default-state {
-				pins = "gpio29", "gpio30";
-				function = "cci_i2c0";
-
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			cci_sleep: cci-sleep-state {
-				pins = "gpio29", "gpio30";
-				function = "gpio";
-
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			sdhc1_default_state: sdhc1-default-state {
-				clk-pins {
-					pins = "sdc1_clk";
-					drive-strength = <10>;
-					bias-disable;
-				};
-
-				cmd-data-pins {
-					pins = "sdc1_cmd", "sdc1_data";
-					drive-strength = <10>;
-					bias-pull-up;
-				};
-			};
-
-			sdhc2_default_state: sdhc2-default-state {
-				clk-pins {
-					pins = "sdc2_clk";
-					drive-strength = <10>;
-					bias-disable;
-				};
-
-				cmd-data-pins {
-					pins = "sdc2_cmd", "sdc2_data";
-					drive-strength = <10>;
-					bias-pull-up;
-				};
-			};
-
-			sdhc3_default_state: sdhc3-default-state {
-				clk-pins {
-					pins = "gpio44";
-					function = "sdc3";
-					drive-strength = <8>;
-					bias-disable;
-				};
-
-				cmd-pins {
-					pins = "gpio43";
-					function = "sdc3";
-					drive-strength = <8>;
-					bias-pull-up;
-				};
-
-				data-pins {
-					pins = "gpio39", "gpio40", "gpio41", "gpio42";
-					function = "sdc3";
-					drive-strength = <8>;
-					bias-pull-up;
-				};
+			pronto_master_stats: sram@1f50 {
+				reg = <0x1f50 0x14>;
 			};
 		};
 
@@ -714,170 +639,153 @@ spmi_bus: spmi@fc4cf000 {
 			#interrupt-cells = <4>;
 		};
 
-		rng@f9bff000 {
-			compatible = "qcom,prng";
-			reg = <0xf9bff000 0x200>;
-			clocks = <&gcc GCC_PRNG_AHB_CLK>;
-			clock-names = "core";
-		};
-
-		timer@f9020000 {
-			compatible = "arm,armv7-timer-mem";
-			reg = <0xf9020000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			frame@f9021000 {
-				frame-number = <0>;
-				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xf9021000 0x1000>,
-				      <0xf9022000 0x1000>;
-			};
-
-			frame@f9023000 {
-				frame-number = <1>;
-				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xf9023000 0x1000>;
-				status = "disabled";
-			};
-
-			frame@f9024000 {
-				frame-number = <2>;
-				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xf9024000 0x1000>;
-				status = "disabled";
-			};
-
-			frame@f9025000 {
-				frame-number = <3>;
-				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xf9025000 0x1000>;
-				status = "disabled";
-			};
-
-			frame@f9026000 {
-				frame-number = <4>;
-				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xf9026000 0x1000>;
-				status = "disabled";
-			};
-
-			frame@f9027000 {
-				frame-number = <5>;
-				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xf9027000 0x1000>;
-				status = "disabled";
-			};
-
-			frame@f9028000 {
-				frame-number = <6>;
-				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xf9028000 0x1000>;
-				status = "disabled";
-			};
-		};
-
-		sram@fc190000 {
-			compatible = "qcom,msm8226-rpm-stats";
-			reg = <0xfc190000 0x10000>;
-		};
-
-		rpm_msg_ram: sram@fc428000 {
-			compatible = "qcom,rpm-msg-ram";
-			reg = <0xfc428000 0x4000>;
-
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0xfc428000 0x4000>;
-
-			apss_master_stats: sram@150 {
-				reg = <0x150 0x14>;
-			};
-
-			mpss_master_stats: sram@b50 {
-				reg = <0xb50 0x14>;
-			};
-
-			lpss_master_stats: sram@1550 {
-				reg = <0x1550 0x14>;
-			};
-
-			pronto_master_stats: sram@1f50 {
-				reg = <0x1f50 0x14>;
-			};
-		};
-
 		tcsr_mutex: hwlock@fd484000 {
 			compatible = "qcom,msm8226-tcsr-mutex", "qcom,tcsr-mutex";
 			reg = <0xfd484000 0x1000>;
 			#hwlock-cells = <1>;
 		};
 
-		adsp: remoteproc@fe200000 {
-			compatible = "qcom,msm8226-adsp-pil";
-			reg = <0xfe200000 0x100>;
+		tlmm: pinctrl@fd510000 {
+			compatible = "qcom,msm8226-pinctrl";
+			reg = <0xfd510000 0x4000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 117>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 
-			interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
-					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
-					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
-					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+			blsp1_i2c1_pins: blsp1-i2c1-state {
+				pins = "gpio2", "gpio3";
+				function = "blsp_i2c1";
+				drive-strength = <2>;
+				bias-disable;
+			};
 
-			power-domains = <&rpmpd MSM8226_VDDCX>;
-			power-domain-names = "cx";
+			blsp1_i2c2_pins: blsp1-i2c2-state {
+				pins = "gpio6", "gpio7";
+				function = "blsp_i2c2";
+				drive-strength = <2>;
+				bias-disable;
+			};
 
-			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
-			clock-names = "xo";
+			blsp1_i2c3_pins: blsp1-i2c3-state {
+				pins = "gpio10", "gpio11";
+				function = "blsp_i2c3";
+				drive-strength = <2>;
+				bias-disable;
+			};
 
-			memory-region = <&adsp_region>;
+			blsp1_i2c4_pins: blsp1-i2c4-state {
+				pins = "gpio14", "gpio15";
+				function = "blsp_i2c4";
+				drive-strength = <2>;
+				bias-disable;
+			};
 
-			qcom,smem-states = <&adsp_smp2p_out 0>;
-			qcom,smem-state-names = "stop";
+			blsp1_i2c5_pins: blsp1-i2c5-state {
+				pins = "gpio18", "gpio19";
+				function = "blsp_i2c5";
+				drive-strength = <2>;
+				bias-disable;
+			};
 
-			status = "disabled";
+			blsp1_i2c6_pins: blsp1-i2c6-state {
+				pins = "gpio22", "gpio23";
+				function = "blsp_i2c6";
+				drive-strength = <2>;
+				bias-disable;
+			};
 
-			smd-edge {
-				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+			cci_default: cci-default-state {
+				pins = "gpio29", "gpio30";
+				function = "cci_i2c0";
 
-				qcom,ipc = <&apcs 8 8>;
-				qcom,smd-edge = <1>;
+				drive-strength = <2>;
+				bias-disable;
+			};
 
-				label = "lpass";
+			cci_sleep: cci-sleep-state {
+				pins = "gpio29", "gpio30";
+				function = "gpio";
+
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			sdhc1_default_state: sdhc1-default-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <10>;
+					bias-disable;
+				};
+
+				cmd-data-pins {
+					pins = "sdc1_cmd", "sdc1_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
+			sdhc2_default_state: sdhc2-default-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <10>;
+					bias-disable;
+				};
+
+				cmd-data-pins {
+					pins = "sdc2_cmd", "sdc2_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
+			sdhc3_default_state: sdhc3-default-state {
+				clk-pins {
+					pins = "gpio44";
+					function = "sdc3";
+					drive-strength = <8>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "gpio43";
+					function = "sdc3";
+					drive-strength = <8>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "gpio39", "gpio40", "gpio41", "gpio42";
+					function = "sdc3";
+					drive-strength = <8>;
+					bias-pull-up;
+				};
 			};
 		};
 
-		sram@fdd00000 {
-			compatible = "qcom,msm8226-ocmem";
-			reg = <0xfdd00000 0x2000>,
-			      <0xfec00000 0x20000>;
-			reg-names = "ctrl", "mem";
-			ranges = <0 0xfec00000 0x20000>;
-			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>;
-			clock-names = "core";
+		mmcc: clock-controller@fd8c0000 {
+			compatible = "qcom,mmcc-msm8226";
+			reg = <0xfd8c0000 0x6000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			gmu_sram: gmu-sram@0 {
-				reg = <0x0 0x20000>;
-			};
-		};
-
-		sram@fe805000 {
-			compatible = "qcom,msm8226-imem", "syscon", "simple-mfd";
-			reg = <0xfe805000 0x1000>;
-
-			reboot-mode {
-				compatible = "syscon-reboot-mode";
-				offset = <0x65c>;
-
-				mode-bootloader = <0x77665500>;
-				mode-normal = <0x77665501>;
-				mode-recovery = <0x77665502>;
-			};
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_MMSS_GPLL0_CLK_SRC>,
+				 <&gcc GPLL0_VOTE>,
+				 <&gcc GPLL1_VOTE>,
+				 <&rpmcc RPM_SMD_GFX3D_CLK_SRC>,
+				 <&mdss_dsi0_phy 1>,
+				 <&mdss_dsi0_phy 0>;
+			clock-names = "xo",
+				      "mmss_gpll0_vote",
+				      "gpll0_vote",
+				      "gpll1_vote",
+				      "gfx3d_clk_src",
+				      "dsi0pll",
+				      "dsi0pllbyte";
 		};
 
 		mdss: display-subsystem@fd900000 {
@@ -1007,6 +915,33 @@ mdss_dsi0_phy: phy@fd922a00 {
 			};
 		};
 
+		cci: cci@fda0c000 {
+			compatible = "qcom,msm8226-cci";
+			reg = <0xfda0c000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
+				 <&mmcc CAMSS_CCI_CCI_AHB_CLK>,
+				 <&mmcc CAMSS_CCI_CCI_CLK>;
+			clock-names = "camss_top_ahb",
+				      "cci_ahb",
+				      "cci";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&cci_default>;
+			pinctrl-1 = <&cci_sleep>;
+
+			status = "disabled";
+
+			cci_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gpu: adreno@fdb00000 {
 			compatible = "qcom,adreno-305.18", "qcom,adreno";
 			reg = <0xfdb00000 0x10000>;
@@ -1046,6 +981,71 @@ opp-19000000 {
 				};
 			};
 		};
+
+		sram@fdd00000 {
+			compatible = "qcom,msm8226-ocmem";
+			reg = <0xfdd00000 0x2000>,
+			      <0xfec00000 0x20000>;
+			reg-names = "ctrl", "mem";
+			ranges = <0 0xfec00000 0x20000>;
+			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>;
+			clock-names = "core";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gmu_sram: gmu-sram@0 {
+				reg = <0x0 0x20000>;
+			};
+		};
+
+		adsp: remoteproc@fe200000 {
+			compatible = "qcom,msm8226-adsp-pil";
+			reg = <0xfe200000 0x100>;
+
+			interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+			power-domains = <&rpmpd MSM8226_VDDCX>;
+			power-domain-names = "cx";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			memory-region = <&adsp_region>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			smd-edge {
+				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,ipc = <&apcs 8 8>;
+				qcom,smd-edge = <1>;
+
+				label = "lpass";
+			};
+		};
+
+		sram@fe805000 {
+			compatible = "qcom,msm8226-imem", "syscon", "simple-mfd";
+			reg = <0xfe805000 0x1000>;
+
+			reboot-mode {
+				compatible = "syscon-reboot-mode";
+				offset = <0x65c>;
+
+				mode-bootloader = <0x77665500>;
+				mode-normal = <0x77665501>;
+				mode-recovery = <0x77665502>;
+			};
+		};
 	};
 
 	thermal-zones {

-- 
2.43.0


