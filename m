Return-Path: <linux-kernel+bounces-38630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1D683C36B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C738291581
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2924F893;
	Thu, 25 Jan 2024 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+2DKi4R"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8C50A69;
	Thu, 25 Jan 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188482; cv=none; b=I7yH35otilebs/wSUDYELY4A5XUHHEr4oMhtUPsZc1A2OGti4xzdWXkw+IIOCIO/lz9/UyoqiFykf4qTAPo7MWdtCDNMZoR3cAJYMiTPGdie5jdp56SpkXED/g/QvJZGpzqvbdT+ic9xadgfnJO8Pdn1RgMLuNZImOMjpaVj9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188482; c=relaxed/simple;
	bh=sS2wLsU7MluN9JmmNAzbFpTnr0xhf954jsxZIMM1KUc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=tu/NRovulUctw6aMo9iTnl3FbT92l/LeBFfHvDH6ejFusY0MaG4+LKfb5VeGDNP5cIGor1WA6k9J3Lbww8isAVlmMZNkaVV8XAh+9zZ5usnItNF/XxVojZyr2tXc+eGmiHp/MkkC51noTSQE3FAcB9rMEwy5kWHXkTgjDgl2fEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+2DKi4R; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so73314605e9.1;
        Thu, 25 Jan 2024 05:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706188479; x=1706793279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4b/eU4REuAaKDyVxKej17wr9BHDZJIws/FBz+hMoFo=;
        b=Y+2DKi4Rip/duJhyOt8cg/aZuCPwibyQAycc4Q6OX9VG/VgYmH6JAPEP3H4ZWFPY47
         0Sxr/dEwu8TDOLfCuylJKTgK32C6bsn0e/d3ovlqq4VmLK98ycwDL4tbRBa8Ra8/USGP
         /GzC4F7gWiU2zYKg+zn4Ee9KJjqnv+zp70NeLyL+rs12u3HfkTCPvoA5sXpR7NOPykPX
         tY9JmYPyBbqeyNFJcSKFI7vWaMc/Y5onNBoOJtp2eoQsd1zTK81cV1G1xjAkb1EIDxJj
         PE63GfZWXV84ENr56LNdckLI1XYe7h3hUfLG7ucm49TtRrOnGWZCSJp5ofWMm+kCwUWp
         vLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706188479; x=1706793279;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4b/eU4REuAaKDyVxKej17wr9BHDZJIws/FBz+hMoFo=;
        b=qesJ4FmzD8aZc42jZqrTyGzV9ceCytTPSaF1xdHObaeHlOlDlSw6kjP1pPM9muaxVR
         AW3TEU3FHmAfLTaZqwSQgOH9eZ0dGH64m7kJ/VC5GYTDUHZ88tjp4woZbars3iuI0QMu
         G6paAQmrl4dXABrAcxmL+zB+2lIYnrNH/PN87C+oC+IO23Pj/7t16hQF9YTcnJEvfFAq
         iAaPXaUWT56pMn0edGWhsMjycYcHMkxLAAa0TZWHHZETYRbFWLHGwGElFQm/chXV/Y4h
         65C98T/ml/dyITo81UWDjiwnuUWiC1kgf/RTNQdssxAKFg5+z4ubOdylsEx9/pBZLu13
         MAXw==
X-Gm-Message-State: AOJu0YzCFhRVxdx3auQo98Of1ZvbNAMv2R7lldj48aY4Ayj/rTbcGxGG
	cNEWvqX2dNH66551TO2JIcmny0ao+/5aRqezi3GApukTmLx82VKg
X-Google-Smtp-Source: AGHT+IFZM+bA6Vbhmp4GsZBZRYAaTAEY5Dg3tS8OUJ6Cr7i04jgv/HNt/ngjPmlbe2oq+Y51inDqqA==
X-Received: by 2002:a05:600c:3d91:b0:40e:4556:5870 with SMTP id bi17-20020a05600c3d9100b0040e45565870mr319886wmb.120.1706188478718;
        Thu, 25 Jan 2024 05:14:38 -0800 (PST)
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b0040e549c77a1sm2621155wmq.32.2024.01.25.05.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 05:14:38 -0800 (PST)
Message-ID: <547dd88c-f07d-4126-ae0b-bee126f23d73@gmail.com>
Date: Thu, 25 Jan 2024 14:14:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [RFC PATCH net-next v1 2/3] net: dst_cache: add input_dst_cache API
Content-Language: en-US
From: Leone Fernando <leone4fernando@gmail.com>
To: dennis@kernel.org, tj@kernel.org, cl@linux.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <d951b371-4138-4bda-a1c5-7606a28c81f0@gmail.com>
In-Reply-To: <d951b371-4138-4bda-a1c5-7606a28c81f0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The input_dst_cache allows fast lookup of frequently encountered dsts.

In order to provide stable results, I implemented a simple linear
hashtable with each bucket containing a constant amount of
entries (DST_CACHE_INPUT_BUCKET_SIZE).

