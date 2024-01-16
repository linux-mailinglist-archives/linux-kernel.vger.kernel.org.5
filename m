Return-Path: <linux-kernel+bounces-28119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDC982FA69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA341F27490
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5C2E3FF;
	Tue, 16 Jan 2024 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrDMgRFc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1462A154C1A;
	Tue, 16 Jan 2024 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435181; cv=none; b=By3KL7OiJtcTe5RWKoaZrT+9o18i/xBC3A8KfRKXfdTSyPjkQCfz9Ry9z3ZDHVixsJYfeJRWBq0gHp/e6iu/9Yr/zVVCqEdZH9un459AuKeedRH1eUnRV7vtLP5ZqPdJmnGQC/mayqXzhIn4VpdIzoaqy/4U2xcJw6FMAHy8cOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435181; c=relaxed/simple;
	bh=JlI0diivkOm2Nup6xaGE01ASMvwED6wXlfSg0DXu1XA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=BhV5I0/OcCCUcPk60wp3O9bQOVRWKAnpodAMPY0R2++NDj225JWlM3vCGONBg7m3+UQGl1EtiOAW83UF1070/ZAd2Q+vyT7PnTPPzQgyAe96xgQsaTugp8NWcSUH5Zzp/92UKeeqMBFep06voi+N+ZWdP7UAGEkJRTn5hrZZrqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrDMgRFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CC6C43390;
	Tue, 16 Jan 2024 19:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435180;
	bh=JlI0diivkOm2Nup6xaGE01ASMvwED6wXlfSg0DXu1XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrDMgRFc0Vx8E0x+9e9lcP80NU2oHgLAiZmLwdQgXMTvfUuJE/oNWydyR5HSrVhxH
	 v0+rMus2TyXe/e1IiQY82xw9+Pg5O7OGcQ2XYz0FwQwsuhf62OoXaOkudZMHgK3etI
	 vOL9lrGMOM8zA+75WcOEAlceLiOyYjCZPCGVz9HtdjX9UXbH9T2TOV8h4cP0GzGTY2
	 WL0dQ3PCFlg9j3mpLspcD9WgXX097pWORxVFcImuhe5tGDwShWaqhnZIBpJhs4EhQc
	 C6u7U2j36SBQJEjFRBHR6WOFa2vCO7s21yHhANc4EWYG+lENSrqEYsoYDnGvUnYjVf
	 88dSk2EN1xCCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 31/47] ARM: dts: imx23-sansa: Use preferred i2c-gpios properties
Date: Tue, 16 Jan 2024 14:57:34 -0500
Message-ID: <20240116195834.257313-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit e3aa1a82fb20ee97597022f6528823a8ab82bde6 ]

The 'gpios' property to describe the SDA and SCL GPIOs is considered
deprecated according to i2c-gpio.yaml.

Switch to the preferred 'sda-gpios' and 'scl-gpios' properties.

This fixes the following schema warnings:

imx23-sansa.dtb: i2c-0: 'sda-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
imx23-sansa.dtb: i2c-0: 'scl-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx23-sansa.dts | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/imx23-sansa.dts
index 46057d9bf555..c2efcc20ae80 100644
--- a/arch/arm/boot/dts/imx23-sansa.dts
+++ b/arch/arm/boot/dts/imx23-sansa.dts
@@ -175,10 +175,8 @@ i2c-0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio1 24 0		/* SDA */
-			&gpio1 22 0		/* SCL */
-		>;
+		sda-gpios = <&gpio1 24 0>;
+		scl-gpios = <&gpio1 22 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 	};
 
@@ -186,10 +184,8 @@ i2c-1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio0 31 0		/* SDA */
-			&gpio0 30 0		/* SCL */
-		>;
+		sda-gpios = <&gpio0 31 0>;
+		scl-gpios = <&gpio0 30 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 
 		touch: touch@20 {
-- 
2.43.0


