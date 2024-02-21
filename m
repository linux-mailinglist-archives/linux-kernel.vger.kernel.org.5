Return-Path: <linux-kernel+bounces-74492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E3585D51B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77541F29537
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3417D3EA7B;
	Wed, 21 Feb 2024 10:00:38 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9493D0DB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509637; cv=none; b=W/j8m8kPbPhRSLWqK/5MOLWJ8WUSryHbX4mT//9Uoe5by9OuriXuttkNul/H4DPos/TgbdL+aldQ+CA/C5gkSL1utCjNzCVU/1KOezV3IoTJOB4QIPwWRSvna1C9YtDBG1sbg9YcUWVJ+r/nbVzJ3MqOcPfEowQ7PD05itpgOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509637; c=relaxed/simple;
	bh=WACsM7dJmS81ncmkq8piKSWMNJkIk8muLxBwnbX9UVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bw9LAeovcS6Ls7Gld5MZ/8N8zijsSW6MwzeQ5WqlHW7KmlUv+GtKxyN6/FACtOBk6u/FyVuFXSxsr8kz4hJCTG2rMC672nl3c+Wn6tZxktNsOezH6nRq3xq8lswgACGGm0EH8R9BasaKy37S/vTsfBkObQ4ZBFy80rpOutRQfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6e9d739c276e4191b279f4b18a21d38c-20240221
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:bb9b2bf2-8df8-4184-8d98-646f3b3f6425,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:bb9b2bf2-8df8-4184-8d98-646f3b3f6425,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:0ef7a480-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240221180024PLCRANR9,BulkQuantity:1,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6e9d739c276e4191b279f4b18a21d38c-20240221
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 583708194; Wed, 21 Feb 2024 18:00:23 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C5E52E000EBC;
	Wed, 21 Feb 2024 18:00:22 +0800 (CST)
X-ns-mid: postfix-65D5C9B6-558034113
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 0BE8DE000EBD;
	Wed, 21 Feb 2024 18:00:21 +0800 (CST)
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
Subject: [PATCH 2/3] drm/amdgpu: Simplify the allocation of mux_chunk slab caches
Date: Wed, 21 Feb 2024 17:59:06 +0800
Message-Id: <20240221095907.172408-3-chentao@kylinos.cn>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring_mux.c
index e1ee1c7117fb..d234b7ccfaaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -159,9 +159,7 @@ int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux,=
 struct amdgpu_ring *ring,
 	mux->ring_entry_size =3D entry_size;
 	mux->s_resubmit =3D false;
=20
-	amdgpu_mux_chunk_slab =3D kmem_cache_create("amdgpu_mux_chunk",
-						  sizeof(struct amdgpu_mux_chunk), 0,
-						  SLAB_HWCACHE_ALIGN, NULL);
+	amdgpu_mux_chunk_slab =3D KMEM_CACHE(amdgpu_mux_chunk, SLAB_HWCACHE_ALI=
GN);
 	if (!amdgpu_mux_chunk_slab) {
 		DRM_ERROR("create amdgpu_mux_chunk cache failed\n");
 		return -ENOMEM;
--=20
2.39.2


