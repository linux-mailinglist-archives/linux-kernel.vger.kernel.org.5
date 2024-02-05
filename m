Return-Path: <linux-kernel+bounces-52056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3819849387
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF7CB21DAB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFE2BE62;
	Mon,  5 Feb 2024 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a21RSwvO"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2360BA39
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112296; cv=none; b=B5cfIvGdJMwFk2735XrSHZgwOTwWfkMga/fEaiBmVL6nYW6txNnENpS+YSNRb93Ps8I+A/tNNdr8pSQ5jHB9EQqchNn11dB+pwZO7rv+xYzhsRDeYyoLKdnjBGbVef0/OqPQ14U/D1VMvZeaUAUR7imYAnohXLVaZrd19giI7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112296; c=relaxed/simple;
	bh=2noKBL5HYpd1xs5iDk72v8+AIEaGQwEt/KA4yFE7NKI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ae7D+h7/n4itFujzUJwv8QzEicwHrq9G29Z525jzeWw2xrbTZZ8Mew+J2KecBUEVogByCmYNg+bLHvyR2nwJQWiGh7jv4LM04rr0dpow9OToMxh8kse6gB3Ub2maVvX+xjZTdOiLTpv7aiFfI03Xc+W6xtr3mKHCV9MXSBOn9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=a21RSwvO; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9a2db1c4c3ea11eea2298b7352fd921d-20240205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yw30OqTt5AJHEMjDxcvTzl5oo4axO9cwqzp5IcfvIJk=;
	b=a21RSwvOU8gnqph+tTxW52QNND2T9phXD5hNO+lNa2XqbYwmEB3/43gAzqmDbh2Gq5VC0ew3jEtwpES50FyXQWm13uQwhs9VUYRt1pCAkE+8h3zqQ/NxxGknKn3eyOOfMtMJFaZZHdps+5hNRBHY15HAMNSWapYH0PtCtmePx1Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:990677f4-d114-4e71-bcc0-60d69de6f4f5,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:00af84fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9a2db1c4c3ea11eea2298b7352fd921d-20240205
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <mac.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 624134815; Mon, 05 Feb 2024 13:51:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Feb 2024 13:51:26 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Feb 2024 13:51:25 +0800
From: mac.shen <mac.shen@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>
CC: <mac.shen@mediatek.com>, <shuijing.li@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/3] Add HDCP feature for DisplayPort
Date: Mon, 5 Feb 2024 13:50:35 +0800
Message-ID: <20240205055055.25340-1-mac.shen@mediatek.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add tee client application, HDCP 1.x and 2.x authentication for DisplayPort
to support the HDCP feature.

mac.shen (3):
  Subject: [PATCH] drm/mediatek/dp: Add tee client application for HDCP
    feature
  Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x feature for DisplayPort
  Subject: [PATCH] drm/mediatek/dp: Add HDCP1.x feature for DisplayPort

 drivers/gpu/drm/mediatek/Makefile        |    7 +-
 drivers/gpu/drm/mediatek/mtk_dp.c        |  324 +++++--
 drivers/gpu/drm/mediatek/mtk_dp.h        |   99 +++
 drivers/gpu/drm/mediatek/mtk_dp_hdcp1x.c |  589 +++++++++++++
 drivers/gpu/drm/mediatek/mtk_dp_hdcp1x.h |   46 +
 drivers/gpu/drm/mediatek/mtk_dp_hdcp2.c  | 1021 ++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dp_hdcp2.h  |   52 ++
 drivers/gpu/drm/mediatek/mtk_dp_reg.h    |    7 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c       |    3 +
 drivers/gpu/drm/mediatek/tci.h           |  156 ++++
 drivers/gpu/drm/mediatek/tlc_dp_hdcp.c   |  598 +++++++++++++
 drivers/gpu/drm/mediatek/tlc_dp_hdcp.h   |  414 +++++++++
 12 files changed, 3230 insertions(+), 86 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dp.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dp_hdcp1x.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dp_hdcp1x.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dp_hdcp2.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_dp_hdcp2.h
 create mode 100644 drivers/gpu/drm/mediatek/tci.h
 create mode 100644 drivers/gpu/drm/mediatek/tlc_dp_hdcp.c
 create mode 100644 drivers/gpu/drm/mediatek/tlc_dp_hdcp.h

-- 
2.43.0


