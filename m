Return-Path: <linux-kernel+bounces-28200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A17F82FB80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D39A7B23E85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDC7166CE3;
	Tue, 16 Jan 2024 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNHslym0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B9566B5F;
	Tue, 16 Jan 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435433; cv=none; b=TR8QaD17J5GCQmaIzx7lnQz4+sDV5nkr06LBt6+gR7SMSiX9f4WRGFaaYOk2PGYiaNhYfm9gtBrRHxciaaNb7o8qCvBbmPb2uWx8nFRy1sTCkvlXycjlndfxl1mLXtqy/YZMJWHNlET8OJU8JD9tw8sm7jRW5HAKvnAbzvmjlBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435433; c=relaxed/simple;
	bh=+0dGaX1WomVTx+JiBsBfua71kEuDLYrscLBuSIfB700=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=IlW9trAYBUK0vGlxSOcwULY1cfU0Gm7Iitz1Jgu1+kLDamYvbBckaO99UmxKXsE1LDQ3+jLEll94F2QsmTYLPWmCGNRzz69uSH+qRWONY7T0Cf4Xjfrzos4pWMj7MsiLY9KuENXWziNDz3NpAh+l88uaiL1RjaNJzIbhpTM5W1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNHslym0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405AFC43394;
	Tue, 16 Jan 2024 20:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435433;
	bh=+0dGaX1WomVTx+JiBsBfua71kEuDLYrscLBuSIfB700=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNHslym022SpyHfETgxfSdjXhSoV2kIur9/n3fmUWLKC/b+yx3qve2KFy8YtXxKIg
	 7a8uf5ot8VJbF0uO5ogdh6algx97Mk0zmWXiO/ET+OCDc4smDtE4LOxp45qPiCk48l
	 9/VmeGFa+KZOo9qi+6kGEEFGr9Pif8qBStifWnNLs2KQW1SQ4nWgO5FWQ9mrm5sjgX
	 Vn4J5xWTc13t0DdcTLPe2O16q5NYQxezkD8H+oBGV0yfdOA8QN20ytjFgwwaDCOKxN
	 4JVt8pF752xuhJlNymMZpF2zs09Rwn7aLBMr2LAYlQA7WxZxrEcdsGeGzfAofkbEjX
	 TDxbN4NoGt85w==
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
Subject: [PATCH AUTOSEL 5.4 20/31] ARM: dts: imx27-apf27dev: Fix LED name
Date: Tue, 16 Jan 2024 15:02:29 -0500
Message-ID: <20240116200310.259340-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit dc35e253d032b959d92e12f081db5b00db26ae64 ]

Per leds-gpio.yaml, the led names should start with 'led'.

Change it to fix the following dt-schema warning:

imx27-apf27dev.dtb: leds: 'user' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx27-apf27dev.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 68fcb5ce9a9e..3d9bb7fc3be2 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -47,7 +47,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		user {
+		led-user {
 			label = "Heartbeat";
 			gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
-- 
2.43.0


