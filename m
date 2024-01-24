Return-Path: <linux-kernel+bounces-36622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAE683A3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7C21F2C719
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A821755E;
	Wed, 24 Jan 2024 08:16:08 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9528171DD;
	Wed, 24 Jan 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084168; cv=none; b=spDpBlNMxz1tBQ0S3KbpkHXKvXNJ/OgXq9TAVqLUZRtoVEr3w+RVMR/QzajEvYIoskHOyThtvvhVhBHgmkv6izli10KSpGr8bBxyThWdN4Qj+IUjZ76rZzk5mg0g0gFCca+XsnOtugymKnDjKdqFl1PV+wowQXO51lf8qfq7o4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084168; c=relaxed/simple;
	bh=/rMbIQJ3jD9TaP/pGU36ORETs0NOMF3ehutw65TTBjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BULlRE7R6Sl0GFAaypvhlEKaRJ45ukn2DWGips/nhnxI3LD+8RFSMV+OTRA5I4NiBlELzRbux7gmfcc9yi+A2KYmbowa9fFwN0Bbir/W3ZMbLQI0uBocXBNoHNT1OnHO3AZwmgFelpItBwTvVDvbIifXwzdVStkxqtUJ3YhuPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b74478b947e1476c901ee4951d5ba963-20240124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:6aa79073-3673-4d3f-bbdb-ab9a9d335fa4,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:6aa79073-3673-4d3f-bbdb-ab9a9d335fa4,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:dd019a8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:24012416154925IVVJGH,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: b74478b947e1476c901ee4951d5ba963-20240124
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2092884169; Wed, 24 Jan 2024 16:15:47 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 57CD3E000EB9;
	Wed, 24 Jan 2024 16:15:47 +0800 (CST)
X-ns-mid: postfix-65B0C733-158474490
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 88D6EE000EB9;
	Wed, 24 Jan 2024 16:15:39 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH nf-next] netfilter: expect: Simplify the allocation of slab caches in nf_conntrack_expect_init
Date: Wed, 24 Jan 2024 16:15:38 +0800
Message-Id: <20240124081538.472522-1-chentao@kylinos.cn>
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
 net/netfilter/nf_conntrack_expect.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_connt=
rack_expect.c
index 81ca348915c9..21fa550966f0 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -722,9 +722,7 @@ int nf_conntrack_expect_init(void)
 			nf_ct_expect_hsize =3D 1;
 	}
 	nf_ct_expect_max =3D nf_ct_expect_hsize * 4;
-	nf_ct_expect_cachep =3D kmem_cache_create("nf_conntrack_expect",
-				sizeof(struct nf_conntrack_expect),
-				0, 0, NULL);
+	nf_ct_expect_cachep =3D KMEM_CACHE(nf_conntrack_expect, 0);
 	if (!nf_ct_expect_cachep)
 		return -ENOMEM;
=20
--=20
2.39.2


