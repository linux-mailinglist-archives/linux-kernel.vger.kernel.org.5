Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2397ACADB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjIXRLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjIXRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:11:38 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B083FC6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 10:11:28 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id BBAE082064;
        Sun, 24 Sep 2023 19:11:25 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH RFC 0/6] ARM: pxa: GPIO descriptor conversions
Date:   Sun, 24 Sep 2023 18:42:53 +0200
Message-Id: <20230924-pxa-gpio-v1-0-2805b87d8894@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA1nEGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNz3YKKRN30gsx8XePkVCPTFFNzEwtDEyWg8oKi1LTMCrBR0UpBbs5
 KsbW1AHrYMDBfAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=B9DP0CxfWMcnVFBkaCnG2gUKEhrfXwj6FqG5mvPhN24=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlEG27bNYu4Fa4414ypkowuQ+gQAtFotUwZOv2q
 d1cTD9kvnCJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRBtuwAKCRCaEZ6wQi2W
 4ZjQEACo4c4VxqU5rJUdrlr21h4lHp2LcaxM93RzM0JC/NtD2NhGy0N78D0zdx014gLbvRFYIAA
 bZfzf8MOK5SZLUJacCUt2kfxb+wUD3AjCEuS4zjfqhTtGbmR3GFWNun3v4IWmbg1f2h/1wUCMhU
 6nuEx0mtnZlQGwEC8AecRbC1LEcby7IG6Jpj251OYz4xOj+KOZdS1zGpWXQj4D4GASTuTrxqwx2
 uF4+iOkIcE/4zwB4EjYnPtLA6uJIUknSjvedyTZoJ7rD5Hx9T4NWfMl93gzKVnxztoh5di4RGb3
 Ky+tp/JDFU3kQzn0kWbg7CqJNcu3rMF3aUbdvcwKv7qSnCiUWJwhfyElAXChEtJG2latdW2P382
 aMVDogpHYPteq/D1rsyygF2Wi/RlyvBt1OpuQ7oNp5shyrcMigNI5KBvblMWxQRXPfH9FLeVmsU
 aiiM+33n4pZxl2uQaEzpsV/nP1kJuiZ0i664df1bfhllpd47n0vO8b5nmKt6TR8Lb+b/Qo2skUG
 WklpXKEHAbyPFyrrar2UeObzm7s9/1r7Kt4FWuat/+7nBA85QB1rqly/Da4LtO7LE9FnY5AYjTJ
 VT1UfzHTr2l8XIQl/G5onxdXjlkWrYNVrO2xgiFOsCSYnyIOazi2pTb5JejNJB/En1I3rQ4Xw7g
 FunsLXRK7+2dlbA==
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
Duje Mihanović (6):
      ARM: pxa: Convert Spitz OHCI to GPIO descriptors
      ARM: pxa: Convert Spitz LEDs to GPIO descriptors
      ARM: pxa: Convert Spitz CF power control to GPIO descriptors
      ARM: pxa: Convert reset driver to GPIO descriptors
      ARM: pxa: Convert Spitz hsync to GPIO descriptors
      ARM: pxa: Convert gumstix Bluetooth to GPIO descriptors

 arch/arm/mach-pxa/gumstix.c    | 24 ++++++++-------
 arch/arm/mach-pxa/reset.c      | 40 +++++++++----------------
 arch/arm/mach-pxa/reset.h      |  3 +-
 arch/arm/mach-pxa/spitz.c      | 68 +++++++++++++++++++++++++++++++++---------
 drivers/usb/host/ohci-pxa27x.c | 10 +++++++
 5 files changed, 92 insertions(+), 53 deletions(-)
---
base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
change-id: 20230807-pxa-gpio-3ce25d574814

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


