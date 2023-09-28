Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4339B7B1B61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjI1Lpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjI1Lpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:45:39 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1424412A;
        Thu, 28 Sep 2023 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1695901538; x=1727437538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X5p7JcHFpT44Zh0Pe/0NroATZwJsdO+79pqlDjr7wh8=;
  b=FPP/SjC1Q2MYdX+I5fARcaeEPxQqGUaq4s4wkKBkGnz+unGWKBnUQz4M
   RaD25g8dGkPd+Lz1qmRnzW6PIhQGmMN/1RzOZIRXgoU+kXyEbgvomAFos
   +7/yO92/NFh5dEMy1mx7uQS6rZYUZSnJEfm6YZM1qdP9zHoVSCST1nP/v
   9sQ5nH1yG7Or+D6kHjhqwBPaZMQ/V27R8jka9KfnyaUv+pCxhMFJHs6DQ
   NuydGByXsawiik2hiXLvKT2lGIfEgoOxzvVEpeVylFlZqbV5IMjFvdWq5
   zqC88P8ZJUv6viSF1LIILDy0Eqh0nRb2JVRtzWDV31rlainnhnWoT6pMD
   g==;
X-IronPort-AV: E=Sophos;i="6.03,183,1694728800"; 
   d="scan'208";a="33198952"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Sep 2023 13:45:30 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 89748280086;
        Thu, 28 Sep 2023 13:45:30 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: update gpio-led configuration
Date:   Thu, 28 Sep 2023 13:45:13 +0200
Message-Id: <79cb3cdfed19962ce0d4ae558de897695658a81f.1695901360.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d5991041263c96c798b94c0844a1550e28daa3b1.1695901360.git.matthias.schiffer@ew.tq-group.com>
References: <d5991041263c96c798b94c0844a1550e28daa3b1.1695901360.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the deprecated label property with color/function.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index 1cb44fb9d2729..d95d80076a427 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pwm/pwm.h>
@@ -59,12 +60,14 @@ gpio-leds {
 		pinctrl-0 = <&mcu_gpio_leds_pins>;
 
 		led-0 {
-			label = "led0";
 			gpios = <&mcu_gpio0 8 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
 		};
 		led-1 {
-			label = "led1";
 			gpios = <&mcu_gpio0 9 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_INDICATOR;
 		};
 	};
 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

