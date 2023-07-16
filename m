Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF3675588E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGPWI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjGPWIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:08:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84841E56;
        Sun, 16 Jul 2023 15:08:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so61528891fa.2;
        Sun, 16 Jul 2023 15:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689545289; x=1692137289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRVc3pq+m8nwB6hJWvTXob0JDRMZoFt9HfBKXX9XoM4=;
        b=N3xoWZNGFZq046gPz7HiEwlcurJQEWI9WCu8DwqZbjIk9s2cFm5Qbry50AlCyN6lKU
         3SRRmpIYM56IY/DsSpvn/vQAEjHmA1g4UV6e2iD3OOs0M4l44SO56o2v43J4RVI1OKTn
         bEooJONZeShCH8AGzJBFpJD7ISgFbrZrFxv2J8U0ybBaJUa2FxspuhuzrJl4IUEUPRnN
         U13QMlAM88FVCy9X+ma8URpfAsElcveF/8JtZxwguUkUusP/cCocq6/W9JPhwDvK9J6C
         10sOaMFz/UmRYcm40xr6N5oFykRDAKrs0QHVkWEgxAGBYcx3wx/QOizzqKe7l0ogQXnu
         9x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689545289; x=1692137289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRVc3pq+m8nwB6hJWvTXob0JDRMZoFt9HfBKXX9XoM4=;
        b=JIniTBHHyXpw2Jxjk4Gz+n0lS1RkjUj6sc+/NmSOKOcIi+8DkNEH9QUcrgU0zrKyGd
         ptx8ChoLscHC4J4Ud0cqH4DS7DYRhq5SAQRBk0nB2nmNX9hvGMmClbOMXVpOd4GlzWA1
         tFYwGGosGTNHSa9Sqagr+BY9Rkjobzlrr6GHUxw/9Xac3ZX0dOrF7s59BSXwVpLJHMBW
         znoFfnNYVlnLbx0HVduCVoHIYd+8+CYIkmUMSeF7YMmnFGS21ittQl2KSNa5H8t6pNlF
         z84y8sLYUjz5PKy4y+ZnAzQu2JLcMTlNyiK0EWE0apiPK5dO3Wql5D2yNHqmj/PhUDXy
         AeGA==
X-Gm-Message-State: ABy/qLbhGCvwmu4js/eYDytsGO2hiwzAOzUjzhUG6vgSa/OMNLZbwvAH
        aKfVOjlP5d8ZNRd0YgtPLZ0=
X-Google-Smtp-Source: APBJJlGX2LJB4HoxSERRZLj5cQBszg6EUgbRvmGeHE8sfFAUGpjHhKF+7+g6TH+AO0uYrh43r687Qw==
X-Received: by 2002:a05:6512:53b:b0:4fb:89bb:bcc5 with SMTP id o27-20020a056512053b00b004fb89bbbcc5mr9245997lfc.50.1689545288727;
        Sun, 16 Jul 2023 15:08:08 -0700 (PDT)
Received: from localhost.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id h24-20020a197018000000b004fb9c625b4asm2464091lfc.210.2023.07.16.15.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 15:08:08 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] ARM: dts: exynos: k3g: Add display support
Date:   Mon, 17 Jul 2023 01:05:09 +0300
Message-ID: <20230716220644.22158-9-markuss.broks@gmail.com>
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

This device has Samsung S6E3FA2 DSI display installed,
this adds the device-tree bindings for it but two things
prevent it from being fully usable: one is a bug in Exynos5
DSI subsystem, which I believe is not tested properly;
the bug occurs randomly regardless of any variables, but it
seems to occur less if the Exynos DRM kernel module is loaded
later in the kernel boot process (the bug concludes in display
filling with static) ; another issue is that efforts
to support the S6E3FA2 panel are still going on, and the driver
for the panel is not in the kernel tree yet.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 41 ++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
index e019b630db94..954de392afbf 100644
--- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
+++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
@@ -203,6 +203,42 @@ &cpu4 {
 	cpu-supply = <&buck6_reg>;
 };
 
+&mixer {
+	status = "okay";
+};
+
+&fimd {
+	status = "okay";
+	samsung,invert-vclk;
+};
+
+&dsi {
+	status = "okay";
+
+	samsung,pll-clock-frequency = <24000000>;
+	samsung,burst-clock-frequency = <500000000>;
+	samsung,esc-clock-frequency = <16000000>;
+
+	vddcore-supply = <&ldo8_reg>;
+	vddio-supply = <&ldo10_reg>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		reg = <0>;
+		compatible = "samsung,s6e3fa2";
+
+		reset-gpios = <&gpy7 4 GPIO_ACTIVE_LOW>;
+
+		vddio-supply = <&ldo25_reg>;
+		vdd-supply = <&ldo28_reg>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&display_reset>;
+	};
+};
+
 &gpu {
 	status = "okay";
 	mali-supply = <&buck4_reg>;
@@ -839,6 +875,11 @@ touchkey_irq: touchkey-irq-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 	};
 
+	display_reset: display-reset-pins {
+		samsung,pins = "gpy7-4";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	wlan_reset: wlan-reset {
 		samsung,pins = "gpy7-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-- 
2.41.0

