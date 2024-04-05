Return-Path: <linux-kernel+bounces-132409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932F589942E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47011C24A09
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DFA21A06;
	Fri,  5 Apr 2024 04:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F9QtCehI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED41D53C;
	Fri,  5 Apr 2024 04:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712291845; cv=none; b=lQ8yD786Yimqo1/YggzLfZ4Si5C2zEAqD6sFh5au24TuS3u25Ntmk4trtVzM/Qe9xpca0jTGlk06aupYXTIffxhFW0vP5TUwmF0cSyWrH4U/MTKca6NYFCILQqffa6Jp6+zN9PNK0dz09NzX3ESdRLN11ULKhztvXmPvms8GKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712291845; c=relaxed/simple;
	bh=po9zb6Qn/5fT2i3jnTl0DLe9EyYWr9PtZv3ZiG+LgXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INhIg+PMiR3OU9U/cxgv9Fx1c94ABC9f0BkYCSM6nVQU9KQowh7hV+8uldKfOIsV0K4O92bJ+XHkbLUxVBq7R5pypLBYGgqiYFGtA7RNQnp3lyJ2hRHR0PBw0DpHZmTbyVxl9yFheDQZ4o07EGAryG8btYq02ECaR5buEXG2c7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F9QtCehI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712291844; x=1743827844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=po9zb6Qn/5fT2i3jnTl0DLe9EyYWr9PtZv3ZiG+LgXk=;
  b=F9QtCehID2MvR/v6ZvDnr9d0ubzS//owYfjYfSnqFkLofgY0MxzrYpPv
   quR7J9EEhD4KmLxmIdcAUXWPazqGv/5Wll36SKYjBbXfyq1a4KLoHbLVg
   fMprcQ8fovkdL3pL2yGPbf5TaZ1S6OAQOXznLO7ICUSeNOvdhlleqabPg
   ComZK+m1a1hUGwz8/cacFQljUweS4RJH6tkFJqaaT8iIHxIO1bumu4nKb
   3Un9eEmYcOVgh3aCXYR/hGZecgDOnMlIhIfxwNu/qlV5NNIv1Y9maEiGh
   zbqB9tGWZv8/yinZ+6oXuRAWviQwuqn7DOAWwMMFYGZ+JRxiPWlSl42Sh
   A==;
X-CSE-ConnectionGUID: pa7nRkquTYe1ezaz9E3PHg==
X-CSE-MsgGUID: 7CFef4+2SuuC2PUB3XjO2g==
X-IronPort-AV: E=Sophos;i="6.07,180,1708412400"; 
   d="scan'208";a="186866936"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2024 21:37:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 21:37:14 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 21:37:02 -0700
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
CC: Dharma Balasubiramani <dharma.b@microchip.com>, "Hari Prasath Gujulan
 Elango" <hari.prasathge@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>
Subject: [PATCH v5 4/4] ARM: configs: at91: Enable LVDS serializer support
Date: Fri, 5 Apr 2024 10:05:36 +0530
Message-ID: <20240405043536.274220-5-dharma.b@microchip.com>
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

Enable LVDS serializer support for display pipeline.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Acked-by: Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Changelog
v4 -> v5
v3 -> v4
v2 -> v3
- No Changes.
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 1d53aec4c836..6eabe2313c9a 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -143,6 +143,7 @@ CONFIG_VIDEO_OV2640=m
 CONFIG_VIDEO_OV7740=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
+CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_FB_ATMEL=y
-- 
2.25.1


