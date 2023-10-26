Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCE97D88D0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344712AbjJZTON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjJZTN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:13:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D021B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c87a85332bso11097285ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698347635; x=1698952435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkZn+U4Wu9+OkFBGF0q0OH+o+7fW9Y2LfpUD4qU656Q=;
        b=kYRIuMZFx6Okn+VqkPykbCsygvA6PDrXFarfMIL1uvq9xCx0d1FnSXix+X3QqkHpg5
         ESJAMdzBuIinvC51B8MRc+iH/U56JA1k+/fNXtRH5XqPPogdgZ0VbU7tedA/cElbUotP
         mvNKwYffXeGvcosmWaTTZc/x8O+8RbX3AyO/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698347635; x=1698952435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkZn+U4Wu9+OkFBGF0q0OH+o+7fW9Y2LfpUD4qU656Q=;
        b=dvskqRTg9KrDG7ebFpXRYFaUKr+93fd4y1vCtbaF6YXt/yYGDHxH1GeMD2NQH0piqp
         BXvXpSIHKZAkPEaxtmK473CD8doZMU+CMQyzNGi599WaMV2njaJDtC9dGWPxlmxalr4e
         V8PHJL0jehT0yImUBu152JFvjTfVHJvSJibrUHq/YUcAl0dOyWlHtwMb3vtL++CUNkJh
         PeJ8E1BR/D2S5idgIv9MFZ3RAndkLf+4VD3MCjwQgmzrlksQLwT/HoAm2wXBQTixc8bK
         2JgWlfkYDxz+wZJxzofk/z4x6/29V+KcH6u9ugH0O3BlHrqOEUeQMZu/93+W337jzq3f
         sklw==
X-Gm-Message-State: AOJu0YzLnf5tmq9RWjzOw830f4uQ8A3d87eTUc/f4M1kAfS408LZUFn1
        UXszkep3cgchJOsLb+g5AmxrfQ==
X-Google-Smtp-Source: AGHT+IGP4O9vPP2T8OqN76SUfejnT4iizwcqXE3U6WJq4ArhjjGIhWGRJua8zBBO7fkBTgQ/twu1gA==
X-Received: by 2002:a17:90b:3889:b0:27d:72bb:3d92 with SMTP id mu9-20020a17090b388900b0027d72bb3d92mr448994pjb.19.1698347635401;
        Thu, 26 Oct 2023 12:13:55 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:f0fe:5c3b:1d70:d0bb])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a031600b0027476c68cc3sm2183639pje.22.2023.10.26.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:13:55 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 7/7] arm64: dts: mt8183: Add jacuzzi pico/pico6 board
Date:   Thu, 26 Oct 2023 12:09:16 -0700
Message-ID: <20231026191343.3345279-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231026191343.3345279-1-hsinyi@chromium.org>
References: <20231026191343.3345279-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pico is also known as Acer Chromebook Spin 311.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt8183-kukui-jacuzzi-pico.dts    |  36 ++++++
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   | 110 ++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 1b85a8c12850..ed174dde97e1 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -34,6 +34,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kappa.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kenzo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-makomo-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-makomo-sku1.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-pico.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-pico6.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
new file mode 100644
index 000000000000..e230323b3a54
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
+
+/ {
+	model = "Google pico board";
+	chassis-type = "convertible";
+	compatible = "google,pico-sku1", "google,pico", "mediatek,mt8183";
+};
+
+&i2c_tunnel {
+	google,remote-bus = <0>;
+};
+
+&i2c2 {
+	i2c-scl-internal-delay-ns = <25000>;
+
+	trackpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		hid-descr-addr = <0x20>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
+
+		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
+
+		wakeup-source;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
new file mode 100644
index 000000000000..a2e74b829320
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-max98357a.dtsi"
+
+/ {
+	model = "Google pico6 board";
+	chassis-type = "convertible";
+	compatible = "google,pico-sku2", "google,pico", "mediatek,mt8183";
+
+	bt_wakeup: bt-wakeup {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_pins_wakeup>;
+
+		wobt {
+			label = "Wake on BT";
+			gpios = <&pio 42 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+};
+
+&i2c_tunnel {
+	google,remote-bus = <0>;
+};
+
+&i2c2 {
+	i2c-scl-internal-delay-ns = <25000>;
+
+	trackpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		hid-descr-addr = <0x20>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
+
+		interrupts-extended = <&pio 7 IRQ_TYPE_LEVEL_LOW>;
+
+		wakeup-source;
+	};
+};
+
+&wifi_wakeup {
+	wowlan {
+		gpios = <&pio 113 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&wifi_pwrseq {
+	post-power-on-delay-ms = <50>;
+
+	/* Toggle WIFI_ENABLE to reset the chip. */
+	reset-gpios = <&pio 8 GPIO_ACTIVE_LOW>;
+};
+
+&wifi_pins_pwrseq {
+	pins-wifi-enable {
+		pinmux = <PINMUX_GPIO8__FUNC_GPIO8>;
+	};
+};
+
+&mmc1_pins_default {
+	pins-cmd-dat {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+	pins-clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
+
+&mmc1_pins_uhs {
+	pins-clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
+
+&mmc1 {
+	bt_reset: bt-reset {
+		compatible = "mediatek,mt7921s-bluetooth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_pins_reset>;
+		reset-gpios = <&pio 120 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pio {
+	bt_pins_wakeup: bt-pins-wakeup {
+		piins-bt-wakeup {
+			pinmux = <PINMUX_GPIO42__FUNC_GPIO42>;
+			input-enable;
+		};
+	};
+
+	bt_pins_reset: bt-pins-reset {
+		pins-bt-reset {
+			pinmux = <PINMUX_GPIO120__FUNC_GPIO120>;
+			output-high;
+		};
+	};
+};
+
+/delete-node/ &bluetooth;
+/delete-node/ &bt_pins;
-- 
2.42.0.820.g83a721a137-goog

