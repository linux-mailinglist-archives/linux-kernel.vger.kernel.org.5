Return-Path: <linux-kernel+bounces-92527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D4B8721A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8D41C21647
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B91128381;
	Tue,  5 Mar 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="df4Hrjwu"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA086AC6;
	Tue,  5 Mar 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649429; cv=none; b=HnIcsEhbexqNQu5ork5povV8IViExDLrHLTIoIPjzcEnGYxr0RUwX3X5rwEzLxyT/agnMEq50rUkR7HmMAnrWpnxDlQusMs1L8q+rk4J2gz0NC+1KqR1FjaX3VdcmljwNG5rSYU4rC+7wRQu4ojOvM5iC+08O9POXyjawcCb7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649429; c=relaxed/simple;
	bh=dmp5KFcigV9N/0wkF+seHjqncGB1BmNzUlnwbTpFD8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2aMiTxnr153MrKuSQFst8jpPsk3V5KEFqqreg89WQdY1y4sCdzdQe3Dil9f9EA9Xb6dUAUo3kghWHN1762X+rW1yUy0SJU4zFsVJTg6+VXCHg6gC2OdPiAe/YuTBUwMt/zWIN0ThBBOS720VPrPAqsZqWJ7V5EZ/lKLz8nstCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=df4Hrjwu; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5299EC0008;
	Tue,  5 Mar 2024 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709649425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6o1HAKXtBl5rVLvoNigCvVZ6wM33rLm44ZB/B7ufNg=;
	b=df4HrjwuvptUVVpTjuESCaN83CMpEgi6TZgqQyQebF+TtMYicP6CvNanjzZhb+NMevKMaA
	I/voGdKrmqBZa9J/ifD3qF8CkCDbjPBK+KpEEBReS/mGxPt6GCp5HTz3p6/fjKxx1lw9qs
	uhOG++siVgIx/L/dSVXOAbusfzRwGzJn5QJj+9plfFdK49x7Dq4bJX+yeycd0YkOxmWtAZ
	wlg1K66c5OxEbOHkqBxUe9V79yH4aYlzOzu1hIhTMtUY5JPTNReCkIVZMhL92fQd/caxhg
	fJRu2JLjcDMDtyWG5e19/F8p31h8x2AUW+pQxYG/nlFo4Qxnk8skiOKK8821yA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 05 Mar 2024 15:36:34 +0100
Subject: [PATCH v4 7/7] arm64: dts: rockchip: add the internal audio codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-rk3308-audio-codec-v4-7-312acdbe628f@bootlin.com>
References: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
In-Reply-To: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

The RK3308 has a built-in audio codec that connects internally to i2s_8ch_2
or i2s_8ch_3.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v4: nothing
Changed in v3: nothing

Changed in v2:
 - use generic node name
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 662c55fe9b77..962ea893999b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -803,6 +803,20 @@ cru: clock-controller@ff500000 {
 		assigned-clock-rates = <32768>;
 	};
 
+	codec: codec@ff560000 {
+		compatible = "rockchip,rk3308-codec";
+		reg = <0x0 0xff560000 0x0 0x10000>;
+		rockchip,grf = <&grf>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		clocks = <&cru SCLK_I2S2_8CH_TX_OUT>,
+			 <&cru SCLK_I2S2_8CH_RX_OUT>,
+			 <&cru PCLK_ACODEC>;
+		reset-names = "codec-reset";
+		resets = <&cru SRST_ACODEC_P>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@ff580000 {
 		compatible = "arm,gic-400";
 		reg = <0x0 0xff581000 0x0 0x1000>,

-- 
2.34.1


