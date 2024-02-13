Return-Path: <linux-kernel+bounces-63162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632C852BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B8A1F2522A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1853F22324;
	Tue, 13 Feb 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ks4+mMwp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC01B971;
	Tue, 13 Feb 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814603; cv=none; b=VWvptVJWCI2OZ9bk65ODJgXM7xbdDUo3Ot3dPzACfD0CLasIn9PZCGTWDKN3eNDh+hxMsmA3fdJ0hQZozbhvPGKczZuIIOf2PLzprUx17NveCBRJfhlmRZh5+PErxXnbiUhYiS/DkCsd6/RyLFonUO+N8IEgvVl3RScslGINu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814603; c=relaxed/simple;
	bh=lSx1r2xryKETv5g33mx8+S9nIQylyh29ftD7vemFgG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kg4AMHkeW/8NsOhmk+eHVYguKgsw0NH2pz1TZb55nQ+ovMMAzjBTJgxWkdKvCcDv0lMgohFPfWiyEvgg7OOlgIt8efuWHX8t+/dTXGHae1UyFjD/muPbuR4qySg+lcYhYrDLj84755s/mzawWzpGXwcV4mJr4zseUbpSrDZ6oxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ks4+mMwp; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707814601; x=1739350601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lSx1r2xryKETv5g33mx8+S9nIQylyh29ftD7vemFgG8=;
  b=Ks4+mMwpGDp/8Oyj+eqSZ30DJvI6ODFCyPjYq+J4ombeuV46H2ngJUGV
   lhue7wBZdNatqxzxCAn9tb/a3YuXsdbYx4TYbj5lCq6wtyeR7QJ/ePqLH
   usl4ZG78ebTrT/lj3Q2loMQ9mUioV+Nx+wbIBEA9v6mZvU63BzQvkfHE7
   efJtcTvBm9T3F1yUiMyx7ez9YG2mT7PjMrYaUDGwTRoTBghip5swPnraa
   WFYaKt6NuaXAIB27SVrDB5cMH77dJXy/G4hLPwZrZZn2fz9xi5MkExuZA
   XLl8VChJua3xAJLr0tD1HhIyeNjgzoSA7mSjlvEe6z6PdG4rZ+QgXmRtY
   Q==;
X-CSE-ConnectionGUID: Tcx08rzESzahUneDj9mfvQ==
X-CSE-MsgGUID: mFDW6cKMRoCDNRuyOhGWbw==
X-IronPort-AV: E=Sophos;i="6.06,156,1705388400"; 
   d="scan'208";a="183422419"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 01:56:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 01:56:29 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 01:56:26 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<andre.przywara@arm.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Date: Tue, 13 Feb 2024 10:56:13 +0200
Message-ID: <20240213085614.26804-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213085614.26804-1-mihai.sain@microchip.com>
References: <20240213085614.26804-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add flexcom 10 node for usage on the SAMA7G54 Curiosity board.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7g5.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 269e0a3ca269..c90e404e8ed9 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -958,6 +958,32 @@ i2c9: i2c@600 {
 			};
 		};
 
+		flx10: flexcom@e2820000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe2820000 0x200>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 48>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe2820000 0x800>;
+			status = "disabled";
+
+			i2c10: i2c@600 {
+				compatible = "microchip,sama7g5-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 48>;
+				atmel,fifo-size = <32>;
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(25)>,
+					<&dma0 AT91_XDMAC_DT_PERID(26)>;
+				dma-names = "rx", "tx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				status = "disabled";
+			};
+		};
+
 		flx11: flexcom@e2824000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe2824000 0x200>;
-- 
2.43.0


