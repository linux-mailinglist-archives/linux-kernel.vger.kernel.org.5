Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B7792C18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353799AbjIERGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343809AbjIEQNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 12:13:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E224E5B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 09:11:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso41250151fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693930202; x=1694535002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n/KyUO/sa6gqqYs1yT3Nm14BvzcgjwW1Ne74cTn1CUM=;
        b=oVZhv/8x62rKQLuaPUfE4vGbepINmuW5KFecpEOzQLn4Nf/nelSj6qNVGvyVqU3vzk
         InEBeR0QfC5r3djMggjqOotKnyWXWrbmuW0xWhUJwmCUfBTRax9ceU7FgMe50fvEpZgw
         6IWdl10QYsSSEupGeqW21AIXijVN97jbdVs5Nq0w5zGoUTp6+J13EqIT0aVVbTOTKkwd
         jFYa2xiBDJ8FxdCenl8X8WaUe1/KFkAkNDcoStIHk2K2BzqUmOOk20iundWwb8tpsBSy
         aHLY0m/OhgeHxxsgo0wjyVFRRnyypKzIny3QIYjaytxr0WcH6wHOiUk6MeBKJ7/r3yzp
         ySUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693930202; x=1694535002;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/KyUO/sa6gqqYs1yT3Nm14BvzcgjwW1Ne74cTn1CUM=;
        b=elaGRVVTardW/ZshB3CVWluQYY9EC3e0+u7u1anqNxnEyBZhGhOLewzXL9zvoIhJBB
         uKepmrJWjM0e3BJZb/j/yAsGUhTJUdTUEJGcy+l1QWa0sjj66MAOYKce7M5Fkd8NuQCq
         SXK1phRSlCWJl80yoZ7V/lc7eUs1Dfm5x9VmbFVMeIFj/vsXfy2dksddlli/MbRCImPN
         Heh3ox0m5GqU+bOMEYZXkGQSkcNdM82Jz6VUJFeivUpQploRY98VGSsQuW4JXPj0aE1r
         lvNW+WMtH3Xm5PNxf3+Gt1RXbh4x3MQiMVpmmPRdOq3KQ2AP6afGEH+gIXcTtsZD9EmO
         z4pA==
X-Gm-Message-State: AOJu0Yx6l1Uzi9DaYjT8x/Xa2+s+ZbibK8cIzqu1cBVNH8ho0j0EVVNC
        SRv7bQn5QWZMmnJA9Lkb/9OuSE7+Dp+sfxp4PLCVYm6EfJs=
X-Google-Smtp-Source: AGHT+IGKKH28Q5RWM72lIVd16anUtTMnf0abN/Xx+LBe+qmO2X9Dvt9W4x2tshusdkkW9lVUi6TNT8E8+1MQrJeVfws=
X-Received: by 2002:a17:906:3044:b0:9a4:88af:b7b with SMTP id
 d4-20020a170906304400b009a488af0b7bmr217086ejd.62.1693929771174; Tue, 05 Sep
 2023 09:02:51 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 5 Sep 2023 11:02:40 -0500
Message-ID: <CABb+yY1SbO_reb0kd9oyq8NZ89iZgVG4ab8etQMQOaNQAnsQ4g@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 706a741595047797872e669b3101429ab8d378ef:

  Linux 6.5-rc7 (2023-08-20 15:02:52 +0200)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v6.6

for you to fetch changes up to a493208079e299aefdc15169dc80e3da3ebb718a:

  mailbox: qcom-ipcc: fix incorrect num_chans counting (2023-09-05
10:11:01 -0500)

----------------------------------------------------------------
qcom: fix incorrect num_chans counting
mhu: Remove redundant dev_err
bcm: fix comments
common changes:
convert to use devm_platform_get_and_ioremap_resource
correct DT includes

----------------------------------------------------------------
Jonathan Marek (1):
      mailbox: qcom-ipcc: fix incorrect num_chans counting

Li Zetao (1):
      mailbox: ti-msgmgr: Use devm_platform_ioremap_resource_byname()

Minjie Du (1):
      mailbox: mailbox-test: Fix an error check in mbox_test_probe()

Rob Herring (1):
      mailbox: Explicitly include correct DT includes

Ruan Jinjie (1):
      mailbox: platform-mhu: Remove redundant dev_err()

Yang Li (1):
      mailbox: bcm-pdc: Fix some kernel-doc comments

Yangtao Li (5):
      mailbox: bcm-ferxrm-mailbox: Use devm_platform_get_and_ioremap_resource()
      mailbox: bcm-pdc: Use devm_platform_get_and_ioremap_resource()
      mailbox: mailbox-test: Use devm_platform_get_and_ioremap_resource()
      mailbox: rockchip: Use devm_platform_get_and_ioremap_resource()
      mailbox: tegra-hsp: Convert to devm_platform_ioremap_resource()

 drivers/mailbox/arm_mhu.c            |  1 +
 drivers/mailbox/arm_mhu_db.c         |  1 -
 drivers/mailbox/bcm-flexrm-mailbox.c | 10 +++-------
 drivers/mailbox/bcm-pdc-mailbox.c    | 18 ++++++------------
 drivers/mailbox/hi3660-mailbox.c     |  1 +
 drivers/mailbox/hi6220-mailbox.c     |  1 +
 drivers/mailbox/imx-mailbox.c        |  3 ++-
 drivers/mailbox/mailbox-mpfs.c       |  1 +
 drivers/mailbox/mailbox-test.c       |  8 +++-----
 drivers/mailbox/mailbox.c            |  1 +
 drivers/mailbox/mtk-adsp-mailbox.c   |  3 ++-
 drivers/mailbox/mtk-cmdq-mailbox.c   |  2 +-
 drivers/mailbox/omap-mailbox.c       |  2 +-
 drivers/mailbox/platform_mhu.c       |  5 ++---
 drivers/mailbox/qcom-ipcc.c          |  4 +---
 drivers/mailbox/rockchip-mailbox.c   |  8 ++------
 drivers/mailbox/sprd-mailbox.c       |  2 +-
 drivers/mailbox/stm32-ipcc.c         |  1 +
 drivers/mailbox/tegra-hsp.c          |  5 +----
 drivers/mailbox/ti-msgmgr.c          | 16 ++++++----------
 drivers/mailbox/zynqmp-ipi-mailbox.c |  2 --
 21 files changed, 37 insertions(+), 58 deletions(-)
