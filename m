Return-Path: <linux-kernel+bounces-142614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C71B8A2DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE551C20D78
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F6955792;
	Fri, 12 Apr 2024 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSQqejBX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808CE54BD3;
	Fri, 12 Apr 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922749; cv=none; b=oBFYnUafrLul67y2IkW63dh5hOC4DKtA9H8CDNUz7X3lF92i7g+C/phkDPXV+EMMCuEjWLKds58M0fTM6QfUpTQJfK5tuMiYT6naCBd6d2DR241dY4TIpg65w/Nhk3kRZJgnQuUAy5A9Uwp5vCRZ1/ivHQIbOcqOO++NUTVAUUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922749; c=relaxed/simple;
	bh=tDkHRVEdpWscZ2zBfN20MYCSZo70ij53K5V5aJSiuY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gydMI8GaIi+bHz7RgiBL8glmVxdl39AFtRHK5cJtoW236claaTNYuZYXoFBRPOD0DxnNxXYkvVioVPyj+G5g58JDXmo85WOW9fKY9cr9EtBamYOE3SQ0WRhRZiJ980z1rEfHyCizlnviIldYw3MPjvK/meBSo5tSsF88zOZFTaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSQqejBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B12C113CC;
	Fri, 12 Apr 2024 11:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712922749;
	bh=tDkHRVEdpWscZ2zBfN20MYCSZo70ij53K5V5aJSiuY0=;
	h=From:Date:Subject:To:Cc:From;
	b=WSQqejBXQiD8VQ1rhERGu649DcEOjqgaLT21pID9O+co5uBuO2D75J5kxIa93nnGX
	 YE80ZSKcCMYsFILw5tzrGNu+umU13RXwL0+R1Dt5hu1M+4f6PQQcCru5ohQzTt5Oon
	 bj3mM0xp8QO2gvr0kW5eaARt5kfZuHIEr9/x2FXPzIgeVh4z9c33/TrMZ8n+Oonj+5
	 LlstWu65eRvykaaVqF01O/tKZQ4n1Frmv78+iAjZnQ7sLL7f2NN2vtNk0wdfKl+zj+
	 hc2HkG+9nWAmhkffNLvB9otGYDNaSjZb082Xo1HrbZ/jLlVVbdbHJ5PakQfGfTHTG5
	 NSrMxU7aLMEsA==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 12 Apr 2024 14:52:14 +0300
Subject: [PATCH] arm64: dts: ti: k3-am62*: Add PHY2 region to USB wrapper
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-for-v6-9-am62-usb-errata-dt-v1-1-ef0d79920f75@kernel.org>
X-B4-Tracking: v=1; b=H4sIAG0gGWYC/x3MTQqDQAwG0KtI1v1gDGrRq0gXUaPNwh8yKgXx7
 h1cvs27KKqbRmqyi1xPi7YuCfkro/4ry6SwIZk4cBGKnDGujrNCDZkrxhE7qLvsgmGHcF+WoXt
 rLYHSsLmO9nv29nPff4xgS0ltAAAA
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: afd@ti.com, srk@ti.com, r-gunasekaran@ti.com, b-liu@ti.com, 
 francesco@dolcini.it, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2612; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=tDkHRVEdpWscZ2zBfN20MYCSZo70ij53K5V5aJSiuY0=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmGSB5fzIe0oR9uaBVVpXHzU3tyQo24H75sNRBx
 aNe7Zj5iJKJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZhkgeQAKCRDSWmvTvnYw
 k+brEADJQId/UCesEm2S8hxTwwWf7z3CPiz1IrsORf2nyW1lW0H+T9NrKMfbnAuhu2CBdseuPVt
 GfBSl1jegY4+lYw5i0pM2vzYzHT+CWAuqZcCNpkmpkMpTuUGadYlpothox4I18IewoKHN1p4+qs
 NcjbfxxuVGL6Siw1tdxzM6GyAvFtIUrxFn/+xbbzCPSuJFxUhUR1U1VkUcL0VexcFOfYErfnohZ
 UcxLoiyIvjZkGvDGbCYOeG0aEr2smW/w6DMy1eC3ap7JKj6BPpEPCNmHOsjFxsNMwHefLOhfrER
 ic45h7PFLeh7jf51KZFIpWru9UmN5GwOj2uwIgsr9mpN/p7o2u0/JIsCf7As24yhfvODOrFluLW
 WZ/+PODgL/H/TTexlJPuAFvJxL9C7pNtoO+IRIT7sJMl3/RYxnqyiym7TmMHDUiGrp5m3Y6NDyt
 zRCJ96oSEDpGPKqsS2oDcVqvf2ZNejh2WfrUwMeZ6tlys6N5TE9y0947Xj2WZrCK28gSIIhEi3C
 ERP9zNWyj0yoPEshfwjIOAIOKf0cRykMbjdBssoZBRfAVbPWnQAEc4Jb2UUt9hQFWCTT+pK7uRw
 v3W6cppt91ycJGMPArtXtfPP4sUgFMjQ3D22/mNzv7xkKjQaQBd7OTCFD0PdW0ehqF4AxBdt8GE
 RqjngIiibTvjnKg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Add PHY2 register space to USB wrapper node. This is required
to deal with Errata i2409.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Hi Vignesh/Nishanth,

Please include this in -rc cycle. This should get rid of below
messages since v6.9-rc1

[    0.583305] dwc3-am62 f910000.dwc3-usb: invalid resource (null)
[    0.589304] dwc3-am62 f910000.dwc3-usb: can't map PHY IOMEM resource. Won't apply i2409 fix.

cheers,
-roger
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 6 ++++--
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index e9cffca073ef..e0ec28b14a07 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -619,7 +619,8 @@ sdhci2: mmc@fa20000 {
 
 	usbss0: dwc3-usb@f900000 {
 		compatible = "ti,am62-usb";
-		reg = <0x00 0x0f900000 0x00 0x800>;
+		reg = <0x00 0x0f900000 0x00 0x800>,
+		      <0x00 0x0f908000 0x00 0x400>;
 		clocks = <&k3_clks 161 3>;
 		clock-names = "ref";
 		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
@@ -644,7 +645,8 @@ usb0: usb@31000000 {
 
 	usbss1: dwc3-usb@f910000 {
 		compatible = "ti,am62-usb";
-		reg = <0x00 0x0f910000 0x00 0x800>;
+		reg = <0x00 0x0f910000 0x00 0x800>,
+		      <0x00 0x0f918000 0x00 0x400>;
 		clocks = <&k3_clks 162 3>;
 		clock-names = "ref";
 		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index aa1e057082f0..93494e30305b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -603,7 +603,8 @@ sdhci2: mmc@fa20000 {
 
 	usbss0: dwc3-usb@f900000 {
 		compatible = "ti,am62-usb";
-		reg = <0x00 0x0f900000 0x00 0x800>;
+		reg = <0x00 0x0f900000 0x00 0x800>,
+		      <0x00 0x0f908000 0x00 0x400>;
 		clocks = <&k3_clks 161 3>;
 		clock-names = "ref";
 		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
@@ -626,7 +627,8 @@ usb0: usb@31000000 {
 
 	usbss1: dwc3-usb@f910000 {
 		compatible = "ti,am62-usb";
-		reg = <0x00 0x0f910000 0x00 0x800>;
+		reg = <0x00 0x0f910000 0x00 0x800>,
+		      <0x00 0x0f918000 0x00 0x400>;
 		clocks = <&k3_clks 162 3>;
 		clock-names = "ref";
 		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240412-for-v6-9-am62-usb-errata-dt-a2c550b7e9a0

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


