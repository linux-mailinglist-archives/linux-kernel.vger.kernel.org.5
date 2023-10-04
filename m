Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0F7B82F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243203AbjJDO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbjJDO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:56:49 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7F1106;
        Wed,  4 Oct 2023 07:56:45 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 40B8985FB2;
        Wed,  4 Oct 2023 16:56:43 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH RFC v5 0/6] ARM: pxa: GPIO descriptor conversions
Date:   Wed, 04 Oct 2023 16:56:24 +0200
Message-Id: <20231004-pxa-gpio-v5-0-d99ae6fceea8@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABh9HWUC/13NzWrDMAzA8VcpPs/FH1Ji7zQo9AF6HT0kldKYj
 SbYJXSEvHuND53pUZZ/f60icQycxOduFZGXkMJ0ywN+7MRl7G5XloHyLIwyVjnVyvnRyescJmk
 vbJCwBadB5O9z5CE8SupbnI4Hcc6PY0j3Kf6V/KLLqpS8gf/SoqWSxinsXUvOefhKP9Mv78dYG
 oupXVM5k513AA2QbpDozdna+crZ7LrBETKSHuz7PXg5rZSuHGSnBtv7Frlhwspt2/YEBaVpWEw
 BAAA=
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
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2898;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=tf+WaMkbZ4fw3cTAWrz8ILARN03+Z+lJ19o/V170Fjw=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlHX0kbRkpi47vK50yAWc/P4RQKSW6ikhoWnTZ5
 fp2exmKRJaJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZR19JAAKCRCaEZ6wQi2W
 4TQ+EACMpzUC3Se9az5qUawI/RDB3oYQTugMOPObf4fmjBzVTTOz9u33MZPUJ+aKQ3bfkctN+jG
 ESyEO4llc43IeyUY1diDCtuWhGGeJxKxMzKE7iS2NW3JzzL/A3bWvOpK/gHBax5T8dMDyY0ZW4V
 SNhrjV787H7JMZM+kd1Tc1hQguyXP3/UYsQW/4LLVeSvicqzA2D4cZRAxAoiHEKj4va5oywGzP6
 X3LsRA59NRAxEkoBfYGBd7k781vL/87Stg/YtTZjOMB60jSnFzIGk7TNOyYkIacOzxXFjPiIsBo
 BmqgQSbyUnU2OQKYJUMsXv7U1kp54QL1L2LS80yxwSfYmJ1/4MOaKPgqvdUQrWpHfH5zot2l5J/
 koPaGkgUPLyrRD0GBReL9yRMInODWkmbsOwq9hXegBAeUsg60VUbR3ygLqy4MBs7OG5CNP7lSZZ
 6tirQ1nT7Pg9aKgUGcQdF66o9wNJ0aUWAWUDEjtDZSzWyhoDl7e8JM8V8QcSVe9PKDB2xLVQQzp
 hTF3RF84fxMoOUfVmhwekiKdFTKybmZqWb25mll3ustQmUzKAqK/fRuBLX8tw84pvtEzQUKUsIX
 PnvAlvRh7rAxRfnkC5x9FdERT1BnV4r3gj63t9peQ9G6Jn4oRtYVr6FqNOTj88F6xYAZAp3oXEM
 zffXKGjUOoHR+Fg==
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
 arch/arm/mach-pxa/reset.c           | 39 +++++++--------------
 arch/arm/mach-pxa/reset.h           |  3 +-
 arch/arm/mach-pxa/spitz.c           | 69 +++++++++++++++++++++++++------------
 drivers/input/touchscreen/ads7846.c | 22 ++++++++----
 drivers/usb/host/ohci-pxa27x.c      |  7 ++++
 include/linux/spi/ads7846.h         |  1 -
 7 files changed, 94 insertions(+), 69 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230807-pxa-gpio-3ce25d574814

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


