Return-Path: <linux-kernel+bounces-145411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E21B8A55DC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1941C21D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF8C76044;
	Mon, 15 Apr 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AgrL/Ntf"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7671B3B;
	Mon, 15 Apr 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193297; cv=none; b=hYX1rPBQZ5AYpHPy9lnTYiGNghGDNW8TZQCJorZNZiPdU6yuZU1ZtOgMoqCX0qioKIJXlk5dAClpxBZqtqT7nrEMoqqSvprSX4IehrBo8//mNXJ7NrKVpbTP5cuXCQVu1HfkGG+Izt6xPF2Wzc3IEza5k/WHf/p3FTrdq6sdkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193297; c=relaxed/simple;
	bh=fErZjILugyMaOlaCYv4Ry65eYxlQ4OnitIywRX/KQwI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LRKrzFPVDMhlb3pNzgwtJ7vRc9EO0L6h5yQ2Rw/rYCwWvNFI2LzHJImNmbpgXFLW4QNaDIlNG/7qAyD6Vw+fCGrdE9mFNq4+02iVUbwptouzpYr0HYDsU3iQQqvpUt1zxelcV632rglS2stXXiaN2C1uHB2mOcR9h3TBdRYJeTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AgrL/Ntf; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 082ce976fb3911ee935d6952f98a51a9-20240415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=j1iSowN/IF/xoWn4Ii/qXGL9p7lH6gAEsvUETuM3jJo=;
	b=AgrL/Ntfy1roFyNxEtDzFgVEyxpwP3//o/CUr4u19qjrsIYUCTPIUBCEU8R/On1NVU8JTHraGw8lCkmAjfzXJu1qsg4/OoCnaLGwpIA4RlInTLdD5qy6XLPBmNmMp/i2y+tbK76QoNsXOTrKDSZ07YNveeiFZ0fb4ErhSBdvAGs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:efe148e8-23a1-4272-bcb2-6b5585221064,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:f15c3386-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 082ce976fb3911ee935d6952f98a51a9-20240415
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1519067544; Mon, 15 Apr 2024 23:01:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 15 Apr 2024 23:01:25 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 15 Apr 2024 23:01:24 +0800
From: <shiming.cheng@mediatek.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <matthias.bgg@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<shiming.cheng@mediatek.com>, Lena Wang <lena.wang@mediatek.com>
Subject: [PATCH net] udp: fix segmentation crash for GRO packet without fraglist
Date: Mon, 15 Apr 2024 23:01:03 +0800
Message-ID: <20240415150103.23316-1-shiming.cheng@mediatek.com>
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

A GRO packet without fraglist is crashed and backtrace is as below:
 [ 1100.812205][    C3] CPU: 3 PID: 0 Comm: swapper/3 Tainted:
G        W  OE      6.6.17-android15-0-g380371ea9bf1 #1
 [ 1100.812317][    C3]  __udp_gso_segment+0x298/0x4d4
 [ 1100.812335][    C3]  __skb_gso_segment+0xc4/0x120
 [ 1100.812339][    C3]  udp_rcv_segment+0x50/0x134
 [ 1100.812344][    C3]  udp_queue_rcv_skb+0x74/0x114
 [ 1100.812348][    C3]  udp_unicast_rcv_skb+0x94/0xac
 [ 1100.812358][    C3]  udp_rcv+0x20/0x30

The reason that the packet loses its fraglist is that in ingress bpf
it makes a test pull with to make sure it can read packet headers
via direct packet access: In bpf_progs/offload.c
try_make_writable -> bpf_skb_pull_data -> pskb_may_pull ->
__pskb_pull_tail  This operation pull the data in fraglist into linear
and set the fraglist to null.

BPF needs to modify a proper length to do pull data. However kernel
should also improve the flow to avoid crash from a bpf function call.
As there is no split flow and app may not decode the merged UDP packet,
we should drop the packet without fraglist in skb_segment_list here.

Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
Signed-off-by: Lena Wang <lena.wang@mediatek.com>
---
 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b99127712e67..f68f2679b086 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4504,6 +4504,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 	if (err)
 		goto err_linearize;
 
+	if (!list_skb)
+		goto err_linearize;
+
 	skb_shinfo(skb)->frag_list = NULL;
 
 	while (list_skb) {
-- 
2.18.0


