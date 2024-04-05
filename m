Return-Path: <linux-kernel+bounces-132405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC88899422
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75161C2577F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AFA1CFB5;
	Fri,  5 Apr 2024 04:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="II5sgwYQ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23BA21;
	Fri,  5 Apr 2024 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712291818; cv=none; b=CrF/1SiTcSdKlVmnVu+1DPvbr2UQ55y2wUBMlK/WJrK7O5Tc7TKcNVTZZxzggti7YzuRg0HfvcSSLePopR3weKhWETFY/tscVAE2s7tST7Lc/fZo3mSiYvCjet9aSs+4ecuBZ8HTirFHeolpWDT2hLfLiEomYB9O5/1skg7qDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712291818; c=relaxed/simple;
	bh=goGGs6Qp9Tc+FkcaAXqOOsCkNMDrE5spBraGeJFsMKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uy7rSnTbp/4mNoeetRG1HowVpNJ94oy8y6BoUsbzYbykrvKppMmaTix8rs7kjpVs1GI34PRCKUCGvB6u3QPzD81ld8e6BAjVCtHsgNinVR07Bu56WbUiK5RdPDoi8WobVkruw9ya+DSY63EC55K6P+BY7/zGLXFoo8kuTgMc9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=II5sgwYQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712291815; x=1743827815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=goGGs6Qp9Tc+FkcaAXqOOsCkNMDrE5spBraGeJFsMKc=;
  b=II5sgwYQDc5HbSbTtqKIn0eNSYtS5oUKbD6BDeYgMgrDBTFMlknzExJ0
   klWWHFlt7eOG0LangLcNtS30lP+68qqC4A2JLxOUPfPlnTBef9uLKuyu7
   0X0xg2kORFUSuPEnXJLKK60gbmH7mIDRQ9h0d2fpksG/8dVyRz8PUlx0i
   5hkz/Q5PhfLrGka6+cPskp0+LHFTqB5iXgxYU65mEzPZVf3fpHv+3pN8P
   W7ACGorEM88Ta/C7i04EsmSZF78J+TgOVK/66tnoh8BvCeiYpNZpji9lN
   ttPhyhW2gffLZySBiDYb2cl6UJ6lK1Oq2qCNfwAjFMMwCKIbz6f9uJCev
   g==;
X-CSE-ConnectionGUID: I3x9LaISQ1uPgH0YvRkiJw==
X-CSE-MsgGUID: kwBJdMmISH+6c6LoaLiAAg==
X-IronPort-AV: E=Sophos;i="6.07,180,1708412400"; 
   d="scan'208";a="19541022"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2024 21:36:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 21:36:23 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 21:36:10 -0700
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
CC: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH v5 0/4] LVDS Controller Support for SAM9X75 SoC
Date: Fri, 5 Apr 2024 10:05:32 +0530
Message-ID: <20240405043536.274220-1-dharma.b@microchip.com>
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
 drivers/gpu/drm/bridge/microchip-lvds.c       | 228 ++++++++++++++++++
 6 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml
 create mode 100644 drivers/gpu/drm/bridge/microchip-lvds.c

-- 
2.25.1


