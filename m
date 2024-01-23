Return-Path: <linux-kernel+bounces-34898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F07C8388FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAC928BCDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F90D5677C;
	Tue, 23 Jan 2024 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GWOychwp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4657896;
	Tue, 23 Jan 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998764; cv=none; b=jDYXBpq3XoNIrRTYT9GZSK9qCdS1yA9oFZzwbsmfQw7EA6pw2jxNRbkHnC79CPB/KrMORGdV0fWMTm7mBoza+uxsAQrU89icmpzlO/H5Lg3nBFgZIZSpD+v/PSePar7bsRjGKm0Myo12baVh3xVzhHo8ldbEMIYiTyzY9HxzyEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998764; c=relaxed/simple;
	bh=XI1MTmtT/icizKXuTfC04bbS584NolAC5j+SsbbXVTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k8y1Pg6R9svnEm86y0DEEmY2oDQs+1Ip72a7u4zt4plUYp5jXXQorPLSVasB5RyZRDe6k6p0XuMWBtfZYfK510k9BuFK4MbhpH1LjeIIXCOwYRTsVUuWx/DXqCgAjfnpKCKu1+Lj4bxvL2w4x2v1euJALrFE5s+ddhXU+DrU/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GWOychwp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705998763; x=1737534763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XI1MTmtT/icizKXuTfC04bbS584NolAC5j+SsbbXVTw=;
  b=GWOychwpHUkJEIzpmXHYWq+3O161KemZ33Y1kpmjWZMZGUMHsICeJ6dt
   elknerUPJN+selaAS+MZ2EE5HESKUfRppRaTqmufb/xcaZBb8QElc5PH1
   fskdcZrouMH0o9g2Oc/YSZ2CmBm7bFcwIUWKA3NbJQK2sHmAqmeFXE7xV
   Joy8S0XuTNy99IgINRDZCwH/dO49J5UakmncVT0hUfv5rDii6GfW/r9vS
   +d9UuklaQOVnzQfDVGL+me0XINZfpcPTrmRJrMsxGF65y5enXlvc4c3yU
   FO12C0ekz9c3Yj76VZUQ4uYCY75ZbgSD07/X4FN+8Q0m+9fZ43mXUKCBQ
   w==;
X-CSE-ConnectionGUID: d5ZmezpQQju+JS/ZUCZJPA==
X-CSE-MsgGUID: b0tkYdbUT3ydODPx9zMbXw==
X-IronPort-AV: E=Sophos;i="6.05,213,1701154800"; 
   d="scan'208";a="245869075"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 01:32:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:32:23 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:32:21 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 0/8] Add power-supply properties for sdmmc nodes on Microchip boards
Date: Tue, 23 Jan 2024 10:31:50 +0200
Message-ID: <20240123083158.7339-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds power-supply properties for sdmmc nodes on Microchip boards.

Mihai Sain (8):
  ARM: dts: microchip: sam9x60_curiosity: Add power-supply properties for sdmmc nodes
  ARM: dts: microchip: sam9x60ek: Add power-supply properties for sdmmc nodes
  ARM: dts: microchip: sama5d27_som1_ek: Add power-supply properties for sdmmc nodes
  ARM: dts: microchip: sama5d27_wlsom1: Add power-supply property for sdmmc1 node
  ARM: dts: microchip: sama5d27_wlsom1_ek: Add power-supply property for sdmmc0 node
  ARM: dts: microchip: sama5d29_curiosity: Add power-supply properties for sdmmc nodes
  ARM: dts: microchip: sama5d2_icp: Add power-supply property for sdmmc0 node
  ARM: dts: microchip: sama5d2_xplained: Add power-supply property for sdmmc0 node

 arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts  | 4 ++++
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts          | 4 ++++
 arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts   | 4 ++++
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi   | 2 ++
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 2 ++
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 4 ++++
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts        | 2 ++
 arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts   | 2 ++
 8 files changed, 24 insertions(+)

-- 
2.43.0


