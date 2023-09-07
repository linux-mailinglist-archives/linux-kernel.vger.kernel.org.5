Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6E797438
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbjIGPgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344319AbjIGPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1AFE49;
        Thu,  7 Sep 2023 08:32:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so1504079a12.3;
        Thu, 07 Sep 2023 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100708; x=1694705508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Anm33g+5dzvXtjWdYbVxFjyCxv+da9wrUjhgUXOLNpI=;
        b=WlZvy1u2VfQahzD1wew9p0jDUUNxg8g/n/bdSYSNKiBmJL7ktH/tn6V+7PSsqtUOiT
         5SZ0uR/klJJ9Qgn49vSGM4O7xrWSbrMiPkYGJyamoGdwUewMIIRwESxCJC3uTm4C780/
         3kNW09Bb0GwwA8SXsC3Hpl6Pa9HkI3xio8k1X2sIO5igAjpLqvK/PoUhdqoDsg/iOB6N
         1r1kpdBgrDyhfpNTz/L0mRXhaqqA/+Uvcsx+DAfpGm3yFrvt7DTy0Klv2r1j480bxtuA
         juKg5wUCD0J9nsgcfC0bRv58Xalek7F+83M1It+mvTiWBIGOGxxYF5zRlVhA1uEYKXcs
         eAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100708; x=1694705508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Anm33g+5dzvXtjWdYbVxFjyCxv+da9wrUjhgUXOLNpI=;
        b=jFlpGlmRFM3iFk6YSZkuQrb1FjCTiNkaPF6wBOyaNVBBfY73NG7Ng8xiYHYRPCjbRA
         iI/WFroWG43QzmGgfjcEuE9+Jz1vE141mz2JiDnSl2wiif1rk8+VeW5+QzTKFimobWUr
         Z78232QcULiORJ1uR5NTagnEjGvryTpFpYzNdn5nHsZ7T+CgbdhM83badVssh0yi2gEi
         fTIRafT5exYR52/4PxlcF5rKrOE5ZmX0lchxeMn8pihmU0Lbys+7y5yz1hON9k9s/8z3
         +2Iw4l1kGlflTZG/4yyRKNRwQpU0MZehVx7DBV3hRrdhUzEveUopq8ujJrzokSWrrryX
         7GxQ==
X-Gm-Message-State: AOJu0YwN+gTBehdFY3Rr6ZCr/OeW2CTmoP7NP0pXNzheyxTbiGhYGpCh
        +oxiN4RAs34p5DiFJZUrM9skpAHCDMA=
X-Google-Smtp-Source: AGHT+IGLdB3VB6GEFhh2lduscEjoVUh+j9EFoWRLJv53K3IliO9AdI22ayjESvSbR/42m/ikSs2BDA==
X-Received: by 2002:a19:6707:0:b0:4fb:9631:4bb with SMTP id b7-20020a196707000000b004fb963104bbmr5289099lfc.11.1694098662260;
        Thu, 07 Sep 2023 07:57:42 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402069a00b0051e2670d599sm10002021edy.4.2023.09.07.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 07:57:41 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v6.6-rc1
Date:   Thu,  7 Sep 2023 16:57:36 +0200
Message-ID: <20230907145738.1185893-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.6-rc1

