Return-Path: <linux-kernel+bounces-116911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BFE88B0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0745B660FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD7819DF50;
	Mon, 25 Mar 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNKvZ5h8"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CBF1607B4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365007; cv=none; b=T/fH6Rp5b9eFsbbCJ3oGhJthTt6p77KrUQTdY4uhE/Obn30xxSsR1tOJWM2DYI9c09xXmeA/EAzLibx7JL01jBm5nxncJrPQ6bqMPG6nB6BoLcXi+Hhncs1Wn1ZXlf0+XM+m4/dT14ySl9IfZZ1z4DOTdOphLp/aWL32In9rrOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365007; c=relaxed/simple;
	bh=9ApsCGJ3JQMoGoKsprcommpaWFgc4kT+l13mpT5eszs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=neBGUkZ9EMnpM/SiYBSDvKPla0G9OWi9UEBa/F3qAibOJRxspqyM/q9UtuqT+E3SAH87NnRVM8ipf+q94kqLBVxXEF47eKkdR+Wxy83LksNarR20VitwjgqhNXPsU3dYPdMKEcxRO0cijzY52bvGCcD3hcfSOJ6P/1ZkFviAess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CNKvZ5h8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a468226e135so497541266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711365003; x=1711969803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zhi0l8jMdnqWTUNp+ZpeHf7cFEI0rGOrDmm8MkWajPw=;
        b=CNKvZ5h8SgWeW+7kRw6k0uvvpJzHYGxUBC/jSOu6I7reTlnI1NG+Sc3+zUp/57oFB/
         sNPWpVYWmmRwiksAWRfZ66fTXNQLM5aMzOILhqGe0LfLxB7yHoa9GaZDL4rzZ9D4NcgT
         vgktbqDSEhlk4ZUWVtHDyMlX9Cw2QJkdX5ETQ7zoOyVXKkOpGcFnfJl1v90lmpEQzhzO
         jmUkySKzxOOB1yPx5hVy9m2Q7YzcGOwLtyLGgW3AvClr5Ul+jRpKhYwVIoMV61QhcIUj
         Vkv6ytoQHMFPSBnTgOYSwI4ngTVIekxVQX8+A0og+D5/biHzkKRgpOwQ3vgL3IHqPGB/
         dRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711365003; x=1711969803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zhi0l8jMdnqWTUNp+ZpeHf7cFEI0rGOrDmm8MkWajPw=;
        b=Ga2/EEwXYkJ+kENiMU3NO7bBgMwhkOHm0kZKLrL2HtIZfD1wrOUGsiy4+vAAm/8h6p
         +9gHoS97Qebkkc2RekwEPSTYfi+ekFGv4Vp+kchkCLoSu6C5xgzu7o8yeUt2Fhx+T7hB
         ylIC6BdLhdgr20kTm1JR0I4vHZ2NRciZWKC8U6WcRedx7MHdPQZmkKsLc3OuRAUQc65u
         t0xeDYu7i2M2wFoFFWGBw/ZIoNXeWchPB8j9MaIkx1steAYbySR7iTMrAn6WkC2PHFkG
         6VdgBVClxAqCE1tgsjl4+mTwNlBd1VaDlPYaaj2l1ZYWe6EpZSb2F0fSUsQCv7j92ybt
         ZYFA==
X-Forwarded-Encrypted: i=1; AJvYcCVuLpAF63yyQwQDPrAVkpWfmfoPX7OGKR0ELEhQt9T7+Ku/jnG6QTqk3vFQDdBk/KhyhifZ/G30iK+GqsoGbYcXss8iB7328EzLpfYP
X-Gm-Message-State: AOJu0YxOZ0YR0UFDG/S9dYrvRXk69BaYPZCGD5UZa2fbt3JcocDwNJT+
	qoNOIE6Do5r8/8y0zpFkpKiw6itXY8ko6V9SJnLMomeWS6T86xs2dT8/9G3O0+YfuEZVFNs1nnW
	vuz1PTA==
X-Google-Smtp-Source: AGHT+IG3HZvEbegs5EIH73dbUnz5W4NvmMEAxSPKeO/1Yxlvv33KUz5P1TYnaBayQ8mJzM6wZHstXw==
X-Received: by 2002:a17:907:6d0b:b0:a49:7078:582a with SMTP id sa11-20020a1709076d0b00b00a497078582amr2478783ejc.35.1711365002522;
        Mon, 25 Mar 2024 04:10:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bw26-20020a170906c1da00b00a4650ec48d0sm2972367ejb.140.2024.03.25.04.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:10:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Mar 2024 12:09:53 +0100
