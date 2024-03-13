Return-Path: <linux-kernel+bounces-102648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38F487B54F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD4D2836B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA685D734;
	Wed, 13 Mar 2024 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i/SptgVW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wc9hKIhb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i/SptgVW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wc9hKIhb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE55B20F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373295; cv=none; b=QYOedHnWFgwdug1Gk582lQnemlJXDbZSvkm7QHxhXSJkz5EMizwg/USatDmDh33cD+qLANWe1XIJg7abpkUGaYQ/7Xuh886AG9vwAZa0dyQh1tdFJZeGchgWnHxFEx45K6ugliTp8OIxodpTE8RQ6k6DBg/+RR34VH+wdoo6TIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373295; c=relaxed/simple;
	bh=HmR8xbgP9XsPuBQuH/s+If1PSfPOE5tYMZ7iJTegv2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahU7fjjGtf+Jfo169YJh9gmk91YoXFdboHYIKNEGIjkGVJnviDzYtLU9CrnZh2Ql0GSMmMlWohFp8tzgGCCchZTCSKXD4VPP5DV/nA57oBbIspsNHuxDtlL1oRcHtcgMmt7DiNAM/dX4OG4zrEHrW9J2n7zOdP04sVqeWd3BJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i/SptgVW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wc9hKIhb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i/SptgVW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wc9hKIhb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45F391F7FA;
	Wed, 13 Mar 2024 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710373291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ngQm30aBJqnSASRUqDF9FkkVGLhh+ZhEHI6q7IEdKyE=;
	b=i/SptgVWMAhN1Vq/cMjLGtfHNVL7VjISImpVpbD4etTEpYz7Z4nOXgeuF8PxTR2KArsngN
	aKdEOEHJ3aYfEh17wonulf9aY84zUEW0u/hrxksJMx50U8QkbnUAAvDJuUIQ5NLt7OT7h4
	1ovrYlcHhHFNen6BeIf76wTyK4ga7pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710373291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ngQm30aBJqnSASRUqDF9FkkVGLhh+ZhEHI6q7IEdKyE=;
	b=wc9hKIhbDnPbCzswGaGYi/NVkVDyJ42sQRGJtGP+Mzh9KKLjosWtqiZxvDue8fqnPGnQAR
	YPu9XnWmgbGPPUBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710373291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ngQm30aBJqnSASRUqDF9FkkVGLhh+ZhEHI6q7IEdKyE=;
	b=i/SptgVWMAhN1Vq/cMjLGtfHNVL7VjISImpVpbD4etTEpYz7Z4nOXgeuF8PxTR2KArsngN
	aKdEOEHJ3aYfEh17wonulf9aY84zUEW0u/hrxksJMx50U8QkbnUAAvDJuUIQ5NLt7OT7h4
	1ovrYlcHhHFNen6BeIf76wTyK4ga7pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710373291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ngQm30aBJqnSASRUqDF9FkkVGLhh+ZhEHI6q7IEdKyE=;
	b=wc9hKIhbDnPbCzswGaGYi/NVkVDyJ42sQRGJtGP+Mzh9KKLjosWtqiZxvDue8fqnPGnQAR
	YPu9XnWmgbGPPUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5EB51397F;
	Wed, 13 Mar 2024 23:41:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +SNVKao58mVQDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 13 Mar 2024 23:41:30 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm,page_owner: Fix recursion
Date: Thu, 14 Mar 2024 00:42:45 +0100
Message-ID: <20240313234245.18824-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="i/SptgVW";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wc9hKIhb
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 1.69
X-Spam-Level: *
X-Rspamd-Queue-Id: 45F391F7FA
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Prior to 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
the only place where page_owner could potentially go into recursion due to
its need of allocating more memory was in save_stack(), which ends up calling
into stackdepot code with the possibility of allocating memory.

We made sure to guard against that by signaling that the current task was
already in page_owner code, so in case a recursion attempt was made, we
could catch that and return dummy_handle.

After above commit, a new place in page_owner code was introduced where we
could allocate memory, meaning we could go into recursion would we take that
path.

Make sure to signal that we are in page_owner in that codepath as well.
Move the guard code into two helpers {un}set_current_in_page_owner()
and use them prior to calling in the two functions that might allocate
memory.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
---
 mm/page_owner.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index e96dd9092658..60663d657f7a 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -54,6 +54,22 @@ static depot_stack_handle_t early_handle;
 
 static void init_early_allocated_pages(void);
 
+static inline void set_current_in_page_owner(void)
+{
+	/*
+	 * Avoid recursion.
+	 *
+	 * We might need to allocate more memory from page_owner code, so make
+	 * sure to signal it in order to avoid recursion.
+	 */
+	current->in_page_owner = 1;
+}
+
+static inline void unset_current_in_page_owner(void)
+{
+	current->in_page_owner = 0;
+}
+
 static int __init early_page_owner_param(char *buf)
 {
 	int ret = kstrtobool(buf, &page_owner_enabled);
@@ -133,23 +149,16 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
 	depot_stack_handle_t handle;
 	unsigned int nr_entries;
 
-	/*
-	 * Avoid recursion.
-	 *
-	 * Sometimes page metadata allocation tracking requires more
-	 * memory to be allocated:
-	 * - when new stack trace is saved to stack depot
-	 */
 	if (current->in_page_owner)
 		return dummy_handle;
-	current->in_page_owner = 1;
 
+	set_current_in_page_owner();
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
 	handle = stack_depot_save(entries, nr_entries, flags);
 	if (!handle)
 		handle = failure_handle;
+	unset_current_in_page_owner();
 
-	current->in_page_owner = 0;
 	return handle;
 }
 
@@ -232,6 +241,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	alloc_handle = page_owner->handle;
 
 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
+
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 		page_owner->free_handle = handle;
@@ -292,7 +302,9 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 		return;
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
 	page_ext_put(page_ext);
+	set_current_in_page_owner();
 	inc_stack_record_count(handle, gfp_mask);
+	unset_current_in_page_owner();
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
-- 
2.44.0


