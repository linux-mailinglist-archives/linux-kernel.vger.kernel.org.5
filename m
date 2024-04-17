Return-Path: <linux-kernel+bounces-147861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840158A7AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F056E1F2220B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B363CB665;
	Wed, 17 Apr 2024 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RNj5XW4U"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768E6FBF;
	Wed, 17 Apr 2024 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321762; cv=none; b=b6sd78MXoNiU0efOwNYZccR0FfLML2QMH4w/PxKFogOAgMxjlW2nrFudSD/22HNrv4hPT4tJNg+8FMgxcHsf9usNJ2PftzZukDlfXE7hvFdfWCsZeCBNXcSVsFpmRxUyo5W99OOCXUAQRzzmufW3JDo9p9Q/r3uXnzfLQKEEmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321762; c=relaxed/simple;
	bh=goGGs6Qp9Tc+FkcaAXqOOsCkNMDrE5spBraGeJFsMKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=um6hcn2x37xffNONGIupk2eE9QxZY/OWiS+ae5kRYLEGVwC37D+9O/3r2uK894u7sLcxC//oPI/ng6ETiw1b+kHbAIPvtjEkmFb5Hz3CFAN5+fPPvd2Kxzez3nF5v3/5eLxgb6YPwkFHHBNMFlPGSfq7QwRqEPAmxSp1WPxvSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RNj5XW4U; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713321760; x=1744857760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=goGGs6Qp9Tc+FkcaAXqOOsCkNMDrE5spBraGeJFsMKc=;
  b=RNj5XW4UBIXzCuyP0KTHCRxaa+YTRCYf8QomcTDUZPQx/MxEHiuwU2/v
   wOxobKKqXhKcsBUx5vLhT7XgLwfkF9XvLiLmnPxxdTthE1kSbZzJcHXRS
   keDWTo6p4iHbUVHiapoHx8fRLMvMSXmiQP8o+tMcje1MZ9p9lLxQrUNVF
   ceHqIwPoYfJTPZn/TR7MompUoSQSntXCrJno7CcvM4+a8yfVg5ktcXasB
   W2qiSsCfAOLuEoPxTAQH+mUYjbuirn8Kc3u68w4zBqlnD2PG1FlcM5s4R
   AqDsERieCDcvB1P6DunWQJixSwjnIlzaJXCnJh/L4nr2aY5q/wRLfMREG
   Q==;
X-CSE-ConnectionGUID: ts5yT8NnQNWB+QLFSWVn+w==
X-CSE-MsgGUID: c+22nOXKRialMAC1qQZcKw==
X-IronPort-AV: E=Sophos;i="6.07,207,1708412400"; 
   d="scan'208";a="21373558"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 19:42:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 19:42:08 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 19:41:58 -0700
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
	<dharma.b@microchip.com>
Subject: [PATCH v6 0/4] LVDS Controller Support for SAM9X75 SoC
Date: Wed, 17 Apr 2024 08:11:33 +0530
Message-ID: <20240417024137.144727-1-dharma.b@microchip.com>
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


