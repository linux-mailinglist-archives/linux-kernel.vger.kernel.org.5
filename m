Return-Path: <linux-kernel+bounces-121252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B07988E461
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF58D1F2EC05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CEA1A4368;
	Wed, 27 Mar 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjAYAPvq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA81A4355;
	Wed, 27 Mar 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542464; cv=none; b=OvhOEBWuG8G8WzVJABDioZKaRNMj9ArfpDMZsnkZdK9BQgs8ke4xeYnJ/ndEQOVR09D6mJ7emEQPRVw90A5t+EmliNLv0jQdz6boWBSnIeT3cpMqXLAyveTPevmLjf08vVK1rxQE21pAam4lzZ5o/izE9y51L5IJFRUJDJSLjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542464; c=relaxed/simple;
	bh=rPGfnLFPSavzTCZl7PBphFANNg0fEWlnqwTgfQnLpTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Krn3bNdgfYYSCwUhh4ZjrCBYSz3KJsPIxBEi3E1toGglnEFig7kZrsHyvgvpf+Pj4G+WG5aLZpeuSW3aRA4ByNU1hOP59XfuuPIqA7IpGaSvXi6CZy6xLisVrt0G4Vjru3mhNhpP2VxJFyC+juuaHIKo1F9VMiu6dqIX4UWfTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjAYAPvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFECC433F1;
	Wed, 27 Mar 2024 12:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542464;
	bh=rPGfnLFPSavzTCZl7PBphFANNg0fEWlnqwTgfQnLpTo=;
	h=From:To:Cc:Subject:Date:From;
	b=fjAYAPvqhlTqnjkFmcnt1pBcZnuzFjSNa464sT3qTv+jHqgHYT9O3sSTQgv5at3PA
	 XvpbX+wqfnyX3I1M67aBOdgrtep+EDVNK2jZUccZCbikzJJ3vjZ9GPFXZj/sZHqTMv
	 ANmGJvfIfd3LPLTMhpGIP2pekn9kZ5rBGQxiKFEg+9IP2Pc5/Yr+hKVhBkaLTpSw5K
	 yVnjD5u9Rex5PPHMrhi272AtQQc004v0Y1TQHi3RbofH5IZ+9fDTUi0CEqtUwEvP6l
	 9FPB835Ux7scyyK6jt8Q4q4zfhngzSrAx5slxdl0E74Vma6Nns6AzhsUYwemE0gcoB
	 mf5F8pXdatrlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tonyb@cybernetics.com
Cc: Greg Edwards <gedwards@ddn.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "block: Fix page refcounts for unaligned buffers in __bio_release_pages()" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:27:42 -0400
Message-ID: <20240327122742.2842138-1-sashal@kernel.org>
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

The patch below does not apply to the 4.19-stable tree.
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





