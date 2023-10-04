Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A847B78E3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbjJDHk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjJDHkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:40:55 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076FCA7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:40:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-27758c8f579so1211922a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696405252; x=1697010052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fUH5S4uz1EWWFstq5oEXMZSXkqH1sqcQ+Nf7tmZbwI=;
        b=lAsRhhXPnuCUvf+HYC2VvZYoaUGmP4X8KP1K3rZef7tfG0FQuAP896a+wpLLarZXLa
         v09Y9wPdj/Ap8I53bfoiPg1jzRv6m+zm6Y94SB3mVi1qxHi5xnz1Bv8O0pzSCvqyAyJk
         /ErdCKkp/IQlplqB8MX0dwBpVDv83imSo6cMKt8vyvR5fz8H85fcpd2ylCUmaz1JkYbD
         DARLrpqiQgvex5vPMDdWy9v6yYMUw6boBvtJvL8HLuYhSdKLtB9GJ3NXC5WMy64mJ9Os
         fpaObpXTXJ3VFLrjmR1FxdY79TZ3KqXE7CGK89Ej6xKPi1lQxqutrnVivkBVfk54+0VO
         YFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696405252; x=1697010052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fUH5S4uz1EWWFstq5oEXMZSXkqH1sqcQ+Nf7tmZbwI=;
        b=iQHgzgeejD5UTXO3n3FkL6tcdjytoF4oEpHYYZYCXTOkieseWZL9JHXcuRkcCesCUs
         EIbx7tK75agGgaDz6OStj+tyCrmNm8jM8sPmvgIpffP7bre0ANMM4+t9SLEdTBbjVm87
         uNwLRbUNsV22YD/6vnbFtc0iCTiMjqqrPPVWQiJZLPlOYk1u4cgXA+8NUGxFuYLw/HFe
         cwvP/3rmmXA3Q1Pqzae9JplgzmSGpY2tuMnB7oxEbHaed0sZPNJA6BWukwE4ztG9J2++
         DX7iWwdo2ed2BylXUmbZBpgby2cfw3MY6KdtZV8T5WW0/trAEvnLNDt0HHKKI56E57AD
         nj4w==
X-Gm-Message-State: AOJu0YzEzpuhnyGtAEfcSw8gjXsFCwAy2blb+YrsvEIqmtT1x8HJiPcq
        41Nx4WLECWT2IhVCHhtn7B4=
X-Google-Smtp-Source: AGHT+IHZ6NRVZIFRqS3Cq1TdvSNu0HELw/5i7B3boICHTTeSqupmrGFgyK8BXOHgZtJ89wiytpIPNQ==
X-Received: by 2002:a17:90a:3f16:b0:279:1367:b9a3 with SMTP id l22-20020a17090a3f1600b002791367b9a3mr1447237pjc.4.1696405252410;
        Wed, 04 Oct 2023 00:40:52 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b0026b12768e46sm894332pji.42.2023.10.04.00.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 00:40:51 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+79d792676d8ac050949f@syzkaller.appspotmail.com
Subject: [PATCH v2] jfs: fix array-index-out-of-bounds in diAlloc
Date:   Wed,  4 Oct 2023 13:10:40 +0530
Message-Id: <20231004074040.12233-1-ghandatmanas@gmail.com>
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

Currently there is not check against the agno of the iag while
allocating new inodes to avoid fragmentation problem. Added the check
which is required.

Reported-by: syzbot+79d792676d8ac050949f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=79d792676d8ac050949f
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
---
V1 -> V2 : Added check for higher bound of agno
 fs/jfs/jfs_imap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 799d3837e7c2..c0cf74e7392b 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1319,7 +1319,7 @@ diInitInode(struct inode *ip, int iagno, int ino, int extno, struct iag * iagp)
 int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 {
 	int rc, ino, iagno, addext, extno, bitno, sword;
-	int nwords, rem, i, agno;
+	int nwords, rem, i, agno, dn_numag;
 	u32 mask, inosmap, extsmap;
 	struct inode *ipimap;
 	struct metapage *mp;
@@ -1355,6 +1355,9 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
+	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
+	if (agno < 0 || agno > dn_numag)
+		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
 		/*
-- 
2.37.2

