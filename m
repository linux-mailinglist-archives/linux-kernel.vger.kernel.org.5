Return-Path: <linux-kernel+bounces-28593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7937830074
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDEE1C23953
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BA1BA50;
	Wed, 17 Jan 2024 07:21:41 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2D8F65;
	Wed, 17 Jan 2024 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476101; cv=none; b=UGpwCkpseiDOI036cgDUWJ2I6O23BB6K6oFCn5iEuoJQeAjmvHmj5SyHXlATxbRykX6s+NlEaS5+uYFb1UJ0KZ05Pp4ANjlhhmVe+lHsrF72IQ8gHg9BnG8bkYN6+fMdV9uoMSQF619y5Xb8jQviZo2Ao+Nx0bkp8IPcjhI3Gsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476101; c=relaxed/simple;
	bh=O85UiwYAkF07o9wiQzUPQRXlOapOHteQzq9bjUp60XQ=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=Rwf0tNtcY5iDKf12P6e0fJnZJCHfxqLn4BhU3Eqol39LINr9iJDIpi9XWjSQAbhc53h3nTDMyrMI1NYqQrZmEFSLcHxVpWhKb4/oh6fHYzCgitbNLpemkTwlz45RtCbIlgdM6BleWhq4MHO5VgsJA1bQowPgDGBi6MbpPdULH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2a46221058924310b9c594314f2c70d8-20240117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e7c0f8e5-df89-401e-9dd4-769b4832632e,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:e7c0f8e5-df89-401e-9dd4-769b4832632e,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:9f08422f-1ab8-4133-9780-81938111c800,B
	ulkID:240117152134M9ZOJKSL,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 2a46221058924310b9c594314f2c70d8-20240117
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 697907986; Wed, 17 Jan 2024 15:21:33 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7AFCAE000EB9;
	Wed, 17 Jan 2024 15:21:33 +0800 (CST)
X-ns-mid: postfix-65A77FFD-295721259
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id B043EE000EB9;
	Wed, 17 Jan 2024 15:21:28 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: horms@verge.net.au,
	ja@ssi.bg,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH net] ipvs: Simplify the allocation of ip_vs_conn slab caches
Date: Wed, 17 Jan 2024 15:20:45 +0800
Message-Id: <20240117072045.142215-1-chentao@kylinos.cn>
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
 net/netfilter/ipvs/ip_vs_conn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_c=
onn.c
index a743db073887..98d7dbe3d787 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -1511,9 +1511,7 @@ int __init ip_vs_conn_init(void)
 		return -ENOMEM;
=20
 	/* Allocate ip_vs_conn slab cache */
-	ip_vs_conn_cachep =3D kmem_cache_create("ip_vs_conn",
-					      sizeof(struct ip_vs_conn), 0,
-					      SLAB_HWCACHE_ALIGN, NULL);
+	ip_vs_conn_cachep =3D KMEM_CACHE(ip_vs_conn, SLAB_HWCACHE_ALIGN);
 	if (!ip_vs_conn_cachep) {
 		kvfree(ip_vs_conn_tab);
 		return -ENOMEM;
--=20
2.39.2


