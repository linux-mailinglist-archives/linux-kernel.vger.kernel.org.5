Return-Path: <linux-kernel+bounces-74344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B623F85D302
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563D01F219DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B04A3C6AB;
	Wed, 21 Feb 2024 09:04:22 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEE938F94
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506261; cv=none; b=lVNoW3J3usMFAxILpDRD2QnJm/wyvBgtmN2r2xOe4RxF5myjCE3qvPivmcgSbOKRysVqccVNTq6GSV/w6OmGyPRuxN4GHnPYfn/EAo3xiUuqmascW2g6vpxFUYyftbgf9Cq/qTTgKnk4zci2oCaF3If/M/xITIANP4z2H0GUdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506261; c=relaxed/simple;
	bh=yZVRv3Jj7/PoGR/VDrzkaaZCMf6fkPUEJZm99tu5WIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jM/BDUT8yGLOonpmotiRWSeOm4XyUXoPogYbNpXh7vE9XiXrTGBFf1nD6x9UrouO7m5HVWGyWZhgPNH4hpcPyTLhl1LT1+WbjI7i7JvuVMbKf7dvYkxQ2AlgKbrFVL4nOah6nMT8xLpxACunK4c01JN8u+ydPd+IhWQo1DJtqf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e055a30fdd404a3482e5e0535a320678-20240221
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:19c1cea5-6803-4bd9-a913-92849b05674b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:19c1cea5-6803-4bd9-a913-92849b05674b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:af722484-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2402211704136R5RNTJ7,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: e055a30fdd404a3482e5e0535a320678-20240221
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1046188438; Wed, 21 Feb 2024 17:04:12 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 64F1FE000EBC;
	Wed, 21 Feb 2024 17:04:12 +0800 (CST)
X-ns-mid: postfix-65D5BC8C-208931588
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id C8665E000EBC;
	Wed, 21 Feb 2024 17:04:10 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: yuq825@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] drm/lima: Simplify the allocation of slab caches in lima_sched_slab_init
Date: Wed, 21 Feb 2024 17:04:09 +0800
Message-Id: <20240221090409.167478-1-chentao@kylinos.cn>
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
 drivers/gpu/drm/lima/lima_sched.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
index c3bf8cda8498..265ee6ca3c44 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -27,9 +27,7 @@ static int lima_fence_slab_refcnt;
 int lima_sched_slab_init(void)
 {
 	if (!lima_fence_slab) {
-		lima_fence_slab =3D kmem_cache_create(
-			"lima_fence", sizeof(struct lima_fence), 0,
-			SLAB_HWCACHE_ALIGN, NULL);
+		lima_fence_slab =3D KMEM_CACHE(lima_fence, SLAB_HWCACHE_ALIGN);
 		if (!lima_fence_slab)
 			return -ENOMEM;
 	}
--=20
2.39.2


