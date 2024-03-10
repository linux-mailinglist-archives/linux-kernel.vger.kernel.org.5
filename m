Return-Path: <linux-kernel+bounces-98243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A963187774A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59187281E02
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E097B38FAD;
	Sun, 10 Mar 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="fA9bDlWv"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965DD2D792;
	Sun, 10 Mar 2024 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710080057; cv=none; b=rE+7X2qraCOtIJq9T3bRZjUjSbNbqcgQOxdgzu4aMv1fOp03EmmBnLApvZwme1UKNVIJ6bLkiaqgg47ypS0qBUZObCwsdF8y4XGFpqcMJKBC7s6KVLY5z9Rv5gA2UuI5HmBi9KMF5UzRKzAfxFYcGDXhec37AXkyMRcPTCwM6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710080057; c=relaxed/simple;
	bh=ovX0pUAx8F2W2fxCPO/erPbGgmSaezc+eg7Bli3jm2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cudeR917g0RUaI+aJK+DoR3wreqUoi3XUdF4DQ3BTSDuyWyMOt4xyVFLrxpJdcGDWp9N8Cr4XzCLXBaYGPUFsPOxo5mPt1JTpP9jZBhO5sb0cmGrq2xXZB1oLKaHy/rdkAusVQqL3lO3Z7xw0T+W4eUCHDp06liBqGqQSksIXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=fA9bDlWv; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710080051; bh=ovX0pUAx8F2W2fxCPO/erPbGgmSaezc+eg7Bli3jm2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fA9bDlWv/V8C3c9PzuFTZXf58uZO28U+GC/s/Bid4vAeDVLfI447j7VGuur5U3iZa
	 UlzANoWct+tbwAaOOPpANGdrek+Y9p7dYrwFsTuhkSIncJ1oTLKypqFXQpZBsCpIVL
	 1NonW0WFfoE1w3EF+pEUm/efXIJc7jVRzjItV+9A=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 10 Mar 2024 15:13:37 +0100
Subject: [PATCH 2/2] ARM: dts: qcom: msm8974: Add Samsung Galaxy Note 3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-samsung-hlte-v1-2-e9b55bf98a48@z3ntu.xyz>
References: <20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz>
In-Reply-To: <20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adam Honse <calcprogrammer1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9729; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Sb/WsRGC4O+QWQzeeFRgEf6ebe02oXck/4boEdn10qM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl7cAxbQlDMKQd1zxIXQvgEBovI71opbYmAVlNh
 PcZiU+ND/2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZe3AMQAKCRBy2EO4nU3X
 Vn/HD/9kAOpl+96wZixI2ctsger5NDY16d67szJ3HlBTAEe4NK73iBwBwiRDvdkjQtPwJIOBySg
 agTU3KFAqa1rox9KDOi9oYrfJ8WbShD88Rs2E4dqf4Hrgr0o/JSmQkkuC/wunWWf2RK1CIjakVn
 aTABDCXWdOfEikSsx5SFeXga+nx0WJ41OeGyUnVckM26eJrRVOyVuIWEM9an1k2ko3XLRla31Qj
 svTQiIm/RbNY3e47kq4um60JsqWfT91oOt7UB6t6JVc4xzdDNy7IKPZIUfdTojVkjWqeAD5d6dB
 VjR40+Vw0YwRbkNDwvNF47dRIlN/xZ/JdnWOqxsWWsTl6xEH9O1z5tiVsM35U2sq/Y531IZMTgR
 LDrAZ2o1e829Mh/BgkVCf51MqYTihZOQxGN6vaH1XHOhjXZ73YkDf3JXqRfpeFxroiMdM9Mk6W3
 kB1fFiY4xOPVjZAuJrcFFxDVUf4LSyU1gR8SPBO4ZJ+dSr3AWgucLisndIPuq9CsTH/QPajTqHq
 6ZyL4o/nsU/5LdHtyGDdBS15nMqz9pS+GS50oqCNXH5yHUc5eZxc3mSYCoXz1CecwSLoDI+Nf/7
 mJBubBG2k3u/R+8wfH73UbGTWrRrlzgfu9NuG+m+H+y1bVxcnZ5ArVgjUzX04JCmxK8EHgfsR3S
 wR3v5XFVeIIN5Tg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Adam Honse <calcprogrammer1@gmail.com>

Add the devicetree for this "phablet" using the Snapdragon 800 SoC.

Signed-off-by: Adam Honse <calcprogrammer1@gmail.com>
[luca@z3ntu.xyz: clean up, prepare for upstream]
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/Makefile                    |   1 +
 .../boot/dts/qcom/qcom-msm8974-samsung-hlte.dts    | 403 +++++++++++++++++++++
 2 files changed, 404 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
index 9cc1e14e6cd0..845af12d15a2 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -39,6 +39,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8960-cdp.dtb \
 	qcom-msm8960-samsung-expressatt.dtb \
 	qcom-msm8974-lge-nexus5-hammerhead.dtb \
