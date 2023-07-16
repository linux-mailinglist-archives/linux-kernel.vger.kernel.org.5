Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D8B755886
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjGPWIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGPWIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:08:04 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451EE1;
        Sun, 16 Jul 2023 15:08:02 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so57737791fa.3;
        Sun, 16 Jul 2023 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689545280; x=1692137280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbi4z5OwpHmDw3fNzdltzwmv9tZsIUUsK9ON0f/StLE=;
        b=MHjtVot+MLxS37P81JK1IL9KQsTVRv6tY+PcdA0A/HKUWOjaCSAB0zOPn2r1RnVPrs
         OshoTuSqtqQqH90Ez21GbQ3xnOeq52WhtuYd8jdtRcq3kHG5/UCOY8EhzmU+JfGXVNRQ
         sd9LzwNqgLm3kqLNQMDYX4f3UWzh+Vu5kpQdJxlOEGvUoMXp5bcmvQ0CDb6HRRHS2OOD
         zdj3fsNOAdAledXRqrjM3GbU+m91OUZQrz83mZJxyfJXq2yihpktPMquqqrEXFafQWvz
         OZHiaGS2MX5dd92AexqXOzNm/Rxc8Oo9oZYqPbnI/lZl8j7c6nrBlH+232GJhfZgzOuu
         TQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689545280; x=1692137280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kbi4z5OwpHmDw3fNzdltzwmv9tZsIUUsK9ON0f/StLE=;
        b=DhWyBIwQYcn3Wdt3WfDLWRQ6EA7cRLAZt8Kmjso8MlPiIi9Wfe9eyM+maLkKt2tgKe
         PBbyP1sena6eV6qTngx52BuEX3wYMP+dexG4v6yo7ZwMEzN8j7plRAEjb1dHD690Rtud
         C2J8Qew4mWwQyOuLJdXtPXicXrDorT9YUQ5Xly3GYORGcFQV1d9riYROe1OaY5dpIA1a
         2ggT5S8OLK9i41aR+oGbT0yBPR2yWIe9GYm1NoDQEdmqL9Fo1ex2yZ4tusxE/Fd49qQA
         2j/PWPXXGv+if7jncoVsWvDxV4V/CBWOEqZNHfjTGjsI4aXMso8BeqZY14Z4IvQjY1Kl
         990A==
X-Gm-Message-State: ABy/qLZ/6mfHWttcNKOM1qibuzQhpZid6rhm7imIvyhHo6PB7MDYGK2r
        VVEL3HtIX5/EwyoFUwERu1I=
X-Google-Smtp-Source: APBJJlHX89VVhGlZFpr4YPnj5Qh5M5j38bPVFfe9FO60d7SLDNziW0bZZ18Ccs+88nFaaGPrvfOthg==
X-Received: by 2002:a05:6512:b9b:b0:4fb:8680:138a with SMTP id b27-20020a0565120b9b00b004fb8680138amr7492520lfv.22.1689545280210;
        Sun, 16 Jul 2023 15:08:00 -0700 (PDT)
Received: from localhost.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id h24-20020a197018000000b004fb9c625b4asm2464091lfc.210.2023.07.16.15.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 15:07:59 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] ARM: dts: exynos: k3g: Add WiFi card support
Date:   Mon, 17 Jul 2023 01:05:02 +0300
Message-ID: <20230716220644.22158-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716220644.22158-1-markuss.broks@gmail.com>
References: <20230716220644.22158-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device has Broadcom BCM4354 WiFi card installed,
which uses SDIO interface.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
index c35261a338ff..1a11a6993ba7 100644
--- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
+++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
@@ -48,6 +48,13 @@ tsp_vdd: regulator-tsp-vdd-en {
 		gpio = <&gpy3 5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	wlan_pwrseq: wlan-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpy7 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
+		clocks = <&s2mps11_osc S2MPS11_CLK_BT>; /* Used not only for Bluetooth */
+		clock-names = "ext_clock";
+	};
 };
 
 &cpu0 {
@@ -616,6 +623,23 @@ &mmc_0 {
 	bus-width = <8>;
 };
 
+/* WiFi SDIO module */
+&mmc_1 {
+	status = "okay";
+	cap-sdio-irq;
+	cap-sd-highspeed;
+	non-removable;
+	samsung,dw-mshc-ciu-div = <1>;
+	samsung,dw-mshc-sdr-timing = <0 1>;
+	samsung,dw-mshc-ddr-timing = <0 2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd1_clk>, <&sd1_cmd>, <&sd1_int>, <&sd1_bus1>,
+			<&sd1_bus4>, <&wlan_reset>;
+	bus-width = <4>;
+	vqmmc-supply = <&ldo3_reg>;
+	mmc-pwrseq = <&wlan_pwrseq>;
+};
+
 &pinctrl_0 {
 	s2mps11_irq: s2mps11-irq-pins {
 		samsung,pins = "gpx0-7";
@@ -628,6 +652,11 @@ touch_irq: touch-irq-pins {
 		samsung,pins = "gpx1-6";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 	};
+
+	wlan_reset: wlan-reset {
+		samsung,pins = "gpy7-7";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
 };
 
 &rtc {
-- 
2.41.0

