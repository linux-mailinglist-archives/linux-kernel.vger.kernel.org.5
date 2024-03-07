Return-Path: <linux-kernel+bounces-95315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBAA874C1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC312842C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53EE85273;
	Thu,  7 Mar 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lSEvMPEx"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45EB84FD6;
	Thu,  7 Mar 2024 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806621; cv=none; b=Eb27wrbByjUp+ybvmjgPcu7w61Sd0R1/rC7QLadn7zbKR80KYjEEfgurcybHU/UQvI6K1h/EsM4TOJ3VjlEzmlMawWAiCTZJhmIl+P70529iF460poqgrUBO6MKQdRdecD9mSr38kcOiVHu2QnUH/xCQez/OeIGXirHT8EoNdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806621; c=relaxed/simple;
	bh=CBvML9deNEoVuOxgFHt894b8D/T7VwNGXZ72n2fnEGk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ld7vLG/+4FioG6YyAcHeKelR44loby0lN0jos0X81YggHkZZCXa6+hyXiUGvyExgE2BlPy65G47161obfogCEHM6B5xwgDZVLGeEctSVdvezRHuZeZqP4oUiWp+1LR0nn3ccrvax2r0Si228M5plSlrDUFEVpj4xbKdFZ/doHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lSEvMPEx; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cddb3408dc6b11ee935d6952f98a51a9-20240307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GNmxSGYpJmxhMAuFxxVg2HZd9oC6HzlD9GPrSS1SIWE=;
	b=lSEvMPExLls0XBvOq74qx6NbOhQoDKVYMaKFGLL0/XhNS+1XUjxjuAPvYbn0PxreQR+NTKGZ5+uDpWkA3HSrG3EZUTM9NGDpyMUq5EW/7pKQ0S/OBwl/MbWTC6ZCu5JHevP7UVPYfQVdAbVf8nb/i0aC/eRn5uH//m2R0fVMnyk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:abd6cb84-9936-4260-aead-1c3f5273dc6c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c5522190-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: cddb3408dc6b11ee935d6952f98a51a9-20240307
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1161080659; Thu, 07 Mar 2024 18:16:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Mar 2024 18:16:44 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Mar 2024 18:16:44 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <jiri@resnulli.us>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <shiming.cheng@mediatek.com>,
	<netdev@vger.kernel.org>, Lena Wang <lena.wang@mediatek.com>
Subject: [PATCH net v5] ipv6: fib6_rules: flush route cache when rule is changed
Date: Thu, 7 Mar 2024 18:01:57 +0800
Message-ID: <20240307100157.29699-1-shiming.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.420700-8.000000
X-TMASE-MatchedRID: vb/S/ihWjLlKgFU/G9flJJD6BbDN9+jOYQXxsZnRwoIXdhT0BAdFzmpH
	KtkQBynKwfZWztcZK6Yg/ZeU3y59o8wrDggcQ6d1USn3o+eoUmxbAoaK+wS4jeO53bHtM9W3W7r
	SImiJ0foLOqNjXz20+KWlAHXodmZtAM0/G7XUdePil2r2x2PwtYfsPVs/8Vw6RTck7NznBP+zYM
	Za9F0/9/UhSex6m6QxGb/srZoSOzUM8jMXjBF+sBRFJJyf5BJeGEkIgdGU7nX6C0ePs7A07fhmF
	HnZFzVqzgENzz9gYA0kfIe+qt5DPoTKqZFxYL9iMFacFnZRXmbKYWGeeDVJ285OyOT3zBST91kE
	KsLI3jRD7oKmUHyhTQvsrGP8HT8wSZrfNhP3sgUBh9AgBSEFrJm+YJspVvj2xkvrHlT8euJ0YHK
	n7N1oOA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.420700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	8442A3A0F195FC5417423452CC46597761296B23CA6257E32AA4AD90FAE1D1452000:8
X-MTK: N

When rule policy is changed, ipv6 socket cache is not refreshed.
The sock's skb still uses a outdated route cache and was sent to
a wrong interface.

To avoid this error we should update fib node's version when
rule is changed. Then skb's route will be reroute checked as
route cache version is already different with fib node version.
The route cache is refreshed to match the latest rule.

Fixes: 101367c2f8c4 ("[IPV6]: Policy Routing Rules")
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
Signed-off-by: Lena Wang <lena.wang@mediatek.com>
---
v5:
  - rebase on the top of latest net/main branch.
v4:
  - add "Fixes:" tag.
  - update subject as requested.
v3:
  - update patch description and name format in commit message.
v2:
  - modify flush function same way as ipv4 flush cache.
  - use tabs to aligh with existing code.
---
---
 net/ipv6/fib6_rules.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 7523c4baef35..52c04f0ac498 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -449,6 +449,11 @@ static size_t fib6_rule_nlmsg_payload(struct fib_rule *rule)
 	       + nla_total_size(16); /* src */
 }
 
+static void fib6_rule_flush_cache(struct fib_rules_ops *ops)
+{
+	rt_genid_bump_ipv6(ops->fro_net);
+}
+
 static const struct fib_rules_ops __net_initconst fib6_rules_ops_template = {
 	.family			= AF_INET6,
 	.rule_size		= sizeof(struct fib6_rule),
@@ -461,6 +466,7 @@ static const struct fib_rules_ops __net_initconst fib6_rules_ops_template = {
 	.compare		= fib6_rule_compare,
 	.fill			= fib6_rule_fill,
 	.nlmsg_payload		= fib6_rule_nlmsg_payload,
+	.flush_cache		= fib6_rule_flush_cache,
 	.nlgroup		= RTNLGRP_IPV6_RULE,
 	.owner			= THIS_MODULE,
 	.fro_net		= &init_net,
-- 
2.18.0


