Return-Path: <linux-kernel+bounces-52456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB153849875
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53523B28941
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD693182A0;
	Mon,  5 Feb 2024 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Rtc0vSm8"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2718E00;
	Mon,  5 Feb 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131218; cv=none; b=Q37PvUtnIC/l+NobiTnlMAUnMz5euUSWxa6FGGFRxMbASYTUOVPem8BZbjnnD43QxT9Rhjpe4SAQss5yyB5Tf1f+YwjdqqSMy9MYfio07S+pr2I2x+bcjDtzogL2TAoH00HcHUBYhci8Pqwv2dH7dt2M/ZCpGrHZCyW0F2GaIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131218; c=relaxed/simple;
	bh=3rCNCUKLYlrAoIsQbOwPSf3Qa0Qegu2i+J6MmKcKEEo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aDXvTwjMtxq+NdmPTheyy+hhuwE2j8LlpkK+85CdYhMwsd4qlGZIpcexKiigwXOiZyDI3wJe0Pt7qQICPuy0cIPLY6N1ADwZIkacYRB56ooLdVl70A0HCeu0vJtXqGhPZTNcVBx+kNvktXEDKCze9CCcUqaVxad/8cuo+i780OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Rtc0vSm8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707131215; x=1738667215;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3rCNCUKLYlrAoIsQbOwPSf3Qa0Qegu2i+J6MmKcKEEo=;
  b=Rtc0vSm8nhRuww0PwroC7rmxWyZb+MWF3AvFXWzZzDAQfEtYopYTUAgJ
   WEZh3yNxA+kukcQgvAvzbc8l8ja/cYJfwxoo/7hMnVihTuhC5NCmki3lS
   wQnhY6A9Bk2tcQIeYXbqLOxWwWdrGsqOkl+/2MmlxcKfviy2dtilevO0P
   KXMcW1YPoDYWjP1CYTOQCrphDHkvFv6N/oIKRV2weoVyxCSCgl7vWWXOy
   F/6jQ4gMyPIxom8UgsVYE7M6Z4qnkKE3zHolHiaF/8fUmOiE2Yy6kqbsz
   XxtP/qFJXS8LMytOUfgsitkljklwK7bDMSwcZTfgfzvnjRwUHetAxtXFs
   w==;
X-CSE-ConnectionGUID: FEqgJhxtTaO3jnO98/SSMw==
X-CSE-MsgGUID: nGV+Aur5RZ+j54PKV0YDZg==
X-IronPort-AV: E=Sophos;i="6.05,245,1701154800"; 
   d="scan'208";a="16285286"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 04:06:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 04:06:24 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 04:06:13 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <dharma.b@microchip.com>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <geert+renesas@glider.be>, <arnd@arndb.de>,
	<hari.prasathge@microchip.com>, <Jason@zx2c4.com>, <rientjes@google.com>,
	<rdunlap@infradead.org>, <vbabka@suse.cz>, <manikandan.m@microchip.com>
Subject: [linux][PATCH v2 0/4] LVDS Controller Support for SAM9X75 SoC
Date: Mon, 5 Feb 2024 16:36:05 +0530
Message-ID: <20240205110609.217022-1-dharma.b@microchip.com>
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

The Individual Changelogs are available on the respective patches.

Dharma Balasubiramani (4):
  dt-bindings: display: bridge: add sam9x75-lvds compatible
  drm/bridge: add lvds controller support for sam9x7
  MAINTAINERS: add SAM9X7 SoC's LVDS controller
  ARM: configs: at91: Enable LVDS serializer support

 .../bridge/microchip,sam9x75-lvds.yaml        |  55 ++++
 MAINTAINERS                                   |   8 +
 arch/arm/configs/at91_dt_defconfig            |   1 +
 drivers/gpu/drm/bridge/Kconfig                |   7 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/microchip-lvds.c       | 246 ++++++++++++++++++
 6 files changed, 318 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml
 create mode 100644 drivers/gpu/drm/bridge/microchip-lvds.c


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.25.1


