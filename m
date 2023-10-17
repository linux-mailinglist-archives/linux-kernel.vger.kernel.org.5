Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EAF7CC330
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbjJQMaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbjJQM37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:29:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC9C46BD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:20:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1c77449a6daso44998605ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697545230; x=1698150030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rr3aW7LK1XAhrtCj3229DIhxXbjMtybVhITPYZZVzq0=;
        b=l11+wBQ4eKGPivsXNU8Vq/uXkY82/msfr4mm6hE5+BnLf8KKLEQb5kwhyj50bjJdRz
         MUUrpRIFg/D9flXEhjpr4T0bByaJZCjnYDf1QalW8SfCJtFX88Tmzb5FC+fmEEeesQ0+
         mqkknjGGskF0YEobCYDWh0jPJ/8To7pCB1ggTe7eMUno23CKYqEX0QZ7wWuEVeGTOFy6
         7sC5jrTc8fSBlAWCLBS+M2NOS1jgGQJ/7wsEQgO5leHf6Q7ILCP92tcTADUKw0wDNai+
         AcmjaSY+lTDq4KSgAmzGVHUw2oZ1P7Y5VCngPlU0P3rdO4rYKAzRwBS/g2aqwLWlbZev
         +Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697545230; x=1698150030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rr3aW7LK1XAhrtCj3229DIhxXbjMtybVhITPYZZVzq0=;
        b=atNZRrggSVHVv8kY3N3lMA3ovZMAjBUVGZFtsz+de8rHUpOP2+HaSnWk9eWDSeuDyi
         3QHhyLdlVD4AwJqplBZ/ocWyYyUHdoT6XgLnWiuPVxr7XWWmdjUhqKFz/833btpbuHX0
         Zp6HMJk8YkOcpWkitRrhzFX1+lnRznTWxi2lHvNlD/wBvxyAVAi1s5ogt4d8KBgKdWPR
         0cPrirzTXiRFJNZTTzukcpTQzQ3DaVwrewvj6B3zumxx7x95gYz7ypq4Ph3PeTBiY3dZ
         Qugg2p0L/hRE+5LOBMGORSp5a9VB/Ez7ebyyRmPM7ADtM9FKvf3aHxQFmy/TInBmhhJb
         0GNQ==
X-Gm-Message-State: AOJu0YzidtoN/90ODQjGQ2Gve+C8C5NxGISMSb8Km29SXtkYyFP3+eE5
        Osgq4TEnaEB0uVi7OGu7j8Y=
X-Google-Smtp-Source: AGHT+IFJzi8P08ZvJ6HuW6FFT+GWNbpO2WFeyN5U6zh3XLZArnSJZAZwBC+SNpOiOW3G0+1tqmqiCw==
X-Received: by 2002:a17:903:32d0:b0:1ca:1be4:bda4 with SMTP id i16-20020a17090332d000b001ca1be4bda4mr2196950plr.4.1697545229477;
        Tue, 17 Oct 2023 05:20:29 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001bbab888ba0sm1383541plb.138.2023.10.17.05.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:20:29 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix array-index-out-of-bounds in dbAdjTree
Date:   Tue, 17 Oct 2023 17:33:56 +0530
Message-Id: <20231017120356.55322-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a bound check missing in the dbAdjTree while
accessing the dmt_stree. To add the required check added the bool is_ctl
which is required to determine the size as suggest in the following
commit.
https://lore.kernel.org/linux-kernel-mentees/f9475918-2186-49b8-b801-6f0f9e75f4fa@oracle.com/

Reported-by: syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=39ba34a099ac2e9bd3cb
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
 fs/jfs/jfs_dmap.c | 57 ++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 88afd108c2dd..57fba21994c3 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -63,10 +63,10 @@
  */
 static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			int nblocks);
-static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval);
-static int dbBackSplit(dmtree_t * tp, int leafno);
-static int dbJoin(dmtree_t * tp, int leafno, int newval);
-static void dbAdjTree(dmtree_t * tp, int leafno, int newval);
+static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval, bool is_ctl);
+static int dbBackSplit(dmtree_t * tp, int leafno, bool is_ctl);
+static int dbJoin(dmtree_t * tp, int leafno, int newval, bool is_ctl);
+static void dbAdjTree(dmtree_t * tp, int leafno, int newval, bool is_ctl);
 static int dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc,
 		    int level);
 static int dbAllocAny(struct bmap * bmp, s64 nblocks, int l2nb, s64 * results);
@@ -2096,7 +2096,7 @@ static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
 		 * system.
 		 */
 		if (dp->tree.stree[word] == NOFREE)
-			dbBackSplit((dmtree_t *) & dp->tree, word);
+			dbBackSplit((dmtree_t *) & dp->tree, word, false);
 
 		dbAllocBits(bmp, dp, blkno, nblocks);
 	}
