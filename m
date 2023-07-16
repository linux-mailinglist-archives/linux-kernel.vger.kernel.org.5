Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2495E755889
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjGPWId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjGPWIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:08:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591F1FE;
        Sun, 16 Jul 2023 15:08:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so6304751e87.1;
        Sun, 16 Jul 2023 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689545281; x=1692137281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHngaqCrQ0FneY3+XbEOWJuLApZy3bmRMZLz2KpBf1c=;
        b=ENfeZFXfbFdTAhHwUcejne2kgnWjt3QCatDMZAiOB2QmHQlzV4Z+D1gkXDNMlOG0Q4
         uFWkgIPCHB7NvnvtCzok7p2/ab2kPauN8lo+YYW2Yr9R0LYspHiabBHAU259sMKB/0Kj
         x6EzoWabJ7KNZ4LykRU69cNs/4/JiDvV0vTl0Z/2Mn1JcQYpLSjtBcChdZkptYaoeunT
         yG7cv4Bk5WGQGXkGBHg0aLzbz3uzF/OjoKLdJURDweImnTUOj1kA42+ZGy6A+akX7kMh
         Kpw77Y1ovClJS2glWrrQpsuoRk2mKCMM4rg6UZRq+Yx+9/c6JOqfalg3A7rdnyW7qEpA
         B+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689545281; x=1692137281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHngaqCrQ0FneY3+XbEOWJuLApZy3bmRMZLz2KpBf1c=;
        b=JcaeszZZskNBU5uyP0i5P16pbXnHjsNOs5F8tKjJ1AxIxJ6Zoz/sn2WWvQjr4ZEWQf
         aMydI04w+vtNRyTaOi5Erfq6HDoJo55tKipF1ddIqIkMnKQtxlPEhhHBM+MrPvqvFQsp
         fH1kd9dVGomi7MSWYYI1Oo6NUVmqy+etRVWlDZZZGOOx1Wh9iy7tU1RC5jS3Z4WBfK+H
         Xsc9V9bZh9FUARHDrI2iZYYMpQlTozectA7SLeAOtRfiRlY9l3p0G/9DEUEZja8tvtJq
         mg3M7heL874GwqovAJA2DJRhKJM6cKascGKrVvu3j1/1dBbU8weS/hCwfevDvj2JaM8Z
         7fbQ==
X-Gm-Message-State: ABy/qLYw3RFFmO7D7mRJOAyv9ISY8Xjm+CV/r7SXuVoOjISA35R0rREW
        Bm1o4Yx88fdZVQ5Ocdq378g=
X-Google-Smtp-Source: APBJJlFdTGOJjV77YehFgSdWX+e70CQdgXv1R+rqWI4JKHgHA4XS20L0eqPhcB7MSYeWuOglrIGX0w==
X-Received: by 2002:a05:6512:1590:b0:4f8:453f:732f with SMTP id bp16-20020a056512159000b004f8453f732fmr3584726lfb.2.1689545281527;
        Sun, 16 Jul 2023 15:08:01 -0700 (PDT)
Received: from localhost.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id h24-20020a197018000000b004fb9c625b4asm2464091lfc.210.2023.07.16.15.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 15:08:01 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] ARM: dts: exynos: Add GPIO keys support for k3g
Date:   Mon, 17 Jul 2023 01:05:03 +0300
Message-ID: <20230716220644.22158-3-markuss.broks@gmail.com>
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

Add the four physical buttons support, volume buttons have
external pull-up resistors.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 60 ++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
index 1a11a6993ba7..c3e006dc34ea 100644
--- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
+++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 #include <dt-bindings/clock/samsung,s2mps11.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include "exynos5800.dtsi"
 #include "exynos5422-cpus.dtsi"
@@ -21,6 +22,45 @@ / {
 
 	aliases {
 		mmc0 = &mmc_0;
+		mmc1 = &mmc_1;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&power_gpio &volume_up_gpio &volume_down_gpio &home_gpio>;
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpx0 2 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpx0 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <15>;
+		};
+
+		key-home {
+			label = "Home";
+			gpios = <&gpx0 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		key-power {
+			label = "Power";
+			gpios = <&gpx2 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
 	};
 
 	memory@20000000 {
@@ -641,6 +681,21 @@ &mmc_1 {
 };
 
 &pinctrl_0 {
+	volume_up_gpio: volume-up-pins {
+		samsung,pins = "gpx0-2";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>; /* External pull up */
+	};
+
+	volume_down_gpio: volume-down-pins {
+		samsung,pins = "gpx0-3";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>; /* External pull up */
+	};
+
+	home_gpio: home-key-pins {
+		samsung,pins = "gpx0-5";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+	};
+
 	s2mps11_irq: s2mps11-irq-pins {
 		samsung,pins = "gpx0-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
@@ -653,6 +708,11 @@ touch_irq: touch-irq-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 	};
 
+	power_gpio: power-key-pins {
+		samsung,pins = "gpx2-2";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+	};
+
 	wlan_reset: wlan-reset {
 		samsung,pins = "gpy7-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-- 
2.41.0

