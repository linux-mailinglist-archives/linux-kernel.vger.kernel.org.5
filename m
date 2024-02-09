Return-Path: <linux-kernel+bounces-59513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B484F839
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A891F29DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A971B59;
	Fri,  9 Feb 2024 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yM82d/pG"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB2364D6;
	Fri,  9 Feb 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491369; cv=none; b=jeHyWo/Aaj469Ye9epYTmqzijTjmFuabsznbiLWXlUN/P/A6M2SvJauV9mfd7v4I50he+IVHtvR4k3igfcELG5R38pnOI1yR8uSpO9i9dKmy3hYMpRkIwtgF13ocB6wgqrjFqoMeslWNwd97AwIbC7qkNMjulRSXMvBgYJWw90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491369; c=relaxed/simple;
	bh=dWx046Tkcu2y3E2CdwqYqH3QkLRo4gCPm3p/Aq7/rvY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9vpfo+YUAmLZDD5tNXAoOK6Kx7iQL0y0/RXbVhAfAn+VNNSLYl7MPhZNOUspe66g0aNW0aPxpTtEp2RYkKg0BbD3Evjpd0fKgAifEzhFurg4LcMUTSI3kjYWlSbJYvgi1blwXWAvFhuvQ4V5PcCU3RQ0fNIhmT7hJNaXuKbIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yM82d/pG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707491366; x=1739027366;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=dWx046Tkcu2y3E2CdwqYqH3QkLRo4gCPm3p/Aq7/rvY=;
  b=yM82d/pG7B5It+OgyttNQb57obDLC5J7YDbjqPraffz/7/6royQoBqnO
   FF25EMl/+Q7KHNzeC9csPhhPbyACYsCKbNc7w7hEd9Cr2wFb9iCBsn+Jr
   XP21D47QwGVzXlgwPlLvp68MKFJpWyeB1PLTOjjr0mLviogbVPBphJJMY
   nmo9BlrFPdm4TOk/sPP1e1RNezu+5mM2F25vYbkk3knkj51vvEGSjj4Dc
   k4vfBwkWkUawo0dQhwvltAnEF6abIR1soTFIxfGF+Yj3ze7x4Q5uj6RX5
   oiJi5Jnxwa3oaSh4LhuSgNwDwYJqjR+WP9M88BC+I/rcn4a4ogGC9Fqqa
   g==;
X-CSE-ConnectionGUID: /ftgHdBDRUKkBO7najs1cw==
X-CSE-MsgGUID: VSn3vkQASAS92qqfg+3cTQ==
X-IronPort-AV: E=Sophos;i="6.05,257,1701154800"; 
   d="scan'208";a="17424562"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2024 08:09:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 08:08:49 -0700
Received: from che-lt-i70843lx.amer.actel.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 08:08:37 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <manikandan.m@microchip.com>,
	<dharma.b@microchip.com>, <arnd@arndb.de>, <geert+renesas@glider.be>,
	<Jason@zx2c4.com>, <mpe@ellerman.id.au>, <gerg@linux-m68k.org>,
	<rdunlap@infradead.org>, <vbabka@suse.cz>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <hari.prasathge@microchip.com>,
	<akpm@linux-foundation.org>, <deller@gmx.de>
Subject: [PATCH v4 3/4] MAINTAINERS: add SAM9X7 SoC's LVDS controller
Date: Fri, 9 Feb 2024 20:37:56 +0530
Message-ID: <20240209150757.66914-4-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209150757.66914-1-dharma.b@microchip.com>
References: <20240209150757.66914-1-dharma.b@microchip.com>
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
v3 ->v4
- No changes.
v2 -> v3
- Move the entry before "MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER".
v1 -> v2
- No Changes.
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7c4cf8201e0..ce592b6cf375 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14216,6 +14216,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
 F:	drivers/pwm/pwm-atmel.c
 
+MICROCHIP SAM9x7-COMPATIBLE LVDS CONTROLLER
+M:	Manikandan Muralidharan <manikandan.m@microchip.com>
+M:	Dharma Balasubiramani <dharma.b@microchip.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+F:	Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
+F:	drivers/gpu/drm/bridge/microchip-lvds.c
+
 MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-iio@vger.kernel.org
-- 
2.25.1


