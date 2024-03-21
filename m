Return-Path: <linux-kernel+bounces-110021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD078858FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9B41F223A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABAF7603D;
	Thu, 21 Mar 2024 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b="Nj7pM8Km";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cx1XgYkr"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B5224F2;
	Thu, 21 Mar 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023689; cv=none; b=nEsYoQMdi/pXww+ooGL1hDAqjXiTG+hYHkZEWuj58ISsJ6mrSb1CW54HPLdKYIM2m28tcHiN3QS7H1QDG/sVmn5Yge5cxJLgIIEZc8OcJ/192ysVuUEgwno8SGaQHz2fuaZ0hfpjlCTnYpN45ZebKkDrU3uEjMOCpwwM2WTxJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023689; c=relaxed/simple;
	bh=tJHhyKzMBGPlvqUYLPyAq4LJdsUc0ArOyr39DcHjHFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8tE45m7ED561fB7m+8tcN87ERI9PIT2FMam7XcP05TNSvboePNtDEP3wBUhXpfzTP8QWpsMThudQoEOBUubzI62JWfOHtg2NweuNXdpqakDSJLjTIk1O9f7MZ5AHbzgQt29d8Ywbw1Zb3Vi7F15ttfW8plDP9VjaTPl0lZcTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl; spf=pass smtp.mailfrom=yotsuba.nl; dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b=Nj7pM8Km; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cx1XgYkr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yotsuba.nl
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4F69B1140113;
	Thu, 21 Mar 2024 08:21:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Mar 2024 08:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1711023685; x=1711110085; bh=zl2DkJ9v924tdl+ckZdhY
	C/P/YNrKbev6EVT/FWNrpk=; b=Nj7pM8Km98RJRF+HloMaLqvDVCJ7HX9HuwlaO
	WR4dWGD9wbcaazY7TNObtfO2om2d2luwvYucpxunx5JAZ9LH8LKwv6qMMsS2rpyG
	JkPSWpzek1+B5U45T2Tde3nsPajBduYaWYET4WCO2ZorBqUMDL9jsVyUwdGQucoS
	HXmxM0H3xM3WLLkT8JvN2CFYSNHJswdGikXmHXRjx7Ci3DFEWmiM04kV8YpuOzes
	Dveo7h63G5vInDtMO8qUSkw5ZrqAS5WTrhXjD0RCr9lxEJXBsEsjXitxyHmC2dSt
	YRWUTqNh4c9X7XXDIrjPm0Hznap8PP9CpN3wivg32JmiMRYRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711023685; x=1711110085; bh=zl2DkJ9v924tdl+ckZdhYC/P/YNr
	Kbev6EVT/FWNrpk=; b=cx1XgYkrsFzFHlzAh7MDr0ZOdZrc8+ofZIQAjquc08K6
	MVh3c9iN/YISpCtFmK+Pqr252fARl+5WTV1EEyA9JIurGqVtnNku9IoljEpZSASe
	0/0GUlt8faETp6OBypsbgUhgPo+53TGqqwfo3LKbeTEzmZDwEUM4IXc9xX2S+D5z
	NmV34+dZc5ftU6Mvdk5xFnzrkJb6Qkb+KgY3j0eS1+C6KmG7XH4dF8EF3MsORd37
	14POAQpQGIhZQsanKRqgRWT/vfmWJTSYEL3q/eA0dKm2YHSXBNt815mhkwlJN7hV
	387EAPh9sXwUp4kpPoATjzjaduUpMhi9ztX7NVQsOw==
X-ME-Sender: <xms:RCb8ZcnRmBj_4jTI3g-NEbiwN5IEFs-sVjQIsERshJv6igQXfwVraA>
    <xme:RCb8Zb0EzsASIUyQVODfuo5l5mb8xPG8rEBHqP6F2JVYeryROR5d-flOLL_bZC-k3
    QFxqF6PNzT9CVb1Ico>
