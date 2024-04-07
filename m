Return-Path: <linux-kernel+bounces-134291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CE189AFF9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E8E1C21186
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B4A14294;
	Sun,  7 Apr 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYHmKlKd"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5AA125AE;
	Sun,  7 Apr 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480748; cv=none; b=YtCDZStVi/vznD4yn1OUE6wCvSHe/Z19b/+FEA9ncxoKX4nmGoPnC2WA699hQm2jf/duTKfAcCJ9MabUs5Xg7I1XmeAEhysudMn+Cof+3jt+eB2KQR/ew+cNWfljZyX/4oZ3cQp506A0oEzPjEHAhof/iqiKZIL87whTWpWIDr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480748; c=relaxed/simple;
	bh=B+0pqPwvb1EdqBxsVyrLss9tlL7jkDR0HRKTh05CH34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir6K1OgBPNIvonhF2e2PVjkeiXVMIH8IG9oGD1/jclE3N3PrPulofLGoVlRbfGchC6sIy1yBE8KlNzLC0rMFSRk90WfN9Ki2yb80qFh6NOcwca5vzdF+KkgFTgk044nds46kJFP3vbcIhVj2muFf1bN9bmT5ErQhqbuVUjSfRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYHmKlKd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4702457ccbso458008666b.3;
        Sun, 07 Apr 2024 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480744; x=1713085544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rbcSqHYWgK+vJS20MUL9LcnPXyeta7PI59ZNeYACgLM=;
        b=XYHmKlKde1Rar9ozwslv+RHagXp+VkmQQR/ZI9RU+M1EM7bf1b8Jm26t7XhXAb9N/3
         i6vbL6PAtcpu2QzJPyPP/hIKPpxtT2qp5T4lYn5fJTbzR4+HNt9366bmgr6AH4R47kjn
         cqKPvMGOawkT9rj5jcVsr8z8lWI7usfy1FfVmZ8VuOhctBGcIq4kM1l+V6+pcoo1IQHf
         71SOABDXjBclljNDC/LspXVZXDXbSVIxwPkBBjaUBi/LZidSLiYsFaP+3iH9SmbPh0Ec
         oI+BB2fnfYhG129x6cjpQmNIKDDFJrv8IbR3n3emv3CrOYtBzIFoMqQeGYpFXY6392hz
         iZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480744; x=1713085544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbcSqHYWgK+vJS20MUL9LcnPXyeta7PI59ZNeYACgLM=;
        b=K7tEUtTVwh9XncxvFkKDtsgDpKAkKiSIBMuljhqg8EhL5rc0BAf8QN7GnW79rP9SgB
         YsQrBV7WfgVB8yuHDlSMoD1H3j0tOZh0UinaAv2EmxJxpimj3jGdjDDyNVtAZcNdVfcw
         t5ly0BAM+UPLMbWGi0fv4Kvqeh6go7rmofloipEbcaV+tvM87P8maQ4jZThZdBH0vkJR
         9MwlKZSJC3pHZPi+GOaQJjnvEFhJB9w2VHsd74bM/Y0ckD5GPVoY9+tgJe8QxuvGgW+8
         Wj1nb0ls0VLbVK396jjIZQMGmsNRUd1fQcRvUEosBZVu+oAOcwOCzLYrOS+ctOZ1qsIS
         3Ybw==
X-Forwarded-Encrypted: i=1; AJvYcCVqZ/WJLROWc15rLyu5/vKW8nHuQ1jDHjPEpxJ4sFUg45UL9EhuVP8lA+uYktJ/+PWGSTUFDKXTAu/y21eHyFlRevLimjDJ5dL4LX05EdlQv1Y5bfBpehH1zim9fxfM6SZazEDygCrl1zOr3aUgCteFV1TwovRYzTNgHweJWQHo/2Md+eS3
X-Gm-Message-State: AOJu0Ywza+9zvp1hn+RPv6BGMkkCsPHsancjGyP+YmIdJ0LipSSsR+wS
	RY+5PndkX/DgVeQHB0cBCYFAoA8oz7kBVDvd1TlVDoNkCBaB7QQT
