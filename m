Return-Path: <linux-kernel+bounces-164182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535298B7A50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DD01F23864
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAAE17994D;
	Tue, 30 Apr 2024 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do7bOgJM"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5342015278D;
	Tue, 30 Apr 2024 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488008; cv=none; b=E/BciuWuZh+Ftdaj7l//9vVIZ7sJvOwv14XwQyba+zSCBIt6z7WjUAMMzlr0KvpgATDPsFeJb3u+qUme65NkAj7PnCH3SNTYEgCglbN4m1VREKQqskL8KpDVVP1lJztttMmHM45dXk2Nf4O1HfRdBcVTNyXjIbeqN1UOYsvQ6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488008; c=relaxed/simple;
	bh=A+OPzocrLD3Xd3QJErQ0Q24dz3nHCPULLiKW4VsIiWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfoOMrgcwkJ1oN6rJnnysfNMqjqfNH7cB9//moKAT3blazt/sgZyMSiIGUFkyLj68hPVdzesV4/SzPTuxHDNUbXMrCNaz+A0UsT9QHRRNzNYLFdp+Gcr5CGx7bN5L/hqM4ZfcHjcAgv/MzOPcooyOIkoU7c7ygKisdtCNkIabfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do7bOgJM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b79450f78so32505605e9.2;
        Tue, 30 Apr 2024 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488004; x=1715092804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9ZGEzc23qTzdRNxofLpSXDaT0ONxA1Z7U4XHdfwje0=;
        b=do7bOgJMLmcYwThxCwTkcKxopgUKNLJrRMFMASi8mhLfZOIhjz8qEyYEBLfNE87g3E
         vbbjpWHiSevCkMsKwCl/+ASKhzbSTtVe7GsVDgPg33tjl9i5MC76rRZmo9zH5VerHV0v
         rDs5zDiENqesx3STnkeJfoNaECAV4L6deyPAX6DI3uAXvW1BX4Dzhw3fkzaAgT7ou9Sw
         2jSx+EOR+Fo2Pwo2b2pWQVXktF3neKXyvpE6qFdrrogMSkf7nqoOAiVI2Utjdh+dryEJ
         o29VkVr2wsF/lS7rf3wpODiHsz8S1qkfeZg9wrCo5Rcfv65HmecOMDASHX+PXAC2sOZ9
         /tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488004; x=1715092804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9ZGEzc23qTzdRNxofLpSXDaT0ONxA1Z7U4XHdfwje0=;
        b=iU7QwH+GADkJKyRFlaxqKEW71z6uHbdKo7lQpIBK+q5zwjlygL0K0p0dGIrNnI/wJ4
         8v6JDWXW2OzDIXK87iqlq54RFt7lHQTSX3xkImzez0Q+iJwvbNJj6sVz7Gy8+aDbzFG4
         Fv0+RJ+qzT6IpmRoBBhaav7qMKNLUeIc3TQLMlhjXOnQNPEMGvN1ldj9t/pZlG6ySsM6
         KsBVWgqiZESJM5EE1+A1Zy3vFWvkzUe3fPrbdZGu2oTxn2hwtHsWEMeCUdH5zxsu1T51
         xGD+JNNhNpfuW9qbJcrjvi7sktVdSJX42yTpiFYTfHmRJlFZnxo5L8QS5PfIqkBKnx3k
         nwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBQW7V1OQ5+AODk7WPI4O5wKuTJg93VBmgX5fiqoJRaBAfFngAQ5GmML1CCsoE81c/xWn5su7bsN1u4th0GUn7J6YRrE7giyWhoFPsjWJRCLkgYSBhDHFbJHD2N1oSQXBybnGG
X-Gm-Message-State: AOJu0YzviFf/zFdzKXBN55FieOF2Y+QyATHKjflbdjHzUzt9M9Y5UuMt
	cfvKt/WHwVMwJo7Lm5JfQ3jjeejSjcRv/nu5KRf3ovbsFTylwa7o
