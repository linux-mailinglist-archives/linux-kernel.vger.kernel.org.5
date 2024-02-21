Return-Path: <linux-kernel+bounces-74497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51CC85D529
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220501C20D30
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502ED41233;
	Wed, 21 Feb 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmEFHB7x"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C940C04;
	Wed, 21 Feb 2024 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509855; cv=none; b=PhHwLWGw2gUnknuomNxp4jgQ5OcExpwZndkuu/qlT6Ijkr+HU4xzZM0r+aPrlf672DIxlyvBZZKqIRtrRisY47lnXDuIEFqhw+f2+DugcSKaYv4f8N8nZnPkUbcS1Uwsux/shpYIbl7osOO+TkFpU77Y9kBDAJ4OG6l6E4HV4Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509855; c=relaxed/simple;
	bh=DmWszk/Ye9Jn3KmaFwmIcZjwP7k88JzY9zTnMSgWsE4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=OSTK2zTdG+okXbETQJm3+EiFuZxlwbXs6G41wvn7dCGdWxSaqK9I9hxnx/FfPTR65jtEak0ddGPaw159rvK2lqS/YG7u8mXYinklMnAz6H2b6Tdm15hw1UnUIh+MbuAD0Zp7CS++4G7uv7KFfdg1u7AH3cW8FttdGnKMj5YbOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmEFHB7x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412767742a0so2704355e9.3;
        Wed, 21 Feb 2024 02:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708509852; x=1709114652; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dTtnvTw6zWyGZ1jeu46KqH+MoeXT/VcdlQfXZJxoo10=;
        b=BmEFHB7xDdDm4mYzwdbAQ6u1LQ81nq7VV8UcwF3ImP6WhniZiVSK3DLJ7A0WMEtAb5
         WDYqKJDLGU5iIj03Obnsy106cJYBCjQlq87yPwlRFhUL7PaHcobeWxzNswMLcuH9EBGs
         S/9aShpLLhOjglxQap8ba4P8TpDlCDQgNh2sJva1Y5OVRaB+iO6mPB2Y8pl872vozgXF
         FYH4eb/L7o8teqTAkIFMFswSDwj9TrkcjNtGL0FrBXrBU5PEaWU/9C5VYWHl+xg+hfDp
         3l7SAnLV7myhMbp9qJmHf5X0Y4K2eQ1GXpvsRmbmXCcYdTTyEgZckoZjqrs1d3ouXJkz
         xeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708509852; x=1709114652;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTtnvTw6zWyGZ1jeu46KqH+MoeXT/VcdlQfXZJxoo10=;
        b=fGuZg+wDqZmub6B/+umqYNyh++XGd9fGiNq6QDM90SAJ+aaaEIj55pLLH0af8VBxjT
         7Np9X+Kg7qvny2Nta4jO63W2XT0BUvCUMAXKG0xKVNX/X/sXdvlqyQ2FmwLcVIRRgPDv
         8wzsZX7HIB+WtD3nM3fiNqFc/mISkK3jJ1tAFp73gmuz5iDG1uc0LL+5tbljCHsKYNHh
         PiGDXG0/sUeaQsLoMDdQMeRN0LeV75XZ6wm6edA9iJj4nolQQQFlpNWpn+2yiXyFAsyL
         XVZj8C3y4gQMsfG/9xvPd3iOB3srcgZrLUrrwOeVjSNQ+tXW4LMCJAqazra96VFjDfYA
         mHDA==
X-Forwarded-Encrypted: i=1; AJvYcCU8NuCj/3bLVCtDPxgmcpwN5jJ6Y7CBknaBdSxJXLpY4FfLI3ulkE1IH55xXjK50NhKLvxf2J3K52hZOKrHLmWevQcT9n5SWc04znaDSJQ68RWXlAIPjBTTD1NLx0bcFpEAW6FW
X-Gm-Message-State: AOJu0YyUvnrxUXXq97ajjMDt6iDm58mSOCg1lNgKAhn+VzvOIL2Ia8cH
	tDBX10MOTTGfqqKUKpWe/B0WTb+DY/8bTxfPxFyZy+40sJ8esjCNoCq3dMSO
X-Google-Smtp-Source: AGHT+IGX3kfg8r06Yv1Cun+hxszxL6sFqDYY2MKBreoXNuzOUyisQLztwXWlPcIMuV6yJWU78tAAPA==
X-Received: by 2002:a05:600c:260e:b0:410:6a8b:6937 with SMTP id h14-20020a05600c260e00b004106a8b6937mr13733054wma.37.1708509851818;
        Wed, 21 Feb 2024 02:04:11 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d610f000000b0033d4cf751b2sm9651612wrt.33.2024.02.21.02.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 02:04:11 -0800 (PST)