Similarly to how the route hint is used, I defined the hashtable key to
contain the daddr and the tos of the IP header.

Lookup is performed in a straightforward manner: start at the bucket head
corresponding the hashed key and search the following
DST_CACHE_INPUT_BUCKET_SIZE entries of the array for a matching key.

When inserting a new dst to the cache, if all the bucket entries are
full, the oldest one is deleted to make room for the new dst.

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 include/linux/percpu.h  |   4 ++
 include/net/dst_cache.h |  56 ++++++++++++++++
 net/core/dst_cache.c    | 145 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 8c677f185901..562d846b81fe 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -141,6 +141,10 @@ extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 #define alloc_percpu_gfp(type, gfp)					\
 	(typeof(type) __percpu *)__alloc_percpu_gfp(sizeof(type),	\
 						__alignof__(type), gfp)
+#define alloc_percpu_array_gfp(type, size, gfp)				 \
+	((typeof(type) __percpu *)__alloc_percpu_gfp(sizeof(type[size]), \
+						__alignof__(type[size]), \
+						gfp))
 #define alloc_percpu(type)						\
 	(typeof(type) __percpu *)__alloc_percpu(sizeof(type),		\
 						__alignof__(type))
diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index df6622a5fe98..560e7aec9347 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -8,11 +8,38 @@
 #include <net/ip6_fib.h>
 #endif
 
+#define DST_CACHE_INPUT_SHIFT (9)
+#define DST_CACHE_INPUT_SIZE (1 << DST_CACHE_INPUT_SHIFT)
+#define DST_CACHE_INPUT_BUCKET_SIZE (4)
+#define DST_CACHE_INPUT_HASH_MASK (~(DST_CACHE_INPUT_BUCKET_SIZE - 1))
+#define INVALID_DST_CACHE_INPUT_KEY (~(u64)(0))
+
 struct dst_cache {
 	struct dst_cache_pcpu __percpu *cache;
 	unsigned long reset_ts;
 };
 
+extern unsigned int dst_cache_net_id __read_mostly;
+
+/**
+ * idst_for_each_in_bucket - iterate over a dst cache bucket
+ * @pos:	the type * to use as a loop cursor
+ * @head:	the head of the cpu dst cache.
+ * @hash:	the hash of the bucket
+ */
+#define idst_for_each_in_bucket(pos, head, hash)		\
+	for (pos = &head[hash];					\
+	     pos < &head[hash + DST_CACHE_INPUT_BUCKET_SIZE];	\
+	     pos++)
+
+/**
+ * idst_for_each_in_cache - iterate over the dst cache
+ * @pos:	the type * to use as a loop cursor
+ * @head:	the head of the cpu dst cache.
+ */
+#define idst_for_each_in_cache(pos, head)				\
+	for (pos = head; pos < head + DST_CACHE_INPUT_SIZE; pos++)
+
 /**
  *	dst_cache_get - perform cache lookup
  *	@dst_cache: the cache
@@ -106,4 +133,33 @@ int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp);
  */
 void dst_cache_destroy(struct dst_cache *dst_cache);
 
+/**
+ *	dst_cache_input_get_noref - perform lookup in the input cache,
+ *	return a noref dst
+ *	@dst_cache: the input cache
+ *	@skb: the packet according to which the dst entry will be searched
+ *	local BH must be disabled.
+ */
+struct dst_entry *dst_cache_input_get_noref(struct dst_cache *dst_cache,
+					    struct sk_buff *skb);
+
+/**
+ *	dst_cache_input_add - add the dst of the given skb to the input cache.
+ *
+ *	in case the cache bucket is full, the oldest entry will be deleted
+ *	and replaced with the new one.
+ *	@dst_cache: the input cache
+ *	@skb: The packet according to which the dst entry will be searched
+ *
+ *	local BH must be disabled.
+ */
+void dst_cache_input_add(struct dst_cache *dst_cache,
+			 const struct sk_buff *skb);
+
+/**
+ *	dst_cache_input_init - initialize the input cache,
+ *	allocating the required storage
+ */
+int __init dst_cache_input_init(void);
+
 #endif
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 0ccfd5fa5cb9..a635c0e52400 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -13,6 +13,7 @@
 #include <net/ip6_fib.h>
 #endif
 #include <uapi/linux/in.h>
+#include <net/netns/generic.h>
 
 struct dst_cache_pcpu {
 	unsigned long refresh_ts;
@@ -21,9 +22,12 @@ struct dst_cache_pcpu {
 	union {
 		struct in_addr in_saddr;
 		struct in6_addr in6_saddr;
+		u64 key;
 	};
 };
 
+unsigned int dst_cache_net_id __read_mostly;
+
 static void dst_cache_per_cpu_dst_set(struct dst_cache_pcpu *dst_cache,
 				      struct dst_entry *dst, u32 cookie)
 {
@@ -181,3 +185,144 @@ void dst_cache_reset_now(struct dst_cache *dst_cache)
 	}
 }
 EXPORT_SYMBOL_GPL(dst_cache_reset_now);
