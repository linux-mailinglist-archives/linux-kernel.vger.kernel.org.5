Return-Path: <linux-kernel+bounces-95919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF458754F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54ADE281FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649C0130E25;
	Thu,  7 Mar 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaahahW8"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4B12FF90;
	Thu,  7 Mar 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831579; cv=none; b=X34pnndo0uQQrISpLGB+5T1ibNdtsFzES4PKKxT9K062LogK5O9iG41+U3/gK+uWgZY+/9pRXhtPmyOEedMVeDaW8PlQ38eQdqAeEqgaYvsekjnyXgcohLa9kAgxAV+PHsgMXBo4f3tWliurzAxf0DTmFcrTH4cMPhMp9vn1EG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831579; c=relaxed/simple;
	bh=W/MumZVpisOIH0WGNOiLL/b9IywMSOOGhuiwYpsXbpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvjSHKpK69NWzO5FwB26KtS9LJZegl3WmGCF87RPS+MhcY6IxEk2MvHloHprbMVIBopwGEnCiEAu0U7newPDqnlG/YIJSgue4cDj3BBZGhFhRjAlEgR1tQO4Ufh0xlQeJnd5bd1eh9lgojv9nGii0OrB0WUMJuAOwTRr7iac428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaahahW8; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-412f1961101so11000985e9.0;
        Thu, 07 Mar 2024 09:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709831576; x=1710436376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7Ai7Y640JAmBstNBPvMR7Rlw25isJH8cGZXI5luHRI=;
        b=gaahahW8wgYGQMKaV9v5zbhOs09Fh/KbI+R02ggg6tR0SMy77u7xS3xzqbzAiUqwEQ
         vo9RcfqL3d8GJc6hOzGR7fAHcaFBHNz7XnOVRPa+brp7kI6/KXMmfH6wD27+gseKRZyt
         ZNa/iLZqNnqJUz8BAIARKCVD8ff8lUDyPuEUsyqC8T7as/TY8FO87O8JKVbprW+ac2ll
         h9o/9eiMnieayMBBe4UzPe1Xv+btRVGtPBq/ZWjRH1eOE0dKU+aYryu/QURrIgvopoEU
         sGO4dDJs8u6IFYMGThe8GW5vg9mrAp+lMYD3oxoiZsNcBz5yNqRtU/zqvCYWxfaRBVdA
         LSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709831576; x=1710436376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7Ai7Y640JAmBstNBPvMR7Rlw25isJH8cGZXI5luHRI=;
        b=gbzHr3ag7qNJdq+eeZGMYgKnUAUxmt+3HqpvOoocqkRiwdYzzdVEs39wy+pNJ02rrU
         ZC7nw1mgThcBteceWvNke76NDGjLjiSxKSleVbWNGWS2x3SIj2Fo5wdYgr1NWzkgi6i2
         DQhGnrfj+DiDU6KK85iHlhWuTJTO4ogUzgTNDc6moY0KGhwvQtJQIQnr4kJxKHNzkRLD
         87kJBLsguuBdGgMxS5UYcRltSV3MWHoaeqSHfQ+lUdaF2RgdHgnwVOt3IKzxoYQHFEP0
         cjR4FJM2mvyjzYwHd9rCxZDDb9zHku3lncUPD5Wsg0nnqeicEz8j3grIdCePcAiEnFUF
         RQEg==
X-Forwarded-Encrypted: i=1; AJvYcCXF+nLeVupK5J4Iuuf6OM3wkUW1WO/SQiw224TBMGj5rh8sQZefiCNj5i4l3AmqhCEz+CEITq7gftd7YSRcqYY7UDkZM+NIdiBcscRg
X-Gm-Message-State: AOJu0Ywb6eCVCVyeR4JR/eHzrQKDaZ6FGAJoC+07I8BOS0Gf3m7O4gGJ
	U6qnLR3isIcItg2J/XhevB45/LblGnOvg4zvh7h4RtCDsa6JuIt4
X-Google-Smtp-Source: AGHT+IH76QeD5yqt+yL0acN5cfjxH5a/KzxG6IU6HAzuH+a11C+gcrK6ns/w95lvnLZ+0KBoOUFbEQ==
X-Received: by 2002:a05:600c:1986:b0:413:14da:a9ec with SMTP id t6-20020a05600c198600b0041314daa9ecmr621128wmq.0.1709831575873;
        Thu, 07 Mar 2024 09:12:55 -0800 (PST)
Received: from localhost ([45.130.85.5])
        by smtp.gmail.com with ESMTPSA id er15-20020a05600c84cf00b00412ff07df2bsm3168611wmb.37.2024.03.07.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:12:55 -0800 (PST)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next 2/4] net: dst_cache: add input_dst_cache API
Date: Thu,  7 Mar 2024 18:12:00 +0100
Message-Id: <20240307171202.232684-3-leone4fernando@gmail.com>
In-Reply-To: <20240307171202.232684-1-leone4fernando@gmail.com>
References: <20240307171202.232684-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 include/net/dst_cache.h |  68 +++++++++++++++++++++
 net/core/dst_cache.c    | 132 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index df6622a5fe98..1c3b06f08d7d 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -7,12 +7,40 @@
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ip6_fib.h>
 #endif
+#include <net/ip.h>
+
+#define DST_CACHE_INPUT_SHIFT (9)
+#define DST_CACHE_INPUT_SIZE (1 << DST_CACHE_INPUT_SHIFT)
+#define DST_CACHE_INPUT_BUCKET_SIZE (4)
+#define DST_CACHE_INPUT_HASH_MASK (~(DST_CACHE_INPUT_BUCKET_SIZE - 1))
+#define INVALID_DST_CACHE_INPUT_KEY (~(u64)(0))
 
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
@@ -106,4 +134,44 @@ int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp);
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
 #endif
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 0ccfd5fa5cb9..245f5546a7ff 100644
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
@@ -181,3 +185,131 @@ void dst_cache_reset_now(struct dst_cache *dst_cache)
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
+	dst_cache->cache = (struct dst_cache_pcpu __percpu *)alloc_percpu_gfp(struct dst_cache_pcpu[DST_CACHE_INPUT_SIZE],
+									      GFP_KERNEL | __GFP_ZERO);
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
+static bool idst_empty(struct dst_cache_pcpu *idst)
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


