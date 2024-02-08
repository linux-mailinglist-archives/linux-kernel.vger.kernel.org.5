Return-Path: <linux-kernel+bounces-58880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB284EE06
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744CF1F24929
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D49551C56;
	Thu,  8 Feb 2024 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hY9JCYvA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p5HZ5uBZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hY9JCYvA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p5HZ5uBZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683EB5101E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435919; cv=none; b=TK5JoUjnSZ1zjdxo+HIfyQl3wkDCcUB5NJWXi8a8mpBCiBR8XTbXwT31HUt9GwsZFORFlvrvXb0x3HeuJH5HiCq4IeXM1mtAJABFZzuN1fLjVyT2rg0yUvI1/hL0M7oOZkYLYIBucBhaxHSSp/BvO82V/lofJ8OWRXMOREMnS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435919; c=relaxed/simple;
	bh=vD+uDbcZd1nUQSYd7TnT05L2X2yMg5F/ZdZDImKbnS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7NUL4oEwN7ssndHREhCFuQnUcryDuWIPfmn+HlG83NBo62fiSQ/1bvG6bMMnT+0rtuxpbryrP26ayg56o9laPEMeZ2j0qU1NQwL3DN6wqUE7qnfXYDShqqXzuWqQdSk7CcwYuZCocn3BwpsMPQ5oxFbGDixI9UNXWYtwy+MJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hY9JCYvA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p5HZ5uBZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hY9JCYvA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p5HZ5uBZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A783422317;
	Thu,  8 Feb 2024 23:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707435915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RIuerYMWRH7Xo5xR9Dr7KugCllJ88k2PizonkIPXIU=;
	b=hY9JCYvAncAGepUu81hefJSrPIqWxz/6UK81x78gggd7DefAzQkSaFtX/UeMHzsUrsprWg
	UnkgoUNyQrDRszamEUWOuLhaRRJBjVfAf5YiWMHqvwRf62A7ru9jv/bv/vvDNy+oUMNH+u
	QAu0UK+6FYmPjn6QLgfthVizcCiWcww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707435915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RIuerYMWRH7Xo5xR9Dr7KugCllJ88k2PizonkIPXIU=;
	b=p5HZ5uBZO2fi/Vl014Q4Qrb0lax8dsjC8lQ2L5wn/MAUf37MHid3+N7LFaSZ6Sd95BS7TW
	b1gGtfcxLmlURUDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707435915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RIuerYMWRH7Xo5xR9Dr7KugCllJ88k2PizonkIPXIU=;
	b=hY9JCYvAncAGepUu81hefJSrPIqWxz/6UK81x78gggd7DefAzQkSaFtX/UeMHzsUrsprWg
	UnkgoUNyQrDRszamEUWOuLhaRRJBjVfAf5YiWMHqvwRf62A7ru9jv/bv/vvDNy+oUMNH+u
	QAu0UK+6FYmPjn6QLgfthVizcCiWcww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707435915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RIuerYMWRH7Xo5xR9Dr7KugCllJ88k2PizonkIPXIU=;
	b=p5HZ5uBZO2fi/Vl014Q4Qrb0lax8dsjC8lQ2L5wn/MAUf37MHid3+N7LFaSZ6Sd95BS7TW
	b1gGtfcxLmlURUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BB6413984;
	Thu,  8 Feb 2024 23:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WI3VA4tnxWWUfAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 08 Feb 2024 23:45:15 +0000
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
Subject: [PATCH v7 3/4] mm,page_owner: Display all stacks and their count
Date: Fri,  9 Feb 2024 00:45:38 +0100
Message-ID: <20240208234539.19113-4-osalvador@suse.de>
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
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

This patch adds a new file called 'page_owner_stacks', which
will show all stacks that were added by page_owner followed by
their counting, giving us a clear overview of stack <-> count
relationship.

E.g:

  prep_new_page+0xa9/0x120
  get_page_from_freelist+0x801/0x2210
  __alloc_pages+0x18b/0x350
  alloc_pages_mpol+0x91/0x1f0
  folio_alloc+0x14/0x50
  filemap_alloc_folio+0xb2/0x100
  __filemap_get_folio+0x14a/0x490
  ext4_write_begin+0xbd/0x4b0 [ext4]
  generic_perform_write+0xc1/0x1e0
  ext4_buffered_write_iter+0x68/0xe0 [ext4]
  ext4_file_write_iter+0x70/0x740 [ext4]
  vfs_write+0x33d/0x420
  ksys_write+0xa5/0xe0
  do_syscall_64+0x80/0x160
  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 stack_count: 4578

In order to show all the stacks, we implement stack_depot_get_next_stack(),
which walks all buckets while retrieving the stacks stored in them.
stack_depot_get_next_stack() will return all stacks, one at a time,
by first finding a non-empty bucket, and then retrieving all the stacks
stored in that bucket.
Once we have completely gone through it, we get the next non-empty bucket
and repeat the same steps, and so on until we have completely checked all
buckets.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h | 20 +++++++++
 lib/stackdepot.c           | 46 +++++++++++++++++++++
 mm/page_owner.c            | 85 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index ac62de4d4999..d851ec821e6f 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -183,6 +183,26 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
  */
 struct stack_record *stack_depot_get_stack(depot_stack_handle_t handle);
 
