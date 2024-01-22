Return-Path: <linux-kernel+bounces-33049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 013098363AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E5C1C235C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F83C07B;
	Mon, 22 Jan 2024 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J3GUiVg/"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B93A1A5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927803; cv=none; b=OvxaqjO5hAdtxMRC4/DM6xaAOXwsA98cycAZSIYPDebYBXJfayMH+bM/UCU1pu3E2VVYVG4kfDuKq34YS5LqHXo0Buskpr/7Dyy55mX6iDgcJXfZc5R12Svk8L6Cmq77NXJUtqurB0Xf0oRrPo5ImSpvD7hFuLYmt9F0jSduLl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927803; c=relaxed/simple;
	bh=1zjBwGYdMsAXlcrn+jyEclUY6YzCr9lQ3UokxI0mHmI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MlFiRfNhw65qrOVhj5tKGazyrQxAteRrvuzm3qHGl0eEKjAD/wJZdr06qZshKk1ny15kESUuh94+lQMSWY0GJ/IMFF7zdXCK2g9x74vmUhDF49RB8U3CAFADCfttJe4ZrwMxJaIseFJ2lfTl6cuXiG1STWZ4TTyEG6clugGjRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J3GUiVg/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40LNn4sE007261;
	Mon, 22 Jan 2024 04:49:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=id42IbT+
	9R3Nmwuhbw3Ko6YmnXQHuzQozlC7TjeqSVs=; b=J3GUiVg/IevliVceLzUgkBOj
	Jm0JYkyoaw22ezy/pJiLBmJyJo0RiN71Gb5Q2AR+7Y64ihSipVcpqVkj9HnWrwLO
	fmvkvqFIxGPMec4VpsIL+q2yPVl0GySghBo4937/CnG3qlQ41h61LS3Ob/lq65n8
	Ersx/HLi9Cl9zBzURofteCXWM8Z5hLTAmr0aJCDiUZgv1FpP6xhJzuXVVaAwXOCM
	KPdl61sb3NscOOODMZFlHhMTu5bAB+DUdzggkaEVhLI4Q88QBXX6gfOr3he0KOTD
	fX2dR8Ix/symlt9LAFV7Dg4RmvEupHeGC4TitIkbedqtcwQbNVgtVaQY2CJj6g==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vrejncu39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 04:49:40 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 22 Jan
 2024 04:49:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 22 Jan 2024 04:49:38 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id CB01B3F7071;
	Mon, 22 Jan 2024 04:49:35 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <george.cherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v3 0/2] Marvell Odyssey uncore performance monitor support
Date: Mon, 22 Jan 2024 18:19:31 +0530
Message-ID: <20240122124933.1311925-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s7W407-GMlEG5bDQKsMiSpjT_rOlTZNN
X-Proofpoint-GUID: s7W407-GMlEG5bDQKsMiSpjT_rOlTZNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02

Odyssey is a 64 bit ARM based SoC with multiple performance monitor
units for various blocks. 

This series of patches introduces support for uncore performance monitor
units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
series include the DDR PMU and LLC-TAD PMU.

v2->v3:
- Dropped PEM PMU support, will be sent as a separate patch.
- Dropped device tree support for DDR PMU and LLC TAD as the acpi table 
  based probing is used.
- Added support for Odyssey tad pmu in the existing driver.

Gowthami Thiagarajan(2):
  perf/marvell: Odyssey DDR Performance monitor support
  perf/marvell : Odyssey LLC-TAD performance monitor support

 drivers/perf/marvell_cn10k_ddr_pmu.c | 421 +++++++++++++++++++++++----
 drivers/perf/marvell_cn10k_tad_pmu.c |  41 ++-
 2 files changed, 399 insertions(+), 63 deletions(-)

-- 
2.25.1


