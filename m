Return-Path: <linux-kernel+bounces-77390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D48604AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AA91C23ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5BB73F28;
	Thu, 22 Feb 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G28T/Rh/"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3F14B832;
	Thu, 22 Feb 2024 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636940; cv=none; b=KjECv/kgUGUxPECtgXPqJxhtH9//evjoaoEsX5OjQaNKua3CEIMn1RGcJoS9GEPNrOC9Yy/sse2rlO8yJLOr2dkZrQPqGCbf6NtCGanAh/hhbKA1c9CNcyO48d+P2bgylTo6mz+qWU7dHD3kDEC3c3GhJzjBR9F+Mg+nlMpVtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636940; c=relaxed/simple;
	bh=OEjaR8q/hH/zJzrJq00dzosvg9sB+rc7P5n3BrRx+nE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mh0Srk989n+37nkqsiN1d/epeUiqpAzTdhUiznzrYXk31BhdPdePsO6boBXXGM1QsyvFeGBAG7Qh4ux28UCvHhYquJauTyoq4iN3l4oYSMGHUa3I7m++hG6QUUJpACol7FC3s/ceeHJK+zpv6XzHRC/NcbWKO64pNMYxzE2ONEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=G28T/Rh/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41ML8XqH001858;
	Thu, 22 Feb 2024 13:22:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=y6gHklRy6mgfq/+kDFgxdQdIm96X6dvMx3GA+sAwVL0=; b=G28
	T/Rh/5lpdK2wQ58rXcKy496aSLJn+3ZySP09j9o/U7PeJx8eYNp4tz31OXS8N/zv
	ct6EW5YoW8JOBoLupWif90oLn8oQ+Hz9636tzo36G2o3awYFuoakYVWCSR9H1xXj
	g+eUfMMRHrdZxtiKJEp2qQ48R2DMWRfqOWBLCfe+EtapT7PjNWOcnvH++vHdq58e
	4oPaTHdrK7t+H9m/4y+t6CrrOUhaQ5sXEufeJ3CqBLgRi9vqCdYrdikANxmQgHYz
	X3Bwfy4CrWEZFsfMaW6r7W8hg8Qaw0sVreGOQkqGfd100kmlEwGE/g0L7C6LZ8Kw
	iWUgiqyF10HGuMVND2Q==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wedwxg1bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 13:22:09 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 22 Feb
 2024 13:22:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 22 Feb 2024 13:22:07 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 794AE3F719F;
	Thu, 22 Feb 2024 11:17:23 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <huziji@marvell.com>, <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 1/2] mmc: xenon: fix PHY init clock stability
Date: Thu, 22 Feb 2024 21:17:13 +0200
Message-ID: <20240222191714.1216470-2-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222191714.1216470-1-enachman@marvell.com>
References: <20240222191714.1216470-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bYNSWMlj2hCJ90jrCB0PWeMEwubrjedi
X-Proofpoint-ORIG-GUID: bYNSWMlj2hCJ90jrCB0PWeMEwubrjedi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Each time SD/mmc phy is initialized, at times, in some of
the attempts, phy fails to completes its initialization
which results into timeout error. Per the HW spec, it is
a pre-requisite to ensure a stable SD clock before a phy
initialization is attempted.

Fixes: 06c8b667ff5b ("mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 8cf3a375de65..c3096230a969 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/iopoll.h>
 #include <linux/of_address.h>
 
 #include "sdhci-pltfm.h"
@@ -216,6 +217,19 @@ static int xenon_alloc_emmc_phy(struct sdhci_host *host)
 	return 0;
 }
 
+static int xenon_check_stability_internal_clk(struct sdhci_host *host)
+{
+	u32 reg;
+	int err;
+
+	err = read_poll_timeout(sdhci_readw, reg, reg & SDHCI_CLOCK_INT_STABLE,
+				1100, 20000, false, host, SDHCI_CLOCK_CONTROL);
+	if (err)
+		dev_err(mmc_dev(host->mmc), "phy_init: Internal clock never stabilized.\n");
+
+	return err;
+}
+
 /*
  * eMMC 5.0/5.1 PHY init/re-init.
  * eMMC PHY init should be executed after:
@@ -232,6 +246,11 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
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


