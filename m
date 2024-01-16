Return-Path: <linux-kernel+bounces-28061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEE082F9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBDA289E83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D881482E1;
	Tue, 16 Jan 2024 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCufvDmU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348BB60891;
	Tue, 16 Jan 2024 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435016; cv=none; b=jIpw4CvQLhCy3sFY55Gdj9TpktXFJc+DqMLInLCLRxyPBHg7PsWL2ClbaGaN2kLsLPsBoewnjEUStYlqKO6cyn6PS1Tf7EwsIfXwN+VZM4eyF4KXzykirYA9DsQgmXqxS1nlVhgp/X+6nqG0fOdYPG9pPR/PfAtfvR7dIXpsnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435016; c=relaxed/simple;
	bh=JlI0diivkOm2Nup6xaGE01ASMvwED6wXlfSg0DXu1XA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=UFYUEccXiY1j9r5wC7qQC/TWj57EYcUTIseWG89l0oDchgvXzJkDMqoFTlA7NzhEE2ZtrsJUc/QZbH10pBehgdSnl5imZuaiXkGeesYGNF09v07b9rRyCE7rt5moiMwbvpwpo+Qnp9HD1YJHA5s2QLph6e5R7otcRZrRjEW958g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCufvDmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5285C433B1;
	Tue, 16 Jan 2024 19:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435015;
	bh=JlI0diivkOm2Nup6xaGE01ASMvwED6wXlfSg0DXu1XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCufvDmU38j4AxiIwktyq8L3gClc/D/RUPnQ4IoT1qLtmRpIzfFjLKnkm9hsE8///
	 sId59a6JtJ/XVB3Hi8snrofnUUxEjpwMjm+LRI6NztdqydZUMxhvuIySK0kgJKVzRK
	 0OM+dh4yo5GU9y04lCVXVgVJoVBe1xbKY3YL6hH5kt7zm1dtWafCLbatXt/W6gMy7p
	 aOIg6L6XZ1v4hS9QggOoR9Rg6lVk2piHJWn1usKqekEQf0D/4W5HHlJwkLMxKgrB5x
	 R0KGm1Q3dWS4lwVE1aWje3BfEMrJxac8/XVhYlONz/tNkV9JZ6Rr2rSmdMZjQni9wW
	 gGGCp/EiqQAig==
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
Subject: [PATCH AUTOSEL 6.1 43/68] ARM: dts: imx23-sansa: Use preferred i2c-gpios properties
Date: Tue, 16 Jan 2024 14:53:42 -0500
Message-ID: <20240116195511.255854-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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


