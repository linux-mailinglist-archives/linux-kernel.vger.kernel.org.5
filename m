Return-Path: <linux-kernel+bounces-12011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 000C481EED9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F461F21FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C37C45014;
	Wed, 27 Dec 2023 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="g44Hx1CB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D0145010;
	Wed, 27 Dec 2023 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BR1MwRC012857;
	Wed, 27 Dec 2023 04:33:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=GqSpaTDd
	FI7PPA6Yp+oHf0fLdjW5o73u2ceBRUXehKY=; b=g44Hx1CBPyx3XcBnow0OGszx
	rGnH8x5UJiJbNJf3qt/qjL6t6/8QYhOWa+qZ3KAdyVvBTOh0kIj63FF5EG6y7PLy
	FneONNNjmMUBCrK+voco7ZyMieALvnReMXWtai/IhY9ZwBkBmkrA2pGyqiImQj6m
	pPVDayHsNSHxWZ4IacrD02L7jKTYxKLKY9WcNFvvMHXSG9QVmnzcIJRrQ791LQs8
	slNhcTpwvu4Gc+cx750whAuS4Khs92XAHeBWjnvvcisgHBvdTyQDpGZTP9FITX4x
	14euFRDPtpYeNzu1nMb0e1U39ZZ0ucyqZnafrU+dT27YTASKRScLEv389I1S2A==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3v5yxp0a58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 04:33:09 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 27 Dec
 2023 04:33:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 27 Dec 2023 04:33:06 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id BDEDF5B6936;
	Wed, 27 Dec 2023 04:33:00 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <huziji@marvell.com>,
        <ulf.hansson@linaro.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <adrian.hunter@intel.com>, <thunder.leizhen@huawei.com>,
        <bhe@redhat.com>, <akpm@linux-foundation.org>, <yajun.deng@linux.dev>,
        <chris.zjh@huawei.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH 0/4] mmc: xenon: add AC5 support
Date: Wed, 27 Dec 2023 14:32:53 +0200
Message-ID: <20231227123257.1170590-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eLx3MVwVY76bvTaJo5RxoZPo9Xn3foGL
X-Proofpoint-GUID: eLx3MVwVY76bvTaJo5RxoZPo9Xn3foGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

This patch series adds support for the Marvell AC5/X/IM series of SOCs.
The main hurdles in supporting these SOCs are the following limitations:
1. DDR starts at offset 0x2_0000_0000
2. mmc controller has only 31-bit path on the crossbar to the DDR.

Point number one is solved by the first patch, which targets the
arm64 subsystem, by taking into account the DDR start address when
calculating the DMA and DMA32 zones.

This yields the correct split between DMA, DMA32 and NORMAL zones
according to the device tree CPU address limitations.

Point number two is solved in the mmc xenon driver by detecting the memory
size, and when it is more than 2GB, disable ADMA and 64-bit DMA, which
effectively enables SDMA with a bounce buffer.
DMA mask is then set manually to 34 bit to account for the DDR starting
at offset 0x2_0000_0000 .

Elad Nachman (4):
  arm64: mm: Fix SOCs with DDR starting above zero
  dt-bindings: mmc: add Marvell ac5
  arm64: dts: ac5: add mmc node and clock
  mmc: xenon: Add ac5 support via bounce buffer

 .../bindings/mmc/marvell,xenon-sdhci.yaml     |  3 ++
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 33 ++++++++++++++++++-
 arch/arm64/mm/init.c                          | 20 ++++++++---
 drivers/mmc/host/sdhci-xenon.c                | 33 ++++++++++++++++++-
 drivers/mmc/host/sdhci-xenon.h                |  3 +-
 5 files changed, 84 insertions(+), 8 deletions(-)

-- 
2.25.1