X-Google-Smtp-Source: AGHT+IEZKSkgJyngXF88pjpoyJWEELJFdE4r3wyaZPSRywU2vb2zUCPKqoiwUDMH+4sFnpP18Rklrg==
X-Received: by 2002:a17:906:2c5a:b0:a4e:233b:e470 with SMTP id f26-20020a1709062c5a00b00a4e233be470mr3790874ejh.53.1712480744136;
        Sun, 07 Apr 2024 02:05:44 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090668c600b00a46d049ff63sm2904852ejr.21.2024.04.07.02.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 02:05:43 -0700 (PDT)
Date: Sun, 7 Apr 2024 11:05:42 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ARM: dts: qcom: Add support for Motorola Moto G (2013)
Message-ID: <ef86e9c84b082f7549f2ca825adfb5cbea640637.1712480582.git.stano.jakubek@gmail.com>
References: <32c507337ab80c550fb1df08f7014d1e31eb4c32.1712480582.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c507337ab80c550fb1df08f7014d1e31eb4c32.1712480582.git.stano.jakubek@gmail.com>

Add a device tree for the Motorola Moto G (2013) smartphone based
on the Qualcomm MSM8226 SoC.

Initially supported features:
  - Buttons (Volume Down/Up, Power)
  - eMMC
  - Hall Effect Sensor
  - SimpleFB display
  - TMP108 temperature sensor
  - Vibrator

Note: the dhob and shob reserved-memory regions are seemingly a part of some
Motorola specific (firmware?) mechanism, see [1].

[1] https://github.com/LineageOS/android_kernel_motorola_msm8226/blob/cm-14.1/Documentation/devicetree/bindings/misc/hob_ram.txt

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V3:
  - collect Konrad's R-b

Changes in V2:
  - split hob-ram reserved-memory region into dhob and shob
  - add a note and a link to downstream documentation with more
    information about these regions

 arch/arm/boot/dts/qcom/Makefile               |   1 +
 .../boot/dts/qcom/msm8226-motorola-falcon.dts | 359 ++++++++++++++++++
 2 files changed, 360 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom/msm8226-motorola-falcon.dts

diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
index 6478a39b3be5..3eacbf5c0785 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_QCOM) += \
+	msm8226-motorola-falcon.dtb \
 	qcom-apq8016-sbc.dtb \
 	qcom-apq8026-asus-sparrow.dtb \
 	qcom-apq8026-huawei-sturgeon.dtb \
