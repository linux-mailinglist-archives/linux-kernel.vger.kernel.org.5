Return-Path: <linux-kernel+bounces-58881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C39C84EE08
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592E0B2A521
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99784524BD;
	Thu,  8 Feb 2024 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ICG5MFU6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QnlWa4ie";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ICG5MFU6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QnlWa4ie"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988051C3D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435920; cv=none; b=I+l3TRIc0QnlGEvnXdbvXKE0FVxWdJalBBy0H7lqJcMr/l3rjf3eEJN9xPv2FIcibHVQD7CzWv9JChsAZ6vzyv7ewP8WY4nv+SwSaxmqMENBm19Pq4q/hqVbNj7y5g1FubijTPjsunVGA69e5+inoi3WTgejwDXrT1Ef8QzcnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435920; c=relaxed/simple;
	bh=iZR/cSUAPw61zT2l0lvV0xr2ZHSjmz6eg0cTSrld+h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/tL3W5qxwWyPseg+Xu9aXMuZ7dTLN7MDlNsqJHnmTyhNq3UoPwF/RA1Kdb8VzIZmJkTC7XtrN/dHArovi3z2d5+iFDxWwA6MYeKGZd6f7wcmtL9I8hu59PUVbArqJvB8pUdyyZyd508/SG5RjynRXB4OzTpZ7EfRsMo1gtnQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ICG5MFU6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QnlWa4ie; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ICG5MFU6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QnlWa4ie; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 56E6F1F7AB;
	Thu,  8 Feb 2024 23:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707435917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ny8/gais+bfRbc1kxGSF6BydkfkKmZPjGNqn+J3Zwo=;
	b=ICG5MFU6nDqsx4akax9QFJCZ0gtmoOaumfOV5ciFWe3dszk6jCbvNQweZcREVQQQQtV1CE
	+EFKutBxG92XfUBOsAlfYK87ItwpTFKkaSkxdax8JJkZYqj3wQry0zfFawbVfIhdFBFGQe
	3OvPAm+/b+WN2TdWWdBp/ppLPLkEm7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707435917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ny8/gais+bfRbc1kxGSF6BydkfkKmZPjGNqn+J3Zwo=;
	b=QnlWa4ieMNxaHh1lPaByAiwWzG4twvBtatrUDg7Kfyqlf/+raHbjXP5l93h60PpXsRrbOg
	PCDMFPgk9mg4gTCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707435917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ny8/gais+bfRbc1kxGSF6BydkfkKmZPjGNqn+J3Zwo=;
	b=ICG5MFU6nDqsx4akax9QFJCZ0gtmoOaumfOV5ciFWe3dszk6jCbvNQweZcREVQQQQtV1CE
	+EFKutBxG92XfUBOsAlfYK87ItwpTFKkaSkxdax8JJkZYqj3wQry0zfFawbVfIhdFBFGQe
	3OvPAm+/b+WN2TdWWdBp/ppLPLkEm7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707435917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ny8/gais+bfRbc1kxGSF6BydkfkKmZPjGNqn+J3Zwo=;
	b=QnlWa4ieMNxaHh1lPaByAiwWzG4twvBtatrUDg7Kfyqlf/+raHbjXP5l93h60PpXsRrbOg
	PCDMFPgk9mg4gTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9CAA13984;
	Thu,  8 Feb 2024 23:45:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDmJLoxnxWWUfAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 08 Feb 2024 23:45:16 +0000
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
Subject: [PATCH v7 4/4] mm,page_owner: Filter out stacks by a threshold
Date: Fri,  9 Feb 2024 00:45:39 +0100
Message-ID: <20240208234539.19113-5-osalvador@suse.de>
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
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ICG5MFU6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QnlWa4ie
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[17.25%];
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
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: 56E6F1F7AB
X-Spam-Flag: NO

We want to be able to filter out the stacks based on
a threshold we can tune.
By writing to 'page_owner_threshold' file, we can adjust
the threshold value.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_owner.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index aea212734557..d95a73cf2581 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -780,14 +780,18 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
 	return stack;
 }
 
+static unsigned long page_owner_stack_threshold;
+
 static int stack_print(struct seq_file *m, void *v)
 {
 	char *buf;
 	int ret = 0;
 	struct stack_iterator *iter = m->private;
 	struct stack_record *stack = iter->last_stack;
+	int stack_count = refcount_read(&stack->count);
 
-	if (!stack->size || stack->size < 0 || refcount_read(&stack->count) < 2)
+	if (!stack->size || stack->size < 0 || stack_count < 2 ||
+	    stack_count < page_owner_stack_threshold)
 		return 0;
 
 	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
@@ -832,6 +836,21 @@ const struct file_operations page_owner_stack_operations = {
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
 	if (!static_branch_unlikely(&page_owner_inited)) {
@@ -843,6 +862,8 @@ static int __init pageowner_init(void)
 			    &proc_page_owner_operations);
 	debugfs_create_file("page_owner_stacks", 0400, NULL, NULL,
 			    &page_owner_stack_operations);
+	debugfs_create_file("page_owner_threshold", 0600, NULL, NULL,
+			    &proc_page_owner_threshold);
 
 	return 0;
 }
-- 
2.43.0


