Return-Path: <linux-kernel+bounces-65602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD9854F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A4F281CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3390860BBE;
	Wed, 14 Feb 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WgbFMw8U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3NIO6dV5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WgbFMw8U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3NIO6dV5"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3F605BF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930058; cv=none; b=Xskzfi9eLX7zVnT/l2j0KBCwhSL+cuFeDcdG4/S+86LqwTpxZQ2XJKTkBf7QtzO2yTcXz6yOCYc2BhDxSK9hbaq5CF4LLGySQtVUtCDlKdZhwsdmKoXC5xqRdXmQ2yl5J3eX6KOpaGY2jY6/+LlilsOanCPy6R+YEEhtoioCtt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930058; c=relaxed/simple;
	bh=aKCo3p0NMLXAjDiUrDaHZAqGzImjVvxgaq5Fk0GZcQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBCzFufyftCPToANK4kBXaR0UWj3FMMa5fvOsqtQy1997zl6SgrTS52H43ZcPZG0DQh0B5OgPjHio/3vTzbsdMG+O2rLykCemg8Try7gNLFskDUEgvgB5mJAquPLabnfoJb6MHnvUFDbCIeCS/Zaam2CltxdAv1StsVFIPRUeO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WgbFMw8U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3NIO6dV5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WgbFMw8U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3NIO6dV5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD36021DB7;
	Wed, 14 Feb 2024 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2WS2tmMx6vkdBbq/BMMJO3YZaJfxmYDmOZxjs2QKsg=;
	b=WgbFMw8UsrxLruEg33YDAuX/poRzXS7nr/9vF3IZg0N8OqlEAqb7r2DCmE0N9JdTTknD88
	DhsNvOUBQ8CBs44LnciNfutYPQvJF13zuDOSlEDicZfn+5sGByZKxDnrkfmyYpO3nCt9Dr
	38A7zFmce29vz6ugxWdMRaJYObdjThc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2WS2tmMx6vkdBbq/BMMJO3YZaJfxmYDmOZxjs2QKsg=;
	b=3NIO6dV59Z+blB81iT3AmWsJbD2s5OZgbH4nP7yaUkeuxuYpCyB++tHVB7ivqpi8wrlcf8
	kaTsY4hiqApWLVAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2WS2tmMx6vkdBbq/BMMJO3YZaJfxmYDmOZxjs2QKsg=;
	b=WgbFMw8UsrxLruEg33YDAuX/poRzXS7nr/9vF3IZg0N8OqlEAqb7r2DCmE0N9JdTTknD88
	DhsNvOUBQ8CBs44LnciNfutYPQvJF13zuDOSlEDicZfn+5sGByZKxDnrkfmyYpO3nCt9Dr
	38A7zFmce29vz6ugxWdMRaJYObdjThc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2WS2tmMx6vkdBbq/BMMJO3YZaJfxmYDmOZxjs2QKsg=;
	b=3NIO6dV59Z+blB81iT3AmWsJbD2s5OZgbH4nP7yaUkeuxuYpCyB++tHVB7ivqpi8wrlcf8
	kaTsY4hiqApWLVAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C77413A0B;
	Wed, 14 Feb 2024 17:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yAQrCMbxzGUfMwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 14 Feb 2024 17:00:54 +0000
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
Subject: [PATCH v9 1/7] lib/stackdepot: Fix first entry having a 0-handle
Date: Wed, 14 Feb 2024 18:01:51 +0100
Message-ID: <20240214170157.17530-2-osalvador@suse.de>
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

The very first entry of stack_record gets a handle of 0, but this is wrong
because stackdepot treats a 0-handle as a non-valid one.
E.g: See the check in stack_depot_fetch()

Fix this by adding and offset of 1.

This bug has been lurking since the very beginning of stackdepot,
but no one really cared as it seems.
Because of that I am not adding a Fixes tag.

Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 lib/stackdepot.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 4a7055a63d9f..c043a4186bc5 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -45,15 +45,16 @@
 #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
 			       STACK_DEPOT_EXTRA_BITS)
 #define DEPOT_POOLS_CAP 8192
+/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
 #define DEPOT_MAX_POOLS \
-	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
-	 (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
+	(((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
+	 (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
 
 /* Compact structure that stores a reference to a stack. */
 union handle_parts {
 	depot_stack_handle_t handle;
 	struct {
-		u32 pool_index	: DEPOT_POOL_INDEX_BITS;
+		u32 pool_index	: DEPOT_POOL_INDEX_BITS; /* pool_index is offset by 1 */
 		u32 offset	: DEPOT_OFFSET_BITS;
 		u32 extra	: STACK_DEPOT_EXTRA_BITS;
 	};
@@ -372,7 +373,7 @@ static struct stack_record *depot_pop_free_pool(void **prealloc, size_t size)
 	stack = current_pool + pool_offset;
 
 	/* Pre-initialize handle once. */
-	stack->handle.pool_index = pool_index;
+	stack->handle.pool_index = pool_index + 1;
 	stack->handle.offset = pool_offset >> DEPOT_STACK_ALIGN;
 	stack->handle.extra = 0;
 	INIT_LIST_HEAD(&stack->hash_list);
@@ -483,18 +484,19 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 	const int pools_num_cached = READ_ONCE(pools_num);
 	union handle_parts parts = { .handle = handle };
 	void *pool;
+	u32 pool_index = parts.pool_index - 1;
 	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
 	lockdep_assert_not_held(&pool_lock);
 
-	if (parts.pool_index > pools_num_cached) {
+	if (pool_index > pools_num_cached) {
 		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
-		     parts.pool_index, pools_num_cached, handle);
+		     pool_index, pools_num_cached, handle);
 		return NULL;
 	}
 
-	pool = stack_pools[parts.pool_index];
+	pool = stack_pools[pool_index];
 	if (WARN_ON(!pool))
 		return NULL;
 
-- 
2.43.0


