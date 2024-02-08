Return-Path: <linux-kernel+bounces-58879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF784EE04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6713E1C25A4F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA4851C3B;
	Thu,  8 Feb 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZwBUTcSH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P94itunw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZwBUTcSH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P94itunw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980750A6D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435918; cv=none; b=S6MVCsvxanm5VPbdWYQD8ViuxcSlNmpuQrLZQSxOeIBpU7tiYMNcQaERy7VEodSrPtJTrHjmceKOn16+Hu+MW35Px6Oj5f5zFj/YXkMjb7/7cub+5FS0b0irrVV+W4VncTGQUSdSCc4+vLXZv0tL0fd76e2TNwGkJ5d5feHU0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435918; c=relaxed/simple;
	bh=SZfyzV7sF3kLKFjE9KI/KE075YQWak/Z7IHyRZhnK50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYk7u5NECDMcAzJDhyzZvSyC6p67BSHvmO6/SgIbEuJ12TIZqMe65NnsHRwAWlBltDRiMu6Qir44bc7rgwMZC0THrnZN7r8MpOJU3jYY3PpWhhzzbI5QpIz0A65BZJHWdmCdRtVqB3fFVR80OrCqULQ6lirG2rlah2CnwL0ZkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZwBUTcSH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P94itunw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZwBUTcSH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P94itunw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0223922315;
	Thu,  8 Feb 2024 23:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707435914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOtnmJyjTMio6JnPiONHFMtYXU8AmDD2FzaIP6UxlE0=;
	b=ZwBUTcSH+yLhiMahPKyOuS6osd4fSVbDvSv0ya9UGW8LetG88/d1KWoq3atCJvOX06Hwzy
	xBwNVvWy/AX19x6X2g6vJmpbvfXHPxyd/hbLKimF1aN1lbKPslwvtSlUR1c71B5sF9gdOZ
	4zAFuPrZgEa8zf1XjkjfiZ8IofdJMc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707435914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOtnmJyjTMio6JnPiONHFMtYXU8AmDD2FzaIP6UxlE0=;
	b=P94itunwwRNbkd3dZY3MmvmKcwBH9vGwln8BkDZ7EFifY/wZ5ri9E0MFoYpFJKTDwXvZyN
	KTNeSOR1XY3gdoCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707435914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOtnmJyjTMio6JnPiONHFMtYXU8AmDD2FzaIP6UxlE0=;
	b=ZwBUTcSH+yLhiMahPKyOuS6osd4fSVbDvSv0ya9UGW8LetG88/d1KWoq3atCJvOX06Hwzy
	xBwNVvWy/AX19x6X2g6vJmpbvfXHPxyd/hbLKimF1aN1lbKPslwvtSlUR1c71B5sF9gdOZ
	4zAFuPrZgEa8zf1XjkjfiZ8IofdJMc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707435914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOtnmJyjTMio6JnPiONHFMtYXU8AmDD2FzaIP6UxlE0=;
	b=P94itunwwRNbkd3dZY3MmvmKcwBH9vGwln8BkDZ7EFifY/wZ5ri9E0MFoYpFJKTDwXvZyN
	KTNeSOR1XY3gdoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6076D13984;
	Thu,  8 Feb 2024 23:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ODavFIlnxWWUfAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 08 Feb 2024 23:45:13 +0000
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
Subject: [PATCH v7 2/4] mm,page_owner: Implement the tracking of the stacks count
Date: Fri,  9 Feb 2024 00:45:37 +0100
Message-ID: <20240208234539.19113-3-osalvador@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208234539.19113-1-osalvador@suse.de>
References: <20240208234539.19113-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZwBUTcSH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P94itunw
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 0223922315
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

page_owner needs to increment a stack_record refcount when a new allocation
occurs, and decrement it on a free operation.
In order to do that, we need to have a way to get a stack_record from a
handle.
Implement stack_depot_get_stack() which just does that, and make it public
so page_owner can use it.

Also implement {inc,dec}_stack_record_count() which increments
or decrements on respective allocation and free operations, via
__reset_page_owner() (free operation) and __set_page_owner() (alloc
operation).

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h |  8 ++++++++
 lib/stackdepot.c           |  8 ++++++++
 mm/page_owner.c            | 30 ++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index d0dcf4aebfb4..ac62de4d4999 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -175,6 +175,14 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
+/**
+ * stack_depo_get_stack - Get a pointer to a stack struct
+ * @handle: Stack depot handle
+ *
+ * Return: Returns a pointer to a stack struct
+ */
+struct stack_record *stack_depot_get_stack(depot_stack_handle_t handle);
+
 /**
  * stack_depot_fetch - Fetch a stack trace from stack depot
  *
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 16c8a1bf0008..197c355601f9 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -681,6 +681,14 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
 
+struct stack_record *stack_depot_get_stack(depot_stack_handle_t handle)
+{
+	if (!handle)
+		return NULL;
+
+	return depot_fetch_stack(handle);
+}
+
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 5634e5d890f8..0adf41702b9d 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -61,6 +61,22 @@ static __init bool need_page_owner(void)
 	return page_owner_enabled;
 }
 
+static void inc_stack_record_count(depot_stack_handle_t handle)
+{
+	struct stack_record *stack = stack_depot_get_stack(handle);
+
+	if (stack)
+		refcount_inc(&stack->count);
+}
+
+static void dec_stack_record_count(depot_stack_handle_t handle)
+{
+	struct stack_record *stack = stack_depot_get_stack(handle);
+
+	if (stack)
+		refcount_dec(&stack->count);
+}
+
 static __always_inline depot_stack_handle_t create_dummy_stack(void)
 {
 	unsigned long entries[4];
@@ -140,6 +156,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	int i;
 	struct page_ext *page_ext;
 	depot_stack_handle_t handle;
+	depot_stack_handle_t alloc_handle;
 	struct page_owner *page_owner;
 	u64 free_ts_nsec = local_clock();
 
@@ -147,6 +164,9 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	if (unlikely(!page_ext))
 		return;
 
+	page_owner = get_page_owner(page_ext);
+	alloc_handle = page_owner->handle;
+
 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
@@ -158,6 +178,15 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		page_ext = page_ext_next(page_ext);
 	}
 	page_ext_put(page_ext);
+	if (alloc_handle != early_handle)
+		/*
+		 * early_handle is being set as a handle for all those
+		 * early allocated pages. See init_pages_in_zone().
+		 * Since their refcount is not being incremented because
+		 * the machinery is not ready yet, we cannot decrement
+		 * their refcount either.
+		 */
+		dec_stack_record_count(alloc_handle);
 }
 
 static inline void __set_page_owner_handle(struct page_ext *page_ext,
@@ -199,6 +228,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 		return;
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
 	page_ext_put(page_ext);
+	inc_stack_record_count(handle);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
-- 
2.43.0


