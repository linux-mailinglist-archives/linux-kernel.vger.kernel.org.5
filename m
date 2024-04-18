Return-Path: <linux-kernel+bounces-149755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289258A9574
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E445B21D66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020515887A;
	Thu, 18 Apr 2024 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GZJJ04iM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD39F1E498;
	Thu, 18 Apr 2024 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430697; cv=none; b=tKppVCoivXd6bv0B4Iq8MKBpB6wcmUFnsLVECyiSxHN3pNk5rJLQlA0BBrUUwLWn3g9pYEDRrhoy9oqL0JbBrQBBYObNl91+3it0Gjyy6+Q8yFirIL1fOxmr3+nmMKISWPalrzaTbiXjstfFyMEf/a7b66w6rFt68zgm0GYBchE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430697; c=relaxed/simple;
	bh=+NHndyStgBNaGg0Gu44NeibBjRQjp+j8aiNKkV+bNiI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FPcmHa7Ro8lS+6xkBSr4K6GzLyXG9rypivYvN901aa5fKgi5hKXT2H48XVt4YvgS434+2UYFk1P+j6gZqco68N1MyIefrIwwYwkGJYtf1TRh3J7ZQ590AQC7S0ptJKEPNq04pLB6D7jO0L7zsWt9DDGlIMw8mNoM04vWv737Mjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GZJJ04iM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713430694; x=1744966694;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+NHndyStgBNaGg0Gu44NeibBjRQjp+j8aiNKkV+bNiI=;
  b=GZJJ04iMjkaxMe28V9vUj8qOE5F9oL/pEbT8Lv11kUVDynXYYsPUci+A
   hSuh3W2MOZZAm3f29iEv+zCBP2VpwmQsy61lLk4p1GayMEPZlH9reVyav
   iynoFdiBzHQpA864I8UJ2ah31cLRdmjEKFrQeTm0JrrCBQOS6kBiB4Bh9
   EbggCPUzq0OZzbJHO5PeFjR10VtYVU+eRcCplzHI3geYEjzQFwR9G+iMk
   kfjN+zRKX1qG9HjxFwTFn993fuXOqi73DrUFuRplKdhn2SiR5Qm4cU1Z0
   +zDnAu3ZjN9INmHSvNWgiByRkGZgnqcza/EeHrEf3TcQ3qAi0NeTzO9IP
   w==;
X-CSE-ConnectionGUID: iLCxEmpnRg6xON07P7n66A==
X-CSE-MsgGUID: riTDQJH0S2CtnfOFsFMeNw==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="scan'208";a="188866754"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 01:58:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 01:58:09 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 01:57:57 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: "dmitry . baryshkov @ linaro . org" <dmitry.baryshkov@linaro.org>,
	"andrzej . hajda @ intel . com" <andrzej.hajda@intel.com>, "neil . armstrong
 @ linaro . org" <neil.armstrong@linaro.org>, "rfoss @ kernel . org"
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
	<Manikandan.M@microchip.com>, "arnd @ arndb . de" <arnd@arndb.de>,
	"geert+renesas @ glider . be" <geert+renesas@glider.be>, "Jason @ zx2c4 .
 com" <Jason@zx2c4.com>, "mpe @ ellerman . id . au" <mpe@ellerman.id.au>,
	"gerg @ linux-m68k . org" <gerg@linux-m68k.org>, "rdunlap @ infradead . org"
	<rdunlap@infradead.org>, "vbabka @ suse . cz" <vbabka@suse.cz>, "dri-devel @
 lists . freedesktop . org" <dri-devel@lists.freedesktop.org>, "devicetree @
 vger . kernel . org" <devicetree@vger.kernel.org>, "linux-kernel @ vger .
 kernel . org" <linux-kernel@vger.kernel.org>, "oe-kbuild-all @ lists . linux
 . dev" <oe-kbuild-all@lists.linux.dev>, "Hari . PrasathGE @ microchip . com"
	<Hari.PrasathGE@microchip.com>
CC: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH v7 0/4] LVDS Controller Support for SAM9X75 SoC
Date: Thu, 18 Apr 2024 14:27:21 +0530
Message-ID: <20240418085725.373797-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series introduces LVDS controller support for the SAM9X75 SoC. The
LVDS controller is designed to work with Microchip's sam9x7 series
System-on-Chip (SoC) devices, providing Low Voltage Differential Signaling
capabilities.

Patch series Changelog:
- Include configs: at91: Enable LVDS serializer
- include all necessary To/Cc entries.
The Individual Changelogs are available on the respective patches.

Dharma Balasubiramani (4):
  dt-bindings: display: bridge: add sam9x75-lvds binding
  drm/bridge: add lvds controller support for sam9x7
  MAINTAINERS: add SAM9X7 SoC's LVDS controller
  ARM: configs: at91: Enable LVDS serializer support

 .../bridge/microchip,sam9x75-lvds.yaml        |  55 +++++
 MAINTAINERS                                   |   8 +
 arch/arm/configs/at91_dt_defconfig            |   1 +
 drivers/gpu/drm/bridge/Kconfig                |   7 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/microchip-lvds.c       | 229 ++++++++++++++++++
 6 files changed, 301 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml
 create mode 100644 drivers/gpu/drm/bridge/microchip-lvds.c

-- 
2.25.1


