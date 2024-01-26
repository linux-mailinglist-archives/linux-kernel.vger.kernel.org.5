Return-Path: <linux-kernel+bounces-39843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDEF83D6A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83EA28F47B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD5C149000;
	Fri, 26 Jan 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="DSr5LP72"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8F38DFE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259464; cv=none; b=kexUXNLGf0AcrLTfQV/cD9do3PtOr4l4MCCH07EzrOSss+lXznqEKzO4OXeePoIRZ0GkDZrmaWCtQ3CK1wjFlidZwV9WiBOVtFdRi9HGiYa4p2taGMzWVsoaiVfHQMoDBgpQC80OQY7uuujFGv+Vp06TiSiBYz/EZ7Cy0akVuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259464; c=relaxed/simple;
	bh=ZDdOWVnddl7bhXfIPB3AKGinke7Z1AztlDd66Tk1tcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HDzwzDOKKzA4gAP/telfytUAvW1xYKmNpDSuPYy0jV74w4tksGaW7ZU3HJZjxx3rDvQRUmRusmMk7MwfMf3/ozGwzKTvql8aumWqb3o/scFjYb+6mhOWknJZIgNqQvh9Gzx4drAq/iddRs0fjkzKEsPa28YOzYXnAMgV1N9sCeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=DSr5LP72; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1706259456; x=1708851456;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZDdOWVnddl7bhXfIPB3AKGinke7Z1AztlDd66Tk1tcc=;
	b=DSr5LP72WjS31TdsHl9I0pSmDOKLY9PrEhJRJVqRVi/hiTepbHTAvrrlEEAXB5Wg
	ZPoJq2RFpV3Tp7Y23i8oq6R6FwOO5kjlCvLbhp54c2uGV3oQ9JV1G2IhPoRjb+Ga
	24Mgb6qfxiqw5DvL6KcoJO1DRFK450AHsTQ5HgptuZM=;
X-AuditID: ac14000a-fadff7000000290d-bb-65b37400038f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E3.F9.10509.00473B56; Fri, 26 Jan 2024 09:57:36 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 26 Jan
 2024 09:57:36 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 26 Jan 2024 09:57:24 +0100
Subject: [PATCH RFC for upstream 2/4] drm/panel: simple: Add EDT
 ETML1010G3DRA panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-2-8ec5b48eec05@phytec.de>
References: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-0-8ec5b48eec05@phytec.de>
In-Reply-To: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-0-8ec5b48eec05@phytec.de>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
	<quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP
 Linux Team <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
CC: Primoz Fiser <primoz.fiser@norik.com>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>, Yannic
 Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHfd7bXlejtznwUTHBsht4CTSeD5r1IXqioKQSCkWHe72gmW3T
	NLPspjnvgoY2nG5mpkNzauqYGSKoiEbkJcQsm9TEy5C0UjDrTSO//c7//M85/w+HJaVfKVc2
	LlHNKxPlCZ6MmDK6OOz0dlC38H6GZ36of1xPIHttHkDGrmECbbwsJpGud5hGIyt2Bk2PnkP1
	pZ0UKrBNk8hkHaORZu05id6ZtQyqXmqjUFZOLY3snRMA9WumaXSv5DGJHnb1itB6u4lCdatt
	ANlandGquZJCrfPFNMpdPIAeTAYcd8HGSiPAXd+rKNxZ8UGETfU5DJ4cszC4ciAEf8ztI3BL
	zR1cmPuAxj9WXtC4ebGDwIXrfrjYchvXlI0yuGUwHX8z7TnPXREHKviEuBRe6XssUhyb/VNL
	JdVzqX1rJiITvJZogCMLOX/YZdGRGiBmpZyBgKXW0a1iGsDu7lkguBhuH7TapmgNYFmK84L2
	nF2C7MSFQtvTEVJgCbcbDpTPUIKF5A7BJrOvIJOcB2xf0G5ZwuDaW9vfLdI/rLFGCOjIhcO7
	972FozJOw8A50xCzOboMoL7dazOmE8zWTxACSzl3aHuTL9rUPWDZ8By5yZdg23I7UQSkFdsC
	VfwPVLEtUBUg64H0alxUPK+Mi/dJik1T81E+Ct4EhGeQOYg7QIEW9wCCBT0AsqSnTOIf0MxL
	JQp52k1eeS1CmZzAq3qAG0t5OksaHl3gpVyMXM3H83wSr/zXJVhH10zgsdf9fa3hdMCNIqqv
	9PN+w/CTyiVF8trU5UHt4MXU+JFgdxRDNYbORi3X0avpO05qX82fapS52Q8Gnw3iS0IWdOvR
	1SrUVxut0xvLncLOaC0Zy02q/BBRVV2KU17OUOCGWX20ucb8KZr90nBixjKeAeQgaDH1161w
	FHk9K8uTUsXKjxwmlSr5b7E0Aqn6AgAA

From: Primoz Fiser <primoz.fiser@norik.com>

Add support for the EDT ETML1010G3DRA 10.1" 1280x800 LVDS panel.
Datasheet can be found at [1].

[1] https://www.glynshop.com/erp/owweb/Daten/DSS/EDT/Products/Specifications/Active%20Displays/ETML1010G3DRA%20Ver.3-RoHS.pdf

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 drivers/gpu/drm/panel/panel-simple.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9367a4572dcf..662cf8d10a8a 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1920,6 +1920,33 @@ static const struct panel_desc edt_etml0700y5dha = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing edt_etml1010g3dra_timing = {
+	.pixelclock = { 66300000, 72400000, 78900000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 12, 72, 132 },
+	.hback_porch = { 86, 86, 86 },
+	.hsync_len = { 2, 2, 2 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 1, 15, 49 },
+	.vback_porch = { 21, 21, 21 },
+	.vsync_len = { 2, 2, 2 },
+	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW |
+		 DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc edt_etml1010g3dra = {
+	.timings = &edt_etml1010g3dra_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 216,
+		.height = 135,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode edt_etmv570g2dhu_mode = {
 	.clock = 25175,
 	.hdisplay = 640,
@@ -4328,6 +4355,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "edt,etml0700y5dha",
 		.data = &edt_etml0700y5dha,
+	}, {
+		.compatible = "edt,etml1010g3dra",
+		.data = &edt_etml1010g3dra,
 	}, {
 		.compatible = "edt,etmv570g2dhu",
 		.data = &edt_etmv570g2dhu,

-- 
2.34.1


