Return-Path: <linux-kernel+bounces-66507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20841855D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514CB1C22159
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242C81798C;
	Thu, 15 Feb 2024 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="evAvT0SQ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C39816430;
	Thu, 15 Feb 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988563; cv=none; b=cwSlYXYEi0RjV4gDR0refgbVoI/M32f/irbPnT6TFRdxyBRuPQw+GNLEC6xtM0VtYhQYBIbv6yKHZSzaQR61wmUW7p8s+4u6Tbz2Pt2vQZBpXWsSJ184WqrPLP+qN0zuP6uhgFC3XOQUXgkHcRA/N6t6gWTDUDqGAPBm8pa0zEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988563; c=relaxed/simple;
	bh=mpAIdYIZdLlbXbUTnkpoAZC9mXd6lxjFuCW9oFcNu6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2IFCmZPCJT3i2FCJ5ZDDnX5RxPZF3t0mRNTsQhg8IBrVaD9yZ8QZftnheNkLRfdCTcF9M1whieiJIC6CwD35VGF35jQFP5yzdtfPqVhU4eZO76mUpaK+mO4B+VzGXvPiSnX9uKHR+SL465YjfyQo0nRxZnscdn5nEtAFjWQZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=evAvT0SQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707988561; x=1739524561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mpAIdYIZdLlbXbUTnkpoAZC9mXd6lxjFuCW9oFcNu6g=;
  b=evAvT0SQEjcQ+N0Cq9fm4TLejrqCeMhNhtLMHX++1bLthOr8FC18rBr0
   qdUisVm0CEQjZu1XzSvyO27uwnSuRjB8kwk0n4868Gmr70QafV0FcOOsa
   ydiwt14nIeEFJCoge6ppvd9wbUSD77OZ7Tev5rRLf8okhIwxGgll04oOJ
   wKV3a8PTGdkofWaJ7yhT+nKjCG5o4D1ngGzAwL87sdqAKkb+phvWpILTq
   hqtUPlzXBNyEd4g6xG6XeZ02XYHNsa3LqGrBF8WW07eFomZ0sgO6kwT65
   opEqCX87YZvHTXBwF4Oxfk4vg7KaQRtNcHNFaHuH4UfkUG2USlOGSfovJ
   Q==;
X-CSE-ConnectionGUID: KRer2CuFQguroFb+z375Pg==
X-CSE-MsgGUID: GZrf6E6nRD6+jf5dZIBtog==
X-IronPort-AV: E=Sophos;i="6.06,161,1705388400"; 
   d="scan'208";a="183550555"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 02:15:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 02:15:36 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 02:15:33 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<andre.przywara@arm.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v3 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Date: Thu, 15 Feb 2024 11:15:23 +0200
Message-ID: <20240215091524.14732-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215091524.14732-1-mihai.sain@microchip.com>
References: <20240215091524.14732-1-mihai.sain@microchip.com>
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
 arch/arm/boot/dts/microchip/sama7g5.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 269e0a3ca269..c030b318985a 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -958,6 +958,30 @@ i2c9: i2c@600 {
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
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(26)>,
+					<&dma0 AT91_XDMAC_DT_PERID(25)>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+		};
+
 		flx11: flexcom@e2824000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe2824000 0x200>;
-- 
2.43.0


