Return-Path: <linux-kernel+bounces-75278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E89E85E5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0F51C23F88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFAF127B63;
	Wed, 21 Feb 2024 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lycHcIQt"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723C86AC6;
	Wed, 21 Feb 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539746; cv=none; b=pbSN+UupDKufZkrBwxVlbwo7zgHENHJ1810TQW1mZVFiBniDOBnZKgkqtTW1pfVRaanbDQvd/ZY6PTZnsCZBY2UaVijV8HLUNMNAbMKLeqfg+X/0QtBQr2t0u0pZ0KIRnsTWOxPqGwoxXxQc1RZkiHzNnAwUFMaslhyQ78ft4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539746; c=relaxed/simple;
	bh=N31M8X9wNmtXzV0/yST3SuCYR1aavyH1pF0I9aDo3z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaMWHIgPQ+J6wMca1B1GvGQZIG6aOiUfjGcjrWuRniNAkLXK/ov1ar4ZCD2P4vtN8NO5pmpT90hZdudkMRn0KlB/AxgxV0l8/dC89cQwXkS2GpVSsA5nb1gjAv2v7+SMiekCe616tgjA2ZJKBZnsDH9AiR/keQ2Rr0CfqwUBfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lycHcIQt; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2E921C000C;
	Wed, 21 Feb 2024 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708539741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFVKnzfWvnwDh4IhKHiF7lZs1WjOrl8WC7ju/i+sQcA=;
	b=lycHcIQt658blsBxqwiyJ84aWdPXKybxsci5EFWI+IQNeitXoILMO9CyCFYfdVWa1jJ2Nt
	4Q3HKkBef2lzEhNy6jVziameihRl+BMXpq2Wv06Lqx2hMH+2TCQR6J5pyfbdsaKaBeRVQK
	XAWnMHitIWcSauHIBtkP0fu0ZMOmQYiIYxt/2nOIqu2/7D02mM2SVSAAGOPGFrnVosjRpk
	AoaFV5nbKH6KRaQmgXbTdPqh621ny/kjPHcYGP33j5pprZnZaqY78bFCS+EB1/saaHQLQ0
	U2ZEbKkATAzGlKvK3V1sHMaCkPCTh6oUxjvqAliqza7HW8qwmtFyAYztkS966A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 21 Feb 2024 19:22:19 +0100
Subject: [PATCH v7 11/14] MIPS: mobileye: eyeq5: add OLB syscon node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240221-mbly-clk-v7-11-31d4ce3630c3@bootlin.com>
References: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
In-Reply-To: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

The OLB ("Other Logic Block") is a syscon region hosting the clock,
reset and pin controllers. It contains registers such as I2C speed mode
that need to be accessible by other nodes.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 6cc5980e2fa1..e82d2a57f6da 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -100,6 +100,14 @@ uart2: serial@a00000 {
 			clock-names = "uartclk", "apb_pclk";
 		};
 
+		olb: system-controller@e00000 {
+			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
+			reg = <0 0xe00000 0x0 0x400>;
+			ranges = <0x0 0x0 0xe00000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		gic: interrupt-controller@140000 {
 			compatible = "mti,gic";
 			reg = <0x0 0x140000 0x0 0x20000>;

-- 
2.43.2


