Return-Path: <linux-kernel+bounces-74239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E742285D174
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23ED61C22937
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535DB3B2B6;
	Wed, 21 Feb 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzLRqJml"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392EE3B1AB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500816; cv=none; b=D8wZK2TtgTqmrr1W0UPjb865eLNUmAx10ATvwdpfxuAbZuxMZoCIvwci3oEB9KSNr3tW9hi/rL7WGeL2E0dMTJ593nAl3yfNZLCaNCSJ1MzRxHhTI4T/VGWZYsbBEpiFykUhmYLPBUerO86K4j1nDj+vWtTYxW634WARejfVG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500816; c=relaxed/simple;
	bh=Dr6Jj0t2I6qYqvCt6QxwjbxJr/y6VUy9W/MZfu57DaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HyCyut0p8QLKFh/wQLXsOs8iZjjdAQhvwDKF3mUajj6ekPKB7b7IX8IHW+y7n/IrX7EgF8/KpauCY9fj/mWq07q55ZBvaKK783IWC7PwAw9wj60XS0F2L/hjUQ5/0KqOplQq9VGskzFZJyih0QlurB2VwjlPuaZ4HZImwcRKdPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzLRqJml; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so4772654a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708500814; x=1709105614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qU2iF33SDnjbxbTA1bjsBvV0qZKEE2L9dMkO6OS+Cdg=;
        b=IzLRqJmlrS5uQcLQ0zw6kyNFo2BqMwwSSqYjshh9oWqLYuVBgZRU5Bb+kxzytFnONV
         qvCgutI9IZBA6bk8M1KRjH/CfFaNWUIKYTa1z0H+0/11aMXiKv78Hox+M6aqZ6Yzvp20
         bDwvK1fH+be78oqDa+unhaQ7TzGbPFJp06xa0zFVuTHRmIgTHv3Y5GyzdQr3Yb+KhVdb
         /HFs+kroCGIF0m3xQdnzuFGep3JXspJL4fZYGyNzxOHFDJa+etFY54oCDNbUbkQ3OOTa
         B6VSejrbTrjgOKJhB8lqky9H+qdO9uiGXSQMR4anFA1D1jkGwCichTmtKw6mOQmK9oUW
         dp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500814; x=1709105614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qU2iF33SDnjbxbTA1bjsBvV0qZKEE2L9dMkO6OS+Cdg=;
        b=OYiNmLMd12Cej6WUEehY7R27x1f9yr2CyskXop7U6ShdA/XDY+Y+fM5MqvlAzEQ/nj
         PipVy7pmZBpDW8M5skrKksSr2v5v0qUHEZZX2vPgTRU+asbapqhJ0DN7iDAdmGCs/Wb5
         tPYW57/38S76WqAg3/NnlNUMClZzb+tc4y5NOBw0fEcM8YJG8jxSZ0vZ0uzlf3WL8Hsq
         OaXiUifKWLYiNcGQcHqrZfMfQzEMku8DLOMFaNFPLRm1WqHMby8iYKE9erNsv1hLGp0h
         M2JOw8B3tJGDyEk/Gyn85arZH+itcP3G/q43vTFl74CR+I85R1WYYdWk5K45miw6dPKo
         cbGw==
X-Forwarded-Encrypted: i=1; AJvYcCV70gor6dEqcYn4XY/ZY0QLUVcZvmcin44xNQx3Nyyobhv0/RR0FcdsRgAEdJ5nIInhHTwgll228YsmHqBPITRiYHvsNLC530KNY4az
X-Gm-Message-State: AOJu0Yz9yc0HY9UU0t25RIN7JVmMDOrL6mRuPxXTBnw6rmLyWWawy758
	/PSCqe2yQX7zmnqSZSDakRfdP5L/8vuYKy3Vm2VEahbvq+UDSOHLgd369PEW
X-Google-Smtp-Source: AGHT+IF29KSLDWX3+z0Vc2R2dUX9ihmYYnDX1o5SvRgDxdShnQR6eB/QSWn1DjxjHx8KCGu2HV22og==
X-Received: by 2002:a17:90a:7788:b0:297:f09:fe08 with SMTP id v8-20020a17090a778800b002970f09fe08mr15845793pjk.0.1708500814365;
        Tue, 20 Feb 2024 23:33:34 -0800 (PST)
Received: from mi.mioffice.cn ([43.224.245.229])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090ad80100b002993c27f76asm8867459pjv.50.2024.02.20.23.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:33:34 -0800 (PST)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	liujinbao1 <liujinbao1@xiaomi.com>
Subject: [PATCH] f2fs: sysfs: support atgc_enabled
Date: Wed, 21 Feb 2024 15:32:49 +0800
Message-Id: <20240221073249.1710026-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liujinbao1 <liujinbao1@xiaomi.com>

When we add "atgc" to the fstab table, ATGC is not immediately enabled.
There is a 7-day time threshold, and we can use "atgc_enabled" to
show whether ATGC is enabled.

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/sysfs.c                         | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 36c3cb547901..8597dfaef700 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -564,6 +564,12 @@ Description:	When ATGC is on, it controls age threshold to bypass GCing young
 		candidates whose age is not beyond the threshold, by default it was
 		initialized as 604800 seconds (equals to 7 days).
 
+What:		/sys/fs/f2fs/<disk>/atgc_enabled
+Date:		Feb 2024
+Contact:	"Jinbao Liu" <liujinbao1@xiaomi.com>
+Description:	It represents whether ATGC is on or off. The value is 1 which
+               indicates that ATGC is on, and 0 indicates that it is off.
+
 What:		/sys/fs/f2fs/<disk>/gc_reclaimed_segments
 Date:		July 2021
 Contact:	"Daeho Jeong" <daehojeong@google.com>
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 417fae96890f..0915872abd97 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -143,6 +143,12 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
 				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
 }
 
+static ssize_t atgc_enabled_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", sbi->am.atgc_enabled ? 1 : 0);
+}
+
 static ssize_t gc_mode_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -1017,6 +1023,7 @@ F2FS_GENERAL_RO_ATTR(encoding);
 F2FS_GENERAL_RO_ATTR(mounted_time_sec);
 F2FS_GENERAL_RO_ATTR(main_blkaddr);
 F2FS_GENERAL_RO_ATTR(pending_discard);
+F2FS_GENERAL_RO_ATTR(atgc_enabled);
 F2FS_GENERAL_RO_ATTR(gc_mode);
 #ifdef CONFIG_F2FS_STAT_FS
 F2FS_GENERAL_RO_ATTR(moved_blocks_background);
@@ -1144,6 +1151,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(atgc_candidate_count),
 	ATTR_LIST(atgc_age_weight),
 	ATTR_LIST(atgc_age_threshold),
+	ATTR_LIST(atgc_enabled),
 	ATTR_LIST(seq_file_ra_mul),
 	ATTR_LIST(gc_segment_mode),
 	ATTR_LIST(gc_reclaimed_segments),
-- 
2.25.1


