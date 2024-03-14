Return-Path: <linux-kernel+bounces-103431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F4787BF3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1C3B21641
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C01A71723;
	Thu, 14 Mar 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hvlaeK3C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mCyeGHiM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hvlaeK3C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mCyeGHiM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8570CC5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427595; cv=none; b=MD5HxRobQNwZ/21g7QEDY4fCIDBLNRacT57neFsUr7g/JPiBdL4qoR6l1an64XQZr6RB+ls1pm1Ic6tQm6QyKPaEmdvSkapGxpG+xsKDUK3RhzPoJQX00QK8AYv38qYNnL7zV/VbTw8XDkwlSoF61sVbrwwTC81zY38FTLXZdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427595; c=relaxed/simple;
	bh=DeDMYoJuNZzuTccpFWlhAKRrfDaEpF6SQ2jqX8G4+t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmvMDk0irkHf1eMr6vYggP5G+d2L/bxumIrQMbPqd4v2zlQShs/heAXl5UhqDH4QstoK8oTR47ZSgijTfaNpyGI6rXOdbiZq+CBHWOk8M1lItbAXacOTMsy4va7vVzEtgd5XH2j9eUiqvJMPTbbAbCzkohMHMvF8tWVtek8tM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hvlaeK3C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mCyeGHiM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hvlaeK3C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mCyeGHiM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 469E321CEA;
	Thu, 14 Mar 2024 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710427591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w/ycXScRm0VEq6f0SxrNdSAEjpI6zCLOzkIxFpkyyFE=;
	b=hvlaeK3Cr6vFSGqH4VmQyscRGbrk7hakpsBrj10jkaiynptTMpBRbZ/5aa+/sROncSURpg
	b64yzx8MarHULW81NUTgawwTshbo71tof3N8tFUZPd9oTsxfNE3O97Wfj6z0U1d34cVYnS
	8yFCRr+oSg+2AeJ12VqP9pFcCKnTj3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710427591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w/ycXScRm0VEq6f0SxrNdSAEjpI6zCLOzkIxFpkyyFE=;
	b=mCyeGHiMRA9mpVFhGedxilqnfxP3ZNzRiRD3Ar6DNG0nxmB/gbbQhPwYzxXLJQ9WGZKie8
	A2nxQVsCdblUZJBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710427591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w/ycXScRm0VEq6f0SxrNdSAEjpI6zCLOzkIxFpkyyFE=;
	b=hvlaeK3Cr6vFSGqH4VmQyscRGbrk7hakpsBrj10jkaiynptTMpBRbZ/5aa+/sROncSURpg
	b64yzx8MarHULW81NUTgawwTshbo71tof3N8tFUZPd9oTsxfNE3O97Wfj6z0U1d34cVYnS
	8yFCRr+oSg+2AeJ12VqP9pFcCKnTj3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710427591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w/ycXScRm0VEq6f0SxrNdSAEjpI6zCLOzkIxFpkyyFE=;
	b=mCyeGHiMRA9mpVFhGedxilqnfxP3ZNzRiRD3Ar6DNG0nxmB/gbbQhPwYzxXLJQ9WGZKie8
	A2nxQVsCdblUZJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD3B91368C;
	Thu, 14 Mar 2024 14:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8BCEK8YN82WIHAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 14 Mar 2024 14:46:30 +0000
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
Subject: [PATCH] mm,page_owner: Fix refcount imbalance
Date: Thu, 14 Mar 2024 15:47:53 +0100
Message-ID: <20240314144753.16276-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hvlaeK3C;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mCyeGHiM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
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
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 469E321CEA
X-Spam-Flag: NO

Current code does not contemplate scenarios were an allocation and
free operation on the same pages do not handle it in the same amount
at once.
To give an example, page_alloc_exact(), where we will allocate a page
of enough order to stafisfy the size request, but we will free the
remainings right away.

In the above example, we will increment the stack_record refcount
only once, but we will decrease it the same number of times as number
of unused pages we have to free.
This will lead to a warning because of refcount imbalance.

Fix this by recording the number of base pages every stack_record holds,
and only let the last decrementing of refcount succeed if the number of
base pages equals 0, which means we freed all the pages.

