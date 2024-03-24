Return-Path: <linux-kernel+bounces-112703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDAE887D29
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37B51C2048F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B318B182AE;
	Sun, 24 Mar 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATq4QVmQ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A217BB6;
	Sun, 24 Mar 2024 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711289082; cv=none; b=UmR+uZyFNRiuulodXgkZmxVr/SzqfvNkf8VhwvYTd5i6GzrZWKABKFKx4qbzxegHzh/H+DCJVeah3WAgv7aWbmexAvc6Ze5KvIWJSjgrZNnuILtzfVvosjSTdfM8mGmtXVAOAKRTiVI5vBBSO1HmtJg5S4blZmtzTaerxK42mmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711289082; c=relaxed/simple;
	bh=boWikopk1TyShk7fkCi/w3GUKx5T1lbgyUjFLRrxTXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXlrZoSRHUKeiHN9Z5Qx+ehqIlJlo61Rk3NuLw1qzZ3UnxyCaH3qtP9IH7yIWsQEJWdsP8QZLPSC5yFOL4tP5KwjppvH9voCaN76fDv+KJNPJvnUH8kia6WeVm/GpQ2GNGr8ekPsB8Bj5y7e8S1OvyRn2CEBkhQYI/9if0ESda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATq4QVmQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso3672332a12.3;
        Sun, 24 Mar 2024 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711289079; x=1711893879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjdVUh/gFEoTJmG4PZRG6ftSHp4lJRJSdpsQqhAC/cg=;
        b=ATq4QVmQpdz9Yq6waS/pJq/Q/i8Q3bewNDjjadx0Jwyl+7sfTCSPLyoYJvfwtX2sxg
         /IEB2kxWXywQ0FyFBVxh+oAIXVupCaXtJlaxKiMmrx0Wm64sNgD9W3Uz/qkj0NRBR77L
         kwtENoopiIhD4vk+EqFB0ZCpxBJjMNSQPjLBm2UZ2o8kjxP7hftgXLRIN0hhRo3Kek/U
         Oq0INjopcAjjq6Ir5KKj2c+gBRKGDELnLxk+yhAPzagfpCq9FZrP3x1aQTGRSsxLNmrk
         4duCaIUOXweGmgkYHH8B89WQ7+l28M7zZcDtFb/bQsO7Rupc6GL/CkJ2DtI5eJpXy17f
         p+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711289079; x=1711893879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjdVUh/gFEoTJmG4PZRG6ftSHp4lJRJSdpsQqhAC/cg=;
        b=avhupMaI/AP09AOJHyMvivsRzruKy2YLY+FgogIDH5jEoAPDip+IThSrJZqlXgXbER
         JuqT2/j4s8EeB9s0pLjSRx96SdB0KuR3Y+aK6Ltrzvt8hQjU/PV2abN/rE0K4yRN/6O2
         K8VzrV806yRXlXRXSiPRbVhHLgs2414UP3c9GQBjR2ozVULP3WVsmxg0mipC7fe8nKBT
         LYyRZH8YOc42FYS1YPHfJkXn11xOrhzXhcbit7RkNrc/d5r/iuvyA+To8Ea2gTvCKi09
         uJ8ldFDPkuRLyX4PpB8YoXXpHvFm8iArS4miJJNSDTg8RFAzXBWGXOGfc1A86VIDXt6a
         qlHw==
X-Forwarded-Encrypted: i=1; AJvYcCUDAJIHk3FedgGWWpUKwHmTGmbI7LGU19sMe4ugy+4T9+KdjH+1s6/f88VpCVhF3AlrMUhyBhrri1dKJkf518LelpsGobtL9q3K20TOxHJuK8cc/B82olGvMsRiKyp4GQ59IHSowgxKnzWuEfNMNDZ99AnSVcCUp9zgO2Sw8AHUPgkWJl0T
X-Gm-Message-State: AOJu0YxPQDT3Pw69b9E2J7EnWU2UjixqpEMFcNYTuNwlZ1h5Uk5kHX+s
	gFp3DJg0seF6TR6LFB+J44PhmZaE3AzeKRyvMn4goz6gq0yHag1M
X-Google-Smtp-Source: AGHT+IEOuY5deeY+bKm3vAcSVZoazGb1m47EbsNipl/FnaBXs9VYrs1inJHPGulS4hSKQwoT6HLFBg==
X-Received: by 2002:a50:ab1e:0:b0:56a:e8e4:9aef with SMTP id s30-20020a50ab1e000000b0056ae8e49aefmr3598924edc.7.1711289079137;
        Sun, 24 Mar 2024 07:04:39 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id e8-20020aa7d7c8000000b005689c2c6508sm1950948eds.70.2024.03.24.07.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 07:04:38 -0700 (PDT)
Date: Sun, 24 Mar 2024 15:04:37 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: qcom: Add support for Motorola Moto G (2013)
Message-ID: <b35ad5ff8a13f9df415b6e6700b3b5d3f13bfce8.1711288736.git.stano.jakubek@gmail.com>
References: <f5d4d71cd59f25b80889ef88fa044aa3a4268d46.1711288736.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5d4d71cd59f25b80889ef88fa044aa3a4268d46.1711288736.git.stano.jakubek@gmail.com>

Add a device tree for the Motorola Moto G (2013) smartphone based
on the Qualcomm MSM8226 SoC.

Initially supported features:
  - Buttons (Volume Down/Up, Power)
  - eMMC
  - Hall Effect Sensor
  - SimpleFB display
  - TMP108 temperature sensor
  - Vibrator

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm/boot/dts/qcom/Makefile               |   1 +
 .../boot/dts/qcom/msm8226-motorola-falcon.dts | 355 ++++++++++++++++++
 2 files changed, 356 insertions(+)
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
index 000000000000..acf0e3fee481
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/msm8226-motorola-falcon.dts
@@ -0,0 +1,355 @@
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
+		hob-ram@f500000 {
+			reg = <0x0f500000 0x40000>,
+			      <0x0f540000 0x2000>;
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


