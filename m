Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47688769D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjGaQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjGaQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:57:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF67C1729;
        Mon, 31 Jul 2023 09:57:30 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-210-008.ewe-ip-backbone.de [91.248.210.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B99F06607186;
        Mon, 31 Jul 2023 17:57:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690822648;
        bh=iJEV5hp8TWN3be/f2X5Jvjfl1ZZIqLvw4EgQ1zURuRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmPKZJSlk1PR4lRNjOr8Zno4JQuxNRd6xewwRw6AW+wMFQYBKYdo+hOWHKO/qZ+At
         +6tWExc6mmL0xSyYQSjUh/dN2MG3SPNJyC2b8DblTuZ4HH25goW4uH5qRiPCoLjR74
         +wYA47lJLfydhXsB5W5lEH7Zjb8QSeQWh4FsKGQOjDu6BOyctzXZqIzFyerxuw9qHo
         xw+yx1mjgJi/VUDDI1hceLyhS4ijr8/tOLj4hzn34CTqMmK5yTyQzi0D5iXl0fa5wo
         B5EonUrlKTaOneIimxo+Vx3q3PDXsra/G/AyYwW87HRQaDw/xN4hnvTe063rPSlbS5
         G53cFVlbxY+Rg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 306484800B3; Mon, 31 Jul 2023 18:57:25 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Kever Yang <kever.yang@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v4 5/5] arm64: dts: rockchip: rk3588: add PCIe2 support
Date:   Mon, 31 Jul 2023 18:57:23 +0200
Message-Id: <20230731165723.53069-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731165723.53069-1-sebastian.reichel@collabora.com>
References: <20230731165723.53069-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all three PCIe2 IP blocks to the RK3588 DT. Note, that RK3588
also has two PCIe3 IP blocks, that will be handled separately.

Co-developed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Tested-by: Jagan Teki <jagan@edgeble.ai> # edgeble-neu6a, 6b
Reviewed-by: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588.dtsi  |  51 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 102 ++++++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
index 6be9bf81c09c..88d702575db2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -80,6 +80,57 @@ i2s10_8ch: i2s@fde00000 {
 		status = "disabled";
 	};
 
+	pcie2x1l0: pcie@fe170000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x20 0x2f>;
+		clocks = <&cru ACLK_PCIE_1L0_MSTR>, <&cru ACLK_PCIE_1L0_SLV>,
+			 <&cru ACLK_PCIE_1L0_DBI>, <&cru PCLK_PCIE_1L0>,
+			 <&cru CLK_PCIE_AUX2>, <&cru CLK_PCIE1L0_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2x1l0_intc 0>,
+				<0 0 0 2 &pcie2x1l0_intc 1>,
+				<0 0 0 3 &pcie2x1l0_intc 2>,
+				<0 0 0 4 &pcie2x1l0_intc 3>;
+		linux,pci-domain = <2>;
+		max-link-speed = <2>;
+		msi-map = <0x2000 &its0 0x2000 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy1_ps PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0x9 0x80000000 0x0 0x40000000>;
+		reg = <0xa 0x40800000 0x0 0x00400000>,
+		      <0x0 0xfe170000 0x0 0x00010000>,
+		      <0x0 0xf2000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE2_POWER_UP>, <&cru SRST_P_PCIE2>;
+		reset-names = "pwr", "pipe";
+		status = "disabled";
+
+		pcie2x1l0_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 240 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
 	gmac0: ethernet@fe1b0000 {
 		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe1b0000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index c9f9dd2472f5..b9b509257aaa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1227,6 +1227,108 @@ qos_vop_m1: qos@fdf82200 {
 		reg = <0x0 0xfdf82200 0x0 0x20>;
 	};
 
+	pcie2x1l1: pcie@fe180000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x30 0x3f>;
+		clocks = <&cru ACLK_PCIE_1L1_MSTR>, <&cru ACLK_PCIE_1L1_SLV>,
+			 <&cru ACLK_PCIE_1L1_DBI>, <&cru PCLK_PCIE_1L1>,
+			 <&cru CLK_PCIE_AUX3>, <&cru CLK_PCIE1L1_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2x1l1_intc 0>,
+				<0 0 0 2 &pcie2x1l1_intc 1>,
+				<0 0 0 3 &pcie2x1l1_intc 2>,
+				<0 0 0 4 &pcie2x1l1_intc 3>;
+		linux,pci-domain = <3>;
+		max-link-speed = <2>;
+		msi-map = <0x3000 &its0 0x3000 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy2_psu PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf3100000 0x0 0xf3100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf3200000 0x0 0xf3200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0x9 0xc0000000 0x0 0x40000000>;
+		reg = <0xa 0x40c00000 0x0 0x00400000>,
+		      <0x0 0xfe180000 0x0 0x00010000>,
+		      <0x0 0xf3000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE3_POWER_UP>, <&cru SRST_P_PCIE3>;
+		reset-names = "pwr", "pipe";
+		status = "disabled";
+
+		pcie2x1l1_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 245 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
+	pcie2x1l2: pcie@fe190000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x40 0x4f>;
+		clocks = <&cru ACLK_PCIE_1L2_MSTR>, <&cru ACLK_PCIE_1L2_SLV>,
+			 <&cru ACLK_PCIE_1L2_DBI>, <&cru PCLK_PCIE_1L2>,
+			 <&cru CLK_PCIE_AUX4>, <&cru CLK_PCIE1L2_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2x1l2_intc 0>,
+				<0 0 0 2 &pcie2x1l2_intc 1>,
+				<0 0 0 3 &pcie2x1l2_intc 2>,
+				<0 0 0 4 &pcie2x1l2_intc 3>;
+		linux,pci-domain = <4>;
+		max-link-speed = <2>;
+		msi-map = <0x4000 &its0 0x4000 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy0_ps PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0xa 0x00000000 0x0 0x40000000>;
+		reg = <0xa 0x41000000 0x0 0x00400000>,
+		      <0x0 0xfe190000 0x0 0x00010000>,
+		      <0x0 0xf4000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE4_POWER_UP>, <&cru SRST_P_PCIE4>;
+		reset-names = "pwr", "pipe";
+		status = "disabled";
+
+		pcie2x1l2_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
 	gmac1: ethernet@fe1c0000 {
 		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe1c0000 0x0 0x10000>;
-- 
2.40.1

