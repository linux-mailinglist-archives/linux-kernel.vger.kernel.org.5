Return-Path: <linux-kernel+bounces-52167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C058494E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73651C218AF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985CB11739;
	Mon,  5 Feb 2024 07:52:07 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2811188
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119527; cv=none; b=kBMUNtRkdTvguXFgIRYhW4jpOQRYB81Wr6xgJ56ZXj4dW6ggGRQpy5W3cGYhFBN/tqib8njw6adVLDKwCkxXqVfJ99kV7gPXjc7TJKYhtB/gR1O2lzcfMsZBJAmnvWH9+HkGDQ5WZj5UTmcJ/W8j1DOqdu+/AwtUUqI1U52A3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119527; c=relaxed/simple;
	bh=mhvQyuJsctI1f+B/SMGnKItaoPt1JLY75GynnViuBks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mDcjzLqfo4oqRwzM3fmOyxgcwvplHT5vnA8tYyINh4LSiTG7dZAIeC8Vn7DXyRK6EFG9WE1J5+sh35jwaSwd/fLWGTO7m1cB/aPa6fs/iIPWvTaWP8nGkPhPJ4JcTx3wZWkaviY/jw/sFwh0g3nRp/aV/JLt4/pAyduCEpdF0SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f919dcbcbb4b43f9abf1b544be7db836-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:d3ad5f33-cdb8-4c57-a427-73bda7883833,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:d3ad5f33-cdb8-4c57-a427-73bda7883833,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:442c2180-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2402051551570XL61VY3,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: f919dcbcbb4b43f9abf1b544be7db836-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1038818982; Mon, 05 Feb 2024 15:51:56 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4A4E1E000EBC;
	Mon,  5 Feb 2024 15:51:56 +0800 (CST)
X-ns-mid: postfix-65C0939C-2060462
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 80BCAE000EBC;
	Mon,  5 Feb 2024 15:51:53 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: dwmw2@infradead.org,
	richard@nod.at
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] jffs2: Simplify the allocation of slab caches
Date: Mon,  5 Feb 2024 15:51:44 +0800
Message-Id: <20240205075144.431567-1-chentao@kylinos.cn>
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
And change cache name from 'jffs2_tmp_dnode' to 'jffs2_tmp_dnode_info'.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/jffs2/malloc.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/fs/jffs2/malloc.c b/fs/jffs2/malloc.c
index ce1189793288..411de8b361b2 100644
--- a/fs/jffs2/malloc.c
+++ b/fs/jffs2/malloc.c
@@ -33,27 +33,19 @@ static struct kmem_cache *xattr_ref_cache;
=20
 int __init jffs2_create_slab_caches(void)
 {
-	full_dnode_slab =3D kmem_cache_create("jffs2_full_dnode",
-					    sizeof(struct jffs2_full_dnode),
-					    0, 0, NULL);
+	full_dnode_slab =3D KMEM_CACHE(jffs2_full_dnode, 0);
 	if (!full_dnode_slab)
 		goto err;
=20
-	raw_dirent_slab =3D kmem_cache_create("jffs2_raw_dirent",
-					    sizeof(struct jffs2_raw_dirent),
-					    0, SLAB_HWCACHE_ALIGN, NULL);
+	raw_dirent_slab =3D KMEM_CACHE(jffs2_raw_dirent, SLAB_HWCACHE_ALIGN);
 	if (!raw_dirent_slab)
 		goto err;
=20
-	raw_inode_slab =3D kmem_cache_create("jffs2_raw_inode",
-					   sizeof(struct jffs2_raw_inode),
-					   0, SLAB_HWCACHE_ALIGN, NULL);
+	raw_inode_slab =3D KMEM_CACHE(jffs2_raw_inode, SLAB_HWCACHE_ALIGN);
 	if (!raw_inode_slab)
 		goto err;
=20
-	tmp_dnode_info_slab =3D kmem_cache_create("jffs2_tmp_dnode",
-						sizeof(struct jffs2_tmp_dnode_info),
-						0, 0, NULL);
+	tmp_dnode_info_slab =3D KMEM_CACHE(jffs2_tmp_dnode_info, 0);
 	if (!tmp_dnode_info_slab)
 		goto err;
=20
@@ -63,28 +55,20 @@ int __init jffs2_create_slab_caches(void)
 	if (!raw_node_ref_slab)
 		goto err;
=20
-	node_frag_slab =3D kmem_cache_create("jffs2_node_frag",
-					   sizeof(struct jffs2_node_frag),
-					   0, 0, NULL);
+	node_frag_slab =3D KMEM_CACHE(jffs2_node_frag, 0);
 	if (!node_frag_slab)
 		goto err;
=20
-	inode_cache_slab =3D kmem_cache_create("jffs2_inode_cache",
-					     sizeof(struct jffs2_inode_cache),
-					     0, 0, NULL);
+	inode_cache_slab =3D KMEM_CACHE(jffs2_inode_cache, 0);
 	if (!inode_cache_slab)
 		goto err;
=20
 #ifdef CONFIG_JFFS2_FS_XATTR
-	xattr_datum_cache =3D kmem_cache_create("jffs2_xattr_datum",
-					     sizeof(struct jffs2_xattr_datum),
-					     0, 0, NULL);
+	xattr_datum_cache =3D KMEM_CACHE(jffs2_xattr_datum, 0);
 	if (!xattr_datum_cache)
 		goto err;
=20
-	xattr_ref_cache =3D kmem_cache_create("jffs2_xattr_ref",
-					   sizeof(struct jffs2_xattr_ref),
-					   0, 0, NULL);
+	xattr_ref_cache =3D KMEM_CACHE(jffs2_xattr_ref, 0);
 	if (!xattr_ref_cache)
 		goto err;
 #endif
--=20
2.39.2


