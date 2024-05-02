Return-Path: <linux-kernel+bounces-166325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F47C8B9914
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC3285EE8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93054824A7;
	Thu,  2 May 2024 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OloDPNA1"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C560DEA
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646348; cv=none; b=lj2k81f6p9kLtEJzl8jG0EAosCfieEhJDvaD5LkHhZvK0l7t8Hd+zuAtmeFeuIeMUBc3nZVyNtR3SGdKXZvrCCpHGJDkH4sWu4I7YZL/tkDANxKJSwtA3Iewa8O/e9rSalWPHAaYM5UL/hC/bSEBicsgJHhCfMeJBgp+y5WAf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646348; c=relaxed/simple;
	bh=/3vMT/xbD2bcKDnPbZVqd9+Q29SLdm94v3PAxe43ib8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EXy7RznBwGA7YHIyvSeWInerf3M4SpU8UsbqXWnAXDO2EtCzPyYMPNEB/1LK9PzfYcbsZMLtSfvLOwj2j+NwIlThUrOaPKehkJFJm8jfDglKtKktlHvSanXplZEEPhJpNPasdyJa5RXH8dahP7imQrITemy8ulwoLVuT3F0q2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OloDPNA1; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2e5ca52a087011efb92737409a0e9459-20240502
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WxqlW/JXc/FtCf7oP19QJ6/dtFVmUXbor8CFzpptsik=;
	b=OloDPNA1HXeE0+qOWm1oxVWZNN3rzoZVzVj3qTtjqXmnyBzvL3caIcozc/3znNmMObl9GA19DenCLEwe19HD8bD8xHF88HNrQoieuYXyu6jt44YmFA/WMhQUtt4KjVL5uF7i5jWZhn9ZsZKgZtHUJRN2rGlk0eBvNM0oeJ7R/nE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5d5c8a87-26fd-4a0b-af70-eb96fc6e9480,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:f1315e83-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2e5ca52a087011efb92737409a0e9459-20240502
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1918405137; Thu, 02 May 2024 18:38:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 May 2024 18:38:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 May 2024 18:38:55 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>, "Nancy .
 Lin" <nancy.lin@mediatek.com>, Fei Shao <fshao@chromium.org>, Sean Paul
	<sean@poorly.run>, Jason Chen
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Hsiao Chien Sung" <shawn.sung@mediatek.corp-partner.google.com>
Subject: [PATCH v7 00/18] Support IGT in display driver
Date: Thu, 2 May 2024 18:38:30 +0800
Message-ID: <20240502103848.5845-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.903800-8.000000
X-TMASE-MatchedRID: HjquttRW1zv8rQJMqxBG8EOLK43kW8U2iEoqWVVgjSt13iQV6+wg1McR
	JRrz9JX4X3E2fHKxS5IAQc5GYpu9o4ztOe3zr3YkxQvMEFMAcCWMjqpeR/YVDfgnJH5vm2+giut
	UOt0XpgTQH7pNnZ67DfPH7C/OYQhzfLc22CMUE+twUSK4/EeOxSEdaywSZvzOgrAXgr/AjP2OVL
	fxhVIGTdnDgiFnMC7vt4ajh1kLGsVrsJ0gSgzm0oxVBvj1jbcj2+EpBnZEzfVehNZiiLW1fWb6P
	phVtfZg4wnhOb+JR+SAMuqetGVetnyef22ep6XYymsk/wUE4hogKsF0sUqGMwu1V7SsQKFF9tQx
	dJ7VV5r87lBDBWilNHRkdoUOOENC
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.903800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DDB7698C318721114BF06767EA83901678B404483425E4423E367D8DBE353DFC2000:8
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

This series is based on 20240307013458.23550-1-jason-jh.lin@mediatek.com

This series adds support for running IGT (Intel GPU Tool) tests
with MediaTek display driver. The following changes will be
applied:

1. Add a new API for creating GCE thread loop to retrieve CRCs
   from the hardware component
2. Support hardware CRC calculation in both VDOSYS0 and VDOSYS1
3. Support alpha blending in both VDOSYS0 and VDOSYS1

Changes in v7:
- Separate the patch into smaller ones

Changes in v6:
- Use drm_vblank_work to deffer the CRC work into bottom halves
- Separate the patches for "Premultiplied" and "None" alpha blending

Changes in v5:
- Add more descriptions to the codes
- Add DRM mode configs to the driver data
- Squash and rearrange the commits

Changes in v4:
- Separate the patch into smaller ones
- Change the title of some patches
- Revert the changes that are not related to the series

Changes in v3:
- Modify the dt-binding document of Mediatek OVL
- Set DRM mode configs accroding to the hardware capabilities
- Replace cmdq_pkt_jump_absolute() with cmdq_pkt_jump()

Changes in v2:
- Simplify CMDQ by adding commands that are currently used only
- Integrate CRC related codes into new APIs for Mixer and OVL to reuse
- Add CPU version CRC retrieval when CMDQ is disabled

Hsiao Chien Sung (18):
  soc: mediatek: Disable 9-bit alpha in ETHDR
  drm/mediatek: Add OVL compatible name for MT8195
  drm/mediatek: Add missing plane settings when async update
  drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation property
  drm/mediatek: Set DRM mode configs accordingly
  drm/mediatek: Turn off the layers with zero width or height
  drm/mediatek: Support more 10bit formats in OVL
  drm/mediatek: Support RGBA8888 and RGBX8888 in OVL
  drm/mediatek: Support constant blending in OVL
  drm/mediatek: Support constant blending in Mixer
  drm/mediatek: Support "Pre-multiplied" blending in OVL
  drm/mediatek: Support "Pre-multiplied" blending in Mixer
  drm/mediatek: Support "None" blending in OVL
  drm/mediatek: Support "None" blending in Mixer
  drm/mediatek: Support alpha blending in display driver
  drm/mediatek: Support CRC in display driver
  drm/mediatek: Support CRC in OVL
  drm/mediatek: Support CRC in OVL adaptor

 drivers/gpu/drm/mediatek/mtk_crtc.c           | 260 +++++++++++++++
 drivers/gpu/drm/mediatek/mtk_crtc.h           |  38 +++
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       |   6 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       |   9 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   6 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 300 ++++++++++++++++--
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  23 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  24 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   4 +
 drivers/gpu/drm/mediatek/mtk_ethdr.c          |  96 +++++-
 drivers/gpu/drm/mediatek/mtk_ethdr.h          |   5 +
 drivers/gpu/drm/mediatek/mtk_plane.c          |  15 +-
 drivers/soc/mediatek/mtk-mmsys.c              |   1 +
 13 files changed, 743 insertions(+), 44 deletions(-)

--
2.18.0


