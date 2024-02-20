Return-Path: <linux-kernel+bounces-72179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5019E85B086
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E519EB2287D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AB91F18D;
	Tue, 20 Feb 2024 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N0NKRQKJ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37602168C7;
	Tue, 20 Feb 2024 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708392371; cv=none; b=mDFT4E4Tm3beMIoNMP5WDG7k2U9I+JGLEMnqOkIl2Sf5KbEszdYEhr1YJe6irG2cZOFrQ1iKQ9MxWdrhNFMvZtTToKA/cLNuS+2zmieK9Vqa/LnlNau4sUrilMiJXCO84XksYM7KZtk6txFEhRJsq6+6zyOVG7zfrhzowvv0bVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708392371; c=relaxed/simple;
	bh=OuqSrEBVr+zxzHdDKD+c7Tmv57tFtsNr/yfG4R6Cu/U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KQ3LBKHS2xTGUXZBOiwSITUASWf6k0DCj2+7a9s6yOFf3Ig04SFHBorQ6aHL1Dh71HAWw/I2Cc/iyWVLW6X1o2QoWsmrez8FOCCf6kGyXTXWwj/kwSuCts08OyhXuNJtX9E6K4JJatdL7uAjvmyn8B0MLrQapztpLFjEl7fFGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N0NKRQKJ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fd7b633ecf8e11ee9e680517dc993faa-20240220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Jb79y2cBHS/ycIILNhbC/ey3i5o/CHC+FKzuHKR7Wf8=;
	b=N0NKRQKJsmOPcs9m0Jx5NX2yxKh5SMTss3VPhwvjO/S1g2jpD8okHChrZJA91T97LqjEELjHalZf5O5bqD7GOFPlU7Zk2mcfnSN82SLD54+kA14gSgdCmnoerp8tXZc7MYtpVdKGuUruS2sfsQAcqsJ3peKmcLnMY7lkGl0gfvo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a383cf8b-6d41-426d-bceb-b1e8f2424316,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:4ba9f8fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: fd7b633ecf8e11ee9e680517dc993faa-20240220
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1192308075; Tue, 20 Feb 2024 09:25:54 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Feb 2024 09:25:52 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Feb 2024 09:25:50 +0800
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
Subject: [PATCH v5 0/2] media: i2c: Add support for GC08A3 sensor 
Date: Tue, 20 Feb 2024 09:25:38 +0800
Message-ID: <20240220012540.10607-1-zhi.mao@mediatek.com>
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
v4: https://lore.kernel.org/linux-media/20240204061538.2105-1-zhi.mao@mediatek.com/
v3: https://lore.kernel.org/linux-media/20240109022715.30278-1-zhi.mao@mediatek.com/
v2: https://lore.kernel.org/linux-media/20231207052016.25954-1-zhi.mao@mediatek.com/
v1: https://lore.kernel.org/linux-media/20231123115104.32094-1-zhi.mao@mediatek.com/

This series is based on linux-next, tag: next-20240219
Changes in v5:
- gc08a3 sensor driver：
-- sort the header files alphabetically in driver code
-- refine the register define and some macros, fix some typo 
-- drop variable：“clinet/streaming” in struct gc08a3
-- refine "ret" flow in function:gc08a3_test_pattern()
-- drop the gc08a3_link_freq_config structure
-- rename some function and variable with a "gc08a3_" prefix
-- refine function:gc08a3_identify_module()/gc08a3_power_on()/gc08a3_power_off()/gc08a3_update_pad_format()
-- use stored crop rectangle in funcion:gc08a3_get_selectoin()
-- use cci_update_bits() in function:gc08a3_set_ctrl_hflip()/gc08a3_set_ctrl_vflip()
-- put the HFLIP and VFLIP controls in a cluster to make it efficiently set in an atomic operation
-- use "fwnode_graph_get_endpoint_by_id" in function: gc08a3_parse_fwnode()
-- remove function:gc08a3_enum_frame_interval()
-- enable autosuspend in function:probe()

Thanks

Zhi Mao (2):
  media: dt-bindings: i2c: add GalaxyCore GC08A3 image sensor
  media: i2c: Add GC08A3 image sensor driver

 .../bindings/media/i2c/galaxycore,gc08a3.yaml |  112 ++
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/gc08a3.c                    | 1335 +++++++++++++++++
 4 files changed, 1458 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
 create mode 100644 drivers/media/i2c/gc08a3.c

-- 
2.25.1




