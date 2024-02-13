Return-Path: <linux-kernel+bounces-64174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7848853B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574EEB269A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7C60EE5;
	Tue, 13 Feb 2024 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKizwqxc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A560EFE;
	Tue, 13 Feb 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852922; cv=none; b=VotKNZvNfAEBb4UhgFGvFKoGHommJzVfTteSWGScrZ++aaoXgHR3HSc3nQbIgWv0mbKIL0cIfC6CSvDaUdLER9oVpFeflUbCYY1aPbUds9EEkO8RD0bmtr8k/2FMQsa64T0j+4CECAQvFwKuyKm58AbVCrnBwQiibGDrdCxTRio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852922; c=relaxed/simple;
	bh=sv88IujBpfHMPhVsbD/uX3vDJVDPR81+Zt14idlIRkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/uT4jKE9pyX017dYds1qb3FBkMDg9nTtAIwXDEkWfVtONfQzESzJ4/OoJ3ZRrLgEwPJAtM2L1sTRL3MVH+o5DcYZyFTpoxAVecGpE8/W/tPFBrzsf8j2tFh5Xh4Wilo7LsYP9RGg6RVnmKhC1YoJHzE3+rEjrqqDeoz+ZaBLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKizwqxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50698C43390;
	Tue, 13 Feb 2024 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707852921;
	bh=sv88IujBpfHMPhVsbD/uX3vDJVDPR81+Zt14idlIRkk=;
	h=From:Date:Subject:References:In-Reply-To:List-Id:To:Cc:From;
	b=DKizwqxcC7J4JqkJOz4xypNY2XQ16Bx9so9xQEHWNUmuyim/ksbKFT7GeurlKn61U
	 ZhGBSZdZAmSA/oBYfhps5ZFr4FS3kJ8OcftkByrKfpB88DPxA1AKzh2leBwnhnOEbO
	 FOEmlLg/SfKOaHw2WFs1vzRvUFS8y9YsPKjIpQaBZzGzbvPSPCyWpO9FjrD9Xnjae1
	 xi3TkDKf+5JQfXIUkgIKtNwyTkWAoxNoax0phwZ0JXxlCqVV7s5V7CZrQJYasNI8Ji
	 yRF+e1AKmXKJGQIKhoLY81kKst4bNdgbB7MmCC3TK1YxnOUsgpZGsm/+Ro5Yrj0EiJ
	 0GeTkg36Zfucg==
From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Feb 2024 13:34:29 -0600
Subject: [PATCH 5/6] arm64: dts: qcom: Fix interrupt-map cell sizes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-arm-dt-cleanups-v1-5-f2dee1292525@kernel.org>
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

The PCI node interrupt-map properties have the wrong size as #address-cells
in the interrupt parent are not accounted for.

The dtc interrupt_map check catches this, but the warning is off because
its dependency, interrupt_provider, is off by default.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi |  8 ++++----
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 5e1277fea725..61c8fd49c966 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -830,10 +830,10 @@ pcie0: pcie@20000000 {
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 75 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 78 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 79 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 83 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc 0 0 0 75 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 0 78 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 0 79 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 0 83 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
 				 <&gcc GCC_PCIE0_AXI_M_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index cf295bed3299..26441447c866 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -814,13 +814,13 @@ pcie1: pcie@10000000 {
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 142
+			interrupt-map = <0 0 0 1 &intc 0 0 142
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 143
+					<0 0 0 2 &intc 0 0 143
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 144
+					<0 0 0 3 &intc 0 0 144
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 145
+					<0 0 0 4 &intc 0 0 145
 					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
@@ -876,13 +876,13 @@ pcie0: pcie@20000000 {
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 75
+			interrupt-map = <0 0 0 1 &intc 0 0 75
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 78
+					<0 0 0 2 &intc 0 0 78
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 79
+					<0 0 0 3 &intc 0 0 79
 					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 83
+					<0 0 0 4 &intc 0 0 83
 					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,

-- 
2.43.0


