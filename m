Return-Path: <linux-kernel+bounces-10537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7511D81D5DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993F01C209DF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA51C6B0;
	Sat, 23 Dec 2023 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Yet5+wwA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A912E61;
	Sat, 23 Dec 2023 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 39bd22a2a1c111eeba30773df0976c77-20231224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BEGZPCKmt9f9RZDTtTK1eRq//eakvj/ygDCBfP+qoYI=;
	b=Yet5+wwA8Mh1Kho36S6j4RG+yKpLJkqsR6bO6rE9NaLliZ6uAIiEDqtpVrwPY0OfZWcL0tIQmiUeQRs9E5CIgwU92QM0Zl1BC1FUpJTYxS3GwRuPsa3D2XP6lUqS0wh4oeIkEl7KDUTcQ1LKpBA9S79cDeB7l4vu4DKhrYCGUKo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:015373de-adc3-40ae-91a7-a5dc75baed13,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ea711882-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 39bd22a2a1c111eeba30773df0976c77-20231224
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 439329542; Sun, 24 Dec 2023 02:29:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 24 Dec 2023 02:29:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 24 Dec 2023 02:29:34 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<dri-devel@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jeffrey Kardatzke
	<jkardatzke@google.com>
Subject: [PATCH v3 04/11] drm/mediatek: Add secure identify flag and funcution to mtk_drm_plane
Date: Sun, 24 Dec 2023 02:29:25 +0800
Message-ID: <20231223182932.27683-5-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.541000-8.000000
X-TMASE-MatchedRID: iSQL5szRvdEXSulpnju2H0hwlOfYeSqxnhD9A3Sa7pYs/uUAk6xP7PlY
	oV6p/cSxrKWVhE5vxYb2eTMy2w8sjsEQdgi1dcDAupDIC9422Dqt4laWdJbsDH5h6y4KCSJcLvr
	/pFNuezpyO22KmJrJ+iJPRcn/eGjlj2hRzH1UwuAURSScn+QSXt0H8LFZNFG7bkV4e2xSge45kJ
	aAbb5MTbwXMX9JdBgYjV6OQILSHebQcJL3YLa5c2gGZNLBHGNe
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.541000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E43CFCFA5052593E412A28F345EF1BEC9D62B00DC0EB17E969BC919D978529D62000:8
X-MTK: N

Add is_sec flag to identify current mtk_drm_plane is secure.
Add mtk_plane_is_sec_fb() to check current drm_framebuffer is secure.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 19 +++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_plane.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index ddc9355b06d5..d4d515627ca4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -210,6 +210,7 @@ static void mtk_plane_update_new_state(struct drm_plane_state *new_state,
 	mtk_plane_state->pending.height = drm_rect_height(&new_state->dst);
 	mtk_plane_state->pending.rotation = new_state->rotation;
 	mtk_plane_state->pending.color_encoding = new_state->color_encoding;
+	mtk_plane_state->pending.is_secure = mtk_plane_fb_is_secure(fb);
 }
 
 static void mtk_plane_atomic_async_update(struct drm_plane *plane,
@@ -348,3 +349,21 @@ int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 
 	return 0;
 }
+
+bool mtk_plane_fb_is_secure(struct drm_framebuffer *fb)
+{
+	struct drm_gem_object *gem = NULL;
+	struct mtk_drm_gem_obj *mtk_gem = NULL;
+
+	if (!fb)
+		return false;
+
+	gem = fb->obj[0];
+	if (!gem)
+		return false;
+
+	mtk_gem = to_mtk_gem_obj(gem);
+
+	return mtk_gem->secure;
+}
+
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.h b/drivers/gpu/drm/mediatek/mtk_drm_plane.h
index 99aff7da0831..5a330797b5db 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.h
@@ -33,6 +33,7 @@ struct mtk_plane_pending_state {
 	bool				async_dirty;
 	bool				async_config;
 	enum drm_color_encoding		color_encoding;
+	bool				is_secure;
 };
 
 struct mtk_plane_state {
@@ -46,6 +47,7 @@ to_mtk_plane_state(struct drm_plane_state *state)
 	return container_of(state, struct mtk_plane_state, base);
 }
 
+bool mtk_plane_fb_is_secure(struct drm_framebuffer *fb);
 int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		   unsigned long possible_crtcs, enum drm_plane_type type,
 		   unsigned int supported_rotations, const u32 *formats,
-- 
2.18.0


