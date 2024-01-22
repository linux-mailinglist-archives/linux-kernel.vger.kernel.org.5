Return-Path: <linux-kernel+bounces-33130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF9C836505
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E558289BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C53F8D1;
	Mon, 22 Jan 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/F34LrP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFCD3EA87;
	Mon, 22 Jan 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932159; cv=none; b=YyERmYLaXdpFnNZIfYjKFAWNWZRb2Pz3oF1nLbqCsF9f0qxEccNysuE3tZHlbhmcgThgmfLzX3W6vw6jnz7O+aTB8cPs6257AV6Bs8qnTJK1FTDHSqHNLEXpN0rrBBQ4R1A+QZuxUL2Dn5D+27gTzkn1hNpzY8LvlJRGKzLUZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932159; c=relaxed/simple;
	bh=PXIW79wR4xxUjQK7k2LVAWHAMpl6SNEqE+BBtUMs9C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UIXjX/6/9Xkmqb0/q+J+QCUqMg+gPklVJRL6Lt13zdZCboTCfJqIq4U710r4eOIhkzexziXO7LBriPxKnCoSNYvdatK37AbVdzByPSkiCuid7i6JE9EInOVtmdbZvLdaX5oEpaSE1oxUCHeOGKYj92p4tnIjucmWzrkVl/DEie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/F34LrP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6daa89a6452so1869967b3a.2;
        Mon, 22 Jan 2024 06:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932157; x=1706536957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvBkLR1lVhjBBWSewqJTTBchTYH/kw10gm2qf5zMfKM=;
        b=g/F34LrPiNceVObdYdIe1y30VZys2rMq2yjd67wS7GO0JaR4Ox8jJvXyJ0qofTV6Zh
         TKfE5xHBhNfLe4J3KT/RzN4PywdBlXqpdvwKUdGUSEZQ3cs8NtBI2a4QbCb91SUBfW3f
         SmGNbSXeE5weiu9c1vzQhOlskbmfB9LZ3X87+R90zk0ABf5ZgCVCYmltTq+L+cFBsFcO
         qIhubf8pJJvUeU0IQE6dbf5AsbJt926/GMVRF/DQiPotlpa3FVpGdH5n74RBws/ozRS/
         r8qgOBVTQgxtALyPns1Vu7X00wRubAlsJ226AkMOspq/xrZfKW/yZW5CIZWNnIAzukhT
         lQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932157; x=1706536957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvBkLR1lVhjBBWSewqJTTBchTYH/kw10gm2qf5zMfKM=;
        b=KGRNRAIoO7EQ1USkq/c7jihAsNUe0Ovypy0xMs87sVeX3ZWr8/PbxThK+LcYrcrCnf
         KvxdYj6eS8a5BUcJG90reYz47MBCwb+3rq1y5TE+QguZUlOfgGELc8X8v19BcE29IQIm
         O0qicr4HRKLXNilREOzJIupF4vPwUde1tZ0UT94KCglOr+BbZmP0Nh5AcJtfbrtaCuN9
         6DLFUNabR5aoycYswzbyNB6aYDW1tQ1jrzaCgDWpdCyfH0+Dq6ADBlv7a1GC50vGGT0F
         hksTGuKMPYMEjkg9oCvQa9XNuvB5juAccIAUy5qkYx4hC2JO7NYsoYXTBKFImm3g+1HC
         qclA==
X-Gm-Message-State: AOJu0YzGuSqZXVGr+jPIBRBabAm9jkLCfKiQDK67kG5YuylsvbdhWpB+
	vL1tnuV76/fmyq4rry/Aw5uai8qPxxg+zsS4jdAgT1TwXpN/bgeo+EW9v6W+
X-Google-Smtp-Source: AGHT+IGQIgDAe9nemcFisoGOOswk6Y8FPanqSaHoQFqf4xqHFqnKkq+SCDcjX6tDZ5TIMZpOs6mRPQ==
X-Received: by 2002:a05:6a20:9e4a:b0:19c:4b98:5e7d with SMTP id mt10-20020a056a209e4a00b0019c4b985e7dmr529625pzb.54.1705932155673;
        Mon, 22 Jan 2024 06:02:35 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:34 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] nilfs2: convert ifile to use kmap_local
