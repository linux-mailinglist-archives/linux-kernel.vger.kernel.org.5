Return-Path: <linux-kernel+bounces-64854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D848543C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D82D1F2467F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C112B60;
	Wed, 14 Feb 2024 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Mzq4aFBA"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EB11C80;
	Wed, 14 Feb 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897859; cv=none; b=ZthvqBSC9dE43nzEi/mBcwJ7KQbUSmcTrqELfHuKl50tNWI1e6L1Sg/1E5DLm02ZPeYV3MdGFD3Yrt6AzpKGTdNJ82DReS0X8s2BmHNy0EO3f07l/F4V5Vi3S5XX9WVwNPhO4PYJB5Jp2hYL/7vRL8ggtOBLL2rkGBrJkmCLvYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897859; c=relaxed/simple;
	bh=DUP0bjlDiDxEt7EBusweiwjiFrBmZVWOoGBRTMCwIeo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qs1NUxkDwS1MOYNOyc41SMvOetauIMDEkVHVSQJWxIkz6QgbsZTocg8wwUPC0hLgxGeEVfwPh8TbGTCbK/KZzyVJegtGBJuOojJ8QJZVK216ReXUyoVdW/LwSBoEt0Rz7kvAVLZpbMIk48c6q5MJoCgpLYweHtBXEOZJViajTZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Mzq4aFBA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707897858; x=1739433858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DUP0bjlDiDxEt7EBusweiwjiFrBmZVWOoGBRTMCwIeo=;
  b=Mzq4aFBAtzpKRjuItGpVgbb1sNAkzGFVrc/Z71pFXX6XJl1w9vNDMfSH
   ws89igI2pI7y4GfwB+5J3Ihy/nOoe9sZ5OF8jEGF2ScNRgIvaeJjA9TFX
   MUKGNOlATTA01DL7rnzFxpYuoAS1Oumpkuozq2uvJ3KWHP+IaITZwAQGT
   xnqEB7AXhhLJZKl+jaNwA4+yDz5vnLR9w301c1t8R1p+o1PMx+jPGyF1t
   12n6++gZ803CHBx3rlea22NK7KXbde8bnNWjc75CGHYCGj/Uhfkni7Tq6
   cPWuLe89S/C9AHaYuzcyM/ybfgcy+R53pFTkxD+mXQWb4WQNXBwYiNXIQ
   w==;
X-CSE-ConnectionGUID: uXOR+YopRZ6oLQavHYuSyg==
X-CSE-MsgGUID: JZh0of/fT/KSDyDsVN33Yg==
X-IronPort-AV: E=Sophos;i="6.06,159,1705388400"; 
   d="scan'208";a="16216868"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 01:04:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 01:03:56 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 01:03:53 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<andre.przywara@arm.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 0/3] Add initial support for Microchip SAMA7G54 Curiosity board
Date: Wed, 14 Feb 2024 10:03:45 +0200
Message-ID: <20240214080348.7540-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds initial support for Microchip SAMA7G54 Curiosity board.

Changes in v2:
--------------

* Remove bootargs.
* Use phandle style for clock nodes.
* Use color and function for gpio-leds.
* Remove status okay from leds, nand, eeprom, pmic, flash.
* Use generic name like pmic for mcp16502 regulator.

Mihai Sain (3):
  dt-bindings: ARM: at91: Document Microchip SAMA7G54 Curiosity
  ARM: dts: microchip: sama7g5: Add flexcom 10 node
  ARM: dts: microchip: sama7g54_curiosity: Add initial device tree of the board

 .../devicetree/bindings/arm/atmel-at91.yaml   |   6 +
 arch/arm/boot/dts/microchip/Makefile          |   4 +-
 .../dts/microchip/at91-sama7g54_curiosity.dts | 487 ++++++++++++++++++
 arch/arm/boot/dts/microchip/sama7g5.dtsi      |  26 +
 4 files changed, 522 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts

-- 
2.43.0


