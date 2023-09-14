Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DEA79FC3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbjINGlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbjINGlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:41:20 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A327DCE5;
        Wed, 13 Sep 2023 23:40:29 -0700 (PDT)
Received: from droid10-sz.amlogic.com (10.28.11.69) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Thu, 14 Sep 2023
 14:40:27 +0800
From:   zelong dong <zelong.dong@amlogic.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <yonghui.yu@amlogic.com>,
        <kelvin.zhang@amlogic.com>, Zelong Dong <zelong.dong@amlogic.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v4 3/3] arm64: dts: amlogic: add reset controller for Amlogic C3 SoC
Date:   Thu, 14 Sep 2023 14:40:18 +0800
Message-ID: <20230914064018.18790-4-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230914064018.18790-1-zelong.dong@amlogic.com>
References: <20230914064018.18790-1-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.69]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelong Dong <zelong.dong@amlogic.com>

Add the reset controller device of Amlogic C3 SoC family

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index 998f5050795c..d086bfab3228 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/reset/amlogic,c3-reset.h>
 
 / {
 	cpus {
@@ -81,6 +82,12 @@ apb4: bus@fe000000 {
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
 
+			reset: reset-controller@2000 {
+				compatible = "amlogic,c3-reset";
+				reg = <0x0 0x2000 0x0 0x98>;
+				#reset-cells = <1>;
+			};
+
 			periphs_pinctrl: pinctrl@4000 {
 				compatible = "amlogic,c3-periphs-pinctrl";
 				#address-cells = <2>;
-- 
2.35.1

