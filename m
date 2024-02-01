Return-Path: <linux-kernel+bounces-48071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7468456DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32541F26D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0F215DBCE;
	Thu,  1 Feb 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3IIuMi0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59B163AB0;
	Thu,  1 Feb 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789039; cv=none; b=XXwlTIAJc8sKEqPFY2OvEVv3JAs39N2TjxL5lXp+ErvWaNLdjFnx2gUxpGUmfVL/UMjm4CFtI+GojTTUIolmMp56gQrk9NYMNwmC9EeWNAKcLAE7qiwoZzPp/+PKucEryz54G6NTxxoEOCKO0rqpTMRvpUGR8MMUrGGpPg27lEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789039; c=relaxed/simple;
	bh=RkISr3n1VWVb0JqS3ctW9rc03+xFECrO3YJ4+fwugsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EDTg83uQbdy0AgNpAdkQ3rJVuNx1pzdFyA9bRmOQQSvXrs7RtYdA+IpPKApJXL65FZ7GLXsMDSs8SF9nrIRcN++rjrEHe4qbv55akhNmEXclp3wOKDXepx0P2S+rXQ/Xny4r6ilDXqQBor8v3bLFiygNJP8kqw8MR8qBWavc2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3IIuMi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80BAC43390;
	Thu,  1 Feb 2024 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789039;
	bh=RkISr3n1VWVb0JqS3ctW9rc03+xFECrO3YJ4+fwugsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P3IIuMi09TRxhrQmxE2CkcaAr7oxdQx1HfUTXCSB1b86f9acz51ShTficHcwuJAub
	 4+t4noPsgsdf0ocpR7b1LEyMKlC2fpZ7SOcSl8p/XQua2gOGmcQZzy8VvNOAJsUBZo
	 yZDfVzRHH8Y8BhD6lh73/xdVi45RX6ROBeujJqJqe1h7yC96V92QJPQCtuCplFKxcb
	 ofgX78sE759tphwMj8cHsiAeh2GNO3Nuqc+KYU/6/33yKH6i+aEP6umtDUv1ODTW2w
	 mYR+QhYFJHJfLxm2nzFlQgrhna1wSaOysnVGZtQf7RkdbEJ4k9oRx/1KRG8GucRVlT
	 WOblGoVKCvREg==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com
Cc: afd@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 5/5] arm64: dts: ti: k3-am62*: Add PHY2 region to USB wrapper node
Date: Thu,  1 Feb 2024 14:03:32 +0200
Message-Id: <20240201120332.4811-6-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201120332.4811-1-rogerq@kernel.org>
References: <20240201120332.4811-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PHY2 register space to USB wrapper node. This is required
to deal with Errata i2409.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    Changelog:
    
    v3 - new patch

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 6 ++++--
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 6 ++++--
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 9432ed344d52..da50fbfcce56 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -622,7 +622,8 @@ sdhci2: mmc@fa20000 {
 
 	usbss0: dwc3-usb@f900000 {
 		compatible = "ti,am62-usb";
-		reg = <0x00 0x0f900000 0x00 0x800>;
+		reg = <0x00 0x0f900000 0x00 0x800>,
+		      <0x00 0x0f908000 0x00 0x400>;
 		clocks = <&k3_clks 161 3>;
 		clock-names = "ref";
 		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
@@ -645,7 +646,8 @@ usb0: usb@31000000 {
 
 	usbss1: dwc3-usb@f910000 {
 		compatible = "ti,am62-usb";
-		reg = <0x00 0x0f910000 0x00 0x800>;
+		reg = <0x00 0x0f910000 0x00 0x800>,
+		      <0x00 0x0f918000 0x00 0x400>;
 		clocks = <&k3_clks 162 3>;
 		clock-names = "ref";
 		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 8311c7c44cd3..523bab94eace 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -563,7 +563,8 @@ sdhci1: mmc@fa00000 {
 
 	usbss0: dwc3-usb@f900000 {
 		compatible = "ti,am62-usb";
-		reg = <0x00 0x0f900000 0x00 0x800>;
+		reg = <0x00 0x0f900000 0x00 0x800>,
+		      <0x00 0x0f908000 0x00 0x400>;
 		clocks = <&k3_clks 161 3>;
 		clock-names = "ref";
 		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
@@ -586,7 +587,8 @@ usb0: usb@31000000 {
 
 	usbss1: dwc3-usb@f910000 {
 		compatible = "ti,am62-usb";
-		reg = <0x00 0x0f910000 0x00 0x800>;
+		reg = <0x00 0x0f910000 0x00 0x800>,
+		      <0x00 0x0f918000 0x00 0x400>;
 		clocks = <&k3_clks 162 3>;
 		clock-names = "ref";
 		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 17d28390d587..ae0ab67460b4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -562,7 +562,8 @@ sdhci2: mmc@fa20000 {
 
 	usbss0: usb@f900000 {
 		compatible = "ti,am62-usb";
-		reg = <0x00 0x0f900000 0x00 0x800>;
+		reg = <0x00 0x0f900000 0x00 0x800>,
+		      <0x00 0x0f908000 0x00 0x400>;
 		clocks = <&k3_clks 161 3>;
 		clock-names = "ref";
 		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
@@ -585,7 +586,8 @@ usb0: usb@31000000 {
 
 	usbss1: usb@f910000 {
 		compatible = "ti,am62-usb";
-		reg = <0x00 0x0f910000 0x00 0x800>;
+		reg = <0x00 0x0f910000 0x00 0x800>,
+		      <0x00 0x0f918000 0x00 0x400>;
 		clocks = <&k3_clks 162 3>;
 		clock-names = "ref";
 		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
-- 
2.34.1


