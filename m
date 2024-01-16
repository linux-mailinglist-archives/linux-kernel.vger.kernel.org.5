Return-Path: <linux-kernel+bounces-27455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BBA82F050
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C78285352
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6AD1BDF3;
	Tue, 16 Jan 2024 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Olrpyaog"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F741BDE7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d5ece717aeso3316385ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 06:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705414313; x=1706019113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwGjvXloGvIfAhj2uR+wy0smwtrFBrVoNPSps/xZwaQ=;
        b=OlrpyaogntkooKtRS6Q+CDvit4gOLBcuP48zQryIA/etz/j0OshxAYKnmVhl1tlvve
         SCpkhJx7qIuHpHMI2T6eVWZOTz/yMHomzQjtbulcVnAAUvyoJzc5RqIzpBIm+vTU3g5d
         AIJK7K+gLLYbFu1gu6uIq6j579q0QEGNtrvtxhVxamNhvQzlSX/e3Vl229PjmzUTTyGo
         vMZVPbUNMlepi+kil6lTKetitzxQuNxf63/wjUJO2vyD4pEC6bNy82j/e1DLYfztrN6K
         P2ABnxUK/S2eMgSuoAttrHkwphpiuuemM2HordJYHrEm1KNfTNJyPsAksVvOTEZtaKTM
         ALTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705414313; x=1706019113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwGjvXloGvIfAhj2uR+wy0smwtrFBrVoNPSps/xZwaQ=;
        b=kxbJu/ugHJXq5FQZimAfLDCAmon1vcN19Ac99MXzcKwEJlZqGCt8xDkkx8LyfmcQoN
         YJElvXEsaQq2ifqQ+FnbMgb5Jluvu0egIUszzOffv4C6bS6B0DvcZk2Cp2YFkQ2dt9uU
         gibSMIYaA0OAzBp3XJrhVHXbca2NKCDg1WYkRnfsxVtcOaC7Yzs9oBbagS9blTERaeTt
         BYCSakwvUKBC0RM38qWtCDbfIAnuFTn0INXKBlwywyYvtuOVauAEhzrSTF2McL8MCLJs
         AJwBAGQ4ywl9AzNU/X47iOHTBlDW+pZ3JXUoxPEdZF7y/wPokILtaFo1H7Tg+n6oCkMF
         DA4Q==
X-Gm-Message-State: AOJu0YysynFwOnOgZorj3QmGqOmBeTc+JB9SqH47FD2RYaiK1+vJTy12
	eHAeVQ1OGnsHEWfZVeEjIlY=
X-Google-Smtp-Source: AGHT+IG5klyCfFZF8El2yLuJhphWWf5wZvlzZYGbQLqxzbecF3MpOnUMh2kBGHKEk1ZmThfmwVC5sA==
X-Received: by 2002:a17:902:eccf:b0:1d5:b797:fdc with SMTP id a15-20020a170902eccf00b001d5b7970fdcmr2922442plh.131.1705414313502;
        Tue, 16 Jan 2024 06:11:53 -0800 (PST)
Received: from localhost.localdomain ([2001:250:4000:8246:8dd2:f82d:e185:367f])
        by smtp.gmail.com with ESMTPSA id p19-20020a170903249300b001d5c38d720bsm4360242plw.2.2024.01.16.06.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 06:11:53 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn,
	Wenjie Qi <qwjhust@gmail.com>
Subject: [PATCH v1] f2fs: fix NULL pointer dereference in f2fs_submit_page_write()
Date: Tue, 16 Jan 2024 22:11:38 +0800
Message-ID: <20240116141138.1245-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
..
It is possible that other threads have added this fio to io->bio
and submitted the io->bio before entering f2fs_submit_page_write().
At this point io->bio = NULL.
If is_end_zone_blkaddr(sbi, fio->new_blkaddr) of this fio is true,
then an NULL pointer dereference error occurs at bio_get(io->bio).
The original code for determining zone end was after "out:",
which would have missed some fio who is zone end. I've moved
 this code before "skip:" to make sure it's done for each fio.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
---
 fs/f2fs/data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dce8defdf4c7..4f445906db8b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1080,10 +1080,6 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	io->last_block_in_bio = fio->new_blkaddr;
 
 	trace_f2fs_submit_page_write(fio->page, fio);
-skip:
-	if (fio->in_list)
-		goto next;
-out:
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
 			is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
@@ -1096,6 +1092,10 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		__submit_merged_bio(io);
 	}
 #endif
+skip:
+	if (fio->in_list)
+		goto next;
+out:
 	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
 				!f2fs_is_checkpoint_ready(sbi))
 		__submit_merged_bio(io);
-- 
2.34.1


