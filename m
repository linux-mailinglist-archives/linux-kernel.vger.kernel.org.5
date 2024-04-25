Return-Path: <linux-kernel+bounces-157936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4258B18EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4BF1C22F72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019321401F;
	Thu, 25 Apr 2024 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="S0NhkdMd"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E27483;
	Thu, 25 Apr 2024 02:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714012433; cv=none; b=JgwduOUOzzySrBVHTDh0T3L33Sl0uwDEDpE5bpFOIHyYmy25qAhxUqQLxzl6HzkFe5hHJRMr3AGztnpxcwZ5PPNQDE67VO+s3a4TOfWaehjqWDDC21VpNv4UsRDA1oShDP3z9IUZ8hPxVlw9QqhG174HAEJmuWuiWeMW750CHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714012433; c=relaxed/simple;
	bh=mR+K/w3FVPmTrebXvMozU0UmSkTw/9Zcomq2YG395Po=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TVxBrsu3qHpx9R90EenfY6w/AORt8Ynm5/Y1rqOWrsPO5TIx19enhHEF1oALPUfIVleb+Fv/4u+dayRX4wcbiRutjcuhcx+OvFgHG87mf9ihQH/jIjSitINgCUrvuseJwUrXZVObzWIlWEjM6yhKUViRQFB9Eq2WZ71GxtPjDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=S0NhkdMd; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3e07e30a02ac11efb8927bc1f75efef4-20240425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=sVluxtdFfxvzOV3SS9bUZugPrDEZjGZyriZnqollBEc=;
	b=S0NhkdMdngEvDDEDoI+1ij5N3DWOEskSEjPdVJHOsBuE8gR95b8YrICapBtX6LmuXi9k663+G6n//lUxySUlokFzSDTYhsQaIrtRdaVHIKwJEO5qmbPmyz5yYsYtnLOpThhxTDVubtSuKJ3Bwnvfx8IyeHSSamxy4HwAOezuAsQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:092f09cf-0d72-456c-a931-4c6ae8ec1bb6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:ede19586-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3e07e30a02ac11efb8927bc1f75efef4-20240425
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 69325539; Thu, 25 Apr 2024 10:33:47 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Apr 2024 19:33:45 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 Apr 2024 10:33:45 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, SkyLake.Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH 0/3] net: phy: mediatek: Integrate mtk-phy-lib and add 2.5Gphy support
Date: Thu, 25 Apr 2024 10:33:22 +0800
Message-ID: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

Re-organize MTK ethernet phy drivers and integrate common manipulations
into mtk-phy-lib. Also, add support for build-in 2.5Gphy on MT7988.

SkyLake.Huang (3):
  net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
  net: phy: mediatek: Add mtk phy lib for token ring access & LED/other
    manipulations
  net: phy: mediatek: add support for built-in 2.5G ethernet PHY on
    MT7988

 MAINTAINERS                                   |   7 +-
 drivers/net/phy/Kconfig                       |  17 +-
 drivers/net/phy/Makefile                      |   3 +-
 drivers/net/phy/mediatek-ge.c                 | 111 ----
 drivers/net/phy/mediatek/Kconfig              |  33 ++
 drivers/net/phy/mediatek/Makefile             |   5 +
 drivers/net/phy/mediatek/mtk-2p5ge.c          | 399 +++++++++++++
 .../mtk-ge-soc.c}                             | 522 ++++++++----------
 drivers/net/phy/mediatek/mtk-ge.c             | 191 +++++++
 drivers/net/phy/mediatek/mtk-phy-lib.c        | 330 +++++++++++
 drivers/net/phy/mediatek/mtk.h                |  97 ++++
 11 files changed, 1277 insertions(+), 438 deletions(-)
 delete mode 100644 drivers/net/phy/mediatek-ge.c
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
 rename drivers/net/phy/{mediatek-ge-soc.c => mediatek/mtk-ge-soc.c} (79%)
 create mode 100644 drivers/net/phy/mediatek/mtk-ge.c
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

-- 
2.18.0


