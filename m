Return-Path: <linux-kernel+bounces-151686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F58AB208
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035591F20FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E5613172E;
	Fri, 19 Apr 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5JXUbHs"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9377F13;
	Fri, 19 Apr 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540998; cv=none; b=GNSD3a9krFYvQRgojtHdiChTmCnOkRVbSUsQzL1EowbTZ15dKhlh63QA/gASehn/JhljfWB1vEdppxBoShuS/4IMB2c01TtyEqfwcab76BItwozCz/WkIej8zQRq1LjgzDaoDVuUle7UnXhWc3t5XR4ZAOwKK/Jo/jXhd9b+4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540998; c=relaxed/simple;
	bh=Skui0WZke+2fDXRGytHsLEi0moy7ejJAoZnm+XJZrQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NUIu5rvVHhOc7VotUPn0+AMk8HYnMqiXpHrFu24u0OO2fUEd1K/1beuBeheypRrB8pX2/AUpRrFfCG3jqocZq4pI0VkLlT19fYb6jUWWo1QgQcye3FLsFFIbh6D/Q3WdDEhMEkqDTtgOqlX/OnhUsytCC7S97iW678kCrxSx5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5JXUbHs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4155819f710so18258075e9.2;
        Fri, 19 Apr 2024 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713540995; x=1714145795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GonKnqV6NFhsZSk6EQZMWgxYIk8eQbiGI3oluYbyLQ=;
        b=g5JXUbHswa+ZfBOiRQMYptwBPiXhJy/Mmo4+D2ep5FlBNRQDUPcTiNoaWje1/AegeW
         U8KgeDyoX948zv7yuWOCARnRDBGTWraXGl/st0a5p8PrYNT06LY0gbfWQMr2mcc6Nd5R
         4x8YkxFAyOgWJuT03mXqi9M7wfKLH024F8rMPlWtEFmslZkZfTNhPZs9NE/ZSSmM/jBB
         2G8ZVAaNL5GLrbjchPhTM5QgZEP2QaIkprlv98UWRTKmckUiCV/X5hCUnHpkRktc94DR
         HaqrHSxYKj0LCxg9a6QT8iohHjJAIbjjk9vWeIKN9691bwdN3JaMhssAYdEIkEXvGcQi
         STwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540995; x=1714145795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GonKnqV6NFhsZSk6EQZMWgxYIk8eQbiGI3oluYbyLQ=;
        b=m57aBOT+QlBXAUwOXLGHfNMjgm1X0ctUftb1goBxpuIVHcq0UbI3A3uKURCCv4fhPd
         NCUF3qFp6bcV00U0ko+TADET7IlSVYGoh16MSyx+f9puBwLRMiDbUpKvgmwpP9N6c1VV
         e7q2jPmFzV7DlfQktapf3c52PC0bsB9K8+OEEwIMnjo4vMdi/qKlAa3xDeoXyG6qHArQ
         1EfKnhGeaZHqnUc5Ro/iB4wu5uGbhpsdaWJjlYPF1miS8LwYJHJ7O9p/9ve8Cy3E/In8
         IC6d85T3W250BG2a3yKIjlnxdpnxFC5Qzc0N2LMK8n4GKENR1NWLOL12y5iJfdTX71L1
         NRrg==
X-Forwarded-Encrypted: i=1; AJvYcCUC4ihZU7bJW6UGXvl3Lt4+rxZUDRIz0A+ej1VCr1Tpr5JwfHamVV+/7rFDWGoImRU12hpL3fqbGQhu6dYO8zix70UfBS1AW2XyPC5kJoxZBJ/E1AbbrK8hjd90R1Mh8yyd4TTj
X-Gm-Message-State: AOJu0YwvMbwMf0zaGCte1Vn2llvL95om1D3ioLJf2ldvItsHkSMM2ffp
	Ciivv0byEriwXfPT6l/pZsKKN/+Cr6HNkK989ResC+pvxrKfh6LO
X-Google-Smtp-Source: AGHT+IEA2dZ2+2gTMlOMW74UYs9uqReDRdBKc/JYC4amTWwcdL6sne/ikOqx/pwpI3rlyGBm9by0aw==
X-Received: by 2002:a05:600c:3b09:b0:418:969b:cb37 with SMTP id m9-20020a05600c3b0900b00418969bcb37mr1771696wms.39.1713540995081;
        Fri, 19 Apr 2024 08:36:35 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c310d00b004196c93da22sm1922124wmo.2.2024.04.19.08.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:36:34 -0700 (PDT)
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
Subject: [PATCH net v2 2/3] net: gro: fix udp bad offset in socket lookup
Date: Fri, 19 Apr 2024 17:35:41 +0200
Message-Id: <20240419153542.121087-3-richardbgobert@gmail.com>
In-Reply-To: <20240419153542.121087-1-richardbgobert@gmail.com>
References: <20240419153542.121087-1-richardbgobert@gmail.com>
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

To fix this issue, network_offsets union is used inside napi_gro_cb, in
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
 net/ipv4/udp.c         | 3 ++-
 net/ipv4/udp_offload.c | 3 ++-
 net/ipv6/udp.c         | 3 ++-
 net/ipv6/udp_offload.c | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

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


