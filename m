Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC047BB98B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjJFNpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjJFNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:45:14 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE7B83;
        Fri,  6 Oct 2023 06:45:11 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 2CF8283E79;
        Fri,  6 Oct 2023 15:45:10 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH RFT v6 0/6] ARM: pxa: GPIO descriptor conversions
Date:   Fri, 06 Oct 2023 15:44:24 +0200
Message-Id: <20231006-pxa-gpio-v6-0-981b4910d599@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADgPIGUC/13PvW7DIBDA8VeJmEvE12Ho1KkPUHWrMhDfEaNWs
 QWVlSryuwcxpMjjwf3+iDsrlBMV9nq4s0xrKmm+1sG+HNg4heuFeMI6MyWUFk4MfLkFflnSzPV
 IChAG46RhdX3JFNOtpb7Yx/snO9XDKZXfOf+1/CrbVSt5Zf5Lq+SCKyfg7AZ0zpu38j3/0HHKr
 bGq3tnOqeq8M8YalBYQd073zndOVxeiQyBAGfX+PfN0UgjZOVOdiPrsByBLCDsHvev/B9Wh94F
 sHImC69y2bQ+Ih4j0hAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3136;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=vI2UBZDMwp1KnzrvD4DKMizRjoWa7ZGUogcX2qCrlnU=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlIA9dcgrmj3+YmkuDPQ6NB90jclsxEluTaVbHA
 jRr7Yra0xyJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSAPXQAKCRCaEZ6wQi2W
 4ZLQD/9QfHwozzzavQqJBgavxYYXaezwWXw2/D6c76kmN7beMOJcorpY5WFtW1AHbAw40nTp0Hm
 UiOfHm8ovkbt8ht39EHQxpRZq1dX9Gak3M/wM9YlGday2HbdU8SeHPCWNnNNEY/mqQRUYdtPKm7
 ot6COA8GuXOuQg/TyE/uu8EMn9Zr/DcafHxF0CkBJ2/rj5aBfPEcglnqedZ7mBdjTSfS9egIv80
 zb+2Re2b1bkPSVMBm9FCnDVimn8VTYoUtRmrbv6XqFYDAgn0zZH3uvH6WZ3ypnv7KomCZlR2G/O
 pJvFE/HsqsCSN3o/Lhz9EKMDXjeDkrl1H9CfrsjELwxlt9QzRTxP7jCMckZ1aWXGwl9M8mpAyvT
 /R1/Nw9YiVZIYtcsipz20DLyl0Sjmcyy2rvVtgqBKYbOWqksTv/irBxOH9mYHAy3iYlqa8U568m
 6JH6lPJJKP7acwSe2F1+ct1VOM1xNQtl5FpEe31gYay4NVA3cHB35p0JPpmkF1hBFbJg2jCy4V+
 sXzXQQWePzn/DYetDOTNp9ol2Q2I9Lm5zWxK7VRwaiDNEZfA9bCg9GpbpNRHIY7hfO96495p0pw
 +gWzvAWKaE/IrDVOkvBGa5lKqSbBp6iHY97ByUxuf6LXZOf7pb98+0Y7MxU0pGiRkNfzZQ/hzNb
 DstjqmARBtK1Dvg==
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

 arch/arm/mach-pxa/gumstix.c         | 22 ++++++------
 arch/arm/mach-pxa/reset.c           | 39 +++++++-------------
 arch/arm/mach-pxa/reset.h           |  3 +-
 arch/arm/mach-pxa/spitz.c           | 71 +++++++++++++++++++++++++------------
 drivers/input/touchscreen/ads7846.c | 22 ++++++++----
 drivers/usb/host/ohci-pxa27x.c      |  7 ++++
 include/linux/spi/ads7846.h         |  1 -
 7 files changed, 96 insertions(+), 69 deletions(-)
---
base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
change-id: 20230807-pxa-gpio-3ce25d574814

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


