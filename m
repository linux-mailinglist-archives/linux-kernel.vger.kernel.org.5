Return-Path: <linux-kernel+bounces-61437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8A851253
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816011F21891
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E200B39852;
	Mon, 12 Feb 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8b1V8/h"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBF39843;
	Mon, 12 Feb 2024 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737626; cv=none; b=saNAl4C9nkiSAfP/Xj+chYspm7MKJVNouOtJ0ytd8kQaHZ/2OtxFe0ZfPc7Gdu4ICksxVmqBhkf/tbOkuHAdCs6ogB/VING4ZkqPydIv4ITiItpB1B8GE2YuRjcImWUTIxe0CHNTk5Dsn6BnrKW7CsYWIlIrU+HX1s3N3p9bJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737626; c=relaxed/simple;
	bh=mqXV0hyS2M2iYooMn7ioshg5LKok7w/6AGMAEnz3aH0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=LAqhE2s71CuY/nu9VJy2s23O1GHH144Ml90EW0SxbAab5mXk2YOjb1fbmxb3O40rSb63w7t/LAhaJPgB+Fuy5jZJtXkdUA4B0s/zidjSp8UkTZdsRntEYlGzfSpqIdSgVwGFD/7OP9wHTrP+VRoq9nXc3PqbFkFtILr4FOq/udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8b1V8/h; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4114e0a2978so1620745e9.3;
        Mon, 12 Feb 2024 03:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707737622; x=1708342422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4RM3XtgRsxdOxtEq0mpMcqUSwQfxyCSmxhKMJArBMY=;
        b=M8b1V8/hrmGe3LifOUNgcikUwn1W149NGI/n6NRpKIh8h2e8tv7JFE5hD6/voufF9C
         CNtHOhnPfoe15Zeh4oGWEVn+rnaIg7Wz4qfvBiBVwo5ZDLnZgMMObPIBK0T4aaJhx+cx
         /LFbMO8w6f5g2KW0bMDECcKbaKFl4rFBwz1fJ0bWQHhpa4213n4v2f2UJ9zc2599Ft5Z
         x393e/Yf1oDFnnaaia6ViF3M0/QMFTVfeeXDccmVaTZ0vya0d5pphZoQFdvZOkiqBmEN
         6MmPcIrGBE2kwdkoF1p204eForN0/fPjaiuNqxOcYG2Tba9buENv1vuLmXooODUwppLS
         JrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707737622; x=1708342422;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4RM3XtgRsxdOxtEq0mpMcqUSwQfxyCSmxhKMJArBMY=;
        b=A/q9Z25SYufVx596pcPzbsI4vXabps2lsCntpkuyqq3+kSoNZ9pWIMFaFSynvrdffF
         XfTFxq5wq1ww1E2760jZTCRj9RMwkhSyBbrWTozQez42oORE8oXR1+f/Z2bhIq4BU35+
         QewjiJuQsR1V0anKav1wGo3oywY8UZj1HCNCiOjtDTfcyGbP19cm/8Gn3d18qSCd+yqM
         Gv1PBmuuAH/61j8/8K9gdJpndn60K7gleDfeHdRKuIdb+vbEap4UwJ+Xg6b968MsVxlD
         fKBljimVh97qjTl9zTW7L/NtTsQeQEjZ14rLpQh+PSb1G+CAg8ckB82rpjPTC8hucthv
         7D4A==
X-Gm-Message-State: AOJu0YwMlVoTRUPnfFuhfuiymKxwB4jk2nUUAvrZ9gdbVXpV93F7vR2R
	1k+2YkBJuQTgOc3d/eSVVsS30xONp7tyCL3R4ipJs/LjZCZZykGp
X-Google-Smtp-Source: AGHT+IF8lCQ9H9UHQDWHngPiP0IoMu0v1EzVcByJlsBMzmgeyFwRzihVmI5i8QIy4sw+lXrTmYxrww==
X-Received: by 2002:a05:600c:5117:b0:40f:df31:6cac with SMTP id o23-20020a05600c511700b0040fdf316cacmr6249594wms.4.1707737622142;
        Mon, 12 Feb 2024 03:33:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUA45XIDOyYDC4wHrktsI/4PTgHN4p7Gpf+se0FZytCCE3HTGdzfnYW2ajIGLk/hbgTCEdVPWdEH3YjrIdI/U68/7amcytHCvYPkE5k2RyteXeYQ2V19jwk6lIZXDQxr2c0Wcpq8K0rtcY6b78fFVAf/VSskOEi3f2m9H0NmqaIIcgyCR8YI89FlKuzbIxnx4bketGycCd3YCHU0nRGF6su0HFwwGUpOOge9BKxxVYAWFg=
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b004106c2278eesm8459064wmq.0.2024.02.12.03.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:33:41 -0800 (PST)
Message-ID: <52164b40-2074-4cfd-aeb4-c1a322976eba@gmail.com>
Date: Mon, 12 Feb 2024 12:33:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [RFC PATCH net-next v2 2/3] net: dst_cache: add input_dst_cache API
Content-Language: en-US
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <3a17c86d-08a5-46d2-8622-abc13d4a411e@gmail.com>
In-Reply-To: <3a17c86d-08a5-46d2-8622-abc13d4a411e@gmail.com>
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
 include/net/dst_cache.h |  69 +++++++++++++++++++++
 net/core/dst_cache.c    | 132 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index df6622a5fe98..4c5474c44cad 100644
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
@@ -106,4 +134,45 @@ int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp);
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
+
 #endif
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 0ccfd5fa5cb9..e551b9ce5108 100644
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
+	dst_cache->cache = (struct dst_cache_pcpu __percpu *)alloc_percpu_gfp(struct dst_cache_pcpu[DST_CACHE_INPUT_SHIFT],
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


