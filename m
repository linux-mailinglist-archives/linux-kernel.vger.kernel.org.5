Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD65078DFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbjH3T0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbjH3J6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:58:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D34BCDB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:58:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c1f6f3884so679564466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693389524; x=1693994324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xX0/yXPE7aSISxZJn2hMtArfZI0yA7qiHLxVlnkrZys=;
        b=Y9hZ7+A5HiT8beas78k26hVgAAx9719kCV2QlhX19KYdRzG9zrKvsU19WL/ynr8dIE
         U1mAOwqVauz8S1QiuPXTRb+njFq4RA6N2kB0EdhQDcDQgjDtf9BooH+BQVH+glzIQwsn
         n0ozbiUvrHusuS9jfrfumr3wcG9ZatSBoTPrTuBu89QLdFtWGknzGHhsJ3NyaE80HHhX
         4S9BshQ5aIAddvff+/JNz/4akqpbWGW9o0WYzrisx8L55rFsx7TFYnkeP8rVjnLI7Hrb
         MA5eghZQ3AOlx1QFyzwzPsH6N4gj3UUotdSS4AjbCVqZi09valZCVLrLLUwiE0D2iME9
         PsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693389524; x=1693994324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xX0/yXPE7aSISxZJn2hMtArfZI0yA7qiHLxVlnkrZys=;
        b=F0C1gOZSWox9HuhUJmvUfZYaHcZqpXDXC9l/VsLhXKHNIXtJPzznWf5BrGJik4usQp
         KjvU4EyaydhVfvLb/2N0oHghMA7qew+ShqQ8iyGF5ZAma+L8JRwRBDiOVucvtSHsus6m
         +ydvZ5mneBGyUhp2QeZZTKlwjGP8XsdKOWJbvDXhqT1JaTWIqmvgXMfdv7bzzYbdajBU
         BopktEaNI2WlbFi8UiAMYtqelWLZUZCoISqK7KzBTesRWJjv0ypccHxCa6rWFE/dKtlS
         VopSA9sGZpX7HCjBuYNhSm2Cq2iyVNjRstVzGxg35xnzsmJNZfy7GX471cTzN+XaUvfO
         joeg==
X-Gm-Message-State: AOJu0YwevIgWSZhTgDuJy9TKLeQUnokYfbIDkePq8M2de+WM9CL04zgs
        BW3GL4pZtj+ty8i5fRH2+dUoig==
X-Google-Smtp-Source: AGHT+IHE2oNPr8YGDecm3++Y/fHkgaWwsbjkXdc3triMzGQUW4D74YTAwBQ4M0EqJPBcxNRdKwGq0Q==
X-Received: by 2002:a17:907:78d1:b0:9a5:eedb:ee1d with SMTP id kv17-20020a17090778d100b009a5eedbee1dmr560880ejc.46.1693389523821;
        Wed, 30 Aug 2023 02:58:43 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (5073ED84.static.ziggozakelijk.nl. [80.115.237.132])
        by smtp.gmail.com with ESMTPSA id i15-20020a1709064ecf00b009a2202bfce5sm6957130ejv.118.2023.08.30.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:58:43 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Wed, 30 Aug 2023 11:58:26 +0200
Subject: [PATCH 01/11] arm64: dts: qcom: sc7280: Mark some nodes as
 'reserved'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-fp5-initial-v1-1-5a954519bbad@fairphone.com>
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
In-Reply-To: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the standard Qualcomm TrustZone setup, components such as lpasscc,
pdc_reset and watchdog shouldn't be touched by Linux. Mark them with
the status 'reserved' and reeable them in the chrome-common dtsi.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  5 ++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index 2e1cd219fc18..8eb30aa226a2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -46,6 +46,14 @@ wpss_mem: memory@9ae00000 {
 	};
 };
 
+&lpasscc {
+	status = "okay";
+};
+
+&pdc_reset {
+	status = "okay";
+};
+
 /* The PMIC PON code isn't compatible w/ how Chrome EC/BIOS handle things. */
 &pmk8350_pon {
 	status = "disabled";
@@ -84,6 +92,10 @@ &scm {
 	dma-coherent;
 };
 
+&watchdog {
+	status = "okay";
+};
+
 &wifi {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 042908048d09..98a8d627a348 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2267,6 +2267,7 @@ lpasscc: lpasscc@3000000 {
 			clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
 			clock-names = "iface";
 			#clock-cells = <1>;
+			status = "reserved";
 		};
 
 		lpass_rx_macro: codec@3200000 {
@@ -4216,6 +4217,7 @@ pdc_reset: reset-controller@b5e0000 {
 			compatible = "qcom,sc7280-pdc-global";
 			reg = <0 0x0b5e0000 0 0x20000>;
 			#reset-cells = <1>;
+			status = "reserved";
 		};
 
 		tsens0: thermal-sensor@c263000 {
@@ -5212,11 +5214,12 @@ msi-controller@17a40000 {
 			};
 		};
 
-		watchdog@17c10000 {
+		watchdog: watchdog@17c10000 {
 			compatible = "qcom,apss-wdt-sc7280", "qcom,kpss-wdt";
 			reg = <0 0x17c10000 0 0x1000>;
 			clocks = <&sleep_clk>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			status = "reserved";
 		};
 
 		timer@17c20000 {

-- 
2.42.0

