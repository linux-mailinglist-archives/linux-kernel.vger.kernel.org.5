Return-Path: <linux-kernel+bounces-129214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD52896714
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B0E28A335
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1444A6FE23;
	Wed,  3 Apr 2024 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITwUDe6p"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E956E5ED
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130412; cv=none; b=U09tcC7iMX/iaJFDmxcrqz8nBVJTQ8iY4WRbYqwfvN+3McosM3SwYYx6HI5E4+cCV/ohzbN6dt1IiU86DpS+cWrqlz5RctyVe7Ai5CmWoo/BzK4oqqijJ7lw7RmaO3iLrTwQ93nPiXqBddfrO824RQN0J6WGyJs31Dg8inOQNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130412; c=relaxed/simple;
	bh=YrJTPnUe9FPoU2LtM/HkzNX7hKrbNF/TaoEsO6yWogM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H895w4DNaU5gEhqqqdsSvzVLCBesfSRJHhwbnadzWouvMQL/C/stOkxvKglt2mOL0FCXF4VqH9sfKKPfQCzZvN7zthKVslDYpWpK7bTm/z79jbFkCR/AYg+wYtTkrBi8AZtkBrhuM6EDZ7PB6XHlrOGabedZZgVh2SyBMi73kEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ITwUDe6p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-415523d9824so41284925e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712130408; x=1712735208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlefNTpcno+kopU3CV8j4XCd6YHAdWq47c6Zt6fbGpA=;
        b=ITwUDe6p4caxH5XUOY44+8q0Nso4eQYx5auXs8wwib9hr/Rpyd7v9xAo4zqEXDHKGm
         FLvsnfO1pBAPaNx1QOBHWYTNfaUzudjOLvPI3gLZrtNs5BEJKcszhmzJJkz7ucLenq8B
         IJqJdVvUZu0mLyT9ZcXozBB7k19MPVc9JGSc1yoQ308kTG+hPm+h+Jf11+fp3t0Rf96B
         tShoLOIclWghtLqzLVMjxRIP5lUk14epgYu1vT8wo5Iz+1SebDLVZew4VfEq1SZqeXE7
         AgRRcvZyytHLiNsrMF92H44B4H3GO2uM8gasMeoXDYpxN9mYiIxwUhISRSfk/+GqIG1q
         likg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130408; x=1712735208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlefNTpcno+kopU3CV8j4XCd6YHAdWq47c6Zt6fbGpA=;
        b=gSHEOnOHV38dYTS3vjV3xrlke39lD9V6gXcSCuQpKX2X3rriaqMygRb9tRlwolWpVb
         LWWo6HKtM+e4gV1f0BAZkAzyxAYCmudFfzmrIz3NqI5cg6BaboDr4Z/Bx9oX+0rQueGt
         vJH0cfjgZ8wqg1Mmxw2xlOrnfZZBFm92ZdOtTpmfZTWRX8ZPDPq5dQQyTm9XkKi1oUH1
         928VmRC7Zt7IJCDSmlQjvziL25c96631qvtSgfSjv9lgtpBbjtyQckttMSPjtTqcA+fj
         823kgF/HPfVuTpLsS9p6OimVRBjKRMZAI6Pf11pxrOPBKKWnXtBxVLlyQ9K5anDl061V
         f7SA==
X-Forwarded-Encrypted: i=1; AJvYcCUW0eySG2VDuayLnjNyruNSJ9KyaaIuoR05KjH029DpB9fjKLJ4JO9HdnHd5KrTzDnpCzOmsMpnGTanoIMqHVVpjVJrMwBmgIMRIlTm
X-Gm-Message-State: AOJu0YyDbpnPeMkHz3eqn3rg8+/6Pfn+93PczOgfNuFyE72zAHrycvCr
	DYtZdym++YjynxnMostWVPpCrK/z2hn5y6Yxd6t8gmOs5hflaGuhPTIF9uv6dws=
X-Google-Smtp-Source: AGHT+IFQv382VmYPD5j91Mya5r4hsTGsyVc8h9rvI/IMpsbaGRq3DXOZt0hCyHTKcQk4M9Gorgnetg==
X-Received: by 2002:adf:e2cb:0:b0:33d:277b:8bf6 with SMTP id d11-20020adfe2cb000000b0033d277b8bf6mr3248660wrj.26.1712130408189;
        Wed, 03 Apr 2024 00:46:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id cc13-20020a5d5c0d000000b00341b8edbe8csm14021282wrb.87.2024.04.03.00.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:46:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 03 Apr 2024 09:46:37 +0200
Subject: [PATCH v12 6/7] arm64: meson: khadas-vim3l: add TS050 DSI panel
 overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-6-99ecdfdc87fc@linaro.org>
