Return-Path: <linux-kernel+bounces-27787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A303E82F5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97901C24064
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E42230A;
	Tue, 16 Jan 2024 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm83Hd+V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920821A1A;
	Tue, 16 Jan 2024 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434198; cv=none; b=RYVZroGl95dIPGF95tv92TXLF0YHYzzWaHbvXMPsxM2rED//mUjyuF6zCIBt7XDT3lJTN+hYZ5UrifLXUy2JFx7sjRqZC0OocL6EzVo5+WwRLagxGeYDORqBZJ8ZjpZon7RPI6KAtdeMSMKnF51KMxAq/hYe8rMO4Zxl4LiFYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434198; c=relaxed/simple;
	bh=biU0qBk/I+LaCJLWDiaFheSahqmBYKM+VUTWIWw1ClA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=c9lO30MA/X/3ETfaTqXPwXkC7ThN5XTCct7XLyvrAbBK0VoLRQUHFye+0sS4m3cH8NwL7IXcJvfmwGwO3jTHugf34MwGPRgtUQhDkNKMrAm7+qw9HwcM/6IxL4oC0sF9vk5bNNOgXhHCKeyZXXw+xIHHgk+gKdz2aJNvpJwrXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm83Hd+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C93C43390;
	Tue, 16 Jan 2024 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434197;
	bh=biU0qBk/I+LaCJLWDiaFheSahqmBYKM+VUTWIWw1ClA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wm83Hd+V7izR3CkAbNPi5DIgWn5d5lX8xpqRrCqoUptEMa9FyqVBaZODBoW72CQMU
	 Ewh13lOQBTe1nJm3CKtjA9ls4aaE42pUzCglu836f7Ww3Jr3vL1Eg8T9Ein79ZcxjP
	 IcBGF186PHhNeUG7qfRiJP1HlxiFc/xwAId5ryP85tM4H5u9h2/UNBPa5V8sSqhQD9
	 Bj3HE9Gd+5anY7D5Bp9ODqvn3pePg6y+ivy8AwkxkiqfT4xqDNU/WY9RBT+T6aNhaW
	 +Pv1440D+U6BLnZiL0aShnppSg1ize9dPoQ7gsotGiUBolH3iOdrxz2ll2FT3oQyzl
	 ZZFR35TqSkskA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 017/108] ARM: dts: samsung: exynos4: fix camera unit addresses/ranges
Date: Tue, 16 Jan 2024 14:38:43 -0500
Message-ID: <20240116194225.250921-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit ba2a45a48503665f7e8eeec51f8b40456566b0cd ]

The camera node has both unit address and children within the same bus
mapping, thus needs proper ranges property to fix dtc W=1 warnings:

  Warning (unit_address_vs_reg): /soc/camera@11800000: node has a unit name, but no reg or ranges property
  Warning (simple_bus_reg): /soc/camera@11800000: missing or empty reg/ranges property

Subtract 0x11800000 from all its children nodes.  No functional impact
expected.

Link: https://lore.kernel.org/r/20230722121719.150094-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/samsung/exynos4.dtsi    | 26 +++++++++++------------
 arch/arm/boot/dts/samsung/exynos4x12.dtsi | 17 ++++++++-------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4.dtsi b/arch/arm/boot/dts/samsung/exynos4.dtsi
