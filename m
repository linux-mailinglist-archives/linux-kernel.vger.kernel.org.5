Return-Path: <linux-kernel+bounces-118411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C2F88BA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0051D1C2ED61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F21130AD3;
	Tue, 26 Mar 2024 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p9jMLvOo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wcN3jXol";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p9jMLvOo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wcN3jXol"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A78130A66
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434569; cv=none; b=WRl09RNPGmrNXBebrqhjdLCjaCdCvp1pwz9HtOVyWQ1TXhBJqSaDlJyA8sW6tHsxmX2KYLgVxVFzHt1ngt3J4Mv8YZaPdigBfXs4bpuUOiDwMUuY7lZhKDE+StGPgy7SiENz02KOzO8Uc6Hvhk1Zc6r4fZoYm+5v80Yb+hQeTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434569; c=relaxed/simple;
	bh=M/8zk4SX2N08A4/Pt/DFwdFp2Lk8SrklrRUVaGnlvAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGPMxlW2fVSKYH8AYh2GHjNn6QC5fZz350v6Efm7eTvy9QQ6LdvIllW1TzVOaEk9BqpwRGeuBg5M+/vmjr9/Si0KlXImuQULEMupW5+Vt7vy7HvxwN3K8Ea9YAVBwiRxIJSvpQ+QHGRdiSKHZSny2wp0aizJNNM0UN9K7f0PXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p9jMLvOo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wcN3jXol; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p9jMLvOo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wcN3jXol; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FB4C5D1D0;
	Tue, 26 Mar 2024 06:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711434563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3hPM+dJZjrUpvPFcXGaUP6KRSTdfQGjfQ6el+a/Oj0=;
	b=p9jMLvOo6GG9vIewO6sQfRTZ4Mni1Sdahpm3nMkhEbh16q6iJRNISCm+ZrBTYFRWpY5YcT
	Lqe8NCKu2D1MHp2522H0z8fCEaKmnc3/42wskN9RWdtmSdi8ocsSRMxp3FSWIIq2rdtKNQ
	LGG0D7tPy5FcURCuhqUWr2cxLFOah9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711434563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3hPM+dJZjrUpvPFcXGaUP6KRSTdfQGjfQ6el+a/Oj0=;
	b=wcN3jXol/cm7dMUuI/mYHwOilVrIFUsqPKVsZqU5Il++LJ0ABOWuEOeQWXzgRWynNrtLwp
	TZDUMr4PFDXkmGBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711434563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3hPM+dJZjrUpvPFcXGaUP6KRSTdfQGjfQ6el+a/Oj0=;
	b=p9jMLvOo6GG9vIewO6sQfRTZ4Mni1Sdahpm3nMkhEbh16q6iJRNISCm+ZrBTYFRWpY5YcT
	Lqe8NCKu2D1MHp2522H0z8fCEaKmnc3/42wskN9RWdtmSdi8ocsSRMxp3FSWIIq2rdtKNQ
	LGG0D7tPy5FcURCuhqUWr2cxLFOah9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711434563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3hPM+dJZjrUpvPFcXGaUP6KRSTdfQGjfQ6el+a/Oj0=;
	b=wcN3jXol/cm7dMUuI/mYHwOilVrIFUsqPKVsZqU5Il++LJ0ABOWuEOeQWXzgRWynNrtLwp
	TZDUMr4PFDXkmGBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 01EA613215;
	Tue, 26 Mar 2024 06:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KGdpOUJrAmY2YQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 26 Mar 2024 06:29:22 +0000
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
Subject: [PATCH v3 3/3] mm,page_owner: Fix accounting of pages when migrating
Date: Tue, 26 Mar 2024 07:30:36 +0100
Message-ID: <20240326063036.6242-4-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326063036.6242-1-osalvador@suse.de>
References: <20240326063036.6242-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.44
X-Spamd-Result: default: False [0.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_SPAM_SHORT(0.54)[0.180];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLubw94u9rwuhrr66hqpkfhck7)];
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
	 BAYES_HAM(-0.00)[31.22%]
X-Spam-Flag: NO

Upon migration, new allocated pages are being given the handle of the old
pages. This is problematic because it means that for the stack which
allocated the old page, we will be substracting the old page + the new one
when that page is freed, creating an accounting imbalance.

There is an interest in keeping it that way, as otherwise the output will
biased towards migration stacks should those operations occur often, but
that is not really helpful.
The link from the new page to the old stack is being performed by calling
__update_page_owner_handle() in __folio_copy_owner().
The only thing that is left is to link the migrate stack to the old
page, so the old page will be subtracted from the migrate stack,
avoiding by doing so any possible imbalance.

Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_owner.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 5df0d6892bdc..b4476f45b376 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -366,9 +366,12 @@ void __split_page_owner(struct page *page, int old_order, int new_order)
 
 void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 {
+	int i;
 	struct page_ext *old_ext;
 	struct page_ext *new_ext;
 	struct page_owner *old_page_owner;
+	struct page_owner *new_page_owner;
+	depot_stack_handle_t migrate_handle;
 
 	old_ext = page_ext_get(&old->page);
 	if (unlikely(!old_ext))
@@ -381,6 +384,8 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	}
 
 	old_page_owner = get_page_owner(old_ext);
+	new_page_owner = get_page_owner(new_ext);
+	migrate_handle = new_page_owner->handle;
 	__update_page_owner_handle(new_ext, old_page_owner->handle,
 				   old_page_owner->order, old_page_owner->gfp_mask,
 				   old_page_owner->last_migrate_reason,
@@ -395,6 +400,16 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 					old_page_owner->free_pid,
 					old_page_owner->free_tgid,
 					old_page_owner->free_ts_nsec);
+	/*
+	 * We linked the original stack to the new folio, we need to do the same
+	 * for the new one and the old folio otherwise there will be an imbalance
+	 * when subtracting those pages from the stack.
+	 */
+	for (i = 0; i < (1 << new_page_owner->order); i++) {
+		old_page_owner->handle = migrate_handle;
+		old_ext = page_ext_next(old_ext);
+		old_page_owner = get_page_owner(old_ext);
+	}
 
 	page_ext_put(new_ext);
 	page_ext_put(old_ext);
-- 
2.44.0


