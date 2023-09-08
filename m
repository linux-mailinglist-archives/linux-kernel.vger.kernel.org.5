Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFB979913D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbjIHUtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjIHUty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:49:54 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7846C9C;
        Fri,  8 Sep 2023 13:49:50 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34cc8e8cbd4so9094155ab.0;
        Fri, 08 Sep 2023 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694206189; x=1694810989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVhxpYw0R4qI6Tx1wydw+Ej+AzCHYQtaynaL7MCVjsw=;
        b=C32bYFfillHMh78+0FLWiRskWUd5kjK7euw5w0NL4LoWh8uEV4SmIlNb6Yk4u9i79l
         3rF9NS1a6FM7zkvkaBq9TCubqrgzcxtFNzgXwoJz/bHD9lp2jPBpMH8uL0ewoKLtv9ve
         At719UdBriyxoA55v0p5w2z7r4+B6u6oc6s127P9a6yjUridOlnd9w9OdroBwW/eCYAU
         d3jFCidEBq/bZ7NG0AjnSwojeE/VsHuZHyAYhEHQ3RS9LmzCtTZpjKeP+o/7l9IdCTxq
         3QS+qf6aH8DOM4eTP15wrwe95EFtRvGNLPrZQvq2oFulpX2xudskAU6VC71WkSrPGkOh
         3tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694206189; x=1694810989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVhxpYw0R4qI6Tx1wydw+Ej+AzCHYQtaynaL7MCVjsw=;
        b=SaDI8srUM9Y82H+3+CjvxMCcpCg2Z6prhaBbgLK7ZKlXJ7QrMfRm9bgqlHXfAlzV5A
         Nz+eefp2LXJhhLFBydrwf+cHBIFAAMrA5dGO4EdMRrQIpGpzeXzklM9yINh5bcmX/wyd
         6WVoMKGaN00NBPRtmaQJMpp5SRxzqBB0RrLNS3QhtRSr8EArh/pckaer1veCucQ/DrEF
         m/KibjA6tElEwqJP51qnvdkITs2J5cxz5EnT2ttD/qguJrHW2tKiHxLTyCZHYRQG74+p
         UhDfRwnELs3Y5wFUXX42LnY2FFw4VfW3YoBIrwEH5leyb1FiefJYwwE2bFj8QXKlIkW7
         E7Wg==
X-Gm-Message-State: AOJu0YyfZLG4uqvPITqXTjjxyylxVSXPrXLEiPgzumAxETQkM3qJizPv
        73urNpDFsLxhYxa8Gr/swi3rbddxaZw=
X-Google-Smtp-Source: AGHT+IGco3Pwuo+A++2EIBmDQSEz1vek9i74d02ScqZ0gXe4/EB196BeSxR8vlWHu28bTSR9LjnybQ==
X-Received: by 2002:a05:6e02:1001:b0:349:8fb5:87c4 with SMTP id n1-20020a056e02100100b003498fb587c4mr4053181ilj.14.1694206188995;
        Fri, 08 Sep 2023 13:49:48 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:1e20:b059:adc7:9ca8])
        by smtp.gmail.com with ESMTPSA id h6-20020a92c086000000b0034ca3b29c5asm711393ile.57.2023.09.08.13.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:49:48 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Derald D. Woods" <woods.technical@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] arm:dts: am3517-evm: Fix LED3/4 pinmux
Date:   Fri,  8 Sep 2023 15:48:27 -0500
Message-Id: <20230908204828.5242-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinmux for LED3 and LED4 are incorrectly attached to the
omap3_pmx_core when they should be connected to the omap3_pmx_wkup
pin mux.  This was likely masked by the fact that the bootloader
used to do all the pinmuxing.

Fixes: 0dbf99542caf ("ARM: dts: am3517-evm: Add User LEDs and Pushbutton")
Signed-off-by: Adam Ford <aford173@gmail.com>
---

V2:  Use current device tree naming convention for led-pins

This likely will require a separate patch to apply to previous file location.

diff --git a/arch/arm/boot/dts/ti/omap/am3517-evm.dts b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
index af9df15274be..866f68c5b504 100644
--- a/arch/arm/boot/dts/ti/omap/am3517-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
@@ -271,13 +271,6 @@ OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT_PULLUP | MUX_MODE0)  /* i2c3_sda */
 		>;
 	};
 
-	leds_pins: leds-pins {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a24, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu0.gpio_11 */
-			OMAP3_WKUP_IOPAD(0x2a26, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu1.gpio_31 */
-		>;
-	};
-
 	mmc1_pins: mmc1-pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
@@ -355,3 +348,12 @@ OMAP3430_CORE2_IOPAD(0x25e2, PIN_INPUT | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
 		>;
 	};
 };
+
+&omap3_pmx_wkup {
+	leds_pins: leds-pins {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a24, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu0.gpio_11 */
+			OMAP3_WKUP_IOPAD(0x2a26, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu1.gpio_31 */
+		>;
+	};
+};
-- 
2.39.2

