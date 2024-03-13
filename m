Return-Path: <linux-kernel+bounces-101561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA58887A8B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609021F24756
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FCC43AB5;
	Wed, 13 Mar 2024 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oGfDetpX"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64E4174F;
	Wed, 13 Mar 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337695; cv=none; b=DoIWb2Ry74SEPRERqyrTrE2sYw1GiigbNR4n+zPZlkJ5pzpgbFMYgilDDxg0G+i8ayl8WjUXaMo5Lgax+G7PN2Qq8pNvaMphXKbseZqMDH7xpRxjVr6Z7NFTqEC4E0Gv1hMlwQM5mSh1Xj+h3Cv+8NwIUdnEyYbf0oDMsgLhUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337695; c=relaxed/simple;
	bh=YRfQD+t2dkUzHEULs3NlLIIcIZaaDOWzomGtk1FtK3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UDY1sYNxeQgegoJdfQlLvDnuslnHVG/WeoY4QG/8YjO+R3TqwKvZZJRf881kdeL0Frzsx0ycOubjiVQ0hRxucZs/QCCy8StNZQnoxBE7MLIFDCBPT2I4g/87Z+2rh3LQk+jOe47xuxHYfI4zSIEY4orfLgvDeriSYzRASWfpzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oGfDetpX; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 50dcf980e14011eeb8927bc1f75efef4-20240313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=L4w20N+otfg7LwiYSgZBTvkCN/wv91X1s34i/ad5CCw=;
	b=oGfDetpXML9V4gCa5zrrGvflXDfgBD950x4waeaDoTDUBe4hUAIU5I/ta2RUpqEJdxFb2Mt3vk5lJNDNKt5e1KiF3i4Oe5ZE9BACbRq1BaSyPkfrLuncWkNrr7eutK0gECQ+YRguwUBNj/QBJrvGsQyXuvulZjFHfkNCmS5Ycz0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:60f705f5-bd61-4bfa-ad4b-07ab2bc4ba90,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:31555c90-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 50dcf980e14011eeb8927bc1f75efef4-20240313
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1696624639; Wed, 13 Mar 2024 21:48:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Mar 2024 21:48:01 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Mar 2024 21:48:01 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lena.wang@mediatek.com>, <shiming.cheng@mediatek.com>
Subject: [PATCH net] udp: fix segmentation crash for untrusted source packet
Date: Wed, 13 Mar 2024 21:34:02 +0800
Message-ID: <20240313133402.9027-1-shiming.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.036400-8.000000
X-TMASE-MatchedRID: wpfAD6xEq/UmcsJib2IjaZyebS/i2xjjRf40pT7Zmv4AhmnHHeGnvd5N
	RzJ0gz5Ho2jEjZ+uot2x/IsbGBsvcXHPBvSspzfjlUgQqGVMqmw+alo1+UETifgnJH5vm2+gE1H
	sA1hANbFWqgnWQ924PABrzRY/wC05Z4gQbTRJ1T0poxDq3DugMkyQ5fRSh265DpCUEeEFm7B91D
	unZtIaFuLzNWBegCW2wgn7iDBesS1YF3qW3Je6+3Cl2j/T96VWClrgwgRb4DTA1+j5xhROnF/E0
	Qms4izZ9dXR8igG1pZpqUV/1/kckl6hsFytkdpyBzxJxdddetpD1vQ6Bk4NMYCE5xpCtDRTUbJF
	yh4XXyqYo/TPOlMB4bCh3zE4wqa8wIE77PEBbml+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.036400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: EB00A10A7E0B78C7CD380D35C873753B8267A33E8C1FB10F0EF5AEE09A8965CE2000:8
X-MTK: N

Kernel exception is reported when making udp frag list segmentation.
Backtrace is as below:
    at out/android15-6.6/kernel-6.6/kernel-6.6/net/ipv4/udp_offload.c:229
    at out/android15-6.6/kernel-6.6/kernel-6.6/net/ipv4/udp_offload.c:262
features=features@entry=19, is_ipv6=false)
    at out/android15-6.6/kernel-6.6/kernel-6.6/net/ipv4/udp_offload.c:289
features=19)
    at out/android15-6.6/kernel-6.6/kernel-6.6/net/ipv4/udp_offload.c:399
features=19)
    at out/android15-6.6/kernel-6.6/kernel-6.6/net/ipv4/af_inet.c:1418
skb@entry=0x0, features=19, features@entry=0)
    at out/android15-6.6/kernel-6.6/kernel-6.6/net/core/gso.c:53
tx_path=<optimized out>)
    at out/android15-6.6/kernel-6.6/kernel-6.6/net/core/gso.c:124

This packet's frag list is null while gso_type is not 0. Then it is treated
as a GRO-ed packet and sent to segment frag list. Function call path is
udp_rcv_segment => config features value
    __udpv4_gso_segment  => skb_gso_ok returns false. Here it should be
                            true. Failed reason is features doesn't match
                            gso_type.
        __udp_gso_segment_list
            skb_segment_list => packet is linear with skb->next = NULL
            __udpv4_gso_segment_list_csum => use skb->next directly and
                                             crash happens

In rx-gro-list GRO-ed packet is set gso type as
NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST in napi_gro_complete. In gso
flow the features should also set them to match with gso_type. Or else it
will always return false in skb_gso_ok. Then it can't discover the
untrusted source packet and result crash in following function.

Fixes: f2696099c6c6 ("udp: Avoid post-GRO UDP checksum recalculation")
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
Signed-off-by: Lena Wang <lena.wang@mediatek.com>
---
 include/net/udp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 488a6d2babcc..c87baa23b9da 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -464,7 +464,7 @@ void udpv6_encap_enable(void);
 static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 					      struct sk_buff *skb, bool ipv4)
 {
-	netdev_features_t features = NETIF_F_SG;
+	netdev_features_t features = NETIF_F_SG | NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST;
 	struct sk_buff *segs;
 
 	/* Avoid csum recalculation by skb_segment unless userspace explicitly
-- 
2.18.0


