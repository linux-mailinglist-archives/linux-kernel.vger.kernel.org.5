Return-Path: <linux-kernel+bounces-152065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB788AB847
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936F32823A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEED5382;
	Sat, 20 Apr 2024 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lWNhlTMX"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231F38B;
	Sat, 20 Apr 2024 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713575947; cv=none; b=UHqdVjEWa7EjywzVFOydcthgLWgkzKJrJXEjHVJjWHtYyY5TzKOk7U5tpwKARO3i9QGpfTPdvPybEufZnr9DQ+SxVlCdyqrJswijac2h5z5iL0G9OvWtIHHVTndRrjsADSozN99BjqK5Z/NJXlCHEAIWofD7yti5k56Dva8CX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713575947; c=relaxed/simple;
	bh=OeWw0/sfk0kAqrVMvmM1AIpTMkffaC+LIKXz0yiKHp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d+W2/fxTnO+VNpfaLjDwBp3tLghNavvM3IhGBzLszSIsw7Y/C/TgwSGnnqizHVtM6l035Ot6Imjjg7iWfIOWDmyrB0KK1pIfaQpWoMA3sIqL2kVDrvGIGqQ6LiM4zypfUDyQEQyQyCH1c/+LBUxJYcmcnbg7AMkv4bD4uHcZaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lWNhlTMX; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f7c963bafeb311eeb8927bc1f75efef4-20240420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WPpCiaf+ewsMyYmHzhTXLI1CVcvOmnq22A0ReGIPgsU=;
	b=lWNhlTMXIs1OefaCQqPSC03Cy8qf/AhppDHLgpjFXmhk/M+/m3m51m63+uVii+0yHFWJdwnY2R1ZelBYcLtofYYmJEa31av4jDL7FVOzMAIK/dbxGdIHX8Fhu4d5BiRSPkKpqV3bqcUQzhdTVI2Tuas8cSt5eSdEBV6lZ2w7M2U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5b31edbc-f447-440c-9aa3-0b2e4bbe6cfb,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:82c5f88,CLOUDID:795d6586-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: f7c963bafeb311eeb8927bc1f75efef4-20240420
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 874621484; Sat, 20 Apr 2024 09:19:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Apr 2024 18:18:59 -0700
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 20 Apr 2024 09:18:57 +0800
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
Subject: [PATCH v1 0/2] media: i2c: Add support for GT97xx VCM
Date: Sat, 20 Apr 2024 09:18:38 +0800
Message-ID: <20240420011840.23148-1-zhi.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N

This series add YAML DT binding and V4L2 sub-device driver for Giantec's GT9768&GT9769.
GT9768&GT9769 is a 10-bit DAC with 100mA output current sink capability, designed
for voice coil motor(VCM) with I2C control bus.

This driver supports:
 - support pm runtime function for suspend/resume
 - support camera lens focus position by V4L2_CID_FOCUS_ABSOLUTE CMD
 - used in camera features on ChromeOS application

Previous versions of this patch-set can be found here:
v0: https://lore.kernel.org/all/20240410104002.1197-1-zhi.mao@mediatek.com/

This series is based on linux-next, tag: next-20240419
Changes in v1:
- dts-binding files:
-- remove "aac-mode/aac-timing/clock-presc" control information
-- remove words:"drivers" in commit message, as bindings are for hardware
-- use compatible filename for YAML
-- remove some uselss comments, as they are clear from the compatibles
-- use "camera-lens" as node-name

- gt97xx vcm driver：
-- use BIT(x) method to define some MACROs
-- remove "aac-mode/aac-timing/clock-presc" control and use the default settings
-- fix duplicate "return" case in function:power_on()/power_off()
-- use API:device_get_match_data() and dev_err_probe() in function:probe()
-- fix some coding style of comments

Thanks

Zhi Mao (2):
  media: dt-bindings: i2c: add Giantec GT97xx VCM driver
  media: i2c: Add GT97xx VCM driver

 .../bindings/media/i2c/giantec,gt9769.yaml    |  56 +++
 drivers/media/i2c/Kconfig                     |  13 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/gt97xx.c                    | 436 ++++++++++++++++++
 4 files changed, 506 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/giantec,gt9769.yaml
 create mode 100644 drivers/media/i2c/gt97xx.c

-- 
2.25.1




