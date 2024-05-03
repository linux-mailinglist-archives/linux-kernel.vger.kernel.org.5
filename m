Return-Path: <linux-kernel+bounces-168056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4A38BB323
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DC01C203E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ACA158A25;
	Fri,  3 May 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PduJYgXL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAykS50v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD1E158219;
	Fri,  3 May 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761011; cv=none; b=Qmnp1pZmH2YjS1G8u5107LY0th8JUAn15+P/9AM5md2eiIYPiGGDLTl+v4qmi5tWRIany33JkZTESyPHxGquwzPPGWCjqHE+A0e0PHFBQsLjATSP+VFpwVidVmXuoWmzKbmoB9fUkvVrKDfCWP6TuCrRGS+V7Wb7RIPVXpoe/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761011; c=relaxed/simple;
	bh=6F+WmYxkkmptqKxlRwOLSf3Q3FyJx8XzwEyn4NvBr2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEC+6pSK/QwD9RQ6Ilq6GInYa4yun8sLV2tMc4vY/l1cwGdJN+N2kg5klNCW2oTiXXog+RghyJcddFgqR391tuRMesax4OQVCJQlaJvNOUfuBeyj2wfqTuhGmVKjUKgGdIW+0D3XWQqckHabyi2lAwe83Mb+bJ5Tg4Jcj9+qqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PduJYgXL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAykS50v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=biQ9vBP/OT8ssEpkU2fNQ/MUE/WSCld+B29qWDwe4EE=;
	b=PduJYgXLFW8KhQlib6ILzf43dkAgdVfolaXAQDMwftvbClGp4aUIT2v8HSS/n+jWqs8pqz
	c/EyxeHX5W5pIi5Y0RNx5tU/5slQOz0XXf/JGWv0Wj+AYZT9zqXvIyoQIeAmD7ha4ySlrP
	5zJQFWSK7ILNcfJQoTr+4Lur66NrlxH1Zj64llpTeh4VFvTBbILe+HNzm6bbK5NzlxU5Dn
	yLInyjnw6Sf+t7w0e/zuisde7Zmt+oSpSfwZillpu+ROIykkKQST9l9suETjcgCr0mF49E
	R7oHBpSHX3IEJJQ2cCTUPzjGxH+pIzeJbxVKPgTUS6LuZleId1sx89djz9iR4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=biQ9vBP/OT8ssEpkU2fNQ/MUE/WSCld+B29qWDwe4EE=;
	b=sAykS50vReWHQQAXvBFRKvJI0gooB3GHpl9sJL6vNypzWmmWJBMb5yf2eaOSDLqCajrgDT
	uzaBbKS/jdaKEHBw==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 04/15] net: Use nested-BH locking for napi_alloc_cache.
Date: Fri,  3 May 2024 20:25:08 +0200
Message-ID: <20240503182957.1042122-5-bigeasy@linutronix.de>
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

napi_alloc_cache is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Add a local_lock_t to the data structure and use local_lock_nested_bh()
for locking. This change adds only lockdep coverage and does not alter
the functional behaviour for !PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/skbuff.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c4479d5721a2a..c8b40e6237057 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -277,6 +277,7 @@ static void *page_frag_alloc_1k(struct page_frag_1k *nc=
, gfp_t gfp_mask)
 #endif
=20
 struct napi_alloc_cache {
+	local_lock_t bh_lock;
 	struct page_frag_cache page;
 	struct page_frag_1k page_small;
 	unsigned int skb_count;
@@ -284,7 +285,9 @@ struct napi_alloc_cache {
 };
=20
 static DEFINE_PER_CPU(struct page_frag_cache, netdev_alloc_cache);
-static DEFINE_PER_CPU(struct napi_alloc_cache, napi_alloc_cache);
+static DEFINE_PER_CPU(struct napi_alloc_cache, napi_alloc_cache) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 /* Double check that napi_get_frags() allocates skbs with
  * skb->head being backed by slab, not a page fragment.
@@ -308,6 +311,7 @@ void *__napi_alloc_frag_align(unsigned int fragsz, unsi=
gned int align_mask)
 	struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
=20
 	fragsz =3D SKB_DATA_ALIGN(fragsz);
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
=20
 	return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
 				       align_mask);
@@ -338,6 +342,7 @@ static struct sk_buff *napi_skb_cache_get(void)
 	struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
 	struct sk_buff *skb;
=20
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
 	if (unlikely(!nc->skb_count)) {
 		nc->skb_count =3D kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
 						      GFP_ATOMIC,
@@ -740,9 +745,13 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *=
dev, unsigned int len,
 		pfmemalloc =3D nc->pfmemalloc;
 	} else {
 		local_bh_disable();
+		local_lock_nested_bh(&napi_alloc_cache.bh_lock);
+
 		nc =3D this_cpu_ptr(&napi_alloc_cache.page);
 		data =3D page_frag_alloc(nc, len, gfp_mask);
 		pfmemalloc =3D nc->pfmemalloc;
+
+		local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 		local_bh_enable();
 	}
=20
@@ -806,11 +815,11 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *na=
pi, unsigned int len)
 		goto skb_success;
 	}
=20
-	nc =3D this_cpu_ptr(&napi_alloc_cache);
-
 	if (sk_memalloc_socks())
 		gfp_mask |=3D __GFP_MEMALLOC;
=20
+	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
+	nc =3D this_cpu_ptr(&napi_alloc_cache);
 	if (NAPI_HAS_SMALL_PAGE_FRAG && len <=3D SKB_WITH_OVERHEAD(1024)) {
 		/* we are artificially inflating the allocation size, but
 		 * that is not as bad as it may look like, as:
@@ -832,6 +841,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi=
, unsigned int len)
 		data =3D page_frag_alloc(&nc->page, len, gfp_mask);
 		pfmemalloc =3D nc->page.pfmemalloc;
 	}
+	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
=20
 	if (unlikely(!data))
 		return NULL;
@@ -1393,6 +1403,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 	if (!kasan_mempool_poison_object(skb))
 		return;
=20
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
 	nc->skb_cache[nc->skb_count++] =3D skb;
=20
 	if (unlikely(nc->skb_count =3D=3D NAPI_SKB_CACHE_SIZE)) {
--=20
2.43.0


