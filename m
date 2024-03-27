Return-Path: <linux-kernel+bounces-121002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59F288E161
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EE31C2A392
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C61581FA;
	Wed, 27 Mar 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roMZ7FX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BBF1581E7;
	Wed, 27 Mar 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541809; cv=none; b=H94/Us3hmxEtTGo2ZJBYq4HMOFNiOP3vxtv9YWwWOtcED4m5D+0NvZkCoX/Cqg2/RATE+EtSmuWAX0kJrTFqYMrTkkWs13Zcv7L/x/3ti50z3yl4I1iv/94SKmFYrrd98QTBWTT2Z2EZe9EWI5bQM7J6uFkiupTb1ivL/DDxNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541809; c=relaxed/simple;
	bh=LNJhnQdO8Zso2e4xaY8jODjBpZledxfzKRcNUaFxF0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdDl7yK3AfbIlNfN/IB+QASQluHxtEvofRz7CIviSqYh0tVojt1IDMWFYawHgoXXrEXArOMdLXNVbPCdCePd9Y94gsNQI1EY4Skfl6CdDY3Do0heohezPeXoYfjXMSJ3/UaDalBHr3QYYkrVbCQHV/tlup0Yald1RdOeyhlV/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roMZ7FX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364B6C433F1;
	Wed, 27 Mar 2024 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541808;
	bh=LNJhnQdO8Zso2e4xaY8jODjBpZledxfzKRcNUaFxF0U=;
	h=From:To:Cc:Subject:Date:From;
	b=roMZ7FX/cuk9afCeLvYtsYwaG5pIgzLirWg7RnI4d01L2rptuM/VokK5NSC/wLK0+
	 RMWi7VN9eWUYcLVQmN/2bStZnENA7k3JiB6J6xHaA5QTScXd62HSgKlyX0YGEare0v
	 2uPQGZMwkQDnH4q8/uqu97UtJsD/nm51aLL/Dl2wm9jMt85T3vi0ns/HQJdoTTuY6o
	 jfoub8Z1MuR2H/if8fKaj6tPCxdrbVB1rx6KqSUDBo172DXWNmU8fDQxOa38CBiFvR
	 5oA7ukW6lD8I2jiydWNCo8vmsWF3wV4JqFHRrh3L05VVOVuNxt1ZRI8moJgXPfCOOB
	 u+AEi+5GmldkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tonyb@cybernetics.com
Cc: Greg Edwards <gedwards@ddn.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "block: Fix page refcounts for unaligned buffers in __bio_release_pages()" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:16:47 -0400
Message-ID: <20240327121647.2832995-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
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





