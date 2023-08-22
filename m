Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CC2783D87
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjHVKER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbjHVKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:04:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D70CDB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:04:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf095e1becso7719585ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1692698651; x=1693303451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2liHGnZ6WhCsCTEPPeyDpLR5DjUMU+Qgp6w0/TwpXWY=;
        b=ZVzxBI9b3S/I7nGRghgeH6UvXsNdDj2RFw0utbCIQTQbyjfqUaUrVqU5KSfy4iSUQ/
         SktnZJkag2sFGaSSWC7xwMWh+buJ3oeJPTA6vI/ucIQDDkuYliP97zzWGmIM6zRmHLEt
         EtklBoHYwG0ckFG7MSqP4eTcnXVN1N1NfCqxp7oEiV8Yu+EGarJLaLA77mRro8FY0FO2
         wB1KS89kumZ1qPh+G2IUPHTmcxmxZ3PVRLB1DTBgCWUHEQe/t/5SL7hNnSdd5hMuaPWX
         KxBbk8hPCDK9D7sn57NwYURrvBmlM4O5bj2L0mfcKVImdx0XJ4hVHAWLMOl98X+3pLGA
         LTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692698651; x=1693303451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2liHGnZ6WhCsCTEPPeyDpLR5DjUMU+Qgp6w0/TwpXWY=;
        b=Gc9a76BAeIPoJUSLqWWW1xdHhrOov3qKOJ9czuDgjstGAY66cNXQxSYwVT5sy4Zg9J
         2FLbzUQfAFdzY1zWkY32en4kNH6yfqolCmj1ED5L615r1JcypTBhiGF+Sl83gyDSjQMT
         cQQRMCnYzUiUsb0R6YhgDf3KovQn8+Y2Q5WeHkACKIzGomDaQ58TDRcc+8rsMBJkuOVD
         /gkWBwrkFjRMTx9PbX0fRn9r6CTqbFte1rqFhy2lsL0Cl36cCscTXbzQzcfgDT0DUXSu
         LDtuDVV0dZlI3LTByjBmGGU1Q5Y9moIc1pIIh9jfPAwjp0/N/A4JOc2Bb8mVI9X54ukv
         HDGg==
X-Gm-Message-State: AOJu0YzqUPu3zDCDevUTJDnZTNEYsleWyTC07aj1uYSOikrU46fpvCSv
        3DawbVj1WCQL9j2vT5PEoOeM6oadUqYuXJRDFgxNFQ==
X-Google-Smtp-Source: AGHT+IE5FwbP8mHyM6AkIXQDcqMT/He2/tTzOg9/aLhrPjms6oHbcVJdwHEPPT3JIndaGTNqzXEKPw==
X-Received: by 2002:a17:902:ea04:b0:1b8:811:b079 with SMTP id s4-20020a170902ea0400b001b80811b079mr10270400plg.0.1692698651355;
        Tue, 22 Aug 2023 03:04:11 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id jc9-20020a17090325c900b001bbb22652a4sm8663176plb.226.2023.08.22.03.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 03:04:11 -0700 (PDT)
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
Subject: [PATCH v5 2/2] arm64: dts: qcom: sc7180: Add sku_id and board id for lazor/limozeen
Date:   Tue, 22 Aug 2023 18:03:58 +0800
Message-Id: <20230822180054.v5.2.I8f20fdfe34a2e8a38373bbd65587754b324f3dcb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822100359.124282-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20230822100359.124282-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SKU ID 10: Lazor LTE+Wifi, no-esim (Strapped 0 X 0)
SKU ID 15: Limozeen LTE+Wifi, TS, no esim (Strapped 1 X 0)
SKU ID 18: Limozeen LTE+Wifi, no TS, no esim (Strapped X 0 0)

Even though the "no esim" boards are strapped differently than
ones that have an esim, the esim isn't represented in the
device tree so the same device tree can be used for LTE w/ esim
and LTE w/out esim.

add BRD_ID(0, Z, 0) = 10 for new board with ALC5682i-VS

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

Changes in v5:
- include rt5682s node for new board version 10

Changes in v4:
- combine pathc2 and patch3

Changes in v3:
- sort out the node order alphabetically

