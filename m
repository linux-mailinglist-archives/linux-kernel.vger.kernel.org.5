Return-Path: <linux-kernel+bounces-56315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4684C89D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C68E1C24EB6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E825602;
	Wed,  7 Feb 2024 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1t9zwcym"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC212560C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301723; cv=none; b=cbRXHz+D4IECoNZnkxq25X9ujJ3zjLGEeWBNm+SEPgc55qZfAh9cmXSIfKMl8zCx7q3Wx/uY5aMkegycNN7rWA6Ujufya5cvSoERW835u+18cp1bqmvLtMjaeekqY7BNQMJ3LCL6P2HG/b2Y4o+EfgiDULoTlzmF/8IlKdYcdYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301723; c=relaxed/simple;
	bh=iLby45AfXsf1+FGAeEA+KBmo2FnjvHkdZA8p3CT5tRE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gWMbHpS8sf1QmN+KtIt3PJarPxwj4W5s/njgv6W2QDjqBLAll9w1PRDWg50K0e4yxSQ4gqNR9sKk9YbSb+2GodZK4ErWoYfALhQmO237eI34FNYuayA1K9pTBg5y/24NeNfJLU35Wur48XyE3bXspXks0oWbrfohS1dnYOYxITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1t9zwcym; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707301722; x=1738837722;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iLby45AfXsf1+FGAeEA+KBmo2FnjvHkdZA8p3CT5tRE=;
  b=1t9zwcym9F/f9FjTFPw5CpHRq3WtzCOpN6h2qdY567Bi3PsGOpQgCVJa
   jsV/loFrI/z+Gd0pym8Ai0cZQ3EpCcie8/6pxsStxlAqlrWSpb0HiHTZR
   d0gzKHqzG41idcZyk3iXF0aOn4Z167s/a0L1+mtS7jH6FR8iZj8DC2nSz
   S1p2SNW0CYp/ndNk8PN4skot+ml14pn2b+HWpvNLhLAdzCFtEvskLZPb8
   aC8jfUXWIiJWoXi9uN+04f7fHBX3Q5TvFZPb0UAvbk3yP+XLj2Hr2KySK
   ZfcR5v6IwIgUom3lZE0zTtrvenGl+nnsuUD+EgOLVo4vFNqFWbvhvl6V3
   g==;
X-CSE-ConnectionGUID: JxZ+DPsRTh6mZRhRbF3CqA==
X-CSE-MsgGUID: ImjuAnsXTKawQo4rCn1Hdw==
X-IronPort-AV: E=Sophos;i="6.05,250,1701154800"; 
   d="scan'208";a="246623769"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2024 03:28:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 03:28:15 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 03:28:05 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <dharma.b@microchip.com>,
	<manikandan.m@microchip.com>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <geert+renesas@glider.be>, <arnd@arndb.de>,
	<palmer@rivosinc.com>, <akpm@linux-foundation.org>, <gerg@linux-m68k.org>,
	<rdunlap@infradead.org>, <vbabka@suse.cz>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/4] LVDS Controller Support for SAM9X75 SoC
Date: Wed, 7 Feb 2024 15:57:58 +0530
Message-ID: <20240207102802.200220-1-dharma.b@microchip.com>
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


