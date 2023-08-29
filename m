Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6078BC95
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjH2CFv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 22:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjH2CFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:05:19 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03120194;
        Mon, 28 Aug 2023 19:05:15 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 29B9B24E1EB;
        Tue, 29 Aug 2023 10:05:14 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Aug
 2023 10:05:13 +0800
Received: from ubuntu.localdomain (113.72.145.245) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Aug
 2023 10:05:13 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Hal Feng <hal.feng@starfivetech.com>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [-next v2 2/2] riscv: dts: starfive: visionfive 2: Fix uart0 pins sort order
Date:   Tue, 29 Aug 2023 10:05:11 +0800
Message-ID: <20230829020511.26844-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230829020511.26844-1-hal.feng@starfivetech.com>
References: <20230829020511.26844-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.245]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node uart0_pins should be sorted alphabetically.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 48 +++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 85f40df93f25..382dfb5e64e4 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -440,30 +440,6 @@ GPOEN_ENABLE,
 		};
 	};
 
-	uart0_pins: uart0-0 {
-		tx-pins {
-			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
-					     GPOEN_ENABLE,
-					     GPI_NONE)>;
-			bias-disable;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		rx-pins {
-			pinmux = <GPIOMUX(6, GPOUT_LOW,
-					     GPOEN_DISABLE,
-					     GPI_SYS_UART0_RX)>;
-			bias-disable; /* external pull-up */
-			drive-strength = <2>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-
 	tdm_pins: tdm-0 {
 		tx-pins {
 			pinmux = <GPIOMUX(44, GPOUT_SYS_TDM_TXD,
@@ -497,6 +473,30 @@ GPOEN_DISABLE,
 			input-enable;
 		};
 	};
+
+	uart0_pins: uart0-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
+					     GPOEN_ENABLE,
+					     GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(6, GPOUT_LOW,
+					     GPOEN_DISABLE,
+					     GPI_SYS_UART0_RX)>;
+			bias-disable; /* external pull-up */
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
 };
 
 &tdm {
-- 
2.38.1

