Return-Path: <linux-kernel+bounces-73392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DAF85C1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1419AB23A54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A921476C74;
	Tue, 20 Feb 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RjcBobBc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JwFYRXTq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RjcBobBc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JwFYRXTq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6CE76905
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448328; cv=none; b=V0CkvpTJfxIGYlXPcXfZUPb2k+i9yK8+6dEI+aypQml1ONSpJs8Cp/iIsb6/sRUvQ7BxCVB5rN+Iy42cZ6abJHGSjVDJEpHzahAHNL+bNnSYmVp+tIEBvdxNXM2IHqF/xG/bmRYhoyVzU3I12zprOH/bygGvf94YesvduAaYC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448328; c=relaxed/simple;
	bh=OddJ5DHeDgks/i1mqhLaA/c2lRjGQhZqtVTweHMQxDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJbpJlIgHFDNm515cFcW/kWm0ypkoYUh9TkaN2hgeHoAXZFVSfG9fceUhJTUel+qjotWef7BE7ejxrFXc1HJllThfVKUkji3y5MvqcAwRg88xc3W++0o+trR5bn4RbLn9C0gYjshVamONZMGa/I5j4afKTLDHbdZjuXC5bPxMUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RjcBobBc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JwFYRXTq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RjcBobBc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JwFYRXTq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 411FC21FBD;
	Tue, 20 Feb 2024 16:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708448325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4OC2yNSKLqgnXzwwPex64d+kZgeSX8gpLykWcl/SKw=;
	b=RjcBobBcQec/R6BNYj9LVtWzct1RqrXs1Hh50ZzAqswNqAlsoooklOUijnTxlI1nWX3Dco
	vuH3FfKT6Qa+8jU56MYk0OjiBEuJ4EPlTADsYBwQBRR3tlkxiEuAvZVOq++BoGa7z3lyWR
	aoDDvqQfuzptU51eGvOW8ET9m4xcNHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708448325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4OC2yNSKLqgnXzwwPex64d+kZgeSX8gpLykWcl/SKw=;
	b=JwFYRXTqoVvqzk23AIOLXuMzXVHV47mrjeIz+Xwiw3CpIAK0JVphGsnYKwgXL6bz1pSKYM
	u8JpMqFaG3AeHuDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708448325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4OC2yNSKLqgnXzwwPex64d+kZgeSX8gpLykWcl/SKw=;
	b=RjcBobBcQec/R6BNYj9LVtWzct1RqrXs1Hh50ZzAqswNqAlsoooklOUijnTxlI1nWX3Dco
	vuH3FfKT6Qa+8jU56MYk0OjiBEuJ4EPlTADsYBwQBRR3tlkxiEuAvZVOq++BoGa7z3lyWR
	aoDDvqQfuzptU51eGvOW8ET9m4xcNHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708448325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4OC2yNSKLqgnXzwwPex64d+kZgeSX8gpLykWcl/SKw=;
	b=JwFYRXTqoVvqzk23AIOLXuMzXVHV47mrjeIz+Xwiw3CpIAK0JVphGsnYKwgXL6bz1pSKYM
	u8JpMqFaG3AeHuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1915E13A93;
	Tue, 20 Feb 2024 16:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GJHYBUXa1GVKXQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Feb 2024 16:58:45 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 20 Feb 2024 17:58:25 +0100
Subject: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-slab-cleanup-flags-v1-1-e657e373944a@suse.cz>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
In-Reply-To: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=OddJ5DHeDgks/i1mqhLaA/c2lRjGQhZqtVTweHMQxDw=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBl1No9wmY1D3tW/Cy64eGuViYQaGuyi/p0I9ZML
 1aOynVc32uJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZdTaPQAKCRC74LB10kWI
 mgcCB/9ah3oEc1eVnw/8rJfS4V2CrkLLtkwjbxIk0QO1Y0hJK6fdAYScMioTiqBbFz2fYneiEib
 unIEdHVvpl+axQ6ErHTm8ti5I3TyU4MWWs83wr4c2KDwr6M1dl/PvpBvMynOrlEipojbhKdzBUG
 M7r0KCDPswYFY/bWZNDMSglmuV4rdwkzWpAlBnmUSK1ARpf/CL/dLuc8EoPraztYVvBTuVl7/sS
 yeaXUhG1SHr+j+ewEl+8Ng27ejIu7HOiappS80WyxN0awRxddapuB+uGZB7Oe88F1qMmz88+5/T
 Zwh17MejM5IUm/PPb+QCsLgpmJBon11M/C4qFpCzuDCoY2ct
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.81
X-Spamd-Result: default: False [-3.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BAYES_HAM(-0.01)[46.40%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLqdadssyy1w6u3twx3pq4jyny)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FREEMAIL_TO(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed.  SLUB instead relies on the page allocator's NUMA policies.
Change the flag's value to 0 to free up the value it had, and mark it
for full removal once all users are gone.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/20240131172027.10f64405@gandalf.local.home/
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 5 +++--
 mm/slab.h            | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..6252f44115c2 100644
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
+#define SLAB_MEM_SPREAD		0
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
2.43.1


