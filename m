Return-Path: <linux-kernel+bounces-65606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E91854F52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183DC1C28F91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652E60EFF;
	Wed, 14 Feb 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KpOOoFhu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8mM7AYOV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KpOOoFhu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8mM7AYOV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E060DE7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930062; cv=none; b=jH+vmF3aUfMXh92n2vILj4jwR0x9DjFpUl0K7UMePFGdPLiGEsql7r/qBu71rkvq9hN+kvUl+Kph//5mtjvCXIYjiyW3gXGuAWQ3TVm/3G4RnRl45XWh+S1HgLJoFTLZRGz0Jpt8RMD8L/2t8BFXJ3JUYelYZxbQZ91hy+cABDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930062; c=relaxed/simple;
	bh=EY4uJrOv8vgQQVh5FQzoOPQNynI1GrMdv5tehKjwhZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrTwRMSdyFUCMsGIKW9ps5ZRMt8XYHwKvE9/+Dt8bn9SzNkkgniyq1CVg9/l9vbrt9UvnJbI/63iNKJTyX/6yGa8J2EweSmTgdhJ/4VqLPM7c/t7+T3OMA3s5yJtohvCN7QN4U3kstZQccDdfvTUg3kL4MSX94aKWTqRhVjU6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KpOOoFhu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8mM7AYOV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KpOOoFhu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8mM7AYOV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E76C1FD19;
	Wed, 14 Feb 2024 17:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XK6TmU+hXbwqsi+dsf3umxmeEe7QW0b6t55ktNSdV6M=;
	b=KpOOoFhuvYfq+25Mh6bBdoeH7GvbWv8AgabL7VOc1wQmWvBRymwKSBbSQjDzDfRuc/Q9Mo
	txj5A0xrdL8pqoN64tArqndeTjo6g/lWUslv//Ks8seGJAO8qR3XoAqr7WCcCxdK/h85kU
	BcflLpVREbh9rlhp7M2Y3sP/YrHAf5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XK6TmU+hXbwqsi+dsf3umxmeEe7QW0b6t55ktNSdV6M=;
	b=8mM7AYOVWw6nRhbI0vrmeuOYM3JCnE5+Zjw2UKNfuIuXA1z8eD/LkAg2BJ6dK8RTTChnpc
	CCpaNpkuhk81GvCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XK6TmU+hXbwqsi+dsf3umxmeEe7QW0b6t55ktNSdV6M=;
	b=KpOOoFhuvYfq+25Mh6bBdoeH7GvbWv8AgabL7VOc1wQmWvBRymwKSBbSQjDzDfRuc/Q9Mo
	txj5A0xrdL8pqoN64tArqndeTjo6g/lWUslv//Ks8seGJAO8qR3XoAqr7WCcCxdK/h85kU
	BcflLpVREbh9rlhp7M2Y3sP/YrHAf5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XK6TmU+hXbwqsi+dsf3umxmeEe7QW0b6t55ktNSdV6M=;
	b=8mM7AYOVWw6nRhbI0vrmeuOYM3JCnE5+Zjw2UKNfuIuXA1z8eD/LkAg2BJ6dK8RTTChnpc
	CCpaNpkuhk81GvCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 815BD13A0B;
	Wed, 14 Feb 2024 17:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gMbiHMrxzGUfMwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 14 Feb 2024 17:00:58 +0000
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
Subject: [PATCH v9 5/7] mm,page_owner: Display all stacks and their count
Date: Wed, 14 Feb 2024 18:01:55 +0100
Message-ID: <20240214170157.17530-6-osalvador@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214170157.17530-1-osalvador@suse.de>
References: <20240214170157.17530-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
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

This patch adds a new directory called 'page_owner_stacks' under
/sys/kernel/debug/, with a file called 'show_stacks' in it.
Reading from that file will show all stacks that were added by page_owner
followed by their counting, giving us a clear overview of stack <-> count
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

The seq stack_{start,next} functions will iterate through the list
stack_list in order to print all stacks.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Marco Elver <elver@google.com>
---
 mm/page_owner.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index df6a923af5de..5258a417f4d1 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -171,7 +171,13 @@ static void add_stack_record_to_list(struct stack_record *stack_record,
 
 	spin_lock_irqsave(&stack_list_lock, flags);
 	stack->next = stack_list;
-	stack_list = stack;
+	/*
+	 * This pairs with smp_load_acquire() from function
+	 * stack_start(). This guarantees that stack_start()
+	 * will see an updated stack_list before starting to
+	 * traverse the list.
+	 */
+	smp_store_release(&stack_list, stack);
 	spin_unlock_irqrestore(&stack_list_lock, flags);
 }
 
@@ -805,8 +811,90 @@ static const struct file_operations proc_page_owner_operations = {
 	.llseek		= lseek_page_owner,
 };
 
+static void *stack_start(struct seq_file *m, loff_t *ppos)
+{
+	struct stack *stack;
+
+	if (*ppos == -1UL)
+		return NULL;
+
+	if (!*ppos) {
+		/*
+		 * This pairs with smp_store_release() from function
+		 * add_stack_record_to_list(), so we get a consistent
+		 * value of stack_list.
+		 */
+		stack = smp_load_acquire(&stack_list);
+	} else {
+		stack = m->private;
+		stack = stack->next;
+	}
+
+	m->private = stack;
+
+	return stack;
+}
+
+static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
+{
+	struct stack *stack = v;
+
+	stack = stack->next;
+	*ppos = stack ? *ppos + 1 : -1UL;
+	m->private = stack;
+
+	return stack;
+}
+
+static int stack_print(struct seq_file *m, void *v)
+{
+	int i;
+	struct stack *stack = v;
+	unsigned long *entries;
+	unsigned long nr_entries;
+	struct stack_record *stack_record = stack->stack_record;
+
+	nr_entries = stack_record->size;
+	entries = stack_record->entries;
+
+	if (!nr_entries || nr_entries < 0 ||
+	    refcount_read(&stack_record->count) < 2)
+		return 0;
+
+	for (i = 0; i < nr_entries; i++)
+		seq_printf(m, " %pS\n", (void *)entries[i]);
+	seq_printf(m, "stack_count: %d\n\n", refcount_read(&stack_record->count));
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
+	return seq_open_private(file, &page_owner_stack_op, 0);
+}
+
+static const struct file_operations page_owner_stack_operations = {
+	.open		= page_owner_stack_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static int __init pageowner_init(void)
 {
+	struct dentry *dir;
+
 	if (!static_branch_unlikely(&page_owner_inited)) {
 		pr_info("page_owner is disabled\n");
 		return 0;
@@ -814,6 +902,9 @@ static int __init pageowner_init(void)
 
 	debugfs_create_file("page_owner", 0400, NULL, NULL,
 			    &proc_page_owner_operations);
+	dir = debugfs_create_dir("page_owner_stacks", NULL);
+	debugfs_create_file("show_stacks", 0400, dir, NULL,
+			    &page_owner_stack_operations);
 
 	return 0;
 }
-- 
2.43.0


