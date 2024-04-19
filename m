Return-Path: <linux-kernel+bounces-151685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429588AB206
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2271F23D02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A966130E3B;
	Fri, 19 Apr 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlnZ2gp7"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1112FB34;
	Fri, 19 Apr 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540988; cv=none; b=BAFrqx3Vihu/jt7HY0svVm4rHkcO7I+T5/akeIhEX8L2nlVcf3gELfURtffGGm23g695iEYOKh3j2eLsytIVUXZceUUi8lDX9sh0wSTwKyEVCVqAY7sICAxKJ5CU0B4NQTRkFrWtSMP8XPNEdxVhzWb6cJXdCn21BxMo7lV7XPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540988; c=relaxed/simple;
	bh=WyEbXvtsNVWgOtX0bo1AxdKOIqpGQ7KA1yYW2GOQePw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0bNw6glZk+XIa4buC+88efwJtOssSUVsgT306xO0ofw6R26OrGpzbJKuUPCwif5Thb2s5Z/IYVwM9isJowGNY0r9L0W6vxzplDXiau09DLHztIZrOAmGu6Czb/ZbYyoN1+Fga97uBIe8mrRqOEgveX0etPYNTqCogyGar4DRa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlnZ2gp7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-419ca3f3dd0so3280805e9.2;
        Fri, 19 Apr 2024 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713540985; x=1714145785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9n1q4eRK+xzr5UrVS/+dPXTIvrcgwvHfK/8hZOcG+0=;
        b=BlnZ2gp7oJgeCB2nsNU7E57fwgqEYgJyVBWpv3VdVTbGY2eGwx41EVHy7mSnQfnSg/
         H6OdiXzhimeeIZSntcWn9tfyb1NP/0km7+3wKDs6iSMqr++an+0pEdpOlJkbRJzoa6CS
         yqM19HVyw4K8q8KwF+FdEzOyQ7hIMYYe7hXP3NlLpBPnneH1OR2lVklx/blIwVnOXsW7
         o5Fuj/z2utfypaeuchdFL6vaYDl2KRbL+dQEJzOxr+uBq8qocvCHGs2vuKJNm9PydEuP
         +ZFyd3FanTyrQ84bid5AETY5qymaF5rd5MsZ2m8fxkHw2umxOrhRxV87LR2dseX5hyoY
         uG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540985; x=1714145785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9n1q4eRK+xzr5UrVS/+dPXTIvrcgwvHfK/8hZOcG+0=;
        b=PWB6m/N5ja0pBRAazDg1J2Jhm+TSyekKGeldfc0SBCvQK/DrIrKN/VFmnRFMCiTJXS
         QRW6txCLw84L4fTyhOwXd+Yi+NmzlxISTvY0LOuLczlW54tnpD+f/fqz8m176C3/OxdQ
         G+w5PqyqDMwYIZkKtLt7ZoYnP7KZPWlfZq/JbUk+6Fj4NKz4djNtlJMwpKwre+Rq7OGL
         8DWvZClUHhwJGvvCN7EHoFt8JsHferaCXvJwUb0M+kgyMtFIXBLwS2CHFmlBo4waya7U
         GobNED3PFxsc9MFf0zfWODI9a/BxJi0nk0rDhA/VBFPOCkFJtDasKIE6PwYcNl64IvQG
         TcFg==
X-Forwarded-Encrypted: i=1; AJvYcCVkTrhJxM8IYlOXUgbN/0IBbKSq6oddb1y/ZtbuSjOQbLNndmxTaK/640YTzegcJhHabdDzLVNcZr5KvtRw3yoho08sJLl4lDByIY7PedYVk9UeoJZ+ojZXaaKvSA7QKIFqJK15
X-Gm-Message-State: AOJu0Yz6DnwqpLljzG+LB8DMc08Nh2npKHEshl7gcK81BYALFPFBDgxB
	/E/5LsF8PMelnZWjM6ryDjZ8zqZ4tLW6jdRJNm9QQiKxbqFMbFHf
X-Google-Smtp-Source: AGHT+IGkebQNQXL5Bql2j2QAwm4CyArSU2/bANJXhk1CnkRJFsC2cfBDKalHEZV2ORzogajm71nR3g==
X-Received: by 2002:a05:600c:4fcf:b0:418:ad02:913e with SMTP id o15-20020a05600c4fcf00b00418ad02913emr2325251wmq.12.1713540985313;
        Fri, 19 Apr 2024 08:36:25 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b00417ee886977sm10786939wmq.4.2024.04.19.08.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:36:25 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	alexander.duyck@gmail.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net v2 1/3] net: gro: add {inner_}network_offset to napi_gro_cb
Date: Fri, 19 Apr 2024 17:35:40 +0200
Message-Id: <20240419153542.121087-2-richardbgobert@gmail.com>
In-Reply-To: <20240419153542.121087-1-richardbgobert@gmail.com>
References: <20240419153542.121087-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds network_offset and inner_network_offset to napi_gro_cb, and
makes sure both are set correctly. In the common path there's only one
write (skb_gro_reset_offset, which replaces skb_set_network_header).

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/geneve.c           |  1 +
 drivers/net/vxlan/vxlan_core.c |  1 +
 include/net/gro.h              | 18 ++++++++++++++++--
 net/8021q/vlan_core.c          |  2 ++
 net/core/gro.c                 |  1 +
 net/ethernet/eth.c             |  1 +
 net/ipv4/af_inet.c             |  5 +----
 net/ipv4/gre_offload.c         |  1 +
 net/ipv6/ip6_offload.c         |  8 ++++----
 9 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 6c2835086b57..6549348cc24e 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -542,6 +542,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 	if (!ptype)
 		goto out;
 
