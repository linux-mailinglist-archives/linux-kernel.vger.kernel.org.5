Return-Path: <linux-kernel+bounces-82532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0078685F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA50B1C26148
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE351610D;
	Tue, 27 Feb 2024 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CEAv4M/0"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435A4431;
	Tue, 27 Feb 2024 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997561; cv=none; b=LqVbJcFgxVnFELHvmzvuGYCr4kMM3Kizyik075X12qdblRVD9KFoYwWfJELtptBCM7IR/w+28u5qdRR5lc0lFOoy4KJ2oLamu/0QZSSJIM35R0N/aDdwT4pX+tvbUpW//l02COeAuGgZjVfKNr6xeKcafjaei63S3aQHetxFVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997561; c=relaxed/simple;
	bh=rwEK40Mj5XvI87taaXUUJLThj4xJgYuaMvN75mfEwus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LN1TauVQqSMWx3YfVI/9VjUIFYTaQN7bfmKJyft9KyL0LwruEbodfN9mA3q84P5w6lsLzG4+xToeGbojo47bKuxLFNzDATJ03UhjSWclPgGJCajxh5xhn0v88Kr2rRwoi6OAT2kBapHSPd8pkIUfnrCum9wWZGUbI0eeS6LHhho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CEAv4M/0; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1285ce64d51011eea4ad694c3f9da370-20240227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=c0PmycMVRivwEWb41nt3gj2hmGIBdJX1VHqiQ5e65ag=;
	b=CEAv4M/0hv2llcBJQ/aiABWGppiqyQ+FNyYnkiYMVjLuOLxXQhg7Cx2o1mb0q5yr/5ae7Q9aMic1My8LvAt6znHdBu7XUQDbLkrK+D3rJPbOHIrXGGoIRR/2zDjUTY/klXeIif11haHLzfX9zMMlT181wsr54ulLTo4dEgvhfBk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e2ba2bf1-7836-452f-be1b-10d5eec6e432,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:6f543d0,CLOUDID:81d63dff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1285ce64d51011eea4ad694c3f9da370-20240227
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 285279662; Tue, 27 Feb 2024 09:32:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Feb 2024 09:32:28 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Feb 2024 09:32:27 +0800
From: Zhi Mao <zhi.mao@mediatek.com>
To: <mchehab@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <sakari.ailus@linux.intel.com>
CC: <laurent.pinchart@ideasonboard.com>, <shengnan.wang@mediatek.com>,
	<yaya.chang@mediatek.com>, <10572168@qq.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, <yunkec@chromium.org>,
	<conor+dt@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jacopo.mondi@ideasonboard.com>,
	<zhi.mao@mediatek.com>, <hverkuil-cisco@xs4all.nl>, <heiko@sntech.de>,
	<jernej.skrabec@gmail.com>, <macromorgan@hotmail.com>,
	<linus.walleij@linaro.org>, <hdegoede@redhat.com>,
	<tomi.valkeinen@ideasonboard.com>, <gerald.loacker@wolfvision.net>,
	<andy.shevchenko@gmail.com>, <bingbu.cao@intel.com>,
	<dan.scally@ideasonboard.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v6 0/2] media: i2c: Add support for GC08A3 sensor
Date: Tue, 27 Feb 2024 09:32:19 +0800
Message-ID: <20240227013221.21512-1-zhi.mao@mediatek.com>
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

This series adds YAML DT binding and V4L2 sub-device driver for Galaxycore's
GC08A3 8-megapixel 10-bit RAW CMOS 1/4" sensor, with an MIPI CSI-2 image data
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
 - support resolution: 3264x2448@30fps, 1920x1080@60fps

Previous versions of this patch-set can be found here:
v5: https://lore.kernel.org/linux-media/20240220012540.10607-1-zhi.mao@mediatek.com/
v4: https://lore.kernel.org/linux-media/20240204061538.2105-1-zhi.mao@mediatek.com/
v3: https://lore.kernel.org/linux-media/20240109022715.30278-1-zhi.mao@mediatek.com/
v2: https://lore.kernel.org/linux-media/20231207052016.25954-1-zhi.mao@mediatek.com/
v1: https://lore.kernel.org/linux-media/20231123115104.32094-1-zhi.mao@mediatek.com/

This series is based on linux-next, tag: next-20240226
Changes in v6:
- gc08a3 sensor driver：
-- refine header files in driver code
-- use macro HZ_PER_MHZ/USEC_PER_MSEC for some variable define
-- define reset-pin as active-low in DT,and use logical states: gpiod_set_value_cansleep(reset_gpio, 0) in driver
-- use new PM macros: pm_ptr()

Thanks

Zhi Mao (2):
  media: dt-bindings: i2c: add GalaxyCore GC08A3 image sensor
  media: i2c: Add GC08A3 image sensor driver

 .../bindings/media/i2c/galaxycore,gc08a3.yaml |  112 ++
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/gc08a3.c                    | 1333 +++++++++++++++++
 4 files changed, 1456 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
 create mode 100644 drivers/media/i2c/gc08a3.c

-- 
2.25.1



