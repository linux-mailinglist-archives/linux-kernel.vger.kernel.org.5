Return-Path: <linux-kernel+bounces-87917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3A486DB0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB7B1C22352
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FFA51C2C;
	Fri,  1 Mar 2024 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JgH7ppQK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BFD5026D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709270792; cv=none; b=KzggwBK+pMmEGVk+/9VGPkoPuuvi1bu27ggK4F99/+cO/6RjJpYUpTP87Wb5IeFkz9oOCGOxVVlB9+pU+mAFu6QNMWCcXeKF6J/UOBycdiz6ZdEVk035j81r3TA3bLqOV4dOCim07ITBAcQKen4STItrhDODbknicqh9iK1QDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709270792; c=relaxed/simple;
	bh=EJ7HICHgLilFrtLK8BajK1eVr4wt6O4I9e6krZgg5WE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnttEXgtIodD3XV9Sao1IHCcLcYF58ede2GVQ2vaSE9K9VyYLmVu1CZ2OyB2eqPDetVTZHo+xRNKD7vo4t+7pXqZvNDEeWV293TnNlsX83i6+O+oSyatoEzPV+l44MnnGA1x0M8pofCn22nZoZjtqD0apWyTyvVk44Fczs2i4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JgH7ppQK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709270791; x=1740806791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EJ7HICHgLilFrtLK8BajK1eVr4wt6O4I9e6krZgg5WE=;
  b=JgH7ppQKn7Fj5UFWMnh9BfTsRfht2jzjT75qpGega+efQO9W1+L2+EBu
   M3gsZgLb/Hg0YdpM1KHJ8luTFdrhvjYI0rFWtxrIQ1LfSTz7qr50HsRap
   6U3yFdzU9yIFm6kH2A7vyGIhsBlRB+L3+4WCOLhvt+H0lkHDWj2ntTOKX
   uNsAVj5CshUWP7nNnizqnA23hBnPTquKugSiXwKh3hh6ZgZRTFYcAtFms
   o16XNR1v8u1y9ZUKRGkgtURTkCInKllRB2JhIsWBl0IjyDWnvhZHIYV1/
   cm1UNKFOZCo9qls1lQwL3lyQnt9Nb7JTMF/vg4SdyHM8OPCNuJluE4lmb
   w==;
X-CSE-ConnectionGUID: epEW2Y4BQQKheh4DRATFNw==
X-CSE-MsgGUID: KupV2im5SROLBogtWp8nUw==
X-IronPort-AV: E=Sophos;i="6.06,195,1705388400"; 
   d="scan'208";a="247809239"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 22:26:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 22:26:19 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 22:26:11 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <Hari.PrasathGE@microchip.com>, <Balamanikandan.Gunasundar@microchip.com>,
	<Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
	<Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
	<Balakrishnan.S@microchip.com>, <Charan.Pedumuru@microchip.com>, "Manikandan
 Muralidharan" <manikandan.m@microchip.com>
Subject: [PATCH v9 3/8] drm: atmel_hlcdc: replace regmap_read with regmap_read_poll_timeout
Date: Fri, 1 Mar 2024 10:55:29 +0530
Message-ID: <20240301052534.38651-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301052534.38651-1-manikandan.m@microchip.com>
References: <20240301052534.38651-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Replace regmap_read with regmap_read_poll_timeout to neatly handle
retries

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 44 +++++++++++--------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index cc5cf4c2faf7..b229692a27ca 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -203,19 +203,22 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
 	pm_runtime_get_sync(dev->dev);
 
 	regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_DISP);
-	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
-	       (status & ATMEL_HLCDC_DISP))
-		cpu_relax();
+	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
+				     !(status & ATMEL_HLCDC_DISP),
+				    10, 1000))
+		dev_warn(dev->dev, "Atmel LCDC status register DISPSTS timeout\n");
 
 	regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_SYNC);
-	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
-	       (status & ATMEL_HLCDC_SYNC))
-		cpu_relax();
+	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
+				     !(status & ATMEL_HLCDC_SYNC),
+				    10, 1000))
+		dev_warn(dev->dev, "Atmel LCDC status register LCDSTS timeout\n");
 
 	regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_PIXEL_CLK);
-	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
-	       (status & ATMEL_HLCDC_PIXEL_CLK))
-		cpu_relax();
+	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
+				     !(status & ATMEL_HLCDC_PIXEL_CLK),
+				    10, 1000))
+		dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
 
 	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
 	pinctrl_pm_select_sleep_state(dev->dev);
@@ -241,20 +244,23 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 	clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
 
 	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_PIXEL_CLK);
-	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
-	       !(status & ATMEL_HLCDC_PIXEL_CLK))
-		cpu_relax();
-
+	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
+				     status & ATMEL_HLCDC_PIXEL_CLK,
+				     10, 1000))
+		dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
 
 	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_SYNC);
-	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
-	       !(status & ATMEL_HLCDC_SYNC))
-		cpu_relax();
+	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
+				     status & ATMEL_HLCDC_SYNC,
+				     10, 1000))
+		dev_warn(dev->dev, "Atmel LCDC status register LCDSTS timeout\n");
 
 	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_DISP);
-	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
-	       !(status & ATMEL_HLCDC_DISP))
-		cpu_relax();
+	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
+				     status & ATMEL_HLCDC_DISP,
+				     10, 1000))
+		dev_warn(dev->dev, "Atmel LCDC status register DISPSTS timeout\n");
+
 
 	pm_runtime_put_sync(dev->dev);
 
-- 
2.25.1


