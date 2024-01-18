Return-Path: <linux-kernel+bounces-29977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48AD83161E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F989282E53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC141F610;
	Thu, 18 Jan 2024 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TGAtf3Ym"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10920B0B;
	Thu, 18 Jan 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571136; cv=none; b=NU8CmjiWxchmzbWDHuxAlKWD3PHJpOwfBaIzRPaU2ELUTi9r0ZmRuXPxvTM9vz1b2vg5wIYjJZwN6mFiNqSm6hKDRJntQIQAmhv6BU+oubkfi7Hmk2tYw5v1VCKXwthIU8xquoe7Alf2YqdAEH8Zc+NQ/YwbySEf5MzV9kx3Wtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571136; c=relaxed/simple;
	bh=ABWyEyd2m5J2uhUi3WEgqj9FNUnfHbOXH8jjOAWLUGY=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EXCLAIMER-MD-CONFIG; b=kyvKqtOEZOsG9biKNlL9hSRTBSe/O3adE/swDV+/I3HuIUDR4hRHu0r5BseiMHZ+rejWJcneFdiE5FT+wti/8phbkukqnaUow205qakl75Jd4IWGDTyxEZ2SFw+BhNVbZX+rLRywlU4a2CpZGPzNHtY5fbplxVAH621yO1+R/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TGAtf3Ym; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40I9jMqM010695;
	Thu, 18 Jan 2024 03:45:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705571122;
	bh=PpCZmq2cyHTo8sRLhwePw1FQyYhyd0XNl0VTXmud4CQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TGAtf3YmIeRqFE1M5EDTVqfWo0PSOp0hfq8aqHzISD2/aoCgO8ax9pBAUiPc9y7pj
	 0hRJflF9GvkYKVaFyZ2AJ/yEMlNGfybNwhO6fOt6bOYdRjLgkpSXNn9t7DI2e/RCAA
	 ozJAM6CVB2Ifbr+rvy9cdMe/12I98Yo3Mw5b71Tc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40I9jM04018594
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 03:45:22 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jan 2024 03:45:22 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jan 2024 03:45:22 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40I9jLDN002294;
	Thu, 18 Jan 2024 03:45:22 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <c-vankar@ti.com>,
        <danishanwar@ti.com>, <tony@atomide.com>
Subject: [PATCH v2 3/5] arm64: dts: ti: k3-j784s4-main: Add CPSW9G nodes
Date: Thu, 18 Jan 2024 15:14:52 +0530
Message-ID: <20240118094454.2656734-4-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118094454.2656734-1-c-vankar@ti.com>
References: <20240118094454.2656734-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Siddharth Vadapalli <s-vadapalli@ti.com>

J784S4 SoC has a 9 port Ethernet Switch instance with 8 external
ports and 1 host port, referred to as CPSW9G.

Add device-tree nodes for CPSW9G and disable it by default.
Device-tree overlays will be used to enable it.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 114 +++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 191fdbe02877..9aebce8a51ab 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -54,6 +54,13 @@ cpsw1_phy_gmii_sel: phy@4034 {
 			#phy-cells = <1>;
 		};
 
+		cpsw0_phy_gmii_sel: phy@4044 {
+			compatible = "ti,j784s4-cpsw9g-phy-gmii-sel";
+			ti,qsgmii-main-ports = <7>, <7>;
+			reg = <0x4044 0x20>;
+			#phy-cells = <1>;
+		};
+
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
 			reg = <0x00004080 0x30>;
@@ -1248,6 +1255,113 @@ cpts@310d0000 {
 		};
 	};
 
+	main_cpsw0: ethernet@c000000 {
+		compatible = "ti,j784s4-cpswxg-nuss";
+		reg = <0x00 0xc000000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x00 0x00 0xc000000 0x00 0x200000>;
+		dma-coherent;
+		clocks = <&k3_clks 64 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_udmap 0xca00>,
+		       <&main_udmap 0xca01>,
+		       <&main_udmap 0xca02>,
+		       <&main_udmap 0xca03>,
+		       <&main_udmap 0xca04>,
+		       <&main_udmap 0xca05>,
+		       <&main_udmap 0xca06>,
+		       <&main_udmap 0xca07>,
+		       <&main_udmap 0x4a00>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			main_cpsw0_port1: port@1 {
+				reg = <1>;
+				label = "port1";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port2: port@2 {
+				reg = <2>;
+				label = "port2";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port3: port@3 {
+				reg = <3>;
+				label = "port3";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port4: port@4 {
+				reg = <4>;
+				label = "port4";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port5: port@5 {
+				reg = <5>;
+				label = "port5";
+				status = "disabled";
+			};
+
+			main_cpsw0_port6: port@6 {
+				reg = <6>;
+				label = "port6";
+				status = "disabled";
+			};
+
+			main_cpsw0_port7: port@7 {
+				reg = <7>;
+				label = "port7";
+				status = "disabled";
+			};
+
+			main_cpsw0_port8: port@8 {
+				reg = <8>;
+				label = "port8";
+				status = "disabled";
+			};
+		};
+
+		main_cpsw0_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 64 0>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			status = "disabled";
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 64 3>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
 	main_cpsw1: ethernet@c200000 {
 		compatible = "ti,j721e-cpsw-nuss";
 		#address-cells = <2>;
-- 
2.34.1


