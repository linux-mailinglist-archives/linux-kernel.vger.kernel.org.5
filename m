Return-Path: <linux-kernel+bounces-27979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB8182F89E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4539E1C25010
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3099425571;
	Tue, 16 Jan 2024 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFg7+vif"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701765A786;
	Tue, 16 Jan 2024 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434742; cv=none; b=snL6eEDApRbu/GXzG92IGqfmontner5kCFIbR07wDCCRYJvnOj2VsOY646HMUHT1tDrp3DAg2wq7onlBNQAgCNSdZ/GvFGJ2jZIahsQpfkZ+ojevgfQ4WKlrpmsDAUCdk4MuyOzeyJHXWokpCQ6tp5HHKDNdO6P7TNFwEJ37/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434742; c=relaxed/simple;
	bh=arElsaYX5SkhFivEekp6V5p95usKRlSKuiPhQlJ5Lgo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=UWTT8ygbvOas4L1Pw3+qgVnX+/zA8erFZP0LRQMTuqBYLtukAojr8zkqVBx786I+Ihwekep8AMa5bMGXcr8IjaQH8OMyKhbb6FC8UpVSzH9fz9r6ZVrH7kHbV7hlTlMadE8Yv0QkCb+9o//RU1qon/5PQt1Lruc0Efsz0DNSg+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFg7+vif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1FFC433A6;
	Tue, 16 Jan 2024 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434742;
	bh=arElsaYX5SkhFivEekp6V5p95usKRlSKuiPhQlJ5Lgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFg7+vif5HhdZohfzxBzQ7MY4cWyhDPw965eTB44nb3daWZ+cJYClr02sj4jvwTvB
	 4UijEZwhNwxSY/kKjZWbbfBTEWhpgq3foT4MJmYeU72JlaHlhTWAIDGME6STpk268b
	 00lJDpPjVrC2Vu3AVwFXsRqc+wCVCnz+lkCMmje7zqNSzxl8xqSZ4aq33XdCVFTQzy
	 Eamk5DRM8r831+E4zIR8xG0LVS2xG9/6K5BH/D8ady0uzyfQdN5s0f4lMbaTqFdoXy
	 jaQGkantjDShnkOjZfF+xHNSxJG0nQ6oqw3j4WGuyTxBSJPL27hrXp5TCGcjRGLBf4
	 cvc+TuJpPyi/Q==
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
Subject: [PATCH AUTOSEL 6.6 068/104] ARM: dts: imx27-apf27dev: Fix LED name
Date: Tue, 16 Jan 2024 14:46:34 -0500
Message-ID: <20240116194908.253437-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
 arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts b/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts
index f047a8487073..849306cb4532 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts
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


