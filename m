Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD507C5550
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346957AbjJKNYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjJKNYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:24:08 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E833293;
        Wed, 11 Oct 2023 06:24:04 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 93FD0830D0;
        Wed, 11 Oct 2023 15:24:02 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH RFT v8 0/6] ARM: pxa: GPIO descriptor conversions
Date:   Wed, 11 Oct 2023 15:23:44 +0200
Message-Id: <20231011-pxa-gpio-v8-0-eed08a0fcac8@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOChJmUC/13PPW7DMAwF4KsEmqtCf5SoTp16gCBb0cG2qFhoE
 Rt2YaQIfPcKGlrCI0V9j3gPsdJSaBUvp4dYaCtrmW51wKeTGMbudiVZUp2FUcYqVEHO905e5zJ
 JO5CBBMGhdqJ+nxfK5d6i3sX57SI+6uNY1u9p+Wnxm26rlhSN+0/atFTSoIIeQ0KM7nX9nL7oe
 Vxaxma488yZ6iI6513SHlI6OMtdZM5W12VMQJB0tsd77s9ppTRzrjqVbR8DkKcEBwfc8X5QXYq
 xI58Hog4PznPH+/nWT/cuapUgxoML3PF+oboBM2SnLCF45vZ9/wWTRi5a9AEAAA==
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3583;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=W45N0rDKR8ciCpFn22YDvuWadd4TwRIEzdyajQZc0vY=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlJqHoOv8y4PmRkwDxzRi92AU5LtYntuzh9qbAn
 MVw/2XG+5aJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSah6AAKCRCaEZ6wQi2W
 4feiD/9V3AUDIT2hwlL293f363ISY7WmwRKzd4I/t04+4gaB13YzmLOR4Q94oZjfpJh00NgJgbU
 iuKsH7NC+cFF4v16zyRM7kpxhS2qgt1ghPnK+qabwKvpA5Srgscw6nele8Qkf99wWoKUSQxKnXJ
 mVpJa6uPEDoR9IY+IpNXk1Qz1yJ5Nop/PCv5DjJG/rgy/pjBlRNJdEmUCRHuNPMkOoZXFBFQlmo
 GLjZWrpNgibfTItoRHMFBwSbDYXnlWHsOO+uP5zICJ5JSi4Rx4CYUnwejmi5AqWEL5iJWT2eniC
 SURf/j/vwkhySix1e+ZSmx4U8mHTw+tYwAlsdsWviMEyntYab93ioQ5r8GqzbriCf+FmVBKX5NZ
 yQE47gpBk01dQwsKYQctgq5ycfu8kE1iXsLPVC+TglvLpMSlX2fJj3SDPtxIvkkFwgoXsiC24i2
 SoLa79Z55FtPd2aAjVfb+lUKaQ4Vo1mx9JbLqWTBpeu4CAtVkVH4vbAABsrNjgLISR0ZJwA9NF4
 iO1VFjast4VvmkO/Jx9nQyioaj0CjySq9B8wDWCF1gWVRF6d3l1S7X2tUJm51fDeHZKtVJUS+Pk
 p9ZONcTQnjyk++g1h4y6YubmW3tzAE6GC88y1We6YS6iHkP4wRD2ZR1rDrcrNIcbQZvCfrw0wnz
 pLq9JSVuzqhNl4w==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Small series to convert some of the board files in the mach-pxa directory
to use the new GPIO descriptor interface.

Most notably, the am200epd, am300epd and Spitz matrix keypad among
others are not converted in this series.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v8:
- Address maintainer comments:
  - Do not pointlessly gpiod_get() LED gpios
- Update trailers
- Rebase on v6.6-rc5
- Link to v7: https://lore.kernel.org/r/20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr

Changes in v7:
- Address maintainer comments:
  - Drop gpiod_put in OHCI
  - Make "struct gpio_descs *leds" in Spitz LEDs global
- Link to v6: https://lore.kernel.org/r/20231006-pxa-gpio-v6-0-981b4910d599@skole.hr

Changes in v6:
- Address maintainer comments:
  - Use devm_gpiod_get_optional() in OHCI
  - Use gpiod_get_array() in Spitz LEDs
- Update trailers
- Link to v5: https://lore.kernel.org/r/20231004-pxa-gpio-v5-0-d99ae6fceea8@skole.hr

Changes in v5:
- Address maintainer comments:
  - Rename "reset generator" GPIO to "reset"
  - Rename ads7846_wait_for_sync() to ads7846_wait_for_sync_gpio()
  - Properly bail out when requesting USB host GPIO fails
  - Use dev_err_probe() when requesting touchscreen sync GPIO fails
  - Use static gpio_desc for gumstix bluetooth reset
- Pulse gumstix bluetooth reset line correctly (assert, then deassert)
- Fix style issue in ads7846_wait_for_sync_gpio()
- Update trailers
- Link to v4: https://lore.kernel.org/r/20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr

Changes in v4:
- Address maintainer comments:
  - Move wait_for_sync() from spitz.c to driver
  - Register LED platform device before getting its gpiod-s
- Add Linus' Reviewed-by
- Link to v3: https://lore.kernel.org/r/20230929-pxa-gpio-v3-0-af8d5e5d1f34@skole.hr

Changes in v3:
- Address maintainer comments:
  - Use GPIO_LOOKUP_IDX for LEDs
  - Drop unnecessary NULL assignments
  - Don't give up on *all* SPI devices if hsync cannot be set up
- Add Linus' Acked-by
- Link to v2: https://lore.kernel.org/r/20230926-pxa-gpio-v2-0-984464d165dd@skole.hr

Changes in v2:
- Address maintainer comments:
  - Change mentions of function to function()
  - Drop cast in OHCI driver dev_warn() call
  - Use %pe in OHCI and reset drivers
  - Use GPIO _optional() API in OHCI driver
  - Drop unnecessary not-null check in OHCI driver
  - Use pr_err() instead of printk() in reset driver
- Rebase on v6.6-rc3
- Link to v1: https://lore.kernel.org/r/20230924-pxa-gpio-v1-0-2805b87d8894@skole.hr

---
Duje Mihanović (6):
      ARM: pxa: Convert Spitz OHCI to GPIO descriptors
      ARM: pxa: Convert Spitz LEDs to GPIO descriptors
      ARM: pxa: Convert Spitz CF power control to GPIO descriptors
      ARM: pxa: Convert reset driver to GPIO descriptors
      ARM: pxa: Convert gumstix Bluetooth to GPIO descriptors
      input: ads7846: Move wait_for_sync() logic to driver

 arch/arm/mach-pxa/gumstix.c         | 22 ++++++-------
 arch/arm/mach-pxa/reset.c           | 39 ++++++++--------------
 arch/arm/mach-pxa/reset.h           |  3 +-
 arch/arm/mach-pxa/spitz.c           | 65 ++++++++++++++++++++++++-------------
 drivers/input/touchscreen/ads7846.c | 22 +++++++++----
 drivers/usb/host/ohci-pxa27x.c      |  5 +++
 include/linux/spi/ads7846.h         |  1 -
 7 files changed, 88 insertions(+), 69 deletions(-)
---
base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
change-id: 20230807-pxa-gpio-3ce25d574814

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


