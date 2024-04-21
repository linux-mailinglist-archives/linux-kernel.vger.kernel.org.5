Return-Path: <linux-kernel+bounces-152421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505BE8ABE37
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003111F2173D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6E2107;
	Sun, 21 Apr 2024 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Lq1J1tC+"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79E205E2C;
	Sun, 21 Apr 2024 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661918; cv=none; b=ptbl95ONfhf3/Rggj3Qf2scaQh1Rsixr7cTpV3xQKj8VttujaYtL+5nt/2K+Y5x02AtbAQan5CU8CmAXyuKE3KEK5RFfzzXfiiD/dUs38+UdTQ931mo09ih0N1gAqzqyswu5VxS38mOAaojTIm9QycVHSczOivh6+hzyHiY9xzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661918; c=relaxed/simple;
	bh=+NHndyStgBNaGg0Gu44NeibBjRQjp+j8aiNKkV+bNiI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=piy/i0eIadvxBhyV6vKFVxbWYGjui+yDWBQAvsCbGb9Ii0e6kRUMzTQy/VVmmT3ZIcLQg3JXfn1a9WIbtlfnqhecZ+IyIrNHCB3viUK2Pvv0dVR66D7GqC3jfpWIYgqUphpvDlBbNKlOGiSi97NIG8g+oETgPKX3Q8lqSpp2EIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Lq1J1tC+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713661915; x=1745197915;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+NHndyStgBNaGg0Gu44NeibBjRQjp+j8aiNKkV+bNiI=;
  b=Lq1J1tC+LYr8kQtapUDQV6tUZyiQrKvJ+uj6yZ0k9VRsMmB5/z8MdTsb
   L93zAifgqplgPo6hjwRWnkBTJ9IKehsQnmsr1PV792iybxn0E51EDUeK5
   1FCBzXDf48LGg5KfZS7/GfS8Yz8K+otVi5qnyQbbV2B66g79BuvTCAigc
   vHIks2uwU94vtsuk5W2gQ90c6fAATqYlJavl/Ics11gKJOSirjeWCvBWH
   rYKjg+P6Ztx5Nwlf0Y1wUKbSnS09eGPyKTFt2d2st8+Toiyl5RqW/o91I
   IRsAiNOg8hPNXAEKnff1acmIhoSU7dKDhkR45diTOIXz8tbYSSo4qbdOx
   g==;
X-CSE-ConnectionGUID: Z31Mwg63QjairJeGchYeZw==
X-CSE-MsgGUID: CoUCdzXmTfOWVot30AcwdQ==
X-IronPort-AV: E=Sophos;i="6.07,217,1708412400"; 
   d="scan'208";a="24025071"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2024 18:11:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Apr 2024 18:11:23 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sat, 20 Apr 2024 18:11:10 -0700
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
Subject: [PATCH v8 0/4] LVDS Controller Support for SAM9X75 SoC
Date: Sun, 21 Apr 2024 06:40:46 +0530
Message-ID: <20240421011050.43265-1-dharma.b@microchip.com>
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


