Return-Path: <linux-kernel+bounces-108375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33EB8809C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403EC1F2528F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479FA39ACB;
	Wed, 20 Mar 2024 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fw0cwBxm"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F029409;
	Wed, 20 Mar 2024 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902555; cv=none; b=ChYFSdjY6fQ622YKDuLOZKrc/5JMtT+WrM/9JKQPHaBxKmoN+B0kT6HfdWmpXnmtm0ZhsxSROMUIxYj5cnZMXOZ73zzhFrNauEHT3uKy6fbi3YIEJ2p1TsCAzm50TeCbtnK57P0Zwi1bALXU2ZhgmfRbTidoPoU76YYhX45hZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902555; c=relaxed/simple;
	bh=gIKsJIk5YbiOhQMsDiru3H/X1kSvuuGDOV24hBV7LG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k53q2gWWGhValakXTQWyebmUsyN6ttRVXYmFX3AKbjvgHHu60oXz0Rik9Rd7X96cJDIeTAc2uG6duscRcTq9bKUe0XJKEdwK7akOlHMwMh4Mt+OhbIwc/jA3pHQCAlskwnfBaPluYqqgtA83rHRyxapo8qhlSmMkh+yEddub0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fw0cwBxm; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7d04d58ce66311ee935d6952f98a51a9-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XKCWVNO/5B3LxPPTIAj8qoriTz/hQl7CWXlq45IQqxQ=;
	b=fw0cwBxm0DT3T+bVhn9ll3ZF8Tpsaax6qwVVpjzJY5NOND9rlmf+m3RsTPA9QehbnsAjokrH9FrTVH69nFwThM3P5I7lD+BMUiJJe63fqDAIeDrLGCL2adOgndUHDyGuLWZPO8QpHmtmVoY2ahqlgzPYMCFDcFZv7aGNnWvXz+0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e7081b81-a8c8-4b20-bc67-74f5255f6f7b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:924e1800-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7d04d58ce66311ee935d6952f98a51a9-20240320
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 431050500; Wed, 20 Mar 2024 10:42:26 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 10:42:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 10:42:25 +0800
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
Subject: [PATCH v3 10/14] drm/mediatek: Rename files "mtk_drm_plane.h" to "mtk_plane.h"
Date: Wed, 20 Mar 2024 10:42:18 +0800
Message-ID: <20240320024222.14234-11-shawn.sung@mediatek.com>
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
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Rename files mtk_drm_plane.h to mtk_plane.h.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c                       | 2 +-
 drivers/gpu/drm/mediatek/mtk_crtc.h                       | 2 +-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c                   | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h                   | 2 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c                  | 2 +-
 drivers/gpu/drm/mediatek/{mtk_drm_plane.h => mtk_plane.h} | 0
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/gpu/drm/mediatek/{mtk_drm_plane.h => mtk_plane.h} (100%)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 7710e539e3da1..1ba47e65a32da 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -23,7 +23,7 @@
 #include "mtk_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_drm_gem.h"
-#include "mtk_drm_plane.h"
+#include "mtk_plane.h"

 /*
  * struct mtk_crtc - MediaTek specific crtc structure.
diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.h b/drivers/gpu/drm/mediatek/mtk_crtc.h
index fd6c006f0c169..388e900b6f4de 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.h
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.h
@@ -9,7 +9,7 @@
 #include <drm/drm_crtc.h>
 #include "mtk_ddp_comp.h"
 #include "mtk_drm_drv.h"
-#include "mtk_drm_plane.h"
+#include "mtk_plane.h"

 #define MTK_MAX_BPC	10
 #define MTK_MIN_BPC	3
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index ab96b1001de3e..c3441508f452f 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -18,7 +18,7 @@
 #include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
 #include "mtk_drm_drv.h"
-#include "mtk_drm_plane.h"
+#include "mtk_plane.h"


 #define DISP_REG_DITHER_EN			0x0000
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 90e64467ea8f8..082ac18fe04aa 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -9,8 +9,8 @@
 #include <linux/soc/mediatek/mtk-cmdq.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
 #include <linux/soc/mediatek/mtk-mutex.h>
-#include "mtk_drm_plane.h"
 #include "mtk_mdp_rdma.h"
+#include "mtk_plane.h"

 int mtk_aal_clk_enable(struct device *dev);
 void mtk_aal_clk_disable(struct device *dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 63a7a24468c13..95a4328a9b0b6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -17,7 +17,7 @@
 #include "mtk_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_drm_gem.h"
-#include "mtk_drm_plane.h"
+#include "mtk_plane.h"

 static const u64 modifiers[] = {
 	DRM_FORMAT_MOD_LINEAR,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.h b/drivers/gpu/drm/mediatek/mtk_plane.h
similarity index 100%
rename from drivers/gpu/drm/mediatek/mtk_drm_plane.h
rename to drivers/gpu/drm/mediatek/mtk_plane.h
--
2.18.0


