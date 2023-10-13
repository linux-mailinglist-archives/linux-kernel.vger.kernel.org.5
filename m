Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C682B7C903B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjJMWY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMWY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:24:58 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518C0AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 15:24:57 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578d0dcd4e1so1829134a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697235896; x=1697840696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/GfpOs8gW0KsSJr+yd9IproIUP4Gx7slhdnmYQ1Acqs=;
        b=Bc5MmJmnYLc627njKuiKczMtzeZHGcFKdYUJHDXA8sv359OMs1afLd63EMM9OmYvlZ
         0gWnqu95osUN+Wkph1hOLVHJ/F7XWDX3N2/KWdlL/+VYA4NP3gapOQtg1TjrKKZr8Jl/
         xK9+vUnXS0JDZ5rkl629EPpiaQ/m3tBmjaQ4ssvKhJdhYkWGfLx4A+GiZl4VpYKUT4Qz
         mgQMhG8/rsL2Cy0/5OIFn4CpDvFP2KIKb6Vs3NChNZefWRaoz4cBIl742EXFLzlrq0g8
         F5b5bUa2zOJyPjoHEEbAKpgnsL4N660TzU97R8heii4VY/dsb8UwfTo6KI49i45EMenI
         uMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697235896; x=1697840696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GfpOs8gW0KsSJr+yd9IproIUP4Gx7slhdnmYQ1Acqs=;
        b=XOiD32sCZ0/9SREnvYB1Yvm4JgGI3sUOpiMtbZbTsfVWkyjq8O2ZkhI91G8nRIp40y
         Ryd/Hv/OACqcO2uGfHQNjPocrOSa959FwG4jc4qsdgIVxkGmN3kjkYkTsvQXW38S+aFo
         K4ksX3TVojZcgl1JaZX2uykBk3SE2V97OLKHeC5Z9oNerDz9AkUHGgsNsd6Qt8jw9hjV
         +PsPFWqgXHoehAlxizZQDyGQ+GYqnYumbsnABSpZOZH4zkCtWMxqsSj/SaRII5tfCRd7
         7TtzzwJhXdmC0U/kw1g+zNWSaWpR0K02ezY9t8D9pmmakIrPyJWoJ2Pi7dx5UObHKb74
         PwxQ==
X-Gm-Message-State: AOJu0Yx/PInWQ/pOXKjWLA1zZv2QuPpPdBiucQYK0tMLBkX8j7e+643l
        1xwPQIAaHBLPFpe+Zh3zvVALkuZmNRA=
X-Google-Smtp-Source: AGHT+IEKA51Ytc7B2fQRyrDt9VVbdMSfwkcL73/KPExzkdZ3lelRQN0gOds3ufJ/JwBLvjne7Fgbqw==
X-Received: by 2002:a05:6a20:6a11:b0:15a:1817:c493 with SMTP id p17-20020a056a206a1100b0015a1817c493mr28467802pzk.39.1697235896437;
        Fri, 13 Oct 2023 15:24:56 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:86c0:c2f7:f3ba:33e1])
        by smtp.gmail.com with ESMTPSA id je6-20020a170903264600b001bbb8d5166bsm4366891plb.123.2023.10.13.15.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:24:56 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: initialize allocated node area
Date:   Fri, 13 Oct 2023 15:24:52 -0700
Message-ID: <20231013222453.240961-1-daeho43@gmail.com>
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

Need to initialize allocated node areas after memory allocation.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/node.c       | 1 +
 include/f2fs_fs.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fsck/node.c b/fsck/node.c
index 3761470..6508340 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -127,6 +127,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
 
 	node_blk = calloc(BLOCK_SZ, 1);
 	ASSERT(node_blk);
+	memset(node_blk, 0, BLOCK_SZ);
 
 	F2FS_NODE_FOOTER(node_blk)->nid = cpu_to_le32(dn->nid);
 	F2FS_NODE_FOOTER(node_blk)->ino = F2FS_NODE_FOOTER(f2fs_inode)->ino;
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 3c7451c..7e22278 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1826,6 +1826,8 @@ static inline void show_version(const char *prog)
 static inline void f2fs_init_inode(struct f2fs_super_block *sb,
 		struct f2fs_node *raw_node, nid_t ino, time_t mtime, mode_t mode)
 {
+	memset(raw_node, 0, F2FS_BLKSIZE);
+
 	F2FS_NODE_FOOTER(raw_node)->nid = cpu_to_le32(ino);
 	F2FS_NODE_FOOTER(raw_node)->ino = cpu_to_le32(ino);
 	F2FS_NODE_FOOTER(raw_node)->cp_ver = cpu_to_le64(1);
-- 
2.42.0.655.g421f12c284-goog

