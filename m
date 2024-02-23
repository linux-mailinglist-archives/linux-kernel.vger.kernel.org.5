Return-Path: <linux-kernel+bounces-78978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D897861B98
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53C8B22AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EA41448CF;
	Fri, 23 Feb 2024 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZmoNfrpC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ii0k7MdE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZmoNfrpC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ii0k7MdE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C614265C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712864; cv=none; b=KtlrYuuQmwaVZswZhgM3RjNUlHQG77OCKMFqV0cDcFZlRsT57n0+Mz2Cbw5lIhZQd9SuMzg19PM0AP8kZqWEjgBSSvQ09X6Lk6U54eE++oCiPnSiJD2UpbWNLuwddEGXyeigxQlbyYkoa5XFKzRKAaeL5p2tpYZ70M4xURgytKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712864; c=relaxed/simple;
	bh=Pwf3NzcoQQwCRBmd+qMj8XBoxm9DrwZf7S0mWjV+OLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/VeHnBrGxNeCwDWoFb8lQ4d52ZtYKp0RbpE/M3jYhFIje1zaOu95PUmUdfLNp0uMLEUpz6edbEtn72wtF4fDweW2x4SUH8FnrZgBslyeD5K1dbyxelfRcfZWfYGJkRS0qKtHB467oz8XvIeyyZHMjaVRk9hmnFGF9w8DvEnGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZmoNfrpC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ii0k7MdE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZmoNfrpC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ii0k7MdE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46C87210F3;
	Fri, 23 Feb 2024 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708712859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdIIkjKNjW91Ug8+r97lNpU6eko4/0lhYa/nSEYrEFs=;
	b=ZmoNfrpCH0PEjyxNf8PJt4n07L7bZCydKQCWOYz8oz5GEYBsG6QDve+ZSKACVvSj31/vKA
	vnb2X4s6QiQsu/x8dg2lDrCZmmOs1S/ccPJnUsV6EUPCw+G8/F46WLQJEk/68NmjeqSxTA
	0gy3a3suP8/Navh+ix+feX4bWYdSdmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708712859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdIIkjKNjW91Ug8+r97lNpU6eko4/0lhYa/nSEYrEFs=;
	b=ii0k7MdEIfYFYmfXmE8fBw7rzdXV4rSipcrqSj2SYPJGx78peHrM+PqQzyVUbVhNQUTjWu
	eBu2MnLZnDDk0YBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708712859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdIIkjKNjW91Ug8+r97lNpU6eko4/0lhYa/nSEYrEFs=;
	b=ZmoNfrpCH0PEjyxNf8PJt4n07L7bZCydKQCWOYz8oz5GEYBsG6QDve+ZSKACVvSj31/vKA
	vnb2X4s6QiQsu/x8dg2lDrCZmmOs1S/ccPJnUsV6EUPCw+G8/F46WLQJEk/68NmjeqSxTA
	0gy3a3suP8/Navh+ix+feX4bWYdSdmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708712859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdIIkjKNjW91Ug8+r97lNpU6eko4/0lhYa/nSEYrEFs=;
	b=ii0k7MdEIfYFYmfXmE8fBw7rzdXV4rSipcrqSj2SYPJGx78peHrM+PqQzyVUbVhNQUTjWu
	eBu2MnLZnDDk0YBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22A6913AC7;
	Fri, 23 Feb 2024 18:27:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GOwlCJvj2GUaTQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 18:27:39 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Feb 2024 19:27:18 +0100
