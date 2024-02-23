Return-Path: <linux-kernel+bounces-78976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF449861B96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4ABB2323C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A43D143C64;
	Fri, 23 Feb 2024 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TwrUziIB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mbWlmygY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TwrUziIB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mbWlmygY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC0143C43
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712863; cv=none; b=fsjYvVbgczAHACpTM921PDRutaXPGJ09Wcy4LJ8p+7f4Wg/CWWmx4Zl8UO98twYLMZeb74+U0dffVUsTrnjemHsO1/yek1g8GMplSvt3rdABJ+obD0rbARKy8s96Yhxa/GiZwPVX4+T3snzH2A+44yUG9ssKGCYD4D4h0Hn4CGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712863; c=relaxed/simple;
	bh=oc217rqjv84A6cygyOWMLvkkVYYlf8fIgIHPUe4CqEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQx8tQt6/sGt4b37+ZhoH6/s+1VLGkS7XV9gCiceZehQeyj8kodwxOSoiQHzi8K6rEkK3M854QhHLE1J/WuYEzF26qthAFBxuzthVdz6j4ybAWBPJT4TJralj4XNmuVJg3fkBEpZTUvDbbWzuYReVRfhGs1hl5cs5mw4h5UEZyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TwrUziIB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mbWlmygY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TwrUziIB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mbWlmygY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73D011FCDA;
	Fri, 23 Feb 2024 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708712859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YO6OeAHEfcyOnMDaYbuFQtLgT98NdTKboW4QLF6GI08=;
	b=TwrUziIBFL2uhqrYSUuzeqP1mcryO/cH+SQcX9cKxgX421rEJSZDVz8bSHpKcIKnaFXAh7
	m/RoZT+NLMEfqrPdUKV+abvPpKptQvBy7Dt+kmk6EXfEPzlRYZKphP3d1AKg9uxSttWO/D
	ArBfDXSAO52TfrFGDOXnhm2KRxQboxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708712859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YO6OeAHEfcyOnMDaYbuFQtLgT98NdTKboW4QLF6GI08=;
	b=mbWlmygYPYsRAT01nQRdqI8oW+QZYkRiQuVUxB9vdh0Bd/jgLEHbcWcPEeQzTFvH+NA7WE
	vhzuuiS1Yo9j3vAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708712859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YO6OeAHEfcyOnMDaYbuFQtLgT98NdTKboW4QLF6GI08=;
	b=TwrUziIBFL2uhqrYSUuzeqP1mcryO/cH+SQcX9cKxgX421rEJSZDVz8bSHpKcIKnaFXAh7
	m/RoZT+NLMEfqrPdUKV+abvPpKptQvBy7Dt+kmk6EXfEPzlRYZKphP3d1AKg9uxSttWO/D
	ArBfDXSAO52TfrFGDOXnhm2KRxQboxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708712859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YO6OeAHEfcyOnMDaYbuFQtLgT98NdTKboW4QLF6GI08=;
	b=mbWlmygYPYsRAT01nQRdqI8oW+QZYkRiQuVUxB9vdh0Bd/jgLEHbcWcPEeQzTFvH+NA7WE
	vhzuuiS1Yo9j3vAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41879133DC;
	Fri, 23 Feb 2024 18:27:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kPmxD5vj2GUaTQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 18:27:39 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Feb 2024 19:27:19 +0100
