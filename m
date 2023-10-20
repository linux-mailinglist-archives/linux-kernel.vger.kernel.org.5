Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FCD7D05FF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346767AbjJTBEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJTBEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:04:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB2D115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:04:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso308579b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697763846; x=1698368646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tZEu1tTHsXOAO6i+L1Ure9U7W9vkxyyQjJZzVAPsBKs=;
        b=kSHWfjo4aJbHfhitQkFRH7jV4hKVaVsU03pIpYbqYWzWTESYUuV03jOL3oi0YXaFbu
         FiQql8r0/tBhrTVqFrTQ7kgWQwiXNAZ8FtiQALdvU25R75rEG54lMLQmeJKO7Gvf8BQh
         DmFaiwjvGbHbXvfNJ5g7AyOeK6lgB3NmfYZf9eIM72O5opV/DjsziGADjT6/Oroj0rZD
         A0by8cOi+y+MmTFs1MHREmjm1ldKgVTa5qGeZU1CukCXjE0dujXe6Hd7rYhJrjRtTsNG
         NaBPqbxaaCEGax/ZXhWhqLUxE/D5WB89JL+IaQ/26qgE5uWLVVWRcDhAofGAYEwUZpZk
         f0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697763846; x=1698368646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZEu1tTHsXOAO6i+L1Ure9U7W9vkxyyQjJZzVAPsBKs=;
        b=d2QBnjM7pYjEBQu5XLbX2bGuLyaitldXcxwLWweRY0UyLc6VeSInMj6LhOVOb7SUMg
         C549K+ZwL/VOWzQhnGb2nZnctaLwsPgmT/jG1CzdoPdwRJajMxm2iUUsff40eTl18VIu
         yBkyT+sEuKZW7vMTuc6R9CHG8CJqUmPdxUH1QySssjwuGBq0fRIobc3hLS9XiR4WZYut
         ASV+TcoC0OQevqJ9wdouWGKq/SJneIT1/Pf4EW1ZlEuyxbgVRqUfeCq7pX4O9JwQFQvH
         CnLf2CK+qm4o8p4rbERXPA6BpTAZgk6L0dCFaDD/sZJNDJIqUdBdH/ioM9r8TE4joJPX
         MuXQ==
X-Gm-Message-State: AOJu0YylRMA1FS0jFMuBp1KFnCo+0rZqpVr3JMfN3L+tHDToKhBYCU8k
        W1IerTKllRW1S4NiB66vg9ItpEn/ExM=
X-Google-Smtp-Source: AGHT+IHbC4c1yQxE9Ko2eHYtsHxrXpBjMzoMME8rjWLs4ekZ6ymfBYFv+oJ2WgxF4Qo4UJVue1qEUQ==
X-Received: by 2002:a05:6a21:4887:b0:179:f7cc:c7e6 with SMTP id av7-20020a056a21488700b00179f7ccc7e6mr384440pzc.38.1697763845258;
        Thu, 19 Oct 2023 18:04:05 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:2586:3997:3e90:5b65])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902db1100b001c9c6a78a56sm329776plx.97.2023.10.19.18.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 18:04:04 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: do not reuse corrupted quota inodes
Date:   Thu, 19 Oct 2023 18:04:01 -0700
Message-ID: <20231020010401.2666246-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

When we detect quota inode corruption, we better deallocate the current
space and allocate new ones for a clean start.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c    | 148 +++++++++++++++++++++++++++++++++++--------------
 fsck/segment.c |   5 +-
 2 files changed, 109 insertions(+), 44 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 99cface..dc8e282 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -67,6 +67,14 @@ int f2fs_set_sit_bitmap(struct f2fs_sb_info *sbi, u32 blk)
 	return f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, blk), fsck->sit_area_bitmap);
 }
 
+static inline int f2fs_clear_sit_bitmap(struct f2fs_sb_info *sbi, u32 blk)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+
+	return f2fs_clear_bit(BLKOFF_FROM_MAIN(sbi, blk),
+						fsck->sit_area_bitmap);
+}
+
 static int add_into_hard_link_list(struct f2fs_sb_info *sbi,
 						u32 nid, u32 link_cnt)
 {
@@ -2150,6 +2158,9 @@ int fsck_chk_quota_node(struct f2fs_sb_info *sbi)
 	return ret;
 }
 
