Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3888D7B47DD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjJAONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjJAONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:13:06 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D04A4;
        Sun,  1 Oct 2023 07:13:02 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 3C232836A5;
        Sun,  1 Oct 2023 16:13:01 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH RFC v4 0/6] ARM: pxa: GPIO descriptor conversions
Date:   Sun, 01 Oct 2023 16:12:51 +0200
Message-Id: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGN+GWUC/13NSw7CIBCA4as0sxbDY2ipKxMTD+DWuKiFWqIpD
 RhS0/TuEjYSl8Pw/bNCMN6aAIdqBW+iDdZNacBdBf3YTQ9DrE4zcMoFVbQh89KRx2wdEb3hUss
 GFUNI32dvBrvk1BUu5xPc0uNow9v5T85Hlle51HL8lSIjlHBF5V01WqkWj+HpXmY/+tyIvHR14
 XhyrUKsUbNaav3nROnawonkukFpaaRmgyjvbdv2BXLmtYoUAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=m8bKiHpWAVkzZ4rX+3MqXGTQKxlWpvxpDzrmC6PtKks=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlGX5nOeDT3j+PeN8XmO9hsa7Y0m/xSrsaviidP
 P5CN29YWYyJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRl+ZwAKCRCaEZ6wQi2W
 4b/FD/0cgXaU50cz0P86RkEXyT6bFJth3AXwlIJKthxeagxMpUY5yEUqu/T8p8LCOUDexyoLiCl
 6kUUOumwEsISsqpv+i4HXGcxRa5bLHWNAm3gXyr2KpAxUA0xnqT300mUeEqeRQCqJOYEgCMdTFi
 EXCArOgqWkm9INcLP7yGavJ33xgosZeOjnoWaa8uQm4wqohD3wOF4fvCFqiSPFpRvtMmGnvnziu
 o/TQ2MPZORRpb8fH5GIHj07lDkk5Yu40hVEgRy1p74jVxyB9JFyHsQsM14dV8nQ6ITW/596db+v
 ldXimOvDHfUH4z5bc4D6GhvIUxpCwCO8CCYPPwxobz8TDhM1UApBu809kONvOMXdQxq4hIoedcD
 M+hE1KV2BTj7vTvD5XeiNTM0xr0a1iVKOPqcUXRWnjl/Of2zDf5kWWvggXDp/ngD06rBEQbYkAN
 OxpsNpPK1qrMH0/7AqrPt9EvGdtfhWok3aevethRNvzBJP19asFySsuY9zQ9Q1wArwvgAdA8YB8
 uLMTl85cku91uvG88Z6GsnR0qq4/Wv8x6iHZImb77tWbfmpCqyEkj3RsNCdYGMqGJF4i2BDUWMX
 PWqi/v8BGbET6E33UF1dxi3MQtJd3WHpoX+5XoBjgMlbe/nlJ5llpB+iEKSrHbirBoiIlxGitMV
 iwbjBf5fmjzM4Ng==
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

 arch/arm/mach-pxa/gumstix.c         | 24 +++++++------
 arch/arm/mach-pxa/reset.c           | 39 +++++++--------------
 arch/arm/mach-pxa/reset.h           |  3 +-
 arch/arm/mach-pxa/spitz.c           | 69 +++++++++++++++++++++++++------------
 drivers/input/touchscreen/ads7846.c | 22 ++++++++----
 drivers/usb/host/ohci-pxa27x.c      |  7 ++++
 include/linux/spi/ads7846.h         |  1 -
 7 files changed, 96 insertions(+), 69 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230807-pxa-gpio-3ce25d574814

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


