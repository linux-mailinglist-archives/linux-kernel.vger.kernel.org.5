Return-Path: <linux-kernel+bounces-126785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50880893CAF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CF3B21AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C94597F;
	Mon,  1 Apr 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE6V+pEh"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0028684
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984437; cv=none; b=uAMOqSqE5uS6nEy0pOcUYqe1IuYHTYkRN3jbJYP5zInCorWSm/0ww77YZM5sUicG6/Mh4qrVSbUuq5DecWc1f8Gvasj0BWi7H0M7XTSnIQhTodC+dvlXCPRyOVI4nHPtxMVvrHclsboQDGJZMlEZvVdC9GHI3+TTR4eEs2z80Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984437; c=relaxed/simple;
	bh=VwpFas1rjtC+4jOO8tGMZ5eidoZPSC8MzruAGcQAUF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4hQRiT75QuQqHDU9+d+ZjUBHEfGEizkWLNpN+0BkslNtMcBnAkjgkzsY+I/97iXfsUidquFkR+P81v42iG/9f4fC1XHI7EuBC5YF/i/h4okaqE5MvwN7pAeqnU/Zd/YBv++iXYAfUOUlX9bt7r4iYMpawP3qUq8bO545ujmMPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lE6V+pEh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e25de8ac5fso2913005ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711984435; x=1712589235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6eV7DdHQLbErWcw4Py5Jo8KIrVYa9EKXORI7ogMXuc=;
        b=lE6V+pEhfuhRMAmKls/K367criORRGPo/45u90Uz9xfnI9ya3UTZ6TdGBBukp0sQ77
         BZNn/2CH7G4ogUBbQGW7KNJF+zq2Xy/nPMGpPcQC9D5fql+4S6FRpGfCjjUhz7aCwzS/
         9iImOpeii6Yx8ej3PIPZpOtOvYgwr5BZbLs78/HgEq2WwSUz59xAfvzB8wxuqywkMkNT
         IZ6ioAtgaul54EPsig9WALDp0Sx7/nrIqawdpSWm82YPADiuC+C1s3p21s/q9SencSID
         TOmkdf7FZGFLWkz14JA3py8W+5pNbMBHa98v9X25RjrZLT18kbsASc2q1VbnZwKA4lvP
         sjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711984435; x=1712589235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6eV7DdHQLbErWcw4Py5Jo8KIrVYa9EKXORI7ogMXuc=;
        b=N4IhSnw9ObdWwHWqfY200icsHiZa9NHw3ENRH216u7odPhWJvQIMdImTSakxG2nJdj
         WqhcoQRYFeMSA4pQD0OJk9DwDWvQ9HQE9ZTivPAyN/j0CptdqsxkLvEJXr6xP+6m84UY
         /1EAK3FQQHVOpCPI7xB6Nkpux2nAPqwkGWSidj7Amuc2nnnTTc6toOQyVmNNUh5K0Zjs
         3M+YhYxcXm3hfmnG5ySTvUABA+ewDwqlEgn573ivbnSp3FC/2vR4dbQOqrs7K400F/ES
         ZfCUv2M30CUZewcizQNLx3FMNv+2PfmBrjASQhi05PRx0p1aY9hVU2++Hzge7FRsUnoi
         f2zQ==
X-Gm-Message-State: AOJu0YwjUPSm36hGaEQFPECemh/qThiFLsxkut786FRMOTorAAtaH22D
	V27B001vI8X61Ta1GwJvEAGremALv1T4hDF80F2CovNUYkgSEMBv4kdTwgol
X-Google-Smtp-Source: AGHT+IEmFlhC9NyJVJJdqzncVigkcluv7g4mNSd+CY/mMhdMt51vTTo0EhfSAdIHc3/STEjaN5qzjQ==
X-Received: by 2002:a17:902:da8c:b0:1e0:d09d:ea59 with SMTP id j12-20020a170902da8c00b001e0d09dea59mr14532352plx.31.1711984435240;
        Mon, 01 Apr 2024 08:13:55 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:b52c:9d5b:e7ea:d1ca])
        by smtp.gmail.com with ESMTPSA id z6-20020a170902708600b001e26191b9c2sm144738plk.67.2024.04.01.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 08:13:54 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v7] f2fs: prevent writing without fallocate() for pinned files
