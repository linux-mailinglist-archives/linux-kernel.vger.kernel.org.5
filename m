Return-Path: <linux-kernel+bounces-42438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C13F8840162
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33A51C20CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C75647D;
	Mon, 29 Jan 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TsCJXdPj"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51256467
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520300; cv=none; b=jVQyFNNrZTNBeyMqlWli5rCjTl3N3EeMLQZ8uBMxELAvh5FWau9oG3F8oluyNDNY9ErDrjNm0fnrIqU/UiTkUXFmf1pmgQYpkAl6VJxafc7XfHjofXX60bA1jl+d16ItOtq26DyMgSYvaqi5Md6H2Kqz+RQTbFOc5oWuMy41Q+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520300; c=relaxed/simple;
	bh=tJbtQ1MlE1W9rRSJGxdgP3sxAM2uACs3ZmeI+EII/UM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5lOoOPD/714gCQ9gdIUM0XBFCJ1BhhqTgtq77iFTyL4JEOpSMlkoETG+aiYcxMD+q8qCvvLe+z2wd3fW7OzPCNQPu2fvEZRAQ4MOJ7BujEaZHRoqL6Fp/kRKDVpERisDsUr7N6jyedywx/zziO8NHaHgWEwVM+p0jgink7tac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TsCJXdPj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706520297; x=1738056297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tJbtQ1MlE1W9rRSJGxdgP3sxAM2uACs3ZmeI+EII/UM=;
  b=TsCJXdPjNUe6IQMffx2rrgFDg1J6EQMvqSA4GKQkhA4yBymgcT5OYja1
   RGTEidQQU1zXkzuNwPwdW9/AWXImaA7HKXn35jkGeDcjr80Q685gvAqlI
   kOxcZEnS5h8VlqYvxRKtAeCmR1d3wxFhQ4riWnsBU5vkyDxVr/8duXbnV
   th8KeVHZ8RCDG1GQ1NUcHIHjSrhJVjikmz/2DyASDwk1qTito9Pr8rCfu
   kLbqT308yQkbUoWuycuR4vLue2bhcevxtA9c3aPmKiMvV82DUzjSkBOhC
   1O8ynkz11WUEXCGBchsMoernaptS2MbBYI7kLFdbeFwBS8wqdhIYyNeek
   A==;
X-CSE-ConnectionGUID: 8voT20HCQaKMMfd/WNhz6Q==
X-CSE-MsgGUID: ca0RYYTXSn6TmRIBQq1YHg==
X-IronPort-AV: E=Sophos;i="6.05,226,1701154800"; 
   d="scan'208";a="16727010"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2024 02:24:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 02:24:27 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 02:24:20 -0700
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
Subject: [PATCH RESEND v7 1/7] drm: atmel-hlcdc: add flag and driver ops to differentiate XLCDC and HLCDC IP
Date: Mon, 29 Jan 2024 14:53:13 +0530
Message-ID: <20240129092319.199365-2-manikandan.m@microchip.com>
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

Add is_xlcdc flag and LCD IP specific ops in driver data to differentiate
XLCDC and HLCDC code within the atmel-hlcdc driver files.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h | 37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 5b5c774e0edf..d5e01ff8c7f9 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -177,6 +177,9 @@ struct atmel_hlcdc_layer_cfg_layout {
 	int csc;
 };
 
+struct atmel_hlcdc_plane_state;
+struct atmel_hlcdc_dc;
+
 /**
  * Atmel HLCDC DMA descriptor structure
  *
@@ -288,6 +291,36 @@ atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *layer)
 	return container_of(layer, struct atmel_hlcdc_plane, layer);
 }
 
+/**
+ * struct atmel_lcdc_dc_ops - describes atmel_lcdc ops group
+ * to differentiate HLCDC and XLCDC IP code support.
+ * @plane_setup_scaler: update the vertical and horizontal scaling factors
+ * @update_lcdc_buffers: update the each LCDC layers DMA registers.
+ * @lcdc_atomic_disable: disable LCDC interrupts and layers
+ * @lcdc_update_general_settings: update each LCDC layers general
+ * confiugration register.
+ * @lcdc_atomic_update: enable the LCDC layers and interrupts.
+ * @lcdc_csc_init: update the color space conversion co-efficient of
+ * High-end overlay register.
+ * @lcdc_irq_dbg: to raise alert incase of interrupt overrun in any LCDC layer.
+ */
+struct atmel_lcdc_dc_ops {
+	void (*plane_setup_scaler)(struct atmel_hlcdc_plane *plane,
+				   struct atmel_hlcdc_plane_state *state);
+	void (*update_lcdc_buffers)(struct atmel_hlcdc_plane *plane,
+				    struct atmel_hlcdc_plane_state *state,
+				    u32 sr, int i);
+	void (*lcdc_atomic_disable)(struct atmel_hlcdc_plane *plane);
+	void (*lcdc_update_general_settings)(struct atmel_hlcdc_plane *plane,
+					     struct atmel_hlcdc_plane_state *state);
+	void (*lcdc_atomic_update)(struct atmel_hlcdc_plane *plane,
+				   struct atmel_hlcdc_dc *dc);
+	void (*lcdc_csc_init)(struct atmel_hlcdc_plane *plane,
+			      const struct atmel_hlcdc_layer_desc *desc);
+	void (*lcdc_irq_dbg)(struct atmel_hlcdc_plane *plane,
+			     const struct atmel_hlcdc_layer_desc *desc);
+};
+
 /**
  * Atmel HLCDC Display Controller description structure.
  *
@@ -304,8 +337,10 @@ atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *layer)
  * @conflicting_output_formats: true if RGBXXX output formats conflict with
  *				each other.
  * @fixed_clksrc: true if clock source is fixed
+ * @is_xlcdc: true if XLCDC IP is supported
  * @layers: a layer description table describing available layers
  * @nlayers: layer description table size
+ * @ops: atmel lcdc dc ops
  */
 struct atmel_hlcdc_dc_desc {
 	int min_width;
@@ -317,8 +352,10 @@ struct atmel_hlcdc_dc_desc {
 	int max_hpw;
 	bool conflicting_output_formats;
 	bool fixed_clksrc;
+	bool is_xlcdc;
 	const struct atmel_hlcdc_layer_desc *layers;
 	int nlayers;
+	const struct atmel_lcdc_dc_ops *ops;
 };
 
 /**
-- 
2.25.1


