Return-Path: <linux-kernel+bounces-110066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78754885985
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF81B22F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7683CD5;
	Thu, 21 Mar 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WISc2sBX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755183CCA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026123; cv=none; b=AmrXXvzX3VQpmhwzNITfwK0faQAEhAeObnhakgLRvh2PkrBbPTF0/j0C0t15hZi10Dp54Rpa/BSU6ODKve7KKPfI03XW6ficmNKtksfyFRDqdh3u/aB1AB7diPFc6GAX3FUj4KRjq67PIQxa8E8ovMKYtP4kaGA7gg9ZdlseHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026123; c=relaxed/simple;
	bh=0Ar5ThuOqYzRFLh58h2aLngrXREFPZj7zmTgtNptjYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dQSOubIMhCw0jZ0MxK2N26U9b/24AiZsnoAPmhJch7B2kktos0ApfldWsNLfVWxcL4eMJ/XfIIc8CpMpkLXwoh3ywDQWVsA5WMkuiJ157OjCzFjDgzzPbcVOTUzTY6ZwjjWZEGZ8pPof7S7DkWb90ZKqEiC3ZRI3d+en8apwaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WISc2sBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74A0C433C7;
	Thu, 21 Mar 2024 13:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711026123;
	bh=0Ar5ThuOqYzRFLh58h2aLngrXREFPZj7zmTgtNptjYE=;
	h=Date:From:To:Cc:Subject:From;
	b=WISc2sBX6Nyv+lB93KWSCEdcDH4xWb2pNM4mkL1BR2R6XQCYg5CtG5BLAT5dFSHtq
	 t/IHsRa8D/avt9SHF3WvyUiFqDOGL3D2Iol5I4iz2/xlisLQPc9NllkEH0fEi5n5Ne
	 y1DiaPKo2QrKh9g+HTMVGcmvvjO6Z9vkwzwOk7dM=
Date: Thu, 21 Mar 2024 14:01:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 6.9-rc1
Message-ID: <Zfwvx6WFIVY-YW0Z@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.9-rc1

for you to fetch changes up to 6aeb8850e0f39869d43768603a75c0431562a429:

  device: core: Log warning for devices pending deferred probe on timeout (2024-03-07 22:10:31 +0000)

----------------------------------------------------------------
Driver core changes for 6.9-rc1

Here is the "big" set of driver core and kernfs changes for 6.9-rc1.

Nothing all that crazy here, just some good updates that include:
  - automatic attribute group hiding from Dan Williams (he fixed up my
    horrible attempt at doing this.)
  - kobject lock contention fixes from Eric Dumazet
  - driver core cleanups from Andy
  - kernfs rcu work from Tejun
  - fw_devlink changes to resolve some reported issues
  - other minor changes, all details in the shortlog

All of these have been in linux-next for a long time with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (4):
      driver core: Drop unneeded 'extern' keyword in fwnode.h
      driver core: Move fw_devlink stuff to where it belongs
      device property: Move enum dev_dma_attr to fwnode.h
      device property: Don't use "proxy" headers

Christophe JAILLET (1):
      platform-msi: Remove usage of the deprecated ida_simple_xx() API

Dan Williams (5):
      sysfs: Introduce a mechanism to hide static attribute_groups
      sysfs: Introduce a mechanism to hide static attribute_groups
      sysfs: Fix crash on empty group attributes array
      sysfs: Document new "group visible" helpers
      sysfs: Introduce DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE()

Dmitry Torokhov (1):
      firmware_loader: introduce __free() cleanup hanler

Eric Dumazet (2):
      kobject: make uevent_seqnum atomic
      kobject: reduce uevent_sock_mutex scope

Greg Kroah-Hartman (3):
      driver core: cpu: make cpu_subsys const
      Merge 6.8-rc5 into driver-core-next
      Merge tag 'sysfs_hidden_attribute_groups-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core into driver-core-next

Johannes Berg (1):
      debugfs: fix wait/cancellation handling during remove

Mukesh Ojha (1):
      firmware_loader: Suppress warning on FW_OPT_NO_WARN flag

Neel Natu (1):
      kernfs: fix false-positive WARN(nr_mmapped) in kernfs_drain_open_files

Nícolas F. R. A. Prado (3):
      driver: core: Log probe failure as error and with device metadata
      driver: core: Use dev_* instead of pr_* so device metadata is added
      device: core: Log warning for devices pending deferred probe on timeout

Randy Dunlap (1):
      driver core: component: fix spellos

Ricardo B. Marliere (1):
      workqueue: make wq_subsys const

Rohan Kollambalath (1):
      sysfs:Addresses documentation in sysfs_merge_group and sysfs_unmerge_group.

Saravana Kannan (3):
      driver core: Adds flags param to fwnode_link_add()
      driver core: Add FWLINK_FLAG_IGNORE to completely ignore a fwnode link
      of: property: fw_devlink: Add support for "post-init-providers" property

Tejun Heo (2):
      kernfs: Rearrange kernfs_node fields to reduce its size on 64bit
      kernfs: RCU protect kernfs_nodes and avoid kernfs_idr_lock in kernfs_find_and_get_node_by_id()

 drivers/base/component.c            |   4 +-
 drivers/base/core.c                 |  72 +++++++++++++++++-
 drivers/base/cpu.c                  |   2 +-
 drivers/base/dd.c                   |  32 ++++----
 drivers/base/firmware_loader/main.c |  16 ++--
 drivers/base/platform-msi.c         |   6 +-
 drivers/base/property.c             |  67 ++---------------
 drivers/base/swnode.c               |  13 +++-
 drivers/firmware/efi/sysfb_efi.c    |   2 +-
 drivers/of/property.c               |  15 +++-
 fs/debugfs/inode.c                  |  25 +++++--
 fs/kernfs/dir.c                     |  31 +++++---
 fs/kernfs/file.c                    |   8 +-
 fs/kernfs/kernfs-internal.h         |   2 +
 fs/sysfs/group.c                    |  55 ++++++++++----
 include/linux/cpu.h                 |   2 +-
 include/linux/firmware.h            |   3 +
 include/linux/fwnode.h              |  18 +++--
 include/linux/kernfs.h              |  10 ++-
 include/linux/kobject.h             |   2 +-
 include/linux/property.h            |   9 +--
 include/linux/sysfs.h               | 142 +++++++++++++++++++++++++++++++++---
 kernel/ksysfs.c                     |   2 +-
 kernel/workqueue.c                  |   2 +-
 lib/kobject_uevent.c                |  24 +++---
 25 files changed, 387 insertions(+), 177 deletions(-)

