Return-Path: <linux-kernel+bounces-133111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835F8899F03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DBD1C22573
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFFE16EBF8;
	Fri,  5 Apr 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="ovDHE782"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64B16E897;
	Fri,  5 Apr 2024 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326018; cv=none; b=auke5NRY2uBgSJcrfWvIe/9wAwaTd1Y3JTyFLu0z2jwRJ9V5yGqYL7fuUpsj4TMojuPKbg27dWXyKW5u9dWQRNf7vTrGpsqJVtLiF1bSw7cGsBHaqIdGjJ86tne6Se0f5Kl60VeGEbbeQchotIF07KvPQm8RQvvK6JfRb35OEXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326018; c=relaxed/simple;
	bh=G0bI5qgE0LDd9BRpOvotX6PHxextPx4tUVg60loKqQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQZ44gvYX6KkKuyiOgCr6skQ+VBYo1UW+EH2ZDtE8b9KkN/Iy5meVtOqgwKkL+5ued4I8W7KoXYgdXigTOCiSm1OWFzJg6z1nfA82wkOMGuHxoh0uQeztyTDxIjIRDZlSVk8EpF3YD+yUgFVj5sw6kmzx7JtcT7g4Nz5SEeKafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=ovDHE782; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 0ACB1419A4;
	Fri,  5 Apr 2024 19:06:47 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1712326007; bh=G0bI5qgE0LDd9BRpOvotX6PHxextPx4tUVg60loKqQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ovDHE782byrwBdEs9Yb5QjBGYCP4TFbI1ICSq+EdP8cd659Fc3MbkdvErVjNnZ3wN
	 2SKfM+bd5IcpqTpGvEhDVmcdVmgr/tgRDdMzffQ6MVMWK3UCcxm/HVEWyo07sjZgGc
	 2ESLADxxC8FrdGsZPdMLrYYIs8TmapLf+hvtj2YvQGM+CO0XXy5kBXArQlhFuncfPY
	 quoZ7/C/ybY3UfcX/bFc+H67O2iGN2ZYMnLdoZyfcv5Tu7YFWSrjZt00vsG/j6DHGs
	 YmidiWT4h4KGCyUQhDpW/46Ytf7QN7pxKwk94S/xjeSe8ihEz0Bj6/Tbeq8Bqint5+
	 weUChFSnetEbA==
From: Nikita Travkin <nikita@trvn.ru>
Date: Fri, 05 Apr 2024 19:06:11 +0500
Subject: [PATCH 2/4] arm64: dts: qcom: Add device tree for Motorola Moto G4
 Play (harpia)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-msm8916-moto-init-v1-2-502b58176d34@trvn.ru>
References: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
In-Reply-To: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>, 
 Ruby Iris Juric <ruby@srxl.me>, Stephan Gerhold <stephan@gerhold.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7948; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=XHxbrEfPHjc7xJ6t++ybqaZ7WD2SUjXw+v5KvKRthVs=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBmEAVzBoxy7MIpq3B8jeYEFsS+jDdolWshMg/fs
 EO5RC24YwWJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZhAFcwAKCRBDHOzuKBm/
 dSFeEACAgb9ZH9uRCwhww15hjH/vovmgRlTEXLElQAZVq37+GhW2mPUrGb9EG27TgSMujyz92Lz
 UswLofkYVNt7P7IUW9dir2I4tVNVwacSDdqboY9UbSJurpJMcmLJ2aqE/wmXsHJJ0BK+FcvfLs9
 IFsFud41I24/8m7LFZUl5FMwnjsb9YN7aiGax9U6+y4HLGjv8cZyyoWNz7Q6PGjZu6JmuSiqfpV
 oBZiap1Po3VL3pAWvaLkZCuH+26ygHtp3XPJqIFsPghh5kV1IqPhpRr86FlQ4l98l5Ug3uBVDiF
 MTsERKBkje8X8Og4O2cWsoky+XjiTOLq3a/Tf1QuerbyFIern6u4w87rK2Avg41wTVWwhJ9KW8P
 rz0BvTvhmHp1qjHuW/2Eacy6ffh0mkgDJSudrJ7PB+3COdIv6g4spkOW+Fl9xJthA2dgr+vupYn
 YGsFv2F9rWeJe8iSVyYyvjg+m7GXVSDQ0dwy5r0QDM/jF/BkfO311q7K1JzycD9PIz2/csGx0rq
 fhHVWPXcyYkxFVFLH+7NPSIB1t+WsgHsh8/GLYGE9fTm434HOGBBNo2yFCkg0ZwPztCHPZ+WT++
 DYkB8Rb9B/5n0v9fsrEG/SwRdtG62FY8DzHwFKRRwbjHa3loxcLca7s+2LA4sl7Mi23ffZxWONZ
 5812rk7moV2ui+A==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

From: Ruby Iris Juric <ruby@srxl.me>

Motorola Moto G4 Play is an msm8916 based smartphone.

Supported features:

- eMMC and SD;
- Buttons;
- Touchscreen;
- USB;
- Fuel Gauge;
- Sound;
- Accelerometer.

msm8916 Moto devices share significant portion of the design so the
common parts are separated into a common dtsi.

