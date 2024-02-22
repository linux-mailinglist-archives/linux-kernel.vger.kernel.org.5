Return-Path: <linux-kernel+bounces-77238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D9C860274
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B8B1C234EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D59548EC;
	Thu, 22 Feb 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jIgR1C0Q"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8714B815;
	Thu, 22 Feb 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629448; cv=none; b=LTBisxRRaA+K4YwlipmVDsUcxfVXa1wATyYjWQAJXFH7n4L6k7aueNe/PdvmzLpEQAmgm7iRHwCymgAHpni03rXS82v1dpn5oLVLzZ3tOBLJdyFDlfY4lEAL7UmD3x6fT86r81gAbM16rnpGBFOY34zfIoPzqN91OqciJUfF6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629448; c=relaxed/simple;
	bh=95r+akAe5Mt4IxxeLNBeJRA1AYrk72nvLO+tAFll6OI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p9SiExoKt6rx2+zLEPgY3OHJNbAk+quKRuMHoPNYoEsUNRGDvXKILjd/bASzAo8J0Ja5fybNlW5h9XnKyI08tQ8aGmjC0tCDWKZsECdGuNU8m5c1gnWkc1lKTAaxmWuvl395a6l/2NRpsbiS8ohK5weTyThH464Cbu0oCXDgWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jIgR1C0Q; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M9BLjT021854;
	Thu, 22 Feb 2024 11:17:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=wngh9XWx
	50PcAMGvZZT3RlIDQYUq9ZQZfregPTf4g9M=; b=jIgR1C0Q0FSaaUXDEDa9zinE
	xfpUyaJwIG97mykYx0mrhLQtb1sEGs7hXKMAYIwJhLpSa62ONBOgZHCQAniWs3Pq
	iWZJG6sP8jOEcSCCwr6NbxuPiRki4Rh4Rnky6Hk/EZ9VHq3YXffLnbs/ydXBvbsn
	RDIyh36GgHkenatduRTcUVsYXWebwYAULWzGjUYRhjLBZEVEylHCtRxfbSrne1NZ
	wjFxALkVrdeqFWH0X9QASUfXhP9N9k4ZaHOp0RIpi393CRHloPEqcE96do2HZwtq
	6UoerEijHPH+F98dA9DBR14uBffwUzehhujEwG57e1DtwLEtJUh4pbz6UPV5MQ==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3we3dwah95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 11:17:24 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 22 Feb
 2024 11:17:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 22 Feb 2024 11:17:23 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 2A7923F718D;
	Thu, 22 Feb 2024 11:17:20 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <huziji@marvell.com>, <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v3 0/2] Fix PHY init timeout issues
Date: Thu, 22 Feb 2024 21:17:12 +0200
Message-ID: <20240222191714.1216470-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IAP0YGiOzlM2mvAqO6ZuH5uIWA9G2meI
X-Proofpoint-ORIG-GUID: IAP0YGiOzlM2mvAqO6ZuH5uIWA9G2meI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Fix PHY init timeout issues:

1. Clock Stability issue causing PHY timeout

2. Timeout taking longer than needed on AC5X.
   Solve by constantly testing the PHY init bit
   until it toggles, but up to 100X timeout factor.

v2:
    1) convert polling loop to read_poll_timeout()
       for both patches.

v3:
    1) Add Acked-by, Fixes and CC for stable

Elad Nachman (2):
  mmc: xenon: fix PHY init clock stability
  mmc: xenon: add timeout for PHY init complete

 drivers/mmc/host/sdhci-xenon-phy.c | 48 ++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 9 deletions(-)

-- 
2.25.1

