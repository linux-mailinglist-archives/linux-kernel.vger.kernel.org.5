Return-Path: <linux-kernel+bounces-84457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1565886A6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4685D1C236BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8A200B7;
	Wed, 28 Feb 2024 03:01:06 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACB1F945;
	Wed, 28 Feb 2024 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089266; cv=none; b=oakrje9af5z35a74/0ML18fz03mMHS83Sfnc1CD7XAgGNROTDcUZPFhqMgwLpyG2CX1+TMWvDB95M0scVcIJ2cVTIr3FQpqmX4XpuUMDhmpPU6S8g9yWF1pwQjZz1JzGSFU7sTaAc7E5502tDL8dHZz17wgRTJuuTxvUwcb2Jvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089266; c=relaxed/simple;
	bh=LYAx6i2cOnkhf1XESQN7LgtJo9zHj/YnHlJ+pCyQkWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AcGpeQKRuH8H+uyHUBOeji8NwGgVzt6WsJCPk7HAyHbZV7Gf3YG1foeldnYv8t2MBV4HvVHHrK3dJ3f7PEklTPrA1p6RvTGtat4BruNFj/D4Pfdnceqr/CN38A3c55Euqavg6cVwaQdk8vFNvSr9Uck2YsN1DOTtW19wjGr6BPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 61f36a06ab6c4d4088c73fea239f1afd-20240228
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2eea6bf1-5c20-4404-b771-0ed2897f1d65,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.37,REQID:2eea6bf1-5c20-4404-b771-0ed2897f1d65,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6f543d0,CLOUDID:3fdae480-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2402281101007PHTMKEX,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 61f36a06ab6c4d4088c73fea239f1afd-20240228
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 275689174; Wed, 28 Feb 2024 11:00:59 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 2E6EAE000EBD;
	Wed, 28 Feb 2024 11:00:59 +0800 (CST)
X-ns-mid: postfix-65DEA1EA-976147471
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 254A8E000EBC;
	Wed, 28 Feb 2024 11:00:57 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: manivannan.sadhasivam@linaro.org
Cc: mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2] bus: mhi: ep: Simplify the allocation of slab caches in mhi_ep_register_controller
Date: Wed, 28 Feb 2024 11:00:56 +0800
Message-Id: <20240228030056.509994-1-chentao@kylinos.cn>
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
v2:
    - Simplify the allocations of mhi_ring_element slab caches
---
 drivers/bus/mhi/ep/main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 65fc1d738bec..795611482f16 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1478,9 +1478,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl =
*mhi_cntrl,
 		goto err_free_ch;
 	}
=20
-	mhi_cntrl->ev_ring_el_cache =3D kmem_cache_create("mhi_ep_event_ring_el=
",
-							sizeof(struct mhi_ring_element), 0,
-							SLAB_CACHE_DMA, NULL);
+	mhi_cntrl->ev_ring_el_cache =3D KMEM_CACHE(mhi_ring_element, SLAB_CACHE=
_DMA);
 	if (!mhi_cntrl->ev_ring_el_cache) {
 		ret =3D -ENOMEM;
 		goto err_free_cmd;
@@ -1493,9 +1491,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl =
*mhi_cntrl,
 		goto err_destroy_ev_ring_el_cache;
 	}
=20
-	mhi_cntrl->ring_item_cache =3D kmem_cache_create("mhi_ep_ring_item",
-							sizeof(struct mhi_ep_ring_item), 0,
-							0, NULL);
+	mhi_cntrl->ring_item_cache =3D KMEM_CACHE(mhi_ep_ring_item, 0);
 	if (!mhi_cntrl->ev_ring_el_cache) {
 		ret =3D -ENOMEM;
 		goto err_destroy_tre_buf_cache;
--=20
2.39.2


