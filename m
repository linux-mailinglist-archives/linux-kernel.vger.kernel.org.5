Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0377769E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjHIUYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjHIUYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:24:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88675210D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:23:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so1325575e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691612638; x=1692217438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZtKCQh6Ef5pxnqhFlCIGhUnRvvp+P2JAi3dlzqJBVk=;
        b=kET5HhM/6IcZaz7YNMsrN4bXEOgTgRtDVDWfX9itoMJ8ijMH2VZASLDT5AhXRVghNG
         7ErFLmcbowwvBoxGCZexgsfC2aDQuefwLYbYnSddAdZ59IHncfjh94F9l7X7spBQ9vDS
         UTzIhx2iaB+LWDdZcmD5L9WJko4j9g6eyThWNjjBYNRAB8hoiktpbGh6V/SzeiRTwsIi
         oQV1SR5thLg+FMZ6cWRCs8W05hjVIT5baEfqMLOOFe9vtc1Z+yvsOxQ2Ms486x9bmcY5
         DfEM/pdilgKbDahSAtbGFMAFBr3aFPjtyfjD49oumxeRyj9Dc8oTdGBU2yZPRlG+B0rd
         MgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691612638; x=1692217438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZtKCQh6Ef5pxnqhFlCIGhUnRvvp+P2JAi3dlzqJBVk=;
        b=D6XbUGvXVXDq4oA+ioz3C87ijMfb5+H32iRERIYEkjgIZ7sIF4M7sUbPQw7PDKXDui
         y7Lf07GVfGMOQNflbTlIXUS3pP0RUL1BSdc+XvNUTMgd/GnzMksW2sULf8Tm8ucUwITD
         je73ZzcnReej0j7+0AMlRwU7E3cHw99Ne+V0S1cPHOjuO3UBhEryO7zdIDfSl35zUOB2
         GXOqhyQ/0u7XXHiaZQ2R5k5QiUfbuwAYagAtKGg6Z/cWvgzjiLsKTO7tGY7J1nJKLtSG
         2WV1fo6ZjhB92IE6vZAoQd9I3euWmSrTE6eJ4w5DR/f0kc26LgGoNHUlBU5ITDZUBfqB
         MSQA==
X-Gm-Message-State: AOJu0YwjAnSccGN8oOr53yb2DZxCU5vsPl0N8rhIeykCZr81Akw/QgUf
        YYdQ+ZIuiSYLcgMH2YjpFR4Pbg==
X-Google-Smtp-Source: AGHT+IGly/zzwOlVaKid6HKD9uqApqVbmI8daJmbfjwS9LHzjTN8/HyjvkCfh+mchlxDhFJig2CEpg==
X-Received: by 2002:a05:600c:ace:b0:3fe:21b9:806 with SMTP id c14-20020a05600c0ace00b003fe21b90806mr226444wmr.0.1691612637866;
        Wed, 09 Aug 2023 13:23:57 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c22ce00b003fba2734f1esm2927509wmg.1.2023.08.09.13.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:23:57 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, loic.poulain@linaro.org, rfoss@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v2 5/6] arm64: dts: qcom: apq8016-sbc-d3-camera-mezzanine: Move default ov5640 to a standalone dts
Date:   Wed,  9 Aug 2023 21:23:42 +0100
Message-Id: <20230809202343.1098425-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809202343.1098425-1-bryan.odonoghue@linaro.org>
References: <20230809202343.1098425-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment we define a single ov5640 sensor in the apq8016-sbc and
disable that sensor.

The sensor mezzanine for this is a D3 Engineering Dual ov5640 mezzanine
card. Move the definition from the apq8016-sbc where it shouldn't be to a
standalone dts.

Enables the sensor by default, as we are adding a standalone mezzanine
structure.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../qcom/apq8016-sbc-d3-camera-mezzanine.dts  | 55 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 49 -----------------
 3 files changed, 56 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f15548dbfa56e..19016765ba4c6 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3-camera-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
new file mode 100644
index 0000000000000..ef0e76e424898
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+/dts-v1/;
+
+#include "apq8016-sbc.dts"
+
+&camss {
+	status = "okay";
+
+	ports {
+		port@0 {
+			reg = <0>;
+			csiphy0_ep: endpoint {
+				data-lanes = <0 2>;
+				remote-endpoint = <&ov5640_ep>;
+				status = "okay";
+			};
+		};
+	};
+};
+
+&cci {
+	status = "okay";
+};
+
+&cci_i2c0 {
+	camera_rear@3b {
+		compatible = "ovti,ov5640";
+		reg = <0x3b>;
+
+		powerdown-gpios = <&tlmm 34 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&camera_rear_default>;
+
+		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
+		clock-names = "xclk";
+		assigned-clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
+		assigned-clock-rates = <23880000>;
+
+		DOVDD-supply = <&camera_vdddo_1v8>;
+		AVDD-supply = <&camera_vdda_2v8>;
+		DVDD-supply = <&camera_vddd_1v5>;
+
+		port {
+			ov5640_ep: endpoint {
+				data-lanes = <1 2>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index ddb19709a9eee..84641925f3329 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -250,55 +250,6 @@ &blsp_uart2 {
 	label = "LS-UART1";
 };
 
-&camss {
-	status = "okay";
-	ports {
-		port@0 {
-			reg = <0>;
-			csiphy0_ep: endpoint {
-				data-lanes = <0 2>;
-				remote-endpoint = <&ov5640_ep>;
-				status = "okay";
-			};
-		};
-	};
-};
-
-&cci {
-	status = "okay";
-};
-
-&cci_i2c0 {
-	camera_rear@3b {
-		compatible = "ovti,ov5640";
-		reg = <0x3b>;
-
-		powerdown-gpios = <&tlmm 34 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&camera_rear_default>;
-
-		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
-		clock-names = "xclk";
-		assigned-clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
-		assigned-clock-rates = <23880000>;
-
-		DOVDD-supply = <&camera_vdddo_1v8>;
-		AVDD-supply = <&camera_vdda_2v8>;
-		DVDD-supply = <&camera_vddd_1v5>;
-
-		/* No camera mezzanine by default */
-		status = "disabled";
-
-		port {
-			ov5640_ep: endpoint {
-				data-lanes = <1 2>;
-				remote-endpoint = <&csiphy0_ep>;
-			};
-		};
-	};
-};
-
 &lpass {
 	status = "okay";
 };
-- 
2.39.2