index f775b9377a38..7f981b5c0d64 100644
--- a/arch/arm/boot/dts/samsung/exynos4.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4.dtsi
@@ -203,16 +203,16 @@ dsi_0: dsi@11c80000 {
 
 		camera: camera@11800000 {
 			compatible = "samsung,fimc";
+			ranges = <0x0 0x11800000 0xa0000>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			#clock-cells = <1>;
 			clock-output-names = "cam_a_clkout", "cam_b_clkout";
-			ranges;
 
-			fimc_0: fimc@11800000 {
+			fimc_0: fimc@0 {
 				compatible = "samsung,exynos4210-fimc";
-				reg = <0x11800000 0x1000>;
+				reg = <0x0 0x1000>;
 				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_FIMC0>,
 					 <&clock CLK_SCLK_FIMC0>;
@@ -223,9 +223,9 @@ fimc_0: fimc@11800000 {
 				status = "disabled";
 			};
 
-			fimc_1: fimc@11810000 {
+			fimc_1: fimc@10000 {
 				compatible = "samsung,exynos4210-fimc";
-				reg = <0x11810000 0x1000>;
+				reg = <0x00010000 0x1000>;
 				interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_FIMC1>,
 					 <&clock CLK_SCLK_FIMC1>;
@@ -236,9 +236,9 @@ fimc_1: fimc@11810000 {
 				status = "disabled";
 			};
 
-			fimc_2: fimc@11820000 {
+			fimc_2: fimc@20000 {
 				compatible = "samsung,exynos4210-fimc";
-				reg = <0x11820000 0x1000>;
+				reg = <0x00020000 0x1000>;
 				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_FIMC2>,
 					 <&clock CLK_SCLK_FIMC2>;
@@ -249,9 +249,9 @@ fimc_2: fimc@11820000 {
 				status = "disabled";
 			};
 
-			fimc_3: fimc@11830000 {
+			fimc_3: fimc@30000 {
 				compatible = "samsung,exynos4210-fimc";
-				reg = <0x11830000 0x1000>;
+				reg = <0x00030000 0x1000>;
 				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_FIMC3>,
 					 <&clock CLK_SCLK_FIMC3>;
@@ -262,9 +262,9 @@ fimc_3: fimc@11830000 {
 				status = "disabled";
 			};
 
-			csis_0: csis@11880000 {
+			csis_0: csis@80000 {
 				compatible = "samsung,exynos4210-csis";
-				reg = <0x11880000 0x4000>;
+				reg = <0x00080000 0x4000>;
 				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_CSIS0>,
 					 <&clock CLK_SCLK_CSIS0>;
@@ -278,9 +278,9 @@ csis_0: csis@11880000 {
 				#size-cells = <0>;
 			};
 
-			csis_1: csis@11890000 {
+			csis_1: csis@90000 {
 				compatible = "samsung,exynos4210-csis";
-				reg = <0x11890000 0x4000>;
+				reg = <0x00090000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_CSIS1>,
 					 <&clock CLK_SCLK_CSIS1>;
diff --git a/arch/arm/boot/dts/samsung/exynos4x12.dtsi b/arch/arm/boot/dts/samsung/exynos4x12.dtsi
index 84c1db221c98..83d9d0a0a617 100644
--- a/arch/arm/boot/dts/samsung/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4x12.dtsi
@@ -451,14 +451,15 @@ &combiner {
 };
 
 &camera {
+	ranges = <0x0 0x11800000 0xba1000>;
 	clocks = <&clock CLK_SCLK_CAM0>, <&clock CLK_SCLK_CAM1>,
 		 <&clock CLK_PIXELASYNCM0>, <&clock CLK_PIXELASYNCM1>;
 	clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0", "pxl_async1";
 
 	/* fimc_[0-3] are configured outside, under phandles */
-	fimc_lite_0: fimc-lite@12390000 {
+	fimc_lite_0: fimc-lite@b90000 {
 		compatible = "samsung,exynos4212-fimc-lite";
-		reg = <0x12390000 0x1000>;
+		reg = <0x00b90000 0x1000>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_isp>;
 		clocks = <&isp_clock CLK_ISP_FIMC_LITE0>;
@@ -467,9 +468,9 @@ fimc_lite_0: fimc-lite@12390000 {
 		status = "disabled";
 	};
 
-	fimc_lite_1: fimc-lite@123a0000 {
+	fimc_lite_1: fimc-lite@ba0000 {
 		compatible = "samsung,exynos4212-fimc-lite";
-		reg = <0x123a0000 0x1000>;
+		reg = <0x00ba0000 0x1000>;
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_isp>;
 		clocks = <&isp_clock CLK_ISP_FIMC_LITE1>;
@@ -478,9 +479,9 @@ fimc_lite_1: fimc-lite@123a0000 {
 		status = "disabled";
 	};
 
-	fimc_is: fimc-is@12000000 {
+	fimc_is: fimc-is@800000 {
 		compatible = "samsung,exynos4212-fimc-is";
-		reg = <0x12000000 0x260000>;
+		reg = <0x00800000 0x260000>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_isp>;
@@ -525,9 +526,9 @@ pmu@10020000 {
 			reg = <0x10020000 0x3000>;
 		};
 
-		i2c1_isp: i2c-isp@12140000 {
+		i2c1_isp: i2c-isp@940000 {
 			compatible = "samsung,exynos4212-i2c-isp";
-			reg = <0x12140000 0x100>;
+			reg = <0x00940000 0x100>;
 			clocks = <&isp_clock CLK_ISP_I2C1_ISP>;
 			clock-names = "i2c_isp";
 			#address-cells = <1>;
-- 
2.43.0


