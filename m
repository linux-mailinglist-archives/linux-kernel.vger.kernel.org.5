Return-Path: <linux-kernel+bounces-67298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A849085695B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAECB1C23D62
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9369134721;
	Thu, 15 Feb 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LGagqFPU"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC143134CE5;
	Thu, 15 Feb 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013792; cv=none; b=dEAEXv2qrP+1VnjUGHLBZAc4sI3pqhcuNf3XC1Qn78wj4wiv/6ZSG+3xsx0bSA/lguAil/RgM9p6vusY6CNqqkEMgijje9bltU164KT6+qGH6eisxfe7EZ0kHY+cXC3/fgQtwODL7qngDhnXV00+DZm90a/yCN/4xwkv61CrInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013792; c=relaxed/simple;
	bh=sxn7UvNEBwbljcxUhLwE3xC0K2n3sgRbv9rYziqHTh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1gmV7VhDcmtlf/RpSR1irMRxCk2cH7fq6Rb02cxRmCy/6BE86gvh+c3/n+9MFgX+s9aBWtO/8W+QYb80y+7q2++S3J7QkJOMpMeLKLo1p46YQqiDo3qyK4EKbtBPjtAQtr9sMP2k3Ol5pbSXQ0wvJp4e5ekj+wpl38MSmqZ7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LGagqFPU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FCk83l026995;
	Thu, 15 Feb 2024 08:16:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=q4P5OHmYn080DFP0oyNUcqHRE5wGOZYP+WFeEgOmAgY=; b=LGa
	gqFPUBOgstb+/dxfpSmFAvULiXVz79ve9YkWjuY0kYH4ndfGKfVbVdphXY0QW5q6
	K9WbaCfZot114PQcUuxs8w6YOXf5EEbhHx6VFRGaQ1XddC6NzqHVhv/dEmhz5Dp2
	o0jftu9T8yfEiYjlqATb+13fM1XvaWuBE9PX/n5GkWtTbcoorB30MoZiFRbepGct
	l1v12vLSXkrJWC/rSoq90CdnNtUUg+5nlDhpc3IoAKxQrjS3uqa0jZ3WyGU7vOAp
	9rJvx4iDSvMBgigLuwVFDMRgMOy24us/FfkJdT/xNR1OEF5QPn65Ln2zJat08Yd3
	X6FHPCmKLv6sgbShg0A==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w9jw98uux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 08:16:23 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 15 Feb
 2024 08:16:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 15 Feb 2024 08:16:21 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 9BD893F7095;
	Thu, 15 Feb 2024 08:16:19 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <huziji@marvell.com>, <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 2/2] mmc: xenon: add timeout for PHY init complete
Date: Thu, 15 Feb 2024 18:16:13 +0200
Message-ID: <20240215161613.1736051-3-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215161613.1736051-1-enachman@marvell.com>
References: <20240215161613.1736051-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qAKbCKW2zkABzLMFkT03CAb1U7QXl2UQ
X-Proofpoint-ORIG-GUID: qAKbCKW2zkABzLMFkT03CAb1U7QXl2UQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_15,2024-02-14_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

AC5X spec says PHY init complete bit must be polled until zero.
We see cases in which timeout can take longer than the standard
calculation on AC5X, which is expected following the spec comment above.
According to the spec, we must wait as long as it takes for that bit to
toggle on AC5X.
Cap that with 100 delay loops so we won't get stuck forever.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index c3096230a969..cc9d28b75eb9 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -110,6 +110,8 @@
 #define XENON_EMMC_PHY_LOGIC_TIMING_ADJUST	(XENON_EMMC_PHY_REG_BASE + 0x18)
 #define XENON_LOGIC_TIMING_VALUE		0x00AA8977
 
+#define XENON_MAX_PHY_TIMEOUT_LOOPS		100
+
 /*
  * List offset of PHY registers and some special register values
  * in eMMC PHY 5.0 or eMMC PHY 5.1
@@ -278,18 +280,27 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
 	/* get the wait time */
 	wait /= clock;
 	wait++;
-	/* wait for host eMMC PHY init completes */
-	udelay(wait);
 
-	reg = sdhci_readl(host, phy_regs->timing_adj);
-	reg &= XENON_PHY_INITIALIZAION;
-	if (reg) {
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
+	ret = read_poll_timeout(sdhci_readl, reg,
+				!(reg & XENON_PHY_INITIALIZAION),
+				wait, XENON_MAX_PHY_TIMEOUT_LOOPS * wait,
+				false, host, phy_regs->timing_adj);
+	if (ret)
 		dev_err(mmc_dev(host->mmc), "eMMC PHY init cannot complete after %d us\n",
-			wait);
-		return -ETIMEDOUT;
-	}
+			wait * XENON_MAX_PHY_TIMEOUT_LOOPS);
 
-	return 0;
+	return ret;
 }
 
 #define ARMADA_3700_SOC_PAD_1_8V	0x1
-- 
2.25.1


