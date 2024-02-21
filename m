Return-Path: <linux-kernel+bounces-74494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C74185D51D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC511C23236
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC20A3F9D3;
	Wed, 21 Feb 2024 10:00:39 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C63D54C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509639; cv=none; b=KnD2+vzT6wNHnZsAdb8QAmHqTOspaT2JwsZNH3IOS+FpzQ3pjA7ZF8CTR0KJfUSqWljmFMre26qI3MsIYsEAeDTmC2iNDsafPCAzitcUDmn8exbXYUIH2Pd0rQBMvfoCJ88b/IdTbv3H2KFXOyCUpthfJ0UAOGMzkO1cjVs1fq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509639; c=relaxed/simple;
	bh=MGZaqLmMzO6wbM7prH14xhw2vpbo3yMc/zyQLmT9EFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HAzRDjxY55KyLwbP7i0/b5YHjjfVMSP7qiNmRhwK8jfKR4tegEtfXkFm/MUleQJFiRCwxLe3BHmVwOmoHkAkDyqy4xPCxbTNEVsetxGc701IfePePL11S/OlOIzNHiOv6Fo3t3Y4y3SJiLUxZkKndjEyWxO8qEk3VQXTxn/PWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 02cc5fc8cccf4f98ab5783f712d703ca-20240221
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:623a14fd-5008-4c40-89be-891b8c45b351,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:623a14fd-5008-4c40-89be-891b8c45b351,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:deed8b8f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2402211800264WKWF8CQ,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 02cc5fc8cccf4f98ab5783f712d703ca-20240221
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 156901990; Wed, 21 Feb 2024 18:00:23 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 9FE0CE000EBC;
	Wed, 21 Feb 2024 18:00:23 +0800 (CST)
X-ns-mid: postfix-65D5C9B7-383174114
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id D4F04E000EBD;
	Wed, 21 Feb 2024 18:00:22 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 3/3] drm/amdgpu: Simplify the allocation of sync slab caches
Date: Wed, 21 Feb 2024 17:59:07 +0800
Message-Id: <20240221095907.172408-4-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221095907.172408-1-chentao@kylinos.cn>
References: <20240221095907.172408-1-chentao@kylinos.cn>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sync.c
index 1b013a44ca99..bdf1ef825d89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -441,9 +441,7 @@ void amdgpu_sync_free(struct amdgpu_sync *sync)
  */
 int amdgpu_sync_init(void)
 {
-	amdgpu_sync_slab =3D kmem_cache_create(
-		"amdgpu_sync", sizeof(struct amdgpu_sync_entry), 0,
-		SLAB_HWCACHE_ALIGN, NULL);
+	amdgpu_sync_slab =3D KMEM_CACHE(amdgpu_sync_entry, SLAB_HWCACHE_ALIGN);
 	if (!amdgpu_sync_slab)
 		return -ENOMEM;
=20
--=20
2.39.2