Date: Mon,  1 Apr 2024 08:13:51 -0700
Message-ID: <20240401151351.248913-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

In a case writing without fallocate(), we can't guarantee it's allocated
in the conventional area for zoned stroage. To make it consistent across
storage devices, we disallow it regardless of storage device types.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: covered the direct io case
v3: covered the mkwrite case
v4: moved pin file check position in prepare_write_begin()
v5: removed unnecessary condition in f2fs_map_blocks() and disallowed
    pre-written inodes for file pinning
v6: check a hole for pinned files in mkwrite()
v7: changed data_blkaddr check condition in mkwrite()
---
 fs/f2fs/data.c | 20 ++++++++++++++++----
 fs/f2fs/file.c | 21 ++++++++++++---------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c21b92f18463..1b02a9291176 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1584,8 +1584,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 	/* use out-place-update for direct IO under LFS mode */
 	if (map->m_may_create &&
-	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO))) {
-		if (unlikely(f2fs_cp_error(sbi))) {
+	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
+			 !f2fs_is_pinned_file(inode)))) {
+		if (unlikely(f2fs_cp_error(sbi)) ||
+		    (f2fs_is_pinned_file(inode) &&
+		     flag != F2FS_GET_BLOCK_PRE_DIO)) {
 			err = -EIO;
 			goto sync_out;
 		}
@@ -3378,6 +3381,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 		f2fs_map_lock(sbi, flag);
 		locked = true;
 	} else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
+		if (f2fs_is_pinned_file(inode))
+			return -EIO;
 		f2fs_map_lock(sbi, flag);
 		locked = true;
 	}
@@ -3414,8 +3419,15 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 		/* hole case */
 		err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
-		if (!err && dn.data_blkaddr != NULL_ADDR)
-			goto out;
+		if (!err) {
+			if (dn.data_blkaddr != NULL_ADDR) {
+				goto out;
+			} else if (f2fs_is_pinned_file(inode)) {
+				err = -EIO;
+				goto out;
+			}
+		}
+
 		f2fs_put_dnode(&dn);
 		f2fs_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO);
 		WARN_ON(flag != F2FS_GET_BLOCK_PRE_AIO);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 82277e95c88f..a8ac546b9abc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -57,7 +57,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
-	bool need_alloc = true;
+	bool need_alloc = !f2fs_is_pinned_file(inode);
 	int err = 0;
 	vm_fault_t ret;
 
@@ -114,19 +114,18 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out_sem;
 	}
 
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	if (need_alloc) {
 		/* block allocation */
-		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = f2fs_get_block_locked(&dn, page->index);
-	}
-
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (!need_alloc) {
-		set_new_dnode(&dn, inode, NULL, NULL, 0);
+	} else {
 		err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
 		f2fs_put_dnode(&dn);
+		if (f2fs_is_pinned_file(inode) &&
+		    !__is_valid_data_blkaddr(dn.data_blkaddr))
+			err = -EIO;
 	}
-#endif
+
 	if (err) {
 		unlock_page(page);
 		goto out_sem;
@@ -3235,7 +3234,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 		goto done;
 	}
 
-	if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
+	if (F2FS_HAS_BLOCKS(inode)) {
 		ret = -EFBIG;
 		goto out;
 	}
@@ -4611,6 +4610,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 			return ret;
 	}
 
+	/* For pinned files, it should be fallocate()-ed in advance. */
+	if (f2fs_is_pinned_file(inode))
+		return 0;
+
 	/* Do not preallocate blocks that will be written partially in 4KB. */
 	map.m_lblk = F2FS_BLK_ALIGN(pos);
 	map.m_len = F2FS_BYTES_TO_BLK(pos + count);
-- 
2.44.0.478.gd926399ef9-goog