Message-ID: <9b82bb29-9316-4dfd-8c56-f8a294713c16@gmail.com>
Date: Wed, 21 Feb 2024 11:03:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v1] net: ipv6: hop tlv ext hdr parsing
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch introduces 'hop_tlv_hdr' and 'hop_calipso_hdr' structs, in
order to access fields in a readable way in "ip6_parse_tlv".

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/ipv6.h | 16 ++++++++++++++++
 net/ipv6/exthdrs.c | 30 +++++++++++++++++-------------
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index cf25ea21d770..61677946ed46 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -151,6 +151,22 @@ struct frag_hdr {
 	__be32	identification;
 };
 
+struct hop_tlv_hdr {
+	u8	tlv_type;
+	u8	tlv_len;
+};
+
+/* CALIPSO RFC 5570 */
+struct hop_calipso_hdr {
+	u8	tlv_type;
+	u8	tlv_len;
+	u32	domain_interpretation;
+	u8	cmpt_len;
+	u8	sens_lvl;
+	u16	checksum;
+	u64	cmpt_bitmap;
+} __packed;
+
 /*
  * Jumbo payload option, as described in RFC 2675 2.
  */
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 4952ae792450..5db624299da4 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -114,7 +114,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
 			  struct sk_buff *skb,
 			  int max_count)
 {
-	int len = (skb_transport_header(skb)[1] + 1) << 3;
+	int len = ipv6_optlen((struct ipv6_opt_hdr *)skb_transport_header(skb));
 	const unsigned char *nh = skb_network_header(skb);
 	int off = skb_network_header_len(skb);
 	bool disallow_unknowns = false;
@@ -890,15 +890,16 @@ static inline struct net *ipv6_skb_net(struct sk_buff *skb)
 
 static bool ipv6_hop_ra(struct sk_buff *skb, int optoff)
 {
-	const unsigned char *nh = skb_network_header(skb);
+	struct hop_tlv_hdr *tlv_hdr =
+		(struct hop_tlv_hdr *)(skb_network_header(skb) + optoff);
 
-	if (nh[optoff + 1] == 2) {
+	if (tlv_hdr->tlv_len == 2) {
 		IP6CB(skb)->flags |= IP6SKB_ROUTERALERT;
-		memcpy(&IP6CB(skb)->ra, nh + optoff + 2, sizeof(IP6CB(skb)->ra));
+		memcpy(&IP6CB(skb)->ra, tlv_hdr + 1, sizeof(IP6CB(skb)->ra));
 		return true;
 	}
 	net_dbg_ratelimited("ipv6_hop_ra: wrong RA length %d\n",
-			    nh[optoff + 1]);
+			    tlv_hdr->tlv_len);
 	kfree_skb_reason(skb, SKB_DROP_REASON_IP_INHDR);
 	return false;
 }
@@ -961,18 +962,20 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 
 static bool ipv6_hop_jumbo(struct sk_buff *skb, int optoff)
 {
-	const unsigned char *nh = skb_network_header(skb);
+	int tlv_off = offsetof(struct hop_jumbo_hdr, tlv_type);
+	struct hop_jumbo_hdr *jumbo_hdr = (struct hop_jumbo_hdr *)
+		(skb_network_header(skb) + optoff - tlv_off);
 	SKB_DR(reason);
 	u32 pkt_len;
 
-	if (nh[optoff + 1] != 4 || (optoff & 3) != 2) {
+	if (jumbo_hdr->tlv_len != 4 || (optoff & 3) != 2) {
 		net_dbg_ratelimited("ipv6_hop_jumbo: wrong jumbo opt length/alignment %d\n",
-				    nh[optoff+1]);
+				    jumbo_hdr->tlv_len);
 		SKB_DR_SET(reason, IP_INHDR);
 		goto drop;
 	}
 
-	pkt_len = ntohl(*(__be32 *)(nh + optoff + 2));
+	pkt_len = ntohl(jumbo_hdr->jumbo_payload_len);
 	if (pkt_len <= IPV6_MAXPLEN) {
 		icmpv6_param_prob_reason(skb, ICMPV6_HDR_FIELD, optoff + 2,
 					 SKB_DROP_REASON_IP_INHDR);
@@ -1004,15 +1007,16 @@ static bool ipv6_hop_jumbo(struct sk_buff *skb, int optoff)
 
 static bool ipv6_hop_calipso(struct sk_buff *skb, int optoff)
 {
-	const unsigned char *nh = skb_network_header(skb);
+	struct hop_calipso_hdr *calipso_hdr =
+		(struct hop_calipso_hdr *)(skb_network_header(skb) + optoff);
 
-	if (nh[optoff + 1] < 8)
+	if (calipso_hdr->tlv_len < 8)
 		goto drop;
 
-	if (nh[optoff + 6] * 4 + 8 > nh[optoff + 1])
+	if (calipso_hdr->cmpt_len * 4 + 8 > calipso_hdr->tlv_len)
 		goto drop;
 
-	if (!calipso_validate(skb, nh + optoff))
+	if (!calipso_validate(skb, (const unsigned char *)calipso_hdr))
 		goto drop;
 
 	return true;
-- 
2.36.1

