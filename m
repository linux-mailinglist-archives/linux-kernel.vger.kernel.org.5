Return-Path: <linux-kernel+bounces-107143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DB387F81E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC3A1F22072
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6657E576;
	Tue, 19 Mar 2024 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pUVvTXA/"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70038537E6;
	Tue, 19 Mar 2024 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831795; cv=none; b=URHV8gBy5S8T87eQowK2QNK7I8U8HIUP0dVjIXI4XxlGPYURaEUl9dnKDCVPy5SI5pmevF46FIE/RD9CEd5y/ruMhZsmEjWN8QOI+XtaC0fHglsSBs37Smd5mSxqYEoxCPMtqtZ9bkY4aGHj5s9n47J1lX3S/H0lOlF281CCOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831795; c=relaxed/simple;
	bh=+5DmOxBUqOPjSleuLbqBySwYmDRSnfog9b+cKxDok8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UusobP5Oo0A9XJ1kyGggM4XbfRMOCQ8n96IcG9mtlFUT0U0jxxoVhaGiQd6L1Os1k7F7wYcJ+u7e1Rdp0e0f0N7WF7DJzYji6f0wZUJWHdQqnJtGemB9yJ1zLHwaQzd2yfaO8cp6Q+1U7Cisxd6iqFQtxBvnzFoW+clCa6N+yfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pUVvTXA/; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b8e7311ce5be11ee935d6952f98a51a9-20240319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Cj7ytnNIJI8uiZd0qfP4Jzaf+xdK5mfmZC7zoeIdEbQ=;
	b=pUVvTXA/SUg91X73lNhJKByGrZy+0D9fg2979WeK6Jb/Cm0a3rK28ieFWNZ4jn6a5OkLnKWO4aqbvve0PY3X3lPRBrSEewXLZf3Fvj6gXilHjr1LoFP/O7fFr8U2A7kDEcm1ztJeKr0LEATJhFhXo0soJg9D69NPd2rY8nAgrWA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b46f7db8-5604-46b4-9caa-1d39ae16384a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6f543d0,CLOUDID:74b49190-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b8e7311ce5be11ee935d6952f98a51a9-20240319
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2085823006; Tue, 19 Mar 2024 15:03:00 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Mar 2024 15:03:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Mar 2024 15:03:00 +0800
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
Subject: [PATCH v2 08/14] drm/mediatek: Rename files "mtk_drm_ddp_comp.h" to "mtk_ddp_comp.h"
Date: Tue, 19 Mar 2024 15:02:51 +0800
Message-ID: <20240319070257.6443-9-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240319070257.6443-1-shawn.sung@mediatek.com>
References: <20240319070257.6443-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Rename files mtk_drm_ddp_comp.h to mtk_ddp_comp.h.

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c                             | 2 +-
 drivers/gpu/drm/mediatek/mtk_crtc.h                             | 2 +-
 drivers/gpu/drm/mediatek/{mtk_drm_ddp_comp.h => mtk_ddp_comp.h} | 0
 drivers/gpu/drm/mediatek/mtk_disp_aal.c                         | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c                       | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_color.c                       | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c                       | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_merge.c                       | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c                         | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c                 | 2 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c                        | 2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                              | 2 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c                     | 2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                          | 2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h                          | 2 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c                        | 2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                              | 2 +-
 drivers/gpu/drm/mediatek/mtk_ethdr.c                            | 2 +-
 drivers/gpu/drm/mediatek/mtk_padding.c                          | 2 +-
 19 files changed, 18 insertions(+), 18 deletions(-)
 rename drivers/gpu/drm/mediatek/{mtk_drm_ddp_comp.h => mtk_ddp_comp.h} (100%)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 631c1ef2847ef..7710e539e3da1 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -20,8 +20,8 @@
 #include <drm/drm_vblank.h>
 
 #include "mtk_crtc.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_drm_drv.h"
-#include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_gem.h"
 #include "mtk_drm_plane.h"
 
diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.h b/drivers/gpu/drm/mediatek/mtk_crtc.h
index 2d9f28f436aea..fd6c006f0c169 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.h
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.h
@@ -7,7 +7,7 @@
 #define MTK_CRTC_H
 
 #include <drm/drm_crtc.h>
-#include "mtk_drm_ddp_comp.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_drm_plane.h"
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
similarity index 100%
rename from drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
rename to drivers/gpu/drm/mediatek/mtk_ddp_comp.h
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index ba926e797af8a..92acdaddd648d 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -12,8 +12,8 @@
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
 #include "mtk_crtc.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
