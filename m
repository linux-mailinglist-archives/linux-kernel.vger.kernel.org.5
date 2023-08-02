Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056DB76CA2F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjHBJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjHBJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:58:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C1930F3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:58:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6872c60b572so888041b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1690970303; x=1691575103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg9EXzX1kgewsMwOeFC+vrgOSvue4qj7vUYgXfqrEs0=;
        b=0H5bE/ffijlHRbJEhOlAQwMiD0MCm1wQyA9riw/Cl1cWxGSZCA2IMCmk7LQzzgwiux
         ZFxIw7oBoPzMu1EDnOrLIHNUHzCfjwce5gQVSFUYcJdpVtj36HUXy5wIOq5Yh6F5EEv4
         LB9Kirr9Adpg174gE3N4pkb30/vvX7z49cic2BZjXaPGM7v+2wTWyKFNy2rhrxZWsHo4
         rj0yM3QlCE3l1kZYEvbrRc6XxWBBSCvLI8HpcLubQWJWu8hj2NHnDsRBRpkKt4QVc8G+
         Gb4RoE1/TI9K8bjJHTvk63V91Ch3AaaMw/K4yB5a9A1Kbanzcd7sEkqoE7ovIFkObPmK
         KS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690970303; x=1691575103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg9EXzX1kgewsMwOeFC+vrgOSvue4qj7vUYgXfqrEs0=;
        b=l8m5XnhC87Gnw8oDBNN+dsyqpF6Ar/yGlD4Ybl/m4lch+gGWAqvWdD5lgxRwXT3FBv
         mWp9jGXuVVXA1jEgRypocTNluTFc/Vx8X+W2SIhxYue/w1Fsy6TJzpI8D5ewYDL16RxV
         9Tft1uSE/YLO4rDrDfrgj8IoWGtSdchTtWwpST62nt0+HHqxstdeyQfoFoTSpOSIXjA+
         BPkhT+eqJdwMYRzmEEp8BhsAk+l1GHfZ5UIv5O7LIHogNDXNzlnhJbfd/zjZUwAEYDkS
         vr8atftEIy0p+AQt3v8mUS8YRcuqYYdSdR+dOoc3ZDc65gLXBSnMVLibVruzH2iWIerB
         qLkA==
X-Gm-Message-State: ABy/qLYAMT6qHCDBbwkZP2DdRNYT9l5FOYQjAp3kmzla82oH/80Ifirj
        KV3Y2cV0HJyqdlFT4ByfGi25SZIwXSrJx0QL4FfiTQ==
X-Google-Smtp-Source: APBJJlGzM9Bn7zEEXu6vCs/8tcvID0v0Gt45w+1nAqoCyc1LJZPIwuv08GJrUzSAm4FneUXIijOJIA==
X-Received: by 2002:a05:6a21:3385:b0:13e:1d49:7249 with SMTP id yy5-20020a056a21338500b0013e1d497249mr8844632pzb.2.1690970303573;
        Wed, 02 Aug 2023 02:58:23 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id m11-20020aa7900b000000b00686f048bb9dsm10742544pfo.74.2023.08.02.02.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:58:23 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: Add board id for lazor/limozeen
Date:   Wed,  2 Aug 2023 17:57:53 +0800
Message-Id: <20230802175628.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802095753.13644-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20230802095753.13644-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add BRD_ID(0, Z, 0) = 10 for new board with ALC5682i-VS

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

 arch/arm64/boot/dts/qcom/Makefile             |  5 ++
 ...sc7180-trogdor-lazor-limozeen-nots-r10.dts | 39 +++++++++++++
 .../sc7180-trogdor-lazor-limozeen-nots-r9.dts |  4 +-
 .../sc7180-trogdor-lazor-limozeen-r10.dts     | 55 +++++++++++++++++++
 .../qcom/sc7180-trogdor-lazor-limozeen-r9.dts |  4 +-
 .../dts/qcom/sc7180-trogdor-lazor-r10-kb.dts  | 33 +++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r10-lte.dts | 37 +++++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r10.dts     | 29 ++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r9-kb.dts   |  4 +-
 .../dts/qcom/sc7180-trogdor-lazor-r9-lte.dts  |  4 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r9.dts |  4 +-
 11 files changed, 208 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 337abc4ceb17..73e745fb1ff0 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -109,11 +109,16 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-kb.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10-kb.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r9.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r10.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r9.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r10.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-parade.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-ti.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-parade.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
