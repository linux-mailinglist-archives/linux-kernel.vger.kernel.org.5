Return-Path: <linux-kernel+bounces-18866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F282642B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1060FB2152D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C27134A5;
	Sun,  7 Jan 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfj40Ld0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66248134A4
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28cec7ae594so912818a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 05:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704633171; x=1705237971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0AZ0NYrGHkvNJ0BuPObLV8cnMGqTc5rnXOPBAm7Oj3w=;
        b=Hfj40Ld0ss0kXbFSC7BhbJzHcOwbT8m33wV98ocfXtJgXtAgiA83XXWrTOULqB8eAg
         OQxSyZOMGEOqrwn7LxSkFT8iH44pLjs9pPI+vCUAkehW1HkNpLRxCw53ccPXNjVIT/iz
         iG/QwBg1GvGgcLkAflxIolP1DvMJmHMMANhG12mYIh8jsehmElRKVcE1L3PlBxar10RZ
         m4McrztyYkklblCioA2p7TSdZxfOlY+8V5LNRshJTecFY6oO8R2vZR1gFtiAMb3d96nW
         m/f46KHlEH5LcCI0I7k5cxnRmeFXrYRw7I+qv1lRLV3NW6Tvz2x3WfXJ0ZdG4XpYh3gB
         iUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704633171; x=1705237971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AZ0NYrGHkvNJ0BuPObLV8cnMGqTc5rnXOPBAm7Oj3w=;
        b=c2Q/80Zg5+wMTj821Xtc6PKvbAfp2gaPI7x9dpM8izViQPoYcV23YCRouzx7VlKbWE
         +VLq8jpw3Ax9vmrpJV/PzbJaYJntmNQ3I1oQkj3tiYDI3FPbkjJbsJof3Mahcq165wD9
         ZjXeUoWSJXzL0ysfD2wLRGNyzfoNNKgo+I3zc1/jvWDJvcvxfPoKMFcy/gSYnnVgZSNf
         sG3EwWUC3T5vq9/2AkCVqKaC/WD85wPvDmHOsU8vVYiFcugc2Hw0nVzv+jlBY6MADkLd
         4MmDFibcPgtNf7DQMiNn6A+9UIBQ2o+f/mmXhBRK/16kB7atBqiP717kmjzUUbtpRkHk
         vPKQ==
X-Gm-Message-State: AOJu0Yz3WsowiZvYgBDRHPSCTGztD1CP5D5cDZj5ihOwc/O255s40ksz
	vDjh83XX/jBkEKEd45zqNrfgTSlUNOfbHg==
X-Google-Smtp-Source: AGHT+IEyT6cSkWIap2ItvbxhQ0T2N09gJiyxAbix4fWyCmxtd7aUxUqmQ3xS+BlozSvYsxONSTHncg==
X-Received: by 2002:a17:90b:1b47:b0:28b:7124:c467 with SMTP id nv7-20020a17090b1b4700b0028b7124c467mr799077pjb.89.1704633170489;
        Sun, 07 Jan 2024 05:12:50 -0800 (PST)
Received: from localhost.localdomain ([2001:250:4000:8246:82c:d0d:31ee:3949])
        by smtp.gmail.com with ESMTPSA id db4-20020a17090ad64400b00286da7407f2sm4534878pjb.7.2024.01.07.05.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 05:12:50 -0800 (PST)
From: Wenjie <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	guoweichao@oppo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn,
	Wenjie Qi <qwjhust@gmail.com>
Subject: [PATCH] f2fs: fix NULL pointer dereference in f2fs_submit_page_write()
Date: Sun,  7 Jan 2024 21:12:36 +0800
Message-ID: <20240107131236.625-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

BUG: kernel NULL pointer dereference, address: 0000000000000014
RIP: 0010:f2fs_submit_page_write+0x6cf/0x780 [f2fs]
Call Trace:
<TASK>
? show_regs+0x6e/0x80
? __die+0x29/0x70
? page_fault_oops+0x154/0x4a0
? prb_read_valid+0x20/0x30
? __irq_work_queue_local+0x39/0xd0
? irq_work_queue+0x36/0x70
? do_user_addr_fault+0x314/0x6c0
? exc_page_fault+0x7d/0x190
? asm_exc_page_fault+0x2b/0x30
? f2fs_submit_page_write+0x6cf/0x780 [f2fs]
? f2fs_submit_page_write+0x736/0x780 [f2fs]
do_write_page+0x50/0x170 [f2fs]
f2fs_outplace_write_data+0x61/0xb0 [f2fs]
f2fs_do_write_data_page+0x3f8/0x660 [f2fs]
f2fs_write_single_data_page+0x5bb/0x7a0 [f2fs]
f2fs_write_cache_pages+0x3da/0xbe0 [f2fs]
...

It is possible that other threads have added this fio to io->bio
and submitted the io->bio before entering f2fs_submit_page_write().
At this point io->bio = NULL.
If is_end_zone_blkaddr(sbi, fio->new_blkaddr) of this fio is true,
then an NULL pointer dereference error occurs at bio_get(io->bio).
In this case, the code to determine the zone end can simply be skipped.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1896928cae77..d08e92bb2621 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1100,7 +1100,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		goto next;
 out:
 #ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
+	if (io->bio && f2fs_sb_has_blkzoned(sbi) && btype < META &&
 			is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
 		spin_lock_bh(&sbi->available_active_zones_lock);
 		if (sbi->available_active_zones > 0) {
-- 
2.34.1


