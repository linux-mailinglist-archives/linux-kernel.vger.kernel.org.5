Return-Path: <linux-kernel+bounces-68381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDC857979
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1B91F24A04
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644CB20328;
	Fri, 16 Feb 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bxwEB/N9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F0925570;
	Fri, 16 Feb 2024 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077130; cv=none; b=oU2aSQkhbr6pV+UQ3EAYYbUPq7E/jWddJxBKlydHc3gT6N1NNkN2WCr5zLmxZaT+6lE5yCNOUxgJPIZw+P0l6byOTLX+7AjjdfNwArNR7ESfPIv0LnPnqGetSuQezhu3e9xiX+FxS2FFSABr5kV4OyByvd5b105oafTX+Fepu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077130; c=relaxed/simple;
	bh=SAX9jxoxsbA2+wx0hIo9Zs7UGKEgB10+fdWYL3Zgv9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WK6WWnY2g396H0tHhiNOI/K8BkQj+TsW8NQFoiXXKiRcVPsheJRJvMGfN+EdEnXCB6vkymbqFT0+9K5wd/SuLPK+PunT7nM8dPfO2RsBCdkRfN1O1mIgWTADqnttB2EGisciQ7lFKBHE1gIw4c8Y941cpV37PX9YA35EoL3bUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bxwEB/N9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708077126;
	bh=SAX9jxoxsbA2+wx0hIo9Zs7UGKEgB10+fdWYL3Zgv9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxwEB/N9xrAUdQw1c/wvjcxrsOHvFwDmkRITJSn4Lu/OoPrJlbXnQjz0jcZhWPS75
	 6U94fMl2fDv4Vut3F+9zFHLU6tQ82D53jqVpzLS4tDDdgihpzT16OfdHn9gUpDznN6
	 qkS5ugmJDyXWpqRjEMokCZR+DHN0E3Lb3Ryp6mMPkXz+o8CvbZbjbP/9NmvUY8RRfv
	 EzVlQRjzSReUI52chz5gN1iphX1EfY5ZlDOMp/a2YlAtIlLYIGM9yAh08751z8ZFoH
	 JyJ1lg25k4TVaI1mYMsFl+UAEe5eVWA8/Cm2uooJXVDHKCADJs7Oed7Po9pQotZNCT
	 NinsYSceCldeA==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D5D8937820B6;
	Fri, 16 Feb 2024 09:52:01 +0000 (UTC)
From: Shreeya Patel <shreeya.patel@collabora.com>
To: heiko@sntech.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	jose.abreu@synopsys.com,
	nelson.costa@synopsys.com,
	dmitry.osipenko@collabora.com,
	sebastian.reichel@collabora.com,
	shawn.wen@rock-chips.com
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-dt@vger.kernel.org,
	linux-arm@lists.infradead.org,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 3/4] arm64: dts: rockchip: Add device tree support for HDMI RX Controller
Date: Fri, 16 Feb 2024 15:19:21 +0530
Message-Id: <20240216094922.257674-4-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216094922.257674-1-shreeya.patel@collabora.com>
References: <20240216094922.257674-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree support for Synopsys DesignWare HDMI RX
Controller.

Signed-off-by: Dingxian Wen <shawn.wen@rock-chips.com>
Co-developed-by: Shreeya Patel <shreeya.patel@collabora.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 .../boot/dts/rockchip/rk3588-pinctrl.dtsi     | 41 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      | 50 +++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-pinctrl.dtsi
index 244c66faa161..4fbe194d96b1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-pinctrl.dtsi
@@ -169,6 +169,47 @@ hdmim0_tx1_sda: hdmim0-tx1-sda {
 				/* hdmim0_tx1_sda */
 				<2 RK_PB4 4 &pcfg_pull_none>;
 		};
+
+		/omit-if-no-ref/
+		hdmim1_rx: hdmim1-rx {
+			rockchip,pins =
+				/* hdmim1_rx_cec */
+				<3 RK_PD1 5 &pcfg_pull_none>,
+				/* hdmim1_rx_scl */
+				<3 RK_PD2 5 &pcfg_pull_none_smt>,
+				/* hdmim1_rx_sda */
+				<3 RK_PD3 5 &pcfg_pull_none_smt>,
+				/* hdmim1_rx_hpdin */
+				<3 RK_PD4 5 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		hdmim1_rx_cec: hdmim1-rx-cec {
+			rockchip,pins =
+				/* hdmim1_rx_cec */
+				<3 RK_PD1 5 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		hdmim1_rx_hpdin: hdmim1-rx-hpdin {
+			rockchip,pins =
+				/* hdmim1_rx_hpdin */
+				<3 RK_PD4 5 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		hdmim1_rx_scl: hdmim1-rx-scl {
+			rockchip,pins =
+				/* hdmim1_rx_scl */
+				<3 RK_PD2 5 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		hdmim1_rx_sda: hdmim1-rx-sda {
+			rockchip,pins =
+				/* hdmim1_rx_sda */
+				<3 RK_PD3 5 &pcfg_pull_none>;
+		};
 	};
 
 	i2c0 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
index 5519c1430cb7..8138b6ee388f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -7,6 +7,24 @@
 #include "rk3588-pinctrl.dtsi"
 
 / {
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		/*
+		 * The 4k HDMI capture controller works only with 32bit
+		 * phys addresses and doesn't support IOMMU. HDMI RX CMA
+		 * must be reserved below 4GB.
+		 */
+		hdmirx_cma: hdmirx_cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0x0 0x0 0x0 0xffffffff>;
+			size = <0x0 (160 * 0x100000)>; /* 160MiB */
+			no-map;
+			status = "disabled";
+		};
+	};
+
 	pcie30_phy_grf: syscon@fd5b8000 {
 		compatible = "rockchip,rk3588-pcie3-phy-grf", "syscon";
 		reg = <0x0 0xfd5b8000 0x0 0x10000>;
@@ -85,6 +103,38 @@ i2s10_8ch: i2s@fde00000 {
 		status = "disabled";
 	};
 
+	hdmirx_ctrler: hdmirx-controller@fdee0000 {
+		compatible = "rockchip,rk3588-hdmirx-ctrler", "snps,dw-hdmi-rx";
+		reg = <0x0 0xfdee0000 0x0 0x6000>;
+		power-domains = <&power RK3588_PD_VO1>;
+		rockchip,grf = <&sys_grf>;
+		rockchip,vo1_grf = <&vo1_grf>;
+		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "cec", "hdmi", "dma";
+		clocks = <&cru ACLK_HDMIRX>,
+			 <&cru CLK_HDMIRX_AUD>,
+			 <&cru CLK_CR_PARA>,
+			 <&cru PCLK_HDMIRX>,
+			 <&cru CLK_HDMIRX_REF>,
+			 <&cru PCLK_S_HDMIRX>,
+			 <&cru HCLK_VO1>;
+		clock-names = "aclk",
+			      "audio",
+			      "cr_para",
+			      "pclk",
+			      "ref",
+			      "hclk_s_hdmirx",
+			      "hclk_vo1";
+		resets = <&cru SRST_A_HDMIRX>, <&cru SRST_P_HDMIRX>,
+			 <&cru SRST_HDMIRX_REF>, <&cru SRST_A_HDMIRX_BIU>;
+		reset-names = "rst_a", "rst_p", "rst_ref", "rst_biu";
+		pinctrl-0 = <&hdmim1_rx>;
+		pinctrl-names = "default";
+		status = "disabled";
+	};
+
 	pcie3x4: pcie@fe150000 {
 		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
 		#address-cells = <3>;
-- 
2.39.2


