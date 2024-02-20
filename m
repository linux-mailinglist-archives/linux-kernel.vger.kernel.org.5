Return-Path: <linux-kernel+bounces-72543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C5D85B500
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6135E1F21B97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE9C5CDF4;
	Tue, 20 Feb 2024 08:25:05 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AA5C8EA;
	Tue, 20 Feb 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417505; cv=none; b=eiyGjFac044jPM7vsgvUMsLHTu/EuN200kjBzTWThvHw0Y3FubBb07WMbKggIbUaeeWTnz1mMI8ca3V38Gwo2382TVLwhOfkkf9PPxDL9OpaLWaDrknLW3bBebPa070wlpueomBQe8jDX4tp8ZivuvX2RC+T4PUou2Qmzy6Q6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417505; c=relaxed/simple;
	bh=+w+mRN6Xuei5AS2KampiNpZLGpy3MvgpnukzVAOQA24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scK/xk9GiduNw4p577SS93QHTtIBGfvXAzcEov+XNAzcqyQ5fQ2TqAgyOHSQVSfRrImoiFtqNHHEvBFP2tJBMUmqG1MRArdHqvJz+Hm0wTMuc87DgRuencHiROi5tNC35dBCn6S0T/JUU/DJyI7OC2OB4baNi+qybXvQxPTECOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e76ac4262ba44dd3adedc0eb3e9b2ca8-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:db588860-89b4-42ab-9066-b37eb2441484,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:db588860-89b4-42ab-9066-b37eb2441484,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:b6121884-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240220153658NWT9W1ND,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: e76ac4262ba44dd3adedc0eb3e9b2ca8-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2003651422; Tue, 20 Feb 2024 15:36:56 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D0490E000EBC;
	Tue, 20 Feb 2024 15:36:55 +0800 (CST)
X-ns-mid: postfix-65D45697-68413322
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 187D8E000EBD;
	Tue, 20 Feb 2024 15:36:55 +0800 (CST)
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
Subject: [PATCH net-next v2 5/5] ipv6: Simplify the allocation of slab caches
Date: Tue, 20 Feb 2024 15:36:46 +0800
Message-Id: <20240220073646.102033-6-chentao@kylinos.cn>
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

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
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


