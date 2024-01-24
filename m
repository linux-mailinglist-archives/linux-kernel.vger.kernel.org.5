Return-Path: <linux-kernel+bounces-36509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E444083A20F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43799286128
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F418FBEE;
	Wed, 24 Jan 2024 06:32:12 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2876E628;
	Wed, 24 Jan 2024 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077932; cv=none; b=awpcNBhcmMAjIbfTMjDllziVlqbtBdX27+NYtW34Ifa1SUnvUg8SVfwyr5MIWi9kFqHr4DHLjeJ6bCrkClCC5Oeoe1pLnkQKVfF3RKs180KSjkBjqT+OKeN9uFJrVsmC+sj542o7ccRZvQrkJrrGzP/8Olb0OvNozDtUp1bQplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077932; c=relaxed/simple;
	bh=NvCcD3W3GSdtW3pNjgJjBbWGVqSOk97olzUAFiThvuY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ezr1Gh3oRDRD7njjPoolOe+yskFSNgAcBOc3A7r0/ca7JQyhb/wIqJg+4GI8Ene7cPHApqy/ypsOt+vkXjTsWivNUQkiWC/MYtmzhcPu6+TbujGxPcJ+OshMBqf2mum3ar4vQVrEaSHikXXq1JTjsq9nBnZBlKzGII25+ntjNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 66264f1f20144503a1659c927b204992-20240124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a7a4f507-c00e-4fc7-9273-f8a515d1704b,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:a7a4f507-c00e-4fc7-9273-f8a515d1704b,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:69c1988e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2401241431565TKGFV73,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 66264f1f20144503a1659c927b204992-20240124
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 978852981; Wed, 24 Jan 2024 14:31:55 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 92849E000EB9;
	Wed, 24 Jan 2024 14:31:55 +0800 (CST)
X-ns-mid: postfix-65B0AEDB-395396169
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id CBC81E000EB9;
	Wed, 24 Jan 2024 14:31:51 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH ipsec-next] xfrm6_tunnel: Use KMEM_CACHE instead of kmem_cache_create
Date: Wed, 24 Jan 2024 14:31:50 +0800
Message-Id: <20240124063150.466037-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/ipv6/xfrm6_tunnel.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index 1323f2f6928e..0f3df26878a3 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -355,10 +355,7 @@ static int __init xfrm6_tunnel_init(void)
 {
 	int rv;
=20
-	xfrm6_tunnel_spi_kmem =3D kmem_cache_create("xfrm6_tunnel_spi",
-						  sizeof(struct xfrm6_tunnel_spi),
-						  0, SLAB_HWCACHE_ALIGN,
-						  NULL);
+	xfrm6_tunnel_spi_kmem =3D KMEM_CACHE(xfrm6_tunnel_spi, SLAB_HWCACHE_ALI=
GN);
 	if (!xfrm6_tunnel_spi_kmem)
 		return -ENOMEM;
 	rv =3D register_pernet_subsys(&xfrm6_tunnel_net_ops);
--=20
2.39.2


