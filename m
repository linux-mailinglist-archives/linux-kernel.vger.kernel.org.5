Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F3778FFDA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350182AbjIAPVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbjIAPVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:21:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF61719
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49BF26252A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8FBC433C7;
        Fri,  1 Sep 2023 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693581649;
        bh=KqC9kD8TGXGM7TN1xvuUg7NJTVq0v9ak+fgyyXX+dMA=;
        h=Date:From:To:Cc:Subject:From;
        b=qH/mKTyAzuhVx9CKVprZveqLT2Xw+/kM+qwbmYjEkxcVq3LXKqD/dJ0gkBbVYOgeT
         rWDjXymuUJC2Ro8kzL0ERCuKxWF3QRDtC84kePsdVKh+40PBA+9wFYRD51URnTil5X
         EChDN6hTRRGF+vr02XRsf+z0WMAq8hJU4JmXM498=
Date:   Fri, 1 Sep 2023 17:20:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core update for 6.6-rc1
Message-ID: <ZPIBTz-bppDBfgDi@kroah.com>
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

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.6-rc1

for you to fetch changes up to 29c8ab79e91d35b93cfab87bf67a11516f7b2051:

  driver core: Call in reversed order in device_platform_notify_remove() (2023-08-22 16:57:39 +0200)

----------------------------------------------------------------
Driver core changes for 6.6-rc1

Here is a small set of driver core updates and additions for 6.6-rc1.

Included in here are:
  - stable kernel documentation updates
  - class structure const work from Ivan on various subsystems
  - kernfs tweaks
  - driver core tests!
  - kobject sanity cleanups
  - kobject structure reordering to save space
  - driver core error code handling fixups
  - other minor driver core cleanups

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (3):
      driver core: Move dev_err_probe() to where it belogs
      driver core: Return proper error code when dev_set_name() fails
      driver core: Call in reversed order in device_platform_notify_remove()

Arnd Bergmann (1):
      kernfs: add stub helper for kernfs_generic_poll()

Christophe JAILLET (1):
      kobject: Reorder fields in 'struct kobject'

Dan Carpenter (1):
      driver core: test_async: fix an error code

David Gow (1):
      drivers: base: Free devm resources when unregistering a device

GUO Zihua (1):
      base/node: Remove duplicated include

Greg Kroah-Hartman (1):
      HID: hidraw: make hidraw_class structure const

Ian Kent (1):
      kernfs: fix missing kernfs_iattr_rwsem locking

Ivan Babrou (1):
      kernfs: attach uuid for every kernfs and report it in fsid

Ivan Orlov (5):
      tpm: make all 'class' structures const
      HID: roccat: make all 'class' structures const
      x86/cpuid: make cpuid_class a static const structure
      x86/MSR: make msr_class a static const structure
      x86/resctrl: make pseudo_lock_class a static const structure

Jason Gunthorpe (1):
      driver core: Call dma_cleanup() on the test_remove path

Maxime Ripard (4):
      drivers: base: Add basic devm tests for root devices
      drivers: base: Add basic devm tests for platform devices
      drivers: base: test: Add missing MODULE_* macros for platform devices tests
      drivers: base: test: Add missing MODULE_* macros to root device tests

Thorsten Leemhuis (7):
      docs: stable-kernel-rules: mention other usages for stable tag comments
      docs: stable-kernel-rules: make rule section more straight forward
      docs: stable-kernel-rules: improve structure by changing headlines
      docs: stable-kernel-rules: move text around to improve flow
      docs: stable-kernel-rules: make the examples for option 1 a proper list
      docs: stable-kernel-rules: fine-tune various details
      docs: stable-kernel-rules: mention that regressions must be prevented

Waiman Long (1):
      driver/base/cpu: Retry online operation if -EBUSY

Zhen Lei (3):
      kobject: Add helper kobj_ns_type_is_valid()
      kobject: Add sanity check for kset->kobj.ktype in kset_register()
      kobject: Remove redundant checks for whether ktype is NULL

 Documentation/process/stable-kernel-rules.rst | 197 ++++++++++++----------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  41 ++---
 arch/x86/kernel/cpuid.c                       |  31 ++--
 arch/x86/kernel/msr.c                         |  31 ++--
 drivers/base/core.c                           |  30 ++--
 drivers/base/cpu.c                            |  19 +++
 drivers/base/dd.c                             |   2 +
 drivers/base/node.c                           |   1 -
 drivers/base/test/.kunitconfig                |   2 +
 drivers/base/test/Kconfig                     |   4 +
 drivers/base/test/Makefile                    |   3 +
 drivers/base/test/platform-device-test.c      | 224 ++++++++++++++++++++++++++
 drivers/base/test/root-device-test.c          | 112 +++++++++++++
 drivers/base/test/test_async_driver_probe.c   |   2 +-
 drivers/char/tpm/tpm-chip.c                   |  11 +-
 drivers/char/tpm/tpm-interface.c              |  21 ++-
 drivers/char/tpm/tpm.h                        |   4 +-
 drivers/char/tpm/tpm2-space.c                 |   2 +-
 drivers/hid/hid-roccat-arvo.c                 |  20 +--
 drivers/hid/hid-roccat-isku.c                 |  21 +--
 drivers/hid/hid-roccat-kone.c                 |  24 +--
 drivers/hid/hid-roccat-koneplus.c             |  22 +--
 drivers/hid/hid-roccat-konepure.c             |  22 +--
 drivers/hid/hid-roccat-kovaplus.c             |  22 +--
 drivers/hid/hid-roccat-pyra.c                 |  22 +--
 drivers/hid/hid-roccat-ryos.c                 |  20 +--
 drivers/hid/hid-roccat-savu.c                 |  20 +--
 drivers/hid/hid-roccat.c                      |   2 +-
 drivers/hid/hidraw.c                          |  18 +--
 fs/kernfs/dir.c                               |   4 +
 fs/kernfs/mount.c                             |  13 +-
 include/linux/dev_printk.h                    |   2 +
 include/linux/device.h                        |   2 -
 include/linux/hid-roccat.h                    |   2 +-
 include/linux/kernfs.h                        |   4 +
 include/linux/kobject.h                       |   8 +-
 lib/kobject.c                                 |  62 +++----
 37 files changed, 749 insertions(+), 298 deletions(-)
 create mode 100644 drivers/base/test/.kunitconfig
 create mode 100644 drivers/base/test/platform-device-test.c
 create mode 100644 drivers/base/test/root-device-test.c
