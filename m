Return-Path: <linux-kernel+bounces-129125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF21896569
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C27D1C2242B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BAE58ACE;
	Wed,  3 Apr 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JqK+SNTC"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B255E4C;
	Wed,  3 Apr 2024 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128061; cv=none; b=OZfxHWrIU8EQe/Ylt7ZllaAVSSkMUjM2uyvSmadxJxHBIEuscRph9iuuGJI4CGUeuV384xlxIBCzVG9o2xhLfNkJG8HZBkJ/NX6BBGMOEhekhchj4QOQZXFIm3NUTQ5sN2LX6837nCBxAQ4Rk5CrgwNDjg/xKVier41ewAWcFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128061; c=relaxed/simple;
	bh=c7xTobvxNcUoi+22SqLi61QDBjn/V6GU1bryobi7w58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOo8rX7xIRIDASUpwuIm+Phkuka1Uz6QxTdhUC/snDiSrFUWYPHr9s9EGS0+SlPzmvTN9+qC5aOoZETwmmatdR3PRuL5PZH/Pzdx21s5SUcnYIz4Geq46jFHqYjLVL4F9e6HabpvSs8UP+Ez4QTpz5dyTlI/7LFCZpEmRMfx42c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JqK+SNTC; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d92b874af18811eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZryZl/fS6pc78wdeFePflYUHBIKbUg/O9hvHU797WQA=;
	b=JqK+SNTCe+gLRpH4kWbJGmA45yMN5tNhzCWMW+gwY8z76GbFiQszeKlFclynxiuxL7mpPP+1zp3T1iv1stYbi8GrMxySn3GNHc4pToWdyR9GZgku9cb2jqzrEZqBGqoiCdIatI9kgsa1tJJBSLk3pLQOZOfa67aXBWAuXHcuxMk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f4570555-7e4b-494b-a9d9-aa218b93b1eb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:23f74282-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d92b874af18811eeb8927bc1f75efef4-20240403
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1423718062; Wed, 03 Apr 2024 15:07:35 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 15:07:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 15:07:33 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Sumit Semwal
	<sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Jason-JH.Lin <jason-jh.lin@mediatek.com>,
	Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v4 1/9] drm/mediatek/uapi: Add DRM_MTK_GEM_CREATE_ENCRYPTED flag
Date: Wed, 3 Apr 2024 15:07:24 +0800
Message-ID: <20240403070732.22085-2-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240403070732.22085-1-shawn.sung@mediatek.com>
References: <20240403070732.22085-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.654100-8.000000
X-TMASE-MatchedRID: k8Cd32tj8sGXFGyE5q3nYI6MisxJraxHkKAa/khZ3iT3bBqxmjinTUbj
	B8LDWKj2XQfL6gqs5ORuLPg+qB+4FrzGV3ndBhcIG5mg0pzqmX59LQinZ4QefCP/VFuTOXUT3n8
	eBZjGmUzkwjHXXC/4I66NVEWSRWybH0KLWoaLjsDRxtpMgfkOquxoY1VGElyx7qk6/CriHFCXDB
	DaofGNbVFVCdf1vKsB2h1guZKcWd06Bd5qdQ0mGA6codyJ3/ShjofsMjQaxVwyYjbiqIQ3Csykh
	tyXcigD6rVdgBjDT2r1nXJavJVNag==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.654100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DFB5D2C452CDE2450E4298B873C27F88EAE4766363A37B3850650FDF66FEB9B82000:8
X-MTK: N

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

Add DRM_MTK_GEM_CREATE_ENCRYPTED flag to allow user to allocate
a secure buffer to support secure video path feature.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 include/uapi/drm/mediatek_drm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/drm/mediatek_drm.h b/include/uapi/drm/mediatek_drm.h
index b0dea00bacbc4..e9125de3a24ad 100644
--- a/include/uapi/drm/mediatek_drm.h
+++ b/include/uapi/drm/mediatek_drm.h
@@ -54,6 +54,7 @@ struct drm_mtk_gem_map_off {
 
 #define DRM_MTK_GEM_CREATE		0x00
 #define DRM_MTK_GEM_MAP_OFFSET		0x01
+#define DRM_MTK_GEM_CREATE_ENCRYPTED	0x02
 
 #define DRM_IOCTL_MTK_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + \
 		DRM_MTK_GEM_CREATE, struct drm_mtk_gem_create)
-- 
2.18.0


