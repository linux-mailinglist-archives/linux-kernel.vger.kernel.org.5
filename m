Return-Path: <linux-kernel+bounces-56800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E22B684CF5B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47942B25B54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F2382899;
	Wed,  7 Feb 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jUCjXNXa"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62DF823CA;
	Wed,  7 Feb 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325483; cv=none; b=DGUW6oHHm6KUI3WSSfF8jjbpfO/uRe7v/Nj9f1feA7h6blLXmLn/F6RCYR3LSRgacT8xkbx1ezRpO6YiIvHLtYQPKC367gQJgRvYreesb//L6B5jmnXJvV+vyzrsMnCMfSP2AxTfepEnAPqK2mvbbe0J+NnlEG4W9DQDFUX0Jv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325483; c=relaxed/simple;
	bh=JALKc4ISj5QXqj8ZxhQzAeFYp2Gk1Tg9cy1aLChqG+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/bZT0bQS6s0MxawbNjHwzvY2iBHvGFKF9ZMC+rr14v5EFrpG/z/8Pn1UawH70kYtPPQIJJg7PtG9E6U0YDEFJ7MXx9gsW249zeF1c+CdNB5p2kzOeUmpx80UShgI6tRRfO6R449Z0DdVkv68MtsizdMy7S38YFwgP0iisnI/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jUCjXNXa; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417Bpj72031753;
	Wed, 7 Feb 2024 09:04:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=Juhy42j2iKDK9LY7bpXPn8t4rHNyPP+bAYrPjTI7bDg=; b=jUC
	jXNXaUt8+RafrZZS8gsC8J8IVlzcD5RRbSoPBpb2HqJr/drJeyhMpJGSr8TgVMnp
	6y/Aevy4erVr3eWhLIly0fp4drkMlHLftu/zxFmuAV1Ke82GmDNsOnZfu0cy2TkC
	O4mDsrmcKRvi0yqQbBLti6ZUx+Pdvt5GappFRbw2xLI3MV9/1GFAOGSwKThbn0nv
	27pQlCDFD8nM5iizInSzBNO3hJH73E8u6LhDCOwdIM3CxSw5v82QVkd+8xH4lDBf
	4DR69pH3S0CtsJB1NduUomvjVhdkhehHz8nKj6huw3MO8S0qWdAKT+2soxGwsmRl
	XyBxxukv2clWjNrU8lQ==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w46k7tkq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 09:04:40 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 7 Feb
 2024 09:04:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 7 Feb 2024 09:04:39 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 813A85E6870;
	Wed,  7 Feb 2024 09:04:37 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <huziji@marvell.com>, <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH 2/2] mmc: xenon: add timeout for PHY init complete
Date: Wed, 7 Feb 2024 19:04:25 +0200
Message-ID: <20240207170425.478558-3-enachman@marvell.com>
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
X-Proofpoint-ORIG-GUID: 8eXC_kRdVYf-7b5cAH5nsEFoT0Z3Pd5W
X-Proofpoint-GUID: 8eXC_kRdVYf-7b5cAH5nsEFoT0Z3Pd5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_08,2024-02-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

AC5X spec says PHY init complete bit must be polled until zero.
We see cases in which timeout can take longer than the standard
calculation on AC5X, which is expected following the spec comment above.
According to the spec, we must wait as long as it takes for that bit to
toggle on AC5X.
Cap that with 100 delay loops so we won't get stuck forever.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 31 ++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 4e99197b62c3..f551a9e31772 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -109,6 +109,8 @@
 #define XENON_EMMC_PHY_LOGIC_TIMING_ADJUST	(XENON_EMMC_PHY_REG_BASE + 0x18)
 #define XENON_LOGIC_TIMING_VALUE		0x00AA8977
 
+#define XENON_MAX_PHY_TIMEOUT_LOOPS		100
+
 /*
  * List offset of PHY registers and some special register values
  * in eMMC PHY 5.0 or eMMC PHY 5.1
@@ -244,7 +246,7 @@ static int xenon_check_stability_internal_clk(struct sdhci_host *host)
  */
 static int xenon_emmc_phy_init(struct sdhci_host *host)
 {
-	u32 reg;
+	u32 reg, retry;
 	u32 wait, clock;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
@@ -282,14 +284,31 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
 	/* get the wait time */
 	wait /= clock;
 	wait++;
-	/* wait for host eMMC PHY init completes */
-	udelay(wait);
 
-	reg = sdhci_readl(host, phy_regs->timing_adj);
-	reg &= XENON_PHY_INITIALIZAION;
+	/*
+	 * AC5X spec says bit must be polled until zero.
+	 * We see cases in which timeout can take longer
+	 * than the standard calculation on AC5X, which is
+	 * expected following the spec comment above.
+	 * According to the spec, we must wait as long as
+	 * it takes for that bit to toggle on AC5X.
+	 * Cap that with 100 delay loops so we won't get
+	 * stuck here forever:
+	 */
+
+	retry = XENON_MAX_PHY_TIMEOUT_LOOPS;
+
+	do {
+		/* wait for host eMMC PHY init completes */
+		udelay(wait);
+
+		reg = sdhci_readl(host, phy_regs->timing_adj);
+		reg &= XENON_PHY_INITIALIZAION;
+	} while (reg && retry--);
+
 	if (reg) {
 		dev_err(mmc_dev(host->mmc), "eMMC PHY init cannot complete after %d us\n",
-			wait);
+			wait * XENON_MAX_PHY_TIMEOUT_LOOPS);
 		return -ETIMEDOUT;
 	}
 
-- 
2.25.1


