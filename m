Return-Path: <linux-kernel+bounces-101489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C187A7C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6C1B231E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49532BB09;
	Wed, 13 Mar 2024 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b="kAJNGphh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HHcl5cpc"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0641392;
	Wed, 13 Mar 2024 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333991; cv=none; b=k6VV/guIAqDWjN3i0Zv8DXorUVZsjdV+oUnZZhwUFoElUBhMp3m7goa98Ubm084JL+R9PyU1cGM5T9vwE/R3wH2rwuUE/Ffh/OQHm2xDkyQECnnKJc7TY8IdEICHux+i1OhOpdiNZTlppIzqosShgwaIfbyEhml48RmT2JQFdvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333991; c=relaxed/simple;
	bh=Jf+wu1IZHLSWPSiVXKPRin5lWsBglxHwN2VUQsB6oqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0rkeuhseD9Z7OPCY52+vEXxKPJzBVNRHzhe8P64K2psUQzCVH5j3+sYAzai+t/HaEDBeVMleMX1O64U/EbQbTLFmsutGsQhUrFNd9suz0y4GFNKZYsul4S9GY/XZz07njM7Vg0AVBkRSnKFiNt191zzN4TIhV51v3sfnOz/0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl; spf=pass smtp.mailfrom=yotsuba.nl; dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b=kAJNGphh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HHcl5cpc; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yotsuba.nl
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 60B0918001BB;
	Wed, 13 Mar 2024 08:46:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 13 Mar 2024 08:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1710333985; x=1710420385; bh=l1HL0LHZYJaa4pEADEaCe
	pA+q5O8TlifflcHnra0QqM=; b=kAJNGphhutQWSqDwIPVWxfX4B2Ls6qyt5SRAb
	7mscMZZWQjWk9d+DKHTAELnkGvKlB+8017xTnuA0HnjRMUM5g8TUfnUcAvNsdjCh
	gjOQ6+XVDbVyOaulxtW1oJVax6oyX6W1e0RFolTaTQf4l55MsmLsT5/sP6xipVtT
	NhppMje77RVMp6ELAF06ZcshSnRL0TSlhrbYY2bg+H2kFtjVA/ugWkDMo+XT6o05
	RNTff7PTG+Hb69F/EtKaH5pzBiUs+6OHCnYon3tMDe3rOEFnnd5OqV8h+dViddqa
	vsp/7rMcNeXnNDWYa7Gg3V0AqF9m+7t1UtGYzt0IK4OTuqiSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710333985; x=1710420385; bh=l1HL0LHZYJaa4pEADEaCepA+q5O8
	TlifflcHnra0QqM=; b=HHcl5cpcVWs3sCINvtq5T/1HVVqtVnSoaqDJ+lfZFmng
	mQqHieWuRJlf1YvxUFGlAExb9NtoygRgJV9P58Ymh7Iv6CIwB0DTpVFnY6MhESQY
	MtaL3z8ekwp+SoxerKuDxc4TcxmJasCCmDa/+qUJdFFUtTdRU1E0OBftZ4JnujMW
	/nsvKmBA2UjcAghK23tB3NkOjVMUzO569kalXSsHUOKoPwSL8cb0X045OlKn2jEH
	Yths4QGBRbuh8gXsP6bv/z5uGcgZxo49qXoyTMTxP43rqMMJsk/zQP3oxXhFmGd/
	NEaM21O/4nwY30ZvdqGnX9xDbaiY+3X9l2Q7Ycokkw==
X-ME-Sender: <xms:IaDxZap81TWSO2g5QIK2km_GZu-LqECRZhOdYSRnu8puVCP0b1yRYw>
    <xme:IaDxZYrslFq5N23pWbj6KYIxMca8VkhZvVPk9u-z4DBq9fOYTEYkUF1nnh9czCjcv
    RShwgVxVpMGh3FZaWk>
X-ME-Received: <xmr:IaDxZfMKhRCJtpIYUzx0H4T3cBDZpcOOjIhCymrcXvvI2wpnr6GYUZjDqHJrkw9vIZPnuaUuePjrVSAvHmdpIMADbSiupw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcuvehi
    lhhishhsvghnuceomhgrrhhkseihohhtshhusggrrdhnlheqnecuggftrfgrthhtvghrnh
    epfffftdevgfffgfdvveduteeufeetfeejueehledvtdekjeeuleegvdfhtdettdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhkse
    ihohhtshhusggrrdhnlh
