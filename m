Return-Path: <linux-kernel+bounces-2503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDCE815DFD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 09:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EEC1C21A30
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502E79F9;
	Sun, 17 Dec 2023 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0bRkKBOJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB86FBE
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5caf86963ecso19611337b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 00:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702800565; x=1703405365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMKZfo7MQTdL4MON6ILyvITz6v7ECb8JCcQoDm+y1oY=;
        b=0bRkKBOJDpybN9GSEOZMp6fck5wCaT1lw6jw7kuhcteHSpDV/5tWVryweSBb/8CsCL
         6ET7x+fFPI3lO+KU/+0QLeO4bhHriXyGdyScbaveaiGzObU1ul84U5fMwSRSlYb40zX9
         Xi/TQALPe6qbSDVmI6sx1JKDJxgb5MMLy17mI+41L2h1rz0hrzDA9XUwloQnlRZZCm01
         4ysNKVtdnbT6G+wbt1FngwxXzbIXuS0u5PK6huBYjZvObdSwSOQwf2fKs1jqgGFwkwA6
         xZNaTAeysDBrPGaRZOH8xkH8kLlnck7Kde1OP0ws5Oy8gB1yV8EAVVg0Ip8lrbGODeTO
         JexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800565; x=1703405365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMKZfo7MQTdL4MON6ILyvITz6v7ECb8JCcQoDm+y1oY=;
        b=UKCbrpZOcsM4U8NyacgJmElzAdpmQ/SDtJso97KFhBB0aLA1CPIvdOx227pfHkQDin
         qo5gY+h7SMyiZ8e5+c7N/7dT4cdSE82lFZ4QwPMFt8t6x5+DGCTh9VdzWXV4bzXnuA7C
         93Osm6iFUv+AoJKmFdcxKy1f9LL+r2LFHBiGuzGmCLW6jwu6vdoO5PHl+rcyynN/Q3+W
         v62rfQVi6J11p51FWnHMFmWX1fgoYekKZrI44ZKOoIeT8IhZlJpP9juXakREoLQ/fr0n
         VoZ7kqpLjexkOjxyo/k8AIrn77JiPP99YLEOMSFRPi4JOA/ATp2TFxsX0gwVfKHlqf9c
         ucqg==
X-Gm-Message-State: AOJu0YxknjtEFE3HsnjmvcO0FIKJal5O1da9jpwp0S/f3X+ylNJq4AYa
	jucZ47U4wls2y5xmpMQmWS9irTOciuBlFEt+cerg0oC0hf/6app42Rc+JMFR0NkxfancUQn0+XS
	YZk+HuDuBNpUSu8IuBmNTAZlF6Z3iHsUTXlipfCl8oE4BzlRE0m8pRF99haoqMAMulRNVQr5EwX
	5IhvnvRDA=
X-Google-Smtp-Source: AGHT+IFJCnycDJwsU67lKu1qB4q73cruRdEMF2MdI6NqbIK/eO/tqFob5FbZApzAiGPawGrZ+fw8MgSBnnOaG1MLLw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:3eb4:e132:f78a:5ba9])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:c02:b0:5e6:2989:a661 with
 SMTP id cl2-20020a05690c0c0200b005e62989a661mr94697ywb.10.1702800564661; Sun,
 17 Dec 2023 00:09:24 -0800 (PST)
Date: Sun, 17 Dec 2023 00:09:11 -0800
In-Reply-To: <20231217080913.2025973-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231217080913.2025973-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231217080913.2025973-4-almasrymina@google.com>
Subject: [PATCH net-next v2 3/3] net: add netmem_t to skb_frag_t
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use netmem_t instead of page directly in skb_frag_t. Currently netmem_t
is always a struct page underneath, but the abstraction allows efforts
to add support for skb frags not backed by pages.

There is unfortunately 1 instance where the skb_frag_t is assumed to be
a bio_vec in kcm. For this case, add a debug assert that the skb frag is
indeed backed by a page, and do a cast.

