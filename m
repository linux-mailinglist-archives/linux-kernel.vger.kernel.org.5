Return-Path: <linux-kernel+bounces-71300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AF985A325
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3371F2558A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226B52E414;
	Mon, 19 Feb 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FU4/egJ2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="J2+oV1ZK"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB702D04A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345507; cv=none; b=hbu6Ps/r2p8zwGODd+8ol3vhV/DcRfAUWTcrKVsHo7pGub92EtsicAz8b31ZbLaBYiZkZmnwDPDkkyMFsq9U6MOF3So7fbh0PPL+mtF/YFAIVBEr3w7FpVAxqJu+I/wrATZI9NW/qGKVm0cNNx/b+cNGOyLtyZW3iY+/+nSOVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345507; c=relaxed/simple;
	bh=+pYIYMQ0DspgqfvQGmuBoGrq9uHeRjxrkdW45I0jm3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djGdPvSMggOx/+dPs5q013vNjmfptQivdUt9GqRblqLj5pXQp6L2lkMrdKp+atzzr1uAK/WoaAscI6gALdHk0LvLr3LM8ngiRjb9tTjYyqFb5FDonSqhJEs5UjDr58xc7Ft2nRy1qWnsSH+KqrKKPzP6KWDxA2xAo/xh/G2B2gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FU4/egJ2; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=J2+oV1ZK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708345505; x=1739881505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ih/v3JlPgjnunjeMXetvHkaR0ZTTwffvOCV3Ri/27Bg=;
  b=FU4/egJ2RCGYmToGwKV1tQe6KvA5MzrXNKKecXnFAm7QduX/SEyMMc+6
   HJpyOhr23sUbHOvbu41N3p6lJcWkGxZVqaz/kajDi6i0jT9ggF45v5Ivb
   DXGUzZVFbK0iI3UnJ3jHQJH4e33sC94XKk/2m3Vwcpru9AXjuThhLi8LW
   wAK0Pfho0yiymL/QRn//3qpddK5axKrBTDfy9XmRxpoNxl6T+ETic4yiV
   kzKV/feEZ4DKxg2tIigotIau0lu6ylvj6ck5+9CQm0zJGnidpszzsWw4I
   Ikmgl8zelI7wMbd7CqmsX6O7uBM9yepp45nwOiSeFQR5mKcakUdJg+KHj
   A==;
X-IronPort-AV: E=Sophos;i="6.06,170,1705359600"; 
   d="scan'208";a="35475552"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Feb 2024 13:25:02 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CA3D16F763;
	Mon, 19 Feb 2024 13:24:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1708345498; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ih/v3JlPgjnunjeMXetvHkaR0ZTTwffvOCV3Ri/27Bg=;
	b=J2+oV1ZKOKLcn/qz2bJ4YrrX7urblOuYeRkmuWrGrDbzdB83S6EHxLju7VhlxI1o9gdH4P
	gOPTG5kfX1mapEHgwI8olPJSvd6Sa8WK+dLdHrcsR4q1ZPV4ufqTOyRTH4F/2Fc7bBGOtp
	mI+xwz2RrdckbZnKGrEnvt99ogvYyCo/e9XZYaHDKlmkXFtvDbWn3gdKnr7J3LmD3tfyq9
	/5J2Ntk5yfaIdHw3vH/gxNUBr+G+1I7A88E6eom7g6dsY1DzEVdHekMeyS7jtj2NHDeYGZ
	IESZMabRoKToR7tODX+CySpQCeTl4bWR9MQVyqyMFQOglcj+IK+omsmIptYlFg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [RESEND 2/2] drm: fsl-dcu: enable PIXCLK on LS1021A
Date: Mon, 19 Feb 2024 13:24:49 +0100
Message-Id: <20240219122449.3083748-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219122449.3083748-1-alexander.stein@ew.tq-group.com>
References: <20240219122449.3083748-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

The PIXCLK needs to be enabled in SCFG before accessing certain DCU
registers, or the access will hang.

Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/fsl-dcu/Kconfig           |  1 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 14 ++++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
index 5ca71ef87325..c9ee98693b48 100644
--- a/drivers/gpu/drm/fsl-dcu/Kconfig
+++ b/drivers/gpu/drm/fsl-dcu/Kconfig
@@ -8,6 +8,7 @@ config DRM_FSL_DCU
 	select DRM_PANEL
 	select REGMAP_MMIO
 	select VIDEOMODE_HELPERS
+	select MFD_SYSCON if SOC_LS1021A
 	help
 	  Choose this option if you have an Freescale DCU chipset.
 	  If M is selected the module will be called fsl-dcu-drm.
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 90cbd18f096d..283858350961 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -100,12 +100,26 @@ static void fsl_dcu_irq_uninstall(struct drm_device *dev)
 static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 {
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct regmap *scfg;
 	int ret;
 
 	ret = fsl_dcu_drm_modeset_init(fsl_dev);
 	if (ret < 0)
 		return dev_err_probe(dev->dev, ret, "failed to initialize mode setting\n");
 
+	scfg = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
+	if (PTR_ERR(scfg) != -ENODEV) {
+		/*
+		 * For simplicity, enable the PIXCLK unconditionally. Disabling
+		 * the clock in PM or on unload could be implemented as a future
+		 * improvement.
+		 */
+		ret = regmap_update_bits(scfg, SCFG_PIXCLKCR, SCFG_PIXCLKCR_PXCEN,
+					SCFG_PIXCLKCR_PXCEN);
+		if (ret < 0)
+			return dev_err_probe(dev->dev, ret, "failed to enable pixclk\n");
+	}
+
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize vblank\n");
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
index e2049a0e8a92..566396013c04 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
@@ -160,6 +160,9 @@
 #define FSL_DCU_ARGB4444		12
 #define FSL_DCU_YUV422			14
 
+#define SCFG_PIXCLKCR			0x28
+#define SCFG_PIXCLKCR_PXCEN		BIT(31)
+
 #define VF610_LAYER_REG_NUM		9
 #define LS1021A_LAYER_REG_NUM		10
 
-- 
2.34.1