X-ME-Proxy: <xmx:IaDxZZ5nY6ciN-dnoz249BIkV0vJ0mxOO1rE7le5f-YEqH5awpdhZA>
    <xmx:IaDxZZ7WVlpXExDIQcdJzm1JEmWOXhC0xDG6RPRBw0rrmt2Mwjbvhg>
    <xmx:IaDxZZjxWdqI7JAy1tBwd36_lPFw9NncOVUVHPF-RT1cZrxl4MWDHA>
    <xmx:IaDxZT7_F8LrOOMz4-fDHVjrTCZ3b-zHG_PkJhCRAivz4JFjALnOLw>
    <xmx:IaDxZViaL9wJmMDlfb23u4TaU6iNF4-GoTRXawbb6mFcQkqe5xczD5ugnK4>
Feedback-ID: i85e1472c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 08:46:24 -0400 (EDT)
From: Mark Cilissen <mark@yotsuba.nl>
To: netdev@vger.kernel.org
Cc: Mark Cilissen <mark@yotsuba.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Ingo Molnar <mingo@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netpoll: support sending over raw IP interfaces
Date: Wed, 13 Mar 2024 13:46:13 +0100
Message-ID: <20240313124613.51399-1-mark@yotsuba.nl>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, netpoll only supports interfaces with an ethernet-compatible
link layer. Certain interfaces like SLIP do not have a link layer
on the network interface level at all and expect raw IP packets,
and could benefit from being supported by netpoll.

This commit adds support for such interfaces by using the network device's
`hard_header_len` field as an indication that no link layer is present.
If that is the case we simply skip adding the ethernet header, causing
a raw IP packet to be sent over the interface. This has been confirmed
to add netconsole support to at least SLIP and WireGuard interfaces.

Signed-off-by: Mark Cilissen <mark@yotsuba.nl>
---
 Documentation/networking/netconsole.rst |  3 ++-
 net/core/netpoll.c                      | 30 ++++++++++++++++---------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index d55c2a22ec7a..434ce0366027 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -327,4 +327,5 @@ enable the logging of even the most critical kernel bugs. It works
 from IRQ contexts as well, and does not enable interrupts while
 sending packets. Due to these unique needs, configuration cannot
 be more automatic, and some fundamental limitations will remain:
-only IP networks, UDP packets and ethernet devices are supported.
+only UDP packets over IP networks, over ethernet links if a
+hardware layer is required, are supported.
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 543007f159f9..0299fb71b456 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -399,7 +399,7 @@ EXPORT_SYMBOL(netpoll_send_skb);
 
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
-	int total_len, ip_len, udp_len;
+	int total_len, ip_len, udp_len, link_len;
 	struct sk_buff *skb;
 	struct udphdr *udph;
 	struct iphdr *iph;
@@ -416,7 +416,10 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	else
 		ip_len = udp_len + sizeof(*iph);
 
-	total_len = ip_len + LL_RESERVED_SPACE(np->dev);
+	/* if there's a hardware header assume ethernet, else raw IP */
+	eth = NULL;
+	link_len = np->dev->hard_header_len ? LL_RESERVED_SPACE(np->dev) : 0;
+	total_len = ip_len + link_len;
 
 	skb = find_skb(np, total_len + np->dev->needed_tailroom,
 		       total_len - len);
@@ -458,9 +461,11 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		ip6h->saddr = np->local_ip.in6;
 		ip6h->daddr = np->remote_ip.in6;
 
-		eth = skb_push(skb, ETH_HLEN);
-		skb_reset_mac_header(skb);
-		skb->protocol = eth->h_proto = htons(ETH_P_IPV6);
+		skb->protocol = htons(ETH_P_IPV6);
+		if (link_len) {
+			eth = skb_push(skb, ETH_HLEN);
+			skb_reset_mac_header(skb);
+		}
 	} else {
 		udph->check = 0;
 		udph->check = csum_tcpudp_magic(np->local_ip.ip,
@@ -487,13 +492,18 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		put_unaligned(np->remote_ip.ip, &(iph->daddr));
 		iph->check    = ip_fast_csum((unsigned char *)iph, iph->ihl);
 
-		eth = skb_push(skb, ETH_HLEN);
-		skb_reset_mac_header(skb);
-		skb->protocol = eth->h_proto = htons(ETH_P_IP);
+		skb->protocol = htons(ETH_P_IP);
+		if (link_len) {
+			eth = skb_push(skb, ETH_HLEN);
+			skb_reset_mac_header(skb);
+		}
 	}
 
-	ether_addr_copy(eth->h_source, np->dev->dev_addr);
-	ether_addr_copy(eth->h_dest, np->remote_mac);
+	if (eth) {
+		eth->h_proto = skb->protocol;
+		ether_addr_copy(eth->h_source, np->dev->dev_addr);
+		ether_addr_copy(eth->h_dest, np->remote_mac);
+	}
 
 	skb->dev = np->dev;
 
-- 
2.43.0


