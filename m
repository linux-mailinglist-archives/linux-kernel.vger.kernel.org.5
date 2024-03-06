Return-Path: <linux-kernel+bounces-94043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE118738F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA381F25826
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C1E132C1F;
	Wed,  6 Mar 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P74mGS1s"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1460895;
	Wed,  6 Mar 2024 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735154; cv=none; b=E8o22rEm2aDYgt+Am4kaaBSYMYVilDQSw3Km6NRcf8DI1jf0YzmZKUhtqzIFSCc1n4NrGEjzAF2cOG0MYRzcXAKx2rY6hKiqcOHKx5zpWD7ZHhumvVMhqi2yll9KO1SxE+zFWCjlm1jwxkVNFF1ox6w8z3yAV04muBydg/870is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735154; c=relaxed/simple;
	bh=sCb5JbyJ/gY7JIM826empmjtqduKbdWZ8F83jb93tPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/uOSizfUccWr7XyL9D3GFkBEfSAJU/S7/myQbu7sri+STPkTzKVYdlR0i1albxZNx45EX6+btWiRM+wqGci0sPly7LaAMsBKXdnqogbft0DGqarv1oUfyM3SdJpUH3xw1UZTwBB/GQ+p3giYXpsOaZtH2LlhFQR7HPrscJksms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P74mGS1s; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e655a12c81so26503b3a.1;
        Wed, 06 Mar 2024 06:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709735152; x=1710339952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=divIJxXpF6Kid14aoXB1EYkP0PShY5l++WV1hOmnXrQ=;
        b=P74mGS1sG/NZGNOX0Gfpj2e+sYTeAWKPjYt672U8kIz2cJ7w5iFwrznUBKHUZYbxkw
         1k8VwZVDK/yo7JdqtjIqdWEBJnlMFLgZbw09HqrfQXP+dM7Xk+B02nkRV9JNBHxAG7vL
         IfKGW1C/d7t0QNatHzkvSb+c6x2zaMRvWqBla6Xcjpx1AqHPwkHSmOs3pCrIixt74i/m
         bvpbzdqAs3qgP0IT8BeRzmYN8MGb9rTLyiTA9a3UNe26k0ddgtxnF+AcpUi2dSC7DBKY
         TafPYsYu8Ml9kaLczlQHr6OHeI56eMUFse5uBFRsTkSyJ+ihYFiZyR0yv63j+lLA0mgq
         C/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735152; x=1710339952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=divIJxXpF6Kid14aoXB1EYkP0PShY5l++WV1hOmnXrQ=;
        b=DgczGAb85iX3M1849e0SuSg0XIMDPs1KaGKkKAPtq0FpfbJA5XKhlxvv7esa1yPbGP
         +0esOmMyXSu3xamvEbRnVbmeUzJeXFX72+76im/R+nCiXCjwzw/WHSxbwIUv6yuIPCiU
         tA1Bo/Jvl+nBQavp3izj8Ag4gI+4OARkw0KdzF5OsGmVtyqvjj6oxBpvcA3aPq9gquJx
         DWaneSKS3sGmIblxi+RBlVz5nKZ97PO0AMLyNp+TzMTIFNla5bvbJRWF9MsXi05hXEjH
         KpxmrKq2asdzk5162QTvstywUkcXpuXiUGI47ytCt9aYgKUL2wwK8PZwdcyoZCXGGtMk
         +ZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNyTEmNBE3zoV4silMMib8o3pK7l3tCq5em8ODXjehiMz53GKNk+UJi9Ex9lp7xI4ir87ag6J2awuB4kvgG2mnTm8R7/bO9oO4QW9+
X-Gm-Message-State: AOJu0Yw+EW+Xj3dDcwVrLoavC3oVDBKfB/E6zc1jJFoWnNQF6cLQ2UQb
	4MWmaIuAu3UU5jK0NRvtEbS+FhVC47VVoip1Zi2w7AGFr/boq92mPOya+8Sj
X-Google-Smtp-Source: AGHT+IFfDqY0nX6iJgir7qlBpUMzd5vDoMJX2JA3WL0pRGQ8CY4i5as8kXqceJlanehnTl9GwkgQlA==
X-Received: by 2002:a05:6a20:3954:b0:1a1:4aea:c665 with SMTP id r20-20020a056a20395400b001a14aeac665mr313660pzg.19.1709735152309;
        Wed, 06 Mar 2024 06:25:52 -0800 (PST)
Received: from carrot.. (i60-34-119-103.s42.a014.ap.plala.or.jp. [60.34.119.103])
        by smtp.gmail.com with ESMTPSA id b4-20020aa78704000000b006e5969aa281sm10751433pfo.169.2024.03.06.06.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:25:51 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: Use div64_ul() instead of do_div()
