Return-Path: <linux-kernel+bounces-74524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7654E85D571
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F268EB22B18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D453F8D1;
	Wed, 21 Feb 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oUycE2NW"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44F3F9FD;
	Wed, 21 Feb 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511000; cv=none; b=cG7RQkcXxGBxt8MdixW/OKPHAAu6ZJwCvI8bNGU4iSKlhFuZgLBLchJIB6xK8xmJXrVcHfUAv1DPZxYgZg3K02AQ8DPx8llzqsZQrYwzBDGKY3FEiC74rtnMdwXg5OB+zOVLLrCPuHEPthlvm1c7pdngF9DzDeIhBdMlHCU5OEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511000; c=relaxed/simple;
	bh=le3BALk+Oworr4tEt7cCYiWfOlR3LmiluAhEAP4F2ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kCWsprillTI2suZ/1nlAlLPdLJXmwHVI9EhPXknWmdm2cuvC9CF/8A1Ur5nJV4Kjdtk6ilOi3/zYR4SlwcwYviAny3YIcnvLzebuZnoWNUYNlViZat6kvvSmqHhPn8rsFE4+heQfqEJiOJYvKBpIQ6nPggtX+r+9FYUAZoNqwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oUycE2NW; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D51F240004;
	Wed, 21 Feb 2024 10:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708510997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rq+wybioC8LqyCl9R5OUbd29VCY4wio0dhlATjVMPPA=;
	b=oUycE2NWHhr9JKpRhvcQI/qQWVSEfDFzrJhUFpN1vSjWU6AyQn8imRa92hSo3TxEO0kEKx
	8rz7RIMtA4OqxCLr4Kv2NabqEcl0leme9LfP8D1gdy9lOJg1N5r55IEj/tXQdJkCj7QW5w
	s4Wi+m8Nw9sPf4+XrNb7w9ptO7eo0MIWpUDYylPlmG0N/aCX2mNsgbr2A3+5+/Ksc/jTAP
	2X02jS4CIFw+8y0eKzejrzdcTV6EKU5l7IkD5+t4vj3qeK/oT9nr9HGH+l7hV7juqO+VXK
	SiNNRFp7lKrPzNmt3vIVYHH4x+2Aw3e9fCkkCfZ/aeBusdC+fbyEEzQdLRIuNw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 21 Feb 2024 11:22:51 +0100
Subject: [PATCH v3 7/7] arm64: dts: rockchip: add the internal audio codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-rk3308-audio-codec-v3-7-dfa34abfcef6@bootlin.com>
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

The RK3308 has a built-in audio codec that connects internally to i2s_8ch_2
or i2s_8ch_3.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

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


