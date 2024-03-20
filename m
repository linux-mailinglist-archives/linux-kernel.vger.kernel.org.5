Return-Path: <linux-kernel+bounces-108501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32219880B61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D51C21D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339BED0;
	Wed, 20 Mar 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nMoxPTJU"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12431EEE7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710916864; cv=none; b=Flz+2Y/yv6n1WLHRooNSGOUH4T9GqMK2w4PQmY8OqQKAMbNldH1MJusW47HCz27kV6s1j/PMngPlKgBhK2aMoh6fuQeyUK9c704rwhRxUPFFjo/w5vnxfMR9x27YL+C75QSo/iEFSoHI8SES1jqz8ADZJoI+xzcrj1kaSh7nnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710916864; c=relaxed/simple;
	bh=okw8Zw+eI6UNkZUF1OiXY0hwkTlmjQq/5sbNv6wAMuw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gmgYXZukxV/onqlA5WsjqOKk5tX/BGW/DeT8KYGT5ijjNSqwn60TBSLkHzW4tHnX7MFy2sZBsi7Suikg/PlqLH2pIIDgo/7Hf650DG/WVdxgz5dFzcut+PUE6dJasxiVXwiWEUEJJ35wP0PvwFQxzPYqmJf5Q7zXGtppWuLuG5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nMoxPTJU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cd92a616e68411ee935d6952f98a51a9-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nyuAhfLKdHPlumW7Kz0BvKW3+g1fkVdh9kODSqgPya4=;
	b=nMoxPTJUvD2QTpTMP4lMvLROO9oJLPJB00CeMGc8C+CwP0EzuCkPvDqilA+Kmez0PpoPHFmyNeDKt21XYv6sPdFJx4Xs5NorUl8a7gHPL+tNW+IHlhQwY6/5G0G5C3/LHUIwxDe9AyszyxMUCRHNPKitHVIg77jRaZHRXGWy6gk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2c397afb-a3f4-4b96-ae07-070d69349039,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:110c9d90-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: cd92a616e68411ee935d6952f98a51a9-20240320
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1698100268; Wed, 20 Mar 2024 14:40:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 14:40:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 14:40:54 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
Subject: [PATCH 0/1] Add interface to allocate MediaTek GEM buffer
Date: Wed, 20 Mar 2024 14:40:42 +0800
Message-ID: <20240320064043.29780-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Add an interface to allocate Mediatek GEM buffers, allow the IOCTLs
to be used by render nodes.
This patch also sets the RENDER driver feature.

This patch is:
- Based on 20240320024222.14234-1-shawn.sung@mediatek.com
- Reviewed on https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1955361

CK Hu (1):
  drm/mediatek: Add interface to allocate MediaTek GEM buffer.

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 16 ++++++-
 drivers/gpu/drm/mediatek/mtk_gem.c     | 40 ++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_gem.h     | 11 +++++
 include/uapi/drm/mediatek_drm.h        | 64 ++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/drm/mediatek_drm.h

--
2.18.0


