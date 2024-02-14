Return-Path: <linux-kernel+bounces-64856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF88543C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C49B1F24604
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8798F1428B;
	Wed, 14 Feb 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F0WPKLEl"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B312B8F;
	Wed, 14 Feb 2024 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897862; cv=none; b=Rijw0q5lfr176gPea9Xe0Fq/gaYzps+YCBzDOdP7Fj/3aXB7Fd7wsMyhNGIMe3Ew9zupNGbs+x/3YnENUClbJM15QijzLM6r1noonLg5zm8Fu6Tgy5v1XgoMPdOvrvgh2uNt7JiFZkD7qKy0xRmvC6gX9nZ+rXoKY4cU0/X5ag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897862; c=relaxed/simple;
	bh=lSx1r2xryKETv5g33mx8+S9nIQylyh29ftD7vemFgG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hy/6XeFqRKn2posQjf+6RsivbsIF1CmkU8IqZDiPcM3qbJuWerBkHgD9KkbknYl+wXXKPB8uO+6SO/jEP7aBlTR1Kqopg3QXZNyq+Ev6GBb8v8SscZ3T0p8ptlzefc7hPfpa0VstAVFY1xBEqGIUksKZuaq+tIYEmUloI+K4jds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F0WPKLEl; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707897861; x=1739433861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lSx1r2xryKETv5g33mx8+S9nIQylyh29ftD7vemFgG8=;
  b=F0WPKLElrc7sjvcpMqoKPteqIVesprS106XHCeCBN86HR2ZcCGKJTzBG
   pxM2IrN7r1xPqeZ6ntoUwv8CcGdiWC4URxpv3hJshHu3e1sMMK9DWNE6q
   BzOTrcLw7dc2bkjekYzBMcbd8b2omnpFpSVq7UfTxTmei9Nk4M+KJju+L
   JnwHk2wLeuBFHHeMwRW/UbrVAijKGIKOgZv/moXSD1nnXWzc3MrGe5Ov7
   R9cYlu2dJxBhvFJ10bs/1vJFflxHBauwFBD8EAsS6FK+y9eCWZwKR/Iti
   J+CLtu/7QjC6OUUrj8rJhzz2FUo93p28AjKjElG5GBgL6zPThvrXs9mdR
   g==;
X-CSE-ConnectionGUID: 5EMCBeoZQRC2nXyc/ouEeQ==
X-CSE-MsgGUID: beIlTBYAT0e2vJ0mBzlCJw==
X-IronPort-AV: E=Sophos;i="6.06,159,1705388400"; 
   d="scan'208";a="17666784"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 01:04:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 01:04:02 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 01:03:59 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<andre.przywara@arm.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Date: Wed, 14 Feb 2024 10:03:47 +0200
Message-ID: <20240214080348.7540-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214080348.7540-1-mihai.sain@microchip.com>
References: <20240214080348.7540-1-mihai.sain@microchip.com>
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


