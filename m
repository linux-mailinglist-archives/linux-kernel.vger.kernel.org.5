Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1072802E17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbjLDImv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjLDImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:42:40 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D1103
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:42:34 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d04d286bc0so13335845ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701679354; x=1702284154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtxwJB+gyX+Kun83a1WzYlUProLM+PYOcLnPqWgIwQU=;
        b=PbTb/3oVWSOTP/oG6eBJQaepq/5/XryBN4mk7LLiMJvmcuC52VD53f0PUM5IkLP/2a
         HDHHPq22apRNyZu6xuYXwenqnL38xrP9JZJSD0sKebu/Ld1r8CCv5e0/Fs/Sac5OwMbL
         S4ZhYd0q4QxhFwmBmG7LnoNiB+pMEEn9Q31R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679354; x=1702284154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtxwJB+gyX+Kun83a1WzYlUProLM+PYOcLnPqWgIwQU=;
        b=Jt98NJwP0Y7FZx4g+VIQRjXuW8v9KJcKt+SA9wANK+7yhTdFFNxRcx0ZRhLXLnYdd5
         EkK/1PDmb3UER18CEa9xsMEnXx0Tiy+mABi4Oq2M1vznlJ8/TclNuLT0P9pj54WXC6o7
         2LxL3yU3zB71P2owv065vlpfA2M4sWXMgQ9KED3Yab0+HMsmE+M7b7ZmgA8CffFcQZmM
         7hz0tA4iXvuMOzeVwbl4rXEfRwt6nyuIVCLINE9MS7euAR0q1Vp4P4YTLJC/j5uZJnVV
         p7J8bC2v1/rs9HeF9Ibx1JTHHq1KZukuHCzvxc2rQ9vIW6B+cbee1Kuu6ssc6Y+urcaz
         dsYA==
X-Gm-Message-State: AOJu0Yy6X4r5OcytPui82xKeAfl3OvYz12ZlU57WV2O+p3C2UJiuwuEq
        7szUolSjKWgVjauv5VxeNshUuA==
X-Google-Smtp-Source: AGHT+IHjs1efUxU8PIZC7bPuZUL+egD8AeqZnRrzoov/LNuIduoaGApfdvfjcTYnSLtTvg3DMHMgLQ==
X-Received: by 2002:a17:902:ed4d:b0:1d0:6d41:e99 with SMTP id y13-20020a170902ed4d00b001d06d410e99mr1403323plb.46.1701679353640;
        Mon, 04 Dec 2023 00:42:33 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6084:72e2:9ac2:f115])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709028a8e00b001cfc3f73927sm7871795plo.9.2023.12.04.00.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:42:33 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool
Date:   Mon,  4 Dec 2023 16:40:08 +0800
Message-ID: <20231204084012.2281292-7-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204084012.2281292-1-wenst@chromium.org>
References: <20231204084012.2281292-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tentacruel and Tentacool are MT8186 based Chromebooks based on the
Krabby design.

Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
convertible device with touchscreen and stylus.

Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
device. It does not have a touchscreen or stylus.

The two devices both have two variants. The difference is a second
source touchpad controller that shares the same address as the original,
but is incompatible.

The extra SKU IDs for the Tentacruel devices map to different sensor
components attached to the Embedded Controller. These are not visible
to the main processor.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v2:
- Picked up Conor's ack
- Rename touchpad to trackpad
- Drop pinctrl properties from trackpad in tentacruel/tentacool second
  source trackpad

Changes since v1:
- Reorder SKU numbers in descending order.
- Fixed pinconfig node names
- Moved pinctrl-* properties after interrupts-*
- Switched to interrupts-extended for external components
- Marked ADSP as explicitly disabled, with a comment explaining that it
  stalls the system
- Renamed "touchpad" to "trackpad"
- Dropped bogus "no-laneswap" property from it6505 node
- Moved "realtek,jd-src" property to after all the regulator supplies
- Switched to macros for MT6366 regulator "regulator-allowed-modes"
- Renamed "vgpu" regulator name to allow coupling, with a comment
  containing the name used in the design
- Renamed "cr50" node name to "tpm"
- Moved trackpad_pins reference up to i2c2; workaround for second source
  component resource sharing.
- Fix copyright year
- Fixed touchscreen supply name

 arch/arm64/boot/dts/mediatek/Makefile         |    4 +
 .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  129 ++
 .../mt8186-corsola-tentacool-sku327681.dts    |   57 +
 .../mt8186-corsola-tentacool-sku327683.dts    |   24 +
 .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
 .../mt8186-corsola-tentacruel-sku262148.dts   |   26 +
 .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1719 +++++++++++++++++
 7 files changed, 2003 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index e6e7592a3645..442af61b1305 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -43,6 +43,10 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327683.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262144.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262148.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