+	qcom-msm8974-samsung-hlte.dtb \
 	qcom-msm8974-sony-xperia-rhine-amami.dtb \
 	qcom-msm8974-sony-xperia-rhine-honami.dtb \
 	qcom-msm8974pro-fairphone-fp2.dtb \
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-samsung-hlte.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-samsung-hlte.dts
new file mode 100644
index 000000000000..e03227a49b67
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974-samsung-hlte.dts
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-msm8974.dtsi"
+#include "pm8841.dtsi"
+#include "pm8941.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+/ {
+	model = "Samsung Galaxy Note 3";
+	compatible = "samsung,hlte", "qcom,msm8974";
+	chassis-type = "handset";
+
+	aliases {
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_3; /* SDC3 SD card slot */
+		serial0 = &blsp1_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pin_a>;
+
+		key-home {
+			label = "home_key";
+			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		key-volume-down {
+			label = "volume_down";
+			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-up {
+			label = "volume_up";
+			gpios = <&pm8941_gpios 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
+	touch_ldo: regulator-touch {
+		compatible = "regulator-fixed";
+		regulator-name = "touch-ldo";
+
+		gpio = <&pm8941_gpios 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_ldo_pin>;
+	};
+};
+
+&blsp1_i2c2 {
+	status = "okay";
+
+	touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+
+		interrupt-parent = <&pm8941_gpios>;
+		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
+
+		vdd-supply = <&pm8941_l10>;
+		vio-supply = <&touch_ldo>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pin>;
+
+		syna,startup-delay-ms = <100>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rmi4-f01@1 {
+			reg = <0x1>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f12@12 {
+			reg = <0x12>;
+			syna,sensor-type = <1>;
+		};
+	};
+};
+
+&blsp2_i2c6 {
+	status = "okay";
+
+	fuelgauge@36 {
+		compatible = "maxim,max17048";
+		reg = <0x36>;
+
+		maxim,double-soc;
+		maxim,rcomp = /bits/ 8 <0x56>;
+
+		interrupt-parent = <&pm8941_gpios>;
+		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&fuelgauge_pin>;
+	};
+};
+
+&blsp1_uart2 {
+	status = "okay";
+};
+
+&pm8941_gpios {
+	gpio_keys_pin_a: gpio-keys-active-state {
+		pins = "gpio2", "gpio3", "gpio5";
+		function = "normal";
+		bias-pull-up;
+		power-source = <PM8941_GPIO_S3>;
+	};
+
+	fuelgauge_pin: fuelgauge-int-state {
+		pins = "gpio26";
+		function = "normal";
+		bias-disable;
+		input-enable;
+		power-source = <PM8941_GPIO_S3>;
+	};
+
+	touch_pin: touchscreen-int-state {
+		pins = "gpio30";
+		function = "normal";
+		bias-disable;
+		input-enable;
+		power-source = <PM8941_GPIO_S3>;
+	};
+
+	touch_ldo_pin: touchscreen-ldo-state {
+		pins = "gpio9";
+		function = "normal";
+		output-high;
+		power-source = <PM8941_GPIO_S3>;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+	};
+};
+
+&remoteproc_adsp {
+	cx-supply = <&pm8841_s2>;
+	status = "okay";
+};
+
+&remoteproc_mss {
+	cx-supply = <&pm8841_s2>;
+	mss-supply = <&pm8841_s3>;
+	mx-supply = <&pm8841_s1>;
+	pll-supply = <&pm8941_l12>;
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm8841-regulators";
+
+		pm8841_s1: s1 {
+			regulator-min-microvolt = <675000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm8841_s2: s2 {
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm8841_s3: s3 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm8841_s4: s4 {
+			regulator-min-microvolt = <815000>;
+			regulator-max-microvolt = <900000>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,rpm-pm8941-regulators";
+
+		pm8941_s1: s1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-always-on;
+		};
+
+		pm8941_s2: s2 {
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
+		};
+
+		pm8941_s3: s3 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8941_l1: l1 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8941_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8941_l3: l3 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8941_l4: l4 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8941_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8941_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8941_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8941_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8941_l9: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8941_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8941_l11: l11 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8941_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8941_l13: l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8941_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8941_l15: l15 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8941_l16: l16 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
+
+		pm8941_l17: l17 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8941_l18: l18 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8941_l19: l19 {
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <3350000>;
+		};
+
+		pm8941_l20: l20 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-allow-set-load;
+			regulator-system-load = <200000>;
+		};
+
+		pm8941_l21: l21 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-allow-set-load;
+			regulator-system-load = <200000>;
+		};
+
+		pm8941_l22: l22 {
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8941_l23: l23 {
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8941_l24: l24 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8941_l20>;
+	vqmmc-supply = <&pm8941_s3>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc1_pin_a>;
+
+	status = "okay";
+};
+
+&sdhc_3 {
+	max-frequency = <100000000>;
+
+	vmmc-supply = <&pm8941_l21>;
+	vqmmc-supply = <&pm8941_l21>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhc3_pin_a>;
+
+	status = "okay";
+};
+
+&tlmm {
+	sdhc1_pin_a: sdhc1-pin-active-state {
+		clk-pins {
+			pins = "sdc1_clk";
+			drive-strength = <4>;
+			bias-disable;
+		};
+
+		cmd-data-pins {
+			pins = "sdc1_cmd", "sdc1_data";
+			drive-strength = <4>;
+			bias-pull-up;
+		};
+	};
+
+	sdhc3_pin_a: sdhc3-pin-active-state {
+		pins = "gpio35", "gpio36", "gpio37", "gpio38", "gpio39", "gpio40";
+		function = "sdc3";
+		drive-strength = <8>;
+		bias-disable;
+	};
+};
+
+&usb {
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+
+	status = "okay";
+};
+
+&usb_hs1_phy {
+	v1p8-supply = <&pm8941_l6>;
+	v3p3-supply = <&pm8941_l24>;
+
+	qcom,init-seq = /bits/ 8 <0x1 0x64>;
+
+	status = "okay";
+};

-- 
2.44.0


