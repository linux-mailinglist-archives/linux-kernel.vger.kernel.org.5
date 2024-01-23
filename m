Return-Path: <linux-kernel+bounces-34648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD5B8385BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D85B27005
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10465139F;
	Tue, 23 Jan 2024 02:46:49 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B4374;
	Tue, 23 Jan 2024 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978008; cv=none; b=phRw/aHvUmARoZFX4aMo/1JLqEpJK0UmzrWl8tFcB2nC/9EN3Kq1FrMPJZdpA8VzJs3Q7nuEwJwTuVqYdJBhzkQJYnHCT7qcvyzcUtcpvern3eHIO8vmpbUXmJM9GqPz0bYh5j7qXpTULUkdtzPdX8VyYEslkVataX5cnczDVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978008; c=relaxed/simple;
	bh=DgpW2TYFY7FMhpYd9iFluKaHz62UIxRSWXxq6QZHrPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KFU1CkJkbishRyIWFdTJlBqaVEomazu8obgyR2uJwehuir/E0eQSGs0c923EnSz7n0DmxcthNNTiRrtnAfJj0kZsS8Oozybj8eG5w8dvSNcQittmkOKDhiyvt/j3zFHgxQ1oMWIZuqsRDsr5N6oYypiKl6F/ChxKv1a5OER/oyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5d505d236484480a9e29728173f68199-20240123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:3ae40562-b553-4881-b1b2-749a43e648c9,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:3ae40562-b553-4881-b1b2-749a43e648c9,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:457fa47f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240123104638C5ZVN90J,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 5d505d236484480a9e29728173f68199-20240123
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2008426615; Tue, 23 Jan 2024 10:46:37 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 100C8E000EB9;
	Tue, 23 Jan 2024 10:46:37 +0800 (CST)
X-ns-mid: postfix-65AF288C-825111420
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 379ACE000EB9;
	Tue, 23 Jan 2024 10:46:33 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH nf-next] netfilter: nf_conncount: Use KMEM_CACHE instead of kmem_cache_create()
Date: Tue, 23 Jan 2024 10:46:31 +0800
Message-Id: <20240123024631.396631-1-chentao@kylinos.cn>
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
 net/netfilter/nf_conncount.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 5d8ed6c90b7e..8715617b02fe 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -605,15 +605,11 @@ static int __init nf_conncount_modinit(void)
 	for (i =3D 0; i < CONNCOUNT_SLOTS; ++i)
 		spin_lock_init(&nf_conncount_locks[i]);
=20
-	conncount_conn_cachep =3D kmem_cache_create("nf_conncount_tuple",
-					   sizeof(struct nf_conncount_tuple),
-					   0, 0, NULL);
+	conncount_conn_cachep =3D KMEM_CACHE(nf_conncount_tuple, 0);
 	if (!conncount_conn_cachep)
 		return -ENOMEM;
=20
-	conncount_rb_cachep =3D kmem_cache_create("nf_conncount_rb",
-					   sizeof(struct nf_conncount_rb),
-					   0, 0, NULL);
+	conncount_rb_cachep =3D KMEM_CACHE(nf_conncount_rb, 0);
 	if (!conncount_rb_cachep) {
 		kmem_cache_destroy(conncount_conn_cachep);
 		return -ENOMEM;
--=20
2.39.2


