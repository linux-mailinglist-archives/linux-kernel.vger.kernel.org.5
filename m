Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CE67FE061
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjK2Tkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjK2Tke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:40:34 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4FDD5E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:40:41 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cf856663a4so1263915ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701286840; x=1701891640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IbN/CBdY8HaO8oEbKkB4VSrcYoZEzNbVhbQ6CTvXobk=;
        b=nZl0VJPSEFdJXhrmInZ84JCCwH6XlC8eJe3UH+YuXtg/KW41Ld5zwMcpi5Kl1WMJPb
         CbFX5iSXIxKzs0ydQzfeF3d+HBTfSjlAgqVwIXdIWMySmXJGUZ7uIe9THLwZfPhsJPBa
         pQQijgauPrfkwlcP9tR2Af7Jk6kFFBq69pm0c/AT5nWV1uIByRnduIP1gG5qLSp25Vvb
         5SYlZWxWIVHapzbaKK0wEJwpuyfoNMMpMK0zfObOlBHTScIEdLOiS89Wa5/XlPaqDut/
         rDKWisRydxesxCKYJU8BO2A/h9OvPfBggLq55oKFQh/jXfmoLvIrWNuvzNlzKU2Bkldd
         7Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701286840; x=1701891640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbN/CBdY8HaO8oEbKkB4VSrcYoZEzNbVhbQ6CTvXobk=;
        b=GF84ENd9zHDp1v9+ErsmyoDgxq9t3ucIcTdvlvsCbjiBAx+M21enAe20+nVgKzyF1x
         ok0xNloaqB4T8BM6HgPPaYeCqzULbQTXQpiGoYe+aD3vfYgz579kuMVk9io3+HYalkCu
         V5Q2H8tJ6q5bj69DlvjgdWx+ca612p1Hk5TsGx96VCZCRUAZEBf/PIkF1tH8T4h9S1XG
         VNtjFcTGfjhAvMCVKMV4v1WAz7AxOh3n69fhsUs/GaNWySPwIDbL6cmOGl/+fFxKg2bp
         Ub5gg6Tb0drH2D+oKzJUrBat/Ju20gf985+4Kxvmox82YKlx/VMqRGqF5asm2o4Ts6QU
         oYbQ==
X-Gm-Message-State: AOJu0YzDhhQH+UG5YnyugCYLRwqFcaFTQ7xpmMXmMFDSUzCxVmKckn2M
        1TDFpYGhsQmdixxYw27aaqUluZXATiqTBw==
X-Google-Smtp-Source: AGHT+IGdZFEyfJpctUU4fXRWtzNMxJlMGwLs6LcaKQ3Eyh1t6Rcslzbpzy0kGZFLVkD8gYn5WOHfqQ==
X-Received: by 2002:a17:902:bd46:b0:1cf:896f:d6c5 with SMTP id b6-20020a170902bd4600b001cf896fd6c5mr18940725plx.41.1701286839814;
        Wed, 29 Nov 2023 11:40:39 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:7782:28f:d123:243d])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902748c00b001c9d011581dsm12640601pll.164.2023.11.29.11.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:40:39 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: convert lost+found dir to regular dentry before adding nodes
Date:   Wed, 29 Nov 2023 11:40:33 -0800
Message-ID: <20231129194033.999207-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

fsck doesn't support adding inodes to inline dentries. So, need to
convert inline lost+found dentry before adding missing inodes.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c | 8 ++++++++
 fsck/fsck.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 55eddca..f40b4cd 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2849,6 +2849,14 @@ static struct f2fs_node *fsck_get_lpf(struct f2fs_sb_info *sbi)
 			/* FIXME: give up? */
 			goto out;
 		}
+
+		/* Must convert inline dentry before adding inodes */
+		err = convert_inline_dentry(sbi, node, ni.blk_addr);
+		if (err) {
+			MSG(0, "Convert inline dentry for ino=%x failed.\n",
+					lpf_ino);
+			goto out;
+		}
 	} else { /* not found, create it */
 		struct dentry de;
 
diff --git a/fsck/fsck.h b/fsck/fsck.h
index f6f15e7..d6abf18 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -330,4 +330,8 @@ void *read_all_xattrs(struct f2fs_sb_info *, struct f2fs_node *, bool);
 void write_all_xattrs(struct f2fs_sb_info *sbi,
 		struct f2fs_node *inode, __u32 hsize, void *txattr_addr);
 
+/* dir.c */
+int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
+		block_t p_blkaddr);
+
 #endif /* _FSCK_H_ */
-- 
2.43.0.rc2.451.g8631bc7472-goog