+static void fsck_disconnect_file(struct f2fs_sb_info *sbi, nid_t ino,
+			bool dealloc);
+
 int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -2181,6 +2192,8 @@ int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
 		if (c.fix_on) {
 			DBG(0, "Fixing Quota file ([%3d] ino [0x%x])\n",
 							qtype, ino);
+			fsck_disconnect_file(sbi, ino, true);
+			f2fs_rebuild_qf_inode(sbi, qtype);
 			f2fs_filesize_update(sbi, ino, 0);
 			ret = quota_write_inode(sbi, qtype);
 			if (!ret) {
@@ -2874,10 +2887,53 @@ static int fsck_do_reconnect_file(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
-static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
-					struct f2fs_inode *inode, nid_t nid)
+static inline void release_inode_cnt(struct f2fs_sb_info *sbi, bool dealloc)
+{
+	F2FS_FSCK(sbi)->chk.valid_inode_cnt--;
+	if (dealloc)
+		sbi->total_valid_inode_count--;
+}
+
+static inline void release_node_cnt(struct f2fs_sb_info *sbi, bool dealloc)
+{
+	F2FS_FSCK(sbi)->chk.valid_node_cnt--;
+	if (dealloc)
+		sbi->total_valid_node_count--;
+}
+
+static inline void release_block_cnt(struct f2fs_sb_info *sbi, bool dealloc)
+{
+	F2FS_FSCK(sbi)->chk.valid_blk_cnt--;
+	if (dealloc)
+		sbi->total_valid_block_count--;
+}
+
+static inline void release_block(struct f2fs_sb_info *sbi, u64 blkaddr,
+			bool dealloc)
+{
+	f2fs_clear_main_bitmap(sbi, blkaddr);
+	if (dealloc) {
+		struct seg_entry *se;
+		u64 offset;
+
+		se = get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr));
+		offset = OFFSET_IN_SEG(sbi, blkaddr);
+		se->valid_blocks--;
+		f2fs_clear_bit(offset, (char *)se->cur_valid_map);
+		se->dirty = 1;
+		f2fs_clear_sit_bitmap(sbi, blkaddr);
+	}
+}
+
+static inline void release_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
+{
+	nullify_nat_entry(sbi, nid);
+	F2FS_FSCK(sbi)->chk.valid_nat_entry_cnt--;
+}
+
+static void fsck_disconnect_file_dnode(struct f2fs_sb_info *sbi,
+			struct f2fs_inode *inode, nid_t nid, bool dealloc)
 {
-	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_node *node;
 	struct node_info ni;
 	u32 addr;
@@ -2890,27 +2946,29 @@ static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
 	err = dev_read_block(node, ni.blk_addr);
 	ASSERT(err >= 0);
 
-	fsck->chk.valid_node_cnt--;
-	fsck->chk.valid_blk_cnt--;
-	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
+	release_node_cnt(sbi, dealloc);
+	release_block_cnt(sbi, dealloc);
+	release_block(sbi, ni.blk_addr, dealloc);
 
 	for (i = 0; i < ADDRS_PER_BLOCK(inode); i++) {
 		addr = le32_to_cpu(node->dn.addr[i]);
 		if (!addr)
 			continue;
-		fsck->chk.valid_blk_cnt--;
+		release_block_cnt(sbi, dealloc);
 		if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
 			continue;
-		f2fs_clear_main_bitmap(sbi, addr);
+		release_block(sbi, addr, dealloc);
 	}
 
+	if (dealloc)
+		release_nat_entry(sbi, nid);
+
 	free(node);
 }
 
-static void fsck_failed_reconnect_file_idnode(struct f2fs_sb_info *sbi,
-					struct f2fs_inode *inode, nid_t nid)
+static void fsck_disconnect_file_idnode(struct f2fs_sb_info *sbi,
+			struct f2fs_inode *inode, nid_t nid, bool dealloc)
 {
-	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_node *node;
 	struct node_info ni;
 	nid_t tmp;
@@ -2923,24 +2981,26 @@ static void fsck_failed_reconnect_file_idnode(struct f2fs_sb_info *sbi,
 	err = dev_read_block(node, ni.blk_addr);
 	ASSERT(err >= 0);
 
-	fsck->chk.valid_node_cnt--;
-	fsck->chk.valid_blk_cnt--;
-	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
+	release_node_cnt(sbi, dealloc);
+	release_block_cnt(sbi, dealloc);
+	release_block(sbi, ni.blk_addr, dealloc);
 
 	for (i = 0; i < NIDS_PER_BLOCK; i++) {
 		tmp = le32_to_cpu(node->in.nid[i]);
 		if (!tmp)
 			continue;
-		fsck_failed_reconnect_file_dnode(sbi, inode, tmp);
+		fsck_disconnect_file_dnode(sbi, inode, tmp, dealloc);
 	}
 
+	if (dealloc)
+		release_nat_entry(sbi, nid);
+
 	free(node);
 }
 
-static void fsck_failed_reconnect_file_didnode(struct f2fs_sb_info *sbi,
-					struct f2fs_inode *inode, nid_t nid)
+static void fsck_disconnect_file_didnode(struct f2fs_sb_info *sbi,
+			struct f2fs_inode *inode, nid_t nid, bool dealloc)
 {
-	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_node *node;
 	struct node_info ni;
 	nid_t tmp;
@@ -2953,28 +3013,26 @@ static void fsck_failed_reconnect_file_didnode(struct f2fs_sb_info *sbi,
 	err = dev_read_block(node, ni.blk_addr);
 	ASSERT(err >= 0);
 
-	fsck->chk.valid_node_cnt--;
-	fsck->chk.valid_blk_cnt--;
-	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
+	release_node_cnt(sbi, dealloc);
+	release_block_cnt(sbi, dealloc);
+	release_block(sbi, ni.blk_addr, dealloc);
 
 	for (i = 0; i < NIDS_PER_BLOCK; i++) {
 		tmp = le32_to_cpu(node->in.nid[i]);
 		if (!tmp)
 			continue;
-		fsck_failed_reconnect_file_idnode(sbi, inode, tmp);
+		fsck_disconnect_file_idnode(sbi, inode, tmp, dealloc);
 	}
 
+	if (dealloc)
+		release_nat_entry(sbi, nid);
+
 	free(node);
 }
 
-/*
- * Counters and main_area_bitmap are already changed during checking
- * inode block, so clear them. There is no need to clear new blocks
- * allocted to lost+found.
- */
-static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid_t ino)
+static void fsck_disconnect_file(struct f2fs_sb_info *sbi, nid_t ino,
+			bool dealloc)
 {
-	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_node *node;
 	struct node_info ni;
 	nid_t nid;
@@ -2988,18 +3046,18 @@ static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid_t ino)
 	ASSERT(err >= 0);
 
 	/* clear inode counters */
-	fsck->chk.valid_inode_cnt--;
-	fsck->chk.valid_node_cnt--;
-	fsck->chk.valid_blk_cnt--;
-	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
+	release_inode_cnt(sbi, dealloc);
+	release_node_cnt(sbi, dealloc);
+	release_block_cnt(sbi, dealloc);
+	release_block(sbi, ni.blk_addr, dealloc);
 
 	/* clear xnid counters */
 	if (node->i.i_xattr_nid) {
 		nid = le32_to_cpu(node->i.i_xattr_nid);
-		fsck->chk.valid_node_cnt--;
-		fsck->chk.valid_blk_cnt--;
+		release_node_cnt(sbi, dealloc);
+		release_block_cnt(sbi, dealloc);
 		get_node_info(sbi, nid, &ni);
-		f2fs_clear_main_bitmap(sbi, ni.blk_addr);
+		release_block(sbi, ni.blk_addr, dealloc);
 	}
 
 	/* clear data counters */
@@ -3009,10 +3067,10 @@ static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid_t ino)
 			block_t addr = le32_to_cpu(node->i.i_addr[ofs + i]);
 			if (!addr)
 				continue;
