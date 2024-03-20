Return-Path: <linux-kernel+bounces-108386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814138809DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367C31F239D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D556446DD;
	Wed, 20 Mar 2024 02:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d1sQfnL3"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72E3D986;
	Wed, 20 Mar 2024 02:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902560; cv=none; b=cwVb47JaTPN+I2+0/pPCE/s+ta8pQHMgLq5VNQIkTwditWZEstf+giWrYjD+n4/hlOhOL876beXt+fJNe41CziVIbpt+9f6OM3GeFyePAhzheXWO+7dbssb1J20Y+IbzaDOvUaDXBE078U8euHQgD8vE4eGKyQ57CMYakDtG7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902560; c=relaxed/simple;
	bh=iSVzjI2zZtv61XTWvLKKakHoiISyfI+CfKn+hbqld08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBDNeBmPU/k6Ufn0O4/56K1SZQk3dCr3IORbD4VNbp21APRo2hjFNYMpJKMcUxnUMNX9Q8ik5hcfuKhGI1SiGOEFcHBSNU/SmT5YkQ8OSb4h1g738Qk02HRimWU9qaT+XJfDrTruPF04BQOgz0Nx6qBjwuEKSIGojuFr+rW6fTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=d1sQfnL3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7dd60562e66311eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wXqKQKWwyy2kjacofcUps73BI2ErEGxymwzA0r1X5iU=;
	b=d1sQfnL363sboFCM/dJAfcNMMBQiJwkSQUiH9Dmyy+vUVzNc9OOLQDgJy2lnUBVciA+dNT1pB5GkSzUHC/WFJe0FKy8Tic84W5Eu0qZ+/zynrkZSyG/0AFMivv7cy0IZSqHG3oCfpwPaxeJNtHJUAglIWir/uuNg3OthoNXqunM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2d9de47a-25c8-4ce4-a92e-a8a38d1e8a25,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:b357b381-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7dd60562e66311eeb8927bc1f75efef4-20240320
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1715453990; Wed, 20 Mar 2024 10:42:28 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 10:42:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 10:42:24 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Hsiao Chien Sung
	<shawn.sung@mediatek.corp-partner.google.com>
Subject: [PATCH v3 03/14] drm/mediatek: Rename "mtk_drm_plane" to "mtk_plane"
Date: Wed, 20 Mar 2024 10:42:11 +0800
Message-ID: <20240320024222.14234-4-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240320024222.14234-1-shawn.sung@mediatek.com>
References: <20240320024222.14234-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.098600-8.000000
X-TMASE-MatchedRID: LAlCrEnopVW4pD9RIlWSGjl/LoO+pjoA1cuIRwt/4Miaecho1pk4scbK
	+pu0ZYwRgaTV+OEAOBbnftxNodBrx9m0JHSAKf2wH5YQyOg71ZZMkOX0UoduuQqiCYa6w8tvVRr
	UWxu78PgR4d+Uvhl0qrBFBlMmSjdIVJTV35UngiOeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8hxKp
	vEGAbTDkmgskU2xwom4nUm8qVokM2hiFLwKQlGCIxlvtHYclZPhgsyKqHa9s6hS4Ju+36N5F4Zh
	O8kc3BOmV3Z7fspagIApVyBqy6GI3mVKZusLp922v9OjYWA2uMMswg45VMfPXY3pGDmoik6
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.098600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	15B449854A97EF4927720C28AC02289C86819065F1ED7D9426FE460E97B22C0E2000:8
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Rename all "mtk_drm_plane" to "mtk_plane":
- To align the naming rule
- To reduce the code size

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 6 +++---
 drivers/gpu/drm/mediatek/mtk_drm_plane.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index cbdb70677d305..43137c46fc148 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -93,8 +93,8 @@ static bool mtk_plane_format_mod_supported(struct drm_plane *plane,
 	return true;
 }

-static void mtk_drm_plane_destroy_state(struct drm_plane *plane,
-					struct drm_plane_state *state)
+static void mtk_plane_destroy_state(struct drm_plane *plane,
+				    struct drm_plane_state *state)
 {
 	__drm_atomic_helper_plane_destroy_state(state);
 	kfree(to_mtk_plane_state(state));
@@ -241,7 +241,7 @@ static const struct drm_plane_funcs mtk_plane_funcs = {
 	.destroy = drm_plane_cleanup,
 	.reset = mtk_plane_reset,
 	.atomic_duplicate_state = mtk_plane_duplicate_state,
-	.atomic_destroy_state = mtk_drm_plane_destroy_state,
+	.atomic_destroy_state = mtk_plane_destroy_state,
 	.format_mod_supported = mtk_plane_format_mod_supported,
 };

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.h b/drivers/gpu/drm/mediatek/mtk_drm_plane.h
index 99aff7da0831d..231bb7aac9473 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.h
@@ -4,8 +4,8 @@
  * Author: CK Hu <ck.hu@mediatek.com>
  */

-#ifndef _MTK_DRM_PLANE_H_
-#define _MTK_DRM_PLANE_H_
+#ifndef _MTK_PLANE_H_
+#define _MTK_PLANE_H_

 #include <drm/drm_crtc.h>
 #include <linux/types.h>
--
2.18.0


