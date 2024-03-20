Return-Path: <linux-kernel+bounces-108371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED02E8809BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A90D1C22A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310442C69C;
	Wed, 20 Mar 2024 02:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="plBKUuQs"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCE21115;
	Wed, 20 Mar 2024 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902553; cv=none; b=I000KGHWJda1ovmwKbkNQr25v4P3lTe6H0S2v42FjiK3mwnQ7uST3qUZtyjn2pLRUzsUlb4xx2+uTSYwR/2JL9IWjcrQKrEaMrLw/IW1rHKvwHGkk6Xi+zOdpP8tDUh1f2SmjzdQD8Ha2SlHcG0skMBS5GLJCJmv/XLSOd5w9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902553; c=relaxed/simple;
	bh=P9UHnurRuI4a0fUi9+SHR9AWsqgecw1ileqO/sUM9CU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qe+jKNo56ZiKH5/YLILmlzc2fIjdqSBbSuVYvO0FXdmkLRZebbpGLko/4me5hoKBRy/fXR6xGgyAc9VuKR0rO1NmTdBiiViUVeQpZ6hbqqi0b5MT4UZSUSzQEi9q60jXluw9DCOB1jLMLzN6yONaAkCTGZhtXvPQFJbYT6fZFEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=plBKUuQs; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7d77b5cae66311ee935d6952f98a51a9-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BnE7kfT92vOKoVcnW2N3zYJMAiR9CTN4ccK+CcPCmZw=;
	b=plBKUuQsancirY5DYPaXA7kod34UynwkFx3w6Vw6oruAAhG3i4kGRAV61RGqUWzarvzugOQV4LhfsxxFX0k8RuT3YOfCp+eneNDP0bO7Nvf/It5o5tX+kILaH5iazNNkOL0O0rCfp2g4IC1Qy2Nfhc7puz9HWYzViwa8J4n6bPc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:8249dc4e-08b0-42e6-ae6d-56cbae51214f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:71b73385-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7d77b5cae66311ee935d6952f98a51a9-20240320
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1198619598; Wed, 20 Mar 2024 10:42:27 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 10:42:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 10:42:26 +0800
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
Subject: [PATCH v3 13/14] drm/mediatek: Rename files "mtk_drm_gem.c" to "mtk_gem.c"
Date: Wed, 20 Mar 2024 10:42:21 +0800
Message-ID: <20240320024222.14234-14-shawn.sung@mediatek.com>
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
X-TM-AS-Result: No-10--3.443300-8.000000
X-TMASE-MatchedRID: guQIDqgTMXG4pD9RIlWSGjl/LoO+pjoA1cuIRwt/4Mg1LB46LFAAkjN9
	Th6tMxrkLYexjI/F2s4qwQCg7f5qk1m72EsAF82QJO/EsSykoaBUENBIMyKD0Zsoi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNQC5WvFNNLJUWAfXowA4FKhdSc530ShVv8Z9UeJoq2g/Hd5EDFTgTp0ovX
	DoCmPWWnHE6sTAbyyx1Fz3r4piNsz8ty2DxUMQqi3rvfwosfhZdATQdtPksR+3/JiWOe6GXXSWg
	Q2GpXdZhztLVWA1eE9DDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.443300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B94EE9E10BFD11EBCC9EA27B2DDEE6215DFC9EE871641BE5F5BBFC2F08C825972000:8
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Rename files mtk_drm_gem.c to mtk_gem.c.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
---
 drivers/gpu/drm/mediatek/Makefile                     | 2 +-
 drivers/gpu/drm/mediatek/{mtk_drm_gem.c => mtk_gem.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/gpu/drm/mediatek/{mtk_drm_gem.c => mtk_gem.c} (100%)

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index a47fbec7b9ce1..32a2ed6c0cfef 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -11,10 +11,10 @@ mediatek-drm-y := mtk_crtc.o \
 		  mtk_disp_ovl_adaptor.o \
 		  mtk_disp_rdma.o \
 		  mtk_drm_drv.o \
-		  mtk_drm_gem.o \
 		  mtk_dsi.o \
 		  mtk_dpi.o \
 		  mtk_ethdr.o \
+		  mtk_gem.o \
 		  mtk_mdp_rdma.o \
 		  mtk_padding.o \
 		  mtk_plane.o
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_gem.c
similarity index 100%
rename from drivers/gpu/drm/mediatek/mtk_drm_gem.c
rename to drivers/gpu/drm/mediatek/mtk_gem.c
--
2.18.0