Subject: [PATCH v2 2/3] mm, slab: use an enum to define SLAB_ cache
 creation flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-slab-cleanup-flags-v2-2-02f1753e8303@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7536; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=Pwf3NzcoQQwCRBmd+qMj8XBoxm9DrwZf7S0mWjV+OLY=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBl2OOVBVULzhmkRIvmLB8VcoT8BDIxH1Iid/dmv
 SrNByJn3OSJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZdjjlQAKCRC74LB10kWI
 mix4B/91x98pri0nNwjdaIAvA0K80Xqlb+Ml7TNN2Kn4iCVaFEU3o+qL1kk2atqnc2Vr0QICmzo
 IvNPMcWRhiPc3oROrosQ4kYcUjO6sjMm3mYp99TavwSmBrdiPUltaY9UNW82evycsXiwESqgeV9
 F55WmiAtDFq8aRweNmizy9g6Ro1bWuAWFed1CHPiWBiQtWTtqrrz7ID1P+/TCYLqLKV02zPKlPe
 PypXdFNkBJd0G6hK9VmcZ5FJTs8/zlV6X3XI3Z58E14hErLUDVEqSROpPcTQ2gtbh3RlFQk2tYw
 XmSmzimiGjvjKKM/XW9Phq5UONbYVTDorTF12wTzkJ35NiVY
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 R_RATELIMIT(0.00)[to_ip_from(RLqdadssyy1w6u3twx3pq4jyny)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FREEMAIL_TO(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

The values of SLAB_ cache creation flags are defined by hand, which is
tedious and error-prone. Use an enum to assign the bit number and a
__SLAB_FLAG_BIT() macro to #define the final flags.

This renumbers the flag values, which is OK as they are only used
internally.

Also define a __SLAB_FLAG_UNUSED macro to assign value to flags disabled
by their respective config options in a unified and sparse-friendly way.

Reviewed-and-tested-by: Xiongwei Song <xiongwei.song@windriver.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 94 +++++++++++++++++++++++++++++++++++++---------------
 mm/slub.c            |  6 ++--
 2 files changed, 70 insertions(+), 30 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b1675ff6b904..f6323763cd61 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -21,29 +21,69 @@
 #include <linux/cleanup.h>
 #include <linux/hash.h>
 
+enum _slab_flag_bits {
+	_SLAB_CONSISTENCY_CHECKS,
+	_SLAB_RED_ZONE,
+	_SLAB_POISON,
+	_SLAB_KMALLOC,
+	_SLAB_HWCACHE_ALIGN,
+	_SLAB_CACHE_DMA,
+	_SLAB_CACHE_DMA32,
+	_SLAB_STORE_USER,
+	_SLAB_PANIC,
+	_SLAB_TYPESAFE_BY_RCU,
+	_SLAB_TRACE,
+#ifdef CONFIG_DEBUG_OBJECTS
+	_SLAB_DEBUG_OBJECTS,
+#endif
+	_SLAB_NOLEAKTRACE,
+	_SLAB_NO_MERGE,
+#ifdef CONFIG_FAILSLAB
+	_SLAB_FAILSLAB,
+#endif
+#ifdef CONFIG_MEMCG_KMEM
+	_SLAB_ACCOUNT,
+#endif
+#ifdef CONFIG_KASAN_GENERIC
+	_SLAB_KASAN,
+#endif
+	_SLAB_NO_USER_FLAGS,
+#ifdef CONFIG_KFENCE
+	_SLAB_SKIP_KFENCE,
+#endif
+#ifndef CONFIG_SLUB_TINY
+	_SLAB_RECLAIM_ACCOUNT,
+#endif
+	_SLAB_OBJECT_POISON,
+	_SLAB_CMPXCHG_DOUBLE,
+	_SLAB_FLAGS_LAST_BIT
+};
+
+#define __SLAB_FLAG_BIT(nr)	((slab_flags_t __force)(1U << (nr)))
+#define __SLAB_FLAG_UNUSED	((slab_flags_t __force)(0U))
 
 /*
  * Flags to pass to kmem_cache_create().
  * The ones marked DEBUG need CONFIG_SLUB_DEBUG enabled, otherwise are no-op
  */
 /* DEBUG: Perform (expensive) checks on alloc/free */
-#define SLAB_CONSISTENCY_CHECKS	((slab_flags_t __force)0x00000100U)
+#define SLAB_CONSISTENCY_CHECKS	__SLAB_FLAG_BIT(_SLAB_CONSISTENCY_CHECKS)
 /* DEBUG: Red zone objs in a cache */
-#define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
+#define SLAB_RED_ZONE		__SLAB_FLAG_BIT(_SLAB_RED_ZONE)
 /* DEBUG: Poison objects */
-#define SLAB_POISON		((slab_flags_t __force)0x00000800U)
+#define SLAB_POISON		__SLAB_FLAG_BIT(_SLAB_POISON)
 /* Indicate a kmalloc slab */
-#define SLAB_KMALLOC		((slab_flags_t __force)0x00001000U)
+#define SLAB_KMALLOC		__SLAB_FLAG_BIT(_SLAB_KMALLOC)
 /* Align objs on cache lines */
-#define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
+#define SLAB_HWCACHE_ALIGN	__SLAB_FLAG_BIT(_SLAB_HWCACHE_ALIGN)
 /* Use GFP_DMA memory */
-#define SLAB_CACHE_DMA		((slab_flags_t __force)0x00004000U)
+#define SLAB_CACHE_DMA		__SLAB_FLAG_BIT(_SLAB_CACHE_DMA)
 /* Use GFP_DMA32 memory */
-#define SLAB_CACHE_DMA32	((slab_flags_t __force)0x00008000U)
+#define SLAB_CACHE_DMA32	__SLAB_FLAG_BIT(_SLAB_CACHE_DMA32)
 /* DEBUG: Store the last owner for bug hunting */
-#define SLAB_STORE_USER		((slab_flags_t __force)0x00010000U)
+#define SLAB_STORE_USER		__SLAB_FLAG_BIT(_SLAB_STORE_USER)
 /* Panic if kmem_cache_create() fails */
-#define SLAB_PANIC		((slab_flags_t __force)0x00040000U)
+#define SLAB_PANIC		__SLAB_FLAG_BIT(_SLAB_PANIC)
 /*
  * SLAB_TYPESAFE_BY_RCU - **WARNING** READ THIS!
  *
@@ -95,19 +135,19 @@
  * Note that SLAB_TYPESAFE_BY_RCU was originally named SLAB_DESTROY_BY_RCU.
  */
 /* Defer freeing slabs to RCU */
-#define SLAB_TYPESAFE_BY_RCU	((slab_flags_t __force)0x00080000U)
+#define SLAB_TYPESAFE_BY_RCU	__SLAB_FLAG_BIT(_SLAB_TYPESAFE_BY_RCU)
 /* Trace allocations and frees */
-#define SLAB_TRACE		((slab_flags_t __force)0x00200000U)
+#define SLAB_TRACE		__SLAB_FLAG_BIT(_SLAB_TRACE)
 
 /* Flag to prevent checks on free */
 #ifdef CONFIG_DEBUG_OBJECTS
-# define SLAB_DEBUG_OBJECTS	((slab_flags_t __force)0x00400000U)
+# define SLAB_DEBUG_OBJECTS	__SLAB_FLAG_BIT(_SLAB_DEBUG_OBJECTS)
 #else
-# define SLAB_DEBUG_OBJECTS	0
+# define SLAB_DEBUG_OBJECTS	__SLAB_FLAG_UNUSED
 #endif
 
 /* Avoid kmemleak tracing */
-#define SLAB_NOLEAKTRACE	((slab_flags_t __force)0x00800000U)
+#define SLAB_NOLEAKTRACE	__SLAB_FLAG_BIT(_SLAB_NOLEAKTRACE)
 
 /*
  * Prevent merging with compatible kmem caches. This flag should be used
@@ -119,25 +159,25 @@
  * - performance critical caches, should be very rare and consulted with slab
  *   maintainers, and not used together with CONFIG_SLUB_TINY
  */
-#define SLAB_NO_MERGE		((slab_flags_t __force)0x01000000U)
+#define SLAB_NO_MERGE		__SLAB_FLAG_BIT(_SLAB_NO_MERGE)
 
 /* Fault injection mark */
 #ifdef CONFIG_FAILSLAB
-# define SLAB_FAILSLAB		((slab_flags_t __force)0x02000000U)
+# define SLAB_FAILSLAB		__SLAB_FLAG_BIT(_SLAB_FAILSLAB)
 #else
-# define SLAB_FAILSLAB		0
+# define SLAB_FAILSLAB		__SLAB_FLAG_UNUSED
 #endif
 /* Account to memcg */
 #ifdef CONFIG_MEMCG_KMEM
-# define SLAB_ACCOUNT		((slab_flags_t __force)0x04000000U)
+# define SLAB_ACCOUNT		__SLAB_FLAG_BIT(_SLAB_ACCOUNT)
 #else
-# define SLAB_ACCOUNT		0
+# define SLAB_ACCOUNT		__SLAB_FLAG_UNUSED
 #endif
 
 #ifdef CONFIG_KASAN_GENERIC
-#define SLAB_KASAN		((slab_flags_t __force)0x08000000U)
+#define SLAB_KASAN		__SLAB_FLAG_BIT(_SLAB_KASAN)
 #else
-#define SLAB_KASAN		0
+#define SLAB_KASAN		__SLAB_FLAG_UNUSED
 #endif
 
 /*
@@ -145,25 +185,25 @@
  * Intended for caches created for self-tests so they have only flags
  * specified in the code and other flags are ignored.
  */
-#define SLAB_NO_USER_FLAGS	((slab_flags_t __force)0x10000000U)
+#define SLAB_NO_USER_FLAGS	__SLAB_FLAG_BIT(_SLAB_NO_USER_FLAGS)
 
 #ifdef CONFIG_KFENCE
-#define SLAB_SKIP_KFENCE	((slab_flags_t __force)0x20000000U)
+#define SLAB_SKIP_KFENCE	__SLAB_FLAG_BIT(_SLAB_SKIP_KFENCE)
 #else
-#define SLAB_SKIP_KFENCE	0
+#define SLAB_SKIP_KFENCE	__SLAB_FLAG_UNUSED
 #endif
 
 /* The following flags affect the page allocator grouping pages by mobility */
 /* Objects are reclaimable */
 #ifndef CONFIG_SLUB_TINY
-#define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
+#define SLAB_RECLAIM_ACCOUNT	__SLAB_FLAG_BIT(_SLAB_RECLAIM_ACCOUNT)
 #else
-#define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0)
+#define SLAB_RECLAIM_ACCOUNT	__SLAB_FLAG_UNUSED
 #endif
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
 
 /* Obsolete unused flag, to be removed */
-#define SLAB_MEM_SPREAD		((slab_flags_t __force)0U)
+#define SLAB_MEM_SPREAD		__SLAB_FLAG_UNUSED
 
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..2934ef5f3cff 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -306,13 +306,13 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
 
 /* Internal SLUB flags */
 /* Poison object */
-#define __OBJECT_POISON		((slab_flags_t __force)0x80000000U)
+#define __OBJECT_POISON		__SLAB_FLAG_BIT(_SLAB_OBJECT_POISON)
 /* Use cmpxchg_double */
 
 #ifdef system_has_freelist_aba
-#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0x40000000U)
+#define __CMPXCHG_DOUBLE	__SLAB_FLAG_BIT(_SLAB_CMPXCHG_DOUBLE)
 #else
-#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0U)
+#define __CMPXCHG_DOUBLE	__SLAB_FLAG_UNUSED
 #endif
 
 /*

-- 
2.43.2


