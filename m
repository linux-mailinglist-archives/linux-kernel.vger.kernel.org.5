Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336A57AEFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjIZPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbjIZPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:46:54 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D56127;
        Tue, 26 Sep 2023 08:46:46 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 3D67E833AA;
        Tue, 26 Sep 2023 17:46:33 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH RFC v2 0/6] ARM: pxa: GPIO descriptor conversions
Date:   Tue, 26 Sep 2023 17:46:21 +0200
Message-Id: <20230926-pxa-gpio-v2-0-984464d165dd@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM38EmUC/0XM3QrCIBQH8FcZ5zpDnaLrKgh6gG5jF2ue5qGYQ
 0MWY++eeNPl/4PfBgkjYYJTs0HETInCXII8NDD6YZ6QkSsZJJctt9ywZR3YtFBg7YhSO22UFQr
 KfYn4pLVSd7hdL9CX0lP6hPitfBZ1qlIn1V/KgnEmLdcPa5y1nTqnV3jj0Ufo933/AWgyee6kA
 AAA
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=kqhcIgA+c1p20ruAULqaoqV6whyH4z56OXFjmXMMryE=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlEvzWBQEqqKBPaHb7u5f9p6t5jZu+JSmFjLYIP
 ESkLEzJC66JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRL81gAKCRCaEZ6wQi2W
 4frvEACSdmt58LurhpjyINqYLP8c6F4nNjDdEdaKG+h2Iha5JQ0BIbtr3evh7ZH/m0EI4uBKvok
 AsEb5gcypshbuCiTBY3bF5sOupIgiNlFtoAEyXNAbXXgjYap1GV2CXc0RUJQF5J5AJB1V6MafFB
 ZOBnwXBpvCGqTCiVFYE0d9Wp3RDR7tYbvQ2shDvXFxyg+Mw3ky2ho7jCFH10PZNh9TgJkyHA5Rz
 QZ9Q5euqdKl5XEeRT7ro1aDO65kIvrNiMTrDo0QwA3UtGdI18sPHWFSmemw5lafrUE2OMJZVE0H
 0b5nu4qzI574hm7u7n/YqbBqdUO5h8d9EBr5inb+jcFl0hJ5hnF8S3fisUEKwdtC3q9DFghI3ZJ
 Ctrij4pjKquiz/O3W12WWe2NcN1KRKOHMVTfaHt1H3qCkXMPL5ZUQDfNNOSY+NBEtujfHOUqKh1
 YmyqXeAMjRpUyc+kjwbnNLN44+Z4SKBhnH2X4spBpvWyJOjPITU+PH3KAJV7+vlxwBdZDrMZlT3
 duwowZQHKf7IMx+jZQ+CdrK5msKFSKnYad/ebSyYwSmyLchW8euXUwMm/jEADNZrWXdvhZ7yvXk
 YeZXKMR8Rctwi/uo9iP0brtT9cG7bVV6Y2pIq6AVq7Vq8mMHUlu8kBmKle75+cWZKQTvaoN68ni
 1UdyUM3845LLdgA==
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
      ARM: pxa: Convert Spitz hsync to GPIO descriptors
      ARM: pxa: Convert gumstix Bluetooth to GPIO descriptors

 arch/arm/mach-pxa/gumstix.c    | 24 ++++++++-------
 arch/arm/mach-pxa/reset.c      | 39 ++++++++---------------
 arch/arm/mach-pxa/reset.h      |  3 +-
 arch/arm/mach-pxa/spitz.c      | 70 +++++++++++++++++++++++++++++++++---------
 drivers/usb/host/ohci-pxa27x.c |  7 +++++
 5 files changed, 90 insertions(+), 53 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230807-pxa-gpio-3ce25d574814

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


