Return-Path: <linux-kernel+bounces-161452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955A48B4C28
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A1E281999
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849256EB65;
	Sun, 28 Apr 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sXwpeMVa"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A5A1C32;
	Sun, 28 Apr 2024 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714314567; cv=none; b=uRpA8SrhYnkV9Bu3HpF7MU0BT1Mf0+demejSL2G5SutWb4jETT7jF+LAWsr4fE28ymkkyqViwYrxCegz4zyzTHqoyqWgOAaVLELf5z0sBOyR8ivPPo0AWwIqfGxp9hXvIYYqFccT+K4fYfZiAoj+sSCUL+s+0flYhCq++YbWDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714314567; c=relaxed/simple;
	bh=pEOEFwml9g9Ku1dfnMgPeNijnvjb2rGfZrouDU5XDvs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O+7ARqPXee4yxe4nzttFbcAViYqK3diKFRoZnHworYNvTYmWfj5N3/nl3Kc1n3wZPPw6IlaZivOqSwyUpCLHCmqIL/yyagX2vWnUkdqOyh152OW9JGFsLGJ4rQ6g61yIdcfy3Sg2TkVk3tlfIH4BGDFJRCn3gESpdL8/Zp1kKZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sXwpeMVa; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b2522164056b11efb92737409a0e9459-20240428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+AJLIaBitYxpEmHqEZ77HT8/gK2VQB6rWKd5c7RlOhA=;
	b=sXwpeMVaadQuhbwLlpl8riuhQtqjOyMbj8n9tZlrkBbxt9Y4ZPnbF0fnqheyAzzcU8MzU3MLv+LlqPSx/xThANZj3sxqIPVSS2Nu6tSJFkUhBfcnMH5KNKKZhqdrmAN+zBRfm5E9TazusmfGvB7Ita7Ml12Ycb+XLXIot2ezQoo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a218aa2d-9b93-4571-bfc4-a000bf3160cd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:010ab166-72bc-4ae0-ab39-a531fe78e0a5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b2522164056b11efb92737409a0e9459-20240428
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1209379289; Sun, 28 Apr 2024 22:29:18 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 28 Apr 2024 22:29:17 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 28 Apr 2024 22:29:16 +0800
From: <shiming.cheng@mediatek.com>
To: <willemdebruijn.kernel@gmail.com>, <edumazet@google.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<matthias.bgg@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<shiming.cheng@mediatek.com>, Lena Wang <lena.wang@mediatek.com>
Subject: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Date: Sun, 28 Apr 2024 22:29:13 +0800
Message-ID: <20240428142913.18666-1-shiming.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Shiming Cheng <shiming.cheng@mediatek.com>

BPF or TC callers may pull in a length longer than skb_headlen()
for a SKB_GSO_FRAGLIST skb. The data in fraglist will be pulled
into the linear space. However it destroys the skb's structure
and may result in an invalid segmentation or kernel exception.

So we should add protection to stop the operation and return
error to remind callers.

Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
Signed-off-by: Lena Wang <lena.wang@mediatek.com>
---
 net/core/skbuff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f68f2679b086..2d35e009e814 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6100,6 +6100,12 @@ EXPORT_SYMBOL(skb_vlan_untag);
 
 int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len)
 {
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
+	     write_len > skb_headlen(skb)) {
+		return -ENOMEM;
+	}
+
 	if (!pskb_may_pull(skb, write_len))
 		return -ENOMEM;
 
-- 
2.18.0


