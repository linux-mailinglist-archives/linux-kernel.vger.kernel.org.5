Return-Path: <linux-kernel+bounces-121268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB3588E485
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D730D1C2BD95
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7B7142E75;
	Wed, 27 Mar 2024 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNiZ24oC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFED1B6FB6;
	Wed, 27 Mar 2024 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542509; cv=none; b=eZxkG0yPvBR/F3fq8127EW8/1ihRsGHzz6cE433XciytRiX2ds52Ot9OkdoOI5wCpW4sysAz6g5fQzAG6u192bPUUNOVERLlOyk7A5CmUsN5eOIABWMgpqRsfkGfoZBKUgCjjXZNLRph5nQZon4lJA0O6uY6fZyvlKeZYBO8CW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542509; c=relaxed/simple;
	bh=qILXJDfEFX4ZvfUyQtQSZ91X4eaPsw7idazy43hhUPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Asy7YTvOlpp5895dvIYzMEgITh9MKnF1OzV8tKHga+EZhkkDtn34cPn0eYIGbY2CYalK82kNcjSh0z74B5mWmrZxWtUTsuxfuDfIZvFfGRqBDo8ETBFgqhwSz9AWU8qQ5gRz/YLuF7KSwtR0hXqxA7B9nQObOxOZQSlx59F8QvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNiZ24oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E61C433C7;
	Wed, 27 Mar 2024 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542509;
	bh=qILXJDfEFX4ZvfUyQtQSZ91X4eaPsw7idazy43hhUPg=;
	h=From:To:Cc:Subject:Date:From;
	b=lNiZ24oCexiEmuZ7PM4dYQS+I56/lo+Uw07F2cmNzaukPJG2NbpgPjMH1HRYDpZHU
	 kDe+YUFoQMQTXCSqx0qzBmfWUYFbtMz7ZFod0noZ/KBHHuXr5nDNibZAFJjzSrjg15
	 K+sKnpQUAKml6ww21l0YLG8GDjAhyka0m060OnLbC2mkUTmWED6Hmgr0ZtIWwyUw6V
	 XcAdMLTOy6tas0dVCb8CsPHKeVwuJRChZxM/CEntlvyKAAM/+dCQzPHQH0F3QAENcp
	 v4Jfa1yesBGVVwXaDRmv4HSfO7SszkNlw43ULMgPHbdemQ1xBgEuTUzXmqSBKqed+C
	 f7Yyl6TjP0Cjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mpatocka@redhat.com
Cc: John Pittman <jpittman@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "dm snapshot: fix lockup in dm_exception_table_exit" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:28:27 -0400
Message-ID: <20240327122827.2842757-1-sashal@kernel.org>
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

From 6e7132ed3c07bd8a6ce3db4bb307ef2852b322dc Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 20 Mar 2024 18:43:11 +0100
Subject: [PATCH] dm snapshot: fix lockup in dm_exception_table_exit

There was reported lockup when we exit a snapshot with many exceptions.
Fix this by adding "cond_resched" to the loop that frees the exceptions.

Reported-by: John Pittman <jpittman@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-snap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index bf7a574499a34..0ace06d1bee38 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -684,8 +684,10 @@ static void dm_exception_table_exit(struct dm_exception_table *et,
 	for (i = 0; i < size; i++) {
 		slot = et->table + i;
 
-		hlist_bl_for_each_entry_safe(ex, pos, n, slot, hash_list)
+		hlist_bl_for_each_entry_safe(ex, pos, n, slot, hash_list) {
 			kmem_cache_free(mem, ex);
+			cond_resched();
+		}
 	}
 
 	kvfree(et->table);
-- 
2.43.0





