Return-Path: <linux-kernel+bounces-156316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76498B011A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E313B23605
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CF2156893;
	Wed, 24 Apr 2024 05:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SHsj7XXs"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22038156671
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936936; cv=none; b=knN6nXfFQERxtdQCVefHrwyLHLQyhVixTXOILMsTvZWRj+5ksQPCUIk8fWtZ0hcznlUzng4U2yb7WJggzscmTqJBLxoXNTkJbCflkvzt6IzGDeGn9iWn3WzA0z3fXMA76QnPnM5fniXyfoLUyZP7fGozlJKFiSmSq1ydH3l+ITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936936; c=relaxed/simple;
	bh=MFjWpwk59bsDChbs9KtKrNdxez95WJ176JCMOJ6L8fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDE3KrZX9BoLb0ewP7wZbhy5AuPUTRuM5UIkkEirc+NxrY4UJ7Co43PAyg+T7bmX4DpVmNGadah1xu3QmRHoLDnNqJjgMoj7kMQnA7Ueo+35Y0mLjTTabrJBrRKGEK2vmJIdq856AZdwHkyZXFks2YaXSM9WIQpYo5Mmj4wDeB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SHsj7XXs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713936935; x=1745472935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MFjWpwk59bsDChbs9KtKrNdxez95WJ176JCMOJ6L8fo=;
  b=SHsj7XXs1VhCuGH7Xphm8Y5tB+BCUKyXoeJNArUJ2ixIE5fhDItC3Qma
   HV4QThktxYNFtuzNmuL3zZvRxNJGcUy85nlVfEOKJUKs4EdP62fZno3F+
   KhB25mbMtXCQSNoNDtDGaaZtedO4YDY5B+MSrjGvV0k6TDeStVRyjGm0m
   vkJwSMhS+Pw+6l+bfEpM3kHwt1h3aroL3lrvigfAMl2aR6ycSrPX71dor
   v7j0I21hhuCC5XsNTFrEl7rUjw76ZqLd+Gb0YC7tkb6gH/XQmhivO1Big
   vj/KEhOrX4aBg5RJm7/8Il/aFSCaCUzTZW6c1hSzuH98SpwHHKuYGN7IW
   Q==;
X-CSE-ConnectionGUID: 66HgaiTNS5a1XaeqM3EXdg==
X-CSE-MsgGUID: YnnuRWviQlaohksSfUW97Q==
X-IronPort-AV: E=Sophos;i="6.07,225,1708412400"; 
   d="scan'208";a="22410971"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 22:35:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 22:35:19 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 22:35:11 -0700
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
Subject: [PATCH RESEND v9 6/8] drm: atmel-hlcdc: add vertical and horizontal scaling support for XLCDC
Date: Wed, 24 Apr 2024 11:03:49 +0530
Message-ID: <20240424053351.589830-7-manikandan.m@microchip.com>
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

Update the vertical and horizontal scaler registers of XLCDC IP
with Bilinear and Bicubic co-efficients taps for Chroma and
Luma componenets of the Pixel.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  4 ++++
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 20 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 1153d402f810..e1a0bb24b511 100644
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
index f60367dc6d9d..4a7ba0918eca 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -966,6 +966,26 @@ static void atmel_xlcdc_csc_init(struct atmel_hlcdc_plane *plane,
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