new file mode 100644
index 000000000000..63602feceea6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor Limozeen board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Lazor Limozeen without Touchscreen (rev10+, rt5682s)";
+	compatible = "google,lazor-sku6", "google,lazor-sku18", "qcom,sc7180";
+};
+
+/delete-node/&ap_ts;
+
+&panel {
+	compatible = "edp-panel";
+};
+
+&sdhc_2 {
+	status = "okay";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
index cef57c15b70b..e3f1f30a7fc3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
@@ -13,8 +13,8 @@
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
-	model = "Google Lazor Limozeen without Touchscreen (rev9+)";
-	compatible = "google,lazor-sku6", "google,lazor-sku18", "qcom,sc7180";
+	model = "Google Lazor Limozeen without Touchscreen (rev9)";
+	compatible = "google,lazor-rev9-sku6", "google,lazor-rev9-sku18", "qcom,sc7180";
 };
 
 /delete-node/&ap_ts;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
new file mode 100644
index 000000000000..d0395a4b5cbb
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor Limozeen board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Lazor Limozeen (rev10+, rt5682s)";
+	compatible = "google,lazor-sku4", "google,lazor-sku15", "qcom,sc7180";
+};
+
+/delete-node/&ap_ts;
+
+&ap_ts_pen_1v8 {
+	ap_ts: touchscreen@10 {
+		compatible = "elan,ekth3500";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+		vcc33-supply = <&pp3300_ts>;
+
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&panel {
+	compatible = "auo,b116xa01";
+};
+
+&sdhc_2 {
+	status = "okay";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
index 2038a82bc0e7..3b6053f3e62b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
@@ -13,8 +13,8 @@
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
-	model = "Google Lazor Limozeen (rev9+)";
-	compatible = "google,lazor-sku4", "google,lazor-sku15", "qcom,sc7180";
+	model = "Google Lazor Limozeen (rev9)";
+	compatible = "google,lazor-rev9-sku4", "google,lazor-rev9-sku15", "qcom,sc7180";
 };
 
 /delete-node/&ap_ts;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
new file mode 100644
index 000000000000..26e5cfcd00fe
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2020 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
+
+/ {
+	model = "Google Lazor (rev10+, rt5682s) with KB Backlight";
+	compatible = "google,lazor-sku2", "qcom,sc7180";
+};
+
+&keyboard_backlight {
+	status = "okay";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
new file mode 100644
index 000000000000..026460ce3893
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Lazor (rev10+, rt5682s) with LTE";
+	compatible = "google,lazor-sku0", "google,lazor-sku10", "qcom,sc7180";
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
+
+&keyboard_backlight {
+	status = "okay";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
new file mode 100644
index 000000000000..40f618da3c7a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
+
+/ {
+	model = "Google Lazor (rev10+, rt5682s)";
+	compatible = "google,lazor", "qcom,sc7180";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
index 960f7b7ce094..f74a1985cac6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
@@ -13,8 +13,8 @@
 #include "sc7180-lite.dtsi"
 
 / {
-	model = "Google Lazor (rev9+) with KB Backlight";
-	compatible = "google,lazor-sku2", "qcom,sc7180";
+	model = "Google Lazor (rev9) with KB Backlight";
+	compatible = "google,lazor-rev9-sku2", "qcom,sc7180";
 };
 
 &keyboard_backlight {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
index 438ab9cd3389..15dcf95da311 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
@@ -13,8 +13,8 @@
 #include "sc7180-trogdor-lte-sku.dtsi"
 
 / {
-	model = "Google Lazor (rev9+) with LTE";
-	compatible = "google,lazor-sku0", "google,lazor-sku10", "qcom,sc7180";
+	model = "Google Lazor (rev9) with LTE";
+	compatible = "google,lazor-rev9-sku0", "google,lazor-rev9-sku10", "qcom,sc7180";
 };
 
 &ap_sar_sensor_i2c {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
index 56dd222650d3..44f61bc56f81 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
@@ -13,6 +13,6 @@
 #include "sc7180-lite.dtsi"
 
 / {
-	model = "Google Lazor (rev9+)";
-	compatible = "google,lazor", "qcom,sc7180";
+	model = "Google Lazor (rev9)";
+	compatible = "google,lazor-rev9", "qcom,sc7180";
 };
-- 
2.34.1

