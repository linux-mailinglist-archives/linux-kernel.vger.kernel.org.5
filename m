Return-Path: <linux-kernel+bounces-74087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D72F85CFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B42D7B22967
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AE53A8C8;
	Wed, 21 Feb 2024 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dU2Wo6mV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C9383BF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493811; cv=none; b=DstTt+GvSBtDtVyDBv9jNf+YzzD4UsU9mAbY8xqtuLyro+KdKplSIePiTsL88MD0+8KdHaboflaD7H9bHKX2BsQGcT7Ldqqa/zdwKei5oFJIOb4eMLJ6TfLHtgBJcLlU4sHuLXeZqeXeLfyHFMs0NUCfaVV0g0pI5E6ICCKbaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493811; c=relaxed/simple;
	bh=U7jH/pJDoVpWs61f/GCs67K6hYCY5UGUIVemfwvO3Aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNzEA6jj6Ki9tYKk49mclgr4qxYTvptrmvuoU1PGtTY7cg0sx8UVxYsZM3va65NHyRhyFct5+36O04QRo2c9PS5r7tnaDfdsZICUGjnszxJpWCrsREUf7derDEgtGMxXGQOI+1J4sqT9+AR+mfQW3pS8vGzBWaY/UXB2meiNb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dU2Wo6mV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708493809; x=1740029809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U7jH/pJDoVpWs61f/GCs67K6hYCY5UGUIVemfwvO3Aw=;
  b=dU2Wo6mVO5DjcvtUiq2CuzP0zCyTcN7pT5eLxBK4B8S7BZ5LeHkOiCXd
   THvYUWPGCycFCWFHcFwdXE5iq/GTZU0YGvmgU8JA+8+MtWmAlGYr3wC6E
   F7/fr1Ff+Y8EFM0+KS0oZZtGGvraY61cT6s5MQ31reREZDwfObRBtXJoj
   dgk/XL0JljMwsKyw7O25oZFSnjAYUI3j6y4S8oo7iiOB8IN5civX/PI5Q
   VIwafPv3rIwznakvN7qSJKjiiPKQHPv90fY9ElnCzjAJ+k491KOE5FOT4
   21FJ/4A+VDf7LPjXhLA/9YpQbHVumk14zjeCsvE5NY6F0WH4nzm37rU1/
   g==;
X-CSE-ConnectionGUID: uvmqqrvDTHSClXFWxIq5Hw==
X-CSE-MsgGUID: LEPWwVfRQ8eIngdgoc/F2Q==
X-IronPort-AV: E=Sophos;i="6.06,174,1705388400"; 
   d="scan'208";a="183844465"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2024 22:36:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 22:36:35 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 22:36:27 -0700
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
	<Balakrishnan.S@microchip.com>, <manikandan.m@microchip.com>,
	<Charan.Pedumuru@microchip.com>, Durai Manickam KR
	<durai.manickamkr@microchip.com>
Subject: [PATCH v8 6/7] drm: atmel-hlcdc: add support for DSI output formats
Date: Wed, 21 Feb 2024 11:05:30 +0530
Message-ID: <20240221053531.12701-7-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221053531.12701-1-manikandan.m@microchip.com>
References: <20240221053531.12701-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for the following DPI mode if the encoder type
is DSI as per the XLCDC IP datasheet:
- 16BPPCFG1
- 16BPPCFG2
- 16BPPCFG3
- 18BPPCFG1
- 18BPPCFG2
- 24BPP

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
[durai.manickamkr@microchip.com: update output format using is_xlcdc flag]
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 74 +++++++++++++++++--
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index fdd3a6bc0f79..0dbe85686fc2 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -301,11 +301,64 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 
 }
 
-#define ATMEL_HLCDC_RGB444_OUTPUT	BIT(0)
-#define ATMEL_HLCDC_RGB565_OUTPUT	BIT(1)
-#define ATMEL_HLCDC_RGB666_OUTPUT	BIT(2)
-#define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
-#define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
+#define ATMEL_HLCDC_RGB444_OUTPUT		BIT(0)
+#define ATMEL_HLCDC_RGB565_OUTPUT		BIT(1)
+#define ATMEL_HLCDC_RGB666_OUTPUT		BIT(2)
+#define ATMEL_HLCDC_RGB888_OUTPUT		BIT(3)
+#define ATMEL_HLCDC_DPI_RGB565C1_OUTPUT		BIT(4)
+#define ATMEL_HLCDC_DPI_RGB565C2_OUTPUT		BIT(5)
+#define ATMEL_HLCDC_DPI_RGB565C3_OUTPUT		BIT(6)
+#define ATMEL_HLCDC_DPI_RGB666C1_OUTPUT		BIT(7)
+#define ATMEL_HLCDC_DPI_RGB666C2_OUTPUT		BIT(8)
+#define ATMEL_HLCDC_DPI_RGB888_OUTPUT		BIT(9)
+#define ATMEL_HLCDC_OUTPUT_MODE_MASK		GENMASK(3, 0)
+#define ATMEL_XLCDC_OUTPUT_MODE_MASK		GENMASK(9, 0)
+
+static int atmel_hlcdc_connector_output_dsi(struct drm_encoder *encoder,
+					    struct drm_display_info *info)
+{
+	int j;
+	unsigned int supported_fmts = 0;
+
+	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+	case 0:
+		break;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		return ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		return ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;
+	case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
+		return ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		return ATMEL_HLCDC_DPI_RGB888_OUTPUT;
+	default:
+		return -EINVAL;
+	}
+
+	for (j = 0; j < info->num_bus_formats; j++) {
+		switch (info->bus_formats[j]) {
+		case MEDIA_BUS_FMT_RGB565_1X16:
+			supported_fmts |=
+				ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB666_1X18:
+			supported_fmts |=
+				ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
+			supported_fmts |=
+				ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB888_1X24:
+			supported_fmts |=
+				ATMEL_HLCDC_DPI_RGB888_OUTPUT;
+			break;
+		default:
+			break;
+		}
+	}
+	return supported_fmts;
+}
 
 static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 {
@@ -318,6 +371,13 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 	encoder = state->best_encoder;
 	if (!encoder)
 		encoder = connector->encoder;
+	/*
+	 * atmel-hlcdc to support DSI formats with DSI video pipeline
+	 * when DRM_MODE_ENCODER_DSI type is set by
+	 * connector driver component.
+	 */
+	if (encoder->encoder_type == DRM_MODE_ENCODER_DSI)
+		return atmel_hlcdc_connector_output_dsi(encoder, info);
 
 	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
 	case 0:
@@ -358,7 +418,7 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 
 static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 {
-	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
+	unsigned int output_fmts;
 	struct atmel_hlcdc_crtc_state *hstate;
 	struct drm_connector_state *cstate;
 	struct drm_connector *connector;
@@ -366,6 +426,8 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 	int i;
 
 	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
+	output_fmts = crtc->dc->desc->is_xlcdc ? ATMEL_XLCDC_OUTPUT_MODE_MASK :
+		      ATMEL_HLCDC_OUTPUT_MODE_MASK;
 
 	for_each_new_connector_in_state(state->state, connector, cstate, i) {
 		unsigned int supported_fmts = 0;
-- 
2.25.1


