Return-Path: <linux-kernel+bounces-78977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ACA861B97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E401F25973
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F6E143C6F;
	Fri, 23 Feb 2024 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qd8LsPfV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMZra/aK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qd8LsPfV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMZra/aK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8A14264A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712863; cv=none; b=OHVjY/povfi7md8mPLBDenz0o5bV0rUOpQ7Uf1Md+64afR5vw9N5FThrrNmmQnCLL0R1FVuRhL0a6vHPVHFCoR7HmiFSYhmDI7Al6KIIlpz+qkZlvmYAx9v9/2WVlGXCxh8c64XFjtQ7s9s4xCqgHQnXqXH+2dxL+gF5vHT95uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712863; c=relaxed/simple;
	bh=xj2FbXNZUF1ZX1Yi4h91pRFSVKXZaW8ItJyLfGmRRuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyIr9fQh3GtFbQHC1567sF5XltmO7Cx5kZAHrayC1Q6xnUFQ0BN7tHPrGA7fk5MHzSO0MeMb14bjrjSE7DpAjIdYkp36zLRf2UcUCEMttNKKjAsEz7no4iHtXFtRwSUBU4OPb3chM9X5gA64RlcM9zWSOx8u4kanRi2fTkJpIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qd8LsPfV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMZra/aK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qd8LsPfV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMZra/aK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28A201FC2A;
	Fri, 23 Feb 2024 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708712859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7brqYZxmuxrRKSYQEeacefCe+ctYuF6xWTXM5McbA8I=;
	b=Qd8LsPfVNYRjMhedMtLQ9mEmCVsypU2uQh2vZjA/HgXPPaDR8h6Ob8cd8kWmdHVkIEyWc5
	tZICMKAYYO83n5ZTXm+kGImHl31S91luqmF99uGMQrY23pYLrC8FYIbz+5qVyYmtbNCrKw
	Ow1WIWaUaW6G1ZKB3a3lruEOoFTS/EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708712859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7brqYZxmuxrRKSYQEeacefCe+ctYuF6xWTXM5McbA8I=;
	b=nMZra/aKnnlj9lkcc3nn6p3CDtjcpzXA6pWZ7RKjeB9Du6opgh5HJm8+D3P0y4LF8SXZOz
	FXDZgr9xc/wiCJCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708712859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7brqYZxmuxrRKSYQEeacefCe+ctYuF6xWTXM5McbA8I=;
	b=Qd8LsPfVNYRjMhedMtLQ9mEmCVsypU2uQh2vZjA/HgXPPaDR8h6Ob8cd8kWmdHVkIEyWc5
	tZICMKAYYO83n5ZTXm+kGImHl31S91luqmF99uGMQrY23pYLrC8FYIbz+5qVyYmtbNCrKw
	Ow1WIWaUaW6G1ZKB3a3lruEOoFTS/EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708712859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7brqYZxmuxrRKSYQEeacefCe+ctYuF6xWTXM5McbA8I=;
	b=nMZra/aKnnlj9lkcc3nn6p3CDtjcpzXA6pWZ7RKjeB9Du6opgh5HJm8+D3P0y4LF8SXZOz
	FXDZgr9xc/wiCJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 008AE13AC1;
	Fri, 23 Feb 2024 18:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gJluO5rj2GUaTQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 18:27:38 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Feb 2024 19:27:17 +0100
Subject: [PATCH v2 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz>
References: <20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz>
In-Reply-To: <20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Zheng Yejian <zhengyejian1@huawei.com>, 
 Xiongwei Song <xiongwei.song@windriver.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
 Vlastimil Babka <vbabka@suse.cz>, Steven Rostedt <rostedt@goodmis.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=xj2FbXNZUF1ZX1Yi4h91pRFSVKXZaW8ItJyLfGmRRuU=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBl2OOSfAZ6NhpOQjvkRl542eUJ71NZdn+YC7Mu6
 stXO0E2hXKJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZdjjkgAKCRC74LB10kWI
 mib0CACG+JmJHKxWWP/7G2u05sgQbj5Lct25lOvrv1QuCza7ZVTLPiTE2iE+BTE0PtH2dbdAYA5
 sl5xS/B71qhL1xjxpXhlT48vuelChx7oiMjOTPC1tbcKaU3HM68z420oR4LMO374DAlIaO5zlXu
 3UBG5MbidRfJxcqpQ8bWT8BUApwBuLjP1/psufGw7UGhM8uOii58OmE81DqIaPf9+9L0upk6xw9
 TNwRePi/w3rAJw42PoL6BkGJktvFbYpMLsDlfcPtjayFWVLix+Fwxkw09xUv4ZmAHSNjBDIMLjm
 HUnykdE/UgcYH0yBCAYi+6kvrVWPQw9wvQU/PWokxe3J3Ive
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[42.50%];
	 R_RATELIMIT(0.00)[to_ip_from(RLqdadssyy1w6u3twx3pq4jyny)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FREEMAIL_TO(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.40
X-Spam-Flag: NO

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed.  SLUB instead relies on the page allocator's NUMA policies.
Change the flag's value to 0 to free up the value it had, and mark it
for full removal once all users are gone.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/20240131172027.10f64405@gandalf.local.home/
Reviewed-and-tested-by: Xiongwei Song <xiongwei.song@windriver.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 5 +++--
 mm/slab.h            | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..b1675ff6b904 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -96,8 +96,6 @@
  */
 /* Defer freeing slabs to RCU */
 #define SLAB_TYPESAFE_BY_RCU	((slab_flags_t __force)0x00080000U)
-/* Spread some memory over cpuset */
-#define SLAB_MEM_SPREAD		((slab_flags_t __force)0x00100000U)
 /* Trace allocations and frees */
 #define SLAB_TRACE		((slab_flags_t __force)0x00200000U)
 
@@ -164,6 +162,9 @@
 #endif
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
 
+/* Obsolete unused flag, to be removed */
+#define SLAB_MEM_SPREAD		((slab_flags_t __force)0U)
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slab.h b/mm/slab.h
index 54deeb0428c6..f4534eefb35d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -469,7 +469,6 @@ static inline bool is_kmalloc_cache(struct kmem_cache *s)
 			      SLAB_STORE_USER | \
 			      SLAB_TRACE | \
 			      SLAB_CONSISTENCY_CHECKS | \
-			      SLAB_MEM_SPREAD | \
 			      SLAB_NOLEAKTRACE | \
 			      SLAB_RECLAIM_ACCOUNT | \
 			      SLAB_TEMPORARY | \

-- 
2.43.2


