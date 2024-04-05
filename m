Return-Path: <linux-kernel+bounces-132408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A4289942C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749FF1C22D6B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79FD208CB;
	Fri,  5 Apr 2024 04:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yC0MbzRo"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671801C68F;
	Fri,  5 Apr 2024 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712291844; cv=none; b=T4FuW2lI/xOOLM8V8eW8gxISGfRLZJ2Mke8WcESszYCFzJM1ZllpMMrRRvGbB14voBuAUF8LbOzR7pM7APo+CjwGAYOK0ts0e0Vwwuei+qwc1btBZz8OBj5yHv3Lu6I+VoBPPl86sKbkT7bXg8W4N1eYRr5iC7T49oQUWEnsngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712291844; c=relaxed/simple;
	bh=9uINqyvWMsG3URlq2A0h6yqig1bkApNedwXa+jRDhH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGylaptFi+8j1TrOnKB9bdkKukz7H2YGm+XhGcRia6mm25ADk0EufVgcoyJuDKOSmH6qpN6t5yjUOEOnqHK2/IYT+VJgtlqlfMQhVTR718RhHlXRQVlkb2/ZkGK6xCoaIHpYF0DCcIIAIEIrB0Wp6M7feLlDSMcQ8JSpfYUG7kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yC0MbzRo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712291842; x=1743827842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9uINqyvWMsG3URlq2A0h6yqig1bkApNedwXa+jRDhH0=;
  b=yC0MbzRodnsQi+9zJQrRwt1v2EZJFe/Tw8a2yBZbVKO+RXBfD5TszP1n
   Fh4PoT61m41kISf2uIYC3uV6ziyrB4/qaMrXl8Qg+MvTymAdwC2PVtKHh
   JoQDRECjajgqH6zdm9W7a1EgXXELXVUyhEAcmSIgha5r4QygHSfuHxWz9
   VOJxFnk43GQhQk+280B6RrzQlO5/2ZE0hv2PDyitfGYQfAjzo3bAuBG02
   lPk1aHpu7pkjOVg5pfDrGTsKsjFGBNvjVgI/ESkniUJzlwguXl71kaXj/
   God379g9esdfOveaRq6ip0PT+5aP/5z1g6rtQaEWd3s1w/LON2xe/RIP3
   w==;
X-CSE-ConnectionGUID: pa7nRkquTYe1ezaz9E3PHg==
X-CSE-MsgGUID: ppkgSPbcQh6PVDkk0xUVZQ==
X-IronPort-AV: E=Sophos;i="6.07,180,1708412400"; 
   d="scan'208";a="186866933"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2024 21:37:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 21:37:01 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 21:36:49 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: "andrzej . hajda @ intel . com" <andrzej.hajda@intel.com>, "neil .
 armstrong @ linaro . org" <neil.armstrong@linaro.org>, "rfoss @ kernel . org"
	<rfoss@kernel.org>, "Laurent . pinchart @ ideasonboard . com"
	<Laurent.pinchart@ideasonboard.com>, "jonas @ kwiboo . se" <jonas@kwiboo.se>,
	"jernej . skrabec @ gmail . com" <jernej.skrabec@gmail.com>, "maarten .
 lankhorst @ linux . intel . com" <maarten.lankhorst@linux.intel.com>,
	"mripard @ kernel . org" <mripard@kernel.org>, "tzimmermann @ suse . de"
	<tzimmermann@suse.de>, "airlied @ gmail . com" <airlied@gmail.com>, "daniel @
 ffwll . ch" <daniel@ffwll.ch>, "robh+dt @ kernel . org" <robh+dt@kernel.org>,
	"krzysztof . kozlowski+dt @ linaro . org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt @ kernel . org"
	<conor+dt@kernel.org>, "linux @ armlinux . org . uk" <linux@armlinux.org.uk>,
	"Nicolas . Ferre @ microchip . com" <Nicolas.Ferre@microchip.com>, "alexandre
 . belloni @ bootlin . com" <alexandre.belloni@bootlin.com>, "claudiu . beznea
 @ tuxon . dev" <claudiu.beznea@tuxon.dev>, "Manikandan . M @ microchip . com"
	<Manikandan.M@microchip.com>, "Dharma . B @ microchip . com"
	<Dharma.B@microchip.com>, "arnd @ arndb . de" <arnd@arndb.de>, "geert+renesas
 @ glider . be" <geert+renesas@glider.be>, "Jason @ zx2c4 . com"
	<Jason@zx2c4.com>, "mpe @ ellerman . id . au" <mpe@ellerman.id.au>, "gerg @
 linux-m68k . org" <gerg@linux-m68k.org>, "rdunlap @ infradead . org"
	<rdunlap@infradead.org>, "vbabka @ suse . cz" <vbabka@suse.cz>, "dri-devel @
 lists . freedesktop . org" <dri-devel@lists.freedesktop.org>, "devicetree @
 vger . kernel . org" <devicetree@vger.kernel.org>, "linux-kernel @ vger .
 kernel . org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel @ lists .
 infradead . org" <linux-arm-kernel@lists.infradead.org>, "Hari . PrasathGE @
 microchip . com" <Hari.PrasathGE@microchip.com>, "akpm @ linux-foundation .
 org" <akpm@linux-foundation.org>, "deller @ gmx . de" <deller@gmx.de>
CC: Dharma Balasubiramani <dharma.b@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>
Subject: [PATCH v5 3/4] MAINTAINERS: add SAM9X7 SoC's LVDS controller
Date: Fri, 5 Apr 2024 10:05:35 +0530
Message-ID: <20240405043536.274220-4-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240405043536.274220-1-dharma.b@microchip.com>
References: <20240405043536.274220-1-dharma.b@microchip.com>
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
index aa3b947fb080..3dd93dbe9542 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14562,6 +14562,14 @@ S:	Supported
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


