Return-Path: <linux-kernel+bounces-47940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9718454E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E1E28AA8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA115B969;
	Thu,  1 Feb 2024 10:09:39 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C134DA1D;
	Thu,  1 Feb 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782179; cv=none; b=ApgvLUXrYObTFZDRNHSazrVQZ0szK65JDJigmlMveBcSCkq7IZee0/URFDOJ3Wcf8z0friFY22ZQKK3ycjdUZGCY1klmqbPL01pEdF6iiZ3qH5WKMrXaNUOddSmvfTWX/8n+EHVf5j69MDnVv4HQOtOiPCiffvRtE9SFM5y0Xb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782179; c=relaxed/simple;
	bh=sUELeIL8A4dMOkQ6Uu6mJ6Gg/l8qd0uKqcRrayxEFTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YWYokFJ2SOSxzvR0GOUxz3JgDFv1LXYk8xPUm4ClEf03vCZwNoJq/RJR6XtzI8QEkeSWHQQtBfuGALxKLnxFsKCN6w++4j0SjWhlHYCQM6PwmTwmMVftfvn+uCGbNvyIMUaHOPlPZXRXrpxTH6DKN+uRRfF/YiybcwmpOfWJe3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8e60355f3f044216afb21e30a2e3a3e9-20240201
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5a88fb0a-d436-49d2-8459-4aef407d2d46,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:5a88fb0a-d436-49d2-8459-4aef407d2d46,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:80c80180-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240201180932CHGT3RUC,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 8e60355f3f044216afb21e30a2e3a3e9-20240201
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1476708960; Thu, 01 Feb 2024 18:09:29 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A812AE000EB9;
	Thu,  1 Feb 2024 18:09:29 +0800 (CST)
X-ns-mid: postfix-65BB6DD9-4795091386
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 1FB48E000EB9;
	Thu,  1 Feb 2024 18:09:25 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH net-next] rxrpc: Simplify the allocation of slab caches
Date: Thu,  1 Feb 2024 18:09:24 +0800
Message-Id: <20240201100924.210298-1-chentao@kylinos.cn>
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
 net/rxrpc/af_rxrpc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 465bfe5eb061..1326a1bff2d7 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -1026,9 +1026,7 @@ static int __init af_rxrpc_init(void)
=20
 	ret =3D -ENOMEM;
 	rxrpc_gen_version_string();
-	rxrpc_call_jar =3D kmem_cache_create(
-		"rxrpc_call_jar", sizeof(struct rxrpc_call), 0,
-		SLAB_HWCACHE_ALIGN, NULL);
+	rxrpc_call_jar =3D KMEM_CACHE(rxrpc_call,	SLAB_HWCACHE_ALIGN);
 	if (!rxrpc_call_jar) {
 		pr_notice("Failed to allocate call jar\n");
 		goto error_call_jar;
--=20
2.39.2


