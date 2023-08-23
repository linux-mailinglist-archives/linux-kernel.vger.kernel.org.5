Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5F5786293
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbjHWVg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbjHWVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:36:48 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5810D2;
        Wed, 23 Aug 2023 14:36:46 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id E6ABA10000D;
        Thu, 24 Aug 2023 00:36:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E6ABA10000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692826602;
        bh=MsqftKOIycFu9ffQQowxWMyaH/kKjUWsNUQo5VRcUOk=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=lM400aCJNhcp3bTIkexFNHUHUKYAgg+2bnVseMACDBNg73ZVGTRNW+DJOU5OYk6EP
         V5TkpFROhKA0Wd74e1m0MBRPUzgPXRbADrecrV8plu0dsUSJ3RCGHsuQmKnjqFHJ7o
         PLu09oaoA6jYQLoY02TE9OZXnrRZIBhYeDyy9odWzARS5kyunj5RgrWxij6xCKtY+z
         xGX3XKgy9yGp6jaS0Ttuuf2eDUORQL0XXcveVWhi5im9zIZhbuvQ8/TufvmU92rrNK
         KkIxaId7W/L/Fx09NpGgaKmLbks2ntfyXFAvW+9vDEG+iRQzRDouYWB7/HLkLZ+jck
         D9vQiYzaWGCMA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 24 Aug 2023 00:36:42 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 24 Aug 2023 00:36:38 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor+dt@kernel.org>
CC:     <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>
Subject: [PATCH v2 06/15] arm64: dts: meson: a1: support USB controller in OTG mode
Date:   Thu, 24 Aug 2023 00:36:21 +0300
Message-ID: <20230823213630.12936-7-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230823213630.12936-1-ddrokosov@sberdevices.ru>
References: <20230823213630.12936-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179413 [Aug 23 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/23 18:49:00 #21688451
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic A1 SoC family has USB2.0 controller based on dwc2 and dwc3
heads. It supports otg/host/peripheral modes.

Signed-off-by: Yue Wang <yue.wang@amlogic.com>
Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 59 +++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index a8a39eeb2581..04df5a5b563e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/gpio/meson-a1-gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/meson-a1-power.h>
+#include <dt-bindings/reset/amlogic,meson-a1-reset.h>
 
 / {
 	compatible = "amlogic,a1";
@@ -152,6 +154,17 @@ uart_AO_B: serial@2000 {
 				status = "disabled";
 			};
 
+			usb2_phy1: phy@4000 {
+				compatible = "amlogic,a1-usb2-phy";
+				clocks = <&clkc_periphs CLKID_USB_PHY_IN>;
+				clock-names = "xtal";
+				reg = <0x0 0x4000 0x0 0x60>;
+				resets = <&reset RESET_USBPHY>;
+				reset-names = "phy";
+				#phy-cells = <0>;
+				power-domains = <&pwrc PWRC_USB_ID>;
+			};
+
 			clkc_pll: pll-clock-controller@7c80 {
 				compatible = "amlogic,a1-pll-clkc";
 				reg = <0 0x7c80 0 0x18c>;
@@ -162,6 +175,52 @@ clkc_pll: pll-clock-controller@7c80 {
 			};
 		};
 
+		usb: usb@fe004400 {
+			status = "disabled";
+			compatible = "amlogic,meson-a1-usb-ctrl";
+			reg = <0x0 0xfe004400 0x0 0xa0>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&clkc_periphs CLKID_USB_CTRL>,
+				 <&clkc_periphs CLKID_USB_BUS>,
+				 <&clkc_periphs CLKID_USB_CTRL_IN>;
+			clock-names = "usb_ctrl", "usb_bus", "xtal_usb_ctrl";
+			resets = <&reset RESET_USBCTRL>;
+			reset-name = "usb_ctrl";
+
+			dr_mode = "otg";
+
+			phys = <&usb2_phy1>;
+			phy-names = "usb2-phy1";
+
+			dwc3: usb@ff400000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff400000 0x0 0x100000>;
+				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,dis_u2_susphy_quirk;
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,parkmode-disable-ss-quirk;
+			};
+
+			dwc2: usb@ff500000 {
+				compatible = "amlogic,meson-a1-usb", "snps,dwc2";
+				reg = <0x0 0xff500000 0x0 0x40000>;
+				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb2_phy1>;
+				phy-names = "usb2-phy";
+				clocks = <&clkc_periphs CLKID_USB_PHY>;
+				clock-names = "otg";
+				dr_mode = "peripheral";
+				g-rx-fifo-size = <192>;
+				g-np-tx-fifo-size = <128>;
+				g-tx-fifo-size = <128 128 16 16 16>;
+			};
+		};
+
 		gic: interrupt-controller@ff901000 {
 			compatible = "arm,gic-400";
 			reg = <0x0 0xff901000 0x0 0x1000>,
-- 
2.36.0

