Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29EA7BE968
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378051AbjJISeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376990AbjJISeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:34:18 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5467BA4;
        Mon,  9 Oct 2023 11:34:15 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 8CE5B84F15;
        Mon,  9 Oct 2023 20:34:13 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH RFT v7 0/6] ARM: pxa: GPIO descriptor conversions
Date:   Mon, 09 Oct 2023 20:33:57 +0200
Message-Id: <20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJVHJGUC/13Pu2rEMBAF0F9ZVEdBr9EjVap8wLJdSCF7xmuRs
 DZSMBsW/3uEikS4HI3OHe6DFcqJCns5PVimLZW03Orgnk5snOPtSjxhnZkSSgsvHF/vkV/XtHA
 9kgIEZ7w0rH5fM03p3qLe2fntwj7q45zK95J/Wvwm26olBWX+kzbJBVdewOAdeh/Ma/lcvuh5z
 i1jU72znVPVBW+MNSgtIB6c7l3onK4uTh6BAOWkj/fMn5NCyM6Z6sSkh+CALCEcHPSu7wfVYQi
 R7DQSRX9wtnd9P9v6ycEEKRBC6Ny+779wKZyzvAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3356;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=9HISThLWXYrKw02vad3s3jjv7OIK+LTjobe89BliE1o=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlJEebqRxXPSHSkqz3VzFiWmCYluOEsVC6FdrVX
 kdBjEH03BqJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSRHmwAKCRCaEZ6wQi2W
 4d/PEACEBwdEFzScJK2AKBhR+Sh2TExixXRhlHrijlQj6TpxuD3ccuPKBwNKoZx1nfg5Z14ao05
 kzPcyamJc9OOofLeF+CSKg1kXy9MnQx4NPmIhk/HiZI5ZkbsbTRPUHhji7GXpD7vy37vLW8SmW+
 U/aVMCAv2sXe3Iism4UxDi4Qgp6khIb4t3K2T2o7efDiM+9aaZOsK/5d5z+lwdTcQfZsYN04//+
 SmnmRIZHrBREnhjCn/M0VF7Y6fXBtfcnxIXY57RfNpRjKCjF1z4gWdVaK/utVHdPBqhUHK4S5YO
 qxxR8DmS9jOLL04bafaq9UR4ayEsQTdmIVmOE26pufWaT1MV8OAyOGuyUxnrqLIWfoDzFnPZGM4
 lHtEhuh6t2CIVK/Yo2H7ym0MoJiZtkGgcr1g7Snch/ktNt3fLXO5WMhO7cgWmPxWQ90eaOIaAF2
 SlRDrw10T7ZMqn2gcbMcszt9tse57mDNwMbFw8UH2C1qWphXlWa7iQ9jMWdDZ1U0Lx76PAbS1Gh
 ozJ0uyhzzM/yc04meQpxIiI7d3+mk5yKmneRV0H96L1j8vC7QGT8Otzqnds8r0Jv3BWdnwcQVoN
 8LY0KS6bRzLQx+4qnIhQQtSv4Bl5dMYZK0dQHvuNsIgTIgRwMUlsk6tJ9wewoObMT3UypmEGldh
 udURqlb2X3xSY3Q==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

 arch/arm/mach-pxa/gumstix.c         | 22 ++++++------
 arch/arm/mach-pxa/reset.c           | 39 +++++++-------------
 arch/arm/mach-pxa/reset.h           |  3 +-
 arch/arm/mach-pxa/spitz.c           | 71 +++++++++++++++++++++++++------------
 drivers/input/touchscreen/ads7846.c | 22 ++++++++----
 drivers/usb/host/ohci-pxa27x.c      |  5 +++
 include/linux/spi/ads7846.h         |  1 -
 7 files changed, 94 insertions(+), 69 deletions(-)
---
base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
change-id: 20230807-pxa-gpio-3ce25d574814

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