Subject: [PATCH v11 7/7] arm64: dts: amlogic: meson-g12b-bananapi-cm4: add
 support for MNT Reform2 with CM4 adaper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-7-04f55de44604@linaro.org>
References: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-0-04f55de44604@linaro.org>
In-Reply-To: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-0-04f55de44604@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Jagan Teki <jagan@amarulasolutions.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Lukas F. Hartmann" <lukas@mntre.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=9593;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9ApsCGJ3JQMoGoKsprcommpaWFgc4kT+l13mpT5eszs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmAVt+xJTaPofWk/WAXXJr0SUIjdXEb5furHzzV4f0
 xkGdKaOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgFbfgAKCRB33NvayMhJ0fiqEA
 DLMc8JY8FSmQe0SXFoZIkLsRi1prBPzAgTClokzx9meFBcjY6g/7nmjsCW0k0rRAWPQwvuwe7uXJXe
 vXOqP3YRYLDRj2E46b3+kbadw/vAfrdx1WYM4NvA+WhAkJiD+Bbam6Vo38GfLmp6pBxHAhHqcNUbur
 iEwTr+sizaodcCCbbiUt7Isu5gka19s3G2SHS6zpZVSsktI8M86Ve9cYK9PNpPYoDJVR3IWc+W79nB
 SC/mxxQGRTWGm7CbbiHJ9t9W5VP3/IY5kPiQuTBnyWozwiPi3hbozd/s1HKLSbu3a7MkFbM4D+Akpu
 WOBxCewu4R6xVZn9tDJCGqXwi3NNglnMhOHqC6xPrhU1JKPD/3ziv0c/cWA+lU9EE2vEZDqBYWXB3O
 257fuhOnS2Oa4a+7vPYp1lzQJBjBWRTIQJkoAZOELdLgjlp6r7I+jbA+6wGAZRWOFvMY46OlWCrRMl
 k442mN91fxhFHUQLzM/+R7O3iWX0wD1L/2E3ThKW6n6G710i+yYhgGguOPUZhw3Ijcs2TidGD7cllW
 fX3Z8j+1xjBfW1i1mze+GI+TCiQCwvyrz6V2Pjsm/RtSiakfNSsNTOaBvqt7qDgEIRuWkWlEqDigto
 Bffp4gf8iESEwbbKB9hp/gD0hR0LIoYuDn6oXr/LeozhxY1nz6cP92+ukO4Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This adds a basic devicetree for the MNT Reform2 DIY laptop when using a
CM4 adapter and a BPI-CM4 module.

Co-developed-by: Lukas F. Hartmann <lukas@mntre.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../meson-g12b-bananapi-cm4-mnt-reform2.dts        | 384 +++++++++++++++++++++
 2 files changed, 385 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index bf723bec3e15..a89491bb72e8 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-bananapi-m2s.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3-ts050.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-bananapi-cm4-cm4io.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-bananapi-cm4-mnt-reform2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts
