Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2C7AB1B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjIVMET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjIVMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:04:06 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5856CCFC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:03:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-692a9bc32bcso498063b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695384239; x=1695989039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc7XJnmS11CqbPLUjM8JwVx1WO2hj/AOe6VqltwSQAE=;
        b=AKKnIXhhngXcGL/CLXkQ5gJefmJdayKV2DcY0TIJOXWvZarLNltQ2tekMxxYmBan5H
         ym5MjkKOefnm15ZIiVjZSR8FNV/A/PUUYoZ2Logd3GUXMCDdjSwKZnOkzRn7jn9Trpq4
         r2vp+QmgZF55SV03j/UaUpwhgc6tJQLwLiq8NuP62vpefGP3QMBbOrp7ETp+jOpA87wX
         6xi2RHjfAR30V04fcy4yDuevnD/ExawdW5Fwq97u1tx++VcSmDbWMr2tKVcYFBQ5V7K4
         c+9BXXFvPA2fkYeH5ZK/L6GWvj6uGsaQPyMc1Z77RFbknolgyGF+hSZQZ7zd+e2IvrDh
         a1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695384239; x=1695989039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mc7XJnmS11CqbPLUjM8JwVx1WO2hj/AOe6VqltwSQAE=;
        b=G1gXtzTc3GaFsgEmW3ZSJMwObg+ixYHYRpkFGWY1w/mBbV33h6quT2QtC/2dJvqCH0
         NdpqjV91NEz6PJcKKNi0a+FO5HHgM2NJjLhm3Cl4cwaL2imuBd/bwcpbRbbWCF81BOO6
         4g201crt/+VuEbMIB44qC8usAsrMfent5s2p7FeDBHMrDK6sIi2lk+L07NZWs2NqktCX
         LXV5yH894rSRduEahJU5DofcZB4bA8m0AxFGDYA/sD4cWkS2c7cd/1Va0Yq8JPL10Nfx
         aS7D6yFFHNFpRgXZqZlvDRCaInqRYzHm2jaMLfLqGjdJNO2vK3NMZT64nkFpx/W9AFsC
         di8Q==
X-Gm-Message-State: AOJu0YxHh+pbolKpfoRUXrKEvrEa35CAk5iYIf4tbdVVAn/8tJvGhxwq
        dr0IQ/IKW7qKwHPA2RUNkQg=
X-Google-Smtp-Source: AGHT+IGlTQWmfBmuHR/BYvJUK5cUqZbXxjfnyQ8/HUHaO1sGhUhAe3+W2yPuELQd5nbQr6DptDUNfw==
X-Received: by 2002:a05:6a20:5486:b0:14d:7130:7bb3 with SMTP id i6-20020a056a20548600b0014d71307bb3mr10430003pzk.13.1695384238425;
        Fri, 22 Sep 2023 05:03:58 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id 131-20020a630289000000b00528db73ed70sm3042486pgc.3.2023.09.22.05.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:03:57 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
Subject: [PATCH v2] jfs: fix array-index-out-of-bounds in dbFindLeaf
Date:   Fri, 22 Sep 2023 17:33:41 +0530
Message-Id: <20230922120341.10805-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently while searching for dmtree_t for sufficient free blocks there
is an array out of bounds while getting element in tp->dm_stree. To add
the required check for out of bound we first need to determine the type
of dmtree. Thus added an extra parameter to dbFindLeaf so that the type
of tree can be determined and the required check can be applied.

Reported-by: syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aea1ad91e854d0a83e04
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
V1 -> V2: Updated dbFindLeaf function.

 fs/jfs/jfs_dmap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a14a0f18a4c4..cee5164c4879 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -87,7 +87,7 @@ static int dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno,
 static int dbExtend(struct inode *ip, s64 blkno, s64 nblocks, s64 addnblocks);
 static int dbFindBits(u32 word, int l2nb);
 static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno);
-static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx);
+static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, int type);
 static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 		      int nblocks);
 static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
@@ -1709,7 +1709,7 @@ static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno)
 		 * dbFindLeaf() returns the index of the leaf at which
 		 * free space was found.
 		 */
-		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx);
+		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx, 0);
 
 		/* release the buffer.
 		 */
@@ -1956,7 +1956,7 @@ dbAllocDmapLev(struct bmap * bmp,
 	 * free space.  if sufficient free space is found, dbFindLeaf()
 	 * returns the index of the leaf at which free space was found.
 	 */
-	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
+	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, 1))
 		return -ENOSPC;
 
 	if (leafidx < 0)
@@ -2920,14 +2920,18 @@ static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
  *	leafidx	- return pointer to be set to the index of the leaf
  *		  describing at least l2nb free blocks if sufficient
  *		  free blocks are found.
+ *	type	- type of dmtree
  *
  * RETURN VALUES:
  *	0	- success
  *	-ENOSPC	- insufficient free blocks.
  */
-static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
+static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, int type)
 {
 	int ti, n = 0, k, x = 0;
+	int max_size;
+
+	max_size = type ? TREESIZE : CTLTREESIZE;
 
 	/* first check the root of the tree to see if there is
 	 * sufficient free space.
@@ -2948,6 +2952,8 @@ static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
 			/* sufficient free space found.  move to the next
 			 * level (or quit if this is the last level).
 			 */
+			if (x + n > max_size)
+				return -ENOSPC;
 			if (l2nb <= tp->dmt_stree[x + n])
 				break;
 		}
-- 
2.37.2

