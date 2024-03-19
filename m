Return-Path: <linux-kernel+bounces-107144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28D987F81F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8655B1F221CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031847E59F;
	Tue, 19 Mar 2024 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b43RzMG/"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513005465C;
	Tue, 19 Mar 2024 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831796; cv=none; b=BGHzQhjtNfHMGcGTaN4NWuyj2JD7bWFeM5H6pSpca5vDtw/kXK91CEvvkxD8shHitBUjEBOCvOsTuZ9nYeSrZ9Hw6xDNR98TtCF+pO4PiceY8kaz2Z2sqir6f0XxeqGYH0Pw9KO884e9PrRcuYyd3heEatKSC9bUL4Aa5zoh2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831796; c=relaxed/simple;
	bh=Va0WMTQGlCFSHqc94yI3mzyXy7jWRyDa+gYI1jGFvWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2ohmmPAZJ3RakrnRUAz+7gbHMQGtFSo5YDPH7dkt4Vb7XOG7cdiH4hV2KnNOuw1+swElxjMR6sOAvMr5747pfbMLc+abvT1T9cHxahtGLt84ewvaYOeO27LC9FktdBTqQEj5i03pN4k6K7PY+1/paCK/8IyZnXRHty0fu1Fch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=b43RzMG/; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b96990dae5be11ee935d6952f98a51a9-20240319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4QFCQcKgColevbSb+qogs2cN+XhmY4yT0db/AAfjr4Q=;
	b=b43RzMG/lRKw7R0kAFWS6IHr13ttjZgOwduGUUdQBsFrx0mCv1TwfUc2DNdYJ1z8qb9kbO7UQAhjrqAbgGYBXGpy4aq60gratrTTn6f4FJQneUl8ovMDkkQbenXJuCZarrWBWjEpvVKNhgPVFAvJA2PbuLLekz1o66N2wyxm+po=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:251d1c9a-1099-4e11-8ad3-92a7c3bbe57a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ed850f00-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b96990dae5be11ee935d6952f98a51a9-20240319
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2104871838; Tue, 19 Mar 2024 15:03:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
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
Subject: [PATCH v2 11/14] drm/mediatek: Rename files "mtk_drm_plane.c" to "mtk_plane.c"
Date: Tue, 19 Mar 2024 15:02:54 +0800
Message-ID: <20240319070257.6443-12-shawn.sung@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.145600-8.000000
X-TMASE-MatchedRID: pxZ747jJzGC4pD9RIlWSGjl/LoO+pjoA1cuIRwt/4MiSYqzYmxOFIvKC
	81FnsF5I+22OskOP/1/M4DgYt2okipH0YXYnbGozFEUknJ/kEl7dB/CxWTRRu4as+d5/8j56uJM
	m6seGO7WxT/4fpUXCiHV3a4sG484pfGlvIDTgud/f0+PZHSsrPg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.145600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	47EE3DFAA1D14EB5E562DE1EFC945EBDE599355E1B13DC44606942FAA5F7F0742000:8
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Rename files mtk_drm_plane.c to mtk_plane.c and
modify the Makefile accordingly.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
---
 drivers/gpu/drm/mediatek/Makefile                         | 4 ++--
 drivers/gpu/drm/mediatek/{mtk_drm_plane.c => mtk_plane.c} | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/gpu/drm/mediatek/{mtk_drm_plane.c => mtk_plane.c} (99%)

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index bdb71738e1f31..a47fbec7b9ce1 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -12,12 +12,12 @@ mediatek-drm-y := mtk_crtc.o \
 		  mtk_disp_rdma.o \
 		  mtk_drm_drv.o \
 		  mtk_drm_gem.o \
-		  mtk_drm_plane.o \
 		  mtk_dsi.o \
 		  mtk_dpi.o \
 		  mtk_ethdr.o \
 		  mtk_mdp_rdma.o \
-		  mtk_padding.o
+		  mtk_padding.o \
+		  mtk_plane.o
 
 obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
similarity index 99%
rename from drivers/gpu/drm/mediatek/mtk_drm_plane.c
rename to drivers/gpu/drm/mediatek/mtk_plane.c
index 95a4328a9b0b6..4625deb21d406 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_plane.c
@@ -16,7 +16,7 @@
 #include "mtk_crtc.h"
 #include "mtk_ddp_comp.h"
 #include "mtk_drm_drv.h"
-#include "mtk_drm_gem.h"
+#include "mtk_gem.h"
 #include "mtk_plane.h"
 
 static const u64 modifiers[] = {
-- 
2.18.0


