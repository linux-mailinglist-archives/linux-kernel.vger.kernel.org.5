Return-Path: <linux-kernel+bounces-72547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42085B505
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B231C2094C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EFF5D75A;
	Tue, 20 Feb 2024 08:25:06 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2BD5C8E4;
	Tue, 20 Feb 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417505; cv=none; b=lwKXbdchDwQnjy4OXyLoWdpbnVYpQA1BWRgRHVli99KjLpYxhWYx4kF2mgs0TPPrdD/guDG0WgXagAhHzo93w6ScoBpol5od72+oroAGFYqsiJRDypWmJbJXtfKH5FsugyQTcNmQQE0uKkgxe1Nh0clDRNYli6L/hLpuQM0OIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417505; c=relaxed/simple;
	bh=Ewm9aE8os5thGL+1GTINypV4Lp9agL4EjjAFq7lE0iU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZqx61zQ0l5pxVDWvkcxQFvkrqX3nLlTfPDiGzmQRQmitLo4MftGF3vh2VnG7yTUrSKY6n443XwbCFsKtTkj1JdZlRalc9Gulh2cD2dTK0XxvctrKAbioJgWKvUrG+jxHlInXXvycUgyaI8LgB6zyJQF3HosIsu+s9aZtLmIPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 734cc8e160aa41b990c82f18d54a2885-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:eb562f8f-bc8f-4890-9270-c5c5b1a46118,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:eb562f8f-bc8f-4890-9270-c5c5b1a46118,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:60f67e8f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240220153655OTY0JWRP,BulkQuantity:1,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 734cc8e160aa41b990c82f18d54a2885-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 113316440; Tue, 20 Feb 2024 15:36:54 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3015AE000EBC;
	Tue, 20 Feb 2024 15:36:54 +0800 (CST)
X-ns-mid: postfix-65D45696-2075820
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 6A410E000EBD;
	Tue, 20 Feb 2024 15:36:53 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiri@resnulli.us,
	Kunwu Chan <chentao@kylinos.cn>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH net-next v2 3/5] ipmr: Simplify the allocation of slab caches
Date: Tue, 20 Feb 2024 15:36:44 +0800
Message-Id: <20240220073646.102033-4-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220073646.102033-1-chentao@kylinos.cn>
References: <20240220073646.102033-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.
And change cache name from 'ip_mrt_cache' to 'mfc_cache'.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 net/ipv4/ipmr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 9d6f59531b3a..820c95bee6bb 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3139,10 +3139,7 @@ int __init ip_mr_init(void)
 {
 	int err;
=20
-	mrt_cachep =3D kmem_cache_create("ip_mrt_cache",
-				       sizeof(struct mfc_cache),
-				       0, SLAB_HWCACHE_ALIGN | SLAB_PANIC,
-				       NULL);
+	mrt_cachep =3D KMEM_CACHE(mfc_cache, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
=20
 	err =3D register_pernet_subsys(&ipmr_net_ops);
 	if (err)
--=20
2.39.2


