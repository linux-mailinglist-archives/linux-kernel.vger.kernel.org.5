Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB507FD654
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjK2MJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjK2MJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:09:09 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3EDE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:09:15 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d279bcce64so4796647b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701259755; x=1701864555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZSr6rQHau8MO7tZUGmumMJZcmC8BlwDTZpr5Z2aRZIc=;
        b=N1qIwRk7DcQkI2LeJc/AIAkNCSvXncBESWESRvTdWPOqxXlre170ruoDAZzOZh755D
         Wznh06qBPIBUMcp+HvFa8Ei+le3c522MpHt/vaR/kKuTIOE39Q28d9wFXrGKiL2+mWl5
         aSMEN6yKCS9SngtnjpqaZvd2rJcwD8VZVprYT7aM9ejyjy4Cpe8XMAqTSiDsraE3gAQY
         4PfqdLFvTa/2Dj750LkH79FMo2xCrYigdAM4pw10wYBpY9Ew+Yegiaw2wuSIDi1h8dYa
         wZ9EI88N+NHW9Ytg9l/OM2Yrloyw85Cxk+oFpMTqGU5G4M9Kc4Df+zVZOf0PM2xqcESr
         BOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701259755; x=1701864555;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSr6rQHau8MO7tZUGmumMJZcmC8BlwDTZpr5Z2aRZIc=;
        b=QfMy1Vru/DWFTkwBvopAX+CPDbZZ1nW2qczojOqKS0ea1lpMIcor7nJ9Oj5eHGUrL1
         Q34bquupMYHT1yRLXohb/sWQFpIurpIGeOeY+qmSibNCmKCgHWdPssTuBh6tYXA8/Uxo
         bRbHuCoBLlQELeGQhYbFrlFGa/vRnV5XwY/fV3u/MWXi7xVrnff3DCHfVHqHoMeo+z1l
         CPcZu+vXNSB30aYV8RWSY7UJDiIagx/r5NmJ08FRu6nBRrnGlD0tJP/Jw2UE4E+tnE3G
         5z2qZnb5n8J3Hxrox7SEKVide35wSerYW9Z5tj61Ctj1KHfi+E4H/VpTVyfCLfY36YtC
         1asA==
X-Gm-Message-State: AOJu0Yyqi58wCRZCwRjJ1SBB5ghdq0vO9iG6hflhK5+OcWNBRjJaND+s
        C7MeSSzhTrwWc2WZsRrQ5QVZM8XDo4UyJyb268d4sg==
X-Google-Smtp-Source: AGHT+IH6JmLCX/Ua5iQPL4qC+Z6sBA9I2zbRBkLCLpvFOiskMyUh6g7GBo6ZiHupJDMVhzO5hR/0/O810sivJT9SRIs=
X-Received: by 2002:a05:690c:4613:b0:5d0:1d51:2e10 with SMTP id
 gw19-20020a05690c461300b005d01d512e10mr9159385ywb.23.1701259755133; Wed, 29
 Nov 2023 04:09:15 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Nov 2023 13:09:03 +0100
Message-ID: <CACRpkdZtVNZFWSUgb4=gUE2mQRb=aT_3=zRv1U71Vsq0Mm34eg@mail.gmail.com>
Subject: [GIT PULL] Pin control fixes for v6.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maria Yu <quic_aiquny@quicinc.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Chester Lin <clin@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this is a first belated round of pin control fixes for the v6.7 series..

The most interesting patch is the list iterator fix in the core by Maria
Yu, it took a while for me to realize what was going on there.

Some details on the fixes are in the tag.

Please pull them in!

Yours,
Linus Walleij

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.7-2

for you to fetch changes up to 90785ea8158b6923c5d6a024f2b1c076110577b5:

  dt-bindings: pinctrl: s32g2: change a maintainer email address
(2023-11-24 11:21:55 +0100)

----------------------------------------------------------------
Some pin control fixes for the v6.7 cycle:

- Fix a really interesting potential core bug in the list iterator
  requireing the use of READ_ONCE() discovered when testing kernel
  compiles with clang.

- Check devm_kcalloc() return value and an array bounds in the STM32
  driver.

- Fix an exotic string truncation issue in the s32cc driver, found
  by the kernel test robot (impressive!)

- Fix an undocumented struct member in the cy8c95x0 driver.

- Fix a symbol overlap with MIPS in the Lochnagar driver, MIPS
  defines a global symbol "RST" which is a bit too generic and
  collide with stuff. OK this one should be renamed too, we will
  fix that as well.

- Fix erroneous branch taking in the Realtek driver.

- Fix the mail address in MAINTAINERS for the s32g2 driver.

----------------------------------------------------------------
Antonio Borneo (1):
      pinctrl: stm32: fix array read out of bound

Charles Keepax (1):
      pinctrl: lochnagar: Don't build on MIPS

Chen Ni (1):
      pinctrl: stm32: Add check for devm_kcalloc

Chester Lin (2):
      pinctrl: s32cc: Avoid possible string truncation
      dt-bindings: pinctrl: s32g2: change a maintainer email address

Linus Walleij (1):
      pinctrl: cy8c95x0: Fix doc warning

Maria Yu (1):
      pinctrl: avoid reload of p state in list iteration

Tzuyi Chang (1):
      pinctrl: realtek: Fix logical error when finding descriptor

 .../bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml           |  2 +-
 drivers/pinctrl/cirrus/Kconfig                              |  3 ++-
 drivers/pinctrl/core.c                                      |  6 +++---
 drivers/pinctrl/nxp/pinctrl-s32cc.c                         |  4 ++--
 drivers/pinctrl/pinctrl-cy8c95x0.c                          |  1 +
 drivers/pinctrl/realtek/pinctrl-rtd.c                       |  4 ++--
 drivers/pinctrl/stm32/pinctrl-stm32.c                       | 13 ++++++++++---
 7 files changed, 21 insertions(+), 12 deletions(-)
