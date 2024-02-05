Return-Path: <linux-kernel+bounces-53166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA0A84A193
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9574D284F48
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985AB4BAA7;
	Mon,  5 Feb 2024 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNA0D8RO"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBCE45971
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155749; cv=none; b=OgJvEYBeseD8o8P9PZ1FG14ugVKRGMbavnwRVoaHK3VnNP3qeOgEi2CEWRv3oOIT6nMx3Ogip0oqqIIGNEYSjMMwe7BlNo5A/vPHxGD0+7EsCIPlU7jZkOImzEQ9FLa/5iPYjLiEB5aOaRk836V+uAbIIfNBjrRlXYxJvyGWOxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155749; c=relaxed/simple;
	bh=7Kf3HPglDKUG/aYHn5uv+MfHpQhrMt9zxAb8kCgv5B4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zbu36jzhWnNfZtdFSXjkDoQ0t1Wd4Vr/4AGhhi54CFGQBHtw7cnQ4K7CdpT7oz7d8PlmMOm/NMrLlmRObZdKGpToBJLz6OJmnK4JuzBk3fih21eCQM3i4oZQ55F73qteU8wbmxRI5hNs2wq/VWLGvzxKy2XC1fdMC40Is2rRddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mNA0D8RO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so10602235e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707155745; x=1707760545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CEQapZHD/xXUBiMxlOlNXosOM3ZH2y4glGOQxeOqG8=;
        b=mNA0D8ROUcIhqW2NlNYhTBKubOI/hqnKC07vC2oLopXrdatg66K3Eg9UrXjhlyrPtW
         xPOu2+UoVlRS3s31nf8LUWeEg/P1pGH93F4vPP37c9ldcYJ2VMx6gRN2zkOjGC9KCiFj
         N2SWfpMGaRHb6Jn/8dw/gFtyB45gI6emr0pDwtIdNTjx1i/qtVGjD09E7Nm7Icer7ZqA
         98aeRBfBTv9l4rarZl080eUxRslnX9SoMgFaWa7x+tON5xk3ov4stIVIzNR00DKVVn00
         PmcT86ao7WldVQB7otJi0B22yC2huWYAaGPpwyyS0v5qpW80vCRf6odsMfMEL0Zjary8
         tfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155745; x=1707760545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CEQapZHD/xXUBiMxlOlNXosOM3ZH2y4glGOQxeOqG8=;
        b=Dc14g5GypbxK6iyTnjpiFeJH6lz64VyJChWMm63pvGFok7lXW/2NZt2B1y7m3uCg7O
         2fKVb6UqMwugOWNtZ5+twE5yWq7lwFr1yM1BiDwj+MU1GAEc3thRj7+1jXhklig4vtWI
         HnsnrrYjNBo3uF/OOq2hXkPbilULdPHJhOcYF/h1SD0PPZrpThrxPxrwrq4kCL7ViSPD
         rrfidXLrp6V9m3oo6UDsDTKkcAzkMaqk+8qY3vVAcOu9lOfZ8a5ThghYHDhEVoCwyqR7
         6xLJOog/R0XNrtKRDs5XLV/Sd6aTkiH0Y1V2V53prWk5f9VsxbzP/NyTYZYr5Ufl/6UO
         x2yw==
X-Gm-Message-State: AOJu0YyoDI06OmT31S2Ao7lAsa0Xqi1BEVHkGg2FXehlLTSS6McSg/UW
	CjXEUX6VNDcBD3tk61sPGcrHj9vjQnsUx8XvtEuhjUO9soETrjHWkP8Yqx0koFY=
