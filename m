Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC607E6B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjKINM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjKINMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:12:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281930C1;
        Thu,  9 Nov 2023 05:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699535539; x=1731071539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EHI8k/5oqb4BHAwxDhenRXq4iJ/ty304Tj8Ha46zV/Q=;
  b=iT/z1FAe1jywWMmhDYcekuPandu3KcTqr9Y9RF9cmgmGAEekFJtKmGvD
   a/80iOBFL0P8+wEW328myghUWo/ua73cCCyZQm84hGvB0YSLJKm3FxB86
   nnHQZCTFMLTyc45Zk0LusV9whdIlVE03SXq9aGPWfaqasb0fdq3gCUmKw
   sO9kEzPBss23R958mjqd565Cp1x5fmF03iYrAVgy+NEnSrqpoXEXNB/5f
   Qu1gx0K8Tgazcb3XTyJQwgV+2EMXnUUSucMtExRFoX3dyxAB/bcG5HTE+
   VmCcEJu6tI4H/9gt1FLwMhBET+ycV6X6R53EuLqOuwHcGkbRiNBpN95m7
   w==;
X-CSE-ConnectionGUID: b8HNUWnxTBWR9Gotu1JdxA==
X-CSE-MsgGUID: AQqo8MgfRIeclZqLIzPIWQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="11697747"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2023 06:12:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Nov 2023 06:12:11 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 9 Nov 2023 06:12:09 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cristian.birsan@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: sam9x60ek: Add IRQ support for ethernet PHY
Date:   Thu, 9 Nov 2023 15:11:49 +0200
Message-ID: <20231109131149.46397-3-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109131149.46397-1-mihai.sain@microchip.com>
References: <20231109131149.46397-1-mihai.sain@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt support for ethernet phy subnode.
Add PB8 definition to macb0 pinctrl.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
index 5cd593028aff..f3cbb675cea4 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
@@ -292,6 +292,8 @@ &macb0 {
 
 	ethernet-phy@0 {
 		reg = <0x0>;
+		interrupt-parent = <&pioB>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
@@ -465,6 +467,7 @@ AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB4 periph A */
 				 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB5 periph A */
 				 AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB6 periph A */
 				 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB7 periph A */
+				 AT91_PIOB 8 AT91_PERIPH_GPIO AT91_PINCTRL_NONE	/* PB8 IRQ GPIO */
 				 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB9 periph A */
 				 AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB10 periph A */
 		};
-- 
2.42.0

