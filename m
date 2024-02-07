Return-Path: <linux-kernel+bounces-56801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7816E84CF5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02DFDB27133
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AE28289E;
	Wed,  7 Feb 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YcX2Hr8k"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E993823D2;
	Wed,  7 Feb 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325483; cv=none; b=Wm2hRXAFtazbtxb8v3nnL6CXIFB5OzG/Qo0233e19Ddm4rSx3Z93iDmyEzBsKcLj8vAda0cOtCM70a15rsyVFq1R6e+sUWZoJ4tsWka/Me8AbdRzYYd8NYr0EcMYNKIfSlA0AiMu6gbdjYo5DpwnncrWOs9ube142b9bMM4diEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325483; c=relaxed/simple;
	bh=UAe3Tjz/2GSXNpvWb7cq2hSzhP7glws/o0rv/XCqYZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ES7feFUED+SOxaEKvlB5oyFBrOuc4bfUzXxf6k9Fc7B2nM5a5V8NwlCJNLmpHjQSucYQ0APgR2ncUVGE6ypJV3VwL9giu6nPU0Xd7+G7rWh22GyoyXV8v1g3HEwRV93lJ2cMwa6eCNuAe9FOw95k3mGOko0SYi5G7txT8DqthX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YcX2Hr8k; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417GOAbt021782;
	Wed, 7 Feb 2024 09:04:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=BupXfoLuUQFpPMCLq7WcLj4RS4BkfT7pIhSLbir0Fd4=; b=YcX
	2Hr8k5mNPS8zcb3m4l3Ozj33vfpLy1oKdqxLP475bd025317j4a6MOdUwUcsmRyT
	/b45Qk/DDWkwmXcWm//45b4P6TceEgjZxJAyDUZQ8bDCZogd+WtSzaIza4FLQ+Oh
	chE/hh2pDOcJ/JLrUm82K8ag418cFxPzOR9EMMEA083ePPaeqzInkqsDv0Eqr8/k
	KemNwSuEGvStlJ0mqbsHaQzipdGqdDsuNobjMgVmZwX1Mv/2GO5N+Kwy+3ffGFtk
	IXonVTF6+ybW/sgZQiCU429SxzOIbvfKjAGJEV1bg1h/VZ8aUkyKRNj4yK15oGoC
	U//aSJoWp/i2K4i73Ig==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w38u88edf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 09:04:39 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 7 Feb
 2024 09:04:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 7 Feb 2024 09:04:37 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 79E575E6872;
	Wed,  7 Feb 2024 09:04:35 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <huziji@marvell.com>, <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH 1/2] mmc: xenon: fix PHY init clock stability
Date: Wed, 7 Feb 2024 19:04:24 +0200
Message-ID: <20240207170425.478558-2-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240207170425.478558-1-enachman@marvell.com>
References: <20240207170425.478558-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eLsqMvuXhBdW4CBRLjB6D6IUbis2TMyX
X-Proofpoint-GUID: eLsqMvuXhBdW4CBRLjB6D6IUbis2TMyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_08,2024-02-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Each time SD/mmc phy is initialized, at times, in some of
the attempts, phy fails to completes its initialization
which results into timeout error. Per the HW spec, it is
a pre-requisite to ensure a stable SD clock before a phy
initialization is attempted.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 8cf3a375de65..4e99197b62c3 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -216,6 +216,24 @@ static int xenon_alloc_emmc_phy(struct sdhci_host *host)
 	return 0;
 }
 
+static int xenon_check_stability_internal_clk(struct sdhci_host *host)
+{
+	u32 reg;
+	ktime_t timeout;
+
+	/* Wait max 20 ms */
+	timeout = ktime_add_ms(ktime_get(), 20);
+	while (!((reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+		& SDHCI_CLOCK_INT_STABLE)) {
+		if (ktime_after(ktime_get(), timeout)) {
+			dev_err(mmc_dev(host->mmc), "phy_init: Internal clock never stabilized.\n");
+			return -ETIMEDOUT;
+		}
+		usleep_range(900, 1100);
+	}
+	return 0;
+}
+
 /*
  * eMMC 5.0/5.1 PHY init/re-init.
  * eMMC PHY init should be executed after:
@@ -232,6 +250,11 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
 	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
 
+	int ret = xenon_check_stability_internal_clk(host);
+
+	if (ret)
+		return ret;
+
 	reg = sdhci_readl(host, phy_regs->timing_adj);
 	reg |= XENON_PHY_INITIALIZAION;
 	sdhci_writel(host, reg, phy_regs->timing_adj);
-- 
2.25.1