+	NAPI_GRO_CB(skb)->inner_network_offset = hlen;
 	pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
 	flush = 0;
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ba319fc21957..c649a82eeca7 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -754,6 +754,7 @@ static struct sk_buff *vxlan_gpe_gro_receive(struct sock *sk,
 
 	vh = vxlan_gro_prepare_receive(sk, head, skb, &grc);
 	if (vh) {
+		NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
 		if (!vxlan_parse_gpe_proto(vh, &protocol))
 			goto out;
 		ptype = gro_find_receive_by_type(protocol);
diff --git a/include/net/gro.h b/include/net/gro.h
index 50f1e403dbbb..1faff23b66e8 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -87,6 +87,15 @@ struct napi_gro_cb {
 
 	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
 	__wsum	csum;
+
+	/* L3 offsets */
+	union {
+		struct {
+			u16 network_offset;
+			u16 inner_network_offset;
+		};
+		u16 network_offsets[2];
+	};
 };
 
 #define NAPI_GRO_CB(skb) ((struct napi_gro_cb *)(skb)->cb)
@@ -172,12 +181,17 @@ static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
 	return ptr;
 }
 
+static inline int skb_gro_network_offset(const struct sk_buff *skb)
+{
+	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
+}
+
 static inline void *skb_gro_network_header(const struct sk_buff *skb)
 {
 	if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
-		return skb_gro_header_fast(skb, skb_network_offset(skb));
+		return skb_gro_header_fast(skb, skb_gro_network_offset(skb));
 
-	return skb_network_header(skb);
+	return skb->data + skb_gro_network_offset(skb);
 }
 
 static inline __wsum inet_gro_compute_pseudo(const struct sk_buff *skb,
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index f00158234505..9404dd551dfd 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -478,6 +478,8 @@ static struct sk_buff *vlan_gro_receive(struct list_head *head,
 	if (unlikely(!vhdr))
 		goto out;
 
+	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = hlen;
+
 	type = vhdr->h_vlan_encapsulated_proto;
 
 	ptype = gro_find_receive_by_type(type);
diff --git a/net/core/gro.c b/net/core/gro.c
index 83f35d99a682..c7901253a1a8 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -371,6 +371,7 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
 	const skb_frag_t *frag0;
 	unsigned int headlen;
 
+	NAPI_GRO_CB(skb)->network_offset = 0;
 	NAPI_GRO_CB(skb)->data_offset = 0;
 	headlen = skb_headlen(skb);
 	NAPI_GRO_CB(skb)->frag0 = skb->data;
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 2edc8b796a4e..ea589e8cde2a 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -441,6 +441,7 @@ struct sk_buff *eth_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	skb_gro_pull(skb, sizeof(*eh));
 	skb_gro_postpull_rcsum(skb, eh, sizeof(*eh));
+	NAPI_GRO_CB(skb)->inner_network_offset = hlen;
 
 	pp = indirect_call_gro_receive_inet(ptype->callbacks.gro_receive,
 					    ipv6_gro_receive, inet_gro_receive,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 55bd72997b31..7899cbd5b263 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1568,10 +1568,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
 	NAPI_GRO_CB(skb)->flush |= flush;
-	skb_set_network_header(skb, off);
-	/* The above will be needed by the transport layer if there is one
-	 * immediately following this IP hdr.
-	 */
 
 	/* Note : No need to call skb_gro_postpull_rcsum() here,
 	 * as we already checked checksum over ipv4 header was 0
@@ -1597,6 +1593,7 @@ static struct sk_buff *ipip_gro_receive(struct list_head *head,
 	}
 
 	NAPI_GRO_CB(skb)->encap_mark = 1;
+	NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
 
 	return inet_gro_receive(head, skb);
 }
diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index 5028c72d494a..a1ff2bdf6206 100644
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -224,6 +224,7 @@ static struct sk_buff *gre_gro_receive(struct list_head *head,
 	/* Adjusted NAPI_GRO_CB(skb)->csum after skb_gro_pull()*/
 	skb_gro_postpull_rcsum(skb, greh, grehlen);
 
+	NAPI_GRO_CB(skb)->inner_network_offset = hlen;
 	pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
 	flush = 0;
 
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index b41e35af69ea..765797ca729c 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -67,7 +67,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
 		off += len;
 	}
 
-	skb_gro_pull(skb, off - skb_network_offset(skb));
+	skb_gro_pull(skb, off - skb_gro_network_offset(skb));
 	return proto;
 }
 
@@ -236,8 +236,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	if (unlikely(!iph))
 		goto out;
 
-	skb_set_network_header(skb, off);
-
 	flush += ntohs(iph->payload_len) != skb->len - hlen;
 
 	proto = iph->nexthdr;
@@ -259,7 +257,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	NAPI_GRO_CB(skb)->proto = proto;
 
 	flush--;
-	nlen = skb_network_header_len(skb);
+	nlen = skb_gro_offset(skb) - off;
 
 	list_for_each_entry(p, head, list) {
 		const struct ipv6hdr *iph2;
@@ -327,6 +325,7 @@ static struct sk_buff *sit_ip6ip6_gro_receive(struct list_head *head,
 	}
 
 	NAPI_GRO_CB(skb)->encap_mark = 1;
+	NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
 
 	return ipv6_gro_receive(head, skb);
 }
@@ -342,6 +341,7 @@ static struct sk_buff *ip4ip6_gro_receive(struct list_head *head,
 	}
 
 	NAPI_GRO_CB(skb)->encap_mark = 1;
+	NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
 
 	return inet_gro_receive(head, skb);
 }
-- 
2.36.1


