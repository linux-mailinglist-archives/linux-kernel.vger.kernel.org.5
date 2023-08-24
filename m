Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2FB786C73
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbjHXJ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240784AbjHXJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:59:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156FC19A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:59:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50098cc8967so2275566e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692871140; x=1693475940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJpfYRgKZJ1m6qXhMS4xJKuQv/3eN0I4OwvdILv7FHk=;
        b=VCsy1QOn/X9qGaCEKD5ovkYRhdHK/vjK9rDcbVqFhwkjvB7eyRm6FcmGC3cQoMYZRm
         tN74nu0BztFi00Em0qEJIIHwX3K4XQK0W+Diog+yw1zpgeRD1EuTMzS6hA6lqAYCs4yG
         pqo5BHt3Fg1Y3T7XCNOYQ5s2Rx1526z3B8qsDOnw086Gnmp0rZOeEza4A5oniwws4/ro
         1REtVtkol8QyGppbLep94xdrtds9rFDmb22Bo3nznyRFFGoyJ3Le4L35KxnKWwb6zuC0
         N7oMbdaKRCdf5DvpgNFuvzL6e9CQCzS9PLroAO7NSIbfuhh7xb+lPOdp8TovBVIDgDoi
         ywBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692871140; x=1693475940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJpfYRgKZJ1m6qXhMS4xJKuQv/3eN0I4OwvdILv7FHk=;
        b=i+s3KajUFqE48b9bee0WPfSmfIVHgmMjPDxMZkojRs8MTRVlgFMFGg3uigE6TIKPqY
         DQfptQnubu288nkjv5zit6gX7RzvrSSEyP3mrHW2SqowdYMhgcUUKUiFhEAMhK/QOiAM
         +Ad31nkF0YAJePA5qWuvwRRaC04dSLsYHnliPkNMBfM4Pu8/S4F+OPpYx7zrFYwn94k3
         SyBNrRe/jVHXpLyb4Eotj47octlIAD6aq7qWXl9C2ISlshpkH7CsvdEC8BNi/uwEXeRw
         TjrXgv/nZ0w/I7SEA7f6G8bs8vNqTBktBZpR9vT30XS51n0Memm2ex/3GR5dRr/qxwno
         Jw2g==
X-Gm-Message-State: AOJu0Yyg2PmgamLyl1buEykohc82noH/6am9hA+42zjG3sw9Oq9YWW4m
        wDo+e/HHRrr0q3Dd2XIWitzwOg==
X-Google-Smtp-Source: AGHT+IFAHH7AuS9bTrFHe4m8PM8Ol77p2373uTrhYZxrCBXmWSlIb+Hjylqxt2CaYaKNdkO/5dBByw==
X-Received: by 2002:a05:6512:1594:b0:500:9b26:9760 with SMTP id bp20-20020a056512159400b005009b269760mr2783160lfb.13.1692871140446;
        Thu, 24 Aug 2023 02:59:00 -0700 (PDT)
Received: from [10.167.154.1] ([2a00:f41:4882:ba34:4490:938b:eab4:c5ef])
        by smtp.gmail.com with ESMTPSA id y2-20020a197502000000b0050096712dc8sm712301lfe.277.2023.08.24.02.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 02:59:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 24 Aug 2023 11:58:54 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: sdm845-tama: Add camera GPIO
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-topic-tama_gpio-v1-3-014e9d198dce@linaro.org>
References: <20230824-topic-tama_gpio-v1-0-014e9d198dce@linaro.org>
In-Reply-To: <20230824-topic-tama_gpio-v1-0-014e9d198dce@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692871134; l=2596;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9Sh6/BNCkUcyih+fbYMiKEBA1FoWVsTp80dXXNG2QJE=;
 b=eLCmC+l0hzDNKNnZLdRG0XX1gLOa78hP/vqNv3YVjzBJyaGBk0LRPFLljG7oQ1dGuGmMJf9Ud
 sVwXlEiRtCbAqiOGlyhj/yimF5MjFac3GH0ZNa7Lu0x8VljxSDg5yy3
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like on many other platforms, Tama devices utilize lots of GPIO-
enabled regulators for the camera sensors. Define them in the DT.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 430857233967..b02a1dc5fecd 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -67,6 +67,36 @@ key-volume-up {
 		};
 	};
 
+	cam_vana_front_vreg: cam-vana-front-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "cam_vana_front_vreg";
+		gpio = <&tlmm 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&chat_cam_pwr_en>;
+		pinctrl-names = "default";
+	};
+
+	cam_vana_rear_vreg: cam-vana-rear-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "cam_vana_rear_vreg";
+		gpio = <&tlmm 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&main_cam_pwr_en>;
+		pinctrl-names = "default";
+	};
+
+	cam_vio_vreg: cam-vio-reagulator {
+		compatible = "regulator-fixed";
+		regulator-name = "cam_vio_vreg";
+		gpio = <&pmi8998_gpios 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&cam_io_en>;
+		pinctrl-names = "default";
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -592,6 +622,17 @@ snapshot_n: snapshot-n-state {
 	};
 };
 
+&pmi8998_gpios {
+	cam_io_en: cam-io-en-state {
+		pins = "gpio12";
+		function = "normal";
+		qcom,drive-strength = <3>;
+		power-source = <0>;
+		drive-push-pull;
+		output-low;
+	};
+};
+
 &pmi8998_wled {
 	default-brightness = <800>;
 	qcom,switching-freq = <800>;
@@ -660,6 +701,14 @@ sde_dsi_sleep: sde-dsi-sleep-state {
 		bias-pull-down;
 	};
 
+	chat_cam_pwr_en: chat-cam-pwr-en-state {
+		pins = "gpio8";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	sde_te_active_sleep: sde-te-active-sleep-state {
 		pins = "gpio10";
 		function = "mdp_vsync";
@@ -667,6 +716,14 @@ sde_te_active_sleep: sde-te-active-sleep-state {
 		bias-pull-down;
 	};
 
+	main_cam_pwr_en: main-cam-pwr-en-state {
+		pins = "gpio27";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	ts_default: ts-default-state {
 		reset-pins {
 			pins = "gpio99";

-- 
2.42.0

