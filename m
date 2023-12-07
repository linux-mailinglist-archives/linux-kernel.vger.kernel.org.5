Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F599809333
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443979AbjLGVUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjLGVUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:20:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFCC1706
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=47QJ8iGehEWhUUW60fV3AigzZvj3J9IhOy+fBQpnUAA=; b=Vv+tz/1gW3MODG1/Ypg7LUQfK8
        YFJECCA/ZMrNY0tsbWy6gaNPtY7onb8ZMvw3IEpFq2oGBSR0RaUBDWjbdvBwU4XYPYO2HfVprq5P+
        who5gc+mIHdEYJqrpykUddTYmeVzBDYiBV/nbSkItcaxaDg+HBGYkUjChg9tnjcXgzLfjAFTuBA1+
        BpZaOWycx6UwBsjC1SbE7a8l1TmE3UsZkD2GLVhPQh+WlnKCuK+a7oy9EDwouTKwhxe3HuAxs8z8j
        cM6FhMPlunijJZMYNASwrFj45KxHBs+OlG6e0Rn9xgX4RTK180W4mzQtlR2/T8zUvOcE/IkTBXEBk
        c1qB2Pbw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBLnQ-00Dwiu-15;
        Thu, 07 Dec 2023 21:20:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] freevxfs: bmap: fix kernel-doc warnings
Date:   Thu,  7 Dec 2023 13:20:33 -0800
Message-ID: <20231207212035.25345-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix -Wall kernel-doc warnings in vxfs_bmap.c:

vxfs_bmap.c:44: warning: Function parameter or member 'bn' not described in 'vxfs_bmap_ext4'
vxfs_bmap.c:44: warning: Excess function parameter 'iblock' description in 'vxfs_bmap_ext4'
vxfs_bmap.c:108: warning: No description found for return value of 'vxfs_bmap_indir'
vxfs_bmap.c:187: warning: No description found for return value of 'vxfs_bmap_typed'
vxfs_bmap.c:251: warning: No description found for return value of 'vxfs_bmap1'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/freevxfs/vxfs_bmap.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
--- a/fs/freevxfs/vxfs_bmap.c
+++ b/fs/freevxfs/vxfs_bmap.c
@@ -29,7 +29,7 @@ vxfs_typdump(struct vxfs_typed *typ)
 /**
  * vxfs_bmap_ext4 - do bmap for ext4 extents
  * @ip:		pointer to the inode we do bmap for
- * @iblock:	logical block.
+ * @bn:		logical block.
  *
  * Description:
  *   vxfs_bmap_ext4 performs the bmap operation for inodes with
@@ -97,7 +97,7 @@ fail_buf:
  *   vxfs_bmap_indir reads a &struct vxfs_typed at @indir
  *   and performs the type-defined action.
  *
- * Return Value:
+ * Returns:
  *   The physical block number on success, else Zero.
  *
  * Note:
@@ -179,7 +179,7 @@ out:
  * Description:
  *   Performs the bmap operation for typed extents.
  *
- * Return Value:
+ * Returns:
  *   The physical block number on success, else Zero.
  */
 static daddr_t
@@ -243,7 +243,7 @@ vxfs_bmap_typed(struct inode *ip, long i
  *   vxfs_bmap1 perfoms a logical to physical block mapping
  *   for vxfs-internal purposes.
  *
- * Return Value:
+ * Returns:
  *   The physical block number on success, else Zero.
  */
 daddr_t
