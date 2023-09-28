Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7F27B1B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjI1Lph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjI1Lpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:45:36 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1DCBF;
        Thu, 28 Sep 2023 04:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1695901533; x=1727437533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ACdZxoKAKh1jcC+SyibkwaZ8XbsuqZqpltxrCHKXjwY=;
  b=oYI27KxwyRYiqeawguJXXyHH6Bk1p4SDe8/DhDMGTy75cLEW+nMSqfv8
   xUmxUmn8cnWYgU32fmE5TEqadCFUMZYa1+20tSOZtxyvJt+dxu8BxPctC
   Qfz898OGrmGQRNyG6yqgYJcomcaOnCnjuGP6Y9cAxHD7Zmh/sBNkGJ67j
   6j73aThjG3/RkX+rY0QOidnLVyKCQW2nee7tiFwmScx35x6g0OhN81XOY
   TJRxrkuza4ZGnubv2IMaj4NrO2ax/bay+mu3UA6CHb91ui73+XkifQAUy
   pYG5bc+zt6ilmFjnX/AcUWfk6Uc7X/ZQD/Z6l+6/NypaqlCOV8hidhA/F
   g==;
X-IronPort-AV: E=Sophos;i="6.03,183,1694728800"; 
   d="scan'208";a="33198949"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Sep 2023 13:45:30 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id E53BB280075;
        Thu, 28 Sep 2023 13:45:29 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-am64-tqma64xxl: add supply regulator for I2C devices
Date:   Thu, 28 Sep 2023 13:45:10 +0200
Message-Id: <d5991041263c96c798b94c0844a1550e28daa3b1.1695901360.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
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

Describes the hardware better, and avoids a few warnings during boot:

    lm75 0-004a: supply vs not found, using dummy regulator
    at24 0-0050: supply vcc not found, using dummy regulator
    at24 0-0054: supply vcc not found, using dummy regulator

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
index 6229849b5d968..d82d4a98306a7 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
@@ -85,6 +85,15 @@ rtos_ipc_memory_region: ipc-memories@a5000000 {
 			no-map;
 		};
 	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &main_i2c0 {
@@ -96,11 +105,13 @@ &main_i2c0 {
 	tmp1075: temperature-sensor@4a {
 		compatible = "ti,tmp1075";
 		reg = <0x4a>;
+		vs-supply = <&reg_1v8>;
 	};
 
 	eeprom0: eeprom@50 {
 		compatible = "st,24c02", "atmel,24c02";
 		reg = <0x50>;
+		vcc-supply = <&reg_1v8>;
 		pagesize = <16>;
 		read-only;
 	};
@@ -114,6 +125,7 @@ pcf85063: rtc@51 {
 	eeprom1: eeprom@54 {
 		compatible = "st,24c64", "atmel,24c64";
 		reg = <0x54>;
+		vcc-supply = <&reg_1v8>;
 		pagesize = <32>;
 	};
 };
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

