Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A87C671D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377624AbjJLHVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347092AbjJLHU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:20:59 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5F6B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:20:57 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7a77e736dso8407307b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697095257; x=1697700057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ppSgknBSf9vKWWkfpc+8Grk5QN8Ns1pPJYktX3W4Dhg=;
        b=nsG9hmkwKM61nbezXl0kLIGM0tmpv0BYamr+o6q+sVTVgEUJYp68szpyqvjjZuTxCR
         LmvpiU4GnPqfOtwo8A9qsMa2MI4tWyluMt3WutKsfa9LWSOmHPBLKe6HN9XoWjbk34SU
         ZWfFbF6S0iPzM7xB3XRNbA6M7F26m+CBFTJvdw+W2FPxDfj9Cp5TA2lt3ymkaE7g51xm
         Xd/zoQibxetyTFhuXrJvkBevhYTkNTmv77ptm7plEXHrSZTzLfeuQuUUG8TfILC7EjCI
         PRMFyGE2agz08seP4X6JB4ny+WiDQG+g9pm1qs7Z39VuuigPasAXfgP1LLiXEUXGCwLg
         c24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697095257; x=1697700057;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppSgknBSf9vKWWkfpc+8Grk5QN8Ns1pPJYktX3W4Dhg=;
        b=oBCn2JGvoTDqk4WRCkL3SwsgTSkSUnMO0ac+LZPd52KH2TjLn9PcyzPwc0AUlgMDLu
         68cIzLP6LWyCZ8pzYc+av5U1q0anApTMTJVjSqUS46gmkFdI5EsSDob0CiWk1wsB9nRz
         tyM6oB9pE7Qp8ZXmR77JZnkU00FpZ3wI6rYiuJN9JoE0W4eEnhWyMZqx3PbrvSnblfjV
         eAVDKJ4Vox+KOonePRENjMTHZ3e06ueicQR1N12qXhdMpzIn2z3sg9TSJG+CE4Klgady
         9ZuqZiYqujfqp6G5J4n/4iDVUmVD1kfirBvorc68PZD49lq6nBldcEweV7zjf0FQLZy2
         28+w==
X-Gm-Message-State: AOJu0YyV02Ur57rfeisWoAaDhNMzy6pA9mNa4l1rgyjto3nOX9dSBWqS
        o+AVgqv+sXr3T9Bu0B7nI36Fk2evO6nP3Fj74SlQbQ==
X-Google-Smtp-Source: AGHT+IHWYIrqx2CW9MmMpdwqzkeqvl8JTxH84Jh3z9OqyBWkjDBHz6q309zTMxdLX2QvK4nzPk2Y/5Vz7aNERZzcPog=
X-Received: by 2002:a81:5283:0:b0:59f:6133:e61c with SMTP id
 g125-20020a815283000000b0059f6133e61cmr24817509ywb.7.1697095256770; Thu, 12
 Oct 2023 00:20:56 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Oct 2023 09:20:46 +0200
Message-ID: <CACRpkdbj9V3S7NWzetOngMyJMygNpiYwZKMM+H4zuX227Sof=Q@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v6.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some pin control fixes for v6.6 which have been stacking
up in my tree.

Dmitry's fix to some locking in the core is the most substantial,
that was a really neat fix.

The rest is the usual assorted spray of minor driver fixes.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.6-2

for you to fetch changes up to f055ff23c331f28aa4ace4b72dc56f63b9a726c8:

  pinctrl: renesas: rzn1: Enable missing PINMUX (2023-10-12 09:10:40 +0200)

----------------------------------------------------------------
Pin control fixes for the v6.6 series:

- Drop some minor code causing warnings in the Lantiq driver.

- Fix out of bounds write in the Nuvoton driver.

- Fix lost IRQs with CONFIG_PM in the Starfive driver.

- Fix a locking issue in find_pinctrl().

- Revert a regressive Tegra debug patch.

- Fix the Renesas RZN1 pin muxing.

----------------------------------------------------------------
Dmitry Torokhov (1):
      pinctrl: avoid unsafe code pattern in find_pinctrl()

Hal Feng (2):
      pinctrl: starfive: jh7110: Fix failure to set irq after
CONFIG_PM is enabled
      pinctrl: starfive: jh7110: Add system pm ops to save and restore context

Linus Walleij (1):
      Revert "pinctrl: tegra: Add support to display pin function"

Mikhail Kobuk (1):
      pinctrl: nuvoton: wpcm450: fix out of bounds write

Ralph Siemsen (1):
      pinctrl: renesas: rzn1: Enable missing PINMUX

YueHaibing (1):
      pinctrl: lantiq: Remove unsued declaration ltq_pinctrl_unregister()

 MAINTAINERS                                        |  1 +
 drivers/pinctrl/core.c                             | 16 +++++----
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c          |  6 ++--
 drivers/pinctrl/pinctrl-lantiq.h                   |  1 -
 drivers/pinctrl/renesas/Kconfig                    |  1 +
 .../pinctrl/starfive/pinctrl-starfive-jh7110-aon.c |  4 +++
 .../pinctrl/starfive/pinctrl-starfive-jh7110-sys.c |  4 +++
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 42 ++++++++++++++++++++--
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h |  4 +++
 drivers/pinctrl/tegra/pinctrl-tegra.c              | 19 ++--------
 drivers/pinctrl/tegra/pinctrl-tegra.h              |  2 --
 11 files changed, 68 insertions(+), 32 deletions(-)
