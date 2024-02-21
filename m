Return-Path: <linux-kernel+bounces-74522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90585D56F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D46B22651
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F5D3FB3D;
	Wed, 21 Feb 2024 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gTkdAxdp"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A003F9C7;
	Wed, 21 Feb 2024 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510999; cv=none; b=H/OUTNu+0bqFuZFwos5iMcVBzB9veL+FJP0i+cfk9s1FXWYGXx76BEVcaaZjHrNDuNZNPi3fx2jdYxb+vR0k0Z3ABVYSxFJsAnXSt4Xf5g53q+NSHjiYxwDkylh44jclwYrKcQcpEFtio+P6uIk6w6L1mNsZMkSW+L1X8TU5C80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510999; c=relaxed/simple;
	bh=+yGbGiI24t+W2Bp2efLYqIYXXDDM72kz7c0Klu7lBMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqlkOKzqMwpnul2lDfY3dv2FhGZi6D+r+P8viCa1Bst//i7JJKlzYnP+8j6tu+j+iSLDwYhhJ1OYutB7/qm+1xW/95X1OS571XSXsFNi3FZY3cJ0cNTMXRrOjr8hRHtWIr1Et3UcH4Rbtn+vgWIKDrswX7nUrMfvCBHcqIGeMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gTkdAxdp; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE329240010;
	Wed, 21 Feb 2024 10:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708510995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWbWCTYyAQwf0LtBE1VVskpeIdxRHchlRxwTXwLtd0o=;
	b=gTkdAxdpR2GYxCrFuY6znSl12BPpGG6/lyJx0oiZzfsvqtn76f5mrYOKxDV4bAi1v1l/yK
	qIQQBRnIYmy9fOSGaS5OSTwk16I0OS7+v4k22JApLwCg1nmERTQAW4ES1dKefel8A69RKJ
	quiHMV1ewtMgP0jEQ+RJ5atPtV9BJ3klCly6iq3UWfQRbHHzGVvOsZOH6hFI+NlmSvrmdr
	PaGLF3yGeUdpIb7UoruJcfAjZ3IO5+xW2UjHgzwv9tikmoTtvakiTGO3/P4QKQV0MjI9jz
	zD7C85szE5dFczvrW/zhL9oJTSVTtHs5eVa1z9jgfFuChGm34qCcxlFh2lyXpg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 21 Feb 2024 11:22:50 +0100
Subject: [PATCH v3 6/7] arm64: dts: rockchip: add i2s_8ch_2 and i2s_8ch_3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-rk3308-audio-codec-v3-6-dfa34abfcef6@bootlin.com>
References: <20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com>
In-Reply-To: <20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: luca.ceresoli@bootlin.com

These are I2S engines internally connected to the built-in audio codec.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v3:
 - removed the 4 optional clocks

Changed in v2: nothing
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index cfc0a87b5195..662c55fe9b77 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -578,6 +578,48 @@ dmac1: dma-controller@ff2d0000 {
 		#dma-cells = <1>;
 	};
 
+	/*
+	 * - can be clock producer or consumer
+	 * - up to 8 capture channels and 2 playback channels
+	 * - connected internally to audio codec
+	 */
+	i2s_8ch_2: i2s@ff320000 {
+		compatible = "rockchip,rk3308-i2s-tdm";
+		reg = <0x0 0xff320000 0x0 0x1000>;
+		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		clocks = <&cru SCLK_I2S2_8CH_TX>,
+			 <&cru SCLK_I2S2_8CH_RX>,
+			 <&cru HCLK_I2S2_8CH>;
+		dmas = <&dmac1 5>, <&dmac1 4>;
+		dma-names = "rx", "tx";
+		resets = <&cru SRST_I2S2_8CH_TX_M>, <&cru SRST_I2S2_8CH_RX_M>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+	};
+
+	/*
+	 * - can be clock consumer only
+	 * - up to 4 capture channels, no playback
+	 * - connected internally to audio codec
+	 */
+	i2s_8ch_3: i2s@ff330000 {
+		compatible = "rockchip,rk3308-i2s-tdm";
+		reg = <0x0 0xff330000 0x0 0x1000>;
+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		clocks = <&cru SCLK_I2S3_8CH_TX>,
+			 <&cru SCLK_I2S3_8CH_RX>,
+			 <&cru HCLK_I2S3_8CH>;
+		dmas = <&dmac1 7>;
+		dma-names = "rx";
+		resets = <&cru SRST_I2S3_8CH_TX_M>, <&cru SRST_I2S3_8CH_RX_M>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+	};
+
 	i2s_2ch_0: i2s@ff350000 {
 		compatible = "rockchip,rk3308-i2s", "rockchip,rk3066-i2s";
 		reg = <0x0 0xff350000 0x0 0x1000>;

-- 
2.34.1


