Return-Path: <linux-kernel+bounces-67720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331BA856FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C561C21099
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3B7145321;
	Thu, 15 Feb 2024 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BIeS8ey8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jDZk1p8j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BIeS8ey8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jDZk1p8j"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEFC1419A4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034283; cv=none; b=Ul3YpY8oJR6CA2bF3eah1e4OeIxcdYVhVZHNMthp9Az9XbezbDtSNbpFwI93to2fjlSZSiP39VqLm15APM0gEjYFqdnDJtQT3aYH3y7um/d9tbljMvlrDeuNuT2wAtNxN2zu0sLRGbHhfxH1DUflwotw7eZ5L7VlBL8w1Lr6FYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034283; c=relaxed/simple;
	bh=RuUKfCJhNptoKS7KxerD38q7tJpuo8NWsIkqExWOq80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv25R+r4B+V1SM6fcx5nni3mrXFbBa65hxpAl5w6zBUoM/Mjb6w38h2acyCtBiDgjMexIugoM7OWg4ztQfVmoEf0ff9GgdCDSp2SEN49DvmP6/o9XzB9k/2XkCdORFkDTO89ttzzq39yWaNN87Ptr5ebQ4uAuAcd7bXjCIaQdQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BIeS8ey8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jDZk1p8j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BIeS8ey8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jDZk1p8j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 355F722216;
	Thu, 15 Feb 2024 21:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708034280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dokaDBSPVaBXieZJW0HGUzN4swvmh9yT+sqR2X4jBMw=;
	b=BIeS8ey8s0J4V2b54NhN6Z6gNxsesWqq8anGuqv6gfTwgfcfgP/eMqYcCFr+t9fqdbO7KL
	/2TRlCl9AMjAXSgahUTzydYxT/XfehM+xzfaVWAZaKJ4uDWTp9LUsY1SlfqL3f4uzxf0tD
	MmReXnT6el1g2Sxq4mzhHsya7W36coY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708034280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dokaDBSPVaBXieZJW0HGUzN4swvmh9yT+sqR2X4jBMw=;
	b=jDZk1p8juHpSTbEvbUl6/ZP2gzkG1u3u2N6mL6NXnzKG+UePPbn7Eo+Mu8OREiCJ8vopUl
	wWEtkgywZoevpnBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708034280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dokaDBSPVaBXieZJW0HGUzN4swvmh9yT+sqR2X4jBMw=;
	b=BIeS8ey8s0J4V2b54NhN6Z6gNxsesWqq8anGuqv6gfTwgfcfgP/eMqYcCFr+t9fqdbO7KL
	/2TRlCl9AMjAXSgahUTzydYxT/XfehM+xzfaVWAZaKJ4uDWTp9LUsY1SlfqL3f4uzxf0tD
	MmReXnT6el1g2Sxq4mzhHsya7W36coY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708034280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dokaDBSPVaBXieZJW0HGUzN4swvmh9yT+sqR2X4jBMw=;
	b=jDZk1p8juHpSTbEvbUl6/ZP2gzkG1u3u2N6mL6NXnzKG+UePPbn7Eo+Mu8OREiCJ8vopUl
	wWEtkgywZoevpnBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A5CFB1346A;
	Thu, 15 Feb 2024 21:57:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IEDFJeeIzmXPAQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 15 Feb 2024 21:57:59 +0000
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
Subject: [PATCH v10 1/7] lib/stackdepot: Fix first entry having a 0-handle
Date: Thu, 15 Feb 2024 22:59:01 +0100
Message-ID: <20240215215907.20121-2-osalvador@suse.de>
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
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BIeS8ey8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jDZk1p8j
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
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
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 355F722216
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
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


