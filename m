Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221DE7FDAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjK2PSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjK2PSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:18:11 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF93D5D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:18:18 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5cbcfdeaff3so70775677b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701271097; x=1701875897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ww7Q/9ceLBE3UsdAE5GfPj/48ajdec2+lwr+X82WcYU=;
        b=pwPjQlBRRKKvKA+D2rWvEslRW96hXjxoYYIe+tA2Y5yu2ZNrf04zabkP+ugHLv85j+
         INydDO+F9jTj4k3xXIanEZtI7R0BJheN87MyWksOJBU6EXa2mxTdlT9XMd76B3BIlc79
         Icgw7dOSDmThJs4t5BnlrDO2EKD2kFqqz4XP5jUj28CLsmYXa/vZn9Al37Xp7GNoOh1F
         ZC/CWZLAIM8xbcdQVO/+FOyCcPWofgvtM4ZZHU6jMIEBUioGwlnG2aJw7mLVmeisOfor
         AJ8sFy4Y7MbyYDSbCcOEyDGxbUIok5WqHNNKIuMq7bf1fiGZXsSo3l/xw/o1S2WBpZ2O
         +x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271097; x=1701875897;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ww7Q/9ceLBE3UsdAE5GfPj/48ajdec2+lwr+X82WcYU=;
        b=N9mbe9uh1/lDefVUF9qcjBYRpFmFthArZILHiRDO5+bBj58MUG9CqY3brtqj5Fh/Tk
         pd2letH6dL7Hf7r43YPAHUVLMfnF+3qRS5irB/D2ENAQJbInruXF4Uw0jCP1N7Om+ZjE
         qNqKUXUAL+7d6lm/FMpF78vrT5/Z2YfC3SBlT9JcAL1QLimrQ9u+1Pa+yj24uG95YqQG
         UG+dmKXNaYqpLwWHA8cEhDIKIuuq54JESkFZyraGKTTEXQ7p8x0g5kEK31YcSW+t2ZsU
         I0J+/WcSfWFdOb0GaZTpv8BD26X8hequGyBBiRa4mZX1lT8kshpG01pwIvN8jBwwMRgz
         mxeQ==
X-Gm-Message-State: AOJu0YyJdJzt7nknLEJ0b990M+wOaejoKrgbUPLuvYsMka9IDR74SpfO
        NvRE/xQLBOkuE3GYxxAQDwFsZGpwmnc53dbawPFKcw==
X-Google-Smtp-Source: AGHT+IEPT8Ws9NesmQWHMj5hZjPO3G5T4wYj+FYaoP8AFc5k6U1UkImn6UdXy1tcfwJdMRyJhtpysDaGAYEdS/bdlEY=
X-Received: by 2002:a0d:df92:0:b0:5c9:d16b:a11b with SMTP id
 i140-20020a0ddf92000000b005c9d16ba11bmr15635597ywe.36.1701271097463; Wed, 29
 Nov 2023 07:18:17 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Nov 2023 16:18:06 +0100
Message-ID: <CACRpkdb8dwq7OYUFuyjJCv7VN9mH1zEmibcOwgFip0wDv5H1gA@mail.gmail.com>
Subject: [GIT PULL] Pin control fixes for v6.7 minus one patch
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maria Yu <quic_aiquny@quicinc.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is an updated tag on a branch where the only change
is to drop the locking READ_ONCE() patch until we know
more about what is going on here.

Remains: driver fixes.

Some details on the fixes are in the tag.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.7-3

for you to fetch changes up to 650d240056059296168b24ba47e76bafa37c0646:

  dt-bindings: pinctrl: s32g2: change a maintainer email address
(2023-11-29 16:11:52 +0100)

----------------------------------------------------------------
Some pin control fixes for the v6.7 cycle:

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

Tzuyi Chang (1):
      pinctrl: realtek: Fix logical error when finding descriptor

 .../bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml           |  2 +-
 drivers/pinctrl/cirrus/Kconfig                              |  3 ++-
 drivers/pinctrl/nxp/pinctrl-s32cc.c                         |  4 ++--
 drivers/pinctrl/pinctrl-cy8c95x0.c                          |  1 +
 drivers/pinctrl/realtek/pinctrl-rtd.c                       |  4 ++--
 drivers/pinctrl/stm32/pinctrl-stm32.c                       | 13 ++++++++++---
 6 files changed, 18 insertions(+), 9 deletions(-)
