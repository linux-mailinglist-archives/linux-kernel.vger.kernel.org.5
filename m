Return-Path: <linux-kernel+bounces-120653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DF388DB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F973298F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F914AED3;
	Wed, 27 Mar 2024 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xlB1du6Y"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435F481D8;
	Wed, 27 Mar 2024 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534676; cv=none; b=U26PuDSrZ5g5whtdmNeQWjjzOMMFWWVmt/8UqcQIBhCzbN85abogrJ1M5R9QuPyeTde46Ogn935XLk2h52ND7fAPWH38muIsAW0nTRB6HmqsT69H77ub80HbvtyJlX3cshlPiWIzhd4kHdEL/HRImR5+EW8/0g148dY9IvIqiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534676; c=relaxed/simple;
	bh=meZVXxB/+eza9W20VEGVYt8KjDSVMR9MhQbI4gUA3G4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gPqHea7iZfAHCxgv1uJqIMq8hDrWsaMaURu8ekKB+YW6nbS1ZPV13Gevi+SvbZ5jSa7RsHWuSBVlNhubwysMSVo0QlOXdif6YUPK4x0WcyIVbs34Rp9CGpuexxRJvKkqr+n2FuI2cyuShdz0AK5Gd4pY2IoO/7KyTzMhwHJA37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xlB1du6Y; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711534675; x=1743070675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=meZVXxB/+eza9W20VEGVYt8KjDSVMR9MhQbI4gUA3G4=;
  b=xlB1du6YyReNSvOsJufS9ppKqDwNTOOY48/20LlMmFgwc1PpLOilmg0g
   QU6tLs57D7azulSm6WUvfIjkmDmjOVZHOoiEcwWcqm4l44ygG2DFxthBA
   k1zfWl02v/jDe6ssQmw2dOch7HgqVnY3PmCx2ZPcAASSegIIzXBFmtCYz
   hModebuTP8BpaRKtXoNfABJ/sHBBPT30nWSHOh3G8/4e2TJouNguCESWq
   IoscYcI4stfz7h7gARb0fOUwy4FDNI2DReYLZvD6WaS1ergrbcSvspmxa
   vrNUTtxIBnoy0zLQHkUcUyioowif04nVjUwLcju2mrEw9FBSY1VBAz1ba
   A==;
X-CSE-ConnectionGUID: GEGGSL7fQXKvsyXMqFOqyA==
X-CSE-MsgGUID: Fl+rkdiOS4eMSOQMC8I6oQ==
X-IronPort-AV: E=Sophos;i="6.07,158,1708412400"; 
   d="scan'208";a="18378622"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2024 03:17:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:17:38 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 03:17:35 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <andrei.simion@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 0/7] regulator: mcp16502: Update the names from buck regulators
Date: Wed, 27 Mar 2024 12:17:17 +0200
Message-ID: <20240327101724.2982-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Use generic names for buck regulators to avoid any confusion.
Update the names from buck regulators in order to match
the datasheet block diagram for the buck regulators.
Using BUCK1-4 as node names is consistent with the node naming rules.

Link: https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP16502-Data-Sheet-DS20006275.pdf

Mihai Sain (7):
  ARM: dts: microchip: sama5d27_wlsom1: Update the node names from pmic-regulators
  ARM: dts: microchip: sama5d29_curiosity: Update the node names from pmic-regulators
  ARM: dts: microchip: sama5d2_icp: Update the node names from pmic-regulators
  ARM: dts: microchip: sama7g54_curiosity: Update the node names from pmic-regulators
  ARM: dts: microchip: sama7g5ek: Update the node names from pmic-regulators
  regulator: dt-bindings: microchip,mcp16502: Update the node names from buck regulators
  regulator: mcp16502: Update the names from buck regulators

 .../bindings/regulator/microchip,mcp16502.yaml         | 10 +++++-----
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi  |  8 ++++----
 .../arm/boot/dts/microchip/at91-sama5d29_curiosity.dts |  8 ++++----
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts       |  8 ++++----
 .../arm/boot/dts/microchip/at91-sama7g54_curiosity.dts |  8 ++++----
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts         |  8 ++++----
 drivers/regulator/mcp16502.c                           |  8 ++++----
 7 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.44.0


