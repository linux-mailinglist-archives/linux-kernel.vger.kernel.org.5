Return-Path: <linux-kernel+bounces-52129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDF84946C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82AEB2449A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40513111AB;
	Mon,  5 Feb 2024 07:20:58 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359414003;
	Mon,  5 Feb 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117657; cv=none; b=ETnwbRABu0hRB10RJj+LzrLC1y3ZDRsVdBj+/o5qpwWu5VAuZ6zSPQuVwSR+j2zkVNIwv123gw4jhBuwpKZIbqPA152JthBuqngf4LqdvPjHBoYW+ShK4MkdQQWz1LXpGdhNAVdNaMJ5qaj8w4h8J5mdWwt7WKWI7ups6iu4NJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117657; c=relaxed/simple;
	bh=RHE0LMIn4zyWVNGXbkE7p6boihvrVpYXBiDhFq/TJGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itkB4JgM2nmdeuuMxiHB2IplWrqysuOuQ+/FPGxtGsYoRyawEQGXHZK74F/kOdmQKkwANwVPhphH2V+NMJUOi8GYmZNBsySzPzZriLdvNF+XYdhKlL4AZn/MCJsomRYcVYNuc/pvaS2fYTflHBDsTVfCzqsAJ4ZXrFJZLoPSxFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 48ae3ccd55694fbabe74fcc28e97ff4f-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:2c1467bf-ae10-4938-a48f-4bd262aa0b81,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:2c1467bf-ae10-4938-a48f-4bd262aa0b81,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:aeb1a083-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240205152050HVK6NM51,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 48ae3ccd55694fbabe74fcc28e97ff4f-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1240959891; Mon, 05 Feb 2024 15:20:49 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id ADDA3E000EBC;
	Mon,  5 Feb 2024 15:20:49 +0800 (CST)
X-ns-mid: postfix-65C08C51-51464976
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 0134EE000EBC;
	Mon,  5 Feb 2024 15:20:48 +0800 (CST)
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
Subject: [PATCH net-next 4/6] ipv4: Simplify the allocation of slab caches in ip_rt_init
Date: Mon,  5 Feb 2024 15:20:11 +0800
Message-Id: <20240205072013.427639-5-chentao@kylinos.cn>
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
And change cache name from 'ip_dst_cache' to 'rtable'.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/ipv4/route.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 16615d107cf0..b512288d6fcc 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3693,9 +3693,8 @@ int __init ip_rt_init(void)
 		panic("IP: failed to allocate ip_rt_acct\n");
 #endif
=20
-	ipv4_dst_ops.kmem_cachep =3D
-		kmem_cache_create("ip_dst_cache", sizeof(struct rtable), 0,
-				  SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
+	ipv4_dst_ops.kmem_cachep =3D KMEM_CACHE(rtable,
+					      SLAB_HWCACHE_ALIGN | SLAB_PANIC);
=20
 	ipv4_dst_blackhole_ops.kmem_cachep =3D ipv4_dst_ops.kmem_cachep;
=20
--=20
2.39.2