-#include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 
 #define DISP_AAL_EN				0x0000
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 79bcd3c487563..975ee45a0f72c 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -11,8 +11,8 @@
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
 #include "mtk_crtc.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
-#include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 
 #define DISP_CCORR_EN				0x0000
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index 4aa41b1ff2602..91e7837a32c86 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -11,8 +11,8 @@
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
 #include "mtk_crtc.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
-#include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 
 #define DISP_COLOR_CFG_MAIN			0x0400
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 1a1ee77127ee9..51ae4f947c714 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -12,8 +12,8 @@
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
 #include "mtk_crtc.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
-#include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 
 #define DISP_GAMMA_EN				0x0000
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
index 32a29924bd54c..3b1e04ecb9d45 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
@@ -10,7 +10,7 @@
 #include <linux/reset.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
-#include "mtk_drm_ddp_comp.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_disp_drv.h"
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 7f2219c0119be..0ebeaf9830d83 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -16,8 +16,8 @@
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
 #include "mtk_crtc.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
-#include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 
 #define DISP_REG_OVL_INTEN			0x0004
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 542dc2a20ea90..d957f5c8ccf92 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -18,8 +18,8 @@
 #include <linux/soc/mediatek/mtk-mutex.h>
 
 #include "mtk_crtc.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
-#include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_ethdr.h"
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 04f584372214f..f06b048c12479 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -14,8 +14,8 @@
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
 #include "mtk_crtc.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
-#include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 
 #define DISP_REG_RDMA_INT_ENABLE		0x0000
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index beb7d9d08e971..fbf63e0441337 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -26,9 +26,9 @@
 #include <drm/drm_of.h>
 #include <drm/drm_simple_kms_helper.h>
 
+#include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
 #include "mtk_dpi_regs.h"
-#include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 
 enum mtk_dpi_out_bit_num {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 24389c6c3561f..ab96b1001de3e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -15,10 +15,10 @@
 #include <drm/drm_print.h>
 
 #include "mtk_crtc.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
 #include "mtk_drm_drv.h"
 #include "mtk_drm_plane.h"
-#include "mtk_drm_ddp_comp.h"
 
 
 #define DISP_REG_DITHER_EN			0x0000
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 7be3b0546d3df..113fdbaac5a14 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -25,7 +25,7 @@
 #include <drm/drm_vblank.h>
 
 #include "mtk_crtc.h"
-#include "mtk_drm_ddp_comp.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_drm_gem.h"
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 24c4d59085bd6..78d698ede1bf8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -7,7 +7,7 @@
 #define MTK_DRM_DRV_H
 
 #include <linux/io.h>
-#include "mtk_drm_ddp_comp.h"
+#include "mtk_ddp_comp.h"
 
 #define MAX_CONNECTOR	2
 #define DDP_COMPONENT_DRM_OVL_ADAPTOR (DDP_COMPONENT_ID_MAX + 1)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 720f6b4b08215..63a7a24468c13 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -14,7 +14,7 @@
 #include <linux/align.h>
 
 #include "mtk_crtc.h"
-#include "mtk_drm_ddp_comp.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_drm_gem.h"
 #include "mtk_drm_plane.h"
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index ec9d96396d7b2..e29c37fb5be09 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -28,8 +28,8 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 
+#include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
-#include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 
 #define DSI_START		0x00
diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 41efaafe26f1a..9b0264bd5e731 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -15,7 +15,7 @@
 #include <linux/soc/mediatek/mtk-mmsys.h>
 
 #include "mtk_crtc.h"
-#include "mtk_drm_ddp_comp.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_ethdr.h"
 
diff --git a/drivers/gpu/drm/mediatek/mtk_padding.c b/drivers/gpu/drm/mediatek/mtk_padding.c
index ff6a5c695128c..1f91805cd9aac 100644
--- a/drivers/gpu/drm/mediatek/mtk_padding.c
+++ b/drivers/gpu/drm/mediatek/mtk_padding.c
@@ -12,8 +12,8 @@
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
 #include "mtk_crtc.h"
+#include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
-#include "mtk_drm_ddp_comp.h"
 
 #define PADDING_CONTROL_REG	0x00
 #define PADDING_BYPASS			BIT(0)
-- 
2.18.0


