Return-Path: <linux-kernel+bounces-116024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B4889503
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0995D1F2FF93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2650621FA0C;
	Mon, 25 Mar 2024 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdfTYvfk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF721A831;
	Sun, 24 Mar 2024 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323374; cv=none; b=RYKLdLezk+bet2HRBc7NfkZzWvtfRTbp3twiq0InjabOiyd+tPnQUWgeO80wo2GCDeDe0cVGsBV+7BZOu4F7cF31RRSQpJIP9G7EIuu+dc0h90K7NarsaKKVZ1nAbapw+aHohv1bRK+uNba02eKpryH2UjLYn0csSd+fo0tBrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323374; c=relaxed/simple;
	bh=/0BMG5w0XrsKasKJ5AD19XQUDouWcqEKSDPr6NyXcZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwVNuBm3Gk2lIU17JZfn/uzTqLVd8y30tXgSwS7XjiDkWM4Y/LYoM03I8mSyFkg+L1fk9dd+HUW0kIaADfBTmPh47+s9dTs3z6kVaz4jrdLZBXf07BAIUTeTUvZf1vI8J70OSEyoA5z1Ip51dQ8lc0UDeKerhPBIT5X73riV5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdfTYvfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125F7C433B1;
	Sun, 24 Mar 2024 23:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323373;
	bh=/0BMG5w0XrsKasKJ5AD19XQUDouWcqEKSDPr6NyXcZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdfTYvfkK1kS1VgCmXP/21WWRZOp5NzrOOzfIMlPOWBoaQYcSSJTmgA6f/ozDzYT6
	 FUlUgY0df5zNNhgJqjXqgsYVIV/smntZUVSEQ+d0XyUgGt5oebQHCbJaR8t8gdLfmU
	 KSi2sQkjUXKOfFOBMyeQB5eUPRn78RIG70L1p9jDhJKTS1MWbLhalClU+0zaz3m5sB
	 aXyFMn0xfscLjoT5WL0hn/wYF90ckCcfx9XZOZAU/V/IQThkLRD+Ba/R7xYanAasQk
	 6pgwkwMfr0uYJYKI1vxG58rkrM8elxW2yv69qnxx1FjH17w6Pn5WMRRgGqU7Dj+VTg
	 Fs77MCsPlVZHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 073/317] arm64: dts: imx8mm-kontron: Add support for ultra high speed modes on SD card
Date: Sun, 24 Mar 2024 19:30:53 -0400
Message-ID: <20240324233458.1352854-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit ec1e91d400bf21def54c441552bdf2976ce36e3b ]

In order to use ultra high speed modes (UHS) on the SD card slot, we
add matching pinctrls and fix the voltage switching for LDO5 of the
PMIC, by providing the SD_VSEL pin as GPIO to the PMIC driver.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 008820524844 ("arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals on BL board")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 28 ++++++++++++++++++-
 .../freescale/imx8mm-kontron-n801x-som.dtsi   |  2 ++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index 67e768032320a..25886622c8c40 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -191,8 +191,10 @@ usbnet: usbether@1 {
 };
 
 &usdhc2 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
 	vmmc-supply = <&reg_vdd_3v3>;
 	vqmmc-supply = <&reg_nvcc_sd>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
@@ -321,4 +323,28 @@ MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
 		>;
 	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+		>;
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index 646615ca4b48b..1b9fc3a926fcb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -86,6 +86,7 @@ pca9450: pmic@25 {
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 
 		regulators {
 			reg_vdd_soc: BUCK1 {
@@ -228,6 +229,7 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000083
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x141
+			MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x141
 		>;
 	};
 
-- 
2.43.0


