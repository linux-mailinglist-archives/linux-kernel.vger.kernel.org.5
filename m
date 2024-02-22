Return-Path: <linux-kernel+bounces-77537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57BA860708
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1627028338F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C6A2230C;
	Thu, 22 Feb 2024 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="eqCd71v0"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340C19452;
	Thu, 22 Feb 2024 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644842; cv=none; b=FSgtrYWbpfcXDw0wxdnJKsyra3RX02c2NimRmByOYPU0Spe3mJKXY+ftY4enfzA5VNywTVFRBP4g+fjSQDzD6aNnm7D0bpsq8zkBoD/8v0mexiLz0p5DG0pCMqqGv+GM0y+50XLRfELqEMPGIT709V92xvNcxrFmom2LAMhZ9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644842; c=relaxed/simple;
	bh=w7q0OZpmbQ4iJGkY22z3KyxTMX1Cmy0aLTK8x/4EEWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qosvjrD1K05Do/pDmGfpVzBb3NC8o2NHjpASN4k3eaqMD+zxL59TgnHHNS2zn3m9Unt0B8q1jA3KaASeC6zharuYKj/4rhK1G1ZpSw0q4/mke5OtTsm0g4JyghHAVD+oesyvx2v+TGmM1OZrQX7hT5FaVlIcJg8+4kwJZ1VwEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=eqCd71v0; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 6F251200C980;
	Fri, 23 Feb 2024 00:33:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 6F251200C980
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708644837;
	bh=ohnw1X5t6/nbcUS24rw3MYJUUJQ4h7ERcV3d3m5S1+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqCd71v0KKdVOC8riTFHBvRMBv6tbxQC3WUvppjDctj38oInNzBC66qEQDmXf5P0m
	 x3UlcU5n7jNmY/djLkBOFA4hfgiQkXkPKKLuMl6u+Vde+KpBbtSMsZzu3it8O++kx9
	 O9ofuM4pjQBQbuts3gcUELwiBVyWCB4mEp4Bn0Ojo4fkeqdx+pSXnJ6R6Se8qeJrA+
	 Is3QnAQSVIl+4IjIGQnBjcDQ7fv9JpV6/WxAzYW8iLRLBS5884BqSxr5jRij0I286q
	 NG8iIqCEdStXTZG5OyBd0gBzeegzWkZEOSmCxmtAfVXT7mMX+jC2kerwQG5CuNmBtl
	 CjKufj49V8JnQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v3 3/3] net: exthdrs: ioam6: send trace event
Date: Fri, 23 Feb 2024 00:33:37 +0100
Message-Id: <20240222233337.5342-4-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222233337.5342-1-justin.iurman@uliege.be>
References: <20240222233337.5342-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're processing an IOAM Pre-allocated Trace Option-Type (the only
one supported currently), and if we're the destination, then send the
trace as an ioam6 event to the multicast group. This way, user space
apps will be able to collect IOAM data (for a trace, it only makes sense
to send events if we're the destination).

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/exthdrs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 4952ae792450..b26dcf4d0239 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -50,6 +50,7 @@
 #endif
 #include <net/rpl.h>
 #include <linux/ioam6.h>
+#include <linux/ioam6_genl.h>
 #include <net/ioam6.h>
 #include <net/dst_metadata.h>
 
@@ -944,6 +945,11 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 			ip6_route_input(skb);
 
 		ioam6_fill_trace_data(skb, ns, trace, true);
+
+		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
+			ioam6_event(IOAM6_EVENT_TRACE, dev_net(skb->dev),
+				    GFP_ATOMIC, (void *)trace,
+				    hdr->opt_len - 2);
 		break;
 	default:
 		break;
-- 
2.34.1


