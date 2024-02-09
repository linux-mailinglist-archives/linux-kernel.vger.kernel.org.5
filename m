Return-Path: <linux-kernel+bounces-59508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC7B84F82C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33BA1C2351F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CE56EB58;
	Fri,  9 Feb 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="01DdIuZF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25952E3F9;
	Fri,  9 Feb 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491323; cv=none; b=UagaFma98S7rcRp/XaFA4ADendkz3Izb9kUZ8/eA673eKzdrlD0Vl2Znm9KJTcH1+boazU2jS60JXjmt6DA8GYgV/R3I0dN5BYpB/HkWLGg7QPDzTvLZIjSl8GWsSDWn717kafTGlr2LugG03P9K+Wlvq12MDgdDb+vtC3TxX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491323; c=relaxed/simple;
	bh=cgrbif3MXR/BTAiL2rEDJWkpNWY9QqVDn209knbW238=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2xwRZMmmI2ZquetV8cVlv6Gj+DqSP/lYbkuR6xNVlq/dKnm4abTIhizRj2d0rqqdRW+QN5qcz5CUPEH+iSId0fGIIqDEZAsZJi6KV2HnAcZYShbgmrywiusGza7JU5viFZdzK1l/iFxf4k3qRoU6nc2tVuwf6aymPb6ionArKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=01DdIuZF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707491322; x=1739027322;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cgrbif3MXR/BTAiL2rEDJWkpNWY9QqVDn209knbW238=;
  b=01DdIuZFjBfiAsX8hMeNt8XDwPOhtIxwINMUeeduNbHV1zyHSGqcPE4P
   78LtjkiAkGdQcAyrF3L1hGnyidMvtJdaLxVCeo4Pc40Kx0cR7LFqw/d9a
   czbPAdPqAviRuqqMC/N7GPEptHSGE3SMEyHBWH/AurGXJBOAgFJFMdlrJ
   u1tvlvL5hajdNiDsU7GfBQNgUKMKjPhmORQZAtVeJIMxkZXFfpfnZ+aPR
   GutHS5x5zzJmr68+3efoAcESZFi3MzK047ASM8pHjIhtfHYNlaSpyba89
   GFYV49m6C97gVuNlw5yGBMNkJndOQOExefYQE/OO2mCeLkxmrpAdujOY0
   g==;
X-CSE-ConnectionGUID: KIIHkk3fQjqBsya5fSn4qQ==
X-CSE-MsgGUID: hxyDI4lESH2W5w9Pl05HTQ==
X-IronPort-AV: E=Sophos;i="6.05,257,1701154800"; 
   d="scan'208";a="16014537"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2024 08:08:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 08:08:12 -0700
Received: from che-lt-i70843lx.amer.actel.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 08:08:01 -0700
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
Subject: [PATCH v4 0/4] LVDS Controller Support for SAM9X75 SoC
Date: Fri, 9 Feb 2024 20:37:53 +0530
Message-ID: <20240209150757.66914-1-dharma.b@microchip.com>
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


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.25.1


