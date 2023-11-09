Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5367E6B10
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjKINMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjKINMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:12:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0BC30D7;
        Thu,  9 Nov 2023 05:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699535548; x=1731071548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LUC4erbno/H52lv94xN12LQvMzbnfDlo0AEr+xiw4UU=;
  b=ZeAQCdF532hZPMNpQ7VQqGWQl6/HXFlZbYmFKDQI9/gIc3yAbZeyl5V3
   MRJVPcAWhVsu3EYFYzpEmp0au43jLOUtD+LawKz+r+dVmx7MyIVjviMdE
   dq59V/BD4Yx3n3SOwKLmbKJ0Ssk8hdE9qKtsAHLJh69sdxpNJj/VbTVUF
   qrUpX1pcQCG2R1w1xKpwkBachwycBY+jR6P274olWP7okvBM7bZj7em3K
   XkdMlWrCFqfd2Pymlx7Bc6v1EZ6gNMJbhYWbQyJvOwL0tobSkPbJyJ0uv
   w5U86fTy8nKzmst6KksxijYwjy7yan9kp+FWo+XfpNnubzdBbzEKL0wuS
   Q==;
X-CSE-ConnectionGUID: uHNDA70zTMalMOg8YTS6DA==
X-CSE-MsgGUID: a58n0SiRTFib0Qv2nP1ZiA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="11697774"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2023 06:12:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Nov 2023 06:12:08 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 9 Nov 2023 06:12:06 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cristian.birsan@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/2] ARM: dts: at91: sam9x60_curiosity: Add IRQ support for ethernet PHY
Date:   Thu, 9 Nov 2023 15:11:48 +0200
Message-ID: <20231109131149.46397-2-mihai.sain@microchip.com>
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
 arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
index 83372c1f291b..c6fbdd29019f 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
@@ -249,6 +249,8 @@ &macb0 {
 
 	ethernet-phy@0 {
 		reg = <0x0>;
+		interrupt-parent = <&pioB>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
@@ -353,6 +355,7 @@ AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB4 periph A */
 				 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB5 periph A */
 				 AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB6 periph A */
 				 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB7 periph A */
+				 AT91_PIOB 8 AT91_PERIPH_GPIO AT91_PINCTRL_NONE	/* PB8 IRQ GPIO */
 				 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB9 periph A */
 				 AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB10 periph A */
 		};
-- 
2.42.0

