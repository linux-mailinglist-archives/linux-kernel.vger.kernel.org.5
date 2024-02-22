Return-Path: <linux-kernel+bounces-76619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A8685FA13
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BA2289B20
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1C1468ED;
	Thu, 22 Feb 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="iisk8n9p"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C9134CC2;
	Thu, 22 Feb 2024 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609367; cv=none; b=nrOoXUUadaIWHRUhNZKTtePIxu2LM6lSCXORiJc/gJkyJgPNHbTVqrdjJ+hlAD1rQGHbhHir751LSl0XS3xsRM4920eE/n3O3PkdXdcm4Csez0X+HnzTJowdcMXQ9qYmLbcY7TntDuyHQxelK8ubS7vOMTxwA8+4lwYxx2ri85Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609367; c=relaxed/simple;
	bh=w7q0OZpmbQ4iJGkY22z3KyxTMX1Cmy0aLTK8x/4EEWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXmwjAaYWvU7l8ypgDYem2CIkqg9YyuRlGC6Gd9bbBN5BRfB4eDw2VSwNQGIOluktRkM2kJXzPE0rFqNoX/MV79WU0Wx6lXGrNS4A/f+I0CdiG1X4kswWN/iEG9stYpFm/LcnUIQJPwvMycFBZheZ9clxuXMlplEE5Dmh0drK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=iisk8n9p; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id C0278200DF89;
	Thu, 22 Feb 2024 14:42:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be C0278200DF89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708609357;
	bh=ohnw1X5t6/nbcUS24rw3MYJUUJQ4h7ERcV3d3m5S1+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iisk8n9pS1HSF3c9g4DMHVKKJ3d5eaY+T4E/6zmc5LwNR8UV3FM0A23LacqY+FYFY
	 RElvkOd88KFwQITaK0vcRozx/3P+vPYH+RbKAaS0IBM69aa8lYVmKmB1RyZk2MqIGF
	 Uksz7mjdoPgXloV+s+jDfWPCX/v+PGdZS/3w8ZJ+RfTRJcvlDe7+yZtrvpruV85muR
	 DyG2cVccIt+cRjlQ4vC+J20oxj1WY3ONiEfRjPRpYFRzXfeKurfPS2fKXeSJ5kygvO
	 /nagO7TU9zg+Dvuv+TLWBesVpul5mleAAIodfNay3QXBagpnd2BStNqc43HjSKcBP7
	 b9BYep7N1kvOg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v2 3/3] net: exthdrs: ioam6: send trace event
Date: Thu, 22 Feb 2024 14:42:20 +0100
Message-Id: <20240222134220.16698-4-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222134220.16698-1-justin.iurman@uliege.be>
References: <20240222134220.16698-1-justin.iurman@uliege.be>
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


