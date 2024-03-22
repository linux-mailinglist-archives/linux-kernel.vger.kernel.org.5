Return-Path: <linux-kernel+bounces-110844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 073638864B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343551C22B42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD61B663;
	Fri, 22 Mar 2024 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e5GUsqQ7"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146910E6;
	Fri, 22 Mar 2024 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070906; cv=none; b=eRbYVrr6fwercbBOf1jAKz/G47jgxynw7nqOf/52FndBLtKmlAhKYW65t6Wefc2WXtFeRDfoSMwxgoqc1Fl9EXlHHu0m0MrEfSIntTBQv5/1zreE4eW/lT3jHuyTQ4V63a7MhWhXIj3VJ4qah3v+17d3Utlxb6FNC/cEn5uKwvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070906; c=relaxed/simple;
	bh=VlWxiJ3vDUKL+/ZetJ0cE3M6aup+7v4jx/XSENzFHIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2ES4vX+maDJgCrgJ9C9Kd/QBXf+H9h4PiedlYveY/5+GeVO7408kelIJn9yBmcyTVzV8rWZgMR8WU1K8BEZZ/IX58ajlnUa1IeW77Ud3DvpNa/LZurrDGVLnflkGmuNpkm7P7cJ9nK/c+2wA8q2nyLm4Rob43qrg/jRzol0VZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=e5GUsqQ7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 72852c40e7eb11ee935d6952f98a51a9-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=l0VX1o2w9lMIx3y3m9eqWBGPK8JczIgKfuRSrwX59oU=;
	b=e5GUsqQ7/UqsMTcJIBXwRb688kq6YONoOQEcnVyxl+qYIJeENT+CTgr6gaL/j8yiLJOsu8IrmxZ4tfJX3xffkJC0MCcHb7i/5xedBx+5Da6WASKgE28uDCUr+Vj47aYJOTIaVYIOzCWyCZl/F99xsAGdazuIM3LTuiyXvaAM6Jg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:257fb8d4-aec3-4aec-a652-d251641ca62a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:27d3b090-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 72852c40e7eb11ee935d6952f98a51a9-20240322
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 462425920; Fri, 22 Mar 2024 09:28:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 09:28:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 09:28:11 +0800
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
Subject: [PATCH v4 11/14] drm/mediatek: Rename files "mtk_drm_plane.c" to "mtk_plane.c"
Date: Fri, 22 Mar 2024 09:28:05 +0800
Message-ID: <20240322012808.26234-12-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240322012808.26234-1-shawn.sung@mediatek.com>
References: <20240322012808.26234-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.074200-8.000000
X-TMASE-MatchedRID: 8MuUkBM4K/+4pD9RIlWSGjl/LoO+pjoA1cuIRwt/4Mg1LB46LFAAkkfp
	kQx2u0KsbDDGr42tgBOb94a9aKYgZT13WcdbGR6QA0ncQPC5QKV9LQinZ4QefPcjNeVeWlqY+gt
	Hj7OwNO2ytvz1/F3QBfXwIN8Gv+1EyVHuboC0UkBNgXkNPSVAeyJzi0B58W0MVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.074200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B9726CEF7EC9308CB1359D7EDD3C17343C30A08DABECDA1CCD594BCDDA60108C2000:8
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Rename files mtk_drm_plane.c to mtk_plane.c and
modify the Makefile accordingly.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
---
 drivers/gpu/drm/mediatek/Makefile                         | 4 ++--
 drivers/gpu/drm/mediatek/{mtk_drm_plane.c => mtk_plane.c} | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/gpu/drm/mediatek/{mtk_drm_plane.c => mtk_plane.c} (100%)

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
similarity index 100%
rename from drivers/gpu/drm/mediatek/mtk_drm_plane.c
rename to drivers/gpu/drm/mediatek/mtk_plane.c
-- 
2.18.0


