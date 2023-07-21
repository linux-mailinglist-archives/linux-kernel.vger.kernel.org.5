Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5BE75D746
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGUWRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGUWRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:17:19 -0400
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B923AA7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:16:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689977814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8V7IVCzXvQ6XGySh6Ck14V+DjdeQUJghLQf/W+Pqwc=;
        b=0W0U/GT0SbHueJkHt3BR0jUMuIhycCoabty8TdgDcWU1WsD01G4yN21m8enKzd5i7I23Of
        zq5/9ObfINIDztVU/dkNPuH545rXOAoOEC9qWRJGya925xngV3A2ojquTOGxtuSJ290Z4J
        Lb6KAIBgWX8LTczvY5PDb1DZsYpgbgOttwKgQRkmLdbzXPAA5SqyQ9OWmEmPdIUuuCCz4h
        6ysAK1G9f4VPxgfHPWj20BUXMg+2JhOd1FNzNw/ldyVjRIz24lL3TqI2Y8q8X5jVSXDy5V
        eO5g6HYTI4UFbvyAEyNoc72MqlfCEtNhCtzXz5PZQT0xv82KFHdz4bH9WPbvkQ==
From:   John Watts <contact@jookia.org>
To:     linux-sunxi@lists.linux.dev
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, John Watts <contact@jookia.org>
Subject: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller nodes
Date:   Sat, 22 Jul 2023 08:15:51 +1000
Message-ID: <20230721221552.1973203-4-contact@jookia.org>
In-Reply-To: <20230721221552.1973203-2-contact@jookia.org>
References: <20230721221552.1973203-2-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner D1, T113 provide two CAN controllers that are variants
of the R40 controller.

I have tested support for these controllers on two boards:

- A Lichee Panel RV 86 Panel running a D1 chip
- A Mango Pi MQ Dual running a T113-s3 chip

Both of these fully support both CAN controllers.

Signed-off-by: John Watts <contact@jookia.org>
---
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 1bb1e5cae602..4086c0cc0f9d 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -131,6 +131,18 @@ uart3_pb_pins: uart3-pb-pins {
 				pins = "PB6", "PB7";
 				function = "uart3";
 			};
+
+			/omit-if-no-ref/
+			can0_pins: can0-pins {
+				pins = "PB2", "PB3";
+				function = "can0";
+			};
+
+			/omit-if-no-ref/
+			can1_pins: can1-pins {
+				pins = "PB4", "PB5";
+				function = "can1";
+			};
 		};
 
 		ccu: clock-controller@2001000 {
@@ -879,5 +891,23 @@ rtc: rtc@7090000 {
 			clock-names = "bus", "hosc", "ahb";
 			#clock-cells = <1>;
 		};
+
+		can0: can@2504000 {
+			compatible = "allwinner,sun20i-d1-can";
+			reg = <0x02504000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(21) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CAN0>;
+			resets = <&ccu RST_BUS_CAN0>;
+			status = "disabled";
+		};
+
+		can1: can@2504400 {
+			compatible = "allwinner,sun20i-d1-can";
+			reg = <0x02504400 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(22) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CAN1>;
+			resets = <&ccu RST_BUS_CAN1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.41.0

