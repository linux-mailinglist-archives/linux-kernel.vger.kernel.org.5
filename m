Return-Path: <linux-kernel+bounces-87810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48B086D951
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3221F23541
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAC38FAD;
	Fri,  1 Mar 2024 02:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="F++7zWSI"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B961FC03;
	Fri,  1 Mar 2024 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258508; cv=none; b=Wwaa+FteXBNnHI1o520Jm/ZTWwxz3pVse6dlSzg4yQ0upWG84S/gCsKhCCdqf2R7je+lzEJzR0WWJAtnKWuS8wvv3ECIBOxNxN5hdsHv08asixAXPrZ5cSngb5TwHxT7+hrI8XXdJthqYjURZiimd4xIMOcfkW+2FdFVIDEJMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258508; c=relaxed/simple;
	bh=qL6ryTGcMgCNWUne3Xb4F08g2n+lnz0zgQg6XVOU8ZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iRk6fuagQYSCAd83Nv9OykEWFtSTMaT8dRNDgN/6xiKEUAWFPxQCFO9ZGkq38ziV2U99MyQT8JT+k7OM48J5OMzeN0Z/BMz4BCr6FgUCI+TRZoR3JmqJq5eBdgMnHze4OcrOh8BatZitF88CzPdCuAtpGo4dKTfBdtSrP3V9HQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=F++7zWSI; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9fa86d68d76f11eeb8927bc1f75efef4-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HBS1I/NOgPbbX1oZFpsgk/1CALyAPNq0suP+PJ3XesU=;
	b=F++7zWSIF/rtO46xP5XMrm5P6hDqrY4yxfJE7EF1ORCuygCyGTeNkWAkKbqbhdvgrqqmjmrfCjJqf415/pPlZJq8QWVf6Z0jbytmK5cwzKKrVFW9XA4Ni39QTAdSas+gpZ8SanxipNyasWGa2TbXIxExH8WNGBlI51egEPv/VMI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:dead455a-5c7c-44f8-81b6-dcbfbd48f4bf,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:cde97984-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9fa86d68d76f11eeb8927bc1f75efef4-20240301
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 176012849; Fri, 01 Mar 2024 10:01:31 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 10:01:29 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 10:01:28 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, "Yunfei
 Dong" <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] media: mediatek: vcodec: support 36bit physical address
Date: Fri, 1 Mar 2024 10:01:26 +0800
Message-ID: <20240301020126.11539-1-yunfei.dong@mediatek.com>
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
X-TM-AS-Result: No-10--8.986100-8.000000
X-TMASE-MatchedRID: MXmpjVMQBvchu4G5/VkGwwPZZctd3P4B7f6JAS2hKPgUtdRZTmEaIb9n
	SsB9y3SmXfLeWSJ8nKvcFPFR1xoqQh8TzIzimOwPC24oEZ6SpSkj80Za3RRg8Nr8k9p6q6xQ8XR
	JHb0N4gK2+HtcNQgId7UxHy5DZGDPwaVEpyapekM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.986100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	81F330C20FD882D5E9A3FF4558755189B19F9D12D06F1B64C5360A96E6826FDE2000:8
X-MTK: N

The physical address is beyond 32bit for mt8188 platform, need
to change the type from unsigned int to unsigned long in case of
the high bit missing.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
index cf48d09b78d7..85df3e7c2983 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
@@ -1074,7 +1074,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
 	unsigned int mi_row;
 	unsigned int mi_col;
 	unsigned int offset;
-	unsigned int pa;
+	unsigned long pa;
 	unsigned int size;
 	struct vdec_vp9_slice_tiles *tiles;
 	unsigned char *pos;
@@ -1109,7 +1109,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
 	pos = va + offset;
 	end = va + bs->size;
 	/* truncated */
-	pa = (unsigned int)bs->dma_addr + offset;
+	pa = (unsigned long)bs->dma_addr + offset;
 	tb = instance->tile.va;
 	for (i = 0; i < rows; i++) {
 		for (j = 0; j < cols; j++) {
-- 
2.18.0


