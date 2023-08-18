Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A547812B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379359AbjHRSRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379453AbjHRSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:17:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843333C3E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:16:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-3fee06efd6bso454225e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692382615; x=1692987415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wdQTPHFVJUzTLBnT6Boa8lOj/znOn/OEZflwWf8XjmU=;
        b=Mqm1LgATJKgvxJkiNBepKbB409fB4B91nbYGSSxGzvC/Z4O052PgZL4cjf15ONWofk
         G3O67DzGdBBzDlI17GXVPz43EdK6v201U+Q5GwvWjeqVWOYAPcm4Rg9MtHxPG6ZwkiP7
         a98oO03rtU0bZDj+x8FGiqEWMuyCiNTNKO2/K2MjDdowRzPd4uYRtu411zOF+FaaeDWR
         eJJCUPPZF6jo5qM9lu8r3oaAxReOCWuz8ePe0O1oPtc+ZcIw5YtL/hLJGkYBqP/i05x1
         Yv7RSpkEpBxW2rpKjxrsmTQ11thBOns5UUQLoPQ4JB2A5IXd6tqiNsKlWC0/Xtt0P9Pw
         1pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692382615; x=1692987415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdQTPHFVJUzTLBnT6Boa8lOj/znOn/OEZflwWf8XjmU=;
        b=MX10XulXzW5pvA26uKOStl4Q65ssxqrIwASP3Ce7xFBhhIk9JbuExu9G4uSTBx7auv
         /0O0Ykr1Kc9ibuKrvuDmOU3DpTSXLvGVpCnfIcmHUCxYrPQVzTZOXgo9GOrJc8vctlSI
         VZejZ9Q0TTrmVeniQK6FxXqxs5CFRV5pUrrmjZmlzTupFQ7fKYmQpYhd0cWZCPfBEn42
         LX39PgriewwvZCnhmFJ2+/bxp3atqhelbJRvMAbNG2UtvqFgvTqx1g2wcUZXu492q0kU
         jE92EMF2ofAe4m0tEAmnbzSM3vTx0/K2ipoiTxHqqwkx0CsiewQlzDW7+WkCirraTu9/
         uKMQ==
X-Gm-Message-State: AOJu0YxEbLgYCn4M7j7No9l0rSiFX9+aPlHGAyI3YJyOkfxVWLjNh8nT
        dMpRhLzEsHr58N4aX5MjsDYazw==
X-Google-Smtp-Source: AGHT+IGrpCUAku0s5dB6vXG61L0urBTHfVd65PuIyvHfLGdfswXIWNOcd40NbN8LNXD0IszcsYVtoQ==
X-Received: by 2002:a5d:4ec6:0:b0:318:416:a56a with SMTP id s6-20020a5d4ec6000000b003180416a56amr5305846wrv.13.1692382614958;
        Fri, 18 Aug 2023 11:16:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d1c5:9f1f:6f05:38a3])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b003140f47224csm3552460wri.15.2023.08.18.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:16:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.5-rc7
Date:   Fri, 18 Aug 2023 20:16:49 +0200
Message-Id: <20230818181649.20814-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following fixes from the GPIO subsystem. Details are in the
signed tag.

Thanks,
Bartosz

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5-rc7

for you to fetch changes up to 3386fb86ecdef0d39ee3306aea8ec290e61b934f:

  gpiolib: fix reference leaks when removing GPIO chips still in use (2023-08-16 13:35:50 +0200)

----------------------------------------------------------------
gpio fixes for v6.5-rc6

- fix a regression in the sysfs interface
- fix a reference counting bug that's been around for years
- MAINTAINERS update

----------------------------------------------------------------
Andy Shevchenko (1):
      gpiolib: sysfs: Do unexport GPIO when user asks for it

Bartosz Golaszewski (1):
      gpiolib: fix reference leaks when removing GPIO chips still in use

Michael Walle (1):
      MAINTAINERS: add content regex for gpio-regmap

 MAINTAINERS                  |  1 +
 drivers/gpio/gpiolib-sysfs.c |  7 +++++--
 drivers/gpio/gpiolib.c       | 16 +++++++++++-----
 3 files changed, 17 insertions(+), 7 deletions(-)
