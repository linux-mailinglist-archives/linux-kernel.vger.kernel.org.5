Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E7C7B7788
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjJDFr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjJDFr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:47:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C7BA7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 22:47:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1c723f1c80fso12847825ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 22:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696398444; x=1697003244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zsxyl+cgvB20az6pAOhEj6zcICahCJD5e9PCu7NYewo=;
        b=B4W2YvhSxELbbt85SEONrx+NQBRFi/SoiS9TwHtw8krs8mmvHrusLALBu2UrTXndvl
         iIOm9x4PKA2rkXB3IYXleCM+TfaI2YfHvubWiJ6r+LPqD00oDUNEV9epzH0/zGTbh8LJ
         cVQr7uSe69RTbmygLvtGIJBrTJ7Qq3VGp3U7KYi85MwU3kco0NaiFPNQbevIK/DvC/Vl
         n4OMLLjZMBHco02t8nHynNv+rwuMtGWxLBQf/oQiqnRS3sKoS2Ln/Jpc5iBal5B77g75
         KO8coNJOAb8Py84gOMSK46lnPZFN5ZxFd+BGp+68e9pi0Gqhn4A1BcjwlsR9rBW3aBmZ
         DMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696398444; x=1697003244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsxyl+cgvB20az6pAOhEj6zcICahCJD5e9PCu7NYewo=;
        b=PSkAkboZ7mlyj1s7uvkk8wOx4RN39j99erRVnaQVaJdchCSAPNXQ2qfhXxvLA910ft
         T1bBvicKWG95bPdQaBARnYmcKnu41dwXiLXxcqx1Fuu244aB24K6u1TmlqjpuMl5Cztk
         Iov6TPC/1gonF6gJPESQECcOrF1R3I5HQX3Ah6cCwVIRfbX10zOXExqW+3f+WSIX1Sih
         xUorK4Q3dBkd1xFarhbnq15BNclV82IDYfZ15XK6jowCxX9KL9sjYgmdSzRxnhckJ8Fy
         5/3wn20eaTpUqyvxC1PmkoufbGJ9RfR9EfPtp97bSePYnFTzzaBJtBCsJqLSPYzd8SVM
         cMzQ==
X-Gm-Message-State: AOJu0YwRWQFwdThOhxjMb4HLkS2XfPIczD8ej2VIFWAdCqLIZbeuFJeo
        Shpacc2qknRhLHHt7VuayyU=
X-Google-Smtp-Source: AGHT+IG3mhIIeNTaduBdTCLgjgOUoe7QYgJDvI3JPdeOSEYfO5qXALn6EjHaFi7WvEOaDwydjEaYjA==
X-Received: by 2002:a17:903:32cf:b0:1c7:56b9:eae with SMTP id i15-20020a17090332cf00b001c756b90eaemr1547394plr.32.1696398444432;
        Tue, 03 Oct 2023 22:47:24 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902ab9500b001c5fc11c085sm2631846plr.264.2023.10.03.22.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 22:47:24 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     dave.kleikamp@oracle.com
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
Subject: [PATCH v3] jfs: fix array-index-out-of-bounds in dbFindLeaf
Date:   Wed,  4 Oct 2023 11:17:18 +0530
Message-Id: <20231004054718.7976-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
V2 -> V3: Changed the argument name from type to is_ctl
V1 -> V2: Updated dbFindLeaf function.

 fs/jfs/jfs_dmap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a14a0f18a4c4..d2a4fced8976 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -87,7 +87,7 @@ static int dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno,
 static int dbExtend(struct inode *ip, s64 blkno, s64 nblocks, s64 addnblocks);
 static int dbFindBits(u32 word, int l2nb);
 static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno);
-static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx);
+static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl);
 static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 		      int nblocks);
 static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
@@ -1709,7 +1709,7 @@ static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno)
 		 * dbFindLeaf() returns the index of the leaf at which
 		 * free space was found.
 		 */
-		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx);
+		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx, true);
 
 		/* release the buffer.
 		 */
@@ -1956,7 +1956,7 @@ dbAllocDmapLev(struct bmap * bmp,
 	 * free space.  if sufficient free space is found, dbFindLeaf()
 	 * returns the index of the leaf at which free space was found.
 	 */
-	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
+	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, false))
 		return -ENOSPC;
 
 	if (leafidx < 0)
@@ -2920,14 +2920,18 @@ static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
  *	leafidx	- return pointer to be set to the index of the leaf
  *		  describing at least l2nb free blocks if sufficient
  *		  free blocks are found.
+ *	is_ctl	- determines if the tree is of type ctl
  *
  * RETURN VALUES:
  *	0	- success
  *	-ENOSPC	- insufficient free blocks.
  */
-static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
+static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 {
 	int ti, n = 0, k, x = 0;
+	int max_size;
+
+	max_size = is_ctl ? CTLTREESIZE : TREESIZE;
 
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

