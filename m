Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6775D0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGURvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGURvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:51:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B071A3583
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:51:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fd190065a7so18775605e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689961896; x=1690566696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ojdfqGoqN9wMPFyEHWKiX6qJWJUmz0v105HY/niv+Y=;
        b=t8Lvyy5wDiECXSOYMDnbN+oghMDJZJmmhBs+nvkle/k0rToWwjLlMItctWuAxAnzHq
         jhJInTVsayfDtT62LDAxrRUe7VU35oOF7yh5JgpFO1EwX5HnGrXRbvM0ohhrfefIpv6v
         v4g4zR/3bd9pVOgL7ixmGyu4Hc66slywvnEY2P0lKFjUkYj3sJFy8ZHci9ZtemsCxN08
         unFg/Tc9CyDrrH52VFGnX5VCF6g3rO+oVNmEn/Y0Lip/G534b3J7dV/iOo70bdbQp60y
         rmiIkZWjazW9+p241jQ5WYMybLKKgz8H08JPGHPY7LgdY5OCk9FE39LkxRf95MKVjKoV
         /J+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961896; x=1690566696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ojdfqGoqN9wMPFyEHWKiX6qJWJUmz0v105HY/niv+Y=;
        b=NBos8pz94oHINMhh3udCAwMnjyzS3X+6CE83UON0LTMIg4mqQbXGiwMSW281gzg75F
         1fp0rZNj3yI5GA3a2LKUmofZvtRPAjjIeGDhdU5j/fBa6tB5h16ZF747Mb5kDJfgPNq2
         Sk+D3cYtLCCcfK2FH/gST+OR6IDtj00F9WslP8Kpy+ePkeoVxRifh69N1TYSXhXu9/Gs
         Z0eSVgwH/6SIOd5vYXHVA4yzD8kPhPWoq04aDNVGTsuSD7bkdbSY9Dqs1tBxUA86iOcC
         2Wkgj+e16jqDDC1CAI0iNn89VtFulJsx5pVtdgiDcoZRKlaB3Z7Kno8lFFynEoGOkXmn
         k46A==
X-Gm-Message-State: ABy/qLbzA7FPusHJ9Bbn2GkvhOzIMSnnsU6/12cbkc46OO34Aw0mupgP
        V5TesWJUC3NEj1sgVrXqarWbXg==
X-Google-Smtp-Source: APBJJlHJaS4CERW0iy34ejO1x8ourdNPO2vwtJjMWG9yVT4Fd4Q/Wn8WBoRcLjYrIpCnuU6SrWxsmw==
X-Received: by 2002:a5d:610a:0:b0:314:1d88:f072 with SMTP id v10-20020a5d610a000000b003141d88f072mr2161741wrt.25.1689961896116;
        Fri, 21 Jul 2023 10:51:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:112:80d4:c836:2d2c])
        by smtp.gmail.com with ESMTPSA id n8-20020adfe348000000b00315af025098sm4815128wrj.46.2023.07.21.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:51:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.5-rc3
Date:   Fri, 21 Jul 2023 19:51:34 +0200
Message-Id: <20230721175134.186223-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of fixes from the GPIO subsystem for the next rc.

Thanks,
Bartosz

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5-rc3

for you to fetch changes up to 644ee70267a934be27370f9aa618b29af7290544:

  gpio: mvebu: fix irq domain leak (2023-07-20 14:38:36 +0200)

----------------------------------------------------------------
gpio fixes for v6.5-rc3

- fix initial value handling for output-only pins in gpio-tps68470
- fix two resource leaks in gpio-mvebu

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpio: mvebu: fix irq domain leak

Hans de Goede (1):
      gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Uwe Kleine-König (1):
      gpio: mvebu: Make use of devm_pwmchip_add

 drivers/gpio/gpio-mvebu.c    | 26 +++++++++++++++-----------
 drivers/gpio/gpio-tps68470.c |  6 +++---
 2 files changed, 18 insertions(+), 14 deletions(-)