new file mode 100644
index 000000000000..003efed529ba
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ * Copyright 2023 MNT Research GmbH
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-bananapi-cm4.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	model = "MNT Reform 2 with BPI-CM4 Module";
+	compatible = "mntre,reform2-cm4", "bananapi,bpi-cm4", "amlogic,a311d", "amlogic,g12b";
+	chassis-type = "laptop";
+
+	aliases {
+		ethernet0 = &ethmac;
+		i2c0 = &i2c1;
+		i2c1 = &i2c3;
+	};
+
+	hdmi_connector: hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "MNT-REFORM2-BPI-CM4";
+		audio-widgets = "Headphone", "Headphone Jack",
+				"Speaker", "External Speaker",
+				"Microphone", "Mic Jack";
+		audio-aux-devs = <&tdmout_a>, <&tdmout_b>, <&tdmin_b>;
+		audio-routing =	"TDMOUT_A IN 0", "FRDDR_A OUT 0",
+				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
+				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
+				"TDM_A Playback", "TDMOUT_A OUT",
+				"TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT",
+				"TDMIN_B IN 1", "TDM_B Capture",
+				"TDMIN_B IN 4", "TDM_B Loopback",
+				"TODDR_A IN 1", "TDMIN_B OUT",
+				"TODDR_B IN 1", "TDMIN_B OUT",
+				"TODDR_C IN 1", "TDMIN_B OUT",
+				"Headphone Jack", "HP_L",
+				"Headphone Jack", "HP_R",
+				"External Speaker", "SPK_LP",
+				"External Speaker", "SPK_LN",
+				"External Speaker", "SPK_RP",
+				"External Speaker", "SPK_RN",
+				"LINPUT1", "Mic Jack",
+				"Mic Jack", "MICB";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+					<&clkc CLKID_MPLL0>,
+					<&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		dai-link-3 {
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link-4 {
+			sound-dai = <&toddr_b>;
+		};
+
+		dai-link-5 {
+			sound-dai = <&toddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-6 {
+			sound-dai = <&tdmif_a>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
+			};
+		};
+
+		/* Analog Audio */
+		dai-link-7 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&wm8960>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-8 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+
+	reg_main_1v8: regulator-main-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&reg_main_3v3>;
+	};
+
+	reg_main_1v2: regulator-main-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&reg_main_5v>;
+	};
+
+	reg_main_3v3: regulator-main-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_main_5v: regulator-main-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_main_usb: regulator-main-usb {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_PWR";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&reg_main_5v>;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm_AO_ab 0 10000 0>;
+		power-supply = <&reg_main_usb>;
+		enable-gpios = <&gpio 58 GPIO_ACTIVE_HIGH>;
+		brightness-levels = <0 32 64 128 160 200 255>;
+		default-brightness-level = <6>;
+	};
+
+	panel {
+		compatible = "innolux,n125hce-gn1";
+		power-supply = <&reg_main_3v3>;
+		backlight = <&backlight>;
+		no-hpd;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&edp_bridge_out>;
+			};
+		};
+	};
+
+	clock_12288: clock_12288 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+};
+
+&mipi_analog_dphy {
+	status = "okay";
+};
+
+&mipi_dphy {
+	status = "okay";
+};
+
+&mipi_dsi {
+	status = "okay";
+
+	assigned-clocks = <&clkc CLKID_GP0_PLL>,
+			  <&clkc CLKID_MIPI_DSI_PXCLK_SEL>,
+			  <&clkc CLKID_MIPI_DSI_PXCLK>,
+			  <&clkc CLKID_CTS_ENCL_SEL>,
+			  <&clkc CLKID_VCLK2_SEL>;
+	assigned-clock-parents = <0>,
+				 <&clkc CLKID_GP0_PLL>,
+				 <0>,
+				 <&clkc CLKID_VCLK2_DIV1>,
+				 <&clkc CLKID_GP0_PLL>;
+	assigned-clock-rates = <936000000>,
+			       <0>,
+			       <936000000>,
+			       <0>,
+			       <0>;
+};
+
+&mipi_dsi_panel_port {
+	mipi_dsi_out: endpoint {
+		remote-endpoint = <&edp_bridge_in>;
+	};
+};
+
+&cecb_AO {
+	status = "okay";
+};
+
+&ethmac {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+&pwm_AO_ab {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_ao_a_pins>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+
+	edp_bridge: bridge@2c {
+		compatible = "ti,sn65dsi86";
+		reg = <0x2c>;
+		enable-gpios = <&gpio GPIOX_10 GPIO_ACTIVE_HIGH>; // PIN_24 / GPIO8
+		vccio-supply = <&reg_main_1v8>;
+		vpll-supply = <&reg_main_1v8>;
+		vcca-supply = <&reg_main_1v2>;
+		vcc-supply = <&reg_main_1v2>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				edp_bridge_in: endpoint {
+					remote-endpoint = <&mipi_dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				edp_bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	wm8960: codec@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		clocks = <&clock_12288>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+		wlf,shared-lrclk;
+	};
+
+	rtc@68 {
+		compatible = "nxp,pcf8523";
+		reg = <0x68>;
+	};
+};
+
+&pcie {
+	status = "okay";
+};
+
+&sd_emmc_b {
+	status = "okay";
+};
+
+&tdmif_a {
+	status = "okay";
+};
+
+&tdmout_a {
+	status = "okay";
+};
+
+&tdmif_b {
+	pinctrl-0 = <&tdm_b_dout0_pins>, <&tdm_b_fs_pins>, <&tdm_b_sclk_pins>, <&tdm_b_din1_pins>;
+	pinctrl-names = "default";
+
+	assigned-clocks = <&clkc_audio AUD_CLKID_TDM_SCLK_PAD1>,
+			  <&clkc_audio AUD_CLKID_TDM_LRCLK_PAD1>;
+	assigned-clock-parents = <&clkc_audio AUD_CLKID_MST_B_SCLK>,
+				 <&clkc_audio AUD_CLKID_MST_B_LRCLK>;
+	assigned-clock-rates = <0>, <0>;
+};
+
+&tdmin_b {
+	status = "okay";
+};
+
+&toddr_a {
+	status = "okay";
+};
+
+&toddr_b {
+	status = "okay";
+};
+
+&toddr_c {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
+
+&usb {
+	dr_mode = "host";
+
+	status = "okay";
+};

-- 
2.34.1


