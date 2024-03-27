Return-Path: <linux-kernel+bounces-120929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E913A88E09A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E911C298CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F370113280E;
	Wed, 27 Mar 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFb2SMm3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF4A14B084;
	Wed, 27 Mar 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541611; cv=none; b=Do18rkHCjzfRecJhNaobrXzjir07AeJxEDp8t75vRpayasmJHIGMKL2r9TQ2lthD5UYyWU52Uh3IdZKCb43JGaNlUVhXoNiVMi5bAXw6eLL3iJ0Cug8OaFSub6kyh5K/ESxG5fPhGbpruz0XB1WFByWi1khyR3xRiOpIkuhX/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541611; c=relaxed/simple;
	bh=QEwF2XE5idcMAAjTSgYHtTfXAGylf/zZN1BFmlqvKtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMV4WKdg0LrmUdM1JSYKe8OsUbcmsV/HIEMcMFmEWfR/ENfLsDSEBxZV4jASr7YydoTWWNvdLoiGjq3r72M/1GM11sF4jTtvs7cDna5Y5YwknyozKwXg0gDR53iCkqDi9V2udK/7A7/vdUOSdJgX2CRV5GGpk0a6WZE87M6EjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFb2SMm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A2AC433C7;
	Wed, 27 Mar 2024 12:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541611;
	bh=QEwF2XE5idcMAAjTSgYHtTfXAGylf/zZN1BFmlqvKtM=;
	h=From:To:Cc:Subject:Date:From;
	b=gFb2SMm3l1PvSuZR+1h1RoEADSS5iDjH0jf1VfVaZpFwofC79uHqojchv5sgn67Xh
	 z6514h5W4lsr3UQyBtiw1HdMz8OSFBnXU927jah30Yzr2C+xNDheQEZG9QAkEBXrXa
	 rA5In2lz3oCxCTjTJfmMnVy0csBZEK3qiNaE2o2aiNYryith3E8u3zBi9wbPBtC05b
	 r8up2e5JqHix92cuzwi4XadJCoH6UpAMVRmv7HKgY5q0uvcLfZA5EXa6VkHlu66x9R
	 J2pRqtbGtWVrCPvhCVJ8gHM7icUFwsMQ4tNpYUe/iwM63P4Z5qx48ACZR2x4x2LLlU
	 yyk5MFFp9JutA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tonyb@cybernetics.com
Cc: Greg Edwards <gedwards@ddn.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "block: Fix page refcounts for unaligned buffers in __bio_release_pages()" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:13:29 -0400
Message-ID: <20240327121329.2830355-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 38b43539d64b2fa020b3b9a752a986769f87f7a6 Mon Sep 17 00:00:00 2001
From: Tony Battersby <tonyb@cybernetics.com>
Date: Thu, 29 Feb 2024 13:08:09 -0500
Subject: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()

Fix an incorrect number of pages being released for buffers that do not
start at the beginning of a page.

Fixes: 1b151e2435fc ("block: Remove special-casing of compound pages")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Tested-by: Greg Edwards <gedwards@ddn.com>
Link: https://lore.kernel.org/r/86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 496867b51609f..a8b6919400270 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1153,7 +1153,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 
 	bio_for_each_folio_all(fi, bio) {
 		struct page *page;
-		size_t done = 0;
+		size_t nr_pages;
 
 		if (mark_dirty) {
 			folio_lock(fi.folio);
@@ -1161,10 +1161,11 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 			folio_unlock(fi.folio);
 		}
 		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
+		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
+			   fi.offset / PAGE_SIZE + 1;
 		do {
 			bio_release_page(bio, page++);
-			done += PAGE_SIZE;
-		} while (done < fi.length);
+		} while (--nr_pages != 0);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
-- 
2.43.0