Add skb[_frag]_fill_netmem_*() and skb_add_rx_frag_netmem() helpers so
that the API can be used to create netmem skbs.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2:
- Add skb frag filling helpers.
---
 include/linux/skbuff.h | 70 ++++++++++++++++++++++++++++++++----------
 net/core/skbuff.c      | 22 +++++++++----
 net/kcm/kcmsock.c      | 10 ++++--
 3 files changed, 78 insertions(+), 24 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7ce38874dbd1..03ab13072962 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -37,6 +37,7 @@
 #endif
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/netmem.h>
 
 /**
  * DOC: skb checksums
@@ -359,7 +360,11 @@ extern int sysctl_max_skb_frags;
  */
 #define GSO_BY_FRAGS	0xFFFF
 
-typedef struct bio_vec skb_frag_t;
+typedef struct skb_frag {
+	struct netmem *bv_page;
+	unsigned int bv_len;
+	unsigned int bv_offset;
+} skb_frag_t;
 
 /**
  * skb_frag_size() - Returns the size of a skb fragment
@@ -2431,22 +2436,37 @@ static inline unsigned int skb_pagelen(const struct sk_buff *skb)
 	return skb_headlen(skb) + __skb_pagelen(skb);
 }
 
+static inline void skb_frag_fill_netmem_desc(skb_frag_t *frag,
+					     struct netmem *netmem, int off,
+					     int size)
+{
+	frag->bv_page = netmem;
+	frag->bv_offset = off;
+	skb_frag_size_set(frag, size);
+}
+
 static inline void skb_frag_fill_page_desc(skb_frag_t *frag,
 					   struct page *page,
 					   int off, int size)
 {
-	frag->bv_page = page;
-	frag->bv_offset = off;
-	skb_frag_size_set(frag, size);
+	skb_frag_fill_netmem_desc(frag, page_to_netmem(page), off, size);
+}
+
+static inline void __skb_fill_netmem_desc_noacc(struct skb_shared_info *shinfo,
+						int i, struct netmem *netmem,
+						int off, int size)
+{
+	skb_frag_t *frag = &shinfo->frags[i];
+
+	skb_frag_fill_netmem_desc(frag, netmem, off, size);
 }
 
 static inline void __skb_fill_page_desc_noacc(struct skb_shared_info *shinfo,
 					      int i, struct page *page,
 					      int off, int size)
 {
-	skb_frag_t *frag = &shinfo->frags[i];
-
-	skb_frag_fill_page_desc(frag, page, off, size);
+	__skb_fill_netmem_desc_noacc(shinfo, i, page_to_netmem(page), off,
+				     size);
 }
 
 /**
@@ -2462,10 +2482,10 @@ static inline void skb_len_add(struct sk_buff *skb, int delta)
 }
 
 /**
- * __skb_fill_page_desc - initialise a paged fragment in an skb
+ * __skb_fill_netmem_desc - initialise a paged fragment in an skb
  * @skb: buffer containing fragment to be initialised
  * @i: paged fragment index to initialise
- * @page: the page to use for this fragment
+ * @netmem: the netmem to use for this fragment
  * @off: the offset to the data with @page
  * @size: the length of the data
  *
@@ -2474,10 +2494,13 @@ static inline void skb_len_add(struct sk_buff *skb, int delta)
  *
  * Does not take any additional reference on the fragment.
  */
