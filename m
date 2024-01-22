Return-Path: <linux-kernel+bounces-33134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5759083650C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5D11F26A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887423FE20;
	Mon, 22 Jan 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaeiRGNl"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A93D554;
	Mon, 22 Jan 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932168; cv=none; b=cVKO/wyrSn+dyxZWDipzlpPViKp/cq+0KCkfzxq2TyH7/cgqkojP5j3+3rUd7/Y0064ffzK3bHIhl/ePQ8NFzkv1B9njVWvMdm2MLrgxO4kjb70dHyZwfmR6A34M3s8CxlmsQf74VSr5eL9dYGJl+DbM1UFPAB786Q5IkflDvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932168; c=relaxed/simple;
	bh=jaYmqoq66caysu4SfR8va6WDVPxCLAXCEaDObkNOASo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2PsCSzsTPE1JuPUqTiWa3kOCmo6OpF41LVwvwP3CNGVcX21lC5W5ME3VWvhwHHZZQzWLqseJ+DK8MwpvfbV1hwigfTEXEKWoVk4kQO7XSjHKsRGq4fO23oDvadnQP7q8plsfqNC79TApWNmWqD6C6zlk3C8wZNIp6QdH4eSoK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaeiRGNl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dbc9dab55dso1751199b3a.0;
        Mon, 22 Jan 2024 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932167; x=1706536967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNNrnAa4IIXxXXOYnbFPbhlz1T+5lQN7PRlkG9jiVX0=;
        b=CaeiRGNl/ujYZuhIEsndpsNoa4ruhMksbKoH6ju7nHFmhXkW09XGcaHROBTBMvQO7l
         KwOLeKFZt55zZLvAIcNxEF6lOvC6aZnINBMO7IUJiQcaNyzjktmHT3GMXoQ5w38BsVJT
         sq7l+6IVoZ9IDpKYm8/jDUYYSFyRnbceG3HDm+pKML+u5GdYeOGRyYazogycUsEgBMun
         kXxTRJdf6+jk3X6ISiA/wSAHSB3osGXcGT/ufChhtjPD4kCbWQ1PwyH+Vbk+vLpNfGTc
         NWF1AQUx0Hnt9pv96ut5+MPo78FVplDN2MsLekYpZKeG+SUBfx+HTQRh4K9kvll+gOdT
         jNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932167; x=1706536967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNNrnAa4IIXxXXOYnbFPbhlz1T+5lQN7PRlkG9jiVX0=;
        b=BmLTM6lUGOYpjkhd4/jWmGOc/1yw490ftCIhpYAWv1DGBo3BJqgyZHsDZHhaCEmK9u
         CUXrVvTltB72rKdg17eDYCfPtxBkgwNn1/YMYbzpS+lXv1qBQrdWTZ3Wi6yn7O7pRp7Z
         7bbFkccToWBJDWxUEoLushBtrLWojLfrQC7P5lqHWrvsbQOM2jxjauoxC3oro106keDd
         3DCLas42+mjdk3nSIyxfhvPFOoPNuhv/yRbMQf4ZLgRylmXRsTsXaVTWZu2AG+dr8oTs
         ON10T9Eyoc3UrIHC02zfV8Mj9IL9+8kjo8k2UZWmD8/l3QNGT+JKuNZDe7DrDLu65Gl0
         AytA==
X-Gm-Message-State: AOJu0YyFoW5IkOsOC0dWR5CpJi5OVa99Haa+id+l+6+7fscPHXEDIJaX
	qV1Ktk+P7vO0NtS+gvF0gUUpWMwlu9fyiuzIPcu2bFlpWC3gkXF2
X-Google-Smtp-Source: AGHT+IFnd6H1NuUyy3A+KCHUGVdjRTRy1tuc0YqLFu5tcgQkeDt6G3zqPyxb1/qGoXQ19JFzzhi5ww==
X-Received: by 2002:a05:6a00:98e:b0:6db:f87:2237 with SMTP id u14-20020a056a00098e00b006db0f872237mr6234852pfg.21.1705932166566;
        Mon, 22 Jan 2024 06:02:46 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:45 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] nilfs2: remove nilfs_cpfile_{get,put}_checkpoint()
Date: Mon, 22 Jan 2024 23:02:01 +0900
Message-Id: <20240122140202.6950-15-konishi.ryusuke@gmail.com>
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

All calls to nilfs_cpfile_get_checkpoint() and
nilfs_cpfile_put_checkpoint() that call kmap() and kunmap() separately
are now gone, so remove these methods.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/cpfile.c | 103 ---------------------------------------------
 fs/nilfs2/cpfile.h |   4 --
 2 files changed, 107 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 56e38843536b..b5bad332d630 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -254,92 +254,6 @@ int nilfs_cpfile_read_checkpoint(struct inode *cpfile, __u64 cno,
 	return ret;
 }
 