diff --git a/arch/arm/boot/dts/qcom/msm8226-motorola-falcon.dts b/arch/arm/boot/dts/qcom/msm8226-motorola-falcon.dts
new file mode 100644
index 000000000000..029e1b1659c9
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/msm8226-motorola-falcon.dts
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+/dts-v1/;
+
+#include "qcom-msm8226.dtsi"
+#include "pm8226.dtsi"
+
+/delete-node/ &smem_region;
+
+/ {
+	model = "Motorola Moto G (2013)";
+	compatible = "motorola,falcon", "qcom,msm8226";
+	chassis-type = "handset";
+
+	aliases {
+		mmc0 = &sdhc_1;
+	};
+
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer@3200000 {
+			compatible = "simple-framebuffer";
+			reg = <0x03200000 0x800000>;
+			width = <720>;
+			height = <1280>;
+			stride = <(720 * 3)>;
+			format = "r8g8b8";
+			vsp-supply = <&reg_lcd_pos>;
+			vsn-supply = <&reg_lcd_neg>;
+			vddio-supply = <&vddio_disp_vreg>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		event-hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&tlmm 51 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			linux,can-disable;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
+	vddio_disp_vreg: regulator-vddio-disp {
+		compatible = "regulator-fixed";
+		regulator-name = "vddio_disp";
+		gpio = <&tlmm 34 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pm8226_l8>;
+		startup-delay-us = <300>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer@3200000 {
+			reg = <0x03200000 0x800000>;
+			no-map;
+		};
+
+		dhob@f500000 {
+			reg = <0x0f500000 0x40000>;
+			no-map;
+		};
+
+		shob@f540000 {
+			reg = <0x0f540000 0x2000>;
+			no-map;
+		};
+
+		smem_region: smem@fa00000 {
+			reg = <0x0fa00000 0x100000>;
+			no-map;
+		};
+
+		/* Actually <0x0fa00000 0x500000>, but first 100000 is smem */
+		reserved@fb00000 {
+			reg = <0x0fb00000 0x400000>;
+			no-map;
+		};
+	};
+};
+
+&blsp1_i2c3 {
+	status = "okay";
+
+	regulator@3e {
+		compatible = "ti,tps65132";
+		reg = <0x3e>;
+		pinctrl-0 = <&reg_lcd_default>;
+		pinctrl-names = "default";
+
+		reg_lcd_pos: outp {
+			regulator-name = "outp";
+			regulator-min-microvolt = <4000000>;
+			regulator-max-microvolt = <6000000>;
+			regulator-active-discharge = <1>;
+			regulator-boot-on;
+			enable-gpios = <&tlmm 31 GPIO_ACTIVE_HIGH>;
+		};
+
+		reg_lcd_neg: outn {
+			regulator-name = "outn";
+			regulator-min-microvolt = <4000000>;
+			regulator-max-microvolt = <6000000>;
+			regulator-active-discharge = <1>;
+			regulator-boot-on;
+			enable-gpios = <&tlmm 33 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	temperature-sensor@48 {
+		compatible = "ti,tmp108";
+		reg = <0x48>;
+		interrupts-extended = <&tlmm 13 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&temp_alert_default>;
+		pinctrl-names = "default";
+		#thermal-sensor-cells = <0>;
+	};
+};
+
+&pm8226_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&pm8226_vib {
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8226-regulators";
+
+		pm8226_s3: s3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2200000>;
+		};
+
+		pm8226_s5: s5 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
+		pm8226_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8226_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l3: l3 {
+			regulator-min-microvolt = <750000>;
+			regulator-max-microvolt = <1337500>;
+		};
+
+		pm8226_l4: l4 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l5: l5 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
+		};
+
+		pm8226_l7: l7 {
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <1850000>;
+		};
+
+		pm8226_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l9: l9 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l14: l14 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+		};
+
+		pm8226_l15: l15 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		pm8226_l16: l16 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3350000>;
+		};
+
+		pm8226_l17: l17 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l18: l18 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l19: l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8226_l20: l20 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8226_l21: l21 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+		};
+
+		pm8226_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l23: l23 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l24: l24 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8226_l25: l25 {
+			regulator-min-microvolt = <1775000>;
+			regulator-max-microvolt = <2125000>;
+		};
+
+		pm8226_l26: l26 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8226_l27: l27 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l28: l28 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3400000>;
+			regulator-boot-on;
+		};
+
+		pm8226_lvs1: lvs1 {
+			regulator-always-on;
+		};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8226_l17>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	bus-width = <8>;
+	non-removable;
+
+	status = "okay";
+};
+
+&smbb {
+	qcom,fast-charge-safe-current = <2000000>;
+	qcom,fast-charge-current-limit = <1900000>;
+	qcom,fast-charge-safe-voltage = <4400000>;
+	qcom,minimum-input-voltage = <4300000>;
+
+	status = "okay";
+};
+
+&tlmm {
+	reg_lcd_default: reg-lcd-default-state {
+		pins = "gpio31", "gpio33";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
+
+	reg_vddio_disp_default: reg-vddio-disp-default-state {
+		pins = "gpio34";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
+
+	temp_alert_default: temp-alert-default-state {
+		pins = "gpio13";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-disable;
+	};
+};
+
+&usb {
+	extcon = <&smbb>;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&smbb>;
+	v1p8-supply = <&pm8226_l10>;
+	v3p3-supply = <&pm8226_l20>;
+};
-- 
2.34.1


