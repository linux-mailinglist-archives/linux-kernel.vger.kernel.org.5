Return-Path: <linux-kernel+bounces-156313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025D8B0117
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728731C2247C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080D156962;
	Wed, 24 Apr 2024 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kBDyZ0Ml"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E871156671
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936913; cv=none; b=IQ1+loV4y5iNl9JrA+ZASu01yVdH/1FaswsLdaIOrXe4ZCUK8ZwrcONQpeabZyVJhJW0gMO1LnYyHtTHKM+3EywNx81S8Q/PtPL02WAQvrwCy3EC4eVLGJeWanRraC377T/ZgwhiP+Wsc1ihEaI3VTwyYrFdb1e6TaxSxNOxZmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936913; c=relaxed/simple;
	bh=EJ7HICHgLilFrtLK8BajK1eVr4wt6O4I9e6krZgg5WE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuPz/c+Y/Ij2RJ0gEaBVptUPUBsdTWlxbv1ryQ7DAeOy9u4OhUW39DLPEEgXN0roBbs/whhrc3feNCKgPCb9MwK+XEp/Cu0WrPazI2eNymXhX+7EnIpVj7moLz48jbmwEHLOiiT/uFK6/fz2+OEnqUsuYRl0cisD1K7D3519f1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kBDyZ0Ml; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713936912; x=1745472912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EJ7HICHgLilFrtLK8BajK1eVr4wt6O4I9e6krZgg5WE=;
  b=kBDyZ0Mlm28T8L9F5DwJqGWyuqkX5HwKSovV9ou8iyUjtz6BHFvgVNx7
   xRO4bkzI49TDN2f9Z6l+ZOkZZwnXjc0A2AFqfokea1vWfEZgQMUl024fc
   sU6jAeYbLo+0SJ0vgn3FmEG/idJrT+KMEeAJiXCoEo5twfX6knF9j1ufX
   7728+88QIAOr0RTLaAq3z4sXIdzcosibHwe/EhqGbwoISGQHAbDYbSUa3
   7B68dhbuoEVyLSA2Jpuv6AYvFiRgIbBPtpio3ttQS2PCD7dDiFK0tkTso
   4rwiVzrgWvF9LKd7Vh3WkIE3uenA7EkyfBlMUzUnG2YnJ42/+EnVLwyI5
   w==;
X-CSE-ConnectionGUID: cS45O937TrSqQ6qvvirFaA==
X-CSE-MsgGUID: pHqPswsEQ4y0P+i2vFp7IQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708412400"; 
   d="scan'208";a="22977482"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 22:35:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 22:34:50 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 22:34:40 -0700
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
Subject: [PATCH RESEND v9 3/8] drm: atmel_hlcdc: replace regmap_read with regmap_read_poll_timeout
Date: Wed, 24 Apr 2024 11:03:46 +0530
Message-ID: <20240424053351.589830-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424053351.589830-1-manikandan.m@microchip.com>
References: <20240424053351.589830-1-manikandan.m@microchip.com>
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


