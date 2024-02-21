Return-Path: <linux-kernel+bounces-74085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044585CFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C731F21E63
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21612B89;
	Wed, 21 Feb 2024 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1FSDreuR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F222F0C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493809; cv=none; b=I6yKPcFbMmGdse4EB8VzGCDirXyBqO+a1/dIoBh1G/vQxEJNwoqMxpwAZk2UHqebfzXX7rvt6R8Yf93TbCDgS3lopERSkYxcvw0VVyQFmmPsQzRdDsZUAFIhyx28BccGfLfeH2hfUG28rIASnPzsa8k4OtbkKrdlDUXuPA7zbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493809; c=relaxed/simple;
	bh=vamCWSiJM7+97Uo0iaUu/+oC2m02hOMoM7VnCK2/wT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hv3JgnNVropISdDwlvol7a5B1mrhtOzDEjOX9thBFSTUbsGufSJyuXELW2INY+RpTGpW8UQEVjvNmqekR0O1V776vkuHZGPU9nXwmuasZQ/qDQXEUTB4gpJjE9sPl2dDJgrk5QLJEDtWbGsRLy3xeQAORAbYOy10wf8gVi1wULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1FSDreuR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708493807; x=1740029807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vamCWSiJM7+97Uo0iaUu/+oC2m02hOMoM7VnCK2/wT8=;
  b=1FSDreuRZPE4eIfMYMO2pMEgNwa/aiT4tx7oefCL/HT341wZEZoQPvPm
   p9iNpP8l2uJVEoYkZBFYcyWKlQRBBvbpvk5Pz4KZuMcvmmXOqhCaK7ni0
   PZ5Pht1yE7e6vCI/Ai/x9abgQXmdQs+XGbyLN0IG/4JTgiRCQ0UP6KGzv
   6fgVOpGHKUIvBn59qUxp9eOIxN2yxm22lPQGZ66ErmdYuqamklZ8nCQE5
   PwS20dAc3ips1+yNCk3DelZADcUuVO30hqxQ48uoQj9yQKqAVayUJa8pf
   vUszHzYvuRiMTuppwMtBtl8nhSgxpdNCuV0OSobRgNUf847+SegrcFWNA
   w==;
X-CSE-ConnectionGUID: uvmqqrvDTHSClXFWxIq5Hw==
X-CSE-MsgGUID: 5XevNVMPS/q+qoTipsI6RQ==
X-IronPort-AV: E=Sophos;i="6.06,174,1705388400"; 
   d="scan'208";a="183844463"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2024 22:36:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 22:36:26 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 22:36:18 -0700
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
	<Charan.Pedumuru@microchip.com>
Subject: [PATCH v8 5/7] drm: atmel-hlcdc: add vertical and horizontal scaling support for XLCDC
Date: Wed, 21 Feb 2024 11:05:29 +0530
Message-ID: <20240221053531.12701-6-manikandan.m@microchip.com>
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

Update the vertical and horizontal scaler registers of XLCDC IP
with Bilinear and Bicubic co-efficients taps for Chroma and
Luma componenets of the Pixel.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  4 ++++
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 20 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 777987b7873d..fd9d9af4332c 100644
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
 
 /**
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