X-Google-Smtp-Source: AGHT+IH/E2II5sQ1H+iCFdB3ZXeXzFkyv7sljrFx/E2eguOvTA1T14+rFA5+63t8WTDhC4nMekTThQ==
X-Received: by 2002:a05:600c:474d:b0:41b:f106:bb89 with SMTP id w13-20020a05600c474d00b0041bf106bb89mr9259902wmo.18.1714488004258;
        Tue, 30 Apr 2024 07:40:04 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b0041a9fc2a6b5sm28763334wmo.20.2024.04.30.07.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:40:04 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	alobakin@pm.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net v4 1/2] net: gro: fix udp bad offset in socket lookup by adding {inner_}network_offset to napi_gro_cb
Date: Tue, 30 Apr 2024 16:35:54 +0200
Message-Id: <20240430143555.126083-2-richardbgobert@gmail.com>
In-Reply-To: <20240430143555.126083-1-richardbgobert@gmail.com>
References: <20240430143555.126083-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
complete phase of gro. The functions always return skb->network_header,
which in the case of encapsulated packets at the gro complete phase, is
always set to the innermost L3 of the packet. That means that calling
{ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
L3/L4 may return an unexpected value.

This incorrect usage leads to a bug in GRO's UDP socket lookup.
udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
*_hdr functions return network_header which will point to the innermost L3,
resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
encapsulated packets.

This patch adds network_offset and inner_network_offset to napi_gro_cb, and
makes sure both are set correctly.

To fix the issue, network_offsets union is used inside napi_gro_cb, in
which both the outer and the inner network offsets are saved.

Reproduction example:

Endpoint configuration example (fou + local address bind)

    # ip fou add port 6666 ipproto 4
    # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap fou encap-dport 5555 encap-sport 6666 mode ipip
    # ip link set tun1 up
    # ip a add 1.1.1.2/24 dev tun1

Netperf TCP_STREAM result on net-next before patch is applied:

net-next main, GRO enabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.28        2.37

net-next main, GRO disabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.01     2745.06

patch applied, GRO enabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.01     2877.38

Fixes: 57c67ff4bd92 ("udp: additional GRO support")
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      | 9 +++++++++
 net/8021q/vlan_core.c  | 2 ++
 net/core/gro.c         | 1 +
 net/ipv4/af_inet.c     | 1 +
 net/ipv4/udp.c         | 3 ++-
 net/ipv4/udp_offload.c | 3 ++-
 net/ipv6/ip6_offload.c | 1 +
 net/ipv6/udp.c         | 3 ++-
 net/ipv6/udp_offload.c | 3 ++-
 9 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 50f1e403dbbb..c1d4ca0463a1 100644
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
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 55bd72997b31..fafb123f798b 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1572,6 +1572,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	/* The above will be needed by the transport layer if there is one
 	 * immediately following this IP hdr.
 	 */
+	NAPI_GRO_CB(skb)->inner_network_offset = off;
 
 	/* Note : No need to call skb_gro_postpull_rcsum() here,
 	 * as we already checked checksum over ipv4 header was 0
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c02bf011d4a6..1399fce82b3f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -532,7 +532,8 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 3498dd1d0694..fd29d21d579c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -718,7 +718,8 @@ EXPORT_SYMBOL(udp_gro_complete);
 
 INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index b41e35af69ea..c8b909a9904f 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -237,6 +237,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 		goto out;
 
 	skb_set_network_header(skb, off);
+	NAPI_GRO_CB(skb)->inner_network_offset = off;
 
 	flush += ntohs(iph->payload_len) != skb->len - hlen;
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8b1dd7f51249..f7880e306410 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -272,7 +272,8 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport)
 {
-	const struct ipv6hdr *iph = ipv6_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
 	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index bbd347de00b4..b41152dd4246 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -164,7 +164,8 @@ struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 {
-	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct ipv6hdr *ipv6h = (struct ipv6hdr *)(skb->data + offset);
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
-- 
2.36.1