As a bonus, show the aggregate of stack_count + base_pages as this gives
a much better picture of the memory usage.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
---
 include/linux/stackdepot.h |  3 ++
 mm/page_owner.c            | 57 +++++++++++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 3c6caa5abc7c..261472807c32 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -57,6 +57,9 @@ struct stack_record {
 	u32 size;			/* Number of stored frames */
 	union handle_parts handle;	/* Constant after initialization */
 	refcount_t count;
+#ifdef CONFIG_PAGE_OWNER
+	unsigned long nr_base_pages;
+#endif
 	union {
 		unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
 		struct {
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 50111078ecd9..5192449bb581 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -123,10 +123,14 @@ static __init void init_page_owner(void)
 	/* Initialize dummy and failure stacks and link them to stack_list */
 	dummy_stack.stack_record = __stack_depot_get_stack_record(dummy_handle);
 	failure_stack.stack_record = __stack_depot_get_stack_record(failure_handle);
-	if (dummy_stack.stack_record)
+	if (dummy_stack.stack_record) {
+		dummy_stack.stack_record->nr_base_pages = 0;
 		refcount_set(&dummy_stack.stack_record->count, 1);
-	if (failure_stack.stack_record)
+	}
+	if (failure_stack.stack_record) {
+		failure_stack.stack_record->nr_base_pages = 0;
 		refcount_set(&failure_stack.stack_record->count, 1);
+	}
 	dummy_stack.next = &failure_stack;
 	stack_list = &dummy_stack;
 }
@@ -192,9 +196,11 @@ static void add_stack_record_to_list(struct stack_record *stack_record,
 	spin_unlock_irqrestore(&stack_list_lock, flags);
 }
 
-static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask)
+static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask,
+				   unsigned long nr_base_pages)
 {
 	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
+	unsigned long curr_nr_pages;
 
 	if (!stack_record)
 		return;
@@ -209,19 +215,47 @@ static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask)
 	if (refcount_read(&stack_record->count) == REFCOUNT_SATURATED) {
 		int old = REFCOUNT_SATURATED;
 
-		if (atomic_try_cmpxchg_relaxed(&stack_record->count.refs, &old, 1))
+		if (atomic_try_cmpxchg_relaxed(&stack_record->count.refs, &old, 1)) {
 			/* Add the new stack_record to our list */
 			add_stack_record_to_list(stack_record, gfp_mask);
+			smp_store_release(&stack_record->nr_base_pages,
+					  nr_base_pages);
+			goto inc;
+		}
 	}
+
+	curr_nr_pages = smp_load_acquire(&stack_record->nr_base_pages);
+	smp_store_release(&stack_record->nr_base_pages,
+			  curr_nr_pages + nr_base_pages);
+inc:
 	refcount_inc(&stack_record->count);
 }
 
-static void dec_stack_record_count(depot_stack_handle_t handle)
+static void dec_stack_record_count(depot_stack_handle_t handle,
+				   unsigned long nr_base_pages)
 {
 	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
+	unsigned long curr_nr_pages;
+
+	if (!stack_record)
+		return;
+
+	curr_nr_pages = smp_load_acquire(&stack_record->nr_base_pages);
+	smp_store_release(&stack_record->nr_base_pages,
+			  curr_nr_pages - nr_base_pages);
+	curr_nr_pages = smp_load_acquire(&stack_record->nr_base_pages);
+
+	/*
+	 * If this stack_record is going to reach a refcount == 1, which means
+	 * free, only do it if all the base pages it allocated were freed.
+	 * E.g: scenarios like THP splitting, or alloc_pages_exact() can have
+	 * an alloc/free operation with different amount of pages
+	 */
+	if (refcount_read(&stack_record->count) == 2 &&
+	    curr_nr_pages)
+		return;
 
-	if (stack_record)
-		refcount_dec(&stack_record->count);
+	refcount_dec(&stack_record->count);
 }
 
 void __reset_page_owner(struct page *page, unsigned short order)
@@ -260,7 +294,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		 * the machinery is not ready yet, we cannot decrement
 		 * their refcount either.
 		 */
-		dec_stack_record_count(alloc_handle);
+		dec_stack_record_count(alloc_handle, 1UL << order);
 }
 
 static inline void __set_page_owner_handle(struct page_ext *page_ext,
@@ -303,7 +337,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
 	page_ext_put(page_ext);
 	set_current_in_page_owner();
-	inc_stack_record_count(handle, gfp_mask);
+	inc_stack_record_count(handle, gfp_mask, 1UL << order);
 	unset_current_in_page_owner();
 }
 
@@ -868,6 +902,7 @@ static int stack_print(struct seq_file *m, void *v)
 	struct stack *stack = v;
 	unsigned long *entries;
 	unsigned long nr_entries;
+	unsigned long nr_base_pages;
 	struct stack_record *stack_record = stack->stack_record;
 
 	if (!stack->stack_record)
@@ -875,6 +910,7 @@ static int stack_print(struct seq_file *m, void *v)
 
 	nr_entries = stack_record->size;
 	entries = stack_record->entries;
+	nr_base_pages = stack_record->nr_base_pages;
 	stack_count = refcount_read(&stack_record->count) - 1;
 
 	if (stack_count < 1 || stack_count < page_owner_stack_threshold)
@@ -882,7 +918,8 @@ static int stack_print(struct seq_file *m, void *v)
 
 	for (i = 0; i < nr_entries; i++)
 		seq_printf(m, " %pS\n", (void *)entries[i]);
-	seq_printf(m, "stack_count: %d\n\n", stack_count);
+	seq_printf(m, "stack_count: %d curr_nr_base_pages: %lu\n\n",
+		   stack_count, nr_base_pages);
 
 	return 0;
 }
-- 
2.44.0


