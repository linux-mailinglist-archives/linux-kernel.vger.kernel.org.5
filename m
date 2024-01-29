Return-Path: <linux-kernel+bounces-42442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29116840168
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D971C28377C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1654FB0;
	Mon, 29 Jan 2024 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uejHdtpo"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940D55C29
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520324; cv=none; b=R5rgfyRbkm93pZjJ+ckHeRK9rbFSwd7QOuT4nRPy40m/SRWgiUATktn9Fb3XTgAixqStO5IvXZ04nTXql8jwumxJizsK4tmVVmcZdtgNAfYacxTC3s4cJPuG7k9HsPS8tsITUxwCRtjNCl/p17cu90KKsdc/8hOoSZGQMWbtqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520324; c=relaxed/simple;
	bh=mMnkreHa1sbG2ukp0/nqtMlRYNpdytaqUwbayQT5CLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggsvz/qwzXu86CqJ/RgXBM1OoP9e/GAAb49OQYTGd2u2j37SZOGfwbMpyt8zTsfEYocN+2/9dnAoJzCCGLee/qHXP6XDvvW1fIQfwyej76aARTvXDuimA817AEmAfk8KHSrqE1gcAz0QZU1zae3M9+ZzoZd+DaQdhyS5tocoPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uejHdtpo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706520320; x=1738056320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mMnkreHa1sbG2ukp0/nqtMlRYNpdytaqUwbayQT5CLI=;
  b=uejHdtpouTh4nXlIRJiCb5hcQxxcVM0MSgu7GZh4NMVaM3smCseBcVCz
   bGFgOWGELKm9FhUAWZ5lcbUwUae8i1GW5iJKzuB+X/jK8EPfQR0m9Bhhl
   wYdaJbTd14cF+5GO1g5g8oqEkUP/3fcJCYSzoEuzgxKk5Rl2vBbnxxyrz
   xyFI6t1cUO92fHg5zN92loHZFSWtlx0yDjp2dk6oMaFlaU9SVzkY87ilL
   pyxFNykx3mUQk9YPmkA/ld/6VEJioLA1IHc1xZrSTApuGl4BGbXRZWmSM
   Ts8YkViHDBwRHBISK/hQOP3pWuVmWchUF4hA4yuUQCbu9QvkYxBQKdYp5
   A==;
X-CSE-ConnectionGUID: TEL7vlM3T66VQyW0vmOUQQ==
X-CSE-MsgGUID: pgdB0o8DQIqIyD1M9YOA8g==
X-IronPort-AV: E=Sophos;i="6.05,226,1701154800"; 
   d="scan'208";a="182680009"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2024 02:25:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 02:25:11 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 02:25:05 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<lee@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <Hari.PrasathGE@microchip.com>, <Balamanikandan.Gunasundar@microchip.com>,
	<Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
	<Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
	<Balakrishnan.S@microchip.com>, Manikandan Muralidharan
	<manikandan.m@microchip.com>
Subject: [PATCH RESEND v7 6/7] drm: atmel-hlcdc: add vertical and horizontal scaling support for XLCDC
Date: Mon, 29 Jan 2024 14:53:18 +0530
Message-ID: <20240129092319.199365-7-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129092319.199365-1-manikandan.m@microchip.com>
References: <20240129092319.199365-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the LCDC_HEOCFG30 and LCDC_HEOCFG31 registers of XLCDC IP which
supports vertical and horizontal scaling with Bilinear and Bicubic
co-efficients taps for Chroma and Luma componenets of the Pixel.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  2 ++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  4 ++++
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 20 +++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 18a3a95f94be..debd4bf3e1b0 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -541,6 +541,8 @@ static const struct atmel_hlcdc_layer_desc atmel_xlcdc_sam9x75_layers[] = {
 			.general_config = 12,
 			.csc = 16,
 			.scaler_config = 23,
+			.vxs_config = 30,
+			.hxs_config = 31,
 		},
 		.clut_offset = 0x1300,
 	},
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 1ef15f2d536c..216beaf1da0e 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -198,6 +198,8 @@
  * @disc_pos: discard area position register
  * @disc_size: discard area size register
  * @csc: color space conversion register
+ * @vxs_config: vertical scalar filter taps control register
+ * @hxs_config: horizontal scalar filter taps control register
  */
 struct atmel_hlcdc_layer_cfg_layout {
 	int xstride[ATMEL_HLCDC_LAYER_MAX_PLANES];
@@ -217,6 +219,8 @@ struct atmel_hlcdc_layer_cfg_layout {
 	int disc_pos;
 	int disc_size;
 	int csc;
+	int vxs_config;
+	int hxs_config;
 };
 
 struct atmel_hlcdc_plane_state;
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 59ddd743ce92..a527badf865d 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -966,6 +966,26 @@ static void xlcdc_csc_init(struct atmel_hlcdc_plane *plane,
 					    desc->layout.csc + i,
 					    xlcdc_csc_coeffs[i]);
 	}
+
+	if (desc->layout.vxs_config && desc->layout.hxs_config) {
+		/*
+		 * Updating vxs.config and hxs.config fixes the
+		 * Green Color Issue in SAM9X7 EGT Video Player App
+		 */
+		atmel_hlcdc_layer_write_cfg(&plane->layer,
+					    desc->layout.vxs_config,
+					    ATMEL_XLCDC_LAYER_VXSYCFG_ONE |
+					    ATMEL_XLCDC_LAYER_VXSYTAP2_ENABLE |
+					    ATMEL_XLCDC_LAYER_VXSCCFG_ONE |
+					    ATMEL_XLCDC_LAYER_VXSCTAP2_ENABLE);
+
+		atmel_hlcdc_layer_write_cfg(&plane->layer,
+					    desc->layout.hxs_config,
+					    ATMEL_XLCDC_LAYER_HXSYCFG_ONE |
+					    ATMEL_XLCDC_LAYER_HXSYTAP2_ENABLE |
+					    ATMEL_XLCDC_LAYER_HXSCCFG_ONE |
+					    ATMEL_XLCDC_LAYER_HXSCTAP2_ENABLE);
+	}
 }
 
 static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
-- 
2.25.1


