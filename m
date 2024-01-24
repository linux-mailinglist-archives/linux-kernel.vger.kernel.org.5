Return-Path: <linux-kernel+bounces-36959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9749583A985
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FFC283D27
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBAC63126;
	Wed, 24 Jan 2024 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVh+Owxx"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96CD63115;
	Wed, 24 Jan 2024 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098784; cv=none; b=UqCKH1yeE0Gspkj0quwpSEJ2RIzap+ZJpxBjbSj0I72CBuynQUNtTxt4L3BJnMQOxIjSPIpNeVszkxvlr2u6pAYeuSyQkNW77E3+MLXWMXGOHN7l0d01E6I1MQWpAP+PXQZBj6ZXb+SbBjRJvUhVyTCkC90ftUkiFUYMi0KVyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098784; c=relaxed/simple;
	bh=9Ku4BKxZ6bGsXYD+z5ODPIV3wgtHmNAQqGbIzS9G2b0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQLIcdJyX1MRuvlmBBtATY+jmjkYrqYSmp1h+mv1hx1pwTcTA3Q0kQz5SCnUxgBqYeyOW4hjUq8sxayyxGY6MaSpnBEuCYrFSGVVxqivX0bUHGpJIMPqIgNbp/4b+EruO2BJWyqXv3qzrVFFdpI54X6aLrxGK4si1ystM4yTZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVh+Owxx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d720c7fc04so30618155ad.2;
        Wed, 24 Jan 2024 04:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706098782; x=1706703582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx+0cl1ZNPikMxNrIrAgJ2neRZewXxRa0JMeCuH3m4Q=;
        b=VVh+OwxxksfZiQQ9QoOzm5tMiC0U0V6yHy9C7qfzHPTrJyjGURESdMaBPp9Iw1uuc1
         DGhCt7zzXDe8FY2p2k88JHBp2a0Aosjmpt5vfC96w8A8aq5DrQZZVYYjA2mYPIwRdw2q
         0eKf7WzwRJpSeJW11hfNUvp+vJn9hYxFQgXGVEnTapUgtnqcdkmKFbDXqyy6Q4vo0q3S
         ejYrw1GgJkjhB4Uk9nE2pMi7FwZ13ZI74SmjuUNUH0p1gsKzuYCzxqm0p6DVpsSCn3yf
         G1G9t4RqVFR8fbPYpyTy5RwrnVWMOtbim2wi9I73wysbckOdcrm+XByA7CzsZR8r0NX/
         4p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706098782; x=1706703582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vx+0cl1ZNPikMxNrIrAgJ2neRZewXxRa0JMeCuH3m4Q=;
        b=KiKbnf1k5bZ1eHNxKuTS/iFsPlJpTexKILF44v+G1zmiy+SsfI85TAmoftMNZA930H
         pJLZ9wffGcV2W2dFGp9ydvGtuFkGBvqcipn5qlW6GE+t4tVA3cPsWhMsP7tny9AcF97J
         EFvNHsG6reEtN+eH1M7cTwe5T6SxSlbIrzb0TvrHmqV6k+ZZIw9wnP1UIkYjKZ1sOrC4
         j/gl1A9ckm1oNPWQrbLa3oZp5jIVih8cBh1TN2Ypeq2wXoj4UD5craFnblDR53YH/ECy
         k2GCu0cajTYjmARn2RVlN4FjaRlmbQuGMiqoBU3/V6tibKuDcdDrXctZeAKlX3Czt68x
         3wcg==
X-Gm-Message-State: AOJu0Yyu8TR45DLVhkxR0LA9TRjlhufcZAmFxRM7urcwSBqF/C+2m053
	sZGEnywx60asConyjkD/dh66HyOtWlfwoA//ReydsuP0+Xpk+EWc43HE7dW1
X-Google-Smtp-Source: AGHT+IFdNny+bWLyCfvWrvX9wp+Ixz9vTCKjCQ7pHqqxwX+5BepJrnXdP5Gu12nxVi5HTuYQOsC4Eg==
X-Received: by 2002:a17:903:191:b0:1d7:2d44:576b with SMTP id z17-20020a170903019100b001d72d44576bmr733561plg.59.1706098781952;
        Wed, 24 Jan 2024 04:19:41 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902f25100b001d70e83f9c3sm9816456plc.242.2024.01.24.04.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 04:19:40 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: fix data corruption in dsync block recovery for small block sizes
Date: Wed, 24 Jan 2024 21:19:36 +0900
Message-Id: <20240124121936.10575-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper function nilfs_recovery_copy_block() of
nilfs_recovery_dsync_blocks(), which recovers data from logs created by
data sync writes during a mount after an unclean shutdown, incorrectly
calculates the on-page offset when copying repair data to the file's page
cache.  In environments where the block size is smaller than the page size,
this flaw can cause data corruption and leak uninitialized memory bytes
during the recovery process.

Fix these issues by correcting this byte offset calculation on the page.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
---
Andrew, please apply this patch as a bug fix.

This patch may conflict with the first patch of the kmap conversion series
that I posted earlier.

Since this fix should be a priority, I made it against the mainline
so that it can be applied before the kmap conversion patches.

If the conflict ia a problem for your patch handling, please drop the
first patch of the kmap conversion series (it can be dropped independently).
In that case, I will repost the patch that resolves the conflict.


Thanks,
Ryusuke Konishi

 fs/nilfs2/recovery.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 0955b657938f..a9b8d77c8c1d 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -472,9 +472,10 @@ static int nilfs_prepare_segment_for_recovery(struct the_nilfs *nilfs,
 
 static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 				     struct nilfs_recovery_block *rb,
-				     struct page *page)
+				     loff_t pos, struct page *page)
 {
 	struct buffer_head *bh_org;
+	size_t from = pos & ~PAGE_MASK;
 	void *kaddr;
 
 	bh_org = __bread(nilfs->ns_bdev, rb->blocknr, nilfs->ns_blocksize);
@@ -482,7 +483,7 @@ static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 		return -EIO;
 
 	kaddr = kmap_atomic(page);
-	memcpy(kaddr + bh_offset(bh_org), bh_org->b_data, bh_org->b_size);
+	memcpy(kaddr + from, bh_org->b_data, bh_org->b_size);
 	kunmap_atomic(kaddr);
 	brelse(bh_org);
 	return 0;
@@ -521,7 +522,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 			goto failed_inode;
 		}
 
-		err = nilfs_recovery_copy_block(nilfs, rb, page);
+		err = nilfs_recovery_copy_block(nilfs, rb, pos, page);
 		if (unlikely(err))
 			goto failed_page;
 
-- 
2.34.1