X-ME-Received: <xmr:RCb8Zaoqlmuy7h9BpOTWQrGNP-7qimBceBe66TLpKbDYUhM2ZJDXv5GGq3VXBkafx2Y7H_R14z88yEtjZ70XgFjfuoCeIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcuvehi
    lhhishhsvghnuceomhgrrhhkseihohhtshhusggrrdhnlheqnecuggftrfgrthhtvghrnh
    ephfeuleeijefgffejheduteeigfefhedvjeeggfffhefgkedthfefjefftefgvedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrghrkheshihothhsuhgsrgdrnhhl
X-ME-Proxy: <xmx:RCb8ZYlS4L7bwyR5Z0DBlUGwRwgkxcCvDQKIiQDgvTk2DfJL0SOBBw>
    <xmx:RCb8Za3-OfB2O9d0J9vCOnWEg6NeUnY6xGXziTauDeccWddcnDwnYQ>
    <xmx:RCb8Zft547FRYerboNQg2fHI9dQpTRjaixVk3NTnrOd-JNjUz1lHcw>
    <xmx:RCb8ZWUDdK3BFDWCbyTDxFHEll1Ipbnxlhd9UmpUMcPwB5zF4DT2bA>
    <xmx:RSb8ZQOn6wLsGnBls0svVnwOxdMtWBHmaJ2HP2rD9kqVEFWRevMsUw>
Feedback-ID: i85e1472c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 08:21:24 -0400 (EDT)
From: Mark Cilissen <mark@yotsuba.nl>
To: netdev@vger.kernel.org
Cc: Mark Cilissen <mark@yotsuba.nl>,
	Jakub Kicinski <kuba@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Eric Dumazet <edumazet@google.com>,
	Breno Leitao <leitao@debian.org>,
	Ingo Molnar <mingo@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 1/2] netpoll: support sending over raw IP interfaces
Date: Thu, 21 Mar 2024 13:20:00 +0100
Message-ID: <20240321122003.20089-1-mark@yotsuba.nl>
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

This commit adds support for such interfaces by checking if a link layer
header is present using `dev_has_header()`. If that is not the case,
it simply skips adding the ethernet header, causing a raw IP packet to be
sent over the interface. This has been confirmed to add netconsole support
to at least SLIP and WireGuard interfaces.

Signed-off-by: Mark Cilissen <mark@yotsuba.nl>
---
v2:
- Use dev_has_header(netdev) to detect existence of link layer header
  instead of netdev->hard_header_len, restore prior skb allocation sizes
  by always using LL_RESERVED_SPACE() as before
- Add selftest for netconsole

v1: https://lore.kernel.org/netdev/20240313124613.51399-1-mark@yotsuba.nl/T/
---
 Documentation/networking/netconsole.rst |  3 ++-
 net/core/netpoll.c                      | 15 ++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

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
index 543007f159f9..d12aa1b7d79e 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -458,9 +458,7 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		ip6h->saddr = np->local_ip.in6;
 		ip6h->daddr = np->remote_ip.in6;
 
-		eth = skb_push(skb, ETH_HLEN);
-		skb_reset_mac_header(skb);
-		skb->protocol = eth->h_proto = htons(ETH_P_IPV6);
+		skb->protocol = htons(ETH_P_IPV6);
 	} else {
 		udph->check = 0;
 		udph->check = csum_tcpudp_magic(np->local_ip.ip,
@@ -487,14 +485,17 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		put_unaligned(np->remote_ip.ip, &(iph->daddr));
 		iph->check    = ip_fast_csum((unsigned char *)iph, iph->ihl);
 
+		skb->protocol = htons(ETH_P_IP);
+	}
+
+	if (dev_has_header(np->dev)) {
 		eth = skb_push(skb, ETH_HLEN);
 		skb_reset_mac_header(skb);
-		skb->protocol = eth->h_proto = htons(ETH_P_IP);
+		eth->h_proto = skb->protocol;
+		ether_addr_copy(eth->h_source, np->dev->dev_addr);
+		ether_addr_copy(eth->h_dest, np->remote_mac);
 	}
 
-	ether_addr_copy(eth->h_source, np->dev->dev_addr);
-	ether_addr_copy(eth->h_dest, np->remote_mac);
-
 	skb->dev = np->dev;
 
 	netpoll_send_skb(np, skb);
-- 
2.44.0


