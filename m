Return-Path: <linux-kernel+bounces-51178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D0484875D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DC11C22C2D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650935F578;
	Sat,  3 Feb 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7jV1sBs"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8105F561;
	Sat,  3 Feb 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706977029; cv=none; b=jHEvtgniNqTczrmoAmxL4jrRwWaGn7WzbO3Ilr1aZq1iIhKAXC5fbo1ArSbd3YJgLHsqGI/6PZjrFpmjwOJ7yTqnLnT58FBIpaqzvT5z9JWSGcdxCNqoPEJ6XH4uQTIANYB4b/MgXjPmWV2xsCbFBDZhcwIAkBjuxj3uUXEvHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706977029; c=relaxed/simple;
	bh=2GPOc2PZ2fg/zlvgyDEmTDV/NI/x0BA9gFkuOhJfAhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWzrPQ5ZpIdeH8BAL5QraDctUs8ebzYSGQ097OzQA7HKwzqUtMoiJXrxldvig1N8x5ExdZFRY++ikKjMtNjNZ178DJ9+fXZQGNp3uZ+3SB5OXQBN3+owUtVopTRdd5P1ZF7h25CqUhbysQkNNPkd/djk/pujHndnIoP9FiHxuk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7jV1sBs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d76671e5a4so24458355ad.0;
        Sat, 03 Feb 2024 08:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706977027; x=1707581827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkKSBEd57oTuNT42X1XreOYTPrUWtWe7ns5GZwL0900=;
        b=S7jV1sBs7Mcm7rqfwHOJP6a0cwTGEyInPG5WsPEt2HGJrno0qvX7tGGdtjYz+hn0lb
         YYM2gMcxV++t3vaAs4PcaXfehuiPWyV3/jwfAynQSJpEMbDbER8VdvAsOoPep4Bz0Kr+
         Vcd+vwfzFejN0tsQJcZnGaBqFXB4xg8GrEFB4aqeKoo5Cpts4dJVKZpJXqOIsYzqY+fV
         D+crHNFqJ0w92g0+OmjsT7gbrWCFOo1wBcOg9Iv98iVZoG6dKB9K9FD6ZYWbDCxpVmTA
         8hf6C4B5xpkIbT28tFcWySR/d+QspiMqfskk1SPui2QJ9hrkLAo2OOr/BOWn5ie7FH7p
         npsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706977027; x=1707581827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkKSBEd57oTuNT42X1XreOYTPrUWtWe7ns5GZwL0900=;
        b=ILUlmya94cY0qU9mQM297EkrtdajrnrrJ9ylmWG/H6hHBSmYK5LJG/oUVBdx61ixsk
         gE2BK38bV5t8wWwrjkCFehBvEVUgkgj0XoKx+doUPLreYhlaZmkZEMVLjYnLIujyarwa
         4/WW//4eXF3EXsUnSzC7LRWBZPAQfddquQ+qe2wLcIiXT3BcB5gUUi4dpVFsr4ZYhHAs
         2E/pvUPUQHVnyOnzKDju42quFyN/JWaLKzijxCRUhulcvXO59mBlgoc1RkUyEfi4HSMe
         CU3HDUWycqyzIHyGNWSHYbxAr4mITkQPSFbAx/1HS9ew3hfE3q0KQr9iMDjZG4kcVzMt
         82jg==
X-Gm-Message-State: AOJu0YwHXfv3ctOB4nfhgYJYT0Lmq4Er6fm26c33wVnSs/T0K03JZiiq
	r6QobvAQH2x6DZ09heKeHrQOAt8BQED/AZFnFSNZQIny0QtT/NxG
X-Google-Smtp-Source: AGHT+IGBTmQivxddaCNb5Yw9T9M/EWo35Gsco2kiOzpZMdJbE2Zh5oWts2lhfjS0Vdc1o5Jd+noHUQ==
X-Received: by 2002:a17:902:e807:b0:1d7:83e4:a19 with SMTP id u7-20020a170902e80700b001d783e40a19mr15438382plg.33.1706977027362;
        Sat, 03 Feb 2024 08:17:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCULw3SkPAaFjzvA6Q65uEQ8raXUpBhJ0EnZPV9zLFUX5bKx2X9NDKnGsY0NTXcjz3SXf4C6HzWXEBLvbdnCr58EpB3Bub36vNbCmhWz2xdVQz3f3UMt88wMpKGoR8+WqjUwJKJrBPb8mGZSxK3p89Fkyg75Fk1E9qc270suqMUMhj/qcW64nctsNHeggY3Fqm1X3jxKGD6QdgBxqueu6IYMb5Akvg==