-static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
-					struct page *page, int off, int size)
+static inline void __skb_fill_netmem_desc(struct sk_buff *skb, int i,
+					  struct netmem *netmem, int off,
+					  int size)
 {
-	__skb_fill_page_desc_noacc(skb_shinfo(skb), i, page, off, size);
+	struct page *page = netmem_to_page(netmem);
+
+	__skb_fill_netmem_desc_noacc(skb_shinfo(skb), i, netmem, off, size);
 
 	/* Propagate page pfmemalloc to the skb if we can. The problem is
 	 * that not all callers have unique ownership of the page but rely
@@ -2485,7 +2508,21 @@ static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
 	 */
 	page = compound_head(page);
 	if (page_is_pfmemalloc(page))
-		skb->pfmemalloc	= true;
+		skb->pfmemalloc = true;
+}
+
+static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
+					struct page *page, int off, int size)
+{
+	__skb_fill_netmem_desc(skb, i, page_to_netmem(page), off, size);
+}
+
+static inline void skb_fill_netmem_desc(struct sk_buff *skb, int i,
+					struct netmem *netmem, int off,
+					int size)
+{
+	__skb_fill_netmem_desc(skb, i, netmem, off, size);
+	skb_shinfo(skb)->nr_frags = i + 1;
 }
 
 /**
@@ -2505,8 +2542,7 @@ static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
 static inline void skb_fill_page_desc(struct sk_buff *skb, int i,
 				      struct page *page, int off, int size)
 {
-	__skb_fill_page_desc(skb, i, page, off, size);
-	skb_shinfo(skb)->nr_frags = i + 1;
+	skb_fill_netmem_desc(skb, i, page_to_netmem(page), off, size);
 }
 
 /**
@@ -2532,6 +2568,8 @@ static inline void skb_fill_page_desc_noacc(struct sk_buff *skb, int i,
 
 void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int off,
 		     int size, unsigned int truesize);
+void skb_add_rx_frag_netmem(struct sk_buff *skb, int i, struct netmem *netmem,
+			    int off, int size, unsigned int truesize);
 
 void skb_coalesce_rx_frag(struct sk_buff *skb, int i, int size,
 			  unsigned int truesize);
@@ -3422,7 +3460,7 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
  */
 static inline struct page *skb_frag_page(const skb_frag_t *frag)
 {
-	return frag->bv_page;
+	return netmem_to_page(frag->bv_page);
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83af8aaeb893..053d220aa2f2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -845,16 +845,24 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
 }
 EXPORT_SYMBOL(__napi_alloc_skb);
 
-void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int off,
-		     int size, unsigned int truesize)
+void skb_add_rx_frag_netmem(struct sk_buff *skb, int i, struct netmem *netmem,
+			    int off, int size, unsigned int truesize)
 {
 	DEBUG_NET_WARN_ON_ONCE(size > truesize);
 
-	skb_fill_page_desc(skb, i, page, off, size);
+	skb_fill_netmem_desc(skb, i, netmem, off, size);
 	skb->len += size;
 	skb->data_len += size;
 	skb->truesize += truesize;
 }
+EXPORT_SYMBOL(skb_add_rx_frag_netmem);
+
+void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int off,
+		     int size, unsigned int truesize)
+{
+	skb_add_rx_frag_netmem(skb, i, page_to_netmem(page), off, size,
+			       truesize);
+}
 EXPORT_SYMBOL(skb_add_rx_frag);
 
 void skb_coalesce_rx_frag(struct sk_buff *skb, int i, int size,
@@ -1868,10 +1876,11 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 
 	/* skb frags point to kernel buffers */
 	for (i = 0; i < new_frags - 1; i++) {
-		__skb_fill_page_desc(skb, i, head, 0, psize);
+		__skb_fill_netmem_desc(skb, i, page_to_netmem(head), 0, psize);
 		head = (struct page *)page_private(head);
 	}
-	__skb_fill_page_desc(skb, new_frags - 1, head, 0, d_off);
+	__skb_fill_netmem_desc(skb, new_frags - 1, page_to_netmem(head), 0,
+			       d_off);
 	skb_shinfo(skb)->nr_frags = new_frags;
 
 release:
@@ -3609,7 +3618,8 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 		if (plen) {
 			page = virt_to_head_page(from->head);
 			offset = from->data - (unsigned char *)page_address(page);
-			__skb_fill_page_desc(to, 0, page, offset, plen);
+			__skb_fill_netmem_desc(to, 0, page_to_netmem(page),
+					       offset, plen);
 			get_page(page);
 			j = 1;
 			len -= plen;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 65d1f6755f98..5c46db045f4c 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -636,9 +636,15 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			msize += skb_shinfo(skb)->frags[i].bv_len;
 
+		/* The cast to struct bio_vec* here assumes the frags are
+		 * struct page based.
+		 */
+		DEBUG_NET_WARN_ON_ONCE(
+			!skb_frag_page(&skb_shinfo(skb)->frags[0]));
+
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
-			      skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
-			      msize);
+			      (const struct bio_vec *)skb_shinfo(skb)->frags,
+			      skb_shinfo(skb)->nr_frags, msize);
 		iov_iter_advance(&msg.msg_iter, txm->frag_offset);
 
 		do {
-- 
2.43.0.472.g3155946c3a-goog