+/**
+ * stack_depot_get_next_stack - Returns all stacks, one at a time
+ *
+ * @table:	Current table we are checking
+ * @bucket:	Current bucket we are checking
+ * @last_found:	Last stack that was found
+ *
+ * This function finds first a non-empty bucket and returns the first stack
+ * stored in it. On consequent calls, it walks the bucket to see whether
+ * it contains more stacks.
+ * Once we have walked all the stacks in a bucket, we check
+ * the next one, and we repeat the same steps until we have checked all of them
+ *
+ * Return: A pointer a to stack_record struct, or NULL when we have walked all
+ * buckets.
+ */
+struct stack_record *stack_depot_get_next_stack(unsigned long *table,
+						struct list_head **bucket,
+						struct stack_record **last_found);
+
 /**
  * stack_depot_fetch - Fetch a stack trace from stack depot
  *
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 197c355601f9..107bd0174cd6 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -782,6 +782,52 @@ unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
 }
 EXPORT_SYMBOL(stack_depot_get_extra_bits);
 
+struct stack_record *stack_depot_get_next_stack(unsigned long *table,
+						struct list_head **curr_bucket,
+						struct stack_record **last_found)
+{
+	struct list_head *bucket = *curr_bucket;
+	unsigned long nr_table = *table;
+	struct stack_record *found = NULL;
+	unsigned long stack_table_entries = stack_hash_mask + 1;
+
+	rcu_read_lock_sched_notrace();
+	if (!bucket) {
+		/*
+		 * Find a non-empty bucket. Once we have found it,
+		 * we will use list_for_each_entry_continue_rcu() on the next
+		 * call to keep walking the bucket.
+		 */
+new_table:
+		bucket = &stack_table[nr_table];
+		list_for_each_entry_rcu(found, bucket, hash_list) {
+			goto out;
+		}
+	} else {
+		 /* Check whether we have more stacks in this bucket */
+		found = *last_found;
+		list_for_each_entry_continue_rcu(found, bucket, hash_list) {
+			goto out;
+		}
+	}
+
+	/* No more stacks in this bucket, check the next one */
+	nr_table++;
+	if (nr_table < stack_table_entries)
+		goto new_table;
+
+	/* We are done walking all buckets */
+	found = NULL;
+
+out:
+	*table = nr_table;
+	*curr_bucket = bucket;
+	*last_found = found;
+	rcu_read_unlock_sched_notrace();
+
+	return found;
+}
+
 static int stats_show(struct seq_file *seq, void *v)
 {
 	/*
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 0adf41702b9d..aea212734557 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -749,6 +749,89 @@ static const struct file_operations proc_page_owner_operations = {
 	.llseek		= lseek_page_owner,
 };
 
+struct stack_iterator {
+	unsigned long nr_table;
+	struct list_head *bucket;
+	struct stack_record *last_stack;
+};
+
+static void *stack_start(struct seq_file *m, loff_t *ppos)
+{
+	struct stack_iterator *iter = m->private;
+
+	if (*ppos == -1UL)
+		return NULL;
+
+	return stack_depot_get_next_stack(&iter->nr_table,
+					  &iter->bucket,
+					  &iter->last_stack);
+}
+
+static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
+{
+	struct stack_iterator *iter = m->private;
+	struct stack_record *stack;
+
+	stack = stack_depot_get_next_stack(&iter->nr_table,
+					   &iter->bucket,
+					   &iter->last_stack);
+	*ppos = stack ? *ppos + 1 : -1UL;
+
+	return stack;
+}
+
+static int stack_print(struct seq_file *m, void *v)
+{
+	char *buf;
+	int ret = 0;
+	struct stack_iterator *iter = m->private;
+	struct stack_record *stack = iter->last_stack;
+
+	if (!stack->size || stack->size < 0 || refcount_read(&stack->count) < 2)
+		return 0;
+
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+
+	ret += stack_trace_snprint(buf, PAGE_SIZE, stack->entries, stack->size,
+				   0);
+	if (!ret)
+		goto out;
+
+	scnprintf(buf + ret, PAGE_SIZE - ret, "stack_count: %d\n\n",
+		  refcount_read(&stack->count));
+
+	seq_printf(m, buf);
+	seq_puts(m, "\n\n");
+out:
+	kfree(buf);
+
+	return 0;
+}
+
+static void stack_stop(struct seq_file *m, void *v)
+{
+}
+
+static const struct seq_operations page_owner_stack_op = {
+	.start	= stack_start,
+	.next	= stack_next,
+	.stop	= stack_stop,
+	.show	= stack_print
+};
+
+static int page_owner_stack_open(struct inode *inode, struct file *file)
+{
+	return seq_open_private(file, &page_owner_stack_op,
+				sizeof(struct stack_iterator));
+}
+
+const struct file_operations page_owner_stack_operations = {
+	.open		= page_owner_stack_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static int __init pageowner_init(void)
 {
 	if (!static_branch_unlikely(&page_owner_inited)) {
@@ -758,6 +841,8 @@ static int __init pageowner_init(void)
 
 	debugfs_create_file("page_owner", 0400, NULL, NULL,
 			    &proc_page_owner_operations);
+	debugfs_create_file("page_owner_stacks", 0400, NULL, NULL,
+			    &page_owner_stack_operations);
 
 	return 0;
 }
-- 
2.43.0


