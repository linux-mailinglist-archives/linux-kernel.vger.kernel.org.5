Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B501E77E898
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345468AbjHPSXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345461AbjHPSXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:23:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958F41986
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:22:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bb84194bf3so43678165ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692210178; x=1692814978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AavxYaQEPY9dU8GTHMOuzfvF8C2yZfbqDwD9ecZqf/Y=;
        b=Rv7jJw/Th5/GaDIfWDCHp5w2jn1aTtV1ApTzdN68lHRwKO67VVqilDVbh2kKFJKmEv
         UUuqhjrQ5sdAjyuisef1dIUbX23rWq8ZAZscoM2zGhJr/qPEpVJKTnxPC0TfcqDIl6wJ
         m6Qilif7tbIn/PT7AfkHSpf0nzMKgwtUWibtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692210178; x=1692814978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AavxYaQEPY9dU8GTHMOuzfvF8C2yZfbqDwD9ecZqf/Y=;
        b=YBCH+RldGSVZmSG4xR9uq17xBWTWiFEC6AdmWZBh+k7DQdEfcfY0DSgU6z8/lnUJ1n
         Kiz12A4HJSu9OwqBIgfWS9bbn6LFDwRbMPWYjSW20LM8tjVTEdY2ZWLcphSGLh7uFvGY
         vr7qtTS8cg79W7xBfW+I1lkC0YyNmbe4lQj1p5i+rHC2JB6i9C1WiJA5vtSVECPtQPpw
         Np0IrmO90UUpQTrnwGvRa1j3x62OSexkL4EGnk8cKPoVzThJDsL/BzAKypxHRcQdbBrL
         E3iTeOx/SH3AcXeRqkIojiDLOFMZ+lhSVsDijZgntRwFJAw6B2bCJuVJWrBFtoWjBu5x
         L1nQ==
X-Gm-Message-State: AOJu0YwDQOisjHUSdEEkAdTfUGKrEbCXO+9IyYUsOPaZN09Lb1mWakNM
        dYRhhi+P9v2kGtyEtTAXHoCmyQ==
X-Google-Smtp-Source: AGHT+IGvTPmZRIujQIljk/5aGfiMHaNQcMM7hE4+cTpS9LxESEUNLHPCrmRJKKfzItxnoeLLP7q30Q==
X-Received: by 2002:a17:902:ec90:b0:1b0:3df7:5992 with SMTP id x16-20020a170902ec9000b001b03df75992mr2520493plg.32.1692210177924;
        Wed, 16 Aug 2023 11:22:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:d195:f984:f71b:ed07])
        by smtp.gmail.com with ESMTPSA id x18-20020a1709027c1200b001b9ff5aa2e7sm13440155pll.239.2023.08.16.11.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 11:22:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sc7180: Move trogdor rt5682s bits to a fragment
Date:   Wed, 16 Aug 2023 11:21:53 -0700
Message-ID: <20230816112143.1.I7227efd47e0dc42b6ff243bd22aa1a3e01923220@changeid>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several trogdor boards have moved from the older rt5862i to the newer
rt5862s, at least on newer revisions of boards. Let's get rid of the
dts duplication across boards and promote this to a fragment.

Note: The old boards used to override the "compatible" in the "sound"
node with the exact same thing that was in "sc7180-trogdor.dtsi"
("google,sc7180-trogdor"). I got rid of that.

This is validated to produce the same result when taking the dtbs
generated by the kernel build and then doing:

  for dtb in *trogdor*.dtb; do
    dtc -I dtb -O dts $dtb -o out/$dtb.dts;
  done

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../boot/dts/qcom/sc7180-trogdor-kingoftown.dts | 13 +------------
 .../dts/qcom/sc7180-trogdor-pazquel360.dtsi     | 13 +------------
 .../dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi    | 17 +++++++++++++++++
 ...180-trogdor-wormdingler-rev1-boe-rt5682s.dts | 13 +------------
 ...180-trogdor-wormdingler-rev1-inx-rt5682s.dts | 13 +------------
 5 files changed, 21 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
