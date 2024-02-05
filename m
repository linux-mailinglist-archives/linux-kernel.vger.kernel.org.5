Return-Path: <linux-kernel+bounces-52131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584E3849470
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFB71F25816
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2314AAD;
	Mon,  5 Feb 2024 07:21:00 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE6111A2;
	Mon,  5 Feb 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117660; cv=none; b=QrVjTvFT31LurIGu3jsTRfrC7Ge2duwrXRGwkau/SbhW7HlAHx+73pXnHiXCqyOfWz3N8nlFr44H+HSB1jpMOuN5d0K2FAwuxzh/2uLIzUvwj9KbcMwHxjVpsAXL4vHjMZQqJtzq6F4ENhxbdKGj8JkrztRAlueA2EaMhe5c6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117660; c=relaxed/simple;
	bh=2RPhHIO24rO7DrKNGK166qDpBMo7ED6D9CiaT+aa0kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=slDNABwoIz4GBxsgzQfZGbg16AW1HvW8dRHKQgf2Mee4xJlsqdjUT2f9yVSEBv1GA9t2xAiFi8ncT7+b9aAoXHI+SlvKfnqh5fFzeZA9CYqqzHFMoAaj8YRxEL6H4LhEboOUzOPzC7KfH9uNm403Lg4M+XTjxR9qdNwZxxzgdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3c01047df7ec4e4c9cf90160e14ee212-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:2fe792de-25ed-4861-8503-5727ad80d150,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:2fe792de-25ed-4861-8503-5727ad80d150,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:cbb1a083-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240205152054PAMNL1WR,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 3c01047df7ec4e4c9cf90160e14ee212-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2062955715; Mon, 05 Feb 2024 15:20:53 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 123C0E000EBC;
	Mon,  5 Feb 2024 15:20:53 +0800 (CST)
X-ns-mid: postfix-65C08C54-87813279
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 5B4D9E000EBD;
	Mon,  5 Feb 2024 15:20:52 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH net-next 6/6] ipv6: Simplify the allocation of slab caches
Date: Mon,  5 Feb 2024 15:20:13 +0800
Message-Id: <20240205072013.427639-7-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205072013.427639-1-chentao@kylinos.cn>
References: <20240205072013.427639-1-chentao@kylinos.cn>
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
 net/ipv6/ip6_fib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 4fc2cae0d116..25d7e6d45e6a 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2444,10 +2444,8 @@ int __init fib6_init(void)
 {
 	int ret =3D -ENOMEM;
=20
-	fib6_node_kmem =3D kmem_cache_create("fib6_nodes",
-					   sizeof(struct fib6_node), 0,
-					   SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT,
-					   NULL);
+	fib6_node_kmem =3D KMEM_CACHE(fib6_node,
+				    SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT);
 	if (!fib6_node_kmem)
 		goto out;
=20
--=20
2.39.2


