Return-Path: <linux-kernel+bounces-108019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E358804DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE724B2214B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5839FDA;
	Tue, 19 Mar 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pfjDOKf1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BoyQKkry";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pfjDOKf1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BoyQKkry"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E339AFD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873063; cv=none; b=rrhgY/Rxj5z0TSZu31sDXjFGZ59+PvCOf19LyLlFJ14lRWPsTJkjqqu5wQlxPBBJ7UMuuWQM1vMPhwq8QARKOs5HadNiITXcV0Q/Sd8ccBabwp6sOMWLbm3j2bJHsvjocZ5jYlFdW9amHelh3nMk27xY/sZhupIA6KbYBrMdkyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873063; c=relaxed/simple;
	bh=qGQrjhl3pdfcRNgDLGE+gYvkhJuPThiXBxTUsgf3JTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEXc3rd6boJSZQFgnze2hmihSfVSaDKsaW/cPHNyI3bzdVhtSEGxR+bz234atu9NwMDkLVFQVvCkNZ7Gf7GYyq5dhxwXxU6NAx6xN2tVkKxURbZGNVjq8/5DnhSxrDuM7T5qPy3MJiDnBPY90qJHbsGjYHvS3AaSBY6AfQfdzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pfjDOKf1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BoyQKkry; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pfjDOKf1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BoyQKkry; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45A201F796;
	Tue, 19 Mar 2024 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710873060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBBDN69VSXz+frM1TA/lUSR1pRpjSQYoj51jkyNzGIg=;
	b=pfjDOKf1uxzUNJ613z2gjhyKrzyrDuE8LKyTAT5UQm6rAtbuXqpqdP8UBZJz6l1MH5xLTy
	smF3WyK1+vBwfEdlPS6dnAELJcWwm1rgYNOA4mM8HwzcOocBjHNKE06257PIzdqNEpzNqF
	LRSAAF5lzHrFo/Hxb6eW4NNICqTXaJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710873060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBBDN69VSXz+frM1TA/lUSR1pRpjSQYoj51jkyNzGIg=;
	b=BoyQKkryctPqM+pUgEPoLlD4178P6d2phPz0yy86fhQEV6syMeGv4jT7b9hWlsYTd8Nmyf
	SCesS3h7e8TtulCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710873060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBBDN69VSXz+frM1TA/lUSR1pRpjSQYoj51jkyNzGIg=;
	b=pfjDOKf1uxzUNJ613z2gjhyKrzyrDuE8LKyTAT5UQm6rAtbuXqpqdP8UBZJz6l1MH5xLTy
	smF3WyK1+vBwfEdlPS6dnAELJcWwm1rgYNOA4mM8HwzcOocBjHNKE06257PIzdqNEpzNqF
	LRSAAF5lzHrFo/Hxb6eW4NNICqTXaJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710873060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBBDN69VSXz+frM1TA/lUSR1pRpjSQYoj51jkyNzGIg=;
	b=BoyQKkryctPqM+pUgEPoLlD4178P6d2phPz0yy86fhQEV6syMeGv4jT7b9hWlsYTd8Nmyf
	SCesS3h7e8TtulCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A91941376B;
	Tue, 19 Mar 2024 18:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wBWfJuPZ+WUcTwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 19 Mar 2024 18:30:59 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/2] mm,page_owner: Fix accounting of pages when migrating
Date: Tue, 19 Mar 2024 19:32:12 +0100
Message-ID: <20240319183212.17156-3-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319183212.17156-1-osalvador@suse.de>
References: <20240319183212.17156-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pfjDOKf1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BoyQKkry
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.48 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLdcskf45ysppnb91ss91phck9)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[46.42%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,i-love.sakura.ne.jp,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 3.48
X-Rspamd-Queue-Id: 45A201F796
X-Spam-Flag: NO

Upon migration, new allocated pages are being given the handle of the old
pages. This is problematic because it means that for the stack which
allocated the old page, we will be substracting the old page + the new one
when that page is freed, creating an accounting imbalance.

Fix this by adding a new migrate_handle in the page_owner struct, and
record the handle that allocated the new page in __folio_copy_owner().
Upon freeing, we check whether we have a migrate_handle, and if we do,
we use migrate_handle for dec_stack_record_count(), which will
subtract those pages from its right handle.

Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_owner.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2613805cb665..1a7d0d1dc640 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -27,6 +27,7 @@ struct page_owner {
 	gfp_t gfp_mask;
 	depot_stack_handle_t handle;
 	depot_stack_handle_t free_handle;
+	depot_stack_handle_t migrate_handle;
 	u64 ts_nsec;
 	u64 free_ts_nsec;
 	char comm[TASK_COMM_LEN];
@@ -240,7 +241,15 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		return;
 
 	page_owner = get_page_owner(page_ext);
-	alloc_handle = page_owner->handle;
+	/*
+	 * If this page was allocated for migration purposes, its handle doesn't
+	 * reference the stack it was allocated from, so make sure to use the
+	 * migrate_handle in order to subtract it from the right stack.
+	 */
+	if (!page_owner->migrate_handle)
+		alloc_handle = page_owner->handle;
+	else
+		alloc_handle = page_owner->migrate_handle;
 
 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
 	for (i = 0; i < (1 << order); i++) {
@@ -277,6 +286,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 		page_owner->handle = handle;
 		page_owner->order = order;
 		page_owner->gfp_mask = gfp_mask;
+		page_owner->migrate_handle = 0;
 		page_owner->last_migrate_reason = -1;
 		page_owner->pid = current->pid;
 		page_owner->tgid = current->tgid;
@@ -358,6 +368,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	new_page_owner->gfp_mask = old_page_owner->gfp_mask;
 	new_page_owner->last_migrate_reason =
 		old_page_owner->last_migrate_reason;
+	new_page_owner->migrate_handle = new_page_owner->handle;
 	new_page_owner->handle = old_page_owner->handle;
 	new_page_owner->pid = old_page_owner->pid;
 	new_page_owner->tgid = old_page_owner->tgid;
-- 
2.44.0


