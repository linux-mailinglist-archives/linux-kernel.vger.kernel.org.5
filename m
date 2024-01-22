Return-Path: <linux-kernel+bounces-33123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF798364F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E952A28AF97
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E8A3D982;
	Mon, 22 Jan 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch2o4LZe"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230B3D969;
	Mon, 22 Jan 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932142; cv=none; b=EcwIeZ4xnNiTionLGhR4REEsTKFku3DajycpJBYl65JS/vVpcorT9/+Ps4JD/r+mNfyoQKKALUNgVD8OhRZ/5km/jlIZlQELFUVGPU1gCB2LU9GhqSfFsSygoSBInk6qgBd7vxa3G4IVjl/oZz5nLd5fG8WeS4Yopu5GQHRW/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932142; c=relaxed/simple;
	bh=J2lcZmt5rFel9B8QGYuEavwUy0DILKVjO6Ink9T2gbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FzuYDZ52uRcglmfzjUTTCnpNHScnn7RMKMkp3npxxoeDey8C33LWMUxLIzc86A7b99ySvrw0CBROL1rkeRlCv1ljyoNGOA0Oay2dZGFsgv9Fnl7Lj/GdULYmAKZl6t53f5b05e3NirHEu8kdEOAGTmbXwjL7MessROH94by8Y3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch2o4LZe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dbdb1cb23fso1373165b3a.3;
        Mon, 22 Jan 2024 06:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932140; x=1706536940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH23pe+q1rzapR4L2svxpX4qJUTePTmHiJ6zfTOcWpI=;
        b=ch2o4LZejBQKeyL8YSyYsp/IGoEu5U1CFJdSvXUdxslJ+4y6oy45SjhtECa01f5Pan
         ie2ulzo63Db8Q8EhvYFAr3O4ppn/E7TMznE19FUYHe055DzzSEEulnyPJd/SVv7MiqLF
         Vi7KpiionzT/MRAeEytuVnwicma6KPG1FR/Oit0OlKiuiaZp0qEB+taVVfEfjwc2DMEm
         Hvcz7Ts9a13AhCaAi6UyaRYXxjwp4kFTlLrYAwNvExHqVlCjMDLRwXqfnD4p94/FIkFD
         C+60zsgTFXJc89tfk1QcfachfrE0nzFtBGSCJ4kNlV6OBaIRWY4+gAD+kbqtcg15zxwp
         +EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932140; x=1706536940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH23pe+q1rzapR4L2svxpX4qJUTePTmHiJ6zfTOcWpI=;
        b=aqBiLHTWArKea0l7URsTvPaA+1w2WuElyTXZ8tnRgDJvArT6hjI4+Sju3FhXQ46Mgr
         rB2o0j3vgjhq/lenh1QF6kT0fBRz91OyT7Bjq3puiFw0vyL39lS+xPMp/cu3k9eK8v6P
         WEIvWl5rkTItAgzd/KC/Fr+HrOk7dudMPyWbJFU2r9fyz6OksEyzntOyMTK5xlSo2kaZ
         uBYtog4lvO+/T59hKV4z63jCn4YWsrbAUlCHj/KCh3qY73hFtbCckY2+g/Iehq4fPYzo
         WEH0b7X7BqoAK0RBrp6uvPcHQjQdltY+FnG+FRa8UAv2t190He/kIws9xZM77GocEWy9
         7lgA==
X-Gm-Message-State: AOJu0YyEIn/y2xo2YmDdo1BjLh3q9JEatQOzuENH3X2MmKisPLq9fFGw
	dgmrLhbl4vkmefLHIAWyA/qL2sY9mHpc+63ZLT2KJpgep1yj6raVq9Jq/NQm
X-Google-Smtp-Source: AGHT+IE9WSrveeqtDsTf3Qi+C5VLGi/zZJkqoLhx/4ctKKWkh6JK55fp6TzYyqJj+L6iKxktzTk0eA==
X-Received: by 2002:a05:6a00:2449:b0:6db:ce4e:1035 with SMTP id d9-20020a056a00244900b006dbce4e1035mr4398440pfj.61.1705932140356;
        Mon, 22 Jan 2024 06:02:20 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:19 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] nilfs2: convert metadata file common code to use kmap_local
Date: Mon, 22 Jan 2024 23:01:51 +0900
Message-Id: <20240122140202.6950-5-konishi.ryusuke@gmail.com>
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

In the common code of metadata files, the new block creation routine
nilfs_mdt_insert_new_block() still uses the deprecated kmap_atomic(), so
convert it to use kmap_local.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/mdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index e45c01a559c0..4f792a0ad0f0 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -47,12 +47,12 @@ nilfs_mdt_insert_new_block(struct inode *inode, unsigned long block,
 
 	set_buffer_mapped(bh);
 
-	kaddr = kmap_atomic(bh->b_page);
+	kaddr = kmap_local_page(bh->b_page);
 	memset(kaddr + bh_offset(bh), 0, i_blocksize(inode));
 	if (init_block)
 		init_block(inode, bh, kaddr);
 	flush_dcache_page(bh->b_page);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	set_buffer_uptodate(bh);
 	mark_buffer_dirty(bh);
-- 
2.34.1


