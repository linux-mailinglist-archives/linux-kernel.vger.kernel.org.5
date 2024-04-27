Return-Path: <linux-kernel+bounces-160844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8598B4376
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BBA1F227F3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927F3770B;
	Sat, 27 Apr 2024 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GiYjisLu"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D42570;
	Sat, 27 Apr 2024 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714181198; cv=none; b=uYayljmEgb8uviRu1rRFqFmsNwiJqPjfluIZlsgT1SMnAfRArJm76NQQj5vzE1HrynbpFfob5lilueEDa9zOWrluIBqrB8tibhRzTQbmbM9sXCkoJ7ztH0rjqqi0HkvDIkkJSBC5JwXXVQpb9/we0ErNTy3iF+yMhhIQn8dxcb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714181198; c=relaxed/simple;
	bh=ecCTW0Np4az1GDooEM9K5T4Wf2Pdlo/BYYVp+btKGew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MVFIJi35uk00Hrd2BLzc6KiOJ6CfOlyFcazcSTMuDdzKHICB6qC9e9D5laH3V46ZecMtmZHcZk0sftHHLkYJq+VHtUkbMFO/GxB+quE4EjoeeA4FIznwVnsZGeYa+E4aiiGMAE73nPFipKhp7SkD9eYgFHxCn1vC7LgsKE+gFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GiYjisLu; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2c91bd78043511ef8065b7b53f7091ad-20240427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7Y4hXZVXbTEkPR4cCFHEBR55hGJrDqCDArvwkQjxBQo=;
	b=GiYjisLuWyBza2WbQ9K0yQTIggArSW0itM6oBdzxenQWnwi0p9939kq6v0Sdf6Qjksxs2qJDVwgGrcpHwJ4YxoV24hNhKe63n83jBWxO0vtkaYGk6gf+iWry9TfdWM0XXl1z4nrf6RsoktnRslllbaqdEuSSVX0EJeQW0WwQ/7U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:099d540d-2e7a-4366-bfc7-f28d43fff2e6,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:82c5f88,CLOUDID:2f9d67fb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2c91bd78043511ef8065b7b53f7091ad-20240427
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 685798841; Sat, 27 Apr 2024 09:26:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 27 Apr 2024 09:26:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 27 Apr 2024 09:26:25 +0800
From: Zhi Mao <zhi.mao@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Zhi Mao <zhi.mao@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Laurent Pinchart
	<laurent.pinchart+renesas@ideasonboard.com>, Heiko Stuebner
	<heiko@sntech.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil
	<hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>, Alain Volmat
	<alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, "Mehdi
 Djait" <mehdi.djait@bootlin.com>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, Bingbu Cao <bingbu.cao@intel.com>,
	<linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <shengnan.wang@mediatek.com>,
	<yaya.chang@mediatek.com>, <yunkec@chromium.org>, <10572168@qq.com>
Subject: [PATCH v2 0/2] media: i2c: Add support for GT97xx VCM
Date: Sat, 27 Apr 2024 09:26:11 +0800
Message-ID: <20240427012613.6621-1-zhi.mao@mediatek.com>
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
X-TM-AS-Result: No-10--0.994900-8.000000
X-TMASE-MatchedRID: lpk7+cih7u+uhCBFl/b63m3NvezwBrVmwlZ2GSFD7LgGW3hFnC9N1Zg1
	FOMOQofR/3dN/c325otYXsJ+nWY7U2GN6M1vhJ4HnVTWWiNp+v8oUVkB7ifJnkYvSDWdWaRh5ym
	1cSfxndgf7I0n0nPgmhEDxWyR0o1w0YRMm/X9bI7uykw7cfAoICoTaU3L23VCmyiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ1NZUO7I4U77G2E9Z8Xt3x1m4/XbB7QDM08NNZ3gvDJuiTg/SxOb1RkL/p6
	fATk3/mps857/V1yTmjhQ++Yq0mfrMADF+wG8K7js0+30OcemTzYaPZALfIbSyZdUr8fx4fMbuy
	vvGhtIDNwMS8lpRKBQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.994900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	53D9ACFF09AC5D5F0B61D020EA0B2910A5294ABA315F4ED34E9C71352FB5C4062000:8
X-MTK: N

This series add YAML DT binding and V4L2 sub-device driver for Giantec's GT9768&GT9769.
GT9768&GT9769 is a 10-bit DAC with 100mA output current sink capability, designed
for voice coil motor(VCM) with I2C control bus.

This driver supports:
 - support pm runtime function for suspend/resume
 - support camera lens focus position by V4L2_CID_FOCUS_ABSOLUTE CMD
 - used in camera features on ChromeOS application

Previous versions of this patch-set can be found here:
v1: https://lore.kernel.org/all/20240420011840.23148-1-zhi.mao@mediatek.com/
v0: https://lore.kernel.org/all/20240410104002.1197-1-zhi.mao@mediatek.com/

This series is based on linux-next, tag: next-20240424
Changes in v2:
- dts-binding files:
-- remove "|-" after description node, and remove a blank line

Thanks

Zhi Mao (2):
  media: dt-bindings: i2c: add Giantec GT97xx VCM
  media: i2c: Add GT97xx VCM driver

 .../bindings/media/i2c/giantec,gt9769.yaml    |  55 +++
 drivers/media/i2c/Kconfig                     |  13 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/gt97xx.c                    | 436 ++++++++++++++++++
 4 files changed, 505 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/giantec,gt9769.yaml
 create mode 100644 drivers/media/i2c/gt97xx.c

-- 
2.25.1




