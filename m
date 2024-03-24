Return-Path: <linux-kernel+bounces-115592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2989B889441
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29221F2F746
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEB6251199;
	Mon, 25 Mar 2024 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7w+70QW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB11FB6ED;
	Sun, 24 Mar 2024 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321302; cv=none; b=qzCwkXo9XOUq0i16W/rkU295eStSlG+jCckNpZFnfokxt6BYqOf8W2EIv7ZaCSh2XkkIOOcGF3iI6nlyKSgkEY5zt7T+i+p2rGHx+UZO97XehDhxqovzplkU8JtEMKopTO/fxIkTrA6Yji5H3KP0Hq7ZnKSR2DZblEEcTRL6wJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321302; c=relaxed/simple;
	bh=ayO7XyN49cXFaYIdOLLp2HPoo0b7cB0hWQMIZqiT/UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ip7EnSXakPH+nUynn0a0wHr8lwZqef1I7MBqQmb3UKYyTZ6WwIMWQ5ptmziBOR4hc6pbF2jWp+U72hRr7W+yiD+3yivCvcBx4YgEcYhNiOBj5yui0bwEiXuJVRMzkoSM8u/Sgae/daTQzrwFTbIz9Xf4NCe3MyI3d/MpKTIWHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7w+70QW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB89C433C7;
	Sun, 24 Mar 2024 23:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321302;
	bh=ayO7XyN49cXFaYIdOLLp2HPoo0b7cB0hWQMIZqiT/UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7w+70QWkCYfMXcZfCgLOz1HZb0YrE6xPzxnCWbWPl7PgGOHbWxKBnlrmQ1avhiEr
	 Do6t7Exp9O23vi1KlETNMk5AwoiBthEGVFBNPIwrRAtvE8gMGsITaCXZKktSdsuDDr
	 ATOkGRiJuDUZcTHlptc4P87O4NzCaemgD8AiO5sJYQDNYhhc4bZVflnGweS4rYzETZ
	 OMwrdik8jVeTKskwqyedbwBoTbmBDTCUPgemmVPka62M+is0clXAE18r+EV2w+Wgzf
	 jiZyYHcvbeB7vb8jJQINQjzhnwGs701EZQA/rx2bhSLnRjOqzgZM+ByIoWgvQcuUPN
	 3ZMori32g+VyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 025/638] ARM: dts: rockchip: Drop interrupts property from pwm-rockchip nodes
Date: Sun, 24 Mar 2024 18:51:02 -0400
Message-ID: <20240324230116.1348576-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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


