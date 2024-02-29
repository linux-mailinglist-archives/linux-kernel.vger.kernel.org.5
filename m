Return-Path: <linux-kernel+bounces-87456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8B86D4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53F51F2445D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9E5156D0B;
	Thu, 29 Feb 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4LAO3cm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7710156D15;
	Thu, 29 Feb 2024 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239108; cv=none; b=NpsuYSdx+c5WbiKbz4LBrCIkxfcl7nl9SwP5U9m1CWV4MezsQX9cI3Vvle02BcNVozgT8/B8+M68yWHVwuJDcXuNGduw2NoNDk+wYbA9qzbjO1nox0igC14Nc4uYssGL/AwXSqJSk6LRjbmY/Bu7apv5qH+r/nq4vi4p0uUl2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239108; c=relaxed/simple;
	bh=Hydcgv3m0EEIxLFQJmaHc1+FBJMwBP1WrXhgZbFNRGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyMJ82+ZN2d78MZEqo8N3yzBA35fiXR4cA8K/JcToS+wXwm08krWm8uWvXHdO8qcJDRlmkkIsuGmieyS0TDQ0FcpSuOsXhHusVB4VNr+A21uVH6t8b5Ny5DxlqJ7oZtWUSDMtrDdVB1yodMY2WMoa9Ug1AjrZ34mWli2nHAjWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4LAO3cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DF4C43399;
	Thu, 29 Feb 2024 20:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239108;
	bh=Hydcgv3m0EEIxLFQJmaHc1+FBJMwBP1WrXhgZbFNRGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4LAO3cm3k2Dd55ywmnyBEpiUtfFKn24moHHglt8g4z3etsD6Up9yb7U+6zAB8ej8
	 YIJbVk+/RYphkMbLQ6FjyVyKVkMYGbFob+Sg29knIaUZsXi+qkXET9Pl9MLX2aB7sk
	 +kC01Ycpt/Ntc3eZRtkYZ4/McHRHuZle0dJrcF90A5in39x0/OURUiXSSZjixTJYNv
	 FvNKlafbwO1GpZAPLT4JF8C58hQo/avBM46PyhZwmXEHYPZk1AGgpM1EQXSDgRYwBE
	 vaws/1YRzvphXtUTDYZyBJVhwZ4w6oMBOgtSPU97h6pbwtc1CFcYPvr1++yhuPiApi
	 QGpOU0xvhnQow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	magnus.damm@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 23/24] ARM: dts: renesas: rcar-gen2: Add missing #interrupt-cells to DA9063 nodes
Date: Thu, 29 Feb 2024 15:37:03 -0500
Message-ID: <20240229203729.2860356-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 8c987693dc2d292d777f1be63cb35233049ae25e ]

make dtbs_check W=2:

    arch/arm/boot/dts/renesas/r8a7790-lager.dts:444.11-458.5: Warning (interrupt_provider): /i2c-mux4/pmic@58: Missing '#interrupt-cells' in interrupt provider
    ...

Fix this by adding the missing #interrupt-cells properties.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/a351e503ea97fb1af68395843f513925ff1bdf26.1707922460.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/renesas/r8a7790-lager.dts   | 1 +
 arch/arm/boot/dts/renesas/r8a7790-stout.dts   | 1 +
 arch/arm/boot/dts/renesas/r8a7791-koelsch.dts | 1 +
 arch/arm/boot/dts/renesas/r8a7791-porter.dts  | 1 +
 arch/arm/boot/dts/renesas/r8a7792-blanche.dts | 1 +
 arch/arm/boot/dts/renesas/r8a7793-gose.dts    | 1 +
 arch/arm/boot/dts/renesas/r8a7794-alt.dts     | 1 +
 arch/arm/boot/dts/renesas/r8a7794-silk.dts    | 1 +
 8 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/renesas/r8a7790-lager.dts b/arch/arm/boot/dts/renesas/r8a7790-lager.dts
index 4d666ad8b114b..b17a9f9307e59 100644
--- a/arch/arm/boot/dts/renesas/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/renesas/r8a7790-lager.dts
@@ -432,6 +432,7 @@ pmic@58 {
 			interrupt-parent = <&irqc0>;
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
+			#interrupt-cells = <2>;
 
 			rtc {
 				compatible = "dlg,da9063-rtc";
diff --git a/arch/arm/boot/dts/renesas/r8a7790-stout.dts b/arch/arm/boot/dts/renesas/r8a7790-stout.dts
index fe14727eefe1e..25956661a8754 100644
--- a/arch/arm/boot/dts/renesas/r8a7790-stout.dts
+++ b/arch/arm/boot/dts/renesas/r8a7790-stout.dts
@@ -332,6 +332,7 @@ pmic@58 {
 		interrupt-parent = <&irqc0>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		onkey {
 			compatible = "dlg,da9063-onkey";
diff --git a/arch/arm/boot/dts/renesas/r8a7791-koelsch.dts b/arch/arm/boot/dts/renesas/r8a7791-koelsch.dts
index 545515b41ea3f..ec01cc8595161 100644
--- a/arch/arm/boot/dts/renesas/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/renesas/r8a7791-koelsch.dts
@@ -795,6 +795,7 @@ pmic@58 {
 		interrupt-parent = <&irqc0>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		rtc {
 			compatible = "dlg,da9063-rtc";
diff --git a/arch/arm/boot/dts/renesas/r8a7791-porter.dts b/arch/arm/boot/dts/renesas/r8a7791-porter.dts
index ec0a20d5130d6..fcc9a2313e1df 100644
--- a/arch/arm/boot/dts/renesas/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/renesas/r8a7791-porter.dts
@@ -389,6 +389,7 @@ pmic@5a {
 		interrupt-parent = <&irqc0>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		watchdog {
 			compatible = "dlg,da9063-watchdog";
diff --git a/arch/arm/boot/dts/renesas/r8a7792-blanche.dts b/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
index e793134f32a30..af16f251849c6 100644
--- a/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/renesas/r8a7792-blanche.dts
@@ -332,6 +332,7 @@ pmic@58 {
 		interrupt-parent = <&irqc>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		rtc {
 			compatible = "dlg,da9063-rtc";
diff --git a/arch/arm/boot/dts/renesas/r8a7793-gose.dts b/arch/arm/boot/dts/renesas/r8a7793-gose.dts
index 79b537b246426..9358fc7d0e9f6 100644
--- a/arch/arm/boot/dts/renesas/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/renesas/r8a7793-gose.dts
@@ -735,6 +735,7 @@ pmic@58 {
 		interrupt-parent = <&irqc0>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		rtc {
 			compatible = "dlg,da9063-rtc";
diff --git a/arch/arm/boot/dts/renesas/r8a7794-alt.dts b/arch/arm/boot/dts/renesas/r8a7794-alt.dts
index 08df031bc27c9..73ec4d3541541 100644
--- a/arch/arm/boot/dts/renesas/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/renesas/r8a7794-alt.dts
@@ -453,6 +453,7 @@ pmic@58 {
 		interrupt-parent = <&gpio3>;
 		interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		rtc {
 			compatible = "dlg,da9063-rtc";
diff --git a/arch/arm/boot/dts/renesas/r8a7794-silk.dts b/arch/arm/boot/dts/renesas/r8a7794-silk.dts
index b7af1befa126b..b825f2e25dd06 100644
--- a/arch/arm/boot/dts/renesas/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/renesas/r8a7794-silk.dts
@@ -424,6 +424,7 @@ pmic@58 {
 		interrupt-parent = <&gpio3>;
 		interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		onkey {
 			compatible = "dlg,da9063-onkey";
-- 
2.43.0