Subject: [PATCH v2 3/3] mm, slab, kasan: replace kasan_never_merge() with
 SLAB_NO_MERGE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-slab-cleanup-flags-v2-3-02f1753e8303@suse.cz>
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
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=oc217rqjv84A6cygyOWMLvkkVYYlf8fIgIHPUe4CqEI=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBl2OOY129UnZyUFxvKzDcfwYdqEhJtST9zIVQhR
 OzNq64oBqmJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZdjjmAAKCRC74LB10kWI
 mm6xB/4/euNwci9dIao8KK+SBBEedcYnZYBkvv/tfVj0jHJLbQRkDU7o18IDmCMksxzsn6GOBXY
 hWU77hCw7WZR01TCB62xaMRW0zCLIA0G06bqY9dvz33jRvBJCH9VBwzyNBAfZ/LcGTpL1GR/5sx
 zB/Zgky+tvMiAeSElsMcqFukRRZ++nF6UNa9NdGkSbr9Ox6qkWHuEPN96iNvR5yTCICx0egsZcj
 nd017gUj/VcmHvW3qxXHRIigA5JksKXUSLxXyaUT03QrYIfSlFxwFjslF2KknX6AGoDV7kJWqCo
 9nYV61PnjZAKDEeC69HZCBItCBliGzH3GGI89D6yycYnxU83
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TwrUziIB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mbWlmygY
X-Spamd-Result: default: False [-3.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLycmwa99sdzp837p77658kns5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 73D011FCDA
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO

The SLAB_KASAN flag prevents merging of caches in some configurations,
which is handled in a rather complicated way via kasan_never_merge().
Since we now have a generic SLAB_NO_MERGE flag, we can instead use it
for KASAN caches in addition to SLAB_KASAN in those configurations,
and simplify the SLAB_NEVER_MERGE handling.

Tested-by: Xiongwei Song <xiongwei.song@windriver.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/kasan.h |  6 ------
 mm/kasan/generic.c    | 22 ++++++----------------
 mm/slab_common.c      |  2 +-
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index dbb06d789e74..70d6a8f6e25d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -429,7 +429,6 @@ struct kasan_cache {
 };
 
 size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
-slab_flags_t kasan_never_merge(void);
 void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			slab_flags_t *flags);
 
@@ -446,11 +445,6 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache,
 {
 	return 0;
 }
-/* And thus nothing prevents cache merging. */
-static inline slab_flags_t kasan_never_merge(void)
-{
-	return 0;
-}
 /* And no cache-related metadata initialization is required. */
 static inline void kasan_cache_create(struct kmem_cache *cache,
 				      unsigned int *size,
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index df6627f62402..27297dc4a55b 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -334,14 +334,6 @@ DEFINE_ASAN_SET_SHADOW(f3);
 DEFINE_ASAN_SET_SHADOW(f5);
 DEFINE_ASAN_SET_SHADOW(f8);
 
-/* Only allow cache merging when no per-object metadata is present. */
-slab_flags_t kasan_never_merge(void)
-{
-	if (!kasan_requires_meta())
-		return 0;
-	return SLAB_KASAN;
-}
-
 /*
  * Adaptive redzone policy taken from the userspace AddressSanitizer runtime.
  * For larger allocations larger redzones are used.
@@ -370,15 +362,13 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		return;
 
 	/*
-	 * SLAB_KASAN is used to mark caches that are sanitized by KASAN
-	 * and that thus have per-object metadata.
-	 * Currently this flag is used in two places:
-	 * 1. In slab_ksize() to account for per-object metadata when
-	 *    calculating the size of the accessible memory within the object.
-	 * 2. In slab_common.c via kasan_never_merge() to prevent merging of
-	 *    caches with per-object metadata.
+	 * SLAB_KASAN is used to mark caches that are sanitized by KASAN and
+	 * that thus have per-object metadata. Currently, this flag is used in
+	 * slab_ksize() to account for per-object metadata when calculating the
+	 * size of the accessible memory within the object. Additionally, we use
+	 * SLAB_NO_MERGE to prevent merging of caches with per-object metadata.
 	 */
-	*flags |= SLAB_KASAN;
+	*flags |= SLAB_KASAN | SLAB_NO_MERGE;
 
 	ok_size = *size;
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..7cfa2f1ce655 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -50,7 +50,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
  */
 #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
-		SLAB_FAILSLAB | SLAB_NO_MERGE | kasan_never_merge())
+		SLAB_FAILSLAB | SLAB_NO_MERGE)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)

-- 
2.43.2


