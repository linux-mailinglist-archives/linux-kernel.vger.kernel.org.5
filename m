Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C858C7BEB96
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378590AbjJIU30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJIU3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:29:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912599E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:29:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c8a6aa0cd1so7465205ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696883364; x=1697488164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNWvqx+TZumLgslLCmyx3nUs5iegGwECzTZpwyFt1BY=;
        b=k+6bkq9E894du/voSLd8443pUKYc0DVZ6Mjbfq9yq5PseYaQ1v4RNcVhxLpCWYLHVy
         JBal5duqXrvfGNFWSA3DRGGGX6Q62mRFJ/d7VPoyoSJtO6tTFh1WQQqVsHW4kGJ/dAMj
         B34y4+3YEOSdImyxYLZl7BQNwhMwrlnHvGLrQRWmUkO80h7cO9fktz908FZ4zeaFrd/2
         KITOUhTjtQGmBmB28DPHCchIMYXzyupBB3Yi2TJnxhVFBVctH6y7AwH2lddCvXGJL10z
         an4SWpGwZjyDHwvALaEHBjFZMeVVPeDcfEOt8kETB2g0AkZBLms1KvjfZMYLo8R/ymtN
         OFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696883364; x=1697488164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNWvqx+TZumLgslLCmyx3nUs5iegGwECzTZpwyFt1BY=;
        b=gm+xrqMF0aKPdA0JFiMl8fv3o/0FMIFWcPDPDNWd9jr9RUepXYhUAydYWUN4IPzXey
         xYmnmwpmI0kCwYLVoaVi6gV4MnrQvR4sdNIQVgd3/KJ0M6Oar6beoMtX5mlhgEw/pC07
         k3dPl26rTkU0bGbqX5yZ8MGYdWGBoLIekySLOTveaLgPMvcvYR8PGg2yvDDqWuMA5pC+
         O9SwqENS8qCQn4Sbz3kxdPDq64wcHrpJXKF8mNIyf34l7PRjFD+dTlA8TL9nv3dMzrzy
         yKegnqAWm2qe78hLpx5a+9N4CbpjmlnIU7NX471Lc5qqnKbLdBt4cF5jaf9RTygyQKHa
         9BYQ==
X-Gm-Message-State: AOJu0Yy8a0PGYIDO3nWnY/mbP7CY2Ku/u2oFojmakgl8W/++h8vALrrf
        5ECsrj+aK3xSexP3C7xU0RvLQhuZJC0=
X-Google-Smtp-Source: AGHT+IEO1UcwAKvlYfVRJowOzIIjl3b6jfjN+CUhqSQDHyh9SkVUClpyT386+PwKF187dxein0DKCA==
X-Received: by 2002:a17:902:d50f:b0:1c3:bc2a:f6b4 with SMTP id b15-20020a170902d50f00b001c3bc2af6b4mr16637007plg.42.1696883363732;
        Mon, 09 Oct 2023 13:29:23 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:7d85:c4b4:e59e:896])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b001c72c07c9d9sm9962633plz.308.2023.10.09.13.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:29:23 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs-tools: use proper address entry count for direct nodes
Date:   Mon,  9 Oct 2023 13:29:17 -0700
Message-ID: <20231009202917.1835899-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
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

For direct nodes, we have to use DEF_ADDRS_PER_BLOCK.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: pass inode struct as a parameter and check COMPRESS_ADDR
---
 fsck/fsck.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 78ffdb6..3ade728 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2875,7 +2875,7 @@ static int fsck_do_reconnect_file(struct f2fs_sb_info *sbi,
 }
 
 static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
-					     nid_t nid)
+					struct f2fs_inode *inode, nid_t nid)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_node *node;
@@ -2894,12 +2894,12 @@ static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
 	fsck->chk.valid_blk_cnt--;
 	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
 
-	for (i = 0; i < ADDRS_PER_BLOCK(&node->i); i++) {
+	for (i = 0; i < ADDRS_PER_BLOCK(inode); i++) {
 		addr = le32_to_cpu(node->dn.addr[i]);
 		if (!addr)
 			continue;
 		fsck->chk.valid_blk_cnt--;
-		if (addr == NEW_ADDR)
+		if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
 			continue;
 		f2fs_clear_main_bitmap(sbi, addr);
 	}
@@ -2908,7 +2908,7 @@ static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
 }
 
 static void fsck_failed_reconnect_file_idnode(struct f2fs_sb_info *sbi,
-					      nid_t nid)
+					struct f2fs_inode *inode, nid_t nid)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_node *node;
@@ -2931,14 +2931,14 @@ static void fsck_failed_reconnect_file_idnode(struct f2fs_sb_info *sbi,
 		tmp = le32_to_cpu(node->in.nid[i]);
 		if (!tmp)
 			continue;
-		fsck_failed_reconnect_file_dnode(sbi, tmp);
+		fsck_failed_reconnect_file_dnode(sbi, inode, tmp);
 	}
 
 	free(node);
 }
 
 static void fsck_failed_reconnect_file_didnode(struct f2fs_sb_info *sbi,
-					       nid_t nid)
+					struct f2fs_inode *inode, nid_t nid)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_node *node;
@@ -2961,7 +2961,7 @@ static void fsck_failed_reconnect_file_didnode(struct f2fs_sb_info *sbi,
 		tmp = le32_to_cpu(node->in.nid[i]);
 		if (!tmp)
 			continue;
-		fsck_failed_reconnect_file_idnode(sbi, tmp);
+		fsck_failed_reconnect_file_idnode(sbi, inode, tmp);
 	}
 
 	free(node);
@@ -3010,7 +3010,7 @@ static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid_t ino)
 			if (!addr)
 				continue;
 			fsck->chk.valid_blk_cnt--;
-			if (addr == NEW_ADDR)
+			if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
 				continue;
 			f2fs_clear_main_bitmap(sbi, addr);
 		}
@@ -3024,14 +3024,14 @@ static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid_t ino)
 		switch (i) {
 		case 0: /* direct node */
 		case 1:
-			fsck_failed_reconnect_file_dnode(sbi, nid);
+			fsck_failed_reconnect_file_dnode(sbi, &node->i, nid);
 			break;
 		case 2: /* indirect node */
 		case 3:
-			fsck_failed_reconnect_file_idnode(sbi, nid);
+			fsck_failed_reconnect_file_idnode(sbi, &node->i, nid);
 			break;
 		case 4: /* double indirect node */
-			fsck_failed_reconnect_file_didnode(sbi, nid);
+			fsck_failed_reconnect_file_didnode(sbi, &node->i, nid);
 			break;
 		}
 	}
-- 
2.42.0.609.gbb76f46606-goog

