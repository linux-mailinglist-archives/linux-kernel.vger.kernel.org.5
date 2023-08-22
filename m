Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AABA78378A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjHVBkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjHVBkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:40:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EF7110
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 18:40:30 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVBmP0yrnzLp5T;
        Tue, 22 Aug 2023 09:37:25 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:40:28 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <hch@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] freevxfs: Fix comment on vxfs_readdir
Date:   Tue, 22 Aug 2023 09:40:10 +0800
Message-ID: <20230822014010.26817-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

As vxfs_readdir now switches to iterate_shared interface, the parameter
of the function is changed. However, the comment of has not been
updated.

This patch updates function doc to reflect this change.

Fixes: 9b5d5a170781 ("[readdir] convert freevxfs")
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 fs/freevxfs/vxfs_lookup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
index f04ba2ed1e1a..53cbb7209324 100644
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -177,12 +177,11 @@ vxfs_lookup(struct inode *dip, struct dentry *dp, unsigned int flags)
 /**
  * vxfs_readdir - read a directory
  * @fp:		the directory to read
- * @retp:	return buffer
- * @filler:	filldir callback
+ * @ctx:	Dir context
  *
  * Description:
- *   vxfs_readdir fills @retp with directory entries from @fp
- *   using the VFS supplied callback @filler.
+ *   vxfs_readdir emits directory entries from @fp using the
+ *   VFS supplied @ctx.
  *
  * Returns:
  *   Zero.
-- 
2.17.1

