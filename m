Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56FD7E41BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjKGOWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE4111A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699366919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z7U0IjTbm9Q4t163uqbaeBeeKjVAKxsMyeV8QNr3RKI=;
        b=IQMJz3pOud2214gpHqPxtI7j+Fgh959mkbWE0ZoZX+Hr8ZN68PfimW4n5QrqRG00lNsrNw
        NMqTFKblekkx8fFPWqMU1ckuaP5lDIzs0/FsFhtdcKARIIMxGbbLKlIqt2Qi6k8zRyR6Vx
        oLaKiXwb0DU2DrNReSn32CaJrOttkeI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-OIMR5y2kPQ-aYJU9eRd9Hg-1; Tue, 07 Nov 2023 09:21:56 -0500
X-MC-Unique: OIMR5y2kPQ-aYJU9eRd9Hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C218821BCF;
        Tue,  7 Nov 2023 14:21:56 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AA881C060B0;
        Tue,  7 Nov 2023 14:21:55 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes
Date:   Tue,  7 Nov 2023 15:21:53 +0100
Message-ID: <20231107142154.613991-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes.

Thank you very much,
Andreas

The following changes since commit a49d273e579615ed63d0347f94075dd22b9458a3:

  Merge tag 'gfs2-v6.6-rc1-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2023-09-18 11:59:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.6-rc2-fixes

for you to fetch changes up to 0cdc6f44e9fdc2d20d720145bf99a39f611f6d61:

  gfs2: don't withdraw if init_threads() got interrupted (2023-11-06 01:51:26 +0100)

----------------------------------------------------------------
gfs2 fixes

- Don't update inode timestamps for direct writes (performance regression fix).

- Skip no-op quota records instead of panicing.

- Fix a RCU race in gfs2_permission().

- Various other smaller fixes and cleanups all over the place.

----------------------------------------------------------------
Al Viro (1):
      gfs2: fix an oops in gfs2_permission

Amir Goldstein (1):
      gfs2: fs: derive f_fsid from s_uuid

Andreas Gruenbacher (19):
      gfs2: Simplify function gfs2_upgrade_iopen_glock
      gfs2: Remove freeze_go_demote_ok
      gfs2: Remove unused gfs2_extent_length argument
      gfs2: Get rid of the gfs2_glock_is_held_* helpers
      gfs2: Don't update inode timestamps for direct writes
      gfs2: setattr_chown: Add missing initialization
      gfs2: Stop using GFS2_BASIC_BLOCK and GFS2_BASIC_BLOCK_SHIFT
      gfs2: Two quota=account mode fixes
      gfs2: Clean up gfs2_alloc_parms initializers
      gfs2: Clean up quota.c:print_message
      gfs2: Add metapath_dibh helper
      gfs2: Get rid of gfs2_alloc_blocks generation parameter
      gfs2: Minor gfs2_write_jdata_batch PAGE_SIZE cleanup
      gfs2: Convert stuffed_readpage to folios
      gfs2: Convert gfs2_internal_read to folios
      gfs2: Rename gfs2_lookup_{ simple => meta }
      gfs2: No longer use 'extern' in function declarations
      gfs2: Silence "suspicious RCU usage in gfs2_permission" warning
      gfs2: don't withdraw if init_threads() got interrupted

Bob Peterson (1):
      gfs2: ignore negated quota changes

Juntong Deng (1):
      gfs2: Fix slab-use-after-free in gfs2_qd_dealloc

Su Hui (1):
      gfs2: remove dead code in add_to_queue

 fs/gfs2/acl.h        |   8 ++--
 fs/gfs2/aops.c       |  72 ++++++++++++++++----------------
 fs/gfs2/aops.h       |   6 +--
 fs/gfs2/bmap.c       |  17 +++++---
 fs/gfs2/bmap.h       |  38 ++++++++---------
 fs/gfs2/dir.c        |   2 +-
 fs/gfs2/dir.h        |  38 ++++++++---------
 fs/gfs2/file.c       |  18 +++++---
 fs/gfs2/glock.c      |   1 -
 fs/gfs2/glock.h      | 113 ++++++++++++++++++++++-----------------------------
 fs/gfs2/glops.c      |  13 ------
 fs/gfs2/glops.h      |   4 +-
 fs/gfs2/incore.h     |   2 +-
 fs/gfs2/inode.c      |  33 +++++++++------
 fs/gfs2/inode.h      |  60 +++++++++++++--------------
 fs/gfs2/log.h        |  46 ++++++++++-----------
 fs/gfs2/lops.h       |  22 +++++-----
 fs/gfs2/meta_io.h    |  20 ++++-----
 fs/gfs2/ops_fstype.c |  28 ++++++-------
 fs/gfs2/quota.c      |  31 +++++++++-----
 fs/gfs2/quota.h      |  38 ++++++++---------
 fs/gfs2/recovery.h   |  18 ++++----
 fs/gfs2/rgrp.c       |  12 +++---
 fs/gfs2/rgrp.h       |  85 +++++++++++++++++++-------------------
 fs/gfs2/super.c      |  29 +++++--------
 fs/gfs2/super.h      |  50 +++++++++++------------
 fs/gfs2/trans.h      |  24 +++++------
 fs/gfs2/util.h       |   8 ++--
 fs/gfs2/xattr.c      |   6 +--
 fs/gfs2/xattr.h      |  12 +++---
 30 files changed, 421 insertions(+), 433 deletions(-)

