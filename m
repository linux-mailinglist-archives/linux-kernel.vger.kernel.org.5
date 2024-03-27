Return-Path: <linux-kernel+bounces-121073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4B88E3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15AF4B21EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5816A1C5;
	Wed, 27 Mar 2024 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO9Dj8uO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA612FB21;
	Wed, 27 Mar 2024 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542007; cv=none; b=jhaAmwM60S2GDD3VaCldspkQH7n2ROwRDy4ds2iIKTC58ngFq8Q/JOrpSBzvoraT+BA6tBf7sIRDd1p5C9RBJByVDoNC5o6tC+rM6UZ6KfJqP62yVf3vpGq+dDk5wxax7/c9KxihlnGd7zFFECIm5R/6b/1OS3Crrhsi6k1uAq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542007; c=relaxed/simple;
	bh=UAovb1tUKDYKJTTGmzPWs+KbevUb2jUSi3ga78rj5PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPY5Vu4f+JWfG26PC6663kkiL6BzQNX+2wmpCy5k8s69c4IhFzu8gmU/Oiy9q5Wj0M1f4Wb1GyClz0rjM6BItpXjIMt0YLe+MHyQlrogC/HHP00dyeo5ZRr7JvT5WZ0xeKEUE9Rr6ZGMw380Iq2xyormPtA6Df7VA1KR6fcTrBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO9Dj8uO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A900C43390;
	Wed, 27 Mar 2024 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542006;
	bh=UAovb1tUKDYKJTTGmzPWs+KbevUb2jUSi3ga78rj5PA=;
	h=From:To:Cc:Subject:Date:From;
	b=YO9Dj8uOujNbklPfHtvUWDZxlRdocbNa7yusWhl5JrQtuSt5gpKuZ7uiU/HQstmLR
	 3HXmsOXtNq3/VWkkH/4oCgKAVKSo18cOswobfe48pE6oWZSJu7d6nyDGXWoDr16AW/
	 KV2Q4jz3Z56dxrgpjrqUfHF20Cjxi86Rutc5muP35ua987uia3S0MvF/JVL2H69qwJ
	 Qy/x89P/47+r7t/FSq3RzhLToK4qSUMHCnpCG/VPrnpvbPUkJ6gYPJVMShdptgtYUX
	 2vJ0NfSWQO0lXw6Cwz0XKB1wwaI/wLr/fRUYQaM3YnzX5GzL+8bGZ/yKTLcRmspurn
	 Vovs2jg4s1/6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tonyb@cybernetics.com
Cc: Greg Edwards <gedwards@ddn.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "block: Fix page refcounts for unaligned buffers in __bio_release_pages()" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:20:05 -0400
Message-ID: <20240327122005.2835722-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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





