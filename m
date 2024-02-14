Return-Path: <linux-kernel+bounces-65607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8959D854F53
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE8D1F2100C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BA06166A;
	Wed, 14 Feb 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zes+YGlv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="86Scdmj0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zes+YGlv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="86Scdmj0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A260EC9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930064; cv=none; b=qooR67bEb4q6Y46+LIWlBvbZMWejM/D+Xtp219zRIDd7tbQCwsmvRDpIuboN7tAiY+DVuPjbKF2T5yqV7jwW7bjK8ukA4S60IDucflEgXp3BunB3phlHoR3+4ZEzE8FW/O2k9AfEYG4BRBwigoLZhxlBsuzTZcqJYbsLrV67k0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930064; c=relaxed/simple;
	bh=MI+IeJmRaq86MzICTxaBZ0taBv1e4Xxijj8xZfxYDLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYUzPFiCDj24H0FtcuF0E5JO57luiDzHqzryymjFZSYHY84FuKxdIvXDr1b+rlmICPJ8Jix+4U+8pMN5sgqZMR+L7Ihgh6b2oG2JLMlMVadPdsaeTfB1s3ZY0O/h85S2eOtlCuCJGwmUsWiPaCQRRVclVO4OKfAB/lOX7rMF2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zes+YGlv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=86Scdmj0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zes+YGlv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=86Scdmj0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 021331FD29;
	Wed, 14 Feb 2024 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O95gSBj24arVN2KSdkLlOTusRHAm3etcuM3qAIyUVjc=;
	b=zes+YGlvv/bao0zBIXw9Zxr3DdFVNNTRtDV+b2DD6ZqBt31dljhlZLxxPY6JnRnX/dH7Xv
	lEAx+JMFrM4BvoMIy5uOjmUu716LBBjYkxy3CFeOGWBCNZNDaErMrY7hpTM+OPtX0ZDRUY
	f2rmdN5751tBiBl7y/ifA6uZR7yZV0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O95gSBj24arVN2KSdkLlOTusRHAm3etcuM3qAIyUVjc=;
	b=86Scdmj0zPg4HuR75wAYrOc+P1+yRbV5BQV4UvtPgV/1ChGWvJVWeFILHJ7iJDt92UFN0g
	gTkTbDvL+T/TvACA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O95gSBj24arVN2KSdkLlOTusRHAm3etcuM3qAIyUVjc=;
	b=zes+YGlvv/bao0zBIXw9Zxr3DdFVNNTRtDV+b2DD6ZqBt31dljhlZLxxPY6JnRnX/dH7Xv
	lEAx+JMFrM4BvoMIy5uOjmUu716LBBjYkxy3CFeOGWBCNZNDaErMrY7hpTM+OPtX0ZDRUY
	f2rmdN5751tBiBl7y/ifA6uZR7yZV0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O95gSBj24arVN2KSdkLlOTusRHAm3etcuM3qAIyUVjc=;
	b=86Scdmj0zPg4HuR75wAYrOc+P1+yRbV5BQV4UvtPgV/1ChGWvJVWeFILHJ7iJDt92UFN0g
	gTkTbDvL+T/TvACA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7536B13A0B;
	Wed, 14 Feb 2024 17:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MFb7GcvxzGUfMwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 14 Feb 2024 17:00:59 +0000
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
Subject: [PATCH v9 6/7] mm,page_owner: Filter out stacks by a threshold
Date: Wed, 14 Feb 2024 18:01:56 +0100
Message-ID: <20240214170157.17530-7-osalvador@suse.de>
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
X-Spamd-Result: default: False [3.36 / 50.00];
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
	 BAYES_HAM(-1.54)[91.97%]
X-Spam-Level: ***
X-Spam-Score: 3.36
X-Spam-Flag: NO

We want to be able to filter out the stacks based on a threshold we can
can tune.
By writing to 'count_threshold' file, we can adjust the threshold value.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_owner.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 5258a417f4d1..9b975f59b773 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -846,9 +846,11 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
 	return stack;
 }
 
+static unsigned long page_owner_stack_threshold;
+
 static int stack_print(struct seq_file *m, void *v)
 {
-	int i;
+	int i, stack_count;
 	struct stack *stack = v;
 	unsigned long *entries;
 	unsigned long nr_entries;
@@ -856,14 +858,15 @@ static int stack_print(struct seq_file *m, void *v)
 
 	nr_entries = stack_record->size;
 	entries = stack_record->entries;
+	stack_count = refcount_read(&stack_record->count);
 
-	if (!nr_entries || nr_entries < 0 ||
-	    refcount_read(&stack_record->count) < 2)
+	if (!nr_entries || nr_entries < 0 || stack_count < 2 ||
+	    stack_count < page_owner_stack_threshold)
 		return 0;
 
 	for (i = 0; i < nr_entries; i++)
 		seq_printf(m, " %pS\n", (void *)entries[i]);
-	seq_printf(m, "stack_count: %d\n\n", refcount_read(&stack_record->count));
+	seq_printf(m, "stack_count: %d\n\n", stack_count);
 
 	return 0;
 }
@@ -891,6 +894,22 @@ static const struct file_operations page_owner_stack_operations = {
 	.release	= seq_release,
 };
 
+static int page_owner_threshold_get(void *data, u64 *val)
+{
+	*val = READ_ONCE(page_owner_stack_threshold);
+	return 0;
+}
+
+static int page_owner_threshold_set(void *data, u64 val)
+{
+	WRITE_ONCE(page_owner_stack_threshold, val);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
+			&page_owner_threshold_set, "%llu");
+
+
 static int __init pageowner_init(void)
 {
 	struct dentry *dir;
@@ -905,6 +924,8 @@ static int __init pageowner_init(void)
 	dir = debugfs_create_dir("page_owner_stacks", NULL);
 	debugfs_create_file("show_stacks", 0400, dir, NULL,
 			    &page_owner_stack_operations);
+	debugfs_create_file("count_threshold", 0600, dir, NULL,
+			    &proc_page_owner_threshold);
 
 	return 0;
 }
-- 
2.43.0


