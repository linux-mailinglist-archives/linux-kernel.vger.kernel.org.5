Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172F17E027C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjKCMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjKCMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:05:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E091A1BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:05:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BCEC433C7;
        Fri,  3 Nov 2023 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699013149;
        bh=GPCflgk0LmQvgM0AM5EW/wUJNC+EgFlju02bKUhkoxI=;
        h=Date:From:To:Cc:Subject:From;
        b=TPPkSHO7yAAylz7UW870v0Eums/0QuN/4FkyHb/C3MQBZsw5mA5Lco4gA5yFOAN+t
         ruE14jEcp+pzLfHxp3SjFh+twOr7FDxOpQLQX1ob0SAac55e+ie2QrxEmCgWFixiCD
         gZnXog3RRMm2YqMpAnyokriTDZw5r/d2yAjA5JCU=
Date:   Fri, 3 Nov 2023 13:05:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 6.7-rc1
Message-ID: <ZUTiFDLKDO4piYuZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.7-rc1

for you to fetch changes up to effd7c70eaa0440688b60b9d419243695ede3c45:

  firmware_loader: Abort all upcoming firmware load request once reboot triggered (2023-10-27 13:30:38 +0200)

----------------------------------------------------------------
Driver core changes for 6.7-rc1

Here is the set of driver core updates for 6.7-rc1.  Nothing major in
here at all, just a small number of changes including:
  - minor cleanups and updates from Andy Shevchenko
  - __counted_by addition
  - firmware_loader update for aborting loads cleaner
  - other minor changes, details in the shortlog
  - documentation update

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (10):
      driver core: platform: Drop redundant check in platform_device_add()
      driver core: platform: Refactor error path in a couple places
      driver core: platform: Use temporary variable in platform_device_add()
      driver core: platform: Unify the firmware node type check
      device property: Clarify usage scope of some struct fwnode_handle members
      driver core: Add missing parameter description to __fwnode_link_add()
      device property: Replace custom implementation of COUNT_ARGS()
      resource: Reuse for_each_resource() macro
      resource: Unify next_resource() and next_resource_skip_children()
      resource: Constify resource crosscheck APIs

Geert Uytterhoeven (1):
      drivers: base: test: Make property entry API test modular

Kees Cook (1):
      driver core: platform: Annotate struct irq_affinity_devres with __counted_by

Masahiro Yamada (1):
      devres: rename the first parameter of devm_add_action(_or_reset)

Maurizio Lombardi (1):
      driver core: class: remove boilerplate code

Mike Tipton (1):
      debugfs: Fix __rcu type comparison warning

Mukesh Ojha (2):
      firmware_loader: Refactor kill_pending_fw_fallback_reqs()
      firmware_loader: Abort all upcoming firmware load request once reboot triggered

Saravana Kannan (1):
      driver core: Release all resources during unbind before updating device links

Valentine Sinitsyn (2):
      kernfs: sysfs: support custom llseek method for sysfs entries
      PCI: Implement custom llseek for sysfs resource entries

Willy Tarreau (1):
      Documentation: security-bugs.rst: linux-distros relaxed their rules

 Documentation/process/security-bugs.rst | 33 +++++++++++----
 drivers/base/class.c                    |  6 +--
 drivers/base/core.c                     |  1 +
 drivers/base/dd.c                       |  2 +-
 drivers/base/firmware_loader/fallback.c | 10 +++--
 drivers/base/firmware_loader/fallback.h |  4 +-
 drivers/base/firmware_loader/firmware.h |  1 +
 drivers/base/firmware_loader/main.c     |  9 +++--
 drivers/base/platform.c                 | 71 +++++++++++++++++----------------
 drivers/base/test/Kconfig               |  4 +-
 drivers/base/test/property-entry-test.c |  4 ++
 drivers/pci/pci-sysfs.c                 | 26 +++++++++++-
 fs/debugfs/file.c                       |  2 +-
 fs/kernfs/file.c                        | 29 +++++++++++++-
 fs/sysfs/file.c                         | 13 ++++++
 include/linux/device.h                  |  8 ++--
 include/linux/fwnode.h                  |  2 +
 include/linux/ioport.h                  | 12 +++---
 include/linux/kernfs.h                  |  1 +
 include/linux/property.h                |  3 +-
 include/linux/sysfs.h                   |  2 +
 kernel/resource.c                       | 51 +++++++++++------------
 22 files changed, 194 insertions(+), 100 deletions(-)