X-Google-Smtp-Source: AGHT+IHWGYX67kI897F0xxQ1R57GLuS/Mf0fPYGnhxw/gflc8fuYMw62u+lGxIKF7czBDtQjsKUlpA==
X-Received: by 2002:a05:600c:3b14:b0:40e:aca0:7b0a with SMTP id m20-20020a05600c3b1400b0040eaca07b0amr5078664wms.10.1707155745205;
        Mon, 05 Feb 2024 09:55:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWofnczo5qzLNWBcE7kn+sulFLJTNvvVa2/a7OyvgOcln1J1Rhqqk02dKd5qXoZm+MiR4A4E8g+Y+PUCfIgnhr0CVTwKmiYGB50Wy5B7bfDRvSCK+eu3LNl9WVqGInvgLv8zIqwcU6ZYaticfNOdhl3XlyTEUz6V8EMYt5dzy3WFjbgvWhzQRT4j1a+D1XTgLaxgMHoSQo5qy7rt8yT8UhJoa9rGljl5NagfiW+FiKOXoKwc5ECpAjQ7XsjJCVpj+z2Nos6mA4g8kyswRHRPm2EyPFtC3Jk2ag3Fihg9SrS6HB0Q/FjkYLj63vjupsQ90lvAKfESuRG3PDmoy4cKx+Xx5HduLHelMv03bO0kOIszVhM3EMbrbCTBh3N+gH85XL1U6x+wgvyjns0pw/xO8ou04yGGzE2aLbYg0X9Lh4BPVUoO5+9hjKVGEF8tJABzGF7JSD2Qva2OUFA/N2Zss6Y72JHhjHoJuduvnISwYbjt4c3twFq7EUeOEjCz/ffh0JGYomf4yn2e775Zw98miJ3ke14NUTZ71wWxAsgrN0NXHDe+cZDJFnUlOQUAU5CFxLOyTChoYWDEPC+1qlFTmk0FKtUvyhAW9F49FOiA+QA9Z3ydXejw/QUAAT/TuLybYZDqulQcL/2pPbr2XmyzBjSDqXJZsBXjt/C4gZ2fQUi6jyP4T997HoFaZyqrnsIHWPiqzQjetOo+/lVAJSb9HcrkTNfkqu3192WhLg06xZgEUqsTDk9xgvnV6/9KLNkRfI1yWCJjzrCXEptGqcTCvyuZg==
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ee8765901sm517556wmb.43.2024.02.05.09.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:55:44 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 05 Feb 2024 18:55:34 +0100
Subject: [PATCH v10 7/7] arm64: dts: amlogic: meson-g12b-bananapi-cm4: add
 support for MNT Reform2 with CM4 adaper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-amlogic-v6-4-upstream-dsi-ccf-vim3-v10-7-dc06073d5330@linaro.org>
References: <20240205-amlogic-v6-4-upstream-dsi-ccf-vim3-v10-0-dc06073d5330@linaro.org>
In-Reply-To: <20240205-amlogic-v6-4-upstream-dsi-ccf-vim3-v10-0-dc06073d5330@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9577;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7Kf3HPglDKUG/aYHn5uv+MfHpQhrMt9zxAb8kCgv5B4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlwSEWwwOqUxztWQoBbKdkamxaSzTOoRPntDcXO046
 nrmoXoOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZcEhFgAKCRB33NvayMhJ0e8SD/
 4pbVBzy4chIUxiD+X/Nf2MyjkJ/JOEaJooi/C5nSaln+aIHELuMx1tZX3vc5c3t2shtdnnhrx5t7eL
 u4lHN8uTjZk73H4gws6PTh0pF1upUJJ0n/iopjIqglgtxTH73M6pw4RYxeTD8+Y+lKyRrTLnTZZ4mv
 zATk7EI2cxc2czEPQVei5ktOJoN0KR9cqSdqiD45Z34nLQzxTzfoRXDyJRNSiCRmYkv8YhgTKdXHCx
 zAOLGMhHW21OkUIZOmdAryOZbhEtKxglr31ydY7YZozXRLuGjuBQG5+d0IH06/NU4DcohGWbCilVFe
 8iA26w2FErSKxYnEsdmlaK3QbJNrP18dr6UiRP6kfWgKQ2Yvkxr5iaFJkdhw6DbJkBjwpkc5HFVYGc
 ovq+Pqm0g2U+jSfAzDCGXsLRL5VWtJiYa9Qsudk5aq+7PY/ZOAOsKU3PRWSces22nFfTOQD0WrSMeI
 XgY9h/GupRFR/ca+VfsMUnOmE4Xyd7EJ5IhQKEmrtrHAyHxR5lV6hImB4DeuqeLiHzFiaz7GoTOREa
 zhWCwosaAmE4RmAiIlNeHyeNiLpK8MX6xNiv32a67v602PUX/JsPyPRXQidDwfqAzz5cpCFoL2x329
 G7ge6uOKhQFZqbyHTb27Pdg7QvvZceB4ZknUzGryKuB/+ZWCJxZ3MIRX1Rvw==
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
index 5e5ea0f14fe2..0d819a63b15e 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-bananapi-m2s.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
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


