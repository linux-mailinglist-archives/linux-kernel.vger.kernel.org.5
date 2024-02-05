Return-Path: <linux-kernel+bounces-52191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682F849524
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D091C235B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9644111AD;
	Mon,  5 Feb 2024 08:12:49 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879611197;
	Mon,  5 Feb 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120769; cv=none; b=m0k3f1LH6x6JbsZMtAeOH+db6e4Nr2GkVZQx0J1Pjj8Fs0abAdtQjde9bgfg6hMu/3N48HG/+vHuQmMte91A8yQ9l5rf6qPb1JZ/rkeNVU28hsbpvdw22uQZX2frh1YuNMtxzxFQ56Y+bj/5e3yg238O2lPCPlDb/f4AztS95Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120769; c=relaxed/simple;
	bh=rfUa0HdmE6ij/bFudS3tT0s17llFqfefDKIJnb9AgNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lAEuOPxdnPpRCmVwHRRitLOA2E1/n/qvs/Vqd4Jnrnm6erDM1kWVQRN325HYPa4O3ugW/6/kFINT10btYeVh7pg0thm9MybrXQkhyMwxirvHW+TDjZK/9NCmlHmOTMfPcN7d0EyoiSGOypEKaga71nr/D/3eexkQgt69aMTr9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1ae78dc8005d4e47a8ded7444ee00e25-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:aee657ed-6156-4f0f-8642-ad02761df660,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:aee657ed-6156-4f0f-8642-ad02761df660,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:c956a183-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240205161243P4PVZV2C,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1ae78dc8005d4e47a8ded7444ee00e25-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 979480105; Mon, 05 Feb 2024 16:12:40 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1DB37E000EBC;
	Mon,  5 Feb 2024 16:12:40 +0800 (CST)
X-ns-mid: postfix-65C09877-93077738
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id A7178E000EBC;
	Mon,  5 Feb 2024 16:12:39 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: chandan.babu@oracle.com,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] xfs: Simplify the allocation of slab caches in xfs_rmap_intent_init_cache
Date: Mon,  5 Feb 2024 16:12:27 +0800
Message-Id: <20240205081227.434198-1-chentao@kylinos.cn>
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
 fs/xfs/libxfs/xfs_rmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_rmap.c b/fs/xfs/libxfs/xfs_rmap.c
index 76bf7f48cb5a..99aac6f6f6b1 100644
--- a/fs/xfs/libxfs/xfs_rmap.c
+++ b/fs/xfs/libxfs/xfs_rmap.c
@@ -2931,9 +2931,7 @@ const struct xfs_owner_info XFS_RMAP_OINFO_COW =3D =
{
 int __init
 xfs_rmap_intent_init_cache(void)
 {
-	xfs_rmap_intent_cache =3D kmem_cache_create("xfs_rmap_intent",
-			sizeof(struct xfs_rmap_intent),
-			0, 0, NULL);
+	xfs_rmap_intent_cache =3D KMEM_CACHE(xfs_rmap_intent, 0);
=20
 	return xfs_rmap_intent_cache !=3D NULL ? 0 : -ENOMEM;
 }
--=20
2.39.2


