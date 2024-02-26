Return-Path: <linux-kernel+bounces-80433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC13866866
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7281F2220E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB811CB8;
	Mon, 26 Feb 2024 02:57:03 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14254EEDE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916222; cv=none; b=UmGRTwcWYVPQ4ozCIChqfyZuGY4ibRzhHelSo+nSGf0awnmrvew7b3S+uzxUYQ9KiqhffzIopMyG+9uUQ4nGFEcZp4JbeANpJfaQvrnDA7TZvq9u4qnA0SyZY1qNewFnjaI3RDHmolCZMUlF3y7UDHoZvIiIXfbRP/RFKnmL59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916222; c=relaxed/simple;
	bh=RkYRKXC8rDGhcHXpOqxOD+2kabTswxu8nRbiz9T3PnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hDnP7/8OUfb5Z34jHcnBbqMyf+ypN2oSUCD9aEqIRREGRo4pYjNTva43lFaVnAiSLc5iib6z8GWi5hSwXhoj4gf0a5mEUsxe1BbwndlpHFF8jsLOdfTX8MLgouWjqxYL7Nn1DLBx+y7l17Xp+NsNMVCqIeyXPAhcyepaVD2WTbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4546ceb75acc42a9b2151b68aacf51a8-20240226
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e41c192e-b886-4454-bc77-1e6bcaeef539,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.37,REQID:e41c192e-b886-4454-bc77-1e6bcaeef539,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6f543d0,CLOUDID:42c032ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:2402261019466BTZH2M6,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 4546ceb75acc42a9b2151b68aacf51a8-20240226
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1034945641; Mon, 26 Feb 2024 10:19:44 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7A78CE000EBC;
	Mon, 26 Feb 2024 10:19:44 +0800 (CST)
X-ns-mid: postfix-65DBF540-285856213
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 43257E000EBC;
	Mon, 26 Feb 2024 10:19:41 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: lucas.demarchi@intel.com,
	ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] drm/xe: use KMEM_CACHE() to create xe_hw_fence cache
Date: Mon, 26 Feb 2024 10:19:12 +0800
Message-Id: <20240226021912.1779715-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the KMEM_CACHE() macro instead of kmem_cache_create() to simplify
the creation of SLAB caches when the default values are used.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/gpu/drm/xe/xe_hw_fence.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_=
fence.c
index a6094c81f2ad..cd258e0ccdf3 100644
--- a/drivers/gpu/drm/xe/xe_hw_fence.c
+++ b/drivers/gpu/drm/xe/xe_hw_fence.c
@@ -20,9 +20,7 @@ static struct kmem_cache *xe_hw_fence_slab;
=20
 int __init xe_hw_fence_module_init(void)
 {
-	xe_hw_fence_slab =3D kmem_cache_create("xe_hw_fence",
-					     sizeof(struct xe_hw_fence), 0,
-					     SLAB_HWCACHE_ALIGN, NULL);
+	xe_hw_fence_slab =3D KMEM_CACHE(xe_hw_fence, SLAB_HWCACHE_ALIGN);
 	if (!xe_hw_fence_slab)
 		return -ENOMEM;
=20
--=20
2.39.2


