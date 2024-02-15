Return-Path: <linux-kernel+bounces-66505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD91855D95
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2381F2EA81
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184A514286;
	Thu, 15 Feb 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QtrlR8La"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F7813FEE;
	Thu, 15 Feb 2024 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988560; cv=none; b=YaOQzWlAcgKoWDCIqOcruaE73dSClHSqe0M8nGA+YT5OUBfT1Sx2FmXgZnpMASXfKlxP+0NVaCHIXTyck1XZR+EcIic2Y5MUpw7/JsMiL1VDKljrENQ5yMYOwcCwQxlZrx02yIi8wEyCSCgaN+Fn6CGQHfueDMT9EISOUIJROEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988560; c=relaxed/simple;
	bh=HSgyWNp4hNerWJS+3/wmyvmHBD4LaRAyLNLKhcn4MuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XOix+1f1YoF/HtLFK79286BIeyzj527//YVXEizvi1HkA/SesanFVLEZZqtDwNd06Xw0d3/JP3MOcYPgUJU+Bgw/YN8DqtKWUvS914KgXyQowuHAZdLOVpJJ3iW/V4O74QyFnraXTkaE/OwZhyRdwSmTX8389NdSUtIorTpxgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QtrlR8La; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707988558; x=1739524558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HSgyWNp4hNerWJS+3/wmyvmHBD4LaRAyLNLKhcn4MuE=;
  b=QtrlR8LaU4r+8puQdTKAbFCFhMnizJS8+OEnFsn8ACDtwkFBujhTbKCn
   ICBI2PnZ2B2V0p3syzzHWU1NgawjiBSlxHws6hL5ba1RYS4dQG2A415M8
   ugVAhrgidWQT/3oERrm0Xm/3lt20InmxrgglRHkyrrILQHg/IUinZTm/X
   bAtB02njFs6kiNUS5UmF2Ock8EBq2MQ6V5YoRWZp2cgtuW9xTpaOCe/Sl
   NzMFmAvrntH1ALcozxQEFku/5XDWIJs4WAhNRupjuwmvNH8laxHIRmPza
   hR3tNJfCOMnqqfLib1vDimf+16exhpvpYDtj1nkA4yoxd5EeNJkqqN5zc
   A==;
X-CSE-ConnectionGUID: KRer2CuFQguroFb+z375Pg==
X-CSE-MsgGUID: u4N86i9TQbaQ/ZwEU5aBGQ==
X-IronPort-AV: E=Sophos;i="6.06,161,1705388400"; 
   d="scan'208";a="183550553"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 02:15:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 02:15:30 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 02:15:27 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<andre.przywara@arm.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v3 0/3] Add initial support for Microchip SAMA7G54 Curiosity board
Date: Thu, 15 Feb 2024 11:15:21 +0200
Message-ID: <20240215091524.14732-1-mihai.sain@microchip.com>
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

Changes in v3:
--------------

* Update flexcom 10 node in order to match previous flexcom definitions.
* Use alphanumerical sorting in Makefile.
* Remove adc subnode from flx10 node.
* Use C style comment.

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
 arch/arm/boot/dts/microchip/Makefile          |   2 +
 .../dts/microchip/at91-sama7g54_curiosity.dts | 482 ++++++++++++++++++
 arch/arm/boot/dts/microchip/sama7g5.dtsi      |  24 +
 4 files changed, 514 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts

-- 
2.43.0


