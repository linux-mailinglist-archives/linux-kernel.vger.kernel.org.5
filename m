Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1495480B4C3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjLINxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjLINxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:53:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46010C8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:53:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AF8C433C8;
        Sat,  9 Dec 2023 13:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702129987;
        bh=uiEXUHSF1CMli8Osbmo8kNmQ4X2/t97OP/e1UIDgpsA=;
        h=Date:From:To:Cc:Subject:From;
        b=StoZVzbvdoj3WlMZceR+eRv82qe8rVTspb7FpkuskPX0oTxnn4Kd0gd1EC3Z1OJKn
         pfQt0lh/VhB3Gy/C+LazvBOC3AjlooSUvrgW9TX9Lpc1WR48MU638KgsbUejm8wHiO
         zAjNDY7R97GZkuynO7Bp8Q+WWL81PQu+C/qqppgU=
Date:   Sat, 9 Dec 2023 14:53:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.7-rc4
Message-ID: <ZXRxQRNFYbjEevvb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.7-rc5

for you to fetch changes up to b7c1e53751cb3990153084f31c41f25fde3b629c:

  nvmem: Do not expect fixed layouts to grab a layout driver (2023-12-07 11:19:32 +0900)

----------------------------------------------------------------
Char/Misc driver fixes for 6.7-rc5

Here are some small fixes for 6.7-rc5 for a variety of small driver
subsystems.  Included in here are:
  - debugfs revert for reported issue
  - greybus revert for reported issue
  - greybus fixup for endian build warning
  - coresight driver fixes
  - nvmem driver fixes
  - devcoredump fix
  - parport new device id
  - ndtest build fix

All of these have ben in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: pxp: fix mei_pxp_send_message return value

Ayush Singh (1):
      greybus: gb-beagleplay: Ensure le for values in transport

Cameron Williams (1):
      parport: Add support for Brainboxes IX/UC/PX parallel cards

Greg Kroah-Hartman (3):
      Merge 6.7-rc4 into char-misc-linus
      Revert "greybus: gb-beagleplay: Ensure le for values in transport"
      Merge tag 'coresight-fixes-for-v6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next

James Clark (1):
      coresight: Fix crash when Perf and sysfs modes are used concurrently

Johannes Berg (1):
      Revert "debugfs: annotate debugfs handlers vs. removal with lockdep"

Junhao He (4):
      hwtracing: hisi_ptt: Add dummy callback pmu::read()
      coresight: ultrasoc-smb: Fix sleep while close preempt in enable_smb
      coresight: ultrasoc-smb: Config SMB buffer before register sink
      coresight: ultrasoc-smb: Fix uninitialized before use buf_hw_base

Miquel Raynal (1):
      nvmem: Do not expect fixed layouts to grab a layout driver

Mukesh Ojha (1):
      devcoredump: Send uevent once devcd is ready

Randy Dunlap (1):
      greybus: BeaglePlay driver needs CRC_CCITT

Su Hui (2):
      misc: mei: client.c: return negative error code in mei_cl_write
      misc: mei: client.c: fix problem of return '-EOVERFLOW' in mei_cl_write

Uwe Kleine-König (1):
      coresight: etm4x: Remove bogous __exit annotation for some functions

Vegard Nossum (1):
      Documentation: coresight: fix `make refcheckdocs` warning

Yi Zhang (1):
      ndtest: fix typo class_regster -> class_register

Yicong Yang (2):
      hwtracing: hisi_ptt: Handle the interrupt in hardirq context
      hwtracing: hisi_ptt: Don't try to attach a task

 Documentation/trace/coresight/coresight.rst        |  2 +-
 drivers/base/devcoredump.c                         |  3 ++
 drivers/greybus/Kconfig                            |  1 +
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  4 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  6 +--
 drivers/hwtracing/coresight/ultrasoc-smb.c         | 58 +++++++++-------------
 drivers/hwtracing/coresight/ultrasoc-smb.h         |  6 +--
 drivers/hwtracing/ptt/hisi_ptt.c                   | 14 ++++--
 drivers/misc/mei/client.c                          |  4 +-
 drivers/misc/mei/pxp/mei_pxp.c                     |  3 +-
 drivers/nvmem/core.c                               |  6 +++
 drivers/parport/parport_pc.c                       | 21 ++++++++
 fs/debugfs/file.c                                  | 10 ----
 fs/debugfs/inode.c                                 |  7 ---
 fs/debugfs/internal.h                              |  6 ---
 tools/testing/nvdimm/test/ndtest.c                 |  2 +-
 16 files changed, 79 insertions(+), 74 deletions(-)