Changes in v2:
- add new entry rev9 with Parade bridge chip
- correct newly create dts files

 arch/arm64/boot/dts/qcom/Makefile             |  5 +++
 ...sc7180-trogdor-lazor-limozeen-nots-r10.dts | 29 ++++++++++++
 .../sc7180-trogdor-lazor-limozeen-nots-r9.dts |  4 +-
 .../sc7180-trogdor-lazor-limozeen-r10.dts     | 45 +++++++++++++++++++
 .../qcom/sc7180-trogdor-lazor-limozeen-r9.dts |  4 +-
 .../dts/qcom/sc7180-trogdor-lazor-r10-kb.dts  | 23 ++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r10-lte.dts | 27 +++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r10.dts     | 19 ++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r9-kb.dts   |  4 +-
 .../dts/qcom/sc7180-trogdor-lazor-r9-lte.dts  |  4 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r9.dts |  4 +-
 11 files changed, 158 insertions(+), 10 deletions(-)
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
index 000000000000..943f267a5586
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor Limozeen board device tree source
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682s-sku.dtsi"
+
+/ {
+	model = "Google Lazor Limozeen without Touchscreen (rev10+)";
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
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
index 400f9e18977f..88451935174e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts
@@ -14,8 +14,8 @@
 #include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
-	model = "Google Lazor Limozeen without Touchscreen (rev9+)";
-	compatible = "google,lazor-sku6", "qcom,sc7180";
+	model = "Google Lazor Limozeen without Touchscreen (rev9)";
+	compatible = "google,lazor-rev9-sku6", "google,lazor-rev9-sku18", "qcom,sc7180";
 };
 
 /delete-node/&ap_ts;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
new file mode 100644
index 000000000000..d77376892f20
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor Limozeen board device tree source
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682s-sku.dtsi"
+
+/ {
+	model = "Google Lazor Limozeen (rev10+)";
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
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
index 09a4ff13f072..76a76b8c0268 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dts
@@ -14,8 +14,8 @@
 #include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
-	model = "Google Lazor Limozeen (rev9+)";
-	compatible = "google,lazor-sku4", "qcom,sc7180";
+	model = "Google Lazor Limozeen (rev9)";
+	compatible = "google,lazor-rev9-sku4", "google,lazor-rev9-sku15", "qcom,sc7180";
 };
 
 /delete-node/&ap_ts;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
new file mode 100644
index 000000000000..45d34718a1bc
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
+#include "sc7180-trogdor-rt5682s-sku.dtsi"
+
+/ {
+	model = "Google Lazor (rev10+) with KB Backlight";
+	compatible = "google,lazor-sku2", "qcom,sc7180";
+};
+
+&keyboard_backlight {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
new file mode 100644
index 000000000000..79028d0dd1b0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682s-sku.dtsi"
+
+/ {
+	model = "Google Lazor (rev10+) with LTE";
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
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
new file mode 100644
index 000000000000..045827341ea0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Lazor board device tree source
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-lazor.dtsi"
+#include "sc7180-lite.dtsi"
+#include "sc7180-trogdor-rt5682s-sku.dtsi"
+
+/ {
+	model = "Google Lazor (rev10+)";
+	compatible = "google,lazor", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
index 1c4f0773a242..cabe99c23a7c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts
@@ -14,8 +14,8 @@
 #include "sc7180-lite.dtsi"
 
 / {
-	model = "Google Lazor (rev9+) with KB Backlight";
-	compatible = "google,lazor-sku2", "qcom,sc7180";
+	model = "Google Lazor (rev9) with KB Backlight";
+	compatible = "google,lazor-rev9-sku2", "qcom,sc7180";;
 };
 
 &keyboard_backlight {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
index ec73943abc4c..d737fd0637fb 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
@@ -14,8 +14,8 @@
 #include "sc7180-trogdor-rt5682i-sku.dtsi"
 
 / {
-	model = "Google Lazor (rev9+) with LTE";
-	compatible = "google,lazor-sku0", "qcom,sc7180";
+	model = "Google Lazor (rev9) with LTE";
+	compatible = "google,lazor-rev9-sku0", "google,lazor-rev9-sku10", "qcom,sc7180";
 };
 
 &ap_sar_sensor_i2c {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
index 6cedc0ba9653..8daad32ff53b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dts
@@ -14,6 +14,6 @@
 #include "sc7180-lite.dtsi"
 
 / {
-	model = "Google Lazor (rev9+)";
-	compatible = "google,lazor", "qcom,sc7180";
+	model = "Google Lazor (rev9)";
+	compatible = "google,lazor-rev9", "qcom,sc7180";
 };
-- 
2.34.1

