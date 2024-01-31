Return-Path: <linux-kernel+bounces-46157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A56843B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81AB1F2AD06
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6846A69D09;
	Wed, 31 Jan 2024 09:43:40 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A369946;
	Wed, 31 Jan 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694220; cv=none; b=Hn/o8goL/Fqzc3kXfpb9rWD0zzo93sPS85xgojRfrZ2n64QPFIOF8Oo/MFip0JYkY8lb3KXKJeoT01fQniSkFT+B1JY82DJwzl8r6x29icLkQhdBR2c4WqnVT5jQbFH3gARSWMmuWW2D0/mQ0mPHJfWfX1u+F/deBcoY/zCmkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694220; c=relaxed/simple;
	bh=WsYGGzm0F3dQ6/wcAMA18RrThIlvQvZG/zk8rYg2uCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YP7aBsrkTCNykZglpkgRVlo3wiWhy10WAOcQEhdIWsulQegRCwXau9K5qWyRbwgKCQHA8MUIfllkjnlWIblR+h9sTxlTTiqnDJeOLqCMJkBsNsjxAMtLPlmOqDLTkV4B6MzBDL2sbb1FjPSbpQGElXHrIwMtBv8DvnhP9JXwgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2647e6bb8f1747718792413957e60165-20240131
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a68bdf03-6d53-48aa-9e37-dffe91fce23d,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:0
X-CID-INFO: VERSION:1.1.35,REQID:a68bdf03-6d53-48aa-9e37-dffe91fce23d,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:df9ff57f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240131174329P1TI2LZ4,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2647e6bb8f1747718792413957e60165-20240131
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 260317277; Wed, 31 Jan 2024 17:43:27 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7216BE000EB9;
	Wed, 31 Jan 2024 17:43:27 +0800 (CST)
X-ns-mid: postfix-65BA163F-267981979
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 10A4DE000EB9;
	Wed, 31 Jan 2024 17:43:26 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] block: Simplify the allocation of slab caches
Date: Wed, 31 Jan 2024 17:43:23 +0800
Message-Id: <20240131094323.146659-1-chentao@kylinos.cn>
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
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f28859b4a3ef..6898d2e6e3c4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1224,8 +1224,7 @@ int __init blk_dev_init(void)
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
=20
-	blk_requestq_cachep =3D kmem_cache_create("request_queue",
-			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
+	blk_requestq_cachep =3D KMEM_CACHE(request_queue, SLAB_PANIC);
=20
 	blk_debugfs_root =3D debugfs_create_dir("block", NULL);
=20
--=20
2.39.2


