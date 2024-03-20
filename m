Return-Path: <linux-kernel+bounces-108591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BDE880CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F071A1F22F65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1832C68A;
	Wed, 20 Mar 2024 08:07:02 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3DE8479
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922021; cv=none; b=bJgHFtSAXBNUKbQgajP9yltx95fCjCKuaUhQPVMIdkkqYFyCeGNuOfNy+YZZsEumtJbv/Teaa61sByTTKeqhtay6kaG+1QKaNhynfnY7Wj0k58IaSFKlkfUTNWbuGz0tGXH8hzgHjzN81x/4UW6jlS4ZGGTc0kPE1pJ9tQYCNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922021; c=relaxed/simple;
	bh=CPM1LdasHW1TS1I2/jcgJRTiDgvfFgizxGBHeDa3Hso=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vvm1TzSFWdnOKLGuKHDWLlriSofDIqrqpA+eaDrJfX2JNNpDzAYS2nZZb0adqk1cXL5tMIWhvKlyxFmqdB2C8YY2F0eOUh/MNd5mdSVrZChTctVyGirnUBDTTZo4G3r7A9BHylH6Peusaij2JGsHk7gH4g6h03Nmv36v/2F8P4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42K86nMg013862;
	Wed, 20 Mar 2024 17:06:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Wed, 20 Mar 2024 17:06:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42K86mdu013858
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 20 Mar 2024 17:06:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4362246e-d804-43de-800b-a7840b70919a@I-love.SAKURA.ne.jp>
Date: Wed, 20 Mar 2024 17:06:48 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING: refcount bug in __reset_page_owner
Content-Language: en-US
To: syzbot <syzbot+98c1a1753a0731df2dd4@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <000000000000015b940614004701@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000015b940614004701@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/mm/page_owner.c b/mm/page_owner.c
index e7139952ffd9..58fc7b451f75 100644
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
@@ -183,9 +184,11 @@ static void add_stack_record_to_list(struct stack_record *stack_record,
 	spin_unlock_irqrestore(&stack_list_lock, flags);
 }
 
-static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask)
+static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask,
+				   int nr_base_pages)
 {
 	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
+	int old = REFCOUNT_SATURATED;
 
 	if (!stack_record)
 		return;
@@ -197,22 +200,21 @@ static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask)
 	 * Since we do not use STACK_DEPOT_FLAG_GET API, let us
 	 * set a refcount of 1 ourselves.
 	 */
-	if (refcount_read(&stack_record->count) == REFCOUNT_SATURATED) {
-		int old = REFCOUNT_SATURATED;
-
-		if (atomic_try_cmpxchg_relaxed(&stack_record->count.refs, &old, 1))
-			/* Add the new stack_record to our list */
-			add_stack_record_to_list(stack_record, gfp_mask);
-	}
-	refcount_inc(&stack_record->count);
+	if (atomic_try_cmpxchg_relaxed(&stack_record->count.refs, &old, 1))
+		add_stack_record_to_list(stack_record, gfp_mask);
+	refcount_add(nr_base_pages, &stack_record->count);
 }
 
-static void dec_stack_record_count(depot_stack_handle_t handle)
+static void dec_stack_record_count(depot_stack_handle_t handle,
+				   int nr_base_pages)
 {
 	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
 
-	if (stack_record)
-		refcount_dec(&stack_record->count);
+	if (!stack_record)
+		return;
+
+	if (refcount_sub_and_test(nr_base_pages, &stack_record->count))
+		WARN(1, "%s refcount went to 0 for %u handle\n", __func__, handle);
 }
 
 void __reset_page_owner(struct page *page, unsigned short order)
@@ -229,7 +231,15 @@ void __reset_page_owner(struct page *page, unsigned short order)
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
@@ -250,7 +260,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		 * the machinery is not ready yet, we cannot decrement
 		 * their refcount either.
 		 */
-		dec_stack_record_count(alloc_handle);
+		dec_stack_record_count(alloc_handle, 1 << order);
 }
 
 static inline void __set_page_owner_handle(struct page_ext *page_ext,
@@ -266,6 +276,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 		page_owner->handle = handle;
 		page_owner->order = order;
 		page_owner->gfp_mask = gfp_mask;
+		page_owner->migrate_handle = 0;
 		page_owner->last_migrate_reason = -1;
 		page_owner->pid = current->pid;
 		page_owner->tgid = current->tgid;
@@ -292,7 +303,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 		return;
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
 	page_ext_put(page_ext);
-	inc_stack_record_count(handle, gfp_mask);
+	inc_stack_record_count(handle, gfp_mask, 1 << order);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
@@ -347,6 +358,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	new_page_owner->gfp_mask = old_page_owner->gfp_mask;
 	new_page_owner->last_migrate_reason =
 		old_page_owner->last_migrate_reason;
+	new_page_owner->migrate_handle = new_page_owner->handle;
 	new_page_owner->handle = old_page_owner->handle;
 	new_page_owner->pid = old_page_owner->pid;
 	new_page_owner->tgid = old_page_owner->tgid;
@@ -848,11 +860,11 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
 	return stack;
 }
 
-static unsigned long page_owner_stack_threshold;
+static unsigned long page_owner_pages_threshold;
 
 static int stack_print(struct seq_file *m, void *v)
 {
-	int i, stack_count;
+	int i, nr_base_pages;
 	struct stack *stack = v;
 	unsigned long *entries;
 	unsigned long nr_entries;
@@ -863,14 +875,14 @@ static int stack_print(struct seq_file *m, void *v)
 
 	nr_entries = stack_record->size;
 	entries = stack_record->entries;
-	stack_count = refcount_read(&stack_record->count) - 1;
+	nr_base_pages = refcount_read(&stack_record->count) - 1;
 
-	if (stack_count < 1 || stack_count < page_owner_stack_threshold)
+	if (nr_base_pages < 1 || nr_base_pages < page_owner_pages_threshold)
 		return 0;
 
 	for (i = 0; i < nr_entries; i++)
 		seq_printf(m, " %pS\n", (void *)entries[i]);
-	seq_printf(m, "stack_count: %d\n\n", stack_count);
+	seq_printf(m, "nr_base_pages: %d\n\n", nr_base_pages);
 
 	return 0;
 }
@@ -900,13 +912,13 @@ static const struct file_operations page_owner_stack_operations = {
 
 static int page_owner_threshold_get(void *data, u64 *val)
 {
-	*val = READ_ONCE(page_owner_stack_threshold);
+	*val = READ_ONCE(page_owner_pages_threshold);
 	return 0;
 }
 
 static int page_owner_threshold_set(void *data, u64 val)
 {
-	WRITE_ONCE(page_owner_stack_threshold, val);
+	WRITE_ONCE(page_owner_pages_threshold, val);
 	return 0;
 }
 


