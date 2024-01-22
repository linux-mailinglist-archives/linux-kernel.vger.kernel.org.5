Return-Path: <linux-kernel+bounces-33129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672A3836501
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE2028E9D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8663E476;
	Mon, 22 Jan 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGSmUmXA"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D03E497;
	Mon, 22 Jan 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932156; cv=none; b=tihOtzA7jL0jlZ5Z8cASzra+8GXS+OWL95r2z9XoprCkqdv6Ib94kVx48DiIM64AhdwU087PO6TtfwHLSHO9ZfbztowVSSbhzbKH5CjE0fg+DoS6trySIf50p5VkjhUIXPHbHMUPeX6wl9KpBlaEf3D8rq5XhCtyaUGl7eOyqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932156; c=relaxed/simple;
	bh=KBth+bbeg4R5PqQLpaKBQ2olW6SygwHEo2iHu/7IdXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rtZmThhYJ4cmIYv0s6kbPusM6OYOY/uHqMPYW8V0ngfBSIQ8a0OquImpgNBuRltNSdYYxPRbxTAfuQqdwtfTfegVuXNsS2gWEl1sZtNC7/6PaEf8bZrPTI2A8MLuI7lqjnzMQakzgi7cLIUjj7AZXkzgtZhSisrnMHwbpLPNMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGSmUmXA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dbd56b5357so690291b3a.1;
        Mon, 22 Jan 2024 06:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932155; x=1706536955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvGoX9VOfmX4dn+RR4IR/9t7Alhj00s+830PV0mY3JA=;
        b=gGSmUmXAoa8zatoROYPYnHhGAMal2iYkflAdm9RTiR4+61X+MvPm60RsR5sDlK9o7w
         PhsLdbX3x+kRz0ewqT0Gbws5bOJz/fukGFxZ398Go4RcIjc0OMKEsjXgU/sEbk+FgFuZ
         qsB125ok6eMl3wH/JkSqS5upKXJvIuiwQFNa0P4zYMaLA/UTYdPq4BF+ezy6BNdKYWuT
         IDM9DcVEhBj8VI7SVS99ZmvHjmY9LirmMM8PvBHhFIT6ZfWx9ZG9mkqkVz7Us9ZZP4wB
         c8Ugl+axk4snGSZVLPfpHtuuu/tnlQVlHEkLNnSp91CI5mcbsWz8+74qG18vq+BaxT4C
         8UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932155; x=1706536955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvGoX9VOfmX4dn+RR4IR/9t7Alhj00s+830PV0mY3JA=;
        b=uIuDtUhmbQNSFu49P6+sGLnWAnHefiFiHrjV0qiAuohDRsjtSuExGXZmTWraMS4EXi
         YGODhM23ouY25S0XJG1XN/0wcDL9W+QKULBwdPdkDPF11FaSAlGUirq6Z1qhBU2V6uDW
         GFBoaKuXjwHVhw2uimUxEYHa6sZra8dGiGsbB3hdYaIDCtw21JiuzlVJaq4CFjLGbPHy
         fRUtVkh7fcYqXdKoa8ta6QjIwGRHgxjW+6IgmGOrRDxp/1IivISuVWH0bZzLiQlLOboK
         6rBtxkh1iCVqrTnEuopzO/AZ2wyGqW/c6OblxPgztOq4NL7AXw0PM/MrTU9Ue6ZfqT2g
         iOWQ==
X-Gm-Message-State: AOJu0Yw5jbkbWkY4i6ghPojvJX/+06xANM6Q0Q5o0QdmhRprLGI0oCRR
	NDMj8WF9R1d3v9OHCAoyc8KQb/aabbgoJgeleRbs30crjM+GOvwC
X-Google-Smtp-Source: AGHT+IGcilZDK/fnpPpSLh99Omb8TfpmkolDOEQiQ3CMiXZjtHF57K5Unzth2zHxF2vhLa/tNZiNeg==
X-Received: by 2002:a05:6a20:d48d:b0:19b:e6c5:2c97 with SMTP id im13-20020a056a20d48d00b0019be6c52c97mr1748589pzb.4.1705932153027;
        Mon, 22 Jan 2024 06:02:33 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:31 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] nilfs2: do not acquire rwsem in nilfs_bmap_write()
Date: Mon, 22 Jan 2024 23:01:56 +0900
Message-Id: <20240122140202.6950-10-konishi.ryusuke@gmail.com>
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

It is now clear that nilfs_bmap_write() is only used to finalize logs
written to disk.  Concurrent bmap modification operations are not
performed on bmaps in this context.  Additionally, this function does not
modify data used in read-only operations such as bmap lookups.

Therefore, there is no need to acquire bmap->b_sem in nilfs_bmap_write(),
so delete it.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/bmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 7a8f166f2c8d..383f0afa2cea 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -548,13 +548,10 @@ int nilfs_bmap_read(struct nilfs_bmap *bmap, struct nilfs_inode *raw_inode)
  */
 void nilfs_bmap_write(struct nilfs_bmap *bmap, struct nilfs_inode *raw_inode)
 {
-	down_write(&bmap->b_sem);
 	memcpy(raw_inode->i_bmap, bmap->b_u.u_data,
 	       NILFS_INODE_BMAP_SIZE * sizeof(__le64));
 	if (bmap->b_inode->i_ino == NILFS_DAT_INO)
 		bmap->b_last_allocated_ptr = NILFS_BMAP_NEW_PTR_INIT;
-
-	up_write(&bmap->b_sem);
 }
 
 void nilfs_bmap_init_gc(struct nilfs_bmap *bmap)
-- 
2.34.1


