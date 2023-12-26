Return-Path: <linux-kernel+bounces-11423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D00F81E60A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728551C21D74
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6EE4D10F;
	Tue, 26 Dec 2023 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1bjnNsV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5B4D102
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ba14203a34so4373613b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 00:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703580808; x=1704185608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jn4iVudUfGWwocGEENajE7FASNfvXCdRZiNgIIgsoiE=;
        b=D1bjnNsVDwnXIDU91cWP1C+AMAlxgLokfWCe6r5APcsNIQ3+xQ8Oz3Xkm5zNcbUUAB
         h+WjQvAJ9F+Qs3cF5Ba9TwFvQErkisU4YsblUCyS7f7xtHJlG5/aYCGBquC2aN3sL27r
         xwXIFVBPISOiT8VcmdCIeaS9bxryrO/QAOhXNQWOQNRrCPjSV0fMy/3hQ+2WR3bHz+ZX
         8d7wEz6I6DlzIYaBgTdaY5rojwczs/vYYQptGU42omxNgWm54t9ls45v2hpUpUmWP/AT
         ArPJECcethX/fE/gRkIVt4hWTq2Y/1mbHI5JH7PUIgnNgomTFmGg3N1el/3eWiGu4Vkd
         eP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703580808; x=1704185608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jn4iVudUfGWwocGEENajE7FASNfvXCdRZiNgIIgsoiE=;
        b=Yn4IxhPqDx7xXcEEigCfWvTZuLKeMAy3g9j1oRTikyjznfUayNB+EdgBoklzIncDra
         jXqSK7CLYCoiStG3v1B5Q2Qk7FgN3CZD2cN9/v64GlJsyApHwhIvQOobcNwr5laAoIZy
         JK6giZ3U175+jcvGx8JrC62Zr8RACSLVwktauJV6mKAj/5TEe5C/8APIxaP+8Uv9vvZJ
         yOIHZz1UxfS7olnJf8LABNpxaE8E3T/VLUcOk2M7WWYzt6Oi6ZsMeWC1SJf2JqJJqlRo
         qwrmaxuW9FoJ86fiJAXPdh6/DHOMr8+hYYQNyq7uG8NcwqtYdTO6M/3LQpxt/9zpbJEQ
         YKEQ==
X-Gm-Message-State: AOJu0YwppmLDmT9tUFIJNAyGFCoWj9aCfHyNIp3iY1NswJY+nO/h9zAj
	wyrJyTF3V1LKpgpJlAOuOOk=
X-Google-Smtp-Source: AGHT+IGh6rpiBownpN1lkmpD2ouX5CXUhRnZ6O4r+qB409O7lMyguRMsAyL+GYTut6KDVZYyCP9Cvw==
X-Received: by 2002:a05:6808:399b:b0:3bb:bf35:f82f with SMTP id gq27-20020a056808399b00b003bbbf35f82fmr92448oib.104.1703580808578;
        Tue, 26 Dec 2023 00:53:28 -0800 (PST)
Received: from ism-manjaro.realtek.com.tw (125-227-180-151.hinet-ip.hinet.net. [125.227.180.151])
        by smtp.gmail.com with ESMTPSA id a23-20020aa78657000000b006d9b8e1971dsm3174349pfo.191.2023.12.26.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 00:53:27 -0800 (PST)
From: Ism Hong <ism.hong@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ism Hong <ism.hong@gmail.com>
Subject: [PATCH] fs/ntfs3: use non-movable memory for ntfs3 MFT buffer cache
Date: Tue, 26 Dec 2023 16:51:41 +0800
Message-Id: <20231226085141.2830875-1-ism.hong@gmail.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the buffer cache for ntfs3 metadata is not released until the file
system is unmounted, allocating from the movable zone may result in cma
allocation failures. This is due to the page still being used by ntfs3,
leading to migration failures.

To address this, this commit use sb_bread_umovable() instead of
sb_bread(). This change prevents allocation from the movable zone,
ensuring compatibility with scenarios where the buffer head is not
released until unmount. This patch is inspired by commit
a8ac900b8163("ext4: use non-movable memory for the ext4 superblock").

The issue is found when playing video files stored in NTFS on the
Android TV platform. During this process, the media parser reads the
video file, causing ntfs3 to allocate buffer cache from the CMA area.
Subsequently, the hardware decoder attempts to allocate memory from the
same CMA area. However, the page is still in use by ntfs3, resulting in
a migrate failure in alloc_contig_range().

The pinned page and allocating stacktrace reported by page owner shows
below:

page:ffffffff00b68880 refcount:3 mapcount:0 mapping:ffffff80046aa828
        index:0xc0040 pfn:0x20fa4
    aops:def_blk_aops ino:0
    flags: 0x2020(active|private)
    page dumped because: migration failure
    page last allocated via order 0, migratetype Movable,
        gfp_mask 0x108c48
        (GFP_NOFS|__GFP_NOFAIL|__GFP_HARDWALL|__GFP_MOVABLE),
    page_owner tracks the page as allocated
     prep_new_page
     get_page_from_freelist
     __alloc_pages_nodemask
     pagecache_get_page
     __getblk_gfp
     __bread_gfp
     ntfs_read_run_nb
     ntfs_read_bh
     mi_read
     ntfs_iget5
     dir_search_u
     ntfs_lookup
     __lookup_slow
     lookup_slow
     walk_component
     path_lookupat

Signed-off-by: Ism Hong <ism.hong@gmail.com>
---
 fs/ntfs3/ntfs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index abbc7182554a..2b54ae94440f 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -1035,7 +1035,7 @@ static inline u64 bytes_to_block(const struct super_block *sb, u64 size)
 static inline struct buffer_head *ntfs_bread(struct super_block *sb,
 					     sector_t block)
 {
-	struct buffer_head *bh = sb_bread(sb, block);
+	struct buffer_head *bh = sb_bread_unmovable(sb, block);

 	if (bh)
 		return bh;

base-commit: 4cdfb6e7bc9c80142d33bf1d4653a73fa678ba56
--
2.37.2


