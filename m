Return-Path: <linux-kernel+bounces-139907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C58A0907
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4A9283462
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B9813DDAF;
	Thu, 11 Apr 2024 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EEPm3p+G"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578063D;
	Thu, 11 Apr 2024 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818900; cv=none; b=ABAKMR1inBTO+5UZmEw+B1ww355Fhi6OSv1aOdC/CWoO4jlvhpBT/JQg7rSA6PT0p98vC8OXqO2ZSKlSBrSkmBdbaRZsnx8+ixVfpC+Ip1V8ujkO6oaZAKMv+a2IKKY3EYawVCkyXuTqypCza+yNa9qRAOscTSx2/Two2l0PBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818900; c=relaxed/simple;
	bh=wgvzpYyL+OriZ2Xf642IWK7zWdae/hliyCromzcK2qA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DWcoLhFzXsq+vCY1zwNEh0iwVUqvZP3/26hhv/paUEStXd+eWrC/S0Vzj4MTPshT3FVPgznzKFpQuKNPjKoMiBZWSBgBje5jmwLj6HWWJ0EsA2NVCHlH7vpK5gGgQVFyHowq8iRhOmRCQm2esOeDdTd8KOE1IPfa5KTWXXQdkYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EEPm3p+G; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5340a76af7d111eeb8927bc1f75efef4-20240411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/c1yvJRz8JdPTs1cqIeERB/b/xbXAhULQ4RA+mlvIg8=;
	b=EEPm3p+GF1lB66eZ6jbesRWIIG9RPKeVSgkGynAJK8jzSot7PuT5r+AUFTNpWFDRs5hgXhG5O1jPdsEqkNR0d8Y7dbUWuv6wM1KwJELswwdKRVY08Z0M2/9soyTxwJAa/xMk5VFNXTN1MLEgMmfaX9qL82kl7m7QO+E7Tug1F5Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:321bcacf-41af-40f0-9752-b9ab2dc3527d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:952b7391-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 5340a76af7d111eeb8927bc1f75efef4-20240411
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 404108306; Thu, 11 Apr 2024 15:01:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 Apr 2024 15:01:29 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 11 Apr 2024 15:01:28 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, "Yunfei
 Dong" <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3] media: mediatek: vcodec: support 36 bits physical address
Date: Thu, 11 Apr 2024 15:01:27 +0800
Message-ID: <20240411070127.12384-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.258800-8.000000
X-TMASE-MatchedRID: 3Zp7/B+3+xCHTNZBcJlnyHQIOMndeKgE6SXuwUgGH0gjEnikYkL+CP44
	pYPD16CLlTJXKqh1ne29cOdjc/43lb/eELA70ejcxPkB0MIBaXGH7D1bP/FcOkPL6pqegFS6y+l
	ts/rkGMs6hUOcTonr9IAy6p60ZV62fJ5/bZ6npdg7AFczfjr/7BBaNQP2ElZ7sBTQNe6q9JnbyF
	/5J/yVwHQbcUv25Bn5i9UugmfH/Nc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.258800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2D4870850A06C752B984B2AFA27145AEA4011B1059274BBEA02A26AFBEEA89602000:8
X-MTK: N

The physical address on the MT8188 platform is larger than 32 bits,
change the type from unsigned int to dma_addr_t to be able to access
the high bits of the address.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
compared with v2:
- remove unless cast
---
 .../media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c | 2 +-
 .../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
index 9649f4ec1f2a..5f848691cea4 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
@@ -449,7 +449,7 @@ static int vdec_vp8_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 		       inst->frm_cnt, y_fb_dma, c_fb_dma, fb);
 
 	inst->cur_fb = fb;
-	dec->bs_dma = (unsigned long)bs->dma_addr;
+	dec->bs_dma = bs->dma_addr;
 	dec->bs_sz = bs->size;
 	dec->cur_y_fb_dma = y_fb_dma;
 	dec->cur_c_fb_dma = c_fb_dma;
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
index cf48d09b78d7..eea709d93820 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
@@ -1074,7 +1074,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
 	unsigned int mi_row;
 	unsigned int mi_col;
 	unsigned int offset;
-	unsigned int pa;
+	dma_addr_t pa;
 	unsigned int size;
 	struct vdec_vp9_slice_tiles *tiles;
 	unsigned char *pos;
@@ -1109,7 +1109,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
 	pos = va + offset;
 	end = va + bs->size;
 	/* truncated */
-	pa = (unsigned int)bs->dma_addr + offset;
+	pa = bs->dma_addr + offset;
 	tb = instance->tile.va;
 	for (i = 0; i < rows; i++) {
 		for (j = 0; j < cols; j++) {
-- 
2.18.0


