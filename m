Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66287E1309
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 11:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjKEKbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 05:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEKbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 05:31:11 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FAFEB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 02:31:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 120F96340DF2;
        Sun,  5 Nov 2023 11:31:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fAgA4uaBlOak; Sun,  5 Nov 2023 11:31:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8B9336340E12;
        Sun,  5 Nov 2023 11:31:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xjuFIeJljwem; Sun,  5 Nov 2023 11:31:02 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6E6126340DF2;
        Sun,  5 Nov 2023 11:31:02 +0100 (CET)
Date:   Sun, 5 Nov 2023 11:31:02 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <15692057.53962.1699180262386.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI and UBIFS Updates for v6.7-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: f1SHfvtc6D/rLNKsb3FlFunId/8Slg==
Thread-Topic: UBI and UBIFS Updates for v6.7-rc1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.7-rc1

for you to fetch changes up to 75690493591fe283e4c92a3ba7c4420e9858abdb:

  ubifs: ubifs_link: Fix wrong name len calculating when UBIFS is encrypted (2023-10-28 23:19:08 +0200)

----------------------------------------------------------------
This pull request contains updates for UBI and UBIFS

- UBI Fastmap improvements
- Minor issues found by static analysis bots in both UBI and UBIFS
- Fix for wrong dentry length UBIFS in fscrypt mode

----------------------------------------------------------------
Ferry Meng (1):
      ubifs: Fix missing error code err

Konstantin Meskhidze (1):
      ubifs: fix possible dereference after free

Vincent Whitchurch (1):
      ubifs: Fix memory leak of bud->log_hash

Yang Li (1):
      ubifs: Fix some kernel-doc comments

ZhaoLong Wang (1):
      ubi: block: Fix use-after-free in ubiblock_cleanup

Zhihao Cheng (13):
      ubi: fastmap: Fix missed ec updating after erasing old fastmap data block
      ubi: fastmap: erase_block: Get erase counter from wl_entry rather than flash
      ubi: fastmap: Allocate memory with GFP_NOFS in ubi_update_fastmap
      ubi: Replace erase_block() with sync_erase()
      ubi: fastmap: Use free pebs reserved for bad block handling
      ubi: fastmap: Wait until there are enough free PEBs before filling pools
      ubi: fastmap: Remove unneeded break condition while filling pools
      ubi: fastmap: may_reserve_for_fm: Don't reserve PEB if fm_anchor exists
      ubi: fastmap: Get wl PEB even ec beyonds the 'max' if free PEBs are run out
      ubi: fastmap: Fix lapsed wear leveling for first 64 PEBs
      ubi: fastmap: Add module parameter to control reserving filling pool PEBs
      ubi: fastmap: Add control in 'UBI_IOCATT' ioctl to reserve PEBs for filling pools
      ubifs: ubifs_link: Fix wrong name len calculating when UBIFS is encrypted

 drivers/mtd/ubi/block.c      |   4 +++-
 drivers/mtd/ubi/build.c      |  25 ++++++++++++++++++++++---
 drivers/mtd/ubi/cdev.c       |   3 ++-
 drivers/mtd/ubi/eba.c        |   3 ---
 drivers/mtd/ubi/fastmap-wl.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 drivers/mtd/ubi/fastmap.c    |  66 +++++++-----------------------------------------------------------
 drivers/mtd/ubi/ubi.h        |  10 ++++++++--
 drivers/mtd/ubi/wl.c         |  48 ++++++++++++++++++++++++++++++------------------
 drivers/mtd/ubi/wl.h         |   6 ++++--
 fs/ubifs/dir.c               |   4 +++-
 fs/ubifs/file.c              |   3 +++
 fs/ubifs/journal.c           |   1 +
 fs/ubifs/super.c             |   5 ++++-
 fs/ubifs/tnc.c               |   1 +
 include/uapi/mtd/ubi-user.h  |   4 +++-
 15 files changed, 179 insertions(+), 116 deletions(-)
