Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A657DCEAC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjJaOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjJaOFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:05:51 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24C69F4;
        Tue, 31 Oct 2023 07:05:48 -0700 (PDT)
From:   Stefan Hansson <newbyte@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1698761146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VYa8DDJIOHEtmh0RgNiZ0BLPYGQGWvRMKUTkLepvPiU=;
        b=o7mJXbYNkm/rcyjF/MoGEY8/gSm99chIWb5JxWCINMRvQA9THV1Eu1D7zjQ+p3DEFDqxfE
        f66UGcX9nt+9qU+DlVaZRCW9VEaKkS05vO5TrrA7ylqto1eOmvQSgYL2c3u1lhKIlQaRah
        Wbbi6EcMphMibRnHHW58SVZKdRroFLM=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Stefan Hansson <newbyte@postmarketos.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 3/4] ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 LTE (SM-T535)
Date:   Tue, 31 Oct 2023 15:00:57 +0100
Message-ID: <20231031140337.49291-4-newbyte@postmarketos.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031140337.49291-1-newbyte@postmarketos.org>
References: <20231031140337.49291-1-newbyte@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree for the Samsung Galaxy Tab 4 10.1 (SM-T535) LTE tablet
based on the MSM8926 platform.

The common dtsi is also modified to describe the widest constraints,
which required modifications to the matisse-wifi dts.

Signed-off-by: Stefan Hansson <newbyte@postmarketos.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/Makefile               |  1 +
 .../qcom-apq8026-samsung-matisse-wifi.dts     |  8 ++++
 .../qcom-msm8226-samsung-matisse-common.dtsi  |  4 +-
 .../qcom/qcom-msm8926-samsung-matisselte.dts  | 37 +++++++++++++++++++
 4 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8926-samsung-matisselte.dts

diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
index a3d293e40820..cab35eeb30f6 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8916-samsung-serranove.dtb \
 	qcom-msm8926-microsoft-superman-lte.dtb \
 	qcom-msm8926-microsoft-tesla.dtb \
+	qcom-msm8926-samsung-matisselte.dtb \
 	qcom-msm8960-cdp.dtb \
 	qcom-msm8960-samsung-expressatt.dtb \
 	qcom-msm8974-lge-nexus5-hammerhead.dtb \
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
index b0da51f67539..3be02bdbb919 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
@@ -66,6 +66,14 @@ touchscreen@4a {
 	};
 };
 
+&pm8226_l3 {
+	regulator-max-microvolt = <1337500>;
+};
+
+&pm8226_s4 {
+	regulator-max-microvolt = <1800000>;
+};
+
 &tlmm {
 	tsp_en1_default_state: tsp-en1-default-state {
 		pins = "gpio73";
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226-samsung-matisse-common.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226-samsung-matisse-common.dtsi
index ef98d88927ca..28317ce79e97 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226-samsung-matisse-common.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226-samsung-matisse-common.dtsi
@@ -230,7 +230,7 @@ pm8226_s3: s3 {
 
 		pm8226_s4: s4 {
 			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
+			regulator-max-microvolt = <2200000>;
 		};
 
 		pm8226_s5: s5 {
@@ -250,7 +250,7 @@ pm8226_l2: l2 {
 
 		pm8226_l3: l3 {
 			regulator-min-microvolt = <750000>;
-			regulator-max-microvolt = <1337500>;
+			regulator-max-microvolt = <1350000>;
 			regulator-always-on;
 		};
 
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8926-samsung-matisselte.dts b/arch/arm/boot/dts/qcom/qcom-msm8926-samsung-matisselte.dts
new file mode 100644
index 000000000000..d0e1bc39f8ef
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8926-samsung-matisselte.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Matti Lehtimäki <matti.lehtimaki@gmail.com>
+ * Copyright (c) 2023, Stefan Hansson <newbyte@postmarketos.org>
+ */
+
+/dts-v1/;
+
+#include "qcom-msm8226-samsung-matisse-common.dtsi"
+
+/ {
+	model = "Samsung Galaxy Tab 4 10.1 LTE";
+	compatible = "samsung,matisselte", "qcom,msm8926", "qcom,msm8226";
+	chassis-type = "tablet";
+
+	reg_tsp_3p3v: regulator-tsp-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_3p3v";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 32 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tsp_en1_default_state>;
+	};
+};
+
+&tlmm {
+	tsp_en1_default_state: tsp-en1-default-state {
+		pins = "gpio32";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
-- 
2.41.0

