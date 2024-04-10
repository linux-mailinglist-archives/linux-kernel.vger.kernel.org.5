Return-Path: <linux-kernel+bounces-138257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F11C789EEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA0CB23097
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5DE159593;
	Wed, 10 Apr 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DuEN1tE7"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324A156C67;
	Wed, 10 Apr 2024 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741358; cv=none; b=dPeub1UboPJJSTS2pjoXTiuki4+gFm8uTzBdWtpuD3toqpWiUVZ6BvxBYaqCINJtv2Um4+3y6gGKOhb5ghqDSzldrSxzvr981dy41ikdHQ08XPcTkqJOEsfv8Yhz6BmRUrXnYMRbHvpMVRsy06igaqA43X+sAtGnWmC5HSZ5RuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741358; c=relaxed/simple;
	bh=vuFml2Tbieyo6tIWPbphQoCJOz5E27f346lkQPXpqDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htJ+kC9ArNxFWdXkkNapuxbyUU3R5EETk2kLEq18eJ8G18yIcE4DOcXcScNnBP1xbLgIqPWtdnkn7lUSw5+v0KII9p3QX9MOBCJLnGRaxx+YvtEVxtEmucN6obhTWEyIf2eqw7uv1g4u8+isYsRbJgdTnoLWGNig6B8eSm6HWjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DuEN1tE7; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F571C0015;
	Wed, 10 Apr 2024 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712741354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Ysm4DbzpqSZj84XzesirmTyGQsD5pPgqx8ZXriQXW0=;
	b=DuEN1tE7IEmwzzZI41CG8Wl+2Q91FSN024Kmli244kCLZCdJ3w35RL8XTJat16WMIAVdN3
	Uf+unyEXT7yYVJhu0zXL5gib5t//O1q5m6Q/9HdG/JX2fF1eKnV7mslRbcoKtbnM51ZUOL
	LZfaRqu/UDsss7gJb5LTuOEEb835LChQ2K/bFJmu31+Md/W9inFbnEK4IjkdxP0XmIhmjN
	4ClCzHDNjPf1syt2qn1srXxqrgneneaL5otzFM/CYocVIqGRifrcUVq0ER0hbCApYrhDIc
	zQ5FsosqZNTyKu3pVT5hgjQvE9d4h0BNxyHn5MVlrwUIqbW1qcr5DCTyjievAg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 11:29:11 +0200
Subject: [PATCH v3 8/9] MIPS: mobileye: eyeq5: Add SPI-NOR controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-cdns-qspi-mbly-v3-8-7b7053449cf7@bootlin.com>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
In-Reply-To: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add Cadence Quad SPI controller node to EyeQ5 SoC devicetree.
Octal is supported.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 8d4f65ec912d..1543c2b9bcb6 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -158,6 +158,21 @@ timer {
 				clocks = <&core0_clk>;
 			};
 		};
+
+		ospi: spi@2100000 {
+			compatible = "mobileye,eyeq5-ospi", "cdns,qspi-nor";
+			reg = <0 0x2100000 0x0 0x1000>,
+			      <0 0x10000000 0x0 0x8000000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clocks EQ5C_DIV_OSPI>;
+			assigned-clocks = <&clocks EQ5C_DIV_OSPI>;
+			assigned-clock-rates = <167000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x00000000>;
+		};
 	};
 };
 

-- 
2.44.0


