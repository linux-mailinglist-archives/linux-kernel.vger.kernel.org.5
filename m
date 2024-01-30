Return-Path: <linux-kernel+bounces-44108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66350841D65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226CC28FBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A260B8C;
	Tue, 30 Jan 2024 08:14:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5F1605D8;
	Tue, 30 Jan 2024 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602474; cv=none; b=W7q1ijeZQs7R2y4m9m6lHn2FLdDG19nKSTQFJJT3lsSJdXthbGp06wISvjsWRlhzmwCWz+zldvz+Ac2cr2PEL9raqx4+aOvEUVdeCgKLYOzei5LHHydnq5wM/11LxXP2B2nGJinR6RyK7tPRaVNr3KIAI4/r0aYPUrdcDol3uGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602474; c=relaxed/simple;
	bh=2X8SIWoitl+VKVgntwPYWRKMalIKKPmqONWJZDOtlBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WbJPcDi3+Rxogbpg/x45k4W92TFWQzNcN6ynHS6GcUq9D+1/45BN4XAZDvn2+5RDuXyN8EL8zeomHhPcjYhXJvCb+eVgdALMuGRnlfWgL9LslC90IkCr4Ov/mpA9l9UHqgaD5S2sKooqV/oi3dWm4zSwcd660XPxVRwDUou1ekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8038e5d20ca848c3927a7be67658d64c-20240130
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f1c4e82b-a40f-43e6-aa2a-683b630f6be4,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:f1c4e82b-a40f-43e6-aa2a-683b630f6be4,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:5f136983-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240130161419ZQQNJ2TK,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 8038e5d20ca848c3927a7be67658d64c-20240130
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 409578972; Tue, 30 Jan 2024 16:14:17 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 8CD10E000EBB;
	Tue, 30 Jan 2024 16:14:17 +0800 (CST)
X-ns-mid: postfix-65B8AFD9-367288681
Received: from kernel.. (unknown [172.20.15.213])
	by mail.kylinos.cn (NSMail) with ESMTPA id 1A722E000EB9;
	Tue, 30 Jan 2024 16:14:13 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH ipsec-next] xfrm: Simplify the allocation of slab caches in xfrm_policy_init
Date: Tue, 30 Jan 2024 16:14:11 +0800
Message-Id: <20240130081411.58246-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
introduces a new macro.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/xfrm/xfrm_policy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7351f32052dc..6ac97e0b66cb 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4025,10 +4025,7 @@ static int __net_init xfrm_policy_init(struct net =
*net)
 	int dir, err;
=20
 	if (net_eq(net, &init_net)) {
-		xfrm_dst_cache =3D kmem_cache_create("xfrm_dst_cache",
-					   sizeof(struct xfrm_dst),
-					   0, SLAB_HWCACHE_ALIGN|SLAB_PANIC,
-					   NULL);
+		xfrm_dst_cache =3D KMEM_CACHE(xfrm_dst, SLAB_HWCACHE_ALIGN | SLAB_PANI=
C);
 		err =3D rhashtable_init(&xfrm_policy_inexact_table,
 				      &xfrm_pol_inexact_params);
 		BUG_ON(err);
--=20
2.39.2


