Return-Path: <linux-kernel+bounces-63160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B78852BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FFD1C22AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94F31B7F5;
	Tue, 13 Feb 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qdWIZLjD"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3C175AC;
	Tue, 13 Feb 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814601; cv=none; b=P1SfzbSjnTFiTReLnK3DQUGmgWFDLELYYdxoprlsvpZzad0oU9Ns5V29u4MPshj3Yr/yluuPGg8eBjZTi5LqkE/KNKsWvupPJWXQK6VZQr2pjJsS5gpsYSJJv9sApX2IWkagUTBAuqWVqIhKXGUt3sZgpTvY1Uvbyo4ma5+pFOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814601; c=relaxed/simple;
	bh=ZELX4+MLTKxtg9D7FUzdHL+NDEwTGDHqMEb4bZqJ/As=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UU1CT8AHdP3zES/P5RPzaIy9wZRiUv+I3GKutP3CxAa9mYSWokD4OEkbuxqGPI9TBKxqgAas8Gm6BbCwPpgE7JwKPqET6s2inBBst6YRdMkC5AIlYLUL3a/a7w20O4KBRjp30gTHwuAjvBVGic7RW+QlCp+Bn2onc0Z89XRyvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qdWIZLjD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707814599; x=1739350599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZELX4+MLTKxtg9D7FUzdHL+NDEwTGDHqMEb4bZqJ/As=;
  b=qdWIZLjDBujtJZirgKSi3LVpg4qmHgdm0YD7U8TYgI4DfLJvFHXxlczX
   9j3JOBH7+XcbQNWJuMgfQvyNggo7s63alAo3afMfLuE0iuUyO10ub5KUa
   i4OAN1AlMEK6nyuZio/FrTJ1oTQoQ32VILBk4yaiGebBBqRh+3yM12J5U
   4UZLtoW2iJ3erNrwZtND0BlDzy93i7QmLixZiC+1Ww7zR/Bk60QvWmArT
   t5eL27kHx2C5GBF3i4IEUCgNthwZ5xq1zEYT9B66tRVMByy9qA6AH+ndF
   kuxnJAzaESSDLs/EwuspCAtebSiEwdsKApNJs0hyJTbWLRlEzkj6DHRLE
   A==;
X-CSE-ConnectionGUID: Tcx08rzESzahUneDj9mfvQ==
X-CSE-MsgGUID: CnpQXNWuQdKhwFHE+fUijg==
X-IronPort-AV: E=Sophos;i="6.06,156,1705388400"; 
   d="scan'208";a="183422416"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 01:56:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 01:56:23 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 01:56:20 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<andre.przywara@arm.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 0/3] Add initial support for Microchip SAMA7G54 Curiosity board
Date: Tue, 13 Feb 2024 10:56:11 +0200
Message-ID: <20240213085614.26804-1-mihai.sain@microchip.com>
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

Mihai Sain (3):
  dt-bindings: ARM: at91: Document Microchip SAMA7G54 Curiosity
  ARM: dts: microchip: sama7g5: Add flexcom 10 node
  ARM: dts: microchip: sama7g54_curiosity: Add initial device tree of the board

 .../devicetree/bindings/arm/atmel-at91.yaml   |   6 +
 arch/arm/boot/dts/microchip/Makefile          |   4 +-
 .../dts/microchip/at91-sama7g54_curiosity.dts | 491 ++++++++++++++++++
 arch/arm/boot/dts/microchip/sama7g5.dtsi      |  26 +
 4 files changed, 526 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sama7g54_curiosity.dts

-- 
2.43.0


