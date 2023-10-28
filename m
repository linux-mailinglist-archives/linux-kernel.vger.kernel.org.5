Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619267DA577
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 09:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjJ1HUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjJ1HUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 03:20:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB87B4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 00:20:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016E6C433C7;
        Sat, 28 Oct 2023 07:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698477607;
        bh=2oC2EwksGU67U/RjZJkv5dCysk+H6PgbBkwsHuRiark=;
        h=Date:From:To:Cc:Subject:From;
        b=BmKRWftK3fXv3e+QEYWGmU7PznjRPP7MUcE7ljUddVGQhYNfc1/UKfiMDU3So5RC6
         l3NzVmPRbvdCPQdD4NBoMZhq/pXosTELvfj4EN3JVoyQ1N87w9hdk0lNBb/iJMqt07
         fbW7qjrEZk4A69SKlGi6cbz0KGKp+vFhEDSlylUk=
Date:   Sat, 28 Oct 2023 09:20:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.6-final
Message-ID: <ZTy2I5Y4EnVLIvod@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-final

for you to fetch changes up to 28926daf731f72d0537767fdbab2a3e06e31190a:

  fpga: Fix memory leak for fpga_region_test_class_find() (2023-10-24 19:32:39 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.6-final

Here are some very small driver fixes for 6.6-final that have shown up
in the past 2 weeks.  Included in here are:
  - tiny fastrpc bugfixes for reported errors
  - nvmem register fixes
  - iio driver fixes for some reported problems
  - fpga test fix
  - MAINTAINERS file update for fpga

All of these have been in linux-next this week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ekansh Gupta (4):
      misc: fastrpc: Reset metadata buffer to avoid incorrect free
      misc: fastrpc: Free DMA handles for RPC calls with no arguments
      misc: fastrpc: Clean buffers on remote invocation failures
      misc: fastrpc: Unmap only if buffer is unmapped from DSP

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-6.6b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

Jinjie Ruan (1):
      fpga: Fix memory leak for fpga_region_test_class_find()

Krzysztof Kozlowski (1):
      dt-bindings: iio: add missing reset-gpios constrain

Linus Walleij (1):
      iio: afe: rescale: Accept only offset channels

Marco Pagani (1):
      fpga: disable KUnit test suites when module support is enabled

Marek Szyprowski (1):
      iio: exynos-adc: request second interupt only when touchscreen mode is used

Peng Fan (3):
      nvmem: imx: correct nregs for i.MX6SLL
      nvmem: imx: correct nregs for i.MX6UL
      nvmem: imx: correct nregs for i.MX6ULL

Robert Hancock (2):
      iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature thresholds
      iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale

Russ Weight (1):
      fpga: m10bmc-sec: Change contact for secure update driver

 .../testing/sysfs-driver-intel-m10-bmc-sec-update  | 14 ++++----
 .../devicetree/bindings/iio/addac/adi,ad74115.yaml |  3 +-
 .../devicetree/bindings/iio/dac/adi,ad5758.yaml    |  3 +-
 .../devicetree/bindings/iio/health/ti,afe4403.yaml |  3 +-
 .../devicetree/bindings/iio/health/ti,afe4404.yaml |  3 +-
 MAINTAINERS                                        |  2 +-
 drivers/fpga/tests/Kconfig                         |  4 +--
 drivers/fpga/tests/fpga-region-test.c              |  2 ++
 drivers/iio/adc/exynos_adc.c                       | 24 +++++++------
 drivers/iio/adc/xilinx-xadc-core.c                 | 39 ++++++++--------------
 drivers/iio/adc/xilinx-xadc.h                      |  2 ++
 drivers/iio/afe/iio-rescale.c                      | 19 ++++++++---
 drivers/misc/fastrpc.c                             | 34 +++++++++----------
 drivers/nvmem/imx-ocotp.c                          |  6 ++--
 14 files changed, 85 insertions(+), 73 deletions(-)