Signed-off-by: Ruby Iris Juric <ruby@srxl.me>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Nikita: Split up to common dtsi]
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../boot/dts/qcom/msm8916-motorola-common.dtsi     | 161 +++++++++++++++++++++
 .../boot/dts/qcom/msm8916-motorola-harpia.dts      | 147 +++++++++++++++++++
 3 files changed, 309 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 7d40ec5e7d21..8d3fc7cb7a4d 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -31,6 +31,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-gplus-fl8005a.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8150.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8910.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-harpia.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a3u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a5u-eur.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-motorola-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-motorola-common.dtsi
new file mode 100644
index 000000000000..6a27d0ecd2ad
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-motorola-common.dtsi
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "msm8916-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
+		serial0 = &blsp_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
+
+		label = "GPIO Buttons";
+
+		volume-up-button {
+			label = "Volume Up";
+			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
+	usb_id: usb-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb_id_default>;
+		pinctrl-1 = <&usb_id_sleep>;
+		pinctrl-names = "default", "sleep";
+	};
+};
+
+&blsp_i2c2 {
+	status = "okay";
+
+	touchscreen: touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vio-supply = <&pm8916_l6>;
+
+		syna,startup-delay-ms = <100>;
+
+		rmi4-f01@1 {
+			reg = <1>;
+			syna,nosleep-mode = <1>; /* Allow sleeping */
+		};
+
+		rmi4-f11@11 {
+			reg = <11>;
+			syna,sensor-type = <1>; /* Touchscreen */
+		};
+	};
+};
+
+&blsp_uart1 {
+	status = "okay";
+};
+
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5500000>;
+};
+
+&pm8916_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&pm8916_rpm_regulators {
+	pm8916_l16: l16 {
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&pm8916_vib {
+	status = "okay";
+};
+
+&sdhc_1 {
+	status = "okay";
+};
+
+&sdhc_2 {
+	status = "okay";
+};
+
+&usb {
+	extcon = <&usb_id>, <&usb_id>;
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&usb_id>;
+};
+
+&venus {
+	status = "okay";
+};
+
+&venus_mem {
+	status = "okay";
+};
+
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
+&wcnss_mem {
+	status = "okay";
+};
+
+/* CTS/RTX are not used */
+&blsp_uart1_default {
+	pins = "gpio0", "gpio1";
+};
+&blsp_uart1_sleep {
+	pins = "gpio0", "gpio1";
+};
+
+&tlmm {
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio107";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	usb_id_default: usb-id-default-state {
+		pins = "gpio91";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	usb_id_sleep: usb-id-sleep-state {
+		pins = "gpio91";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts b/arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts
new file mode 100644
index 000000000000..8380451ebbf6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-motorola-common.dtsi"
+
+/ {
+	model = "Motorola Moto G4 Play";
+	compatible = "motorola,harpia", "qcom,msm8916";
+	chassis-type = "handset";
+};
+
+&blsp_i2c1 {
+	status = "okay";
+
+	battery@36 {
+		compatible = "maxim,max17050";
+		reg = <0x36>;
+
+		interrupts-extended = <&tlmm 62 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-0 = <&battery_alert_default>;
+		pinctrl-names = "default";
+
+		maxim,rsns-microohm = <10000>;
+		maxim,over-heat-temp = <600>;
+		maxim,cold-temp = <(-200)>;
+		maxim,dead-volt = <3200>;
+		maxim,over-volt = <4500>;
+	};
+
+	/* charger@6b */
+};
+
+&blsp_i2c4 {
+	status = "okay";
+
+	accelerometer@19 {
+		compatible = "bosch,bma253";
+		reg = <0x19>;
+
+		interrupts-extended = <&tlmm 115 IRQ_TYPE_EDGE_RISING>,
+				      <&tlmm 119 IRQ_TYPE_EDGE_RISING>;
+
+		vdd-supply = <&pm8916_l17>;
+		vddio-supply = <&pm8916_l6>;
+
+		mount-matrix = "1",  "0", "0",
+			       "0", "-1", "0",
+			       "0",  "0", "1";
+
+		pinctrl-0 = <&accel_int_default>;
+		pinctrl-names = "default";
+	};
+
+	/* proximity@49 */
+};
+
+&pm8916_codec {
+	qcom,micbias-lvl = <2800>;
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+	qcom,micbias1-ext-cap;
+};
+
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
+&sdhc_2 {
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
+	pinctrl-names = "default", "sleep";
+
+	cd-gpios = <&tlmm 118 GPIO_ACTIVE_LOW>;
+};
+
+&sound {
+	audio-routing =
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+
+	pinctrl-0 = <&cdc_pdm_default &headset_switch_supply_en
+		     &headset_switch_in>;
+	pinctrl-1 = <&cdc_pdm_sleep &headset_switch_supply_en
+		     &headset_switch_in>;
+	pinctrl-names = "default", "sleep";
+};
+
+&touchscreen {
+	interrupts-extended = <&tlmm 13 IRQ_TYPE_EDGE_FALLING>;
+
+	vdd-supply = <&pm8916_l16>;
+
+	pinctrl-0 = <&ts_int_default>;
+	pinctrl-names = "default";
+};
+
+&tlmm {
+	accel_int_default: accel-int-default-state {
+		pins = "gpio115", "gpio119";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	battery_alert_default: battery-alert-default-state {
+		pins = "gpio62";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	headset_switch_in: headset-switch-in-state {
+		pins = "gpio112";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
+	headset_switch_supply_en: headset-switch-supply-en-state {
+		pins = "gpio111";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
+
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio118";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio13";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};

-- 
2.44.0


