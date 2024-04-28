Return-Path: <linux-kernel+bounces-161453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB63C8B4C2A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FC7281A58
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C46EB64;
	Sun, 28 Apr 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J0R83qi6"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C651C32;
	Sun, 28 Apr 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714314602; cv=none; b=qTWO0uUExI6SxwtW+WsmCKx6gqNZMBHS3j3mRW3Vzq6OqgADiwu3SR2eImemQ3I4ZPeMGugvvbUogHdb/NtlUpJaMzSdJ1WGGq8WMNuOeKvUHilHpeVAzrg+MM/Crpbvf0YmK00RWA6zRiuFI7vn8GUK+vrAYKh1hWqLWMDCBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714314602; c=relaxed/simple;
	bh=NqZBkRYnYes+Rg+x6msRDkpz+oUasi4o3teBF2EsQy4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i8+cP8XRAj0KYkgqzJtP0NkSBpvmXfp4hxAZnFo9d6T+ujIwXn6rJcdStHnkpZ+DiTLTCsTVZGHRMBnD5OfCBr7ww3aExVlouR8OqXWQBosCJTG+iICMMwPjLCw9Kh7TPulbpKu0C/3ZFejxiI8KNJG3wi4M3Akd7Vy9k3K6P/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=J0R83qi6; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c8911534056b11efb92737409a0e9459-20240428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XXRJ81xwIuTFUgX0JZRvcELJ+oqPi5PwBncGpAHuDC0=;
	b=J0R83qi65ZejTNxWY547thJUp8/BMHx3kmKTlKW0/5c6NJg2E4nfXpqcWkXipuwMLQsLxiFkdO2CNnIpT1T932lITIdH8RfbRi7fIHg/qL+5mrcP1FPQY/SphoNSlNbm7vre/7liEDavXq7/P2OhNhoiL4BCH6349DQa34WlRt8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:06c68dc0-168e-4e65-bcd9-97a7df2127f0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:720ab166-72bc-4ae0-ab39-a531fe78e0a5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: c8911534056b11efb92737409a0e9459-20240428
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2096129537; Sun, 28 Apr 2024 22:29:55 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 28 Apr 2024 22:29:54 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 28 Apr 2024 22:29:53 +0800
From: <shiming.cheng@mediatek.com>
To: <willemdebruijn.kernel@gmail.com>, <edumazet@google.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<matthias.bgg@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<shiming.cheng@mediatek.com>, Lena Wang <lena.wang@mediatek.com>
Subject: [PATCH net] net: drop pulled SKB_GSO_FRAGLIST skb
Date: Sun, 28 Apr 2024 22:30:10 +0800
Message-ID: <20240428143010.18719-1-shiming.cheng@mediatek.com>
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

A SKB_GSO_FRAGLIST skb without GSO_BY_FRAGS is
expected to have all segments except the last
to be gso_size long. If this does not hold, the
skb has been modified and the fraglist gso integrity
is lost. Drop the packet, as it cannot be segmented
correctly by skb_segment_list.

The skb could be salvaged. By linearizing, dropping
the SKB_GSO_FRAGLIST bit and entering the normal
skb_segment path rather than the skb_segment_list path.

That choice is currently made in the protocol caller,
__udp_gso_segment. It's not trivial to add such a
backup path here. So let's add this backstop against
kernel crashes.

Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
Signed-off-by: Lena Wang <lena.wang@mediatek.com>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b99127712e67..4777f5fea6c3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4491,6 +4491,7 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 {
 	struct sk_buff *list_skb = skb_shinfo(skb)->frag_list;
 	unsigned int tnl_hlen = skb_tnl_header_len(skb);
+	unsigned int mss = skb_shinfo(skb)->gso_size;
 	unsigned int delta_truesize = 0;
 	unsigned int delta_len = 0;
 	struct sk_buff *tail = NULL;
@@ -4504,6 +4505,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 	if (err)
 		goto err_linearize;
 
+	if (mss != GSO_BY_FRAGS && mss != skb_headlen(skb))
+		return ERR_PTR(-EFAULT);
+
 	skb_shinfo(skb)->frag_list = NULL;
 
 	while (list_skb) {
-- 
2.18.0


