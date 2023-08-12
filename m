Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C993D779EDC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbjHLKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHLKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:17:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A8270E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 03:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA2A06284F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 10:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C857FC433C8;
        Sat, 12 Aug 2023 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691835447;
        bh=f0tArHTDjI08A3w4aBWzcKnrDU1JEGmb9h+dWZe66WE=;
        h=Date:From:To:Cc:Subject:From;
        b=etijGF+ybPnCuc562llNHL5/cnTly3Xm7b9n/k4CeUU9A0CP2cHsYV/JugOrxAL4u
         /2r61Na8e+D9TqZP5sW/sNf0VkzFyO5k49+3q7GVoCh3kfjp03JUTaoe/soI6gg5D+
         l5mLi/Kcoja15BVxqLZF5i8Ud5w2F2vIxJa4NpP4=
Date:   Sat, 12 Aug 2023 12:17:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.5-rc6
Message-ID: <ZNdcNLteAsSSrH2u@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.5-rc6

for you to fetch changes up to 51a26bb02ae58c7db6b4156d7e1e39cd79008757:

  Merge tag 'icc-6.5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus (2023-08-05 08:35:14 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.5-rc6

Here are some small char/misc driver fixes for 6.5-rc6 that resolve some
reported issues.  Included in here are:
  - bunch of iio driver fixes for reported problems
  - interconnect driver fixes
  - counter driver build fix
  - cardreader driver fixes
  - binder driver fixes
  - other tiny driver fixes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alejandro Tafalla (1):
      iio: imu: lsm6dsx: Fix mount matrix retrieval

Alisa Roman (1):
      iio: adc: ad7192: Fix ac excitation feature

Alvin Šipraga (1):
      iio: adc: ina2xx: avoid NULL pointer dereference on OF device match

Anh Tuan Phan (1):
      tools/counter: Makefile: Replace rmdir by rm to avoid make,clean failure

Dan Carpenter (1):
      iio: frequency: admv1013: propagate errors from regulator_get_voltage()

Esteban Blanc (1):
      misc: tps6594-esm: Disable ESM for rev 1 PMIC

George Stark (1):
      iio: adc: meson: fix core clock enable/disable moment

Greg Kroah-Hartman (4):
      Merge tag 'counter-fixes-for-6.5a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-linus
      Merge tag 'counter-fixes-for-6.5b' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-linus
      Merge tag 'iio-fixes-for-6.5a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
      Merge tag 'icc-6.5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus

Krzysztof Kozlowski (1):
      dt-bindings: iio: adi,ad74115: remove ref from -nanoamp

Matti Vaittinen (3):
      iio: light: bu27034: Fix scale format
      iio: light: bu27008: Fix scale format
      iio: light: bu27008: Fix intensity data type

Mike Tipton (1):
      interconnect: qcom: Add support for mask-based BCMs

Milan Zamazal (1):
      iio: core: Prevent invalid memory access when there is no parent

Neil Armstrong (3):
      interconnect: qcom: sm8450: add enable_mask for bcm nodes
      interconnect: qcom: sm8550: add enable_mask for bcm nodes
      interconnect: qcom: sa8775p: add enable_mask for bcm nodes

Qi Zheng (1):
      binder: fix memory leak in binder_init()

Ricky WU (1):
      misc: rtsx: judge ASPM Mode to set PETXCFG Reg

William Breathitt Gray (2):
      counter: Fix menuconfig "Counter support" submenu entries disappearance
      counter: Fix menuconfig "Counter support" submenu entries disappearance

Yiyuan Guo (1):
      iio: cros_ec: Fix the allocation size for cros_ec_command

 .../devicetree/bindings/iio/addac/adi,ad74115.yaml |  3 ---
 drivers/android/binder.c                           |  1 +
 drivers/android/binder_alloc.c                     |  6 ++++++
 drivers/android/binder_alloc.h                     |  1 +
 drivers/counter/Kconfig                            | 14 ++++++-------
 drivers/iio/adc/ad7192.c                           | 16 +++++++--------
 drivers/iio/adc/ina2xx-adc.c                       |  9 ++++++---
 drivers/iio/adc/meson_saradc.c                     | 23 +++++++++++-----------
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  2 +-
 drivers/iio/frequency/admv1013.c                   |  5 ++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  2 +-
 drivers/iio/industrialio-core.c                    |  5 +++--
 drivers/iio/light/rohm-bu27008.c                   | 22 ++++++++++++++++++---
 drivers/iio/light/rohm-bu27034.c                   | 22 ++++++++++++++++++---
 drivers/interconnect/qcom/bcm-voter.c              |  5 +++++
 drivers/interconnect/qcom/icc-rpmh.h               |  2 ++
 drivers/interconnect/qcom/sa8775p.c                |  1 +
 drivers/interconnect/qcom/sm8450.c                 |  9 +++++++++
 drivers/interconnect/qcom/sm8550.c                 | 17 ++++++++++++++++
 drivers/misc/cardreader/rts5227.c                  |  2 +-
 drivers/misc/cardreader/rts5228.c                  | 18 -----------------
 drivers/misc/cardreader/rts5249.c                  |  3 +--
 drivers/misc/cardreader/rts5260.c                  | 18 -----------------
 drivers/misc/cardreader/rts5261.c                  | 18 -----------------
 drivers/misc/cardreader/rtsx_pcr.c                 |  5 ++++-
 drivers/misc/tps6594-esm.c                         | 19 +++++++++++++++++-
 tools/counter/Makefile                             |  3 ++-
 27 files changed, 148 insertions(+), 103 deletions(-)
