Return-Path: <linux-kernel+bounces-87464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E36D386D4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0171C1C220E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86609159E1F;
	Thu, 29 Feb 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srwhlFwB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C99159E08;
	Thu, 29 Feb 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239183; cv=none; b=IdNv7ppxui1ZAtrZMfctqFcLhKSxSCG/Tna9CWhFE8EAKpUerFMD+te2rTFs9MWCBvcZs+M5JNDvUqyKfl6Qp4A0sJzBnmhi95b1h+P5OJHO2n2TvrRuHnEpZnTTFALHG1nYdZFXyvdSI2Wv1tZEhBXgAIYWX/jbh5+lxgDlHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239183; c=relaxed/simple;
	bh=ayO7XyN49cXFaYIdOLLp2HPoo0b7cB0hWQMIZqiT/UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXUmc71ZKikcrkFeMallDSdbNb07ygy/g/YcCmSFpERyi8+GlcP5sEiH+6hIykKK0beQYVGkVKk0aUY8Y5yWV/gqpF5Q6LPocoDTcGNsuvKmt3eSsH0JvbfbbqFkjwrNO92yIzHaHK1+R8L4p45KwBqEAlL8CbbTSOwvOqqn0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srwhlFwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6D4C43390;
	Thu, 29 Feb 2024 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239183;
	bh=ayO7XyN49cXFaYIdOLLp2HPoo0b7cB0hWQMIZqiT/UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srwhlFwBaqayZ31Y/JDpMUmpsa/FebL+bwplEurkn2OHUXACRmQXS+5ilxO5WGayX
	 VMZFtOgRq+6Pb579/N99Af3J9eVHT0X/rXRYl2k7bAdGDMyLB/UsABgI2lblkMKvX1
	 nUYNZT60ejCvUseJZWVHJGzixKUt/uuUTa4wIZx7jlOAFb5ZU2snlGzQm5lU+GVRQj
	 uoBU2Ofxi2EPjSzO6LWnDQLoOBNdsyzQrsSolJr6ijEwTVssoj7geHFILvKuOKWZYK
	 t3VLHo+ctftTKZR2pc5k00MSu+jwuhjumEdzQaVuJ1TwnI7l3unmA2dOJi9LwTloy+
	 vAVK3it6dgm8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 05/22] ARM: dts: rockchip: Drop interrupts property from pwm-rockchip nodes
Date: Thu, 29 Feb 2024 15:38:58 -0500
Message-ID: <20240229203933.2861006-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203933.2861006-1-sashal@kernel.org>
References: <20240229203933.2861006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit f98643d8daf3443e3b414a82d0cb3d745f8c8bbc ]

The binding doesn't define interrupts and adding such a definition was
refused because it's unclear how they should ever be used and the
relevant registers are outside the PWM range. So drop them fixing
several dtbs_check warnings like:

	arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb: pwm@10280030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pwm/pwm-rockchip.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20240129113205.2453029-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rockchip/rv1108.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rv1108.dtsi b/arch/arm/boot/dts/rockchip/rv1108.dtsi
index abf3006f0a842..f3291f3bbc6fd 100644
--- a/arch/arm/boot/dts/rockchip/rv1108.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1108.dtsi
@@ -196,7 +196,6 @@ spi: spi@10270000 {
 	pwm4: pwm@10280000 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x10280000 0x10>;
-		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -208,7 +207,6 @@ pwm4: pwm@10280000 {
 	pwm5: pwm@10280010 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x10280010 0x10>;
-		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -220,7 +218,6 @@ pwm5: pwm@10280010 {
 	pwm6: pwm@10280020 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x10280020 0x10>;
-		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -232,7 +229,6 @@ pwm6: pwm@10280020 {
 	pwm7: pwm@10280030 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x10280030 0x10>;
-		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -386,7 +382,6 @@ i2c0: i2c@20000000 {
 	pwm0: pwm@20040000 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x20040000 0x10>;
-		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -398,7 +393,6 @@ pwm0: pwm@20040000 {
 	pwm1: pwm@20040010 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x20040010 0x10>;
-		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -410,7 +404,6 @@ pwm1: pwm@20040010 {
 	pwm2: pwm@20040020 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x20040020 0x10>;
-		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
@@ -422,7 +415,6 @@ pwm2: pwm@20040020 {
 	pwm3: pwm@20040030 {
 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
 		reg = <0x20040030 0x10>;
-		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
 		clock-names = "pwm", "pclk";
 		pinctrl-names = "default";
-- 
2.43.0


