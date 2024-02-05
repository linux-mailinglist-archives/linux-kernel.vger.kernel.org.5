Return-Path: <linux-kernel+bounces-52202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E684954D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAFE1F21EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623BB1170A;
	Mon,  5 Feb 2024 08:24:38 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5651119B;
	Mon,  5 Feb 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121478; cv=none; b=tCLluaNBu2Lg0QdNaUYTss8s5g1wEAGcULlRVtEz+n10aWOxsaVg6jfKmAEDL0yh07aVFRV4kvsePkBpE3rKB5nlXtOZNXMO16lo0CugKsG2KozayMFwNO/viM8lBo/FEov8pdSnGMqCPYfE+rCgycUpuMMiRg9FB3AOCbLy2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121478; c=relaxed/simple;
	bh=KQpaPLqSEolF8emsWTskFJOpRGHDfiOKvR6xUfHJThE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KMPQXHdyUCsFdbYZfomFEkezuC8BkLMrMrtCy1tp9f9DNYpjBzz2es41q6Qk9vMksNLSKkSY0s98zLzD7/4Hx+YEN9SSInRCXt8DHXNou1IcRZ+wWjbmOig3tcH2gMFWvD39v5Ld8iVFDHDLJU0+R/x4tafLcfvrC82q6U9/UtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f9bc70ff996c4d7392f84dd422bb2e54-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:4e29416e-52ab-436f-85b1-2bd53a7c5caf,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:4e29416e-52ab-436f-85b1-2bd53a7c5caf,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:eb9c86fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:240205162428F9EWJSI9,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: f9bc70ff996c4d7392f84dd422bb2e54-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1214818029; Mon, 05 Feb 2024 16:24:26 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E7E6BE000EBC;
	Mon,  5 Feb 2024 16:24:25 +0800 (CST)
X-ns-mid: postfix-65C09B39-75837763
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 41994E000EBC;
	Mon,  5 Feb 2024 16:24:25 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: chandan.babu@oracle.com,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] xfs: Simplify the allocation of slab caches in xfs_attr_intent_init_cache
Date: Mon,  5 Feb 2024 16:24:23 +0800
Message-Id: <20240205082423.435569-1-chentao@kylinos.cn>
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
 fs/xfs/libxfs/xfs_attr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 9976a00a73f9..c8e1c741701f 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -1530,9 +1530,7 @@ xfs_attr_namecheck(
 int __init
 xfs_attr_intent_init_cache(void)
 {
-	xfs_attr_intent_cache =3D kmem_cache_create("xfs_attr_intent",
-			sizeof(struct xfs_attr_intent),
-			0, 0, NULL);
+	xfs_attr_intent_cache =3D KMEM_CACHE(xfs_attr_intent, 0);
=20
 	return xfs_attr_intent_cache !=3D NULL ? 0 : -ENOMEM;
 }
--=20
2.39.2