+
+static void dst_cache_input_set(struct dst_cache_pcpu *idst,
+				struct dst_entry *dst, u64 key)
+{
+	dst_cache_per_cpu_dst_set(idst, dst, 0);
+	idst->key = key;
+	idst->refresh_ts = jiffies;
+}
+
+static struct dst_entry *__dst_cache_input_get_noref(struct dst_cache_pcpu *idst)
+{
+	struct dst_entry *dst = idst->dst;
+
+	if (unlikely(dst->obsolete && !dst->ops->check(dst, idst->cookie))) {
+		dst_cache_input_set(idst, NULL, INVALID_DST_CACHE_INPUT_KEY);
+		goto fail;
+	}
+
+	idst->refresh_ts = jiffies;
+	return dst;
+
+fail:
+	return NULL;
+}
+
+static inline u64 create_dst_cache_key_ip4(const struct sk_buff *skb)
+{
+	struct iphdr *iphdr = ip_hdr(skb);
+
+	return (((u64)iphdr->daddr) << 8) | iphdr->tos;
+}
+
+static inline u32 hash_dst_cache_key(u64 key)
+{
+	return hash_64(key, DST_CACHE_INPUT_SHIFT) & DST_CACHE_INPUT_HASH_MASK;
+}
+
+struct dst_entry *dst_cache_input_get_noref(struct dst_cache *dst_cache,
+					    struct sk_buff *skb)
+{
+	struct dst_entry *out_dst = NULL;
+	struct dst_cache_pcpu *pcpu_cache;
+	struct dst_cache_pcpu *idst;
+	u32 hash;
+	u64 key;
+
+	pcpu_cache = this_cpu_ptr(dst_cache->cache);
+	key = create_dst_cache_key_ip4(skb);
+	hash = hash_dst_cache_key(key);
+	idst_for_each_in_bucket(idst, pcpu_cache, hash) {
+		if (key == idst->key) {
+			out_dst = __dst_cache_input_get_noref(idst);
+			goto out;
+		}
+	}
+out:
+	return out_dst;
+}
+
+static void dst_cache_input_reset_now(struct dst_cache *dst_cache)
+{
+	struct dst_cache_pcpu *caches;
+	struct dst_cache_pcpu *idst;
+	struct dst_entry *dst;
+	int i;
+
+	for_each_possible_cpu(i) {
+		caches = per_cpu_ptr(dst_cache->cache, i);
+		idst_for_each_in_cache(idst, caches) {
+			idst->key = INVALID_DST_CACHE_INPUT_KEY;
+			dst = idst->dst;
+			if (dst)
+				dst_release(dst);
+		}
+	}
+}
+
+static int __net_init dst_cache_input_net_init(struct net *net)
+{
+	struct dst_cache *dst_cache = net_generic(net, dst_cache_net_id);
+
+	dst_cache->cache = alloc_percpu_array_gfp(struct dst_cache_pcpu,
+						  DST_CACHE_INPUT_SIZE,
+						  GFP_KERNEL | __GFP_ZERO);
+	if (!dst_cache->cache)
+		return -ENOMEM;
+
+	dst_cache_input_reset_now(dst_cache);
+	return 0;
+}
+
+static void __net_exit dst_cache_input_net_exit(struct net *net)
+{
+	struct dst_cache *dst_cache = net_generic(net, dst_cache_net_id);
+
+	dst_cache_input_reset_now(dst_cache);
+	free_percpu(dst_cache->cache);
+	dst_cache->cache = NULL;
+}
+
+static inline bool idst_empty(struct dst_cache_pcpu *idst)
+{
+	return idst->key == INVALID_DST_CACHE_INPUT_KEY;
+}
+
+void dst_cache_input_add(struct dst_cache *dst_cache, const struct sk_buff *skb)
+{
+	struct dst_cache_pcpu *entry = NULL;
+	struct dst_cache_pcpu *pcpu_cache;
+	struct dst_cache_pcpu *idst;
+	u32 hash;
+	u64 key;
+
+	pcpu_cache = this_cpu_ptr(dst_cache->cache);
+	key = create_dst_cache_key_ip4(skb);
+	hash = hash_dst_cache_key(key);
+	idst_for_each_in_bucket(idst, pcpu_cache, hash) {
+		if (idst_empty(idst)) {
+			entry = idst;
+			goto add_to_cache;
+		}
+		if (!entry || time_before(idst->refresh_ts, entry->refresh_ts))
+			entry = idst;
+	}
+
+add_to_cache:
+	dst_cache_input_set(entry, skb_dst(skb), key);
+}
+
+static struct pernet_operations dst_cache_input_ops __net_initdata = {
+	.init = dst_cache_input_net_init,
+	.exit = dst_cache_input_net_exit,
+	.id   = &dst_cache_net_id,
+	.size = sizeof(struct dst_cache),
+};
+
+int __init dst_cache_input_init(void)
+{
+	return register_pernet_subsys(&dst_cache_input_ops);
+}
+subsys_initcall(dst_cache_input_init);
-- 
2.34.1


