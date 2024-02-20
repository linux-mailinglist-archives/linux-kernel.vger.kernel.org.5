Return-Path: <linux-kernel+bounces-72546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D648585B503
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150DE1C20AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7635D481;
	Tue, 20 Feb 2024 08:25:06 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFB5C8E5;
	Tue, 20 Feb 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417505; cv=none; b=EbAJ3nMFSaoUl+uRIr4RLu2fUGrxVL/w9eg6rP4dt4CpdfUDDVqbyO3YAOKviUYc2Q1RYq7hmlTojtd/x9ISm9KiRSGzN8Sm9IUUvB5Ncr73uoCs0+Fy7dEFuiktofzlDJDqfOiz51GGEnqCoKj5dMHK2H2KyhYICxvykTwRMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417505; c=relaxed/simple;
	bh=ReuleouYnuzsUZPagxclzFw7E1W2ioD+wkHnlAUNSQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNNE5oOSFpAJhb/GkR/zaxP6rPvkIfOGN3l3Q8CGA1mNM0AnTU0hSE0w1cF06mQDz3lu7m7EJVjXBocjihjqWJKdm4vPGNGUKWpZWBrfP99aft1wm17iVkOe5B+vzOlTuJJMV09VScY2yJQqRpABHscy5byjcktrOHPDuFl18aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e97d3e886b344174aa31eec5022e6eb4-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:80761d99-db20-4992-a924-713ab21de6fe,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:15
X-CID-INFO: VERSION:1.1.35,REQID:80761d99-db20-4992-a924-713ab21de6fe,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-META: VersionHash:5d391d7,CLOUDID:b4fc9780-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240220153655KYLGABEG,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: e97d3e886b344174aa31eec5022e6eb4-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1641455968; Tue, 20 Feb 2024 15:36:55 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 087D9E000EBC;
	Tue, 20 Feb 2024 15:36:55 +0800 (CST)
X-ns-mid: postfix-65D45696-85943521
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 40744E000EBD;
	Tue, 20 Feb 2024 15:36:54 +0800 (CST)
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
Subject: [PATCH net-next v2 4/5] ipv4: Simplify the allocation of slab caches in ip_rt_init
Date: Tue, 20 Feb 2024 15:36:45 +0800
Message-Id: <20240220073646.102033-5-chentao@kylinos.cn>
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
And change cache name from 'ip_dst_cache' to 'rtable'.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
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


