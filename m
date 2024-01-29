Return-Path: <linux-kernel+bounces-42555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924AE84030B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9C02828A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E97258ABD;
	Mon, 29 Jan 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Gg/+p5iM"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E158217
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524933; cv=none; b=pznW2x0Li2+LYeQgtkrfCCyw3hj1LnsXRtsVi3/ds0Re1nrVnZn2DVSb+Z7uG8m+UFRdwuvPDU+lZRWVGKHMiqV4BSCXKmnwY9b5+pcAsa8lZNY/I/5fhyCb+K7X1ehHpBkiBtJn14c5oCamT1yKlQnSOW1Vc+s41y6XB2yheWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524933; c=relaxed/simple;
	bh=cymToVl/T5Yi9HehNQ95mgHhDIYusz6zpE2uo5Styhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYMcVZhDDes/umVZhGD7dDG7DZA+orhQIUlKmy+Euinr7apMLXnM1hawULuwDmpQKpS3gkPwRoo3AHlAqoKEoviVUGE9VzwgDtrLKpgSQn0gFtJUCQnDv6P0cNT/5lsUfWiExolbPQRuh5xZaQF4v8L88rnu5ABbcJ5fdY8wSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Gg/+p5iM; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T61Eh1004842;
	Mon, 29 Jan 2024 11:41:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=uxlxZGGWiCK9ukUifKVDu5ceC0YPpoymX4MhiItDcpE=; b=Gg
	/+p5iMgUrTaGxRwwzg8NlPbIAerP7E8cISQoELZMJc7bm+UUSDlYXHWzoDCNQTUd
	ipWku2L75D+TaPQDzCVetkVrQ/M3ZoZY9WfzZAB2RUbQwxOjb7u1DusY7CDQUuih
	NVZ/zZo0ic0mvX9WstNhvoMFVlqQH5JEvGEVQDH5lb9MAMuOo3QlLE8/skVR0CWq
	v7uZ6sbIU+3etG2+uZW/rwJBNaHX8vQEqwiH2iKE0qoR237L2lN4NzS7Ake/GXCi
	I/48mToYuR/YOS1nIiHngU9yMu4fW7uUi/vyywUe4om//exR54KoEBge636jQP4o
	yXGntVs7gGjHy3D0EEWQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vvr4kpn7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 11:41:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0D75E10005A;
	Mon, 29 Jan 2024 11:41:18 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0609F216837;
	Mon, 29 Jan 2024 11:41:18 +0100 (CET)
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
Subject: [PATCH RESEND v3 1/3] drm/stm: dsi: use new SYSTEM_SLEEP_PM_OPS() macro
Date: Mon, 29 Jan 2024 11:41:04 +0100
Message-ID: <20240129104106.43141-2-raphael.gallais-pou@foss.st.com>
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

Use RUNTIME_PM_OPS() instead of the old SET_SYSTEM_SLEEP_PM_OPS().
This means we don't need  __maybe_unused on the functions.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index d5f8c923d7bc..b1aee43d51e9 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -544,7 +544,7 @@ static void dw_mipi_dsi_stm_remove(struct platform_device *pdev)
 	regulator_disable(dsi->vdd_supply);
 }
 
-static int __maybe_unused dw_mipi_dsi_stm_suspend(struct device *dev)
+static int dw_mipi_dsi_stm_suspend(struct device *dev)
 {
 	struct dw_mipi_dsi_stm *dsi = dw_mipi_dsi_stm_plat_data.priv_data;
 
@@ -556,7 +556,7 @@ static int __maybe_unused dw_mipi_dsi_stm_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused dw_mipi_dsi_stm_resume(struct device *dev)
+static int dw_mipi_dsi_stm_resume(struct device *dev)
 {
 	struct dw_mipi_dsi_stm *dsi = dw_mipi_dsi_stm_plat_data.priv_data;
 	int ret;
@@ -580,8 +580,8 @@ static int __maybe_unused dw_mipi_dsi_stm_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops dw_mipi_dsi_stm_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dw_mipi_dsi_stm_suspend,
-				dw_mipi_dsi_stm_resume)
+	SYSTEM_SLEEP_PM_OPS(dw_mipi_dsi_stm_suspend,
+			    dw_mipi_dsi_stm_resume)
 };
 
 static struct platform_driver dw_mipi_dsi_stm_driver = {
-- 
2.25.1


