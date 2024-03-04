Return-Path: <linux-kernel+bounces-90896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 066DB870683
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53A8AB23A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFC34CE0E;
	Mon,  4 Mar 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hSIUVb6E"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C4482DA;
	Mon,  4 Mar 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568305; cv=none; b=o6JmfqDbaQgSyFaVVveLEC0yaip0GLH7KH2w++BEF9c+rwBA3L3RZngSSui3dotHQ40hDLYsaROYNGhJqPgy4AOPFwCNmr3rg/N03n6HjhAlMEZIzMCY+1chH7DE7pekBXtrTu1k16KXfxJ53oXQM9kN8xY2yST6as08wrukYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568305; c=relaxed/simple;
	bh=UqrS3L3ZfbwmChhjl8azT4mTToB0ZPmTuVA//e4Tm3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ed9qnqvtDOt+Q85DvS0+92hp/BA6lWX6XrET1iRO6+gjbebRRt9wNNzT+0YRNxuomVO17mZB0lwBYXBYHBkqS3DpowHn1T+ZgZU+oazjyuk9C1KzFYLpedbR9mS0bBJFmC2/OMD77JfhL8R0StPHUAw40X/p6EzY5LSKemRFVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hSIUVb6E; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 949B920004;
	Mon,  4 Mar 2024 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709568301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02ddm9Xy6N7z/+neL8gzCb13I4/NT+KuYhzJAZBmiP4=;
	b=hSIUVb6E9z+JSB3bVvrNY/dPAlfXj7zfaI3INTwE8Z2MqF10k09JJmTREEaB3DRgjsWAQj
	YwzYwrwJKxnGbuvvtKJw9iaJxJvbXAzkzEXZeTUcF58cWnZDswtLxwJNXEVgAPkiSIgJtc
	9lroxmwHSoB34Yz6fFszoK/HGENu8aOAhW+7unBeOQ2lIxYlqzYMgCqQwIYnS3ASG9W+mX
	tixzkUi6qIOWAa+ekwBb2CBGStwPBvV/uqrjaRzm4I8BjtYxsd/8EjxtKvgcf8zQ1GRw7Y
	tu1aM+ajydcauOYQjMoKO7iApTuYrnLSblJ2fCiJYBYBBnYiG5xrDw6qRSSo7A==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v2 3/3] drm/panel: simple: add CMT430B19N00 LCD panel support
Date: Mon,  4 Mar 2024 17:04:54 +0100
Message-Id: <20240304160454.96977-4-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
References: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Add support for Crystal Clear Technology CMT430B19N00 4.3" 480x272
TFT-LCD panel.

Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 20e3df1c59d4..b940220f56e2 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1457,6 +1457,32 @@ static const struct panel_desc boe_hv070wsa = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode cct_cmt430b19n00_mode = {
+	.clock = 9000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 43,
+	.hsync_end = 480 + 43 + 8,
+	.htotal = 480 + 43 + 8 + 4,
+	.vdisplay = 272,
+	.vsync_start = 272 + 12,
+	.vsync_end = 272 + 12 + 8,
+	.vtotal = 272 + 12 + 8 + 4,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc cct_cmt430b19n00 = {
+	.modes = &cct_cmt430b19n00_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 95,
+		.height = 53,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct drm_display_mode cdtech_s043wq26h_ct7_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -4402,6 +4428,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "boe,hv070wsa-100",
 		.data = &boe_hv070wsa
+	}, {
+		.compatible = "cct,cmt430b19n00",
+		.data = &cct_cmt430b19n00,
 	}, {
 		.compatible = "cdtech,s043wq26h-ct7",
 		.data = &cdtech_s043wq26h_ct7,
-- 
2.34.1


