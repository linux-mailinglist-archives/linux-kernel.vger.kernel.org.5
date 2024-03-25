Return-Path: <linux-kernel+bounces-116906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D641C88A4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620641F37DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D831420B3;
	Mon, 25 Mar 2024 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVeeIHgI"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF0157E8D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365004; cv=none; b=KUus8SDYOTfZYPRZDf8MJRqefKaYiPQesdsuUAKQZCQyvKaHzcGIJ40GckVvvw1EYyRYqhysjrkIXta4mR5TTMc6jsBtmIfJYQvCPR4q1WwlSCGxDpwzZSRvW98OYWPaj/YOJt1dyNi3r8Xrd7lLyipfqhnO3cVj65qQUTfm1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365004; c=relaxed/simple;
	bh=6uoQ7q0WSGnRt1wBGi5MUg52iZBFGMzXkF4qZ3FVLw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/DfR65U00C3WFPOFuz3L4sNpBHjJblcVRk+kloE6E3fxpcjQeut8dD8xceBskJqAEjNbVUBAr0dzXHPXp4NoBvc1CGEDnoI+5AuaxsYBxYvcCk/jZqjEphI+u3dXex+J/BrEMyaSe570Wqc3/ICo129PG4QOmPRaIuYhUr33go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVeeIHgI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a468226e135so497538966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711365001; x=1711969801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7W38VmP7/e4MBZ92EJA4Zfd+sy54HWNOPkuchga6kY=;
        b=HVeeIHgIErptm0hAqtDeYC+lzTmRw0yuAJyutWNOrOeE5BQy8Fi4GCog2ylvCQSdyw
         fX9SOjDyQkgmHDXGAQaOyPewgtWdqSB611+142QgpHEnDX6R4hzHSl/stgg5Mm++Iwva
         6IgDjmaxGJVRkyNTUku7Z8jy0/2VJfJjpsjB7Rf4OBDHb0dD6MKXim+sV7zmlvlaGZgF
         CMSbItiiRYhmwuX8Zrc1zQIO2B4TWcPhZnZQ9mmXh0BXwXM4OGJpnXiMHa+Dfc1kAcY8
         ZrEGnkPzL4fkI6tasXkCsFw08/vmf9bWA8Lqr/S+JgVNeeUEmSufylT8FtmrZL0FYpNy
         6+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711365001; x=1711969801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7W38VmP7/e4MBZ92EJA4Zfd+sy54HWNOPkuchga6kY=;
        b=ZOwgXy5SLyMpjmWJG43BYGK73/oSvAP0Dqzpkq1S53mzvEJ3rnybKEcz/Fj5yv7CAx
         FDGER62rEYCjA6lXsniL7noIA7IXFBJ8Lm3/RCj5N5Wj9aUadoFidGs+H3eJCLM6VAj5
         Tlx6gueX2s86CGkRkA1r8nIEv1dPPZ39XtKmUZ0vXjf39JmrwivYM1TkAoRy4FdrWSWc
         1+2l4aP7bow7LePl0zWI28PByTSJU7oshUDso7RZDfXJlO+vsxrrt+He/V14Gxfq5Q62
         EKUe7VlLh8MXilzHJPsud1qgGgFILmVP426DA531zZcm7u8NRRUPbdjsv9ohFf1vEnQk
         HgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvElGoZcy1VvnMtAmCuyyT07kuaYaKgBeWglBVEp2yDc5r5lrD8/my6CicIRNI8iJw7CzFzaZNA6SvfakDx0AbnNi2QjBhnfuZTVk3
X-Gm-Message-State: AOJu0YxZO9YIDPrcHktxyu4VYd06UCPJWG6+yy1oCqqJj/lA6fmLocBu
	Rcm3iA5FSuGkBMn++j4zF9oAbRBWfOa8HQmjVah3H5/7o3iqdfI1xeIE08YezifpTwqztUoaXv5
	diwoBkg==
X-Google-Smtp-Source: AGHT+IEPlE5wlEOBrrfeLeRdqlriwGeJRzwRxhp3y28W76Dldron5v6PO+aomL64zP6PI8UYC+onkg==
X-Received: by 2002:a17:906:5d2:b0:a47:3664:1b98 with SMTP id t18-20020a17090605d200b00a4736641b98mr4522356ejt.7.1711365001216;
        Mon, 25 Mar 2024 04:10:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bw26-20020a170906c1da00b00a4650ec48d0sm2972367ejb.140.2024.03.25.04.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:10:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Mar 2024 12:09:52 +0100
Subject: [PATCH v11 6/7] arm64: meson: khadas-vim3l: add TS050 DSI panel
 overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-6-04f55de44604@linaro.org>
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
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4784;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6uoQ7q0WSGnRt1wBGi5MUg52iZBFGMzXkF4qZ3FVLw4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmAVt+KC97SPDDu3RkrChahtz+MaFhLx+y6cpmnP/r
 yEoIl76JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgFbfgAKCRB33NvayMhJ0QgWD/
 99QIn15ghruMDJrG1lUSpBBX6QaOn22B13J7xaUA8rqEKGJDCltIR8b7h8KazDtQ0RmwikwQ8VU2CZ
 onmWOX6O/AU9aSjLIcCk8rWuBsVGWcrqzxqQC1M5k+Rp/jTJslo12EXW6boqch2bqIhCThpMbGchK1
 hGctvw+38gioc9lEkAXfGfXdgLC9kFBOOJ6k3K3jPCp5tzQDZxeE4CEpvFRaik6xsQP0a2KGyAxmA7
 50KowkJenrqE+TusyIycuSdsxTrPcSU6C9VCjZyc76S7mr4Z8zaKQZjul20YV7UjxdIrJqpPZ+zYvB
 gaKdMvg+7EDa7o95nzeKgcmBgn6UlxHSXSHtdFkjS15ZYaPsk/RCgxBBfOPn1XPx7/9WleZ/baUCmu
 4O3H/7J1qidmIRl1XvEfmv2JvGsds3vMT/jnaE2j6EUHuIVp0xsJREsqN/Usve/2jImMcXSntVhZv4
 7oPSGdsmSW1z3kA40G37Mtqo6aXlMpcijXTb78FGLd17IB+cNoS2Q0fiOSkiSs2AxctT2GEj8frfsg
 HGCvm+m3maVIeHRGWhcorzZEoBVE9LVgXxpMM+dYzkBV5jSugiWmYDSBwXOMVrrfk4513BxI5rBVe5
 kLsfpiXpkwVOqXTklmnRxUtLfhG+ouT+nODIa1Enlird2/+lYDRABqMb3vOQ==
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
index 1ab160bf928a..bf723bec3e15 100644
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
+meson-g12b-a311d-khadas-vim3-ts050 := meson-g12b-a311d-khadas-vim3.dtb meson-khadas-vim3-ts050.dtbo
+meson-sm1-khadas-vim3l-ts050	:= meson-sm1-khadas-vim3l.dtb meson-khadas-vim3-ts050.dtbo
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


