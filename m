Return-Path: <linux-kernel+bounces-74341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB0B85D2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDFC1F232F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77C93D0B6;
	Wed, 21 Feb 2024 09:01:32 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80BC3C497
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506092; cv=none; b=g4+v9CeHqKrO3cs3AZEMNom12XpQeI/cxTXyr6iwBOvTeLGs3gcjuGgYWdzBpgfQDckRp9v6VliewmK4k0w3rv3IwqDUdqM2pvo41ABLP8kSJcOcBH8EDb06bZr56qnlCmfmg0drwj+FUhiAzpNgtxJHBLzLEOzt0DoTxhgpMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506092; c=relaxed/simple;
	bh=1S4AsCBkhTEWibR9crMuAzFv0ZZTi4TJLhXgEEgbKq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbF/LAAETd11e6Y2RUu1ooPexI94XZ3UbkQRpSG3a+xS9jKVhZ831OsgCz6tidzXeFN6qnI9TQfWF/1Qas7aEH9/822/JF+/dhtde7SFilNND+G566v6PkfA9QxyfA6IoPl4V+ULzTLyqT37qKu8lyw2AauiXCvfd0sh65UXifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0aa368f3530545ed8de1e400171aded9-20240221
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:8dc1fbd6-5e04-4cb7-a59c-c0138488e143,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:8dc1fbd6-5e04-4cb7-a59c-c0138488e143,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:013b8b8f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240221165604J5OQ83PO,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|17|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 0aa368f3530545ed8de1e400171aded9-20240221
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 436310388; Wed, 21 Feb 2024 16:56:02 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 54D8BE000EBC;
	Wed, 21 Feb 2024 16:56:02 +0800 (CST)
X-ns-mid: postfix-65D5BAA2-127793529
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 89F08E000EBC;
	Wed, 21 Feb 2024 16:56:00 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: ltuikov89@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] drm/scheduler: Simplify the allocation of slab caches in drm_sched_fence_slab_init
Date: Wed, 21 Feb 2024 16:55:58 +0800
Message-Id: <20240221085558.166774-1-chentao@kylinos.cn>
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
 drivers/gpu/drm/scheduler/sched_fence.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/sc=
heduler/sched_fence.c
index 06cedfe4b486..0f35f009b9d3 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -33,9 +33,7 @@ static struct kmem_cache *sched_fence_slab;
=20
 static int __init drm_sched_fence_slab_init(void)
 {
-	sched_fence_slab =3D kmem_cache_create(
-		"drm_sched_fence", sizeof(struct drm_sched_fence), 0,
-		SLAB_HWCACHE_ALIGN, NULL);
+	sched_fence_slab =3D KMEM_CACHE(drm_sched_fence, SLAB_HWCACHE_ALIGN);
 	if (!sched_fence_slab)
 		return -ENOMEM;
=20
--=20
2.39.2


