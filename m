Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4AA753896
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjGNKpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjGNKpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:45:30 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAFD30EF;
        Fri, 14 Jul 2023 03:45:26 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8916024DD81;
        Fri, 14 Jul 2023 18:45:25 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Jul
 2023 18:45:25 +0800
Received: from starfive-sdk.starfivetech.com (171.223.208.138) by
 EXMBX062.cuchost.com (172.16.6.62) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 14 Jul 2023 18:45:23 +0800
From:   Samin Guo <samin.guo@starfivetech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v1 2/2] riscv: dts: starfive: visionfive 2: Add configuration of gmac and phy
Date:   Fri, 14 Jul 2023 18:45:21 +0800
Message-ID: <20230714104521.18751-3-samin.guo@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230714104521.18751-1-samin.guo@starfivetech.com>
References: <20230714104521.18751-1-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1.3B:
  v1.3B uses motorcomm YT8531(rgmii-id phy) x2, need delay and
  inverse configurations.
  The tx_clk of v1.3B uses an external clock and needs to be
  switched to an external clock source.

v1.2A:
  v1.2A gmac0 uses motorcomm YT8531(rgmii-id) PHY, and needs delay
  configurations.
  v1.2A gmac1 uses motorcomm YT8512(rmii) PHY, and needs to
  switch rx and rx to external clock sources.

Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2-v1.2a.dts    | 13 +++++++
 .../jh7110-starfive-visionfive-2-v1.3b.dts    | 31 +++++++++++++++++
 .../jh7110-starfive-visionfive-2.dtsi         | 34 +++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dts
index 4af3300f3cf3..205a13d8c8b1 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dts
@@ -11,3 +11,16 @@
 	model = "StarFive VisionFive 2 v1.2A";
 	compatible = "starfive,visionfive-2-v1.2a", "starfive,jh7110";
 };
+
+&gmac1 {
+	phy-mode = "rmii";
+	assigned-clocks = <&syscrg JH7110_SYSCLK_GMAC1_TX>,
+			  <&syscrg JH7110_SYSCLK_GMAC1_RX>;
+	assigned-clock-parents = <&syscrg JH7110_SYSCLK_GMAC1_RMII_RTX>,
+				 <&syscrg JH7110_SYSCLK_GMAC1_RMII_RTX>;
+};
+
+&phy0 {
+	rx-internal-delay-ps = <1900>;
+	tx-internal-delay-ps = <1350>;
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
index 9230cc3d8946..36f74d4eda01 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
@@ -11,3 +11,34 @@
 	model = "StarFive VisionFive 2 v1.3B";
 	compatible = "starfive,visionfive-2-v1.3b", "starfive,jh7110";
 };
+
+&gmac0 {
+	starfive,tx-use-rgmii-clk;
+	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
+	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+};
+
+&gmac1 {
+	starfive,tx-use-rgmii-clk;
+	assigned-clocks = <&syscrg JH7110_SYSCLK_GMAC1_TX>;
+	assigned-clock-parents = <&syscrg JH7110_SYSCLK_GMAC1_RMII_RTX>;
+};
+
+&phy0 {
+	motorcomm,tx-clk-adj-enabled;
+	motorcomm,tx-clk-100-inverted;
+	motorcomm,tx-clk-1000-inverted;
+	motorcomm,rx-clk-driver-strength = <3970>;
+	motorcomm,rx-data-driver-strength = <2910>;
+	rx-internal-delay-ps = <1500>;
+	tx-internal-delay-ps = <1500>;
+};
+
+&phy1 {
+	motorcomm,tx-clk-adj-enabled;
+	motorcomm,tx-clk-100-inverted;
+	motorcomm,rx-clk-driver-strength = <3970>;
+	motorcomm,rx-data-driver-strength = <2910>;
+	rx-internal-delay-ps = <300>;
+	tx-internal-delay-ps = <0>;
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index fa0061eb33a7..fcb45db42df5 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -11,6 +11,8 @@
 
 / {
 	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 		i2c0 = &i2c0;
 		i2c2 = &i2c2;
 		i2c5 = &i2c5;
@@ -86,6 +88,38 @@
 	clock-frequency = <49152000>;
 };
 
+&gmac0 {
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&gmac1 {
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy1: ethernet-phy@1 {
+			reg = <0>;
+		};
+	};
+};
+
 &i2c0 {
 	clock-frequency = <100000>;
 	i2c-sda-hold-time-ns = <300>;
-- 
2.17.1