References: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org>
In-Reply-To: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Nicolas Belin <nbelin@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4794;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=YrJTPnUe9FPoU2LtM/HkzNX7hKrbNF/TaoEsO6yWogM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmDQlfa2VZ14f0jFHdpB7He77oInOEMhgaYnEUmXYJ
 51U/CjOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg0JXwAKCRB33NvayMhJ0SH2D/
 0ZpDRTw78r/0Rr8fNdV5YWHxMsOgegpQt0H6vhrGq6o6go3kSJROSrM4dROt6xiYN6QhQsC2mdas4C
 yDM5LfQBhMykFQNmMml2799R/ZkB6QApSAamDR2eovuXV0DZVdW3wTMR7QkWA7sojddvh0JAeB/qQe
 n7+4c0fEz3556oL8WAJ/+R4zA63yfMVslnFt8fg3oEiG8oEiTWfpFSwQDZaEgXqGc1iay6Jp/3cvMM
 kKZW/O5uN8/kvTohrcK3pkuY3KNGe5o2Oh70qCRmYF7c2NJGkZH1DuH3/g56yBUCGks131eEjFkFmO
 mwBDQ890W4ZmoFcwGgYcsxYgQWHPZtW05MJtyNSfZKPiRRoBAlgFo2sgNId6AO1BxRB/tdDcWG9vDA
 VjM1+m+xQU4ATmuS9WrBLmlaWqHBVdslgBrQibvRmIr7YQzI82ntazynuDDTKYAjLupW9QSkuetqoD
 KMdJox34YjLgY+/k1EGQU+ZTxX86KAHRNa3QhiwvmIsQpgrOtoLNfCZOS1KkLvZwgcW2qZ5NCNZShc
 aK6uldqttviVZVTQZOI+4cy+xkO+hqlx+cJu++ddKFeoJj1HCuJvDNCG5/uGYobyEaoDsV6/5NkZDK
 g2TNi7CaEynNdKJKsTtZKTHkTwZF3kHIA9QGtzh2L69wKygoy2s9ZGbDHaxQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This add dtbo overlay to support the Khadas TS050 panel on the
Khadas VIM3 & VIM3L boards.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/Makefile               |   4 +
 .../boot/dts/amlogic/meson-khadas-vim3-ts050.dtso  | 108 +++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 1ab160bf928a..0b7961de3db7 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -16,6 +16,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-bananapi-m2s.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3-ts050.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-bananapi-cm4-cm4io.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
@@ -76,6 +77,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m2-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l-ts050.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-s905d3-libretech-cc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
@@ -86,3 +88,5 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
 # Overlays
 meson-g12a-fbx8am-brcm-dtbs	:= meson-g12a-fbx8am.dtb meson-g12a-fbx8am-brcm.dtbo
 meson-g12a-fbx8am-realtek-dtbs	:= meson-g12a-fbx8am.dtb meson-g12a-fbx8am-realtek.dtbo
+meson-g12b-a311d-khadas-vim3-ts050-dtbs := meson-g12b-a311d-khadas-vim3.dtb meson-khadas-vim3-ts050.dtbo
+meson-sm1-khadas-vim3l-ts050-dtbs	:= meson-sm1-khadas-vim3l.dtb meson-khadas-vim3-ts050.dtbo
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3-ts050.dtso b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3-ts050.dtso
new file mode 100644
index 000000000000..a41b4e619580
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3-ts050.dtso
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/g12a-clkc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/amlogic,meson-g12a-gpio-intc.h>
+
+/dts-v1/;
+/plugin/;
+
+/*
+ * Enable Khadas TS050 DSI Panel + Touch Controller
+ * on Khadas VIM3 (A311D) and VIM3L (S905D3)
+ */
+
+&{/} {
+	panel_backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm_AO_cd 0 25000 0>;
+		brightness-levels = <0 255>;
+		num-interpolated-steps = <255>;
+		default-brightness-level = <200>;
+	};
+};
+
+&i2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	touch-controller@38 {
+		compatible = "edt,edt-ft5206";
+		reg = <0x38>;
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <IRQID_GPIOA_5 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio_expander 6 GPIO_ACTIVE_LOW>;
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <1920>;
+		status = "okay";
+	};
+};
+
+&mipi_dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
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
+	assigned-clock-rates = <960000000>,
+			       <0>,
+			       <960000000>,
+			       <0>,
+			       <0>;
+
+	panel@0 {
+		compatible = "khadas,ts050";
+		reset-gpios = <&gpio_expander 0 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&gpio_expander 1 GPIO_ACTIVE_HIGH>;
+		power-supply = <&vcc_3v3>;
+		backlight = <&panel_backlight>;
+		reg = <0>;
+
+		port {
+			mipi_in_panel: endpoint {
+				remote-endpoint = <&mipi_out_panel>;
+			};
+		};
+	};
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			mipi_out_panel: endpoint {
+				remote-endpoint = <&mipi_in_panel>;
+			};
+		};
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
+&pwm_AO_cd {
+	pinctrl-0 = <&pwm_ao_c_6_pins>, <&pwm_ao_d_e_pins>;
+};

-- 
2.34.1