for you to fetch changes up to 4aae44f65827f0213a7361cf9c32cfe06114473f:

  pwm: lpc32xx: Remove handling of PWM channels (2023-08-22 10:14:16 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v6.6-rc1

This contains various cleanups and fixes across the board.

----------------------------------------------------------------
Biju Das (1):
      pwm: rz-mtu3: Fix build warning 'num_channel_ios' not described

Guiting Shen (1):
      pwm: atmel: Enable clk when pwm already enabled in bootloader

Rob Herring (1):
      pwm: Explicitly include correct DT includes

Stanislav Jakubek (1):
      dt-bindings: pwm: brcm,kona-pwm: convert to YAML

Uwe Kleine-König (26):
      pwm: Use a consistent name for pwm_chip pointers in the core
      pwm: atmel-hlcdc: Use consistent variable naming
      pwm: bcm-kona: Consistently name pwm_chip variables "chip"
      pwm: crc: Consistently name pwm_chip variables "chip"
      pwm: cros-ec: Consistently name pwm_chip variables "chip"
      pwm: lp3943: Consistently name pwm_chip variables "chip"
      pwm: rockchip: Consistently name pwm_chip variables "chip"
      pwm: sifive: Consistently name pwm_chip variables "chip"
      pwm: sl28cpld: Consistently name pwm_chip variables "chip"
      staging: greybus: pwm: Consistently name pwm_chip variables "chip"
      pwm: Remove outdated documentation for pwmchip_remove()
      pwm: Drop unused #include <linux/radix-tree.h>
      pwm: atmel-tcb: Harmonize resource allocation order
      pwm: atmel-tcb: Fix resource freeing in error path and remove
      pwm: atmel-tcb: Put per-channel data into driver data
      pwm: atmel-tcb: Unroll atmel_tcb_pwm_set_polarity() into only caller
      pwm: atmel-tcb: Don't track polarity in driver data
      pwm: lpc18xx-sct: Simplify using devm_clk_get_enabled()
      pwm: pxa: Don't reimplement of_device_get_match_data()
      pwm: ntxec: Drop a write-only variable from driver data
      pwm: ntxec: Use device_set_of_node_from_dev()
      pwm: Fix order of freeing resources in pwmchip_remove()
      pwm: stm32: Don't modify HW state in .remove() callback
      pwm: stm32: Simplify using devm_pwmchip_add()
      pwm: stmpe: Handle errors when disabling the signal
      pwm: atmel: Simplify using devm functions

Vladimir Zapolskiy (1):
      pwm: lpc32xx: Remove handling of PWM channels

 .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |  21 ----
 .../devicetree/bindings/pwm/brcm,kona-pwm.yaml     |  51 +++++++++
 drivers/pwm/core.c                                 |  41 ++++---
 drivers/pwm/pwm-apple.c                            |   1 +
 drivers/pwm/pwm-atmel-hlcdc.c                      |  66 +++++------
 drivers/pwm/pwm-atmel-tcb.c                        | 123 ++++++++-------------
 drivers/pwm/pwm-atmel.c                            |  77 ++++++++-----
 drivers/pwm/pwm-bcm-kona.c                         |   4 +-
 drivers/pwm/pwm-berlin.c                           |   1 +
 drivers/pwm/pwm-crc.c                              |   4 +-
 drivers/pwm/pwm-cros-ec.c                          |  11 +-
 drivers/pwm/pwm-fsl-ftm.c                          |   3 +-
 drivers/pwm/pwm-hibvt.c                            |   2 +-
 drivers/pwm/pwm-imx1.c                             |   1 -
 drivers/pwm/pwm-jz4740.c                           |   2 +-
 drivers/pwm/pwm-lp3943.c                           |   5 +-
 drivers/pwm/pwm-lpc18xx-sct.c                      |  34 ++----
 drivers/pwm/pwm-lpc32xx.c                          |  16 +--
 drivers/pwm/pwm-mediatek.c                         |   1 -
 drivers/pwm/pwm-meson.c                            |   1 -
 drivers/pwm/pwm-microchip-core.c                   |   2 +-
 drivers/pwm/pwm-mtk-disp.c                         |   1 -
 drivers/pwm/pwm-ntxec.c                            |   4 +-
 drivers/pwm/pwm-pxa.c                              |  10 +-
 drivers/pwm/pwm-rockchip.c                         |   4 +-
 drivers/pwm/pwm-rz-mtu3.c                          |   2 +-
 drivers/pwm/pwm-sifive.c                           |   5 +-
 drivers/pwm/pwm-sl28cpld.c                         |  14 ++-
 drivers/pwm/pwm-sprd.c                             |   1 +
 drivers/pwm/pwm-stm32.c                            |  14 +--
 drivers/pwm/pwm-stmpe.c                            |  17 +--
 drivers/pwm/pwm-sun4i.c                            |   1 -
 drivers/pwm/pwm-sunplus.c                          |   1 +
 drivers/pwm/pwm-tegra.c                            |   1 -
 drivers/pwm/pwm-tiecap.c                           |   2 +-
 drivers/pwm/pwm-tiehrpwm.c                         |   2 +-
 drivers/pwm/pwm-visconti.c                         |   2 +-
 drivers/pwm/pwm-vt8500.c                           |   5 +-
 drivers/staging/greybus/pwm.c                      |  12 +-
 include/linux/pwm.h                                |   6 +-
 40 files changed, 281 insertions(+), 290 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
