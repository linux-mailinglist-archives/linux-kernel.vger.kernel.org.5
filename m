Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC04A7C99C1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjJOPYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjJOPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:24:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2674FC5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 08:24:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C6DC433C7;
        Sun, 15 Oct 2023 15:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697383441;
        bh=6AcLuzp2faOAS838XmbUFOAOEQ1yB3YL3D7WqNbMO6U=;
        h=Date:From:To:Cc:Subject:From;
        b=dvHJK+FgCE2aDWWubcZ7FeGRobF3JQUqxhgObX5rlpS8nrKw5CleX2mAj63y5u2Tk
         yOzvGJ2U9Jp4YsECNIUbq5pJTxaMKcNsDIcmEi0xA3EsSWDm/0NS61UjLS03pcnQbY
         NweiSZl8QUZw8BwtmtirVUxLJMu6oSOLlWrgXak8=
Date:   Sun, 15 Oct 2023 17:23:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.6-rc6
Message-ID: <ZSwEDVXfNxshSzrQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc6

for you to fetch changes up to ffd1f150fffe8a708f6ccd15152791d0e8f812b6:

  Merge tag 'iio-fixes-for-6.6a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2023-10-06 16:58:28 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.6-rc6

Here is a small set of char/misc and other smaller driver subsystem
fixes for 6.6-rc6.  Included in here are:
  - lots of iio driver fixes
  - binder memory leak fix
  - mcb driver fixes
  - counter driver fixes
  - firmware loader documentation fix
  - embargoed hardware issue documentation update

All of these have been in linux-next for over a week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Zangerl (1):
      iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

Alisa-Dariana Roman (1):
      iio: adc: ad7192: Correct reference voltage

Antoniu Miclaus (2):
      iio: admv1013: add mixer_vgate corner cases
      iio: addac: Kconfig: update ad74413r selections

Carlos Llamas (1):
      binder: fix memory leaks of spam and pending work

Dharma Balasubiramani (1):
      counter: microchip-tcb-capture: Fix the use of internal GCLK logic

Fabrice Gasnier (1):
      counter: chrdev: fix getting array extensions

GONG, Ruiqi (1):
      iio: irsd200: fix -Warray-bounds bug in irsd200_trigger_handler

Greg Kroah-Hartman (3):
      Merge tag 'counter-fixes-for-6.6a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-linus
      Merge tag 'coresight-fixes-v6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-linus
      Merge tag 'iio-fixes-for-6.6a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

Jonathan Cameron (1):
      iio: imu: bno055: Fix missing Kconfig dependencies

Jorge Sanjuan Garcia (1):
      mcb: remove is_added flag from mcb_device struct

Kees Cook (1):
      Documentation: embargoed-hardware-issues.rst: Clarify prenotifaction

Krzysztof Kozlowski (1):
      dt-bindings: iio: rohm,bu27010: add missing vdd-supply to example

Lakshmi Yadlapati (1):
      iio: pressure: dps310: Adjust Timeout Settings

Linu Cherian (1):
      coresight: Fix run time warnings while reusing ETR buffer

Marcelo Schmitt (1):
      iio: dac: ad3552r: Correct device IDs

Mårten Lindahl (1):
      iio: light: vcnl4000: Don't power on/off chip in config

Phil Elwell (1):
      iio: pressure: bmp280: Fix NULL pointer exception

Philipp Rossak (1):
      iio: adc: imx8qxp: Fix address for command buffer registers

Rob Herring (1):
      dt-bindings: iio: adc: adi,ad7292: Fix additionalProperties on channel nodes

Russ Weight (1):
      firmware_loader: Update contact emails for ABI docs

Suzuki K Poulose (1):
      coresight: tmc-etr: Disable warnings for allocation failures

Tzung-Bi Shih (1):
      iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()

 Documentation/ABI/testing/sysfs-class-firmware     | 14 +++++------
 .../devicetree/bindings/iio/adc/adi,ad7292.yaml    |  2 +-
 .../bindings/iio/light/rohm,bu27010.yaml           |  1 +
 .../process/embargoed-hardware-issues.rst          | 19 ++++++++------
 MAINTAINERS                                        |  2 +-
 drivers/android/binder.c                           |  2 ++
 drivers/counter/counter-chrdev.c                   |  4 +--
 drivers/counter/microchip-tcb-capture.c            |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 27 +++++++++++---------
 drivers/iio/adc/ad7192.c                           | 29 +++++++++++++++++++---
 drivers/iio/adc/imx8qxp-adc.c                      |  4 +--
 drivers/iio/addac/Kconfig                          |  2 ++
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  6 ++++-
 drivers/iio/dac/ad3552r.c                          |  4 +--
 drivers/iio/frequency/admv1013.c                   |  4 +--
 drivers/iio/imu/bno055/Kconfig                     |  2 ++
 drivers/iio/light/vcnl4000.c                       |  1 -
 drivers/iio/pressure/bmp280-core.c                 |  2 +-
 drivers/iio/pressure/dps310.c                      |  8 +++---
 drivers/iio/pressure/ms5611_core.c                 |  2 +-
 drivers/iio/proximity/irsd200.c                    |  6 ++---
 drivers/mcb/mcb-core.c                             | 10 +++-----
 drivers/mcb/mcb-parse.c                            |  2 --
 include/linux/mcb.h                                |  1 -
 24 files changed, 94 insertions(+), 62 deletions(-)
