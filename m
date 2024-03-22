Return-Path: <linux-kernel+bounces-110847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B232D8864C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AEF1C22BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BECB18EB4;
	Fri, 22 Mar 2024 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c5RN5lLJ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4010FA;
	Fri, 22 Mar 2024 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070907; cv=none; b=XbDrugHCPrcalFQd813J0RTAqYonjPkiytK1m+eB3VQOldvDQYvWH5lILt7U8pZbvCw4p/sPtUwipNJCf7c+XMz5zaTQ4tp3XKfc0mS38R95wiIwnnUGDAY9qeKrzBccUHrqTet5CzM3t3gxEYr5AY5nPLfy7RP91W9wn6yZX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070907; c=relaxed/simple;
	bh=mNrIlZ1w638txmfYNEQv3vnA4PyYQHbKqrpubIoGtpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGp48VHugvd6t2iZKV3feA6rwL1Ms8hGwAS0x0qYyKXDQRGeHgaCwy5RaHvnUXiorefYcnoG93XuOS1yroX7COauqNsZ98/fyz1RkOl53QcnYuX/HmFLK8PcSWn17R0+qVS9X+vyA31m9+RrjQFveLG+7Rpj6KyXtqWcjqI2/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c5RN5lLJ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7228bf32e7eb11ee935d6952f98a51a9-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zJt1nKNgrkXP+kAfgyhqIEi0kY1kNO04ElypM0mbftk=;
	b=c5RN5lLJUxVFpWM6+SKgMwTQHH9jpe0iNMDUX7iDlr/13bLHqSf0MluqJ6kj1giOtsNm4jTT5q8rMTJEzmOzBAE5pipZMP6qLQ5ItycjwHrCUprbF/a9P5Ngr8npZ37bQU0JVbYSLhntxUJoUB3cdlB1BfAyUfJNbr3mUWJTxKI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d6198441-7194-4abc-bb01-19f09755c576,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:26a82e00-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7228bf32e7eb11ee935d6952f98a51a9-20240322
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 914423028; Fri, 22 Mar 2024 09:28:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 09:28:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 09:28:10 +0800
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
Subject: [PATCH v4 07/14] drm/mediatek: Rename files "mtk_drm_crtc.c" to "mtk_crtc.c"
Date: Fri, 22 Mar 2024 09:28:01 +0800
Message-ID: <20240322012808.26234-8-shawn.sung@mediatek.com>
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
X-TM-AS-Result: No-10--5.320300-8.000000
X-TMASE-MatchedRID: z+1rZbcYA6y4pD9RIlWSGjl/LoO+pjoA1cuIRwt/4Mg1LB46LFAAkkfp
	kQx2u0KsbDDGr42tgBOb94a9aKYgZT13WcdbGR6Qtw+xHnsmQjN3Bf9JIqsoeMnKcJMuNOWgo8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqtcUMxtgayi+JjGvmfcUwkX199DkWxEQdhs2VJT05J8nL7QD
	4WQBDTOEMMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.320300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DAB789DCCAC938BD7D08F9980D60F1AB6FE6B6A88517F66749143ED778170AA92000:8
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Rename files mtk_drm_crtc.c to mtk_crtc.c and
modify the Makefile accordingly.

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
---
 drivers/gpu/drm/mediatek/Makefile                       | 4 ++--
 drivers/gpu/drm/mediatek/{mtk_drm_crtc.c => mtk_crtc.c} | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/gpu/drm/mediatek/{mtk_drm_crtc.c => mtk_crtc.c} (100%)

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index 5e4436403b8d2..0198b50820d4c 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-mediatek-drm-y := mtk_disp_aal.o \
+mediatek-drm-y := mtk_crtc.o \
+		  mtk_disp_aal.o \
 		  mtk_disp_ccorr.o \
 		  mtk_disp_color.o \
 		  mtk_disp_gamma.o \
@@ -8,7 +9,6 @@ mediatek-drm-y := mtk_disp_aal.o \
 		  mtk_disp_ovl.o \
 		  mtk_disp_ovl_adaptor.o \
 		  mtk_disp_rdma.o \
-		  mtk_drm_crtc.o \
 		  mtk_drm_ddp_comp.o \
 		  mtk_drm_drv.o \
 		  mtk_drm_gem.o \
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
similarity index 100%
rename from drivers/gpu/drm/mediatek/mtk_drm_crtc.c
rename to drivers/gpu/drm/mediatek/mtk_crtc.c
-- 
2.18.0


