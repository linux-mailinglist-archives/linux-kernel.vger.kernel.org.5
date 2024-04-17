Return-Path: <linux-kernel+bounces-147863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA78A7AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32C21F221CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F223BA34;
	Wed, 17 Apr 2024 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Yu5hAx2K"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB458F72;
	Wed, 17 Apr 2024 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321805; cv=none; b=eigm2dZ5ZGLAkYc7fL9BFCUSpHB25DVEgkgBcgIEDCXSv6q0O3rg3g7kEhJ0yATH5j7AzyMe1qXMyr30jCuhaWWsZW1YV2CcQ3KBKEWjEACktAFN8zBpIb0j2Cnfc/spmRKCRhouoR1ipVupxKn6M3sDJEa5df6mEcp+pQjkgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321805; c=relaxed/simple;
	bh=RW42ADRJHbjCU+N4jM5hsf6GoRXrS/Cmrp4V+FIUu5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fucL357ZtYtre/vBOYGANK4eF+hpxctK6SlbRSMVsQ9eh358htenOHWTv1KUbWKPUfSC/oIIzUP4ATLKEzwqSqnjA+dvzZq1d4lD3MvcRE6IblP0nL2tyTtH2KPDVgaZic7yZlmRaD0OJcs3XzTRJi2uAOtn9U1k0Hg3NlkzNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Yu5hAx2K; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713321804; x=1744857804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RW42ADRJHbjCU+N4jM5hsf6GoRXrS/Cmrp4V+FIUu5E=;
  b=Yu5hAx2KL8ec4gIXlCFECeQNuexb6AQfKJ96mf0JFbOMScXI96G1J5W3
   KZWRinjmOJNil77vNj6pEKZQ5WyGBNN1Cz7D4bdNnMZJRx2XrJvfgUkOR
   y962GvtUcmdmhOXir9nfAMCuneDs0hjo6QOA3UDafeQ1EyMHmw9Gz7sl5
   Wk0CI09bkxdUZzHTEG9/f7j2G0wdJt9H3Ai6kYsuoK4GIrgDS812hWIV9
   cAB0+Xz87/3sOgCs+eG0ZynyyVnwjzvnyx6zB70R+H/7HXab+Uxe/eH+x
   QW9l9mbkfc0flJFPKsMkQxzBsK1C2WHkZ4BPs39EdLAQHXPeHJaOq2dXV
   A==;
X-CSE-ConnectionGUID: lGxh+0ByRtCkzh726CowEg==
X-CSE-MsgGUID: TmGpvyGHREyqXt8rLiNfvA==
X-IronPort-AV: E=Sophos;i="6.07,207,1708412400"; 
   d="scan'208";a="252174814"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 19:43:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 19:42:43 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 19:42:32 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <Dharma.B@microchip.com>, <andrzej.hajda@intel.com>,
	<neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <Manikandan.M@microchip.com>, <arnd@arndb.de>,
	<geert+renesas@glider.be>, <Jason@zx2c4.com>, <mpe@ellerman.id.au>,
	<gerg@linux-m68k.org>, <rdunlap@infradead.org>, <vbabka@suse.cz>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Dharma Balasubiramani
	<dharma.b@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v6 3/4] MAINTAINERS: add SAM9X7 SoC's LVDS controller
Date: Wed, 17 Apr 2024 08:11:36 +0530
Message-ID: <20240417024137.144727-4-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417024137.144727-1-dharma.b@microchip.com>
References: <20240417024137.144727-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the newly added LVDS controller for the SAM9X7 SoC to the existing
MAINTAINERS entry.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Changelog
v5 -> v6
- Correct the file name sam9x7-lvds.yaml -> sam9x75-lvds.yaml.
v4 -> v5
v3 -> v4
- No changes.
v2 -> v3
- Move the entry before "MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER".
v1 -> v2
- No Changes.
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c23fda1aa1f0..e49347eac596 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14563,6 +14563,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
 F:	drivers/pwm/pwm-atmel.c
 
+MICROCHIP SAM9x7-COMPATIBLE LVDS CONTROLLER
+M:	Manikandan Muralidharan <manikandan.m@microchip.com>
+M:	Dharma Balasubiramani <dharma.b@microchip.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+F:	Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml
+F:	drivers/gpu/drm/bridge/microchip-lvds.c
+
 MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-iio@vger.kernel.org
-- 
2.25.1


