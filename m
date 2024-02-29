Return-Path: <linux-kernel+bounces-86487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A071B86C624
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2381EB22912
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E47F629F8;
	Thu, 29 Feb 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N/cP+7EM"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203686214F;
	Thu, 29 Feb 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200582; cv=none; b=ENItuwfM7CpXCWNy+LvhnUDMLr8zZh5N1aewZ+nlGQIeyzFOelIMW2Du689qKY06PWjJOVcMbFzau7vWshdW4vWhe58t7VKNCEUaeELMH3aiNiv5X8Kgd93h+zEsrwfPQDmtNxITMr7j4ILlG84tPPuMuq2cgPICOZX5siac37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200582; c=relaxed/simple;
	bh=oX6D0KfNi01U7tSsTaFJWOaYfQ65vpLBSdYFEZ0GUsk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APRucDEANP4hjKy9P8FgTgOdSO016CNE+GPpB0hepX8ZrPgup6YOfjcLSPIOsWtcFRgy69ea06H9OrXCasqcgdyu8Iz/Ud+qqwIgdAQV5571dJAd4qCyXIaJMMKlPXKpGjUFqcIVwv8K4YmC8Wog4acvFSznDqGWKXGHvDhXAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N/cP+7EM; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c6aedc08d6e811ee935d6952f98a51a9-20240229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8mZe/2ayLC1nbMG8YNHZKyZz78ymXaSQ8iXw5n6PhEY=;
	b=N/cP+7EMBel7PGEdQ2X0OEdtEbJgZsV+mBcucne+5S43i4PWCLE86YdKO5dJjfgaOpE4u4HX3zAMei/q+c2J3LNmyjA8TlgUeHBhvcZ1+7pgi2bXb7oaQKVQWn1nEG17pR5u8XY/MkZFgVD9UCwqzpg1Oiv+UXfEiSxO/4pbaO0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0d075454-d480-45ba-8505-9dfaad702b72,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:45477384-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c6aedc08d6e811ee935d6952f98a51a9-20240229
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1439398416; Thu, 29 Feb 2024 17:56:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Feb 2024 17:56:12 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Feb 2024 17:56:12 +0800
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
Subject: [PATCH 0/3] media: mediatek: vcodec: fix vcodec smatch warning
Date: Thu, 29 Feb 2024 17:56:08 +0800
Message-ID: <20240229095611.6698-1-yunfei.dong@mediatek.com>
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
X-TM-AS-Result: No-10--5.692400-8.000000
X-TMASE-MatchedRID: GsIztItoYiqoft0ZW3r/iTCaEJt46PppMZm0+sEE9mv7efdnqtsaE2qs
	CKGiHb6RWXHfTJ/rMPZKhBUJyxjhBiY0eULsNBXlngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIfiA
	qrjYtFiQtkoiozVGxQwPgUY24KmPEUzhAlmaaSM7Hh1Xl/pN1bX7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.692400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C12846495FBB9F31E1C1D1D305CD86C0CE38D318B493888AF7439DD448A5A48B2000:8
X-MTK: N

Fix below smatch static checker warning from [bug report]:
The patch 397edc703a10: "media: mediatek: vcodec: add h264 decoder
driver for mt8186" from May 12, 2022 (linux-next), leads to the
following (in development) Smatch static checker warning:

drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c:351
vdec_h264_slice_decode() potential NULL container_of 'fb'

drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c:337
vdec_vp8_slice_decode() potential NULL container_of 'fb'

drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c:728
vdec_h264_slice_single_decode() potential NULL container_of 'fb'

---
Yunfei Dong (3):
  media: mediatek: vcodec: fix h264 multi statless decoder smatch
    warning
  media: mediatek: vcodec: fix vp8 stateless decoder smatch warning
  media: mediatek: vcodec: fix h264 stateless decoder smatch warning

 .../mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c    |  9 +++++++--
 .../vcodec/decoder/vdec/vdec_h264_req_multi_if.c       |  9 +++++++--
 .../mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c     | 10 +++++++---
 3 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.25.1


