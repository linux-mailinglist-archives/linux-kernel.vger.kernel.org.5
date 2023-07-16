Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5661375588B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGPWIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjGPWII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:08:08 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0BAD9;
        Sun, 16 Jul 2023 15:08:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6ff1a637bso54690981fa.3;
        Sun, 16 Jul 2023 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689545285; x=1692137285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugXpMr+bRzbd6kwqs4nSMZRO9LhGaT1WWKpkMn+sESs=;
        b=J902K7sDSU4Rt4aB4MsWvcY7K4BoVpmEOVfKM068i+rc9mkd96UlUVOF4S/Z7c5SIO
         d30NDPEq+6evbgh0oGShHZWunL6Mi+GlBhHkvxZnAlXhfHLG35Jh6PuKnJvqOvBwbfG1
         JCEg+vg5y8ml4AtGDXo/+/S0S/QSwZYmRCVaMk5UEduEpjik0h7Fl8PUAjWTKSolNAfT
         eXoZujNz1peqDAWrcO9ZzCzetS9S4Xu+YeHwLxHr35g14wH1GGTQ06BdHaZU4mMhNsxX
         BsDTKjJJ14L0CkmBbW0Q2xFbkBzaPrxTLHhfNVVM+1+AUU8Jcpsf9yj3NOkZe8EScnV/
         LJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689545285; x=1692137285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugXpMr+bRzbd6kwqs4nSMZRO9LhGaT1WWKpkMn+sESs=;
        b=NhUgVPo51445ZbyTp0TqO6eeXTHqB4XqaOnh5HlUUbvpTzSfffGr9yOKX2r3BfkFQ8
         HgqhsoXD+GM9a4+t8BnVUp+7yE0Ou3Aznpdv7Hg05jrH3YfWaw6mIeQBbDT5gxXNh6XB
         XI6McukeBynoWFnEjvz7ItgS7zfSMc1BAOYIcz083JC/HeA5lnowZBaaVoU6JLgQhY1b
         SzxaY7vH3CDbDS3u+WzhYtyoumfHRq79QMW0l4g8zhT9UbWopp+oPU1jiGJmsk0cHjk8
         1DG/B1sr3draBy11duHd+SXy2fBpVcHRO1hdlaA2whq1fp3eOjMMfFvMsjz6q8cRSj4A
         gItw==
X-Gm-Message-State: ABy/qLZ1xgqujRHtLWw18h+zYZG9AKpS+I3BcZSIoDAOXeh0v0fUpzCy
        l6UpPSA1lRfxHrctjBNLaFY=
X-Google-Smtp-Source: APBJJlFAXsafN5wXf769iQpJt4tz/9VY6FOtsLGjhkgPZIU8mp5Jeyq1oC/JxcKV8bqnZFNFtp8OOQ==
X-Received: by 2002:a05:6512:3c92:b0:4fa:5e76:7ad4 with SMTP id h18-20020a0565123c9200b004fa5e767ad4mr8282328lfv.10.1689545285145;
        Sun, 16 Jul 2023 15:08:05 -0700 (PDT)
Received: from localhost.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id h24-20020a197018000000b004fb9c625b4asm2464091lfc.210.2023.07.16.15.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 15:08:04 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] ARM: dts: exynos: k3g: Add touchkeys support
Date:   Mon, 17 Jul 2023 01:05:06 +0300
Message-ID: <20230716220644.22158-6-markuss.broks@gmail.com>
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

This device has touch keys that are compatible with those
installed on Samsung TM2 dev board.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
index 582faedd6aab..b3576a745054 100644
--- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
+++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
@@ -104,6 +104,33 @@ battery@36 {
 		};
 	};
 
+	i2c-touchkey {
+		compatible = "i2c-gpio";
+
+		sda-gpios = <&gpd1 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpd1 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		touchkey@20 {
+			compatible = "cypress,tm2-touchkey";
+			reg = <0x20>;
+
+			interrupt-parent = <&gpy7>;
+			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&touchkey_irq>;
+
+			vcc-supply = <&ldo38_reg>;
+			vdd-supply = <&ldo30_reg>;
+
+			linux,keycodes = <KEY_APPSELECT KEY_BACK>;
+		};
+	};
+
 	tsp_vdd: regulator-tsp-vdd-en {
 		compatible = "regulator-fixed";
 		regulator-name = "tsp_vdd_en";
@@ -742,6 +769,11 @@ power_gpio: power-key-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 	};
 
+	touchkey_irq: touchkey-irq-pins {
+		samsung,pins = "gpy7-1";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
 	wlan_reset: wlan-reset {
 		samsung,pins = "gpy7-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-- 
2.41.0

