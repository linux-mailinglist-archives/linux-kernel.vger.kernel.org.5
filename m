Return-Path: <linux-kernel+bounces-111191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A50FD8868F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66821C240D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C043D3BC;
	Fri, 22 Mar 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G6VuMXor"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC420B3D;
	Fri, 22 Mar 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098765; cv=none; b=FiC8lyk7b/z0z80EF1LW4hgoo2VlZePlRnL3AGkuFrsMPG6osGU7xyiDJoVD9mqgh4iGAiBF8dxN7msD+rCQWdnLpDiNLkpxNm6Nt8/P4IIb3XJwZrlziQk+FCX0qJUrunqXJhKinQXIIAg0qq6Lg4tMZzapJGgCEgeVnU3ua1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098765; c=relaxed/simple;
	bh=cOmpPG/8ARnymfPCcuDFoTNXuXoPbNNtt5jS/D26kAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyA/d5nPxkGUG+vyNy5b0607bFShyYouhFD4n6XpDeikzoSQi/6VFPY0jJTvzLPl1T11NIN7WBmZ1Vmj9i/92Eczc+JAwuNE4c54sLsB75Pim4vCYw4RogOKdiDaEMxy+eiuY4VB/CvIGBaKYeIu/Dz1PmfFOQsomOQufGan+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=G6VuMXor; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 524781bce82c11eeb8927bc1f75efef4-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wXqKQKWwyy2kjacofcUps73BI2ErEGxymwzA0r1X5iU=;
	b=G6VuMXorf/gYEBwSxflWrGIazqZndcA1Ee7PeFcJB7/ZsxJYEiRPzp92FfT9Nhp2/wGEvLa0Pe+aAL2KYlgRNLXxihKjSjg3ffZ9oWRGJyItNR+tlGt14tfd0k78uNKLQ8FctFahW+fpiZxysSaw24xDABi5vgH+S7ZZbYCi0q4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:8d6bbe73-a5df-476a-b5db-bda968e707eb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:111bcf81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 524781bce82c11eeb8927bc1f75efef4-20240322
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 401848834; Fri, 22 Mar 2024 17:12:35 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 17:12:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 17:12:33 +0800
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
Subject: [PATCH v5 03/14] drm/mediatek: Rename "mtk_drm_plane" to "mtk_plane"
Date: Fri, 22 Mar 2024 17:12:21 +0800
Message-ID: <20240322091232.26387-4-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240322091232.26387-1-shawn.sung@mediatek.com>
References: <20240322091232.26387-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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


