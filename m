Return-Path: <linux-kernel+bounces-138351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829EE89F00C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F989289817
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D906159566;
	Wed, 10 Apr 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s+RwauTd"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E5158A24;
	Wed, 10 Apr 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745622; cv=none; b=Pi9sn2AIhHGZGQQlpeTmOSrT+EBZqhPa1GC+m4z7YUvOHXObWgIn1qH2tC52FLcEbJsV3w5Iq17YYRiDcto2SE545FgLuR201O7p5+iNtQtJw5H5dNmAzSU0SqBxws1W+5LQYEiNWKw0YbQ59jGw67dgTLKDRDtKkQyfvE3/21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745622; c=relaxed/simple;
	bh=SAqBFczJ+tmlYo+zdCtJ3BATtOdKgesPROhCRLUBJJs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ko8QccszYtE4o6Nql12Z8zXAfoKFczRco3D6N05M8OokWJPEzbzhaeKsfrGeTGc9yJXaFfI0TvFZO1/Rqe841wQeYAYoevL+arlja49sKl51aUpLSY+S6cRxTfwmvgShV9YsuQUbFvdT+qNT38/7Qm29m6OB0NJnwfRG5wX+g4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=s+RwauTd; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b53e6872f72611eeb8927bc1f75efef4-20240410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2sokhXpVuGdd+C31xIWCwBxH2sSaSAWmmdSxZUZqrmo=;
	b=s+RwauTd5sgv6b9xOUEGPjz9zjpTRkVEux5vY5OBNDw//PEz8A5xsoCUen+SgrBozP+Lvqm4blQxoZTJucjGaaY4vFsHoJb9iBre4o/hO3A0WVdN2ThkIqU+Lw4AWfF6qjdXj7c6wmDCfE+z2IY5VRgf1PkLzP4ooTw6UKXv9LQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:46e3d9f5-6ffc-422e-b05a-efff55788ba4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:05d58282-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b53e6872f72611eeb8927bc1f75efef4-20240410
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1194052815; Wed, 10 Apr 2024 18:40:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Apr 2024 18:40:10 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Apr 2024 18:40:09 +0800
From: Zhi Mao <zhi.mao@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Zhi Mao <zhi.mao@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Laurent Pinchart
	<laurent.pinchart+renesas@ideasonboard.com>, Heiko Stuebner
	<heiko@sntech.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil
	<hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, Tomi
 Valkeinen <tomi.valkeinen@ideasonboard.com>, Alain Volmat
	<alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, Mehdi
 Djait <mehdi.djait@bootlin.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bingbu Cao <bingbu.cao@intel.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<shengnan.wang@mediatek.com>, <yaya.chang@mediatek.com>,
	<yunkec@chromium.org>, <10572168@qq.com>
Subject: [PATCH 0/2] media: i2c: Add support for GT97xx VCM
Date: Wed, 10 Apr 2024 18:40:00 +0800
Message-ID: <20240410104002.1197-1-zhi.mao@mediatek.com>
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

This series add YAML DT binding and V4L2 sub-device driver for Giantec's GT9768&GT9769.
GT9768&GT9769 is a 10-bit DAC with 100mA output current sink capability, designed
for voice coil motor(VCM) with I2C control bus.

This driver supports:
 - support pm runtime function for suspend/resume
 - support camera lens focus position by V4L2_CID_FOCUS_ABSOLUTE CMD
 - used in camera features on ChromeOS application

This series is based on linux-next, tag: next-20240409

Thanks

Zhi Mao (2):
  media: dt-bindings: i2c: add Giantec GT97xx VCM driver
  media: i2c: Add GT97xx VCM driver

 .../bindings/media/i2c/giantec,gt97xx.yaml    |  91 +++
 drivers/media/i2c/Kconfig                     |  13 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/gt97xx.c                    | 640 ++++++++++++++++++
 4 files changed, 745 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml
 create mode 100644 drivers/media/i2c/gt97xx.c

-- 
2.25.1 



