Return-Path: <linux-kernel+bounces-167542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4138BAB17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E00E1C226B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF28515219D;
	Fri,  3 May 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="scVx3x5/"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8E150982;
	Fri,  3 May 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733735; cv=none; b=OzRvDQcVBC8GHFKYPAWXLz2ANBndap2IkqL9jlY+2ZdM/wB4PBQ1N1TU3IVlkKQ36jZW0QScP5tale1j2OBJBCmmyQfai9Irf/CxCaQ/WBChAwvLdbTx+veqtKEUgLS+evSsuBc2yrEMrlLnBVyx/bs+jpG+IcKgeSsxmKRMTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733735; c=relaxed/simple;
	bh=/4zLaVQuU1wmeIeAfJH/eguO+ohhbE6XUdh7n4342pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1p3O5+amp27FGgB6C0mVZmhUYyEePH0ZrOUlr5PGo3be9Q7EUlq5PPpGVYh9tCbXemSKwos1qJCrqgRX85f3XvbyZWHKGuNcH0Y5oR/26cW6WsqSsNjYJEuQ588xS4GkBYHQzI9dE8MJ3GcCriPC+v/HcFLE4/NkrzI8o+n7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=scVx3x5/; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 92ECB600A7;
	Fri,  3 May 2024 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714733723;
	bh=/4zLaVQuU1wmeIeAfJH/eguO+ohhbE6XUdh7n4342pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scVx3x5/gLpgoyoIzDOg7FpjAu5K34yUsCx4Z+B0tdNicRPPHpOgA6TvHgURzaBX3
	 Z0t+p1PEZOstkeixFT/4RbqqAQM/U79iVgM5XGpQb9HEVgYOQvma/4l1/YwyY7Zq+o
	 0bEmCBjukHS4/vygo74rwaMSrHl0A2EgMJyldCjyBSyotC7T9yWVTB6siVr43EGO7j
	 Q60C5qPhqNiLmAoi8FblbcrCS+UAC7dQHA0+8R7CFvbNVM6YN4WUwLW1KtOVTt+rjv
	 Hok6JUCNjJsQ/qKCvInHR1Q7WA0yklClVcAfTAIUgcud0rtdeLGbxK1fYNMI99V1Ye
	 1s0BZyqp8GVtQ==
Received: by x201s (Postfix, from userid 1000)
	id 333EA21BB74; Fri, 03 May 2024 10:55:12 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 3/3] net: qede: use return from qede_flow_parse_ports()
Date: Fri,  3 May 2024 10:55:03 +0000
Message-ID: <20240503105505.839342-4-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503105505.839342-1-ast@fiberby.net>
References: <20240503105505.839342-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When calling qede_flow_parse_ports(), then the
return code was only used for a non-zero check,
and then -EINVAL was returned.

qede_flow_parse_ports() can currently fail with:
* -EINVAL

This patch changes qede_flow_parse_v{4,6}_common() to
use the actual return code from qede_flow_parse_ports(),
so it's no longer assumed that all errors are -EINVAL.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 07af0464eb1e..ded48523c383 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1725,6 +1725,7 @@ qede_flow_parse_v6_common(struct qede_dev *edev, struct flow_rule *rule,
 			  struct qede_arfs_tuple *t)
 {
 	struct in6_addr zero_addr, addr;
+	int err;
 
 	memset(&zero_addr, 0, sizeof(addr));
 	memset(&addr, 0xff, sizeof(addr));
@@ -1746,8 +1747,9 @@ qede_flow_parse_v6_common(struct qede_dev *edev, struct flow_rule *rule,
 		memcpy(&t->dst_ipv6, &match.key->dst, sizeof(addr));
 	}
 
-	if (qede_flow_parse_ports(edev, rule, t))
-		return -EINVAL;
+	err = qede_flow_parse_ports(edev, rule, t);
+	if (err)
+		return err;
 
 	return qede_set_v6_tuple_to_profile(edev, t, &zero_addr);
 }
@@ -1756,6 +1758,8 @@ static int
 qede_flow_parse_v4_common(struct qede_dev *edev, struct flow_rule *rule,
 			struct qede_arfs_tuple *t)
 {
+	int err;
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
 		struct flow_match_ipv4_addrs match;
 
@@ -1770,8 +1774,9 @@ qede_flow_parse_v4_common(struct qede_dev *edev, struct flow_rule *rule,
 		t->dst_ipv4 = match.key->dst;
 	}
 
-	if (qede_flow_parse_ports(edev, rule, t))
-		return -EINVAL;
+	err = qede_flow_parse_ports(edev, rule, t);
+	if (err)
+		return err;
 
 	return qede_set_v4_tuple_to_profile(edev, t);
 }
-- 
2.43.0


