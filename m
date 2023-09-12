Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F61C79DAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjILVZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjILVZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:25:05 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ABF10CE;
        Tue, 12 Sep 2023 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694553899;
        bh=9RBuwJ4rsGWgWemg5nbnJIHL0qtjBmuyF2BkQ8tuVuI=;
        h=From:Subject:Date:To:Cc:From;
        b=QDNIMWqtvpGfrqO41PmolBA5vd7WLu9ITjcID6QBk6dbSHXtqebYybpB+6QUDO6is
         jq9Tf8lnsE7hU5YPm+CKhXUK3yGHpvGrmjmuRiNt+gdApHX6cS2VVuuuvbodBnmkS4
         A25vGJuevPyljxe+NDZtynkBx8+DE3EZ1gPEEVe0=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] bcachefs: Fixes for various compiler warnings
Date:   Tue, 12 Sep 2023 23:24:39 +0200
Message-Id: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABfXAGUC/x3MSwqAMAwA0atI1gb6QVCvIi7SmmpAamlRBPHuF
 pdvMfNA4SxcYGweyHxJkSNW6LYBv1FcGWWpBqOMVYM26Dz5jUNBvzPFMyHZYMkNXW+NgpqlzEH
 ufznN7/sBMtQ+WWIAAAA=
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694553898; l=1408;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9RBuwJ4rsGWgWemg5nbnJIHL0qtjBmuyF2BkQ8tuVuI=;
 b=fpBkoKka6ay4f301ZQylJqfzC9d0dpAaaawW8uFjbpYbmOxbH9TpWmY/J7e9BxusTD4AcMTBn
 8apdKuDHj88BAw+CNd8QissWryiz+EGcbcFFuNl7geUuhLojtqu+84l
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fixes for warnings found by "make W=1".

Note: This was only compile-tested.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      bcachefs: Delete dead code
      bcachefs: Mark bch2_snapshot_node_delete() static
      bcachefs: Delete set but not used variables
      bcachefs: Add printf function attributes
      bcachefs: Avoid unused symbol warnings from headers

 fs/bcachefs/alloc_foreground.c   |  3 --
 fs/bcachefs/backpointers.c       |  3 --
 fs/bcachefs/bcachefs.h           |  3 +-
 fs/bcachefs/bcachefs_format.h    | 15 +++++-----
 fs/bcachefs/btree_io.c           |  4 +--
 fs/bcachefs/btree_trans_commit.c |  4 ---
 fs/bcachefs/btree_types.h        | 63 +++++++++++++++++++++-------------------
 fs/bcachefs/btree_update.c       | 13 ++-------
 fs/bcachefs/btree_update.h       |  4 ++-
 fs/bcachefs/compress.c           |  4 ---
 fs/bcachefs/data_update.c        |  4 ---
 fs/bcachefs/fs-io-pagecache.c    |  7 -----
 fs/bcachefs/fs-ioctl.h           |  8 +++--
 fs/bcachefs/opts.h               |  3 +-
 fs/bcachefs/reflink.c            |  8 -----
 fs/bcachefs/snapshot.c           |  2 +-
 16 files changed, 58 insertions(+), 90 deletions(-)
---
base-commit: e7e6c4189f70ab2d7c21eaec5b9e9c34527ef349
change-id: 20230912-bcachefs-cleanup-a3f3ab958320

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

