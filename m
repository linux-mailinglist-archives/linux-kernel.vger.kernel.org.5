Return-Path: <linux-kernel+bounces-168054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C558BB320
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565811C21632
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3AE158D7E;
	Fri,  3 May 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6tJjx30";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2g1qQerk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49842158866;
	Fri,  3 May 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761009; cv=none; b=j5BVZdj+kmbpp8LHHl2sOBV6hYaQxrfNDC3hWtB58IGarfO1DMlf0UzY/e6udXI99a/RIKDy4mXFXX7oh0tY0b1NPEc/FUkPUNjjMbHzcT5t51z7GSONOQBq097DxV+NqdaiZ6TlY1Y0hUHUOfTBXrNPD34ammkmuzWSM0n+W2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761009; c=relaxed/simple;
	bh=yrTjq6I9F4tvJDSchi3W1D6EoEX8ecSy8/O3MSsUTBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMMZzzMfzipNaHYyjzNxEN/1rAj4aXCIi+2IqAtYJogBgNT9Tzduc0hrFnXUHwvoT/CEFJHwA/y+UIvAnDsrZl8u24gqDDmc6uBt5Bcj7LrXlgnxZ43gzcT8M49p7DC/4Rad6V0oLrJQGOSfNN0ATBfIfLMFszKkAVbhjf03cc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6tJjx30; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2g1qQerk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oD7RGOip8UU5tOqDcDr5U4zAaPpFJ3hsGwy+4VIdr1c=;
	b=D6tJjx30NRzffTkKAqPkisdJQCPnRO4mJh3Wcb/ErQjw30+FSPEpOoHD5b9aJeVOzO4Ijz
	34EGfDKaQvlvEoAesT03UJNeWrddtPGmIfjfkcKbeY7632hel+KGyVfxnhyYP9Vy/p+4gj
	E0rqS/uBmoNjUoKp7mYqZB5fpXmi6pOObeBy9qFfnAuI7h/nJL73HXmF6ytBdDk3sm78XN
	Fh5vqiM234mcYgDWnVtNhALoHdtV2ZyFQKBf2SDrtQAZOqfEFH2yNXLhh1dly7xSJn8MFr
	sStx5oJ2+0rntuhxbyizL8U55kC4wnDkYiz05njvAOBAEUY21nV3qvgPlic4jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oD7RGOip8UU5tOqDcDr5U4zAaPpFJ3hsGwy+4VIdr1c=;
	b=2g1qQerkfskhwQlDA9yoByrlSmRNXtWLAnixjwn0fom7Ie4H8qdCoHPCPs5RcxAu0ovqS8
	pex8BGioCbm+0KAw==
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
Subject: [PATCH net-next 03/15] net: Use __napi_alloc_frag_align() instead of open coding it.
Date: Fri,  3 May 2024 20:25:07 +0200
Message-ID: <20240503182957.1042122-4-bigeasy@linutronix.de>
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The else condition within __netdev_alloc_frag_align() is an open coded
__napi_alloc_frag_align().

Use __napi_alloc_frag_align() instead of open coding it.
Move fragsz assignment before page_frag_alloc_align() invocation because
__napi_alloc_frag_align() also contains this statement.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/skbuff.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 28cd640a6ea97..c4479d5721a2a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -318,19 +318,15 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, =
unsigned int align_mask)
 {
 	void *data;
=20
-	fragsz =3D SKB_DATA_ALIGN(fragsz);
 	if (in_hardirq() || irqs_disabled()) {
 		struct page_frag_cache *nc =3D this_cpu_ptr(&netdev_alloc_cache);
=20
+		fragsz =3D SKB_DATA_ALIGN(fragsz);
 		data =3D __page_frag_alloc_align(nc, fragsz, GFP_ATOMIC,
 					       align_mask);
 	} else {
-		struct napi_alloc_cache *nc;
-
 		local_bh_disable();
-		nc =3D this_cpu_ptr(&napi_alloc_cache);
-		data =3D __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
-					       align_mask);
+		data =3D __napi_alloc_frag_align(fragsz, align_mask);
 		local_bh_enable();
 	}
 	return data;
--=20
2.43.0


