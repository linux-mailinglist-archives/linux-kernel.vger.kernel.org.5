Return-Path: <linux-kernel+bounces-15800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5005A823335
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650EE1C21536
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2411C6B0;
	Wed,  3 Jan 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z4lswk3w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA51C2B3;
	Wed,  3 Jan 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403HGV09005814;
	Wed, 3 Jan 2024 09:28:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=HsM2PtSD
	G+uhFtF66jLd1H1LuunmkJrOLGiPepAyDm8=; b=Z4lswk3wpORZ01ay7F3lDaaY
	mA+puEDK6faXxr32WJ/pitwbdgbMNfhF+65TUMJKBLyjw+zTqMASdMA53QU+jENK
	gHFiDSKf0ZBdGvu6i+XBdydTuIiyI+7VPICNNc5sWGwk1fCSIhURU1HFNF+8Ll55
	O0ahccfijf14scSfdjJYtYyiibfxlX72PwZLKRaJucBSBEma81dUH17wvjcksZyW
	3TW1Gu3cV6Rm7oQSZrU0lnFzBcGIh6u9pFxYcAJbKTKTwF3VDSLABa9wQSg6ojLr
	4RXb3uuVXHNDUN116xRSvOme1YvUOVrHXcKb7lu6eE4gke4fIJgsGpI24/o/1Q==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vcxu5umjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 09:28:09 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 3 Jan
 2024 09:28:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 3 Jan 2024 09:28:07 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 9D3E25B6933;
	Wed,  3 Jan 2024 09:28:04 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <huziji@marvell.com>,
        <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 0/2] arm64: dts: ac5: add mmc
Date: Wed, 3 Jan 2024 19:28:01 +0200
Message-ID: <20240103172803.1826113-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XmTx4lKS0Wjl2yBU6XflX3GkQ-PPpnsW
X-Proofpoint-GUID: XmTx4lKS0Wjl2yBU6XflX3GkQ-PPpnsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

This patch series adds device tree support for the Marvell AC5/X/IM
series of SOCs.
This is required due to bus limitation of 31-bit in this SOC family
plus the fact that the DDR memory starts at address 0x2_0000_0000 .

Elad Nachman (2):
  dt-bindings: mmc: add Marvell ac5
  arm64: dts: ac5: add mmc node and clock

 .../bindings/mmc/marvell,xenon-sdhci.yaml     |  4 ++-
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 31 ++++++++++++++++++-
 .../boot/dts/marvell/ac5-98dx35xx-rd.dts      |  4 +++
 3 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.25.1


