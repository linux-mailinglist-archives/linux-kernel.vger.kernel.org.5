Return-Path: <linux-kernel+bounces-110942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD6988661A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725471F24983
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8174310A13;
	Fri, 22 Mar 2024 05:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QSarjtcU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F98C15
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711085322; cv=none; b=mUF32Hw7vPr2QN5jusFYBw/N1ED/Lbt7frgkCIb1M0QUA5vANKDHX/N3dyOfzhuIhEaHPM6Ddx/JS+yjTKxvxDfbcxQ9b7u+aSsX4u4Icr0UhCvbJyPFT5JBtja63rO6BKBE/wfEGu9+FAiLI5DVB8xwrlz9lHjbiwAOD2NL5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711085322; c=relaxed/simple;
	bh=GHrU1eG/2iFeAWdjK40POqOgi78g0NL6nofD8NwytoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1oyDds7JHE/mW9I+/n5J/JOjHX7xkmualGO1QaR04wvD7Osxhay/fH0Z8ch6iMQUvwq9SG7zVbVOQ7KBIvaDSjNQdRD6515Fgw83BkEWmUqoVWtw2MyHCPDMogVypxhkaH8g+gQhDrcA21Mmt2xwvPIRlsj0rOiC81QtwC/mb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QSarjtcU; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 064e490ee80d11eeb8927bc1f75efef4-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=u08yQkzLQe3nxMe8CbG1scNucD/LAJ38bA0echu1PJ4=;
	b=QSarjtcUsSmGKfr9c9Thn/GKGV6ZilXSQCVRoG0/lnS2gGsHuUbnbkWamermu9iiCRGGdGQpBSXyqvTUf4apA6Xy2L8swi4/ZDOwwgSIg4sDI+uZyafELE0b/Ay78H48SByqXTORcONYNV9Qll3hzrLj4a18qrENDxzQb6GVOUk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b90c486b-9b8a-485b-a63f-df51ded1fae6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:da83b390-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 064e490ee80d11eeb8927bc1f75efef4-20240322
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1166592612; Fri, 22 Mar 2024 13:28:33 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 13:28:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 13:28:32 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>, "Nancy .
 Lin" <nancy.lin@mediatek.com>, Fei Shao <fshao@chromium.org>, Sean Paul
	<sean@poorly.run>, Jason Chen
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Hsiao
 Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v6 11/14] drm/mediatek: Support "None" alpha blending in Mixer
Date: Fri, 22 Mar 2024 13:28:26 +0800
Message-ID: <20240322052829.9893-12-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240322052829.9893-1-shawn.sung@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support "None" blend mode on MediaTek's chips.

Please refer to the description of the commit
"drm/mediatek: Support alpha blending in display driver"
for more information.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ethdr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 4b12ca285e84b..951e3e82a6a1a 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -178,7 +178,8 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 	if (state->base.pixel_blend_mode != DRM_MODE_BLEND_COVERAGE)
 		mix_con |= PREMULTI_SOURCE;
 
-	if (state->base.fb && !state->base.fb->format->has_alpha) {
+	if (state->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE ||
+	    (state->base.fb && !state->base.fb->format->has_alpha)) {
 		/*
 		 * Mixer doesn't support CONST_BLD mode,
 		 * use a trick to make the output equivalent
-- 
2.18.0


