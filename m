Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB775587A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGPWIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjGPWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:08:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D5E1;
        Sun, 16 Jul 2023 15:08:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso57702231fa.1;
        Sun, 16 Jul 2023 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689545286; x=1692137286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4UUoDGd2gBkYu4LAt7ZJ7XPzzBg5mAAkXDFIcZ5WcE=;
        b=d/AeaEfDb+5v7QJ4fifmtKxiDhuwtPB3QvFaBu3pVpes5J3s4+Wlsmd2XCrrBp+IyF
         VHZfaV3JStUemmDEl0cR9lQaL69dicLUHM5h+1bD0X9nAlhcIStH63B+mqFSUVUjPxC1
         oOl2gWVJLCwZ6XYeKBb+KbO28YskuQm6WKuGI5SbFnyLALltQOyH/qyaLiYPENQhNmxM
         O+jrpckbclEuaOt6C+krWVLuwDCI6HB/tu0UunvGMviOEARzgh/uEydRrXavgMTQ4BDd
         Q6J8S6Lpc/4pwcLIdQCn1BC/D9nkhmv0VVIhl0sBSsEBqj+hy8NzGAozBmc6X41GF1hb
         B9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689545286; x=1692137286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4UUoDGd2gBkYu4LAt7ZJ7XPzzBg5mAAkXDFIcZ5WcE=;
        b=MvV0FAQu6fo1iNwL5oMgpIUhPvndgdpkoZkwThk3Lki8ATw+mFwLMTzHgBuAY1uBve
         fEUXB7b0y5V/n/u25FrHi4rjpjrx0FW3ZN3Eh8tpe/0mW8Te33ljb2sB0kMvaQyGn0ru
         2j389e86NBItQ5BGF36GEoccRvOwfpJ9aE4ytHXlvyRD6Ddpf/PmCUNOJI9pSr+eZRZf
         uVBvWjMWPMi2FDxKkKmiUcXCuL8hWVQSACTwZL7TO6NDVZONlAfZCHdg4ERPmmcs03LE
         yOarvH0/6taJYHKduDh4kfmhkL9MWyEU7+0OcV8qDBQ+nOp+dGsbUchqolxuwXAmylaQ
         CKKQ==
X-Gm-Message-State: ABy/qLYSRHnYW71YknW7VjFvx9Fib0TjZTd0YKOwlJ+jP9M/xsb+9/h0
        2Y74D10ZDd1ns+uBg1b0nxd6wWedqSs=
X-Google-Smtp-Source: APBJJlHwOvb5wiCo4clFjmzDCmA1fl7RbqKHFikhsSkLSc+nFms/jPhfxiR6dFwAdT/cIGXe2kixeQ==
X-Received: by 2002:a05:6512:2384:b0:4fb:8603:f6aa with SMTP id c4-20020a056512238400b004fb8603f6aamr8598156lfv.11.1689545286245;
        Sun, 16 Jul 2023 15:08:06 -0700 (PDT)
Received: from localhost.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id h24-20020a197018000000b004fb9c625b4asm2464091lfc.210.2023.07.16.15.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 15:08:06 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] ARM: dts: exynos: k3g: Add notification LED support
Date:   Mon, 17 Jul 2023 01:05:07 +0300
Message-ID: <20230716220644.22158-7-markuss.broks@gmail.com>
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

This device has a Texas Instruments LP5562 LED controller
which controls the LEDs which are used as notification lights.
It has three colors which can be combined, supports pulse mode
and other various features.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 47 ++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
index b3576a745054..813dbf0438de 100644
--- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
+++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
 #include "exynos5800.dtsi"
 #include "exynos5422-cpus.dtsi"
 
@@ -131,6 +132,52 @@ touchkey@20 {
 		};
 	};
 
+	i2c-led {
+		compatible = "i2c-gpio";
+
+		sda-gpios = <&gpy3 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpy3 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		lp5562@30 {
+			compatible = "ti,lp5562";
+			reg = <0x30>;
+
+			clock-mode = /bits/ 8 <2>;
+			label = "notification-leds";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				chan-name = "notification-red";
+				color = <LED_COLOR_ID_RED>;
+				led-cur = /bits/ 8 <0x40>;
+				max-cur = /bits/ 8 <0x40>;
+			};
+
+			led@1 {
+				reg = <1>;
+				chan-name = "notification-green";
+				color = <LED_COLOR_ID_GREEN>;
+				led-cur = /bits/ 8 <0x40>;
+				max-cur = /bits/ 8 <0x40>;
+			};
+
+			led@2 {
+				reg = <2>;
+				chan-name = "notification-blue";
+				color = <LED_COLOR_ID_BLUE>;
+				led-cur = /bits/ 8 <0x40>;
+				max-cur = /bits/ 8 <0x40>;
+			};
+		};
+	};
+
 	tsp_vdd: regulator-tsp-vdd-en {
 		compatible = "regulator-fixed";
 		regulator-name = "tsp_vdd_en";
-- 
2.41.0