Received: from carrot.. (i223-218-113-167.s42.a014.ap.plala.or.jp. [223.218.113.167])
        by smtp.gmail.com with ESMTPSA id jh2-20020a170903328200b001d94546686esm3465551plb.28.2024.02.03.08.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:17:05 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	syzbot <syzbot+5c04210f7c7f897c1e7f@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: fix potential bug in end_buffer_async_write
Date: Sun,  4 Feb 2024 01:16:45 +0900
Message-Id: <20240203161645.4992-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000019a97c05fd42f8c8@google.com>
References: <00000000000019a97c05fd42f8c8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to a syzbot report, end_buffer_async_write(), which handles
the completion of block device writes, may detect abnormal condition
of the buffer async_write flag and cause a BUG_ON failure when using
nilfs2.

Nilfs2 itself does not use end_buffer_async_write().
But, the async_write flag is now used as a marker by
commit 7f42ec394156 ("nilfs2: fix issue with race condition of
competition between segments for dirty blocks") as a means of
resolving double list insertion of dirty blocks in
nilfs_lookup_dirty_data_buffers() and nilfs_lookup_node_buffers()
and the resulting crash.

This modification is safe as long as it is used for file data and
b-tree node blocks where the page caches are independent.  However,
it was irrelevant and redundant to also introduce async_write for
segment summary and super root blocks that share buffers with the
backing device.  This led to the possibility that the BUG_ON check
in end_buffer_async_write would fail as described above, if
independent writebacks of the backing device occurred in parallel.

The use of async_write for segment summary buffers has already been
removed in a previous change.

Fix this issue by removing the manipulation of the async_write flag
for the remaining super root block buffer.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+5c04210f7c7f897c1e7f@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/00000000000019a97c05fd42f8c8@google.com
Fixes: 7f42ec394156 ("nilfs2: fix issue with race condition of competition between segments for dirty blocks")
Cc: <stable@vger.kernel.org>
---
Andrew, please apply this as a bugfix.

This fixes a kernel bug issue reported by syzbot.  This may conflict
with the merged folio conversion series when backporting it to stable
trees.  I would like to send a separate request to the stable team
in that case.

Thanks,
Ryusuke Konishi

 fs/nilfs2/segment.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2590a0860eab..2bfb08052d39 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1703,7 +1703,6 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			set_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_folio != bd_folio) {
 					folio_lock(bd_folio);
@@ -1714,6 +1713,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 				}
 				break;
 			}
+			set_buffer_async_write(bh);
 			if (bh->b_folio != fs_folio) {
 				nilfs_begin_folio_io(fs_folio);
 				fs_folio = bh->b_folio;
@@ -1800,7 +1800,6 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				clear_buffer_uptodate(bh);
 				if (bh->b_folio != bd_folio) {
@@ -1809,6 +1808,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				}
 				break;
 			}
+			clear_buffer_async_write(bh);
 			if (bh->b_folio != fs_folio) {
 				nilfs_end_folio_io(fs_folio, err);
 				fs_folio = bh->b_folio;
@@ -1896,8 +1896,9 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				 BIT(BH_Delay) | BIT(BH_NILFS_Volatile) |
 				 BIT(BH_NILFS_Redirected));
 
-			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh == segbuf->sb_super_root) {
+				set_buffer_uptodate(bh);
+				clear_buffer_dirty(bh);
 				if (bh->b_folio != bd_folio) {
 					folio_end_writeback(bd_folio);
 					bd_folio = bh->b_folio;
@@ -1905,6 +1906,7 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				update_sr = true;
 				break;
 			}
+			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh->b_folio != fs_folio) {
 				nilfs_end_folio_io(fs_folio, 0);
 				fs_folio = bh->b_folio;
-- 
2.34.1


