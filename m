Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280A7796E49
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 03:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbjIGBCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 21:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjIGBCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:02:14 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363141BC1;
        Wed,  6 Sep 2023 18:02:08 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-792726d3aeeso16366939f.0;
        Wed, 06 Sep 2023 18:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694048527; x=1694653327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJHKtHFGdl4J2B/Oj4nlf+sDC7Tm9KEhrRJOXO+FSNY=;
        b=RHfg6qA16x9a0Z3dE6/poG5qbPcwTPmVV9as3XP3BLTFhCD7AWYEqHPiCz6wQHHsaW
         Vc8j9fGFeh98q9xp441NAIv3VedwytdWdNRFpAcE4jw8Uu2cEgZfkOPEw+36tdmltoQx
         /SyXahJL2bZ7Y/hu+X5Ib962Ex3S6UTu1ArXubFdjWZkigZRDunCprL90b0hsucxBTrS
         xL+TCaAXBoFJda0lptYzy96U43HBIPDJ9Pvc3J8/BHtFl2j0LWxqMgymluLDuEFTG6aF
         YppxoVvjGs6pq61p4OoVVMX1OqxetA8hSgiX0+RZDYNr4HOEgK76avP5/hZljjoAciq+
         /R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694048527; x=1694653327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJHKtHFGdl4J2B/Oj4nlf+sDC7Tm9KEhrRJOXO+FSNY=;
        b=DOYuiEGhGbQYUFJaXaB6G6DJZwrLsYRwdfCfGe5tjB/SeMvO9T8U/U1MlRm8RtHXbo
         OI4SbHrv4HYUabzh1lpa3dvg3/GAA+19RgiUtA3L7ozbU0xjO4L3hujYuulxYfeOMKuT
         XR5FkplxXDScUqQ47IrK89TKqc+mbHgUPShLCPlzg6nZ0QIXGXL8/r22CTJuD4fGTvgw
         qPTs/1w0NxVJWlKBOQ8hU0IJzRBz7CHpN8CeMvKx6bB5e+Gs7XkRPFsM6PVmJIDLkDXf
         DpUMTrzq7QajIXs1ZU5EhJaIYSFlu6e2cJiXd9Kh/lara0sjmLStrp3Wh5FFsgUB/N4h
         ivKg==
X-Gm-Message-State: AOJu0YyQLDBkzzJcMbiUXkwqpFisyViA79BGBYNZSsE4PVnyYx31S4FY
        yVSZsRsVIn3T6Z57QgvrkBmjiE5QecM=
X-Google-Smtp-Source: AGHT+IHENBuQoGUHLoA/1ZYjmHdz72K8X09e5hNVAkflc2Z9ft3AL221hOfzTKp99DllHav/9S01iA==
X-Received: by 2002:a6b:4919:0:b0:795:2274:1f3f with SMTP id u25-20020a6b4919000000b0079522741f3fmr20115691iob.3.1694048527099;
        Wed, 06 Sep 2023 18:02:07 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:c24d:eb45:b814:f30b])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b0042ff466c9bdsm5389796jan.127.2023.09.06.18.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 18:02:06 -0700 (PDT)
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
Subject: [PATCH 1/2] arm:dts: am3517-evm: Fix LED3/4 pinmux
Date:   Wed,  6 Sep 2023 20:01:58 -0500
Message-Id: <20230907010159.330555-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
This likely cannot apply to the original series, because the file has
moved.  I can generate a separate patch for the pre-move device trees
if necesssary.  The original location was:
  arch/arm/boot/dts/am3517-evm.dts

diff --git a/arch/arm/boot/dts/ti/omap/am3517-evm.dts b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
index af9df15274be..738189ddc8d5 100644
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
+	leds_pins: pinmux_leds_pins {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a24, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu0.gpio_11 */
+			OMAP3_WKUP_IOPAD(0x2a26, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu1.gpio_31 */
+		>;
+	};
+};
-- 
2.39.2