-			fsck->chk.valid_blk_cnt--;
+			release_block_cnt(sbi, dealloc);
 			if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
 				continue;
-			f2fs_clear_main_bitmap(sbi, addr);
+			release_block(sbi, addr, dealloc);
 		}
 	}
 
@@ -3024,18 +3082,24 @@ static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid_t ino)
 		switch (i) {
 		case 0: /* direct node */
 		case 1:
-			fsck_failed_reconnect_file_dnode(sbi, &node->i, nid);
+			fsck_disconnect_file_dnode(sbi, &node->i, nid,
+					dealloc);
 			break;
 		case 2: /* indirect node */
 		case 3:
-			fsck_failed_reconnect_file_idnode(sbi, &node->i, nid);
+			fsck_disconnect_file_idnode(sbi, &node->i, nid,
+					dealloc);
 			break;
 		case 4: /* double indirect node */
-			fsck_failed_reconnect_file_didnode(sbi, &node->i, nid);
+			fsck_disconnect_file_didnode(sbi, &node->i, nid,
+					dealloc);
 			break;
 		}
 	}
 
+	if (dealloc)
+		release_nat_entry(sbi, ino);
+
 	free(node);
 }
 
@@ -3121,7 +3185,7 @@ static int fsck_reconnect_file(struct f2fs_sb_info *sbi)
 			if (fsck_do_reconnect_file(sbi, lpf_node, node)) {
 				DBG(1, "Failed to reconnect inode [0x%x]\n",
 				    nid);
-				fsck_failed_reconnect_file(sbi, nid);
+				fsck_disconnect_file(sbi, nid, false);
 				continue;
 			}
 
diff --git a/fsck/segment.c b/fsck/segment.c
index 3a9500f..4b05fd4 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -36,7 +36,7 @@ int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 				ERR_MSG("Not enough space\n");
 				return -ENOSPC;
 			}
-			if (is_node && fsck->chk.valid_node_cnt >=
+			if (is_node && fsck->chk.valid_node_cnt >
 					sbi->total_valid_node_count) {
 				ERR_MSG("Not enough space for node block\n");
 				return -ENOSPC;
@@ -76,7 +76,7 @@ int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 
 	se = get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr));
 	offset = OFFSET_IN_SEG(sbi, blkaddr);
-	se->type = type;
+	se->type = se->orig_type = type;
 	if (se->valid_blocks == 0)
 		SM_I(sbi)->free_segments--;
 	se->valid_blocks++;
@@ -101,6 +101,7 @@ int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 		if (c.func == FSCK) {
 			fsck->chk.valid_blk_cnt++;
 			if (is_node) {
+				fsck->chk.valid_nat_entry_cnt++;
 				fsck->chk.valid_node_cnt++;
 				if (is_inode)
 					fsck->chk.valid_inode_cnt++;
-- 
2.42.0.655.g421f12c284-goog