Date: Mon, 22 Jan 2024 23:01:57 +0900
Message-Id: <20240122140202.6950-11-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
References: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert deprecated kmap() and kmap_atomic() to use kmap_local for the
ifile metadata file used to manage disk inodes.

In some usages, calls to kmap_local and kunmap_local are split into
different helpers, but those usages can be safely changed to local thread
kmap.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/ifile.c   | 4 ++--
 fs/nilfs2/ifile.h   | 7 +++----
 fs/nilfs2/inode.c   | 6 +++---
 fs/nilfs2/segment.c | 2 +-
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index a8a4bc8490b4..e9538fa46ff2 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -115,11 +115,11 @@ int nilfs_ifile_delete_inode(struct inode *ifile, ino_t ino)
 		return ret;
 	}
 
-	kaddr = kmap_atomic(req.pr_entry_bh->b_page);
+	kaddr = kmap_local_page(req.pr_entry_bh->b_page);
 	raw_inode = nilfs_palloc_block_get_entry(ifile, req.pr_entry_nr,
 						 req.pr_entry_bh, kaddr);
 	raw_inode->i_flags = 0;
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	mark_buffer_dirty(req.pr_entry_bh);
 	brelse(req.pr_entry_bh);
diff --git a/fs/nilfs2/ifile.h b/fs/nilfs2/ifile.h
index 35c5273f4821..b71ab0a81dc4 100644
--- a/fs/nilfs2/ifile.h
+++ b/fs/nilfs2/ifile.h
@@ -21,15 +21,14 @@
 static inline struct nilfs_inode *
 nilfs_ifile_map_inode(struct inode *ifile, ino_t ino, struct buffer_head *ibh)
 {
-	void *kaddr = kmap(ibh->b_page);
+	void *kaddr = kmap_local_page(ibh->b_page);
 
 	return nilfs_palloc_block_get_entry(ifile, ino, ibh, kaddr);
 }
 
-static inline void nilfs_ifile_unmap_inode(struct inode *ifile, ino_t ino,
-					   struct buffer_head *ibh)
+static inline void nilfs_ifile_unmap_inode(struct nilfs_inode *raw_inode)
 {
-	kunmap(ibh->b_page);
+	kunmap_local(raw_inode);
 }
 
 int nilfs_ifile_create_inode(struct inode *, ino_t *, struct buffer_head **);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index b9d40f5e94d3..a475095a5e80 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -520,7 +520,7 @@ static int __nilfs_read_inode(struct super_block *sb,
 			inode, inode->i_mode,
 			huge_decode_dev(le64_to_cpu(raw_inode->i_device_code)));
 	}
-	nilfs_ifile_unmap_inode(root->ifile, ino, bh);
+	nilfs_ifile_unmap_inode(raw_inode);
 	brelse(bh);
 	up_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
 	nilfs_set_inode_flags(inode);
@@ -529,7 +529,7 @@ static int __nilfs_read_inode(struct super_block *sb,
 	return 0;
 
  failed_unmap:
-	nilfs_ifile_unmap_inode(root->ifile, ino, bh);
+	nilfs_ifile_unmap_inode(raw_inode);
 	brelse(bh);
 
  bad_inode:
@@ -814,7 +814,7 @@ void nilfs_update_inode(struct inode *inode, struct buffer_head *ibh, int flags)
 		raw_inode->i_device_code =
 			cpu_to_le64(huge_encode_dev(inode->i_rdev));
 
-	nilfs_ifile_unmap_inode(ifile, ino, ibh);
+	nilfs_ifile_unmap_inode(raw_inode);
 }
 
 #define NILFS_MAX_TRUNCATE_BLOCKS	16384  /* 64MB for 4KB block */
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index b512e7728465..3657918328ea 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -966,7 +966,7 @@ static void nilfs_fill_in_file_bmap(struct inode *ifile,
 		raw_inode = nilfs_ifile_map_inode(ifile, ii->vfs_inode.i_ino,
 						  ibh);
 		nilfs_bmap_write(ii->i_bmap, raw_inode);
-		nilfs_ifile_unmap_inode(ifile, ii->vfs_inode.i_ino, ibh);
+		nilfs_ifile_unmap_inode(raw_inode);
 	}
 }
 
-- 
2.34.1


