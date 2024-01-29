Return-Path: <linux-kernel+bounces-42445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF3F84016C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FA12829B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3A45644B;
	Mon, 29 Jan 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Cdy394qw"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F356441
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520343; cv=none; b=AE0UFi13MGYae1RmiMBaj3MVaW+qLXKlV8OTOrNqRXgVZIhm5fK294L8rCZHXlh01gfpwvgST8Y6fg5bmrjpfv/17IOEg/gT/QdR6EZpZKQsCKU8D44B4lW6OIyLIy27y9y+XLyNPS3DmbRRxJ4IO+yLwcydxXxM2rVNzsYaA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520343; c=relaxed/simple;
	bh=A7zhmYqSGF3f91x5Sfj8wc2+BL0d/H7Pomw5rky9/34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgb7pM71N20oupOZPLK7TQwmN6ErcE4kvNfAHRzMGnUgIxGZCBpsFkJbJmu0X1icHJhxJB2Ty5UHMPCRIdQZ+ZrwB3a9Fh/TsMaPYiI39XYJGbjPLDsMofPcFk5ZGnogZm/sGpBZ87qYjn9EBBi0RlbUHrmmvAWRUAJUKfPOrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Cdy394qw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706520341; x=1738056341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A7zhmYqSGF3f91x5Sfj8wc2+BL0d/H7Pomw5rky9/34=;
  b=Cdy394qwkfYABnZsOWywKivFaQK9VrfvWbF8r7Xwc0jy20/CRDwepb02
   TQ+1lxPW6TvxhYY0H1K4egMGUM9UX85JuixIMNzD7MrXwD+wfIhsO5r/l
   U8gMxUbj0jmOFk6ametbJpO3GYdJ/zNrEqGgNsMPfKi3/R+YZ1YKLJ0N9
   JmvyynRMZ+RFA+W6fRal1TIBOV37WFC5KSE5X4P3wlwMXtVpGvTJX1dFe
   +NYRJstI/jvYL4PCgqF8QlYIYBR74ydpb5GfS6lNu+b+2RUChQimnCPG5
   dSrdtnKofXu92gTocRrt0E4jQbozd7dig1g9Euk373TNfOhibEHIoblZB
   w==;
X-CSE-ConnectionGUID: JMZNa0W0TwelpxkBzp+3Tg==
X-CSE-MsgGUID: OO2i0OZfQBG2uogTKO6FKA==
X-IronPort-AV: E=Sophos;i="6.05,226,1701154800"; 
   d="scan'208";a="182680029"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2024 02:25:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 02:25:20 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 02:25:13 -0700
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
	<manikandan.m@microchip.com>, Durai Manickam KR
	<durai.manickamkr@microchip.com>
Subject: [PATCH RESEND v7 7/7] drm: atmel-hlcdc: add support for DSI output formats
Date: Mon, 29 Jan 2024 14:53:19 +0530
Message-ID: <20240129092319.199365-8-manikandan.m@microchip.com>
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
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 123 +++++++++++++-----
 1 file changed, 88 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 1899be2eb6a3..6f529769b036 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -295,11 +295,18 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 
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
 
 static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 {
@@ -313,53 +320,99 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 	if (!encoder)
 		encoder = connector->encoder;
 
-	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
-	case 0:
-		break;
-	case MEDIA_BUS_FMT_RGB444_1X12:
-		return ATMEL_HLCDC_RGB444_OUTPUT;
-	case MEDIA_BUS_FMT_RGB565_1X16:
-		return ATMEL_HLCDC_RGB565_OUTPUT;
-	case MEDIA_BUS_FMT_RGB666_1X18:
-		return ATMEL_HLCDC_RGB666_OUTPUT;
-	case MEDIA_BUS_FMT_RGB888_1X24:
-		return ATMEL_HLCDC_RGB888_OUTPUT;
-	default:
-		return -EINVAL;
-	}
-
-	for (j = 0; j < info->num_bus_formats; j++) {
-		switch (info->bus_formats[j]) {
-		case MEDIA_BUS_FMT_RGB444_1X12:
-			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
+	if (encoder->encoder_type == DRM_MODE_ENCODER_DSI) {
+		/*
+		 * atmel-hlcdc to support DSI formats with DSI video pipeline
+		 * when DRM_MODE_ENCODER_DSI type is set by
+		 * connector driver component.
+		 */
+		switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+		case 0:
 			break;
 		case MEDIA_BUS_FMT_RGB565_1X16:
-			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
-			break;
+			return ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;
 		case MEDIA_BUS_FMT_RGB666_1X18:
-			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
-			break;
+			return ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;
+		case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
+			return ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;
 		case MEDIA_BUS_FMT_RGB888_1X24:
-			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
-			break;
+			return ATMEL_HLCDC_DPI_RGB888_OUTPUT;
 		default:
+			return -EINVAL;
+		}
+
+		for (j = 0; j < info->num_bus_formats; j++) {
+			switch (info->bus_formats[j]) {
+			case MEDIA_BUS_FMT_RGB565_1X16:
+				supported_fmts |=
+					ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB666_1X18:
+				supported_fmts |=
+					ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
+				supported_fmts |=
+					ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB888_1X24:
+				supported_fmts |=
+					ATMEL_HLCDC_DPI_RGB888_OUTPUT;
+				break;
+			default:
+				break;
+			}
+		}
+	} else {
+		switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+		case 0:
 			break;
+		case MEDIA_BUS_FMT_RGB444_1X12:
+			return ATMEL_HLCDC_RGB444_OUTPUT;
+		case MEDIA_BUS_FMT_RGB565_1X16:
+			return ATMEL_HLCDC_RGB565_OUTPUT;
+		case MEDIA_BUS_FMT_RGB666_1X18:
+			return ATMEL_HLCDC_RGB666_OUTPUT;
+		case MEDIA_BUS_FMT_RGB888_1X24:
+			return ATMEL_HLCDC_RGB888_OUTPUT;
+		default:
+			return -EINVAL;
 		}
-	}
 
+		for (j = 0; j < info->num_bus_formats; j++) {
+			switch (info->bus_formats[j]) {
+			case MEDIA_BUS_FMT_RGB444_1X12:
+				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB565_1X16:
+				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB666_1X18:
+				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
+				break;
+			case MEDIA_BUS_FMT_RGB888_1X24:
+				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
+				break;
+			default:
+				break;
+			}
+		}
+	}
 	return supported_fmts;
 }
 
 static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 {
-	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
+	unsigned int output_fmts;
 	struct atmel_hlcdc_crtc_state *hstate;
 	struct drm_connector_state *cstate;
 	struct drm_connector *connector;
-	struct atmel_hlcdc_crtc *crtc;
+	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
 	int i;
+	bool is_xlcdc = crtc->dc->desc->is_xlcdc;
 
-	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
+	output_fmts = is_xlcdc ? ATMEL_XLCDC_OUTPUT_MODE_MASK :
+		      ATMEL_HLCDC_OUTPUT_MODE_MASK;
 
 	for_each_new_connector_in_state(state->state, connector, cstate, i) {
 		unsigned int supported_fmts = 0;
@@ -380,7 +433,7 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 
 	hstate = drm_crtc_state_to_atmel_hlcdc_crtc_state(state);
 	hstate->output_mode = fls(output_fmts) - 1;
-	if (crtc->dc->desc->is_xlcdc) {
+	if (is_xlcdc) {
 		/* check if MIPI DPI bit needs to be set */
 		if (fls(output_fmts) > 3) {
 			hstate->output_mode -= 4;
-- 
2.25.1