-/**
- * nilfs_cpfile_get_checkpoint - get a checkpoint
- * @cpfile: inode of checkpoint file
- * @cno: checkpoint number
- * @create: create flag
- * @cpp: pointer to a checkpoint
- * @bhp: pointer to a buffer head
- *
- * Description: nilfs_cpfile_get_checkpoint() acquires the checkpoint
- * specified by @cno. A new checkpoint will be created if @cno is the current
- * checkpoint number and @create is nonzero.
- *
- * Return Value: On success, 0 is returned, and the checkpoint and the
- * buffer head of the buffer on which the checkpoint is located are stored in
- * the place pointed by @cpp and @bhp, respectively. On error, one of the
- * following negative error codes is returned.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-ENOENT - No such checkpoint.
- *
- * %-EINVAL - invalid checkpoint.
- */
-int nilfs_cpfile_get_checkpoint(struct inode *cpfile,
-				__u64 cno,
-				int create,
-				struct nilfs_checkpoint **cpp,
-				struct buffer_head **bhp)
-{
-	struct buffer_head *header_bh, *cp_bh;
-	struct nilfs_cpfile_header *header;
-	struct nilfs_checkpoint *cp;
-	void *kaddr;
-	int ret;
-
-	if (unlikely(cno < 1 || cno > nilfs_mdt_cno(cpfile) ||
-		     (cno < nilfs_mdt_cno(cpfile) && create)))
-		return -EINVAL;
-
-	down_write(&NILFS_MDT(cpfile)->mi_sem);
-
-	ret = nilfs_cpfile_get_header_block(cpfile, &header_bh);
-	if (ret < 0)
-		goto out_sem;
-	ret = nilfs_cpfile_get_checkpoint_block(cpfile, cno, create, &cp_bh);
-	if (ret < 0)
-		goto out_header;
-	kaddr = kmap(cp_bh->b_page);
-	cp = nilfs_cpfile_block_get_checkpoint(cpfile, cno, cp_bh, kaddr);
-	if (nilfs_checkpoint_invalid(cp)) {
-		if (!create) {
-			kunmap(cp_bh->b_page);
-			brelse(cp_bh);
-			ret = -ENOENT;
-			goto out_header;
-		}
-		/* a newly-created checkpoint */
-		nilfs_checkpoint_clear_invalid(cp);
-		if (!nilfs_cpfile_is_in_first(cpfile, cno))
-			nilfs_cpfile_block_add_valid_checkpoints(cpfile, cp_bh,
-								 kaddr, 1);
-		mark_buffer_dirty(cp_bh);
-
-		kaddr = kmap_atomic(header_bh->b_page);
-		header = nilfs_cpfile_block_get_header(cpfile, header_bh,
-						       kaddr);
-		le64_add_cpu(&header->ch_ncheckpoints, 1);
-		kunmap_atomic(kaddr);
-		mark_buffer_dirty(header_bh);
-		nilfs_mdt_mark_dirty(cpfile);
-	}
-
-	if (cpp != NULL)
-		*cpp = cp;
-	*bhp = cp_bh;
-
- out_header:
-	brelse(header_bh);
-
- out_sem:
-	up_write(&NILFS_MDT(cpfile)->mi_sem);
-	return ret;
-}
-
 /**
  * nilfs_cpfile_create_checkpoint - create a checkpoint entry on cpfile
  * @cpfile: checkpoint file inode
@@ -414,23 +328,6 @@ int nilfs_cpfile_create_checkpoint(struct inode *cpfile, __u64 cno)
 	return ret;
 }
 
-/**
- * nilfs_cpfile_put_checkpoint - put a checkpoint
- * @cpfile: inode of checkpoint file
- * @cno: checkpoint number
- * @bh: buffer head
- *
- * Description: nilfs_cpfile_put_checkpoint() releases the checkpoint
- * specified by @cno. @bh must be the buffer head which has been returned by
- * a previous call to nilfs_cpfile_get_checkpoint() with @cno.
- */
-void nilfs_cpfile_put_checkpoint(struct inode *cpfile, __u64 cno,
-				 struct buffer_head *bh)
-{
-	kunmap(bh->b_page);
-	brelse(bh);
-}
-
 /**
  * nilfs_cpfile_finalize_checkpoint - fill in a checkpoint entry in cpfile
  * @cpfile: checkpoint file inode
diff --git a/fs/nilfs2/cpfile.h b/fs/nilfs2/cpfile.h
index 2cfa14011bc8..f5b1d59289eb 100644
--- a/fs/nilfs2/cpfile.h
+++ b/fs/nilfs2/cpfile.h
@@ -16,13 +16,9 @@
 #include <linux/nilfs2_ondisk.h>	/* nilfs_inode, nilfs_checkpoint */
 
 
-int nilfs_cpfile_get_checkpoint(struct inode *, __u64, int,
-				struct nilfs_checkpoint **,
-				struct buffer_head **);
 int nilfs_cpfile_read_checkpoint(struct inode *cpfile, __u64 cno,
 				 struct nilfs_root *root, struct inode *ifile);
 int nilfs_cpfile_create_checkpoint(struct inode *cpfile, __u64 cno);
-void nilfs_cpfile_put_checkpoint(struct inode *, __u64, struct buffer_head *);
 int nilfs_cpfile_finalize_checkpoint(struct inode *cpfile, __u64 cno,
 				     struct nilfs_root *root, __u64 blkinc,
 				     time64_t ctime, bool minor);
-- 
2.34.1


