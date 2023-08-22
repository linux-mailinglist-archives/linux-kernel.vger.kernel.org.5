Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93878378C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjHVBoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHVBoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:44:13 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B501110
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 18:44:11 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVBtT5rMBz1L9br;
        Tue, 22 Aug 2023 09:42:41 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:44:09 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <hch@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] freevxfs: Fixed comment for parameter of vxfs_immed_read_folio and vxfs_bmap_ext4
Date:   Tue, 22 Aug 2023 09:43:50 +0800
Message-ID: <20230822014350.27591-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed comment for parameter of vxfs_immed_read_folio and vxfs_bmap_ext4.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 fs/freevxfs/vxfs_bmap.c  | 2 +-
 fs/freevxfs/vxfs_immed.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
index de2a5bccb930..9615f9fea54f 100644
--- a/fs/freevxfs/vxfs_bmap.c
+++ b/fs/freevxfs/vxfs_bmap.c
@@ -29,7 +29,7 @@ vxfs_typdump(struct vxfs_typed *typ)
 /**
  * vxfs_bmap_ext4 - do bmap for ext4 extents
  * @ip:		pointer to the inode we do bmap for
- * @iblock:	logical block.
+ * @bn:	logical block.
  *
  * Description:
  *   vxfs_bmap_ext4 performs the bmap operation for inodes with
diff --git a/fs/freevxfs/vxfs_immed.c b/fs/freevxfs/vxfs_immed.c
index 9b49ec36e667..01cded39ade2 100644
--- a/fs/freevxfs/vxfs_immed.c
+++ b/fs/freevxfs/vxfs_immed.c
@@ -15,7 +15,7 @@
 
 /**
  * vxfs_immed_read_folio - read part of an immed inode into pagecache
- * @file:	file context (unused)
+ * @fp:	file context (unused)
  * @folio:	folio to fill in.
  *
  * Description:
-- 
2.17.1

