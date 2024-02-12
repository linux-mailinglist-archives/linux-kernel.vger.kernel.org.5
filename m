Return-Path: <linux-kernel+bounces-62478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE785216B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EE81C21DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC034E1D7;
	Mon, 12 Feb 2024 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2EkLibh1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tC+Nwu7M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2EkLibh1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tC+Nwu7M"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421E4D595
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776970; cv=none; b=I0ua04nSzLt4C1OpvEEQFqA7HQb4yIHY1EMg8bpNEFn+qSQrAkvxNy24WSietk2pNyf/cFZ7tOUHsfZ3ov9aet5U7Db7rZ3O+OXRLXw7oXBRgBDqRRrugdQS8GF/hgHFTAaLuhxdhSM1RORzlcvyG63CkgIVqs14RgHQ1w1Myx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776970; c=relaxed/simple;
	bh=4Q7KJLy2PG12CfEApH1U9an73DqUlm1TwR3tb7XObzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmBlwiWZAmTvvvbiFFSeh9lJ0gJFpOX4rKAnt3rcgSuUDoj5Qg1+dMsf8NYYWXWs1K3APVLogJrdbMzl17OYSC2gMa473kc99tpSIHwOL4lLTIURpUpU6N3+OtiVvHkWLSsFuWfvSBKZxSBbL2d2tBBpofO2BLhq9GrgqMeonfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2EkLibh1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tC+Nwu7M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2EkLibh1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tC+Nwu7M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60F4F1F46E;
	Mon, 12 Feb 2024 22:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707776966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxO9mvfKurSdueDhnN3nx9fh6LQJs6PfoMaU2G6mpJQ=;
	b=2EkLibh1T0Fpvt5mQX5cxgPHMlwcw7SrPLaJ8HP3vpqaLlAPLEjfjZosemRKQVC7usQktP
	iipLG7yV7zr53ZKaC1QpRqsfGkDShZY3d8MRRXjgN/zj3vssnEC3Kr02aK1diL+lYxp831
	EUpqNZHOw0EC9jd3i3AWNhl0i28Zc64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707776966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxO9mvfKurSdueDhnN3nx9fh6LQJs6PfoMaU2G6mpJQ=;
	b=tC+Nwu7MsfACk+TPLrMCNykGk2INKq1bt5vpxNJwB860dZMWrxGpymKG8NT0/qgyClXS23
	bRvhU3JQLYp9LpDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707776966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxO9mvfKurSdueDhnN3nx9fh6LQJs6PfoMaU2G6mpJQ=;
	b=2EkLibh1T0Fpvt5mQX5cxgPHMlwcw7SrPLaJ8HP3vpqaLlAPLEjfjZosemRKQVC7usQktP
	iipLG7yV7zr53ZKaC1QpRqsfGkDShZY3d8MRRXjgN/zj3vssnEC3Kr02aK1diL+lYxp831
	EUpqNZHOw0EC9jd3i3AWNhl0i28Zc64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707776966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxO9mvfKurSdueDhnN3nx9fh6LQJs6PfoMaU2G6mpJQ=;
	b=tC+Nwu7MsfACk+TPLrMCNykGk2INKq1bt5vpxNJwB860dZMWrxGpymKG8NT0/qgyClXS23
	bRvhU3JQLYp9LpDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FF5513212;
	Mon, 12 Feb 2024 22:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gDGZFMWbymX5JgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Mon, 12 Feb 2024 22:29:25 +0000
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
Subject: [PATCH v8 1/5] lib/stackdepot: Move stack_record struct definition into the header
Date: Mon, 12 Feb 2024 23:30:25 +0100
Message-ID: <20240212223029.30769-2-osalvador@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ********
X-Spam-Score: 8.80
X-Spamd-Result: default: False [8.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

In order to move the heavy lifting into page_owner code, this one
needs to have access to the stack_record structure, which right now
sits in lib/stackdepot.c.
Move it to the stackdepot.h header so page_owner can access
stack_record's struct fields.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h | 44 ++++++++++++++++++++++++++++++++++++++
 lib/stackdepot.c           | 43 -------------------------------------
 2 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index adcbb8f23600..90274860fd8e 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -30,6 +30,50 @@ typedef u32 depot_stack_handle_t;
  */
 #define STACK_DEPOT_EXTRA_BITS 5
 
+#define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
+
+#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
+#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
+#define DEPOT_STACK_ALIGN 4
+#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
+#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
+			       STACK_DEPOT_EXTRA_BITS)
+
+/* Compact structure that stores a reference to a stack. */
+union handle_parts {
+	depot_stack_handle_t handle;
+	struct {
+		u32 pool_index	: DEPOT_POOL_INDEX_BITS;
+		u32 offset	: DEPOT_OFFSET_BITS;
+		u32 extra	: STACK_DEPOT_EXTRA_BITS;
+	};
+};
+
+struct stack_record {
+	struct list_head hash_list;	/* Links in the hash table */
+	u32 hash;			/* Hash in hash table */
+	u32 size;			/* Number of stored frames */
+	union handle_parts handle;	/* Constant after initialization */
+	refcount_t count;
+	union {
+		unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
+		struct {
+			/*
+			 * An important invariant of the implementation is to
+			 * only place a stack record onto the freelist iff its
+			 * refcount is zero. Because stack records with a zero
+			 * refcount are never considered as valid, it is safe to
+			 * union @entries and freelist management state below.
+			 * Conversely, as soon as an entry is off the freelist
+			 * and its refcount becomes non-zero, the below must not
+			 * be accessed until being placed back on the freelist.
+			 */
+			struct list_head free_list;	/* Links in the freelist */
+			unsigned long rcu_state;	/* RCU cookie */
+		};
+	};
+};
+
 typedef u32 depot_flags_t;
 
 /*
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 4a7055a63d9f..6f9095374847 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -36,54 +36,11 @@
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>
 
-#define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
-
-#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
-#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
-#define DEPOT_STACK_ALIGN 4
-#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
-#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
-			       STACK_DEPOT_EXTRA_BITS)
 #define DEPOT_POOLS_CAP 8192
 #define DEPOT_MAX_POOLS \
 	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
 	 (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
 
-/* Compact structure that stores a reference to a stack. */
-union handle_parts {
-	depot_stack_handle_t handle;
-	struct {
-		u32 pool_index	: DEPOT_POOL_INDEX_BITS;
-		u32 offset	: DEPOT_OFFSET_BITS;
-		u32 extra	: STACK_DEPOT_EXTRA_BITS;
-	};
-};
-
-struct stack_record {
-	struct list_head hash_list;	/* Links in the hash table */
-	u32 hash;			/* Hash in hash table */
-	u32 size;			/* Number of stored frames */
-	union handle_parts handle;	/* Constant after initialization */
-	refcount_t count;
-	union {
-		unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
-		struct {
-			/*
-			 * An important invariant of the implementation is to
-			 * only place a stack record onto the freelist iff its
-			 * refcount is zero. Because stack records with a zero
-			 * refcount are never considered as valid, it is safe to
-			 * union @entries and freelist management state below.
-			 * Conversely, as soon as an entry is off the freelist
-			 * and its refcount becomes non-zero, the below must not
-			 * be accessed until being placed back on the freelist.
-			 */
-			struct list_head free_list;	/* Links in the freelist */
-			unsigned long rcu_state;	/* RCU cookie */
-		};
-	};
-};
-
 static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
 static bool __stack_depot_early_init_passed __initdata;
-- 
2.43.0