index 36326ef972dc..d6db7d83adcf 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
@@ -11,19 +11,13 @@
 #include "sc7180-trogdor-parade-ps8640.dtsi"
 #include <arm/cros-ec-keyboard.dtsi>
 #include "sc7180-trogdor-lte-sku.dtsi"
+#include "sc7180-trogdor-rt5682s-sku.dtsi"
 
 / {
 	model = "Google Kingoftown";
 	compatible = "google,kingoftown", "qcom,sc7180";
 };
 
-&alc5682 {
-	compatible = "realtek,rt5682s";
-	/delete-property/ VBAT-supply;
-	realtek,dmic1-clk-pin = <2>;
-	realtek,dmic-clk-rate-hz = <2048000>;
-};
-
 &ap_tp_i2c {
 	status = "okay";
 };
@@ -84,11 +78,6 @@ &pp3300_dx_edp {
 	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
 };
 
-&sound {
-	compatible = "google,sc7180-trogdor";
-	model = "sc7180-rt5682s-max98357a-1mic";
-};
-
 &wifi {
 	qcom,ath10k-calibration-variant = "GO_KINGOFTOWN";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
index 273e2249f018..89034b6702f4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
@@ -7,13 +7,7 @@
 
 /* This file must be included after sc7180-trogdor.dtsi */
 #include "sc7180-trogdor-pazquel.dtsi"
-
-&alc5682 {
-	compatible = "realtek,rt5682s";
-	realtek,dmic1-clk-pin = <2>;
-	realtek,dmic-clk-rate-hz = <2048000>;
-	/delete-property/ VBAT-supply;
-};
+#include "sc7180-trogdor-rt5682s-sku.dtsi"
 
 ap_ts_pen_1v8: &i2c4 {
 	clock-frequency = <400000>;
@@ -64,11 +58,6 @@ CROS_STD_MAIN_KEYMAP
 	>;
 };
 
-&sound {
-	compatible = "google,sc7180-trogdor";
-	model = "sc7180-rt5682s-max98357a-1mic";
-};
-
 &wifi {
 	qcom,ath10k-calibration-variant = "GO_PAZQUEL360";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi
new file mode 100644
index 000000000000..66b8773309d4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-rt5682s-sku.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Trogdor dts fragment for SKUs with
+ *
+ * Copyright 2023 Google LLC.
+ */
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
index 6225ab8329c3..842f07f16ed1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
@@ -11,20 +11,9 @@
 /dts-v1/;
 
 #include "sc7180-trogdor-wormdingler-rev1-boe.dts"
+#include "sc7180-trogdor-rt5682s-sku.dtsi"
 
 / {
 	model = "Google Wormdingler rev1+ (BOE, rt5682s)";
 	compatible = "google,wormdingler-sku1025", "qcom,sc7180";
 };
-
-&alc5682 {
-	compatible = "realtek,rt5682s";
-	/delete-property/ VBAT-supply;
-	realtek,dmic1-clk-pin = <2>;
-	realtek,dmic-clk-rate-hz = <2048000>;
-};
-
-&sound {
-	compatible = "google,sc7180-trogdor";
-	model = "sc7180-rt5682s-max98357a-1mic";
-};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
index b40b068dad6a..084870323606 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
@@ -11,20 +11,9 @@
 /dts-v1/;
 
 #include "sc7180-trogdor-wormdingler-rev1-inx.dts"
+#include "sc7180-trogdor-rt5682s-sku.dtsi"
 
 / {
 	model = "Google Wormdingler rev1+ (INX, rt5682s)";
 	compatible = "google,wormdingler-sku1", "qcom,sc7180";
 };
-
-&alc5682 {
-	compatible = "realtek,rt5682s";
-	/delete-property/ VBAT-supply;
-	realtek,dmic1-clk-pin = <2>;
-	realtek,dmic-clk-rate-hz = <2048000>;
-};
-
-&sound {
-	compatible = "google,sc7180-trogdor";
-	model = "sc7180-rt5682s-max98357a-1mic";
-};
-- 
2.41.0.694.ge786442a9b-goog