@@ -2182,7 +2182,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			 * the binary system of the leaves if need be.
 			 */
 			dbSplit(tp, word, BUDMIN,
-				dbMaxBud((u8 *) & dp->wmap[word]));
+				dbMaxBud((u8 *) & dp->wmap[word]),false);
 
 			word += 1;
 		} else {
@@ -2222,7 +2222,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 				 * system of the leaves to reflect the current
 				 * allocation (size).
 				 */
-				dbSplit(tp, word, size, NOFREE);
+				dbSplit(tp, word, size, NOFREE, false);
 
 				/* get the number of dmap words handled */
 				nw = BUDSIZE(size, BUDMIN);
@@ -2329,7 +2329,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			/* update the leaf for this dmap word.
 			 */
 			rc = dbJoin(tp, word,
-				    dbMaxBud((u8 *) & dp->wmap[word]));
+				    dbMaxBud((u8 *) & dp->wmap[word]),false);
 			if (rc)
 				return rc;
 
@@ -2362,7 +2362,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 
 				/* update the leaf.
 				 */
-				rc = dbJoin(tp, word, size);
+				rc = dbJoin(tp, word, size, false);
 				if (rc)
 					return rc;
 
@@ -2514,16 +2514,16 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 		 * that it is at the front of a binary buddy system.
 		 */
 		if (oldval == NOFREE) {
-			rc = dbBackSplit((dmtree_t *) dcp, leafno);
+			rc = dbBackSplit((dmtree_t *) dcp, leafno, true);
 			if (rc) {
 				release_metapage(mp);
 				return rc;
 			}
 			oldval = dcp->stree[ti];
 		}
-		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval);
+		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval, true);
 	} else {
-		rc = dbJoin((dmtree_t *) dcp, leafno, newval);
+		rc = dbJoin((dmtree_t *) dcp, leafno, newval, true);
 		if (rc) {
 			release_metapage(mp);
 			return rc;
@@ -2554,7 +2554,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 				 */
 				if (alloc) {
 					dbJoin((dmtree_t *) dcp, leafno,
-					       oldval);
+					       oldval, true);
 				} else {
 					/* the dbJoin() above might have
 					 * caused a larger binary buddy system
@@ -2564,9 +2564,9 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 					 */
 					if (dcp->stree[ti] == NOFREE)
 						dbBackSplit((dmtree_t *)
-							    dcp, leafno);
+							    dcp, leafno, true);
 					dbSplit((dmtree_t *) dcp, leafno,
-						dcp->budmin, oldval);
+						dcp->budmin, oldval, true);
 				}
 
 				/* release the buffer and return the error.
@@ -2614,7 +2614,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
  *
  * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
  */
-static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
+static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval, bool is_ctl)
 {
 	int budsz;
 	int cursz;
@@ -2636,7 +2636,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
 		while (cursz >= splitsz) {
 			/* update the buddy's leaf with its new value.
 			 */
-			dbAdjTree(tp, leafno ^ budsz, cursz);
+			dbAdjTree(tp, leafno ^ budsz, cursz, is_ctl);
 
 			/* on to the next size and buddy.
 			 */
@@ -2648,7 +2648,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
 	/* adjust the dmap tree to reflect the specified leaf's new
 	 * value.
 	 */
-	dbAdjTree(tp, leafno, newval);
+	dbAdjTree(tp, leafno, newval, is_ctl);
 }
 
 
@@ -2679,7 +2679,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
  *
  * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
  */
-static int dbBackSplit(dmtree_t * tp, int leafno)
+static int dbBackSplit(dmtree_t * tp, int leafno, bool is_ctl)
 {
 	int budsz, bud, w, bsz, size;
 	int cursz;
@@ -2730,7 +2730,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
 				 * system in two.
 				 */
 				cursz = leaf[bud] - 1;
-				dbSplit(tp, bud, cursz, cursz);
+				dbSplit(tp, bud, cursz, cursz, is_ctl);
 				break;
 			}
 		}
@@ -2758,7 +2758,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
  *
  * RETURN VALUES: none
  */
-static int dbJoin(dmtree_t * tp, int leafno, int newval)
+static int dbJoin(dmtree_t * tp, int leafno, int newval, bool is_ctl)
 {
 	int budsz, buddy;
 	s8 *leaf;
@@ -2813,12 +2813,12 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
 			if (leafno < buddy) {
 				/* leafno is the left buddy.
 				 */
-				dbAdjTree(tp, buddy, NOFREE);
+				dbAdjTree(tp, buddy, NOFREE, is_ctl);
 			} else {
 				/* buddy is the left buddy and becomes
 				 * leafno.
 				 */
-				dbAdjTree(tp, leafno, NOFREE);
+				dbAdjTree(tp, leafno, NOFREE, is_ctl);
 				leafno = buddy;
 			}
 
@@ -2831,7 +2831,7 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
 
 	/* update the leaf value.
 	 */
-	dbAdjTree(tp, leafno, newval);
+	dbAdjTree(tp, leafno, newval, is_ctl);
 
 	return 0;
 }
@@ -2852,15 +2852,20 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
  *
  * RETURN VALUES: none
  */
-static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
+static void dbAdjTree(dmtree_t * tp, int leafno, int newval, bool is_ctl)
 {
 	int lp, pp, k;
-	int max;
+	int max, size;
+
+	size = is_ctl ? CTLTREESIZE : TREESIZE;
 
 	/* pick up the index of the leaf for this leafno.
 	 */
 	lp = leafno + le32_to_cpu(tp->dmt_leafidx);
 
+	if (lp > size || lp < 0)
+		return;
+
 	/* is the current value the same as the old value ?  if so,
 	 * there is nothing to do.
 	 */
-- 
2.37.2

