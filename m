Return-Path: <linux-kernel+bounces-129005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486C489630E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F5A1F243DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382153F9F4;
	Wed,  3 Apr 2024 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oGyF9agt"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94913BB2E;
	Wed,  3 Apr 2024 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115521; cv=none; b=ChQq6b7zDE6KPta4homue8ZYFluDnUR4A26fiOFae+LhxnJbgw2qgyTTquqfbh/l86wmGXmfdF0GUwYwgzOLTQAmL2cnJSt6P7eQl4h6NKJrbyFRnFmebhz+TbYggZF+XCmPMaOKrlTK9ap/dfTx6AmbwdGOQF9VcNCeIiAeYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115521; c=relaxed/simple;
	bh=2B5ubMo2hBDrqEwadV5dCKYtjFP0itNCVJkqnUu7CJI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dj2yePyXDXbW3ifXWLYGDDe7FZUQ9YFhKZwevRG1UGV6/zyzV152ZEJLwve6YyY8xNN7uqhQvdEcFz2l+K3t6gyZJ6UbH0zMuQ7Tf4Jn/l89XBo5X+Ev+109Q+vv50udj2PENVzmBh42ZINjKylrO1PKNRLr4UnL+YG8VpxA4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oGyF9agt; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a51b8896f16b11ee935d6952f98a51a9-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7988cwAOK9MC3mHUDJ4zxY+hlmm8z4n8rPOgPgVYjvw=;
	b=oGyF9agtt/FtclX6nkeGIepis9Rk330xElllvA/1xNynYrRfWR7JvjjpCFerarugCHVxh1GZqhBIy/BCaTyhdjQl8WyAG7o9Hk+Q5b9+7+TWRd77MOgRsfFhGyYzNh7Wbi+sB7LLtdMA4gfQrickAJL5IzoisDMQMUjeR5tMyzQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6aaacf04-dcb0-49cb-81bf-e06bcd199dcd,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:19e22791-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a51b8896f16b11ee935d6952f98a51a9-20240403
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 785604696; Wed, 03 Apr 2024 11:38:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 11:38:31 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 11:38:30 +0800
From: Zhi Mao <zhi.mao@mediatek.com>
To: <mchehab@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <sakari.ailus@linux.intel.com>
CC: <laurent.pinchart@ideasonboard.com>, <shengnan.wang@mediatek.com>,
	<yaya.chang@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, <yunkec@chromium.org>,
	<conor+dt@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jacopo.mondi@ideasonboard.com>,
	<zhi.mao@mediatek.com>, <10572168@qq.com>, <hverkuil-cisco@xs4all.nl>,
	<heiko@sntech.de>, <jernej.skrabec@gmail.com>, <macromorgan@hotmail.com>,
	<linus.walleij@linaro.org>, <hdegoede@redhat.com>,
	<tomi.valkeinen@ideasonboard.com>, <gerald.loacker@wolfvision.net>,
	<andy.shevchenko@gmail.com>, <bingbu.cao@intel.com>,
	<dan.scally@ideasonboard.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 0/2]  media: i2c: Add support for GC05A2 sensor
Date: Wed, 3 Apr 2024 11:38:23 +0800
Message-ID: <20240403033825.9072-1-zhi.mao@mediatek.com>
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

This series adds YAML DT binding and V4L2 sub-device driver for Galaxycore's
GC05A2 5-megapixel 10-bit RAW CMOS 1/5" sensor, with an MIPI CSI-2 image data
interface and the I2C control bus.

The driver is implemented with V4L2 framework.
 - Async registered as a V4L2 sub-device.
 - As the first component of camera system including Seninf, ISP pipeline.
 - A media entity that provides one source pad in common.
 - Used in camera features on ChromeOS application.

Also this driver supports following features:
 - manual exposure and analog gain control support
 - vertical blanking control support
 - test pattern support
 - media controller support
 - runtime PM support
 - support resolution: 2592x1944@30fps, 1280x720@60fps

Previous versions of this patch-set can be found here:
v2:https://lore.kernel.org/linux-media/20240323014751.4989-1-zhi.mao@mediatek.com/
v1:https://lore.kernel.org/linux-media/20240316025253.2300-1-zhi.mao@mediatek.com/
v0:https://lore.kernel.org/linux-media/20240313054409.8073-1-zhi.mao@mediatek.com/

This series is based on linux-next, tag: next-20240402
Changes in v3:
- gc05a2 sensor driver:
-- remove gc05a2_power_on() in function:probe(),
   and use pm_runtime_resume_and_get() to power on sensor in function:start_streaming()
-- move gc05a2_identify_module() frome function:probe() to function:start_streaming()

Thanks

Zhi Mao (2):
  media: dt-bindings: i2c: add GalaxyCore GC05A2 image sensor
  media: i2c: Add GC05A2 image sensor driver

 .../bindings/media/i2c/galaxycore,gc05a2.yaml |  112 ++
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/gc05a2.c                    | 1383 +++++++++++++++++
 4 files changed, 1506 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc05a2.yaml
 create mode 100644 drivers/media/i2c/gc05a2.c

-- 
2.25.1





