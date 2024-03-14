Return-Path: <linux-kernel+bounces-103238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4287BCC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEB62844D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F4853E2D;
	Thu, 14 Mar 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QjCyBJYe"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBAA8831;
	Thu, 14 Mar 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419419; cv=none; b=J1prtch08OmWtTvn3UubQMmab+jlGJQsUHLmAfz99oQn4CCOkwmmZ6NqLYzTUONVhvH4X+r7fdqcFH32E0yLvThEviM6M3Pr0F6mn1JY1PunwQBd6nz+4Nt+idpqr9k6Tc5Aq50cwjy+rSjVe9WJ5aspWwQBe+toVcZZTDO1mXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419419; c=relaxed/simple;
	bh=AQsHUkmoCoT49L49qMYT4ETuprISeqx8xIy0oxUYFEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fEst/uXsq3SAsyjEOXLBcYoONn1n52GV83MH11AN5Ukw6iRAxpE4uzdSU6/9pm+iEfdT0+NX3+XqvrXula5YHU1WcTBgnMaE8+VkhFICo6Anbs/F3xxHMTZLhMAVdWe7JU/QkIL5J7bZC9lpnH3qa2xJKzSJyDEIVqZOsD/1Gyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QjCyBJYe; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9a5d3a2ae1fe11ee935d6952f98a51a9-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ExKWeZtF1o/H6VvLIV2C1PGZug2wLFclbrXuhugazns=;
	b=QjCyBJYeFKc957okieBTwMcitgoYSS5YWSDrTbDkLOXOauR/mtquFCPlBaPEoaovKZ3X4TdGUJpERXDhYSsz0P2XmGUPA0QERALKV4dwB4BH6yQIeMRNLnQ46tj8Jml1IYxoucnWJYN4II3zF0R9VvBJhFxXrO0iqbJkMB4RrpM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:57622e65-deef-4b24-b22a-9f3d3dac0d3f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:216c8081-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9a5d3a2ae1fe11ee935d6952f98a51a9-20240314
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1967096897; Thu, 14 Mar 2024 20:30:12 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 20:30:10 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 20:30:10 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>, Irui Wang
	<irui.wang@mediatek.com>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, Yunfei
 Dong <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4,0/2] media: adding lock to protect the context list
Date: Thu, 14 Mar 2024 20:30:07 +0800
Message-ID: <20240314123009.20205-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The ctx_list of each module will be deleted when scp getting
unexpected behavior, then the ctx_list->next will be set to NULL,
the system reboot when access the NULL pointer in function
vpu_enc(dev)_ipi_handler to go through each context.

---
Changed in v4:
- Re-write the commit message for patch 1/2
Changed in v3:
- change 'Fixes' tag in patch 1/2
- add cover-letter for this patch series
---
Yunfei Dong (2):
  media: mediatek: vcodec: adding lock to protect decoder context list
  media: mediatek: vcodec: adding lock to protect encoder context list

 .../platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c   | 8 ++++----
 .../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c | 5 +++++
 .../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h | 2 ++
 .../media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c  | 2 ++
 .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c | 5 +++++
 .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h | 2 ++
 .../media/platform/mediatek/vcodec/encoder/venc_vpu_if.c  | 2 ++
 7 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.18.0


