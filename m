Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9F57B9908
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbjJEAEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjJEAEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:04:14 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F4D8;
        Wed,  4 Oct 2023 17:04:10 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79faf4210b2so19620239f.2;
        Wed, 04 Oct 2023 17:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696464249; x=1697069049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGDDpzqsvW7aOeRzDYWTlcuECFrpOSpEIaC/TB+7ynk=;
        b=BgHKVhAUGBrVl9agIOKNnfthmVpQDQZ1mH0B1KqBKc1Ax2v6FvmtuGb/WHwM6XXiag
         JHXS1OlwcdR2MMBw8yhSDONpBqys/X4h0gOfRoRorP2HM+mQqXeGl3hc+ETWHyB/dneN
         tPy9fgifXkJoWtEhZmVtBGMvZe3U8MfFjBrK9y4aoFvUiFhn1beOVbSad4uDAsUsBD/3
         PakHBusnpSj9v0/aXY+8g6+pW5V+USAlosArlcH9jQfLolY9RYLJxV9mDp51Ka8t38De
         uN+ywsEnqaHyQYNcKbwNBjfJqoF7lf3gzzUDhpb8vC/KhT3cqU0B9arAlbPA74aoPtLt
         jA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696464249; x=1697069049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGDDpzqsvW7aOeRzDYWTlcuECFrpOSpEIaC/TB+7ynk=;
        b=mEGzrf3Z2SoM35T7L29tq5OqWSmvBDpSR36p1nV3+QJRDAzqFkNqT4vxyX2A/PrATa
         sgfUF1haFFwa1VUC+tMUlLXOUhP9O0YSWLFBk6PHPG4iScUV+7o5gUOxu/vJcaFYNc8f
         m4vy6j3DAaM8yXMCfwRiAg9E/dY4NvtVj1wdFwQ3zc3ILGd5JjgxDsM7zlKckgScvpNS
         jO/yEICFrEh5b1/kAlh3gWWerHFje3+iwimPw11fc9uA8bRXZVNwm0QTd/QZG4MSjpMV
         qTa9WmvVnkuEBB/F67kgjp4SSANPrEgjF2wWII/NYdQwV+aXTdyZaLKP3OitUjbNgF/r
         BqXw==
X-Gm-Message-State: AOJu0YxOdzD/p35dCJ5wjBA5mZ7J3xAIQ0Qlc/ESj3CE/690Klfe9b+C
        5FSobWJ01JWUgCUy8N16t9czm1TdnuM0hA==
X-Google-Smtp-Source: AGHT+IHwwtYO6TvyCdx9Peqr4gYUFiN1LWR9IJlByaOKxfxPSvI3ifyR2TuGn1lSyJO46a8TxB4zdQ==
X-Received: by 2002:a6b:dd0d:0:b0:791:1b1c:b758 with SMTP id f13-20020a6bdd0d000000b007911b1cb758mr3785561ioc.19.1696464248186;
        Wed, 04 Oct 2023 17:04:08 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id h3-20020a5ecb43000000b0079fdeed3ab6sm56895iok.40.2023.10.04.17.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 17:04:07 -0700 (PDT)
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
Subject: [PATCH V3 1/2] arm:dts: am3517-evm: Fix LED3/4 pinmux
Date:   Wed,  4 Oct 2023 19:04:01 -0500
Message-Id: <20231005000402.50879-1-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
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
V3:  No Change
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
2.40.1

