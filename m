Return-Path: <linux-kernel+bounces-131007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1FE8981DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD191C20DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129559B44;
	Thu,  4 Apr 2024 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vqzIj68i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EdzULppk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF4056B66
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214354; cv=none; b=ZHzOwk49gNzh86Cf/jAIOVI/VyjaVpykOk1cvkrP1xfX2K9B9Xd3r/A2nDMyd9xRIqzudTGjzAsY1wQlapr/hgcP0PBVr7A78dBaOl/d4ht233hF1jpS8oVkXC5Ptq1jcZDAziOZkqr1Y3+paLp6+IaRmeVdlsahdeFepyRAunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214354; c=relaxed/simple;
	bh=+6T8XbJZgGjTxkv6mFtAdG/6qCcIPdviSagu3Z1aIVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6q4JNcHUe15L60B9oAnWBEh9/MstYJZD1TroORK7TcKxcrM9S/GFMokmAOytMt2G6cRjzfSteZOcJyURWUBMRlZVJeACNSDKXSzlTmvKh8fozubZ3x2MMmaACBWFqnUSQfwLFlaAkhDvIMCY4QWo9ajzpu6Nid89StrJ07tW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vqzIj68i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EdzULppk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2766F378EA;
	Thu,  4 Apr 2024 07:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712214351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8WcJoZIAuccn6bS5H52hIFrTVidppTfRzzAEdTNAso=;
	b=vqzIj68iArnn+jsBa8iE51o8g82HwP3tf58Jqo9Y1QMYTKq2ADZ9BtLOfdwVq3H1Zj/rOk
	ABYB4xBZ18nMrmC9evEUEUGLraGaY2LAegAdqp83pZzId2i8HXmie44k0kg4ChyXiegCN3
	ULyIg4hpges6VTrSCOUJTS/KUaeDNLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712214351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8WcJoZIAuccn6bS5H52hIFrTVidppTfRzzAEdTNAso=;
	b=EdzULppkr+ztcsNQp/E7F9+/5X5wb36VwFC+Yv41g7GfIyiAb7myRXX/2cisk7VhtnjoI6
	qzePAph+8U8gttCQ==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 919BA139E8;
	Thu,  4 Apr 2024 07:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yCTjIE5RDmY6cgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 04 Apr 2024 07:05:50 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 3/4] mm,page_owner: Fix accounting of pages when migrating
Date: Thu,  4 Apr 2024 09:07:01 +0200
Message-ID: <20240404070702.2744-4-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404070702.2744-1-osalvador@suse.de>
References: <20240404070702.2744-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	REPLY(-4.00)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[34.02%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.de:email,suse.cz:email];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,rivosinc.com,suse.de];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Level: 
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
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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


