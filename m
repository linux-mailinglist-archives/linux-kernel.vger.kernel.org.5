Return-Path: <linux-kernel+bounces-78513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7022861457
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8560A1F24934
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684E882891;
	Fri, 23 Feb 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="n/eeu5bV"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3586FA7;
	Fri, 23 Feb 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699314; cv=none; b=QTjBkzFKyGloqXeM2tGTcX5tUrnopE+/fbviQi1QoC54P6JaZOqePn306pfyiNZLMBu3UdPZG0HRXInMc7AyYMAwaOlTNK0+mDy8rsrFm6F7ZtbNn6cetyATogNJmsLzNoXeaWjm9ZTY8JiEFjR4C7Qk7Jk+UaIk9UXqguZ0O54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699314; c=relaxed/simple;
	bh=XN/Z2W6Q47kswIvugAyf+0JDBepLSAUiKU4MFYhPfmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ExWS4vcneIJlnOIgZFrJCfDJJjvnBJYOneLCm5uRBXKcoeUGpXfSklvKdEg/7Flm0OYUM4ITrYPJaWsBIWhLOkD22B8pShuoytnAM600QetCcSUPmRLcx2CZnrM7NSUHQJUlMYzKsoAix/+36xV26HCG4hVN/PK1jXa54VRCki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=n/eeu5bV; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 9C2A2200C983;
	Fri, 23 Feb 2024 15:41:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 9C2A2200C983
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708699303;
	bh=hq6ndT35T0S7QhhDxp3zV7pZyTqFTsug9KaHtrGUSs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/eeu5bVcgE/VBkBM5q8DLHy8yjO40/BS1ukoudYl+nFlrgghdzrHypOSDzkKPOth
	 eA6mV2R6vIpx1T0nFdO/01qjld6XY+CiZDrF5melZlfiCYU0/hmt+RpqdiDC2VFJn4
	 mYcj208RsrXarva041udsJHU9HosavvMM1JGiGEk8WymDDQr3ghHwjBJkYTvlv6+pd
	 etStCueFtzWsmyPk+630Zxgjvsm+rwGsMSVvljm/hv7dnolY1RMyuUERWp/s7mQ5zM
	 sQnzFKWqSA5Kss6vOIWndJ7TMbiPKafbI+2CdC/1oz2wo87qHqPYJt2tPqsi2LH5Zl
	 nXO5j5dAdA9DA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v4 2/3] net: ioam6: multicast event
Date: Fri, 23 Feb 2024 15:41:34 +0100
Message-Id: <20240223144135.12826-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223144135.12826-1-justin.iurman@uliege.be>
References: <20240223144135.12826-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a multicast group to the ioam6 generic netlink family and provide
ioam6_event() to send an ioam6 event to the multicast group.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 include/net/ioam6.h |  4 +++
 net/ipv6/ioam6.c    | 64 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/net/ioam6.h b/include/net/ioam6.h
index 781d2d8b2f29..2cbbee6e806a 100644
--- a/include/net/ioam6.h
+++ b/include/net/ioam6.h
@@ -12,6 +12,7 @@
 #include <linux/net.h>
 #include <linux/ipv6.h>
 #include <linux/ioam6.h>
+#include <linux/ioam6_genl.h>
 #include <linux/rhashtable-types.h>
 
 struct ioam6_namespace {
@@ -65,4 +66,7 @@ void ioam6_exit(void);
 int ioam6_iptunnel_init(void);
 void ioam6_iptunnel_exit(void);
 
+void ioam6_event(enum ioam6_event_type type, struct net *net, gfp_t gfp,
+		 void *opt, unsigned int opt_len);
+
 #endif /* _NET_IOAM6_H */
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 571f0e4d9cf3..5fa923f06632 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -612,6 +612,68 @@ static const struct genl_ops ioam6_genl_ops[] = {
 	},
 };
 
+#define IOAM6_GENL_EV_GRP_OFFSET 0
+
+static const struct genl_multicast_group ioam6_mcgrps[] = {
+	[IOAM6_GENL_EV_GRP_OFFSET] = { .name = IOAM6_GENL_EV_GRP_NAME,
+				       .flags = GENL_MCAST_CAP_NET_ADMIN },
+};
+
+static int ioam6_event_put_trace(struct sk_buff *skb,
+				 struct ioam6_trace_hdr *trace,
+				 unsigned int len)
+{
+	if (nla_put_u16(skb, IOAM6_EVENT_ATTR_TRACE_NAMESPACE,
+			be16_to_cpu(trace->namespace_id)) ||
+	    nla_put_u8(skb, IOAM6_EVENT_ATTR_TRACE_NODELEN, trace->nodelen) ||
+	    nla_put_u32(skb, IOAM6_EVENT_ATTR_TRACE_TYPE,
+			be32_to_cpu(trace->type_be32)) ||
+	    nla_put(skb, IOAM6_EVENT_ATTR_TRACE_DATA,
+		    len - sizeof(struct ioam6_trace_hdr) - trace->remlen * 4,
+		    trace->data + trace->remlen * 4))
+		return 1;
+
+	return 0;
+}
+
+void ioam6_event(enum ioam6_event_type type, struct net *net, gfp_t gfp,
+		 void *opt, unsigned int opt_len)
+{
+	struct nlmsghdr *nlh;
+	struct sk_buff *skb;
+
+	if (!genl_has_listeners(&ioam6_genl_family, net,
+				IOAM6_GENL_EV_GRP_OFFSET))
+		return;
+
+	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!skb)
+		return;
+
+	nlh = genlmsg_put(skb, 0, 0, &ioam6_genl_family, 0, type);
+	if (!nlh)
+		goto nla_put_failure;
+
+	switch (type) {
+	case IOAM6_EVENT_UNSPEC:
+		WARN_ON_ONCE(1);
+		break;
+	case IOAM6_EVENT_TRACE:
+		if (ioam6_event_put_trace(skb, (struct ioam6_trace_hdr *)opt,
+					  opt_len))
+			goto nla_put_failure;
+		break;
+	}
+
+	genlmsg_end(skb, nlh);
+	genlmsg_multicast_netns(&ioam6_genl_family, net, skb, 0,
+				IOAM6_GENL_EV_GRP_OFFSET, gfp);
+	return;
+
+nla_put_failure:
+	nlmsg_free(skb);
+}
+
 static struct genl_family ioam6_genl_family __ro_after_init = {
 	.name		= IOAM6_GENL_NAME,
 	.version	= IOAM6_GENL_VERSION,
@@ -620,6 +682,8 @@ static struct genl_family ioam6_genl_family __ro_after_init = {
 	.ops		= ioam6_genl_ops,
 	.n_ops		= ARRAY_SIZE(ioam6_genl_ops),
 	.resv_start_op	= IOAM6_CMD_NS_SET_SCHEMA + 1,
+	.mcgrps		= ioam6_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(ioam6_mcgrps),
 	.module		= THIS_MODULE,
 };
 
-- 
2.34.1


