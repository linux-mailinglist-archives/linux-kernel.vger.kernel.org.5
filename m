Return-Path: <linux-kernel+bounces-42553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016C0840309
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211881C21E96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C35823F;
	Mon, 29 Jan 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ORHdZknI"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C5658213
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524932; cv=none; b=F9b5Q1KK6ftvWcA1gbmJNCnHNRGOouzfyvsHAigV32RZljTGxCL5URvuH8wG50Ok1VQrcC1L+TZel6yl9ke5LkdpVlKkUUrnyIi8WztWdxtA6Dqwj33GTIXvuADCOnrt3G9SFsw7NjmbAO8XTNIgbQbyWUNOG9zPynSOFBOCzaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524932; c=relaxed/simple;
	bh=50doY6T1bUzczdoNYVXRJSOPytbWwVqA565aAlL2RJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flITDGK2mHXeJAJY5ZcOxiAwU+utseDnxJjQon49Ab3QEN0rkdlwgVotGSb+hu49BocHB5eT5smRllV3xDQKzqQx3sI4OcrtXByLw0nWxrBhsmNnlhJU0ogcrNwL/q9lYrJ8KHq143dx1EiZ+BYYZAHkMMqixv4IlkCOikToVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ORHdZknI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T61IUn024667;
	Mon, 29 Jan 2024 11:41:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=VZZBxcUbum7P76Wj0XWqOVN7boKS0FAnpWW8U/8QDpY=; b=OR
	HdZknIHnuTRsFpoFNXp/G9bOUiAU2TUAZ3mvJx8Rsl5GklBXg6qHgLf9alEW6dTd
	WenpXECMdU0N1NcvRUdQxCiP7nqsVM6UdmlDPD4NQIn1FWKdYsqJMLuezJkEq5T1
	6DpghvSvDxJGgttWWgUtYWYu+rCqu68lUeIs5YGHp80PGzfGxdcunqCI8okFbuCI
	Jm3RyRvXZ0BrpFUVkhJ6i/1ahyCpcm968WC5Pmv9JhwcCJW2VCwg2SWLvAD8yUxt
	hQR7AHJhcSLMYR93p7uTlyitBLkRDfSfKlPRtzrG2ieC7NdEwAgaf/fDEqNmPpcq
	9pW7BMouEd/K6L0ujeAg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vwdnnm2y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 11:41:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0471A100058;
	Mon, 29 Jan 2024 11:41:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E70BD216832;
	Mon, 29 Jan 2024 11:41:17 +0100 (CET)
Received: from localhost (10.252.28.37) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 29 Jan
 2024 11:41:17 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 2/3] drm/stm: dsi: add pm runtime ops
Date: Mon, 29 Jan 2024 11:41:05 +0100
Message-ID: <20240129104106.43141-3-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129104106.43141-1-raphael.gallais-pou@foss.st.com>
References: <20240129104106.43141-1-raphael.gallais-pou@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-29_01,2023-05-22_02

From: Yannick Fertre <yannick.fertre@foss.st.com>

Update control of clocks and supply thanks to the PM runtime
mechanism to avoid kernel crash during a system suspend.

Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
Changes in v2:
	- Changed SET_RUNTIME_PM_OPS to RUNTIME_PM_OPS and removed
	__maybe_unused
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index b1aee43d51e9..82fff9e84345 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -11,6 +11,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
 #include <video/mipi_display.h>
@@ -77,6 +78,7 @@ enum dsi_color {
 struct dw_mipi_dsi_stm {
 	void __iomem *base;
 	struct clk *pllref_clk;
+	struct clk *pclk;
 	struct dw_mipi_dsi *dsi;
 	u32 hw_version;
 	int lane_min_kbps;
@@ -443,7 +445,6 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_mipi_dsi_stm *dsi;
-	struct clk *pclk;
 	int ret;
 
 	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
@@ -483,21 +484,21 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
 		goto err_clk_get;
 	}
 
-	pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(pclk)) {
-		ret = PTR_ERR(pclk);
+	dsi->pclk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(dsi->pclk)) {
+		ret = PTR_ERR(dsi->pclk);
 		DRM_ERROR("Unable to get peripheral clock: %d\n", ret);
 		goto err_dsi_probe;
 	}
 
-	ret = clk_prepare_enable(pclk);
+	ret = clk_prepare_enable(dsi->pclk);
 	if (ret) {
 		DRM_ERROR("%s: Failed to enable peripheral clk\n", __func__);
 		goto err_dsi_probe;
 	}
 
 	dsi->hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
-	clk_disable_unprepare(pclk);
+	clk_disable_unprepare(dsi->pclk);
 
 	if (dsi->hw_version != HWVER_130 && dsi->hw_version != HWVER_131) {
 		ret = -ENODEV;
@@ -551,6 +552,7 @@ static int dw_mipi_dsi_stm_suspend(struct device *dev)
 	DRM_DEBUG_DRIVER("\n");
 
 	clk_disable_unprepare(dsi->pllref_clk);
+	clk_disable_unprepare(dsi->pclk);
 	regulator_disable(dsi->vdd_supply);
 
 	return 0;
@@ -569,8 +571,16 @@ static int dw_mipi_dsi_stm_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(dsi->pclk);
+	if (ret) {
+		regulator_disable(dsi->vdd_supply);
+		DRM_ERROR("Failed to enable pclk: %d\n", ret);
+		return ret;
+	}
+
 	ret = clk_prepare_enable(dsi->pllref_clk);
 	if (ret) {
+		clk_disable_unprepare(dsi->pclk);
 		regulator_disable(dsi->vdd_supply);
 		DRM_ERROR("Failed to enable pllref_clk: %d\n", ret);
 		return ret;
@@ -582,6 +592,8 @@ static int dw_mipi_dsi_stm_resume(struct device *dev)
 static const struct dev_pm_ops dw_mipi_dsi_stm_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(dw_mipi_dsi_stm_suspend,
 			    dw_mipi_dsi_stm_resume)
+	RUNTIME_PM_OPS(dw_mipi_dsi_stm_suspend,
+		       dw_mipi_dsi_stm_resume, NULL)
 };
 
 static struct platform_driver dw_mipi_dsi_stm_driver = {
-- 
2.25.1


