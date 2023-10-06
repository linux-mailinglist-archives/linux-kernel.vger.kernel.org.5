Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31487BB6B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjJFLmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjJFLl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:41:59 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251C0CA;
        Fri,  6 Oct 2023 04:41:54 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 0FC00120006;
        Fri,  6 Oct 2023 14:41:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0FC00120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696592512;
        bh=hvuosWr2wdmb2JBZ+is0TB+tnsHxcAuNr2PYKRoXoWA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=SaFk0/vhnOyY5jrUOcT5pnyrBkIHtgO8tulzDenyfCKted4ZDswCeYd2ChVlsuMSs
         Y8ndPJMCgf9n+z2pK8XlkLbtU7utvtg+XSKdXwmqbo6dsIhsZmcQc81hXLqYy3zIe0
         oEO5F1ZRNnoxnDm3m+fOZvFjpYQx4fSw2FYhn/QwQJStp0SvCkGLi9Am+TBstjfrKJ
         ul2r+zBsh4+7rwO9RfD7hEqq8muz0N2R+KhpV5F9Xd6QWgWiKTiCWpsqkjk3Q6FvjJ
         kihr5F1MQaIr7zvBgdlk7a3beZGr9Sui0KYLp5GmjqIp9XHydZUSocUE1Tc+xqja6d
         S1ydsrSC2/eCQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri,  6 Oct 2023 14:41:51 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 6 Oct 2023 14:41:51 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>,
        George Stark <gnstark@salutedevices.com>
Subject: [PATCH v1] arm64: dts: amlogic: a1: support all i2c masters and their muxes
Date:   Fri, 6 Oct 2023 14:41:45 +0300
Message-ID: <20231006114145.18718-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180422 [Oct 06 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/06 08:17:00 #22074438
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A1 SoC family has four i2c masters: i2c0 (I2CM_A), i2c1 (I2CM_B), i2c2
(I2CM_C) and i2c3 (I2CM_D).

Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 144 ++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 823714bcb7a0..f53000a5d0cc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -126,6 +126,106 @@ gpio: bank@400 {
 					gpio-ranges = <&periphs_pinctrl 0 0 62>;
 				};
 
+				i2c0_f11_pins: i2c0-f11 {
+					mux {
+						groups = "i2c0_sck_f11",
+							 "i2c0_sda_f12";
+						function = "i2c0";
+						bias-pull-up;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				i2c0_f9_pins: i2c0-f9 {
+					mux {
+						groups = "i2c0_sck_f9",
+							 "i2c0_sda_f10";
+						function = "i2c0";
+						bias-pull-up;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				i2c1_x_pins: i2c1-x {
+					mux {
+						groups = "i2c1_sck_x",
+							 "i2c1_sda_x";
+						function = "i2c1";
+						bias-pull-up;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				i2c1_a_pins: i2c1-a {
+					mux {
+						groups = "i2c1_sck_a",
+							 "i2c1_sda_a";
+						function = "i2c1";
+						bias-pull-up;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				i2c2_x0_pins: i2c2-x0 {
+					mux {
+						groups = "i2c2_sck_x0",
+							 "i2c2_sda_x1";
+						function = "i2c2";
+						bias-pull-up;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				i2c2_x15_pins: i2c2-x15 {
+					mux {
+						groups = "i2c2_sck_x15",
+							 "i2c2_sda_x16";
+						function = "i2c2";
+						bias-pull-up;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				i2c2_a4_pins: i2c2-a4 {
+					mux {
+						groups = "i2c2_sck_a4",
+							 "i2c2_sda_a5";
+						function = "i2c2";
+						bias-pull-up;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				i2c2_a8_pins: i2c2-a8 {
+					mux {
+						groups = "i2c2_sck_a8",
+							 "i2c2_sda_a9";
+						function = "i2c2";
+						bias-pull-up;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				i2c3_x_pins: i2c3-x {
+					mux {
+						groups = "i2c3_sck_x",
+							 "i2c3_sda_x";
+						function = "i2c3";
+						bias-pull-up;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				i2c3_f_pins: i2c3-f {
+					mux {
+						groups = "i2c3_sck_f",
+							 "i2c3_sda_f";
+						function = "i2c3";
+						bias-pull-up;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
 				uart_a_pins: uart-a {
 					mux {
 						groups = "uart_a_tx",
@@ -377,6 +477,17 @@ clkc_periphs: clock-controller@800 {
 					      "hifi_pll", "xtal";
 			};
 
+			i2c0: i2c@1400 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x1400 0x0 0x20>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc_periphs CLKID_I2C_M_A>;
+				power-domains = <&pwrc PWRC_I2C_ID>;
+			};
+
 			uart_AO: serial@1c00 {
 				compatible = "amlogic,meson-a1-uart",
 					     "amlogic,meson-ao-uart";
@@ -437,6 +548,39 @@ saradc: adc@2c00 {
 				status = "disabled";
 			};
 
+			i2c1: i2c@5c00 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x5c00 0x0 0x20>;
+				interrupts = <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc_periphs CLKID_I2C_M_B>;
+				power-domains = <&pwrc PWRC_I2C_ID>;
+			};
+
+			i2c2: i2c@6800 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x6800 0x0 0x20>;
+				interrupts = <GIC_SPI 76 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc_periphs CLKID_I2C_M_C>;
+				power-domains = <&pwrc PWRC_I2C_ID>;
+			};
+
+			i2c3: i2c@6c00 {
+				compatible = "amlogic,meson-axg-i2c";
+				status = "disabled";
+				reg = <0x0 0x6c00 0x0 0x20>;
+				interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc_periphs CLKID_I2C_M_D>;
+				power-domains = <&pwrc PWRC_I2C_ID>;
+			};
+
 			usb2_phy1: phy@4000 {
 				compatible = "amlogic,a1-usb2-phy";
 				clocks = <&clkc_periphs CLKID_USB_PHY_IN>;
-- 
2.36.0

