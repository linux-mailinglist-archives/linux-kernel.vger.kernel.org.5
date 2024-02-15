Return-Path: <linux-kernel+bounces-67722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE73856FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9FAB23382
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5BD145B11;
	Thu, 15 Feb 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OdZe2HVT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nmku8TLu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OdZe2HVT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nmku8TLu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2466145340
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034287; cv=none; b=cHgNZjJBLvLbhXeBzsHHw4JIbhlKCG5Wm6VoF8r9rTl9wzMk1wBoAdqg5dUQKWnUa9xWluUbJDkKkcoE2tVaHtRq8Yl8Hiba79OoQib+JTkSjFVYxHYkyfu4RwAEXk3tZtbHJKvmIyrWBb8esOp3TsDtRG85xwYpRwEDqoFO254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034287; c=relaxed/simple;
	bh=Bjv6L8CpXpR+FN9AP+0tDlizUSzzE8TOqCyxhbE02AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGBeChi5TY1vSIxW6Smz3/vyraLQKuwCGcn4ZaeNCyBqXhXfA8Pid73GZU8u49W6zRMRScySCqOTel4udOl3SiWDe/Xj+6q8iXG+A+c/tXVxo/2ka8zZpCZbD8ZiQSzaGZDH02UTXW26NO8FZfR6qKBE99Uink0U4tO5Pu9IVzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OdZe2HVT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nmku8TLu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OdZe2HVT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nmku8TLu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09430220A6;
	Thu, 15 Feb 2024 21:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708034284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcxp99FnLp1RnVVp7F0RPZtIZa/+vMDeTxogq7yX6CE=;
	b=OdZe2HVToKR+dXod4mHXxxhQTyYmVE8e7iPBXbqfOUzVljTJpGs5Ga/r/LStLFWk2J7mPa
	1sTa/uWN++cLaozklVYWtu1zJCOX+GVAlFVB3XEFsWLBKiEAptEJzMae/h5Ln+0lxFSISK
	BA4DYYqmjAPMrkAX4JTW2lh3xKsVfE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708034284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcxp99FnLp1RnVVp7F0RPZtIZa/+vMDeTxogq7yX6CE=;
	b=Nmku8TLuOVciMQqnVySHUqlbN4Yj+dlteZY+KFFJIRTwfSVWGNKbHU89jXYC10ZWs3n3Vi
	x2zhcwY5hjJikZBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708034284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcxp99FnLp1RnVVp7F0RPZtIZa/+vMDeTxogq7yX6CE=;
	b=OdZe2HVToKR+dXod4mHXxxhQTyYmVE8e7iPBXbqfOUzVljTJpGs5Ga/r/LStLFWk2J7mPa
	1sTa/uWN++cLaozklVYWtu1zJCOX+GVAlFVB3XEFsWLBKiEAptEJzMae/h5Ln+0lxFSISK
	BA4DYYqmjAPMrkAX4JTW2lh3xKsVfE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708034284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcxp99FnLp1RnVVp7F0RPZtIZa/+vMDeTxogq7yX6CE=;
	b=Nmku8TLuOVciMQqnVySHUqlbN4Yj+dlteZY+KFFJIRTwfSVWGNKbHU89jXYC10ZWs3n3Vi
	x2zhcwY5hjJikZBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AAD51346A;
	Thu, 15 Feb 2024 21:58:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GIBCG+uIzmXPAQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 15 Feb 2024 21:58:03 +0000
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
Subject: [PATCH v10 3/7] mm,page_owner: Maintain own list of stack_records structs
Date: Thu, 15 Feb 2024 22:59:03 +0100
Message-ID: <20240215215907.20121-4-osalvador@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215215907.20121-1-osalvador@suse.de>
References: <20240215215907.20121-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

page_owner needs to increment a stack_record refcount when a new allocation
occurs, and decrement it on a free operation.
In order to do that, we need to have a way to get a stack_record from a
handle.
Implement __stack_depot_get_stack_record() which just does that, and make
it public so page_owner can use it.

Also, traversing all stackdepot buckets comes with its own complexity,
plus we would have to implement a way to mark only those stack_records
that were originated from page_owner, as those are the ones we are
interested in.
For that reason, page_owner maintains its own list of stack_records,
because traversing that list is faster than traversing all buckets
while keeping at the same time a low complexity.

For now, add to stack_list only the stack_records of dummy_handle and
failure_handle, and set their refcount of 1.

Further patches will add code to increment or decrement stack_records
count on allocation and free operation.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Marco Elver <elver@google.com>
---
 include/linux/stackdepot.h | 11 +++++++++++
 lib/stackdepot.c           |  8 ++++++++
 mm/page_owner.c            | 15 +++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index c4b5ad57c066..3c6caa5abc7c 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -178,6 +178,17 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
+/**
+ * __stack_depot_get_stack_record - Get a pointer to a stack_record struct
+ *
+ * @handle: Stack depot handle
+ *
+ * This function is only for internal purposes.
+ *
+ * Return: Returns a pointer to a stack_record struct
+ */
+struct stack_record *__stack_depot_get_stack_record(depot_stack_handle_t handle);
+
 /**
  * stack_depot_fetch - Fetch a stack trace from stack depot
  *
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 514b8d40ff57..8c795bb20afb 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -687,6 +687,14 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
 
+struct stack_record *__stack_depot_get_stack_record(depot_stack_handle_t handle)
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
index 5634e5d890f8..33e342b15d9b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -36,6 +36,14 @@ struct page_owner {
 	pid_t free_tgid;
 };
 
+struct stack {
+	struct stack_record *stack_record;
+	struct stack *next;
+};
+static struct stack dummy_stack;
+static struct stack failure_stack;
+static struct stack *stack_list;
+
 static bool page_owner_enabled __initdata;
 DEFINE_STATIC_KEY_FALSE(page_owner_inited);
 
@@ -95,6 +103,13 @@ static __init void init_page_owner(void)
 	register_early_stack();
 	static_branch_enable(&page_owner_inited);
 	init_early_allocated_pages();
+	/* Initialize dummy and failure stacks and link them to stack_list */
+	dummy_stack.stack_record = __stack_depot_get_stack_record(dummy_handle);
+	failure_stack.stack_record = __stack_depot_get_stack_record(failure_handle);
+	refcount_set(&dummy_stack.stack_record->count, 1);
+	refcount_set(&failure_stack.stack_record->count, 1);
+	dummy_stack.next = &failure_stack;
+	stack_list = &dummy_stack;
 }
 
 struct page_ext_operations page_owner_ops = {
-- 
2.43.0


