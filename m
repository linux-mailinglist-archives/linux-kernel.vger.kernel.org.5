Return-Path: <linux-kernel+bounces-76218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92EB85F44D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6751C214E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504CD38DD8;
	Thu, 22 Feb 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fdJEjhpS"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FFB376ED;
	Thu, 22 Feb 2024 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593981; cv=none; b=fkLWM60Lf5sM/+ThRxBbuGnan+bixo8Gn9dHeLTrU1z9kUTT8J+6Z5+Hv4R4j9+gq6qR1+BEvmjmsgQPkuAjFQYHF9pjyAWUwxf3W6ItkPtVeG7h5JJ/FEmXpHbKf7x7Wxua1YF5D0oa7/uRBR9OBn7ln1/JYT+1oAM/KKXEQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593981; c=relaxed/simple;
	bh=cj2x5EkB+znCQLwMNSiHmRiWRUXDZC1sMKehm/0Vcos=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dv3Fw6oJFeTpYexesVARdHJa1QydFz/36fixmu3M577Spc1ZjrFgYZZahicbeJexa7v4uv67rCgfie4+AMDFoTNYTT3SOyysTbR8dmN5tYQYtODXJsi4q3ie+Jc5rPvdEoAoP40uvStebfeyRufRQoI7jb/KrCyzxgGYZtO/O90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fdJEjhpS; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6b14ec0ed16411eea4ad694c3f9da370-20240222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6B0HV0kGS0T2iBD7E8AlFvFIWEbIwJXtwEBE1cSDwcc=;
	b=fdJEjhpStBozUjQKLMxOSpKIYZ3GECjy8bvVjOtSCKL/E70JJ07r/75SIAOfXpyu1kJCT5JQ4kajntdbE8gsjrPZAanv8JQvfbCaL+NZ3xYwQfCuxwm7FyfcuXPr+wYpdmVSLxSPSokmeLZRRxSpsOIlF6REAXM5ccuidypX2RY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:85d21219-0c5d-40b3-ad53-6083bfde8b30,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-35
X-CID-META: VersionHash:6f543d0,CLOUDID:effb968f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6b14ec0ed16411eea4ad694c3f9da370-20240222
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1859642586; Thu, 22 Feb 2024 17:26:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Feb 2024 17:26:10 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 22 Feb 2024 17:26:09 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>, Irui
 Wang <irui.wang@mediatek.com>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, Yunfei
 Dong <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3,0/2] media: adding lock to protect the context list
Date: Thu, 22 Feb 2024 17:26:07 +0800
Message-ID: <20240222092609.31382-1-yunfei.dong@mediatek.com>
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

From: Yunfei Dong <yunfei.dong@mediatek.corp-partner.google.com>

The ctx_list of each module will be deleted when scp getting unexpected
behavior, then the ctx_list->next will be set to NULL, the system reboot
when access the NULL pointer in function vpu_enc(dev)_ipi_handler to go
through each context.

---
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


