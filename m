Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781A77542AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbjGNSjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjGNSjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:39:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF4330E2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:38:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2369290f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1689359936; x=1691951936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=deU8c6Cea+L9orVZZNfEPw1rPtq90LnlFmj7Ns6mrNU=;
        b=V3Zn7QDF/i1c6PTCznso6v0fvoVvFxZBVRKwUkL/7UsD45K53p5fAhb5BrqiDZbXxW
         RYZp46jRv+rZKouuJGzqBw6a8tz0fMjhpICJJfZTZdeKRypLrwe+Mx0eb3SWIaP03tL8
         qS4wWm3XqVNI6YE+2RA5bHtVmRNF3GvN68UN2R+9m/nYYyPUBi8Wd3fW8OOzplmuCqrk
         4xspA/sRstP8XtXbRJa6w/wPr69j7yD95/irjBUDcMYs/CelJp02ZYVTnDOXAHLMfhbH
         AQHDnAYXXRVog6aMIB0oF0DhDep8S71rlpnyiZmbyjklXRjXUpMZU5z3t3XDUyb/lK+q
         6Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689359936; x=1691951936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deU8c6Cea+L9orVZZNfEPw1rPtq90LnlFmj7Ns6mrNU=;
        b=SlYqvc6xsLDv3eE87AWwZ818WB6LGG+wWoEAv2V0xVnziDq0gIsUe364Z1I0/eiy32
         x4mSWJVALkHbNH6qgkEolMMEnXIsi8Qgh+hLmvMbQXqTZD0nA3eM10rqJBK3C2FRQaS2
         gJqO/3F1AqNqAPL3u8ZBlxqX6J00WD//wWAwAnPXVdqEC9jOa5bdF4rk1kb2sPhmiD3J
         dCy9DoOQ4lc/IlvFl4jjm/gu8Dz7CJlDHirG5qlNhvzppKoSgq+RwMN9maZVu4GoLLi4
         g5AxE4jYCg76pmSen+WAoHWme6ZBIBgErUQJy4i3kvy4kGD/bulovDonZchyaCXrCims
         k4nA==
X-Gm-Message-State: ABy/qLaJKehvO/BDpaB/jV11mt54T5rIQFqzrZguU+81wym3iE4hyi6j
        sWu3WAW80Q82E1m1Wek8wajxzUgNouG9vRqD+RdloxLv
X-Google-Smtp-Source: APBJJlHMDyu+SyQWF0qX33GSwmmfhSuO8ys8Uf258zjX9A+WMuxc0AXrb8eyGX1vf6+YEZlzNZUeMw==
X-Received: by 2002:a5d:4fd0:0:b0:314:2d89:70f1 with SMTP id h16-20020a5d4fd0000000b003142d8970f1mr5082421wrw.16.1689359936078;
        Fri, 14 Jul 2023 11:38:56 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600000cd00b00314367cf43asm11562379wrx.106.2023.07.14.11.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:38:55 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
Date:   Fri, 14 Jul 2023 21:38:52 +0300
Message-Id: <20230714183852.8370-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MAINTAINERS entries with a valid email address as the Microchip
one is no longer valid.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 MAINTAINERS | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..0be71ca1cbb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2337,7 +2337,7 @@ F:	drivers/phy/mediatek/
 ARM/MICROCHIP (ARM64) SoC support
 M:	Conor Dooley <conor@kernel.org>
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
@@ -2346,7 +2346,7 @@ F:	arch/arm64/boot/dts/microchip/
 ARM/Microchip (AT91) SoC support
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 W:	http://www.linux4sam.org
@@ -3248,7 +3248,7 @@ F:	include/uapi/linux/atm*
 
 ATMEL MACB ETHERNET DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 S:	Supported
 F:	drivers/net/ethernet/cadence/
 
@@ -13778,7 +13778,7 @@ F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
 F:	drivers/spi/spi-at91-usart.c
 
 MICROCHIP AUDIO ASOC DRIVERS
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/sound/atmel*
@@ -13801,7 +13801,7 @@ S:	Maintained
 F:	drivers/crypto/atmel-ecc.*
 
 MICROCHIP EIC DRIVER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/microchip,sama7g5-eic.yaml
@@ -13874,7 +13874,7 @@ F:	drivers/video/fbdev/atmel_lcdfb.c
 F:	include/video/atmel_lcdc.h
 
 MICROCHIP MCP16502 PMIC DRIVER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
@@ -13901,7 +13901,7 @@ F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 F:	drivers/mtd/nand/raw/atmel/*
 
 MICROCHIP OTPC DRIVER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
@@ -13940,7 +13940,7 @@ F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
 F:	drivers/fpga/microchip-spi.c
 
 MICROCHIP PWM DRIVER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-pwm@vger.kernel.org
 S:	Supported
@@ -13956,7 +13956,7 @@ F:	drivers/iio/adc/at91-sama5d2_adc.c
 F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
 
 MICROCHIP SAMA5D2-COMPATIBLE SHUTDOWN CONTROLLER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
@@ -13973,7 +13973,7 @@ S:	Supported
 F:	drivers/spi/spi-atmel.*
 
 MICROCHIP SSC DRIVER
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -14002,7 +14002,7 @@ F:	drivers/usb/gadget/udc/atmel_usba_udc.*
 
 MICROCHIP WILC1000 WIFI DRIVER
 M:	Ajay Singh <ajay.kathat@microchip.com>
-M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/microchip/wilc1000/
-- 
2.39.2