new file mode 100644
index 000000000000..9b2b64525961
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	aliases {
+		i2c4 = &i2c4;
+	};
+};
+
+&dsi_out {
+	remote-endpoint = <&ps8640_in>;
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+
+	ps8640: edp-bridge@8 {
+		compatible = "parade,ps8640";
+		reg = <0x8>;
+		powerdown-gpios = <&pio 96 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&pio 98 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ps8640_pins>;
+		vdd12-supply = <&mt6366_vrf12_reg>;
+		vdd33-supply = <&mt6366_vcn33_reg>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				ps8640_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				ps8640_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+
+		aux-bus {
+			panel {
+				compatible = "edp-panel";
+				power-supply = <&pp3300_disp_x>;
+				backlight = <&backlight_lcd0>;
+
+				port {
+					panel_in: endpoint {
+						remote-endpoint = <&ps8640_out>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	i2c-scl-internal-delay-ns = <10000>;
+
+	touchscreen: touchscreen@10 {
+		compatible = "hid-over-i2c";
+		reg = <0x10>;
+		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		post-power-on-delay-ms = <10>;
+		hid-descr-addr = <0x0001>;
+		vdd-supply = <&pp3300_s3>;
+	};
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	proximity@28 {
+		compatible = "semtech,sx9324";
+		reg = <0x28>;
+		interrupts-extended = <&pio 5 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sar_sensor_pins>;
+		vdd-supply = <&mt6366_vio18_reg>;
+		svdd-supply = <&mt6366_vio18_reg>;
+		#io-channel-cells = <1>;
+	};
+};
+
+&pio {
+	i2c4_pins: i2c4-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO136__FUNC_SDA4>,
+				 <PINMUX_GPIO135__FUNC_SCL4>;
+			bias-disable;
+			drive-strength = <4>;
+			input-enable;
+		};
+	};
+
+	ps8640_pins: ps8640-pins {
+		pins-pwrdn-rst {
+			pinmux = <PINMUX_GPIO96__FUNC_GPIO96>,
+				 <PINMUX_GPIO98__FUNC_GPIO98>;
+			output-low;
+		};
+	};
+
+	sar_sensor_pins: sar-sensor-pins {
+		pins-irq {
+			pinmux = <PINMUX_GPIO5__FUNC_GPIO5>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
new file mode 100644
index 000000000000..9bb64353ca65
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-krabby.dtsi"
+
+/ {
+	model = "Google Tentacool board";
+	compatible = "google,tentacruel-sku327681", "google,tentacruel", "mediatek,mt8186";
+	chassis-type = "laptop";
+};
+
+/* Tentacool omits the pen. */
+&gpio_keys {
+	status = "disabled";
+};
+
+/* Tentacool omits the touchscreen; nothing else is on i2c1. */
+&i2c1 {
+	status = "disabled";
+};
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
+	>;
+
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
+
+/* Tentacool omits the touchscreen. */
+&touchscreen {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
new file mode 100644
index 000000000000..c3ae6f9616c8
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+#include "mt8186-corsola-tentacool-sku327681.dts"
+
+/ {
+	compatible = "google,tentacruel-sku327683", "google,tentacruel", "mediatek,mt8186";
+};
+
+/* This variant replaces only the trackpad controller. */
+&i2c2 {
+	/delete-node/ trackpad@15;
+
+	trackpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
+		hid-descr-addr = <0x0001>;
+		vdd-supply = <&pp3300_s3>;
+		wakeup-source;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
new file mode 100644
index 000000000000..26d3451a5e47
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-krabby.dtsi"
+
+/ {
+	model = "Google Tentacruel board";
+	compatible = "google,tentacruel-sku262147", "google,tentacruel-sku262146",
+		     "google,tentacruel-sku262145", "google,tentacruel-sku262144",
+		     "google,tentacruel", "mediatek,mt8186";
+	chassis-type = "convertible";
+};
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
+	>;
+
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
new file mode 100644
index 000000000000..447b57b12b41
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+#include "mt8186-corsola-tentacruel-sku262144.dts"
+
+/ {
+	compatible = "google,tentacruel-sku262151", "google,tentacruel-sku262150",
+		     "google,tentacruel-sku262149", "google,tentacruel-sku262148",
+		     "google,tentacruel", "mediatek,mt8186";
+};
+
+/* This variant replaces only the trackpad controller. */
+&i2c2 {
+	/delete-node/ trackpad@15;
+
+	trackpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
+		hid-descr-addr = <0x0001>;
+		vdd-supply = <&pp3300_s3>;
+		wakeup-source;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
new file mode 100644
index 000000000000..8726b2916ef1
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -0,0 +1,1719 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+/dts-v1/;
+#include "mt8186.dtsi"
+#include <dt-bindings/pinctrl/mt8186-pinfunc.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
+
+/ {
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c5 = &i2c5;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		/* The size should be filled in by the bootloader. */
+		reg = <0 0x40000000 0 0>;
+	};
+
+	backlight_lcd0: backlight-lcd0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 500000>;
+		power-supply = <&ppvar_sys>;
+		enable-gpios = <&pio 152 0>;
+		brightness-levels = <0 1023>;
+		num-interpolated-steps = <1023>;
+		default-brightness-level = <576>;
+	};
+
+	btsco: bt-sco {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <0>;
+	};
+
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <2>;
+		wakeup-delay-ms = <50>;
+		#sound-dai-cells = <0>;
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pen_eject>;
+
+		pen_insert: pen-insert-switch {
+			label = "Pen Insert";
+			/* Insert = low, eject = high */
+			gpios = <&pio 18 GPIO_ACTIVE_LOW>;
+			linux,code = <SW_PEN_INSERTED>;
+			linux,input-type = <EV_SW>;
+			wakeup-event-action = <EV_ACT_DEASSERTED>;
+			wakeup-source;
+		};
+	};
+
+	pp1800_dpbrdg_dx: regulator-pp1800-dpbrdg-dx {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&en_pp1800_dpbrdg>;
+		regulator-name = "pp1800_dpbrdg_dx";
+		enable-active-high;
+		gpio = <&pio 39 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&mt6366_vio18_reg>;
+	};
+
+	pp3300_disp_x: regulator-pp3300-disp-x {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_disp_x";
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_panel_fixed_pins>;
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&pio 153 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_z2>;
+	};
+
+	/* system wide LDO 3.3V power rail */
+	pp3300_z5: regulator-pp3300-ldo-z5 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_ldo_z5";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* separately switched 3.3V power rail */
+	pp3300_s3: regulator-pp3300-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_s3";
+		/* automatically sequenced by PMIC EXT_PMIC_EN2 */
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&pp3300_z2>;
+	};
+
+	/* system wide 3.3V power rail */
+	pp3300_z2: regulator-pp3300-z2 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_z2";
+		/* EN pin tied to pp4200_z2, which is controlled by EC */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide 4.2V power rail */
+	pp4200_z2: regulator-pp4200-z2 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp4200_z2";
+		/* controlled by EC */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide switching 5.0V power rail */
+	pp5000_z2: regulator-pp5000-z2 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp5000_z2";
+		/* controlled by EC */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide semi-regulated power rail from battery or USB */
+	ppvar_sys: regulator-ppvar-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		adsp_dma_mem: memory@61000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x61000000 0 0x100000>;
+			no-map;
+		};
+
+		adsp_mem: memory@60000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60000000 0 0xA00000>;
+			no-map;
+		};
+
+		scp_mem: memory@50000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x10a0000>;
+			no-map;
+		};
+	};
+
+	sound: sound {
+		compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound";
+		pinctrl-names = "aud_clk_mosi_off",
+				"aud_clk_mosi_on",
+				"aud_clk_miso_off",
+				"aud_clk_miso_on",
+				"aud_dat_miso_off",
+				"aud_dat_miso_on",
+				"aud_dat_mosi_off",
+				"aud_dat_mosi_on",
+				"aud_gpio_i2s0_off",
+				"aud_gpio_i2s0_on",
+				"aud_gpio_i2s1_off",
+				"aud_gpio_i2s1_on",
+				"aud_gpio_i2s2_off",
+				"aud_gpio_i2s2_on",
+				"aud_gpio_i2s3_off",
+				"aud_gpio_i2s3_on",
+				"aud_gpio_tdm_off",
+				"aud_gpio_tdm_on",
+				"aud_gpio_pcm_off",
+				"aud_gpio_pcm_on",
+				"aud_gpio_dmic_sec";
+		pinctrl-0 = <&aud_clk_mosi_off>;
+		pinctrl-1 = <&aud_clk_mosi_on>;
+		pinctrl-2 = <&aud_clk_miso_off>;
+		pinctrl-3 = <&aud_clk_miso_on>;
+		pinctrl-4 = <&aud_dat_miso_off>;
+		pinctrl-5 = <&aud_dat_miso_on>;
+		pinctrl-6 = <&aud_dat_mosi_off>;
+		pinctrl-7 = <&aud_dat_mosi_on>;
+		pinctrl-8 = <&aud_gpio_i2s0_off>;
+		pinctrl-9 = <&aud_gpio_i2s0_on>;
+		pinctrl-10 = <&aud_gpio_i2s1_off>;
+		pinctrl-11 = <&aud_gpio_i2s1_on>;
+		pinctrl-12 = <&aud_gpio_i2s2_off>;
+		pinctrl-13 = <&aud_gpio_i2s2_on>;
+		pinctrl-14 = <&aud_gpio_i2s3_off>;
+		pinctrl-15 = <&aud_gpio_i2s3_on>;
+		pinctrl-16 = <&aud_gpio_tdm_off>;
+		pinctrl-17 = <&aud_gpio_tdm_on>;
+		pinctrl-18 = <&aud_gpio_pcm_off>;
+		pinctrl-19 = <&aud_gpio_pcm_on>;
+		pinctrl-20 = <&aud_gpio_dmic_sec>;
+		mediatek,adsp = <&adsp>;
+		mediatek,platform = <&afe>;
+
+		playback-codecs {
+			sound-dai = <&it6505dptx>, <&rt1019p>;
+		};
+
+		headset-codec {
+			sound-dai = <&rt5682s 0>;
+		};
+	};
+
+	rt1019p: speaker-codec {
+		compatible = "realtek,rt1019p";
+		pinctrl-names = "default";
+		pinctrl-0 = <&rt1019p_pins_default>;
+		sdb-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+
+	usb_p1_vbus: regulator-usb-p1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 148 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp5000_z2>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_pin>;
+		post-power-on-delay-ms = <50>;
+		reset-gpios = <&pio 54 GPIO_ACTIVE_LOW>;
+	};
+
+	wifi_wakeup: wifi-wakeup {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_wakeup_pin>;
+
+		wowlan-event {
+			label = "Wake on WiFi";
+			gpios = <&pio 7 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+};
+
+&adsp {
+	memory-region = <&adsp_dma_mem>, <&adsp_mem>;
+	status = "disabled"; /* causes stall */
+};
+
+&afe {
+	i2s0-share = "I2S1";
+	i2s3-share = "I2S2";
+	status = "okay";
+};
+
+&cci {
+	proc-supply = <&mt6366_vproc12_reg>;
+};
+
+&cpu0 {
+	proc-supply = <&mt6366_vproc12_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6366_vproc12_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&mt6366_vproc12_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&mt6366_vproc12_reg>;
+};
+
+&cpu4 {
+	proc-supply = <&mt6366_vproc12_reg>;
+};
+
+&cpu5 {
+	proc-supply = <&mt6366_vproc12_reg>;
+};
+
+&cpu6 {
+	proc-supply = <&mt6366_vproc11_reg>;
+};
+
+&cpu7 {
+	proc-supply = <&mt6366_vproc11_reg>;
+};
+
+&dpi {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&dpi_pins_default>;
+	pinctrl-1 = <&dpi_pins_sleep>;
+	status = "okay";
+};
+
+&dpi_out {
+	remote-endpoint = <&it6505_in>;
+};
+
+&dsi0 {
+	status = "okay";
+};
+
+&gic {
+	mediatek,broken-save-restore-fw;
+};
+
+&gpu {
+	mali-supply = <&mt6366_vgpu_reg>;
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	clock-frequency = <400000>;
+	i2c-scl-internal-delay-ns = <8000>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	/*
+	 * Trackpad pin put here to work around second source components
+	 * sharing the pinmux in steelix designs.
+	 */
+	pinctrl-0 = <&i2c2_pins>, <&trackpad_pin>;
+	clock-frequency = <400000>;
+	i2c-scl-internal-delay-ns = <10000>;
+	status = "okay";
+
+	trackpad@15 {
+		compatible = "elan,ekth3000";
+		reg = <0x15>;
+		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&pp3300_s3>;
+		wakeup-source;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	it6505dptx: dp-bridge@5c {
+		compatible = "ite,it6505";
+		reg = <0x5c>;
+		interrupts-extended = <&pio 8 IRQ_TYPE_LEVEL_LOW>;
+		ovdd-supply = <&mt6366_vsim2_reg>;
+		pwr18-supply = <&pp1800_dpbrdg_dx>;
+		reset-gpios = <&pio 177 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&it6505_pins>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#sound-dai-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				it6505_in: endpoint {
+					link-frequencies = /bits/ 64 <150000000>;
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+			};
+		};
+	};
+};
+
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	status = "okay";
+
+	rt5682s: codec@1a {
+		compatible = "realtek,rt5682s";
+		reg = <0x1a>;
+		interrupts-extended = <&pio 17 IRQ_TYPE_EDGE_BOTH>;
+		AVDD-supply = <&mt6366_vio18_reg>;
+		DBVDD-supply = <&mt6366_vio18_reg>;
+		LDO1-IN-supply = <&mt6366_vio18_reg>;
+		MICVDD-supply = <&pp3300_z2>;
+		realtek,jd-src = <1>;
+		#sound-dai-cells = <1>;
+	};
+};
+
+&mfg0 {
+	domain-supply = <&mt6366_vsram_gpu_reg>;
+};
+
+&mfg1 {
+	domain-supply = <&mt6366_vgpu_reg>;
+};
+
+&mipi_tx0 {
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	non-removable;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	supports-cqe;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
+	hs400-ds-delay = <0x11814>;
+	mediatek,hs400-ds-dly3 = <0x14>;
+	vmmc-supply = <&mt6366_vemc_reg>;
+	vqmmc-supply = <&mt6366_vio18_reg>;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default", "state_uhs", "state_eint";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	pinctrl-2 = <&mmc1_pins_eint>;
+	/delete-property/ interrupts;
+	interrupt-names = "msdc", "sdio_wakeup";
+	interrupts-extended = <&gic GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&pio 87 IRQ_TYPE_LEVEL_LOW>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	keep-power-in-suspend;
+	wakeup-source;
+	cap-sdio-irq;
+	no-mmc;
+	no-sd;
+	non-removable;
+	vmmc-supply = <&pp3300_s3>;
+	vqmmc-supply = <&mt6366_vio18_reg>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bluetooth@2 {
+		compatible = "mediatek,mt7921s-bluetooth";
+		reg = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_pins_reset>;
+		reset-gpios = <&pio 155 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&nor_flash {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nor_pins_default>;
+	assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D7_D4>;
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <39000000>;
+	};
+};
+
+&pio {
+	/* 185 lines */
+	gpio-line-names = "TP",
+			  "TP",
+			  "TP",
+			  "I2S0_HP_DI",
+			  "I2S3_DP_SPKR_DO",
+			  "SAR_INT_ODL",
+			  "BT_WAKE_AP_ODL",
+			  "WIFI_INT_ODL",
+			  "DPBRDG_INT_ODL",
+			  "EDPBRDG_INT_ODL",
+			  "EC_AP_HPD_OD",
+			  "TCHPAD_INT_ODL",
+			  "TCHSCR_INT_1V8_ODL",
+			  "EC_AP_INT_ODL",
+			  "EC_IN_RW_ODL",
+			  "GSC_AP_INT_ODL",
+			  /* AP_FLASH_WP_L is crossystem ABI. Rev1 schematics call it AP_WP_ODL. */
+			  "AP_FLASH_WP_L",
+			  "HP_INT_ODL",
+			  "PEN_EJECT_OD",
+			  "WCAM_PWDN_L",
+			  "WCAM_RST_L",
+			  "UCAM_SEN_EN",
+			  "UCAM_RST_L",
+			  "LTE_RESET_L",
+			  "LTE_SAR_DETECT_L",
+			  "I2S2_DP_SPK_MCK",
+			  "I2S2_DP_SPKR_BCK",
+			  "I2S2_DP_SPKR_LRCK",
+			  "I2S2_DP_SPKR_DI (TP)",
+			  "EN_PP1000_EDPBRDG",
+			  "EN_PP1800_EDPBRDG",
+			  "EN_PP3300_EDPBRDG",
+			  "UART_GSC_TX_AP_RX",
+			  "UART_AP_TX_GSC_RX",
+			  "UART_DBGCON_TX_ADSP_RX",
+			  "UART_ADSP_TX_DBGCON_RX",
+			  "EN_PP1000_DPBRDG",
+			  "TCHSCR_REPORT_DISABLE",
+			  "EN_PP3300_DPBRDG",
+			  "EN_PP1800_DPBRDG",
+			  "SPI_AP_CLK_EC",
+			  "SPI_AP_CS_EC_L",
+			  "SPI_AP_DO_EC_DI",
+			  "SPI_AP_DI_EC_DO",
+			  "SPI_AP_CLK_GSC",
+			  "SPI_AP_CS_GSC_L",
+			  "SPI_AP_DO_GSC_DI",
+			  "SPI_AP_DI_GSC_DO",
+			  "UART_DBGCON_TX_SCP_RX",
+			  "UART_SCP_TX_DBGCON_RX",
+			  "EN_PP1200_CAM_X",
+			  "EN_PP2800A_VCM_X",
+			  "EN_PP2800A_UCAM_X",
+			  "EN_PP2800A_WCAM_X",
+			  "WLAN_MODULE_RST_L",
+			  "EN_PP1200_UCAM_X",
+			  "I2S1_HP_DO",
+			  "I2S1_HP_BCK",
+			  "I2S1_HP_LRCK",
+			  "I2S1_HP_MCK",
+			  "TCHSCR_RST_1V8_L",
+			  "SPI_AP_CLK_ROM",
+			  "SPI_AP_CS_ROM_L",
+			  "SPI_AP_DO_ROM_DI",
+			  "SPI_AP_DI_ROM_DO",
+			  "NC",
+			  "NC",
+			  "EMMC_STRB",
+			  "EMMC_CLK",
+			  "EMMC_CMD",
+			  "EMMC_RST_L",
+			  "EMMC_DATA0",
+			  "EMMC_DATA1",
+			  "EMMC_DATA2",
+			  "EMMC_DATA3",
+			  "EMMC_DATA4",
+			  "EMMC_DATA5",
+			  "EMMC_DATA6",
+			  "EMMC_DATA7",
+			  "AP_KPCOL0",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "TP",
+			  "SDIO_CLK",
+			  "SDIO_CMD",
+			  "SDIO_DATA0",
+			  "SDIO_DATA1",
+			  "SDIO_DATA2",
+			  "SDIO_DATA3",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "EDPBRDG_PWREN",
+			  "BL_PWM_1V8",
+			  "EDPBRDG_RST_L",
+			  "MIPI_DPI_CLK",
+			  "MIPI_DPI_VSYNC",
+			  "MIPI_DPI_HSYNC",
+			  "MIPI_DPI_DE",
+			  "MIPI_DPI_D0",
+			  "MIPI_DPI_D1",
+			  "MIPI_DPI_D2",
+			  "MIPI_DPI_D3",
+			  "MIPI_DPI_D4",
+			  "MIPI_DPI_D5",
+			  "MIPI_DPI_D6",
+			  "MIPI_DPI_DA7",
+			  "MIPI_DPI_D8",
+			  "MIPI_DPI_D9",
+			  "MIPI_DPI_D10",
+			  "MIPI_DPI_D11",
+			  "PCM_BT_CLK",
+			  "PCM_BT_SYNC",
+			  "PCM_BT_DI",
+			  "PCM_BT_DO",
+			  "JTAG_TMS_TP",
+			  "JTAG_TCK_TP",
+			  "JTAG_TDI_TP",
+			  "JTAG_TDO_TP",
+			  "JTAG_TRSTN_TP",
+			  "CLK_24M_WCAM",
+			  "CLK_24M_UCAM",
+			  "UCAM_DET_ODL",
+			  "AP_I2C_EDPBRDG_SCL_1V8",
+			  "AP_I2C_EDPBRDG_SDA_1V8",
+			  "AP_I2C_TCHSCR_SCL_1V8",
+			  "AP_I2C_TCHSCR_SDA_1V8",
+			  "AP_I2C_TCHPAD_SCL_1V8",
+			  "AP_I2C_TCHPAD_SDA_1V8",
+			  "AP_I2C_DPBRDG_SCL_1V8",
+			  "AP_I2C_DPBRDG_SDA_1V8",
+			  "AP_I2C_WLAN_SCL_1V8",
+			  "AP_I2C_WLAN_SDA_1V8",
+			  "AP_I2C_AUD_SCL_1V8",
+			  "AP_I2C_AUD_SDA_1V8",
+			  "AP_I2C_TPM_SCL_1V8",
+			  "AP_I2C_UCAM_SDA_1V8",
+			  "AP_I2C_UCAM_SCL_1V8",
+			  "AP_I2C_UCAM_SDA_1V8",
+			  "AP_I2C_WCAM_SCL_1V8",
+			  "AP_I2C_WCAM_SDA_1V8",
+			  "SCP_I2C_SENSOR_SCL_1V8",
+			  "SCP_I2C_SENSOR_SDA_1V8",
+			  "AP_EC_WARM_RST_REQ",
+			  "AP_XHCI_INIT_DONE",
+			  "USB3_HUB_RST_L",
+			  "EN_SPKR",
+			  "BEEP_ON",
+			  "AP_EDP_BKLTEN",
+			  "EN_PP3300_DISP_X",
+			  "EN_PP3300_SDBRDG_X",
+			  "BT_KILL_1V8_L",
+			  "WIFI_KILL_1V8_L",
+			  "PWRAP_SPI0_CSN",
+			  "PWRAP_SPI0_CK",
+			  "PWRAP_SPI0_MO",
+			  "PWRAP_SPI0_MI",
+			  "SRCLKENA0",
+			  "SRCLKENA1",
+			  "SCP_VREQ_VAO",
+			  "AP_RTC_CLK32K",
+			  "AP_PMIC_WDTRST_L",
+			  "AUD_CLK_MOSI",
+			  "AUD_SYNC_MOSI",
+			  "AUD_DAT_MOSI0",
+			  "AUD_DAT_MOSI1",
+			  "AUD_CLK_MISO",
+			  "AUD_SYNC_MISO",
+			  "AUD_DAT_MISO0",
+			  "AUD_DAT_MISO1",
+			  "NC",
+			  "NC",
+			  "DPBRDG_PWREN",
+			  "DPBRDG_RST_L",
+			  "LTE_W_DISABLE_L",
+			  "LTE_SAR_DETECT_L",
+			  "EN_PP3300_LTE_X",
+			  "LTE_PWR_OFF_L",
+			  "LTE_RESET_L",
+			  "TP",
+			  "TP";
+
+	aud_clk_mosi_off: aud-clk-mosi-off-pins {
+		pins-clk-sync {
+			pinmux = <PINMUX_GPIO166__FUNC_GPIO166>,
+				 <PINMUX_GPIO167__FUNC_GPIO167>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	aud_clk_mosi_on: aud-clk-mosi-on-pins {
+		pins-clk-sync {
+			pinmux = <PINMUX_GPIO166__FUNC_AUD_CLK_MOSI>,
+				 <PINMUX_GPIO167__FUNC_AUD_SYNC_MOSI>;
+		};
+	};
+
+	aud_clk_miso_off: aud-clk-miso-off-pins {
+		pins-clk-sync {
+			pinmux = <PINMUX_GPIO170__FUNC_GPIO170>,
+				 <PINMUX_GPIO171__FUNC_GPIO171>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	aud_clk_miso_on: aud-clk-miso-on-pins {
+		pins-clk-sync {
+			pinmux = <PINMUX_GPIO170__FUNC_AUD_CLK_MISO>,
+				 <PINMUX_GPIO171__FUNC_AUD_SYNC_MISO>;
+		};
+	};
+
+	aud_dat_mosi_off: aud-dat-mosi-off-pins {
+		pins-dat {
+			pinmux = <PINMUX_GPIO168__FUNC_GPIO168>,
+				 <PINMUX_GPIO169__FUNC_GPIO169>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	aud_dat_mosi_on: aud-dat-mosi-on-pins {
+		pins-dat {
+			pinmux = <PINMUX_GPIO168__FUNC_AUD_DAT_MOSI0>,
+				 <PINMUX_GPIO169__FUNC_AUD_DAT_MOSI1>;
+		};
+	};
+
+	aud_dat_miso_off: aud-dat-miso-off-pins {
+		pins-dat {
+			pinmux = <PINMUX_GPIO172__FUNC_GPIO172>,
+				 <PINMUX_GPIO173__FUNC_GPIO173>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	aud_dat_miso_on: aud-dat-miso-on-pins {
+		pins-dat {
+			pinmux = <PINMUX_GPIO172__FUNC_AUD_DAT_MISO0>,
+				 <PINMUX_GPIO173__FUNC_AUD_DAT_MISO1>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+	};
+
+	aud_gpio_i2s0_off: aud-gpio-i2s0-off-pins {
+		pins-sdata {
+			pinmux = <PINMUX_GPIO3__FUNC_GPIO3>;
+		};
+	};
+
+	aud_gpio_i2s0_on: aud-gpio-i2s0-on-pins {
+		pins-sdata {
+			pinmux = <PINMUX_GPIO3__FUNC_I2S0_DI>;
+		};
+	};
+
+	aud_gpio_i2s1_off: aud-gpio-i2s-off-pins {
+		pins-clk-sdata {
+			pinmux = <PINMUX_GPIO56__FUNC_GPIO56>,
+				 <PINMUX_GPIO57__FUNC_GPIO57>,
+				 <PINMUX_GPIO58__FUNC_GPIO58>,
+				 <PINMUX_GPIO59__FUNC_GPIO59>;
+			output-low;
+		};
+	};
+
+	aud_gpio_i2s1_on: aud-gpio-i2s1-on-pins {
+		pins-clk-sdata {
+			pinmux = <PINMUX_GPIO56__FUNC_I2S1_DO>,
+				 <PINMUX_GPIO57__FUNC_I2S1_BCK>,
+				 <PINMUX_GPIO58__FUNC_I2S1_LRCK>,
+				 <PINMUX_GPIO59__FUNC_I2S1_MCK>;
+		};
+	};
+
+	aud_gpio_i2s2_off: aud-gpio-i2s2-off-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO26__FUNC_GPIO26>,
+				 <PINMUX_GPIO27__FUNC_GPIO27>;
+			output-low;
+		};
+	};
+
+	aud_gpio_i2s2_on: aud-gpio-i2s2-on-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO26__FUNC_I2S2_BCK>,
+				 <PINMUX_GPIO27__FUNC_I2S2_LRCK>;
+			drive-strength = <4>;
+		};
+	};
+
+	aud_gpio_i2s3_off: aud-gpio-i2s3-off-pins {
+		pins-sdata {
+			pinmux = <PINMUX_GPIO4__FUNC_GPIO4>;
+			output-low;
+		};
+	};
+
+	aud_gpio_i2s3_on: aud-gpio-i2s3-on-pins {
+		pins-sdata {
+			pinmux = <PINMUX_GPIO4__FUNC_I2S3_DO>;
+			drive-strength = <4>;
+		};
+	};
+
+	aud_gpio_tdm_off: aud-gpio-tdm-off-pins { };
+
+	aud_gpio_tdm_on: aud-gpio-tdm-on-pins { };
+
+	aud_gpio_pcm_off: aud-gpio-pcm-off-pins {
+		pins-clk-sdata {
+			pinmux = <PINMUX_GPIO115__FUNC_GPIO115>,
+				 <PINMUX_GPIO116__FUNC_GPIO116>,
+				 <PINMUX_GPIO117__FUNC_GPIO117>,
+				 <PINMUX_GPIO118__FUNC_GPIO118>;
+			output-low;
+		};
+	};
+
+	aud_gpio_pcm_on: aud-gpio-pcm-on-pins {
+		pins-clk-sdata {
+			pinmux = <PINMUX_GPIO115__FUNC_PCM_CLK>,
+				 <PINMUX_GPIO116__FUNC_PCM_SYNC>,
+				 <PINMUX_GPIO117__FUNC_PCM_DI>,
+				 <PINMUX_GPIO118__FUNC_PCM_DO>;
+		};
+	};
+
+	aud_gpio_dmic_sec: aud-gpio-dmic-sec-pins {
+		pins {
+			pinmux = <PINMUX_GPIO23__FUNC_GPIO23>;
+			output-low;
+		};
+	};
+
+	bt_pins_reset: bt-reset-pins {
+		pins-bt-reset {
+			pinmux = <PINMUX_GPIO155__FUNC_GPIO155>;
+			output-high;
+		};
+	};
+
+	dpi_pins_sleep: dpi-sleep-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO103__FUNC_GPIO103>,
+				 <PINMUX_GPIO104__FUNC_GPIO104>,
+				 <PINMUX_GPIO105__FUNC_GPIO105>,
+				 <PINMUX_GPIO106__FUNC_GPIO106>,
+				 <PINMUX_GPIO107__FUNC_GPIO107>,
+				 <PINMUX_GPIO108__FUNC_GPIO108>,
+				 <PINMUX_GPIO109__FUNC_GPIO109>,
+				 <PINMUX_GPIO110__FUNC_GPIO110>,
+				 <PINMUX_GPIO111__FUNC_GPIO111>,
+				 <PINMUX_GPIO112__FUNC_GPIO112>,
+				 <PINMUX_GPIO113__FUNC_GPIO113>,
+				 <PINMUX_GPIO114__FUNC_GPIO114>,
+				 <PINMUX_GPIO101__FUNC_GPIO101>,
+				 <PINMUX_GPIO100__FUNC_GPIO100>,
+				 <PINMUX_GPIO102__FUNC_GPIO102>,
+				 <PINMUX_GPIO99__FUNC_GPIO99>;
+			drive-strength = <10>;
+			output-low;
+		};
+	};
+
+	dpi_pins_default: dpi-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO103__FUNC_DPI_DATA0>,
+				 <PINMUX_GPIO104__FUNC_DPI_DATA1>,
+				 <PINMUX_GPIO105__FUNC_DPI_DATA2>,
+				 <PINMUX_GPIO106__FUNC_DPI_DATA3>,
+				 <PINMUX_GPIO107__FUNC_DPI_DATA4>,
+				 <PINMUX_GPIO108__FUNC_DPI_DATA5>,
+				 <PINMUX_GPIO109__FUNC_DPI_DATA6>,
+				 <PINMUX_GPIO110__FUNC_DPI_DATA7>,
+				 <PINMUX_GPIO111__FUNC_DPI_DATA8>,
+				 <PINMUX_GPIO112__FUNC_DPI_DATA9>,
+				 <PINMUX_GPIO113__FUNC_DPI_DATA10>,
+				 <PINMUX_GPIO114__FUNC_DPI_DATA11>,
+				 <PINMUX_GPIO101__FUNC_DPI_HSYNC>,
+				 <PINMUX_GPIO100__FUNC_DPI_VSYNC>,
+				 <PINMUX_GPIO102__FUNC_DPI_DE>,
+				 <PINMUX_GPIO99__FUNC_DPI_PCLK>;
+			drive-strength = <10>;
+		};
+	};
+
+	ec_ap_int: cros-ec-int-pins {
+		pins-ec-ap-int-odl {
+			pinmux = <PINMUX_GPIO13__FUNC_GPIO13>;
+			input-enable;
+		};
+	};
+
+	edp_panel_fixed_pins: edp-panel-fixed-pins {
+		pins-vreg-en {
+			pinmux = <PINMUX_GPIO153__FUNC_GPIO153>;
+			output-high;
+		};
+	};
+
+	en_pp1800_dpbrdg: en-pp1800-dpbrdg-pins {
+		pins-vreg-en {
+			pinmux = <PINMUX_GPIO39__FUNC_GPIO39>;
+			output-low;
+		};
+	};
+
+	gsc_int: gsc-int-pins {
+		pins-gsc-ap-int-odl {
+			pinmux = <PINMUX_GPIO15__FUNC_GPIO15>;
+			input-enable;
+		};
+	};
+
+	i2c0_pins: i2c0-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO128__FUNC_SDA0>,
+				 <PINMUX_GPIO127__FUNC_SCL0>;
+			bias-disable;
+			drive-strength = <4>;
+			input-enable;
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO130__FUNC_SDA1>,
+				 <PINMUX_GPIO129__FUNC_SCL1>;
+			bias-disable;
+			drive-strength = <4>;
+			input-enable;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO132__FUNC_SDA2>,
+				 <PINMUX_GPIO131__FUNC_SCL2>;
+			bias-disable;
+			drive-strength = <4>;
+			input-enable;
+		};
+	};
+
+	i2c3_pins: i2c3-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO134__FUNC_SDA3>,
+				 <PINMUX_GPIO133__FUNC_SCL3>;
+			bias-disable;
+			drive-strength = <4>;
+			input-enable;
+		};
+	};
+
+	i2c5_pins: i2c5-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO138__FUNC_SDA5>,
+				 <PINMUX_GPIO137__FUNC_SCL5>;
+			bias-disable;
+			drive-strength = <4>;
+			input-enable;
+		};
+	};
+
+	it6505_pins: it6505-pins {
+		pins-hpd {
+			pinmux = <PINMUX_GPIO10__FUNC_GPIO10>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-int {
+			pinmux = <PINMUX_GPIO8__FUNC_GPIO8>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-reset {
+			pinmux = <PINMUX_GPIO177__FUNC_GPIO177>;
+			output-low;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_default: mmc0-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO68__FUNC_MSDC0_CLK>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO71__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO72__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO73__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO74__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO75__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO76__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO77__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO78__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO69__FUNC_MSDC0_CMD>;
+			input-enable;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO70__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO68__FUNC_MSDC0_CLK>;
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO71__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO72__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO73__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO74__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO75__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO76__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO77__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO78__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO69__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO67__FUNC_MSDC0_DSL>;
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO70__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_pins_default: mmc1-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO84__FUNC_MSDC1_CLK>;
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO86__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO87__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO88__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO89__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO85__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO84__FUNC_MSDC1_CLK>;
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO86__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO87__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO88__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO89__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO85__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_pins_eint: mmc1-eint-pins {
+		pins-dat1 {
+			pinmux = <PINMUX_GPIO87__FUNC_GPIO87>;
+			input-enable;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	nor_pins_default: nor-default-pins {
+		pins-clk-dat {
+			pinmux = <PINMUX_GPIO63__FUNC_SPINOR_IO0>,
+				 <PINMUX_GPIO61__FUNC_SPINOR_CK>,
+				 <PINMUX_GPIO64__FUNC_SPINOR_IO1>;
+			drive-strength = <6>;
+			bias-pull-down;
+		};
+
+		pins-cs-dat {
+			pinmux = <PINMUX_GPIO62__FUNC_SPINOR_CS>,
+				 <PINMUX_GPIO65__FUNC_SPINOR_IO2>,
+				 <PINMUX_GPIO66__FUNC_SPINOR_IO3>;
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
+
+	pen_eject: pen-eject-pins {
+		pins {
+			pinmux = <PINMUX_GPIO18__FUNC_GPIO18>;
+			input-enable;
+			/* External pull-up. */
+			bias-disable;
+		};
+	};
+
+	pwm0_pin: disp-pwm-pins {
+		pins {
+			pinmux = <PINMUX_GPIO97__FUNC_DISP_PWM>;
+			output-high;
+		};
+	};
+
+	rt1019p_pins_default: rt1019p-default-pins {
+		pins-sdb {
+			pinmux = <PINMUX_GPIO150__FUNC_GPIO150>;
+			output-low;
+		};
+	};
+
+	scp_pins: scp-default-pins {
+		pins-scp-uart {
+			pinmux = <PINMUX_GPIO48__FUNC_TP_URXD2_AO>,
+				 <PINMUX_GPIO49__FUNC_TP_UTXD2_AO>;
+		};
+	};
+
+	spi1_pins: spi1-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO40__FUNC_SPI1_CLK_A>,
+				 <PINMUX_GPIO41__FUNC_SPI1_CSB_A>,
+				 <PINMUX_GPIO42__FUNC_SPI1_MO_A>,
+				 <PINMUX_GPIO43__FUNC_SPI1_MI_A>;
+			bias-disable;
+			input-enable;
+		};
+	};
+
+	spi2_pins: spi2-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO44__FUNC_SPI2_CLK_A>,
+				 <PINMUX_GPIO45__FUNC_GPIO45>,
+				 <PINMUX_GPIO46__FUNC_SPI2_MO_A>,
+				 <PINMUX_GPIO47__FUNC_SPI2_MI_A>;
+			bias-disable;
+			input-enable;
+		};
+	};
+
+	spmi_pins: spmi-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO183__FUNC_SPMI_SCL>,
+				 <PINMUX_GPIO184__FUNC_SPMI_SDA>;
+		};
+	};
+
+	touchscreen_pins: touchscreen-pins {
+		pins-irq {
+			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-reset {
+			pinmux = <PINMUX_GPIO60__FUNC_GPIO60>;
+			output-high;
+		};
+
+		pins-report-sw {
+			pinmux = <PINMUX_GPIO37__FUNC_GPIO37>;
+			output-low;
+		};
+	};
+
+	trackpad_pin: trackpad-default-pins {
+		pins-int-n {
+			pinmux = <PINMUX_GPIO11__FUNC_GPIO11>;
+			input-enable;
+			bias-disable; /* pulled externally */
+		};
+	};
+
+	wifi_enable_pin: wifi-enable-pins {
+		pins-wifi-enable {
+			pinmux = <PINMUX_GPIO54__FUNC_GPIO54>;
+		};
+	};
+
+	wifi_wakeup_pin: wifi-wakeup-pins {
+		pins-wifi-wakeup {
+			pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
+			input-enable;
+		};
+	};
+};
+
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pin>;
+	status = "okay";
+};
+
+&pwrap {
+	pmic {
+		compatible = "mediatek,mt6366", "mediatek,mt6358";
+		interrupt-controller;
+		interrupts-extended = <&pio 201 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <2>;
+
+		mt6366codec: codec {
+			compatible = "mediatek,mt6366-sound", "mediatek,mt6358-sound";
+			Avdd-supply = <&mt6366_vaud28_reg>;
+			mediatek,dmic-mode = <1>; /* one-wire */
+		};
+
+		mt6366_regulators: regulators {
+			compatible = "mediatek,mt6366-regulator", "mediatek,mt6358-regulator";
+			vsys-ldo1-supply = <&pp4200_z2>;
+			vsys-ldo2-supply = <&pp4200_z2>;
+			vsys-ldo3-supply = <&pp4200_z2>;
+			vsys-vcore-supply = <&pp4200_z2>;
+			vsys-vdram1-supply = <&pp4200_z2>;
+			vsys-vgpu-supply = <&pp4200_z2>;
+			vsys-vmodem-supply = <&pp4200_z2>;
+			vsys-vpa-supply = <&pp4200_z2>;
+			vsys-vproc11-supply = <&pp4200_z2>;
+			vsys-vproc12-supply = <&pp4200_z2>;
+			vsys-vs1-supply = <&pp4200_z2>;
+			vsys-vs2-supply = <&pp4200_z2>;
+			vs1-ldo1-supply = <&mt6366_vs1_reg>;
+			vs2-ldo1-supply = <&mt6366_vdram1_reg>;
+			vs2-ldo2-supply = <&mt6366_vs2_reg>;
+			vs2-ldo3-supply = <&mt6366_vs2_reg>;
+
+			vcore {
+				regulator-name = "pp0750_dvdd_core";
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <800000>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
+							   MT6397_BUCK_MODE_FORCE_PWM>;
+				regulator-always-on;
+			};
+
+			mt6366_vdram1_reg: vdram1 {
+				regulator-name = "pp1125_emi_vdd2";
+				regulator-min-microvolt = <1125000>;
+				regulator-max-microvolt = <1125000>;
+				regulator-ramp-delay = <12500>;
+				regulator-enable-ramp-delay = <0>;
+				regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
+							   MT6397_BUCK_MODE_FORCE_PWM>;
+				regulator-always-on;
+			};
+
+			mt6366_vgpu_reg: vgpu {
+				/*
+				 * Called "ppvar_dvdd_gpu" in the schematic.
+				 * Called "ppvar_dvdd_vgpu" here to match
+				 * regulator coupling requirements.
+				 */
+				regulator-name = "ppvar_dvdd_vgpu";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
+							   MT6397_BUCK_MODE_FORCE_PWM>;
+				regulator-coupled-with = <&mt6366_vsram_gpu_reg>;
+				regulator-coupled-max-spread = <10000>;
+			};
+
+			mt6366_vproc11_reg: vproc11 {
+				regulator-name = "ppvar_dvdd_proc_bc_mt6366";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
+							   MT6397_BUCK_MODE_FORCE_PWM>;
+				regulator-always-on;
+			};
+
+			mt6366_vproc12_reg: vproc12 {
+				regulator-name = "ppvar_dvdd_proc_lc";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
+							   MT6397_BUCK_MODE_FORCE_PWM>;
+				regulator-always-on;
+			};
+
+			mt6366_vs1_reg: vs1 {
+				regulator-name = "pp2000_vs1";
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-ramp-delay = <12500>;
+				regulator-enable-ramp-delay = <0>;
+				regulator-always-on;
+			};
+
+			mt6366_vs2_reg: vs2 {
+				regulator-name = "pp1350_vs2";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <12500>;
+				regulator-enable-ramp-delay = <0>;
+				regulator-always-on;
+			};
+
+			va12 {
+				regulator-name = "pp1200_va12";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-enable-ramp-delay = <270>;
+				regulator-always-on;
+			};
+
+			mt6366_vaud28_reg: vaud28 {
+				regulator-name = "pp2800_vaud28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vaux18_reg: vaux18 {
+				regulator-name = "pp1840_vaux18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1840000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vbif28_reg: vbif28 {
+				regulator-name = "pp2800_vbif28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vcn18_reg: vcn18 {
+				regulator-name = "pp1800_vcn18_x";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vcn28_reg: vcn28 {
+				regulator-name = "pp2800_vcn28_x";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vefuse_reg: vefuse {
+				regulator-name = "pp1800_vefuse";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vfe28_reg: vfe28 {
+				regulator-name = "pp2800_vfe28_x";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vemc_reg: vemc {
+				regulator-name = "pp3000_vemc";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vibr_reg: vibr {
+				regulator-name = "pp2800_vibr_x";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vio18_reg: vio18 {
+				regulator-name = "pp1800_vio18_s3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <2700>;
+				regulator-always-on;
+			};
+
+			mt6366_vio28_reg: vio28 {
+				regulator-name = "pp2800_vio28_x";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			mt6366_vm18_reg: vm18 {
+				regulator-name = "pp1800_emi_vdd1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1840000>;
+				regulator-enable-ramp-delay = <325>;
+				regulator-always-on;
+			};
+
+			mt6366_vmc_reg: vmc {
+				regulator-name = "pp3000_vmc";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vmddr_reg: vmddr {
+				regulator-name = "pm0750_emi_vmddr";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <750000>;
+				regulator-enable-ramp-delay = <325>;
+				regulator-always-on;
+			};
+
+			mt6366_vmch_reg: vmch {
+				regulator-name = "pp3000_vmch";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <60>;
+			};
+
+			mt6366_vcn33_reg: vcn33 {
+				regulator-name = "pp3300_vcn33_x";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+
+			vdram2 {
+				regulator-name = "pp0600_emi_vddq";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <600000>;
+				regulator-enable-ramp-delay = <3300>;
+				regulator-always-on;
+			};
+
+			mt6366_vrf12_reg: vrf12 {
+				regulator-name = "pp1200_vrf12_x";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			mt6366_vrf18_reg: vrf18 {
+				regulator-name = "pp1800_vrf18_x";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+
+			vsim1 {
+				regulator-name = "pp1860_vsim1_x";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1860000>;
+				regulator-enable-ramp-delay = <540>;
+			};
+
+			mt6366_vsim2_reg: vsim2 {
+				regulator-name = "pp2760_vsim2_x";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <2760000>;
+				regulator-enable-ramp-delay = <540>;
+			};
+
+			mt6366_vsram_gpu_reg: vsram-gpu {
+				regulator-name = "pp0900_dvdd_sram_gpu";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1050000>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-coupled-with = <&mt6366_vgpu_reg>;
+				regulator-coupled-max-spread = <10000>;
+			};
+
+			mt6366_vsram_others_reg: vsram-others {
+				regulator-name = "pp0900_dvdd_sram_core";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+
+			mt6366_vsram_proc11_reg: vsram-proc11 {
+				regulator-name = "pp0900_dvdd_sram_bc";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1120000>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+
+			mt6366_vsram_proc12_reg: vsram-proc12 {
+				regulator-name = "pp0900_dvdd_sram_lc";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1120000>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+
+			vusb {
+				regulator-name = "pp3070_vusb";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3070000>;
+				regulator-enable-ramp-delay = <270>;
+				regulator-always-on;
+			};
+
+			vxo22 {
+				regulator-name = "pp2240_vxo22";
+				regulator-min-microvolt = <2200000>;
+				regulator-max-microvolt = <2240000>;
+				regulator-enable-ramp-delay = <120>;
+				/* Feeds DCXO internally */
+				regulator-always-on;
+			};
+		};
+
+		rtc {
+			compatible = "mediatek,mt6366-rtc", "mediatek,mt6358-rtc";
+		};
+	};
+};
+
+&scp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scp_pins>;
+	firmware-name = "mediatek/mt8186/scp.img";
+	memory-region = <&scp_mem>;
+	status = "okay";
+
+	cros-ec-rpmsg {
+		compatible = "google,cros-ec-rpmsg";
+		mediatek,rpmsg-name = "cros-ec-rpmsg";
+	};
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+
+	cros_ec: ec@0 {
+		compatible = "google,cros-ec-spi";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		interrupts-extended = <&pio 13 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ec_ap_int>;
+
+		i2c_tunnel: i2c-tunnel {
+			compatible = "google,cros-ec-i2c-tunnel";
+			google,remote-bus = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		typec {
+			compatible = "google,cros-ec-typec";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb_c0: connector@0 {
+				compatible = "usb-c-connector";
+				reg = <0>;
+				label = "left";
+				power-role = "dual";
+				data-role = "host";
+				try-power-role = "source";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@1 {
+						reg = <1>;
+
+						typec_port0: endpoint { };
+					};
+				};
+			};
+
+			usb_c1: connector@1 {
+				compatible = "usb-c-connector";
+				reg = <1>;
+				label = "right";
+				power-role = "dual";
+				data-role = "host";
+				try-power-role = "source";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@1 {
+						reg = <1>;
+
+						typec_port1: endpoint { };
+					};
+				};
+			};
+		};
+	};
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins>;
+	cs-gpios = <&pio 45 GPIO_ACTIVE_LOW>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+
+	tpm@0 {
+		compatible = "google,cr50";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gsc_int>;
+		interrupt-parent = <&pio>;
+		interrupts = <15 IRQ_TYPE_EDGE_RISING>;
+	};
+};
+
+&ssusb0 {
+	status = "okay";
+};
+
+&ssusb1 {
+	status = "okay";
+};
+
+&u3phy0 {
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb_host0 {
+	vbus-supply = <&pp3300_s3>;
+	status = "okay";
+};
+
+&usb_host1 {
+	vbus-supply = <&usb_p1_vbus>;
+	status = "okay";
+	#address-cells = <2>;
+	#size-cells = <2>;
+};
+
+&watchdog {
+	mediatek,reset-by-toprgu;
+};
+
+#include <arm/cros-ec-keyboard.dtsi>
+#include <arm/cros-ec-sbs.dtsi>
-- 
2.43.0.rc2.451.g8631bc7472-goog

