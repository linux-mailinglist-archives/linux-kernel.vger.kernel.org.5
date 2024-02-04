Return-Path: <linux-kernel+bounces-51452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D741848B6D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7838D1F23078
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F2479C2;
	Sun,  4 Feb 2024 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Qn36UBNz"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61306FB9;
	Sun,  4 Feb 2024 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707027358; cv=none; b=ca8CYmd+hGZ6UrdqRSHQWdi9m2NYF7ffyPmivNvTspYWgeSfl0CnzTwMH2c6vynOtQAjw7z8D4VSFMAFLNfFxmL8sgLKxtP0QPvAkIrRtQPxYZ1l20ALWLv592ekyhJ8g73z5f5ABgj/x6thrvF+VbY6mi+h9oJdBZhnfMT+lEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707027358; c=relaxed/simple;
	bh=zj8W88bcPnLkTE+fXm5UmM2vKrJmCJcLAJXAOeGn64g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NUTeBl66sBRM39f180V+DXwa+vX3UFg7UXUbboZR094U+7YXQXGh5USJopfckfi+vLqwGQfrbsEJZhsIYllp1o/l0nzHWVBPPIxg7BZaSrNjZh11RSrtCJEU8mdpbO2huCZ5jJLiXrsyrzDWJ6LLqafRdO1yp9Y9fnwvCbZwrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Qn36UBNz; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d4e0afb8c32411eea2298b7352fd921d-20240204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fkXM634J1jlWm154+lSLzt0VRf6EPqKugqRDSzvwyjE=;
	b=Qn36UBNzFcP7wIRnIMbrFew5Zh9bH+4wUUP7S9q5JzS+vQMMCiVtb821/aMm3zaBr6+kNNY2MfZdqAATY7MRdw229n4M06knDGLYSi1xPMPnyJmMZyFGf9apXtEhVfuggUn+RXMmh+7MRzwM/pq1rZByyO6HTLiYeioyNeukQRI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:93253548-1f6c-40c3-b351-76553d597c32,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6e16cf4,CLOUDID:ece07cfe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d4e0afb8c32411eea2298b7352fd921d-20240204
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 444715976; Sun, 04 Feb 2024 14:15:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 4 Feb 2024 14:15:43 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 4 Feb 2024 14:15:42 +0800
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
Subject: [PATCH v4 0/2] media: i2c: Add support for GC08A3 sensor
Date: Sun, 4 Feb 2024 14:15:36 +0800
Message-ID: <20240204061538.2105-1-zhi.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.927800-8.000000
X-TMASE-MatchedRID: Rxzc2NErS1CU2fVedEQUO9jGRkLinPFIsjXBCUyiRiYfVuGrjP7J9Mn+
	P5bPwFH9zE9s0r9yaTktNGU0YgjeG9OD37/ztihF9Ib/6w+1lWT4qCLIu0mtIGHZ+cd7VyKXEXF
	HklABLo68Vg/IW0KkK0qWBBwop/gkmxh0gY/o+VkD2WXLXdz+AXN3sLsG0mhuZ3q824boKrK6JW
	ZHJaNx2Tu2CaYPW4+0Qf7ywtpmhLmpvxu3mLBTO78P2gGjGpF1MVx/3ZYby7+K1QpOXZsW6rwos
	MBsCF61X3E2fHKxS5I1hvF/jmI7s79ZdlL8eona8dA3q/uj/L/EQdG7H66TyH4gKq42LRYk45J2
	CIYLmEfavpPfvq387lBQskZgXfN/ppwvS1ddVil+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.927800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	33169919FB7FFD4F64E3E162B218E2F6FFDCF6FFEC8629B887694416EF336E7F2000:8
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
v3: https://lore.kernel.org/linux-media/20240109022715.30278-1-zhi.mao@mediatek.com/
v2: https://lore.kernel.org/linux-media/20231207052016.25954-1-zhi.mao@mediatek.com/
v1: https://lore.kernel.org/linux-media/20231123115104.32094-1-zhi.mao@mediatek.com/

This series is based on linux-next, tag: next-20240202
Changes in v4:
- dts-binding files：
-- rename the titile of patch "dt-bindings"
-- use "sensor@31" as device node,according to Krzysztof's suggestion

- gc08a sensor driver：
-- use "ARRAY_SIZE(...)" directly in driver code, instead of macros
-- use pointer to corresponds an array entry of link_frequency
-- use variable of struc "mode" in function:gc08a3_get_selection()
-- declare ret as last in function:gc08a3_test_pattern()
-- fix some coding style by "checkpatch.pl --strict --max-line-length=80"
-- remove function:gc08a3_g_mbus_config()
-- use "v4l2_link_freq_to_bitmap()" API to parse driver-supported link frequencies
-- move runtime PM API before registering the sub-device in function:probe()

Thanks

Zhi Mao (2):
  media: dt-bindings: i2c: add GalaxyCore GC08A3 image sensor
  media: i2c: Add GC08A3 image sensor driver

 .../bindings/media/i2c/galaxycore,gc08a3.yaml |  112 ++
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/gc08a3.c                    | 1448 +++++++++++++++++
 4 files changed, 1571 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
 create mode 100644 drivers/media/i2c/gc08a3.c

-- 
2.25.1





