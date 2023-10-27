Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D208D7D9D62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346188AbjJ0Ptq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346174AbjJ0Pto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:49:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F99CE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:49:39 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc2f17ab26so1041425ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698421779; x=1699026579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTGZ3m1qe87c+NuEwbcQd6GcZq/RTlx8NPY386XZ8A4=;
        b=i4xLrZVVZtOJFcD8m06YQWcTY5+aLIxQvjsrQApqEr5Lrji5c0tic5egNl10g+9PK4
         nKbsUELnSFbIOeb/xURs8ZozeIIM9+ZKrD65A03NsiTKDPSxDOZBo/VQfzdwWBZGXF5A
         Q1znqinCaCaZcwXxzq4N36wcYJU5Qca8BBDpfyvTlu2qRNvG0OF7U+XrJL0k7fugUiIC
         4iUDJLhetqOatQk4Bg0X0xWmxUj2pQSI8VrkXi2pVf6EncXCVf3Th8Uut+Wa9pDGF08L
         3yM4klzgiW/kfYicD5kNpt6ND/0mMGWyn+04ttokaNIQbZnY3lLi8AbTWfzHmqakfb4f
         0L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421779; x=1699026579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTGZ3m1qe87c+NuEwbcQd6GcZq/RTlx8NPY386XZ8A4=;
        b=EX5JVNKJMsFslKw0mStaIbENzPNVR39qEBzr8AKS4dvysmLFATnrHCe7SsP4JsH0wq
         I9uuNjR3zQSNcKOGlur4Wrh3m0FCp6SaW2Wv5mj84aOGxl/HuQ50KZ324F9cd1/IlSRM
         VShwtW1/2SGa+tbMXZteCrgGAsUzjyhbJSMs+IRb1d+BxqEFsqVsHheBzPNo71pkSum8
         Dydh8q6ddKBnZarHf9n7np6W/flgi0eWOD6XeMoloaAuGlJHKy1IqmTZI80aovvXR0gP
         pLwuwyI5mB6XJ79T5Gx6tMGPB+Pd95Fq57j39mEe38aTWbVzAzhAEd8YIu+Z01xgl9vk
         EmTw==
X-Gm-Message-State: AOJu0YzVBig2/iCoBK+54KBJaOaVPLixIvNx12Xg83Uf45IvASP8hX0D
        1f6DsnviigJN8MJ7ylJs2f+qoP1BVQg=
X-Google-Smtp-Source: AGHT+IEi2mKIu8CCQHQRZ4LhWQcFaEGyhRuU7oh3I4TTx3LqUhmfNK9pivak29Z0ZfsUW2WYTdREXA==
X-Received: by 2002:a17:902:f990:b0:1cc:1ee2:d41d with SMTP id ky16-20020a170902f99000b001cc1ee2d41dmr2091834plb.39.1698421778702;
        Fri, 27 Oct 2023 08:49:38 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:d9fe:c408:7e52:ad85])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001ca4c20003dsm1761412plb.69.2023.10.27.08.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:49:38 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: do not put CP_UMOUNT_FLAG for roll forward recovery
Date:   Fri, 27 Oct 2023 08:49:35 -0700
Message-ID: <20231027154935.1384979-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
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

If we write CP_UMOUNT_FLAG in fsck, f2fs will not do foll forward recovery
even though it has to do.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c       | 3 ++-
 fsck/mount.c      | 5 ++++-
 include/f2fs_fs.h | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index f1a55db..126458c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2526,7 +2526,8 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	unsigned long long cp_blk_no;
-	u32 flags = c.alloc_failed ? CP_FSCK_FLAG: CP_UMOUNT_FLAG;
+	u32 flags = c.alloc_failed ? CP_FSCK_FLAG :
+			(c.roll_forward ? 0 : CP_UMOUNT_FLAG);
 	block_t orphan_blks = 0;
 	block_t cp_blocks;
 	u32 i;
diff --git a/fsck/mount.c b/fsck/mount.c
index 3b02d73..805671c 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -3218,7 +3218,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	block_t orphan_blks = 0;
 	unsigned long long cp_blk_no;
-	u32 flags = CP_UMOUNT_FLAG;
+	u32 flags = c.roll_forward ? 0 : CP_UMOUNT_FLAG;
 	int i, ret;
 	uint32_t crc = 0;
 
@@ -3837,6 +3837,9 @@ static int record_fsync_data(struct f2fs_sb_info *sbi)
 	if (ret)
 		goto out;
 
+	if (c.func == FSCK && inode_list.next != &inode_list)
+		c.roll_forward = 1;
+
 	ret = late_build_segment_manager(sbi);
 	if (ret < 0) {
 		ERR_MSG("late_build_segment_manager failed\n");
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index abd5abf..faa5d6b 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1513,6 +1513,7 @@ struct f2fs_configuration {
 	unsigned int feature;			/* defined features */
 	unsigned int quota_bits;	/* quota bits */
 	time_t fixed_time;
+	int roll_forward;
 
 	/* mkfs parameters */
 	int fake_seed;
-- 
2.42.0.820.g83a721a137-goog

