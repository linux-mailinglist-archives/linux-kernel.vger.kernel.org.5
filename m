Return-Path: <linux-kernel+bounces-120419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A5388D71A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789D31F288F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC0724B26;
	Wed, 27 Mar 2024 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="etIhkxUN"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C952C190
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711523940; cv=none; b=jFJVgbP5/0gMH0uDjezxnxQRSrN7zF2z1O322WP0Y4r+PYKBwDdRHUf2t+pUf6tpzk+CD257Bl/JNNpWFdBnmQSFGTr5da00ucANIGglcUnc76cBH06CNywENvCSfX2pYt08XWNoCWT24ybEV+zqE9/OdXY4799q+r19SVUBh1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711523940; c=relaxed/simple;
	bh=3Q+lbP9fpfOK+r0+ltKIMrTUg5KwkTJ8OyUxh867q+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=soK1mlmFsfsJoK5OSnWf2/z9dR3x8rFQ2Kjw3sAMFJTVURNwMYftTxueHu49MqerhUuGPAl6L7s/S2ztMEp6fqwj2jvVXFqs/Ptzcm3MJyC3eLPOxg+JixgJzdoQ+Hs0/lwAX27zO/TCOemBM1VT+F10W80SWUucR+/KG3Ofzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=etIhkxUN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R6n8vM009783;
	Wed, 27 Mar 2024 00:18:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=rojNcnfF
	9kJd7NdnnPnr+a5n3516+iqDUSRCgYKDbiQ=; b=etIhkxUNch/qa7Ye3fYBpl7D
	rLADekCxZEOw5ft/nixPrVORrGNrqDgV+sBdr3kYFsxolTPmlDFfBGshcN5fYFsT
	PBT7cDBeWJzE8zM4ChQAubkMI+koJLLs98t+OOdyoedwXleWzX6s73z+ziIxNNVB
	3UhrPiiGtOFULuNvNyZDYB7FyIpmbw82mCBMa7lV0TjA92tAfzISMXifjsqdtsHV
	+vApZ6uVKmRcclYsQDueYu3QR2CgQ+g5yOKBIsiXLnUNKCoz1Q/EZ5g77n+IpS/p
	tCW8pjHSnChrurHXH3cgHeUkWRINSDwNXOSIgo+dQuLzOpnFmrRWhbU7tDPpPw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x3hy1xpcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 00:18:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 27 Mar 2024 00:18:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 27 Mar 2024 00:18:38 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 787483F70C1;
	Wed, 27 Mar 2024 00:18:35 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <bbhushan2@marvell.com>, <gcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [RESEND PATCH v4 0/3] Marvell Odyssey uncore performance monitor support
Date: Wed, 27 Mar 2024 12:48:29 +0530
Message-ID: <20240327071832.1556576-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Lhez1xrU4spcFW7Mhthlajdpf-ZEY62S
X-Proofpoint-ORIG-GUID: Lhez1xrU4spcFW7Mhthlajdpf-ZEY62S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_04,2024-03-21_02,2023-05-22_02

Odyssey is a 64 bit ARM based SoC with multiple performance monitor
units for various blocks.

This series of patches introduces support for uncore performance monitor
units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
series include the DDR PMU and LLC-TAD PMU.

v3->v4:
- Refactored the existing ddr pmu driver to extract the platform data

Gowthami Thiagarajan (3):
  perf/marvell: Refactor to extract platform data - no functional change
  perf/marvell: perf/marvell: Odyssey DDR Performance monitor support
  perf/marvell : Odyssey LLC-TAD performance monitor support

 drivers/perf/marvell_cn10k_ddr_pmu.c | 528 +++++++++++++++++++++++----
 drivers/perf/marvell_cn10k_tad_pmu.c |  62 +++-
 2 files changed, 515 insertions(+), 75 deletions(-)

-- 
2.25.1


