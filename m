Return-Path: <linux-kernel+bounces-80969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B773A866E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA332862AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2F9605DD;
	Mon, 26 Feb 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sBB6968Q"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60460272;
	Mon, 26 Feb 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937475; cv=none; b=p1OsWPKu5n2SDlad0VlEYAJa38lVOXVuguRREsXijiYyUZyUuUplE+e0M/Vl9CPik98OOELf9lqmrkLdkJuHDIcPToQ/Q9Cd5qLoxIYXJzt564/NCggaTo+9ihvrtBG23F2x7SeNrsnddXeARbHBfTAD35/biS0TG3V7kUmaV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937475; c=relaxed/simple;
	bh=GVF4XiFl/Tzw/2ZxXbG0u87GgcKy1IdXEGyfuHdPSAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmFxgKA+doqEZVnbe/MoGPsqz6fkE7M9ls/V49YojG981StPyHYrTnlLUnGwvjTj5KCT+PfyrObV0WShuAJym865wMKHOb4hwyYDuKWBAH6wviMuEIVL4ezxIlkI0jsr67PQS1jTUNnPLgE2o1JuG9dLaaD/lp1ZCXwSnbGqHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sBB6968Q; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2b79158ed48411eea4ad694c3f9da370-20240226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sM8UoohUbZJxJVpiqBGVNjeWckAhm+PhZjsuoeNGu7o=;
	b=sBB6968QwofIC2QXsVAwjoidDJ/1bXSQ90QHcBABMiAytozRzOo18x2q/8blIx3r5u69NriG71DeaWXd5QEpbY4miu35dkGZXemNxkDdnLSpuM9rfYf8W43vVyz+Qsu8Yd3MSU7R6/nzSGU1dpJpKdMNMqQAeK0QfraYqR/aN1Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:5b8ab37a-39b8-4c04-97e9-3f5fc2f1f7f8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:0656b98f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2b79158ed48411eea4ad694c3f9da370-20240226
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 701259482; Mon, 26 Feb 2024 16:51:02 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Feb 2024 16:51:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 26 Feb 2024 16:51:01 +0800
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
Subject: [PATCH 09/11] drm/mediatek: Rename files "mtk_drm_gem.*" to "mtk_gem.*"
Date: Mon, 26 Feb 2024 16:50:57 +0800
Message-ID: <20240226085059.26850-10-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240226085059.26850-1-shawn.sung@mediatek.com>
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.051000-8.000000
X-TMASE-MatchedRID: 9IrrHbNZyfo/5uXNh96gfjl/LoO+pjoA1cuIRwt/4Mg1LB46LFAAkhW2
	f9kZkU+12g2rjVADxc1g62EFNWAoiEzhWNnvpqvYCXpcUYyUeeT0O7M3lSnTW5soi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNX5GLVEFfGYWpXt1SGGa7UIiuivvBlcpmLpp2HrpqRleFLHeAx8rfY3Avp
	LE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.051000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E7AAB4CDEF13AE55F6A37D367F5B852F515EEFA2A8D556483FF71CAB49A1E1B42000:8
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Rename files mtk_drm_gem.* to mtk_gem.*.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
---
 drivers/gpu/drm/mediatek/Makefile                     | 2 +-
 drivers/gpu/drm/mediatek/mtk_crtc.c                   | 2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                | 2 +-
 drivers/gpu/drm/mediatek/{mtk_drm_gem.c => mtk_gem.c} | 2 +-
 drivers/gpu/drm/mediatek/{mtk_drm_gem.h => mtk_gem.h} | 0
 drivers/gpu/drm/mediatek/mtk_plane.c                  | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/gpu/drm/mediatek/{mtk_drm_gem.c => mtk_gem.c} (99%)
 rename drivers/gpu/drm/mediatek/{mtk_drm_gem.h => mtk_gem.h} (100%)

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index 0e198c00c6f2..7e6d4b2fadbf 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -11,7 +11,7 @@ mediatek-drm-y := mtk_disp_aal.o \
 		  mtk_crtc.o \
 		  mtk_ddp_comp.o \
 		  mtk_drm_drv.o \
-		  mtk_drm_gem.o \
+		  mtk_gem.o \
 		  mtk_plane.o \
 		  mtk_dsi.o \
 		  mtk_dpi.o \
diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 96af194d0d49..7fe234de83a3 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -22,7 +22,7 @@
 #include "mtk_drm_drv.h"
 #include "mtk_crtc.h"
 #include "mtk_ddp_comp.h"
-#include "mtk_drm_gem.h"
+#include "mtk_gem.h"
 #include "mtk_plane.h"
 
 /*
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 113fdbaac5a1..b62320f64882 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -27,7 +27,7 @@
 #include "mtk_crtc.h"
 #include "mtk_ddp_comp.h"
 #include "mtk_drm_drv.h"
-#include "mtk_drm_gem.h"
+#include "mtk_gem.h"
 
 #define DRIVER_NAME "mediatek"
 #define DRIVER_DESC "Mediatek SoC DRM"
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_gem.c
similarity index 99%
rename from drivers/gpu/drm/mediatek/mtk_drm_gem.c
rename to drivers/gpu/drm/mediatek/mtk_gem.c
index 3ae1f12bfb46..0fd55117ebf7 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_gem.c
@@ -12,7 +12,7 @@
 #include <drm/drm_prime.h>
 
 #include "mtk_drm_drv.h"
-#include "mtk_drm_gem.h"
+#include "mtk_gem.h"
 
 static int mtk_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.h b/drivers/gpu/drm/mediatek/mtk_gem.h
similarity index 100%
rename from drivers/gpu/drm/mediatek/mtk_drm_gem.h
rename to drivers/gpu/drm/mediatek/mtk_gem.h
diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
index 95a4328a9b0b..4625deb21d40 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.c
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