Date: Wed,  6 Mar 2024 23:25:47 +0900
Message-Id: <20240306142547.4612-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@toblux.com>

Fixes Coccinelle/coccicheck warnings reported by do_div.cocci.

Compared to do_div(), div64_ul() does not implicitly cast the divisor and
does not unnecessarily calculate the remainder.

Link: https://lkml.kernel.org/r/20240229210456.63234-2-thorsten.blum@toblux.com
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Hi Andrew,

Could you please add this to the queue for the merge window?
It's a little late addition, so if this doesn't make it to the
upcoming merge window, please queue it for the next one.

Thanks,
Ryusuke Konishi

 fs/nilfs2/cpfile.c    | 2 +-
 fs/nilfs2/dat.c       | 2 +-
 fs/nilfs2/ioctl.c     | 4 ++--
 fs/nilfs2/sufile.c    | 2 +-
 fs/nilfs2/super.c     | 2 +-
 fs/nilfs2/the_nilfs.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 2c57132584de..69a5cced1e84 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -28,7 +28,7 @@ nilfs_cpfile_get_blkoff(const struct inode *cpfile, __u64 cno)
 {
 	__u64 tcno = cno + NILFS_MDT(cpfile)->mi_first_entry_offset - 1;
 
-	do_div(tcno, nilfs_cpfile_checkpoints_per_block(cpfile));
+	tcno = div64_ul(tcno, nilfs_cpfile_checkpoints_per_block(cpfile));
 	return (unsigned long)tcno;
 }
 
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 8f71f8b0e218..180fc8d36213 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -460,7 +460,7 @@ ssize_t nilfs_dat_get_vinfo(struct inode *dat, void *buf, unsigned int visz,
 		kaddr = kmap_local_page(entry_bh->b_page);
 		/* last virtual block number in this block */
 		first = vinfo->vi_vblocknr;
-		do_div(first, entries_per_block);
+		first = div64_ul(first, entries_per_block);
 		first *= entries_per_block;
 		last = first + entries_per_block - 1;
 		for (j = i, n = 0;
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index cfb6aca5ec38..f1a01c191cf5 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -1111,7 +1111,7 @@ static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
 	segbytes = nilfs->ns_blocks_per_segment * nilfs->ns_blocksize;
 
 	minseg = range[0] + segbytes - 1;
-	do_div(minseg, segbytes);
+	minseg = div64_ul(minseg, segbytes);
 
 	if (range[1] < 4096)
 		goto out;
@@ -1120,7 +1120,7 @@ static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
 	if (maxseg < segbytes)
 		goto out;
 
-	do_div(maxseg, segbytes);
+	maxseg = div64_ul(maxseg, segbytes);
 	maxseg--;
 
 	ret = nilfs_sufile_set_alloc_range(nilfs->ns_sufile, minseg, maxseg);
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index abf05dc5750c..6748218be7c5 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -48,7 +48,7 @@ nilfs_sufile_get_blkoff(const struct inode *sufile, __u64 segnum)
 {
 	__u64 t = segnum + NILFS_MDT(sufile)->mi_first_entry_offset;
 
-	do_div(t, nilfs_sufile_segment_usages_per_block(sufile));
+	t = div64_ul(t, nilfs_sufile_segment_usages_per_block(sufile));
 	return (unsigned long)t;
 }
 
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 5e630c179a1e..ac24ed109ce9 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -448,7 +448,7 @@ int nilfs_resize_fs(struct super_block *sb, __u64 newsize)
 
 	sb2off = NILFS_SB2_OFFSET_BYTES(newsize);
 	newnsegs = sb2off >> nilfs->ns_blocksize_bits;
-	do_div(newnsegs, nilfs->ns_blocks_per_segment);
+	newnsegs = div64_ul(newnsegs, nilfs->ns_blocks_per_segment);
 
 	ret = nilfs_sufile_resize(nilfs->ns_sufile, newnsegs);
 	up_write(&nilfs->ns_segctor_sem);
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 71400496ed36..2ae2c1bbf6d1 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -413,7 +413,7 @@ static u64 nilfs_max_segment_count(struct the_nilfs *nilfs)
 {
 	u64 max_count = U64_MAX;
 
-	do_div(max_count, nilfs->ns_blocks_per_segment);
+	max_count = div64_ul(max_count, nilfs->ns_blocks_per_segment);
 	return min_t(u64, max_count, ULONG_MAX);
 }
 
-- 
2.34.1


