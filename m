Return-Path: <linux-kernel+bounces-62481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAB285216E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA17BB20CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECE4F898;
	Mon, 12 Feb 2024 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U9jqloks";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TkinlWVz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U9jqloks";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TkinlWVz"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF94F20D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776975; cv=none; b=R5IxBPp9MZ5X4j/mPD+baWk2cOl1jUH7zowjPwQ73fTjp4/OOoO1Yycw0BOa1ipPG9Yg7XeESRfplHWQ4CwKd10CrPYURNx+AD/+afJBcW2eKcJZuttdOI/Rz64ZL25kCXeWh48JkNwUacYJmrVdDdINc0dpScGnzpfu3T6Smmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776975; c=relaxed/simple;
	bh=0UjzajfUgl8WMY9SKpR8JzCcqPQyXSlET4DvDtf+pFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V763CoWRG2jwKANZFZgJ3wESnIZEgS/b1r0zZTKaLR6NUH0n0Iir8AMxXgOILsMsHUqq8Ewqs893qCqfnX7MW7YfWhrbyjroQm6btVexeeTVgDkjXe+mjyAQ2DTnABHbxFVhp6Y3GJPMgj0Q5EXEjLhCEm1YUafRFBtZV/VIqbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U9jqloks; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TkinlWVz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U9jqloks; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TkinlWVz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11AA7221A6;
	Mon, 12 Feb 2024 22:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707776972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrmGvHqQzfNaShrvDguSIt1AAdF/oquPyxCU6VC3V/0=;
	b=U9jqloksGUrl/eNBRyCLYgfj6sduFcBCUrcWKDHpeXb24Ugicd6lmLa9UnYqfvX0TuXKS7
	9r60PATmtHzXICNvsY/UL9x7L2p6wP0/4TGbvNQuYcsO/8DGCByBw/voo3tYgBZwqrLSt+
	VFEJVKqBubRJKJULlxT/ymJWlRYLNiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707776972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrmGvHqQzfNaShrvDguSIt1AAdF/oquPyxCU6VC3V/0=;
	b=TkinlWVzB7+YhEp3jJr/aZNIP8VQuP4l4pvoZufo1Kr2/64XIZmKINju8djN6EKZQGdFX9
	h1A0nNQbWXysyuDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707776972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrmGvHqQzfNaShrvDguSIt1AAdF/oquPyxCU6VC3V/0=;
	b=U9jqloksGUrl/eNBRyCLYgfj6sduFcBCUrcWKDHpeXb24Ugicd6lmLa9UnYqfvX0TuXKS7
	9r60PATmtHzXICNvsY/UL9x7L2p6wP0/4TGbvNQuYcsO/8DGCByBw/voo3tYgBZwqrLSt+
	VFEJVKqBubRJKJULlxT/ymJWlRYLNiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707776972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrmGvHqQzfNaShrvDguSIt1AAdF/oquPyxCU6VC3V/0=;
	b=TkinlWVzB7+YhEp3jJr/aZNIP8VQuP4l4pvoZufo1Kr2/64XIZmKINju8djN6EKZQGdFX9
	h1A0nNQbWXysyuDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 806AE13212;
	Mon, 12 Feb 2024 22:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8F2kHMubymX5JgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Mon, 12 Feb 2024 22:29:31 +0000
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
Subject: [PATCH v8 4/5] mm,page_owner: Filter out stacks by a threshold
Date: Mon, 12 Feb 2024 23:30:28 +0100
Message-ID: <20240212223029.30769-5-osalvador@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212223029.30769-1-osalvador@suse.de>
References: <20240212223029.30769-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U9jqloks;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TkinlWVz
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
	 BAYES_HAM(-0.00)[21.10%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: 11AA7221A6
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

We want to be able to filter out the stacks based on a threshold we can
can tune.
By writing to 'set_threshold' file, we can adjust the threshold value.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_owner.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 3e4b7cd7c8f8..c4f9e5506e93 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -832,15 +832,18 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
 	return stack;
 }
 
+static unsigned long page_owner_stack_threshold;
+
 static int stack_print(struct seq_file *m, void *v)
 {
 	char *buf;
 	int ret = 0;
 	struct stack *stack = v;
 	struct stack_record *stack_record = stack->stack_record;
+	int stack_count = refcount_read(&stack_record->count);
 
 	if (!stack_record->size || stack_record->size < 0 ||
-	    refcount_read(&stack_record->count) < 2)
+	    stack_count < 2 || stack_count < page_owner_stack_threshold)
 		return 0;
 
 	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
@@ -851,7 +854,7 @@ static int stack_print(struct seq_file *m, void *v)
 		goto out;
 
 	scnprintf(buf + ret, PAGE_SIZE - ret, "stack_count: %d\n\n",
-		  refcount_read(&stack_record->count));
+		  stack_count);
 
 	seq_printf(m, buf);
 	seq_puts(m, "\n\n");
@@ -884,6 +887,21 @@ static const struct file_operations page_owner_stack_operations = {
 	.release	= seq_release,
 };
 
+static int page_owner_threshold_get(void *data, u64 *val)
+{
+	*val = page_owner_stack_threshold;
+	return 0;
+}
+
+static int page_owner_threshold_set(void *data, u64 val)
+{
+	page_owner_stack_threshold = val;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
+			&page_owner_threshold_set, "%llu");
+
 static int __init pageowner_init(void)
 {
 	struct dentry *dir;
@@ -898,6 +916,8 @@ static int __init pageowner_init(void)
 	dir = debugfs_create_dir("page_owner_stacks", NULL);
 	debugfs_create_file("show_stacks", 0400, dir, NULL,
 			    &page_owner_stack_operations);
+	debugfs_create_file("set_threshold", 0600, dir, NULL,
+			    &proc_page_owner_threshold);
 
 	return 0;
 }
-- 
2.43.0


