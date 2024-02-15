Return-Path: <linux-kernel+bounces-67725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5C7856FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E66284518
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ADB146007;
	Thu, 15 Feb 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xKXjuvM6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ISzZj3yO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xKXjuvM6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ISzZj3yO"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3D145B2C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034291; cv=none; b=O06tUE193uATNDvl6N9qmRHMGrViha+98f4YkLltDeEc0GI7mIs1TX5OQkFfAONi2+BBBuSUYJzIQ/OY3S3awDkpyTbiTnRNifoJaOS3jYMtUpVldx+gJTGPpeyP4BHpq3lsc1jKKyntyVwHS5qHCwreRI6wHB1j0NWBaa8fPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034291; c=relaxed/simple;
	bh=MMxLR+c4AHCe+B8TLyyKQxH5S3MQ4cOXSawsCWvKqjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5fpZCf1RrwIwCoBmirzVjpP7m3iMgIoSoPXE1WhY9gdHJA0eqgLshxfJY3Ysds6WOoGi3kNN9FmQNqApy5NmqMef/OKbT5bsuZA/MD+OIoyUp4y23tZ2cimrP4eR0Akp+xJG6ehP3RbDDew4MRITrFA83iLUJSAhb9FJ4ZADg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xKXjuvM6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ISzZj3yO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xKXjuvM6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ISzZj3yO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 665111FB3D;
	Thu, 15 Feb 2024 21:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708034288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdFOtzOx20tmIdKDlysiVW3d7kQDyZIV9s1KqsDHXqU=;
	b=xKXjuvM64ri4D1udjo/jUaR0xlKobKbyI/1DWsmWrRQm/ske/AndH267ENTEACSWoGiQ1K
	8ETMBUYzKYV88SALUr1/KlcDe9zw0MBnWkpPXHLr+t3RP2R8ClJjBVnuFxArFufQl0yTxX
	bB767jlMSLQELB/TO3vVfQ0u8To9zAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708034288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdFOtzOx20tmIdKDlysiVW3d7kQDyZIV9s1KqsDHXqU=;
	b=ISzZj3yOabo2ChHLC1ocsTD4f+4ly25Gzqxmli5CBnhIYpISGnqIWI18xzqAUpZyD0OWNq
	YrATsok0rfl/DIAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708034288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdFOtzOx20tmIdKDlysiVW3d7kQDyZIV9s1KqsDHXqU=;
	b=xKXjuvM64ri4D1udjo/jUaR0xlKobKbyI/1DWsmWrRQm/ske/AndH267ENTEACSWoGiQ1K
	8ETMBUYzKYV88SALUr1/KlcDe9zw0MBnWkpPXHLr+t3RP2R8ClJjBVnuFxArFufQl0yTxX
	bB767jlMSLQELB/TO3vVfQ0u8To9zAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708034288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdFOtzOx20tmIdKDlysiVW3d7kQDyZIV9s1KqsDHXqU=;
	b=ISzZj3yOabo2ChHLC1ocsTD4f+4ly25Gzqxmli5CBnhIYpISGnqIWI18xzqAUpZyD0OWNq
	YrATsok0rfl/DIAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 40B301346A;
	Thu, 15 Feb 2024 21:58:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SM9hCe+IzmXPAQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 15 Feb 2024 21:58:07 +0000
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
Subject: [PATCH v10 6/7] mm,page_owner: Filter out stacks by a threshold
Date: Thu, 15 Feb 2024 22:59:06 +0100
Message-ID: <20240215215907.20121-7-osalvador@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: **
X-Spam-Score: 2.20
X-Spamd-Result: default: False [2.20 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.50)[91.72%]
X-Spam-Flag: NO

We want to be able to filter out the stacks based on a threshold we can
can tune.
By writing to 'count_threshold' file, we can adjust the threshold value.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_owner.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index e99fbf822dd6..e56c1e92eccf 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -846,6 +846,8 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
 	return stack;
 }
 
+static unsigned long page_owner_stack_threshold;
+
 static int stack_print(struct seq_file *m, void *v)
 {
 	int i, stack_count;
@@ -858,7 +860,8 @@ static int stack_print(struct seq_file *m, void *v)
 	entries = stack_record->entries;
 	stack_count = refcount_read(&stack_record->count) - 1;
 
-	if (!nr_entries || nr_entries < 0 || stack_count < 1)
+	if (!nr_entries || nr_entries < 0 || stack_count < 1 ||
+	    stack_count < page_owner_stack_threshold)
 		return 0;
 
 	for (i = 0; i < nr_entries; i++)
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


