Return-Path: <linux-kernel+bounces-64173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56191853B27
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACA3B260D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1360ED4;
	Tue, 13 Feb 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU1N4Ggy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF46088E;
	Tue, 13 Feb 2024 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852919; cv=none; b=Ee7DBiCUIA9HWzPEbYsiCMxdumRLhz96pX+3d9i+QBF9YPdFK/LMMcMRJcu8szxZ0eAsZwZ2KFYcBKbHa1mWi8lc0bPOHLABOvqnFigx5t28VDclr0F2x9it8mWjM1KGMlaQOOVvuCrRhh3tp24ukrqgNZz04YfQzTwLb7nYbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852919; c=relaxed/simple;
	bh=wSVuDaYSgh8MRixfbgvvFkBg3ejCEwObxIZSwlWgJa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATFr8hzHjpnVozknYhThWE2EZBkbAb4gSvorl8EkTe6xGh+TH3B0gvp1G/TsZAi7RvXVFg1djVXtu4KH2tpV7Ia7wOZV55voyR7Q08XISHytTuoFdiNjfnfpJoh2Rg7IkBLvtk1qTfOW9WEXN2g/JGhBlVuvGfIy1QABYuDeeAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU1N4Ggy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E623CC433C7;
	Tue, 13 Feb 2024 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707852919;
	bh=wSVuDaYSgh8MRixfbgvvFkBg3ejCEwObxIZSwlWgJa4=;
	h=From:Date:Subject:References:In-Reply-To:List-Id:To:Cc:From;
	b=sU1N4Ggyxhx9lERFgDp3HswZEeDvw732OLECne+I4Atpgqblh4cjja3l1sOtHoYl9
	 l4dwZ+ziMxlfjtve6lVljsTFIcvmXjKYBQ67e/js6lCJzMDx3omgBVxFxh+cpbdJ3K
	 ueRtx+gAJt1uQoXbtpoQhKfp/FrApaqLNGG8OsjkSURY5NvOmoE/UZMuIglTGuJlN/
	 igWEIOhI1bq6q1be+4Q4sWE31EpquEUWwrCaPxrrf3CxjTIr8R4S3/iF0K6nLZMv1n
	 mhE2OnbR162tkiAXlw/c2oDCTV64L+hKXBoPRMs21+2xmFBfgTWGJgpMvp15ZtC2JP
	 0GPOgUMijJiWg==
From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Feb 2024 13:34:28 -0600
Subject: [PATCH 4/6] arm: dts: Fix dtc interrupt_map warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-arm-dt-cleanups-v1-4-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
In-Reply-To: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
To: soc@kernel.org, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tsahee Zidenberg <tsahee@annapurnalabs.com>, 
 Antoine Tenart <atenart@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Stefan Agner <stefan@agner.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
 Tony Lindgren <tony@atomide.com>, Chanho Min <chanho.min@lge.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Imre Kaloz <kaloz@openwrt.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kbuild@vger.kernel.org
X-Mailer: b4 0.13-dev

The dtc interrupt_map warning is off because its dependency,
interrupt_provider, is off by default. Fix all the warnings so it can be
enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts     | 2 ++
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts | 2 ++
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi                        | 8 ++++----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts
index 4d70f6afd13a..6d5e69035f94 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateway-7001.dts
@@ -60,6 +60,8 @@ pci@c0000000 {
 			 * We have slots (IDSEL) 1 and 2 with one assigned IRQ
 			 * each handling all IRQs.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 1 */
 			<0x0800 0 0 1 &gpio0 11 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 1 is irq 11 */
diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts
index 9ec0169bacf8..5f4c849915db 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-goramo-multilink.dts
@@ -89,6 +89,8 @@ pci@c0000000 {
 			 * The slots have Ethernet, Ethernet, NEC and MPCI.
 			 * The IDSELs are 11, 12, 13, 14.
 			 */
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map =
 			/* IDSEL 11 - Ethernet A */
 			<0x5800 0 0 1 &gpio0 4 IRQ_TYPE_LEVEL_LOW>, /* INT A on slot 11 is irq 4 */
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 2045fc779f88..27429d0fedfb 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -340,10 +340,10 @@ pcie_rc: pcie@1c00000 {
 					  "msi8";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 0 0 141 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 0 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 0 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 0 0 144 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc 0 141 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_PCIE_PIPE_CLK>,
 				 <&gcc GCC_PCIE_AUX_CLK>,

-- 
2.43.0


