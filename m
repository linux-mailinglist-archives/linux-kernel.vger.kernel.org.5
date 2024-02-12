Return-Path: <linux-kernel+bounces-61739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CE3851619
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5D8B254D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E14CB20;
	Mon, 12 Feb 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q4f4eUDZ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582146544;
	Mon, 12 Feb 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745487; cv=none; b=tzG13LN8O3Qq3GUGd+nV/Akxob8cJfA8cAyiEqxGS2biUWNacLxDFqCZNiqeOnrLn7Emfz8sbudRlTjvt2zstDVLXmrOST2qfCvQFJ3mLMWdjH2Axx/NlFQsJO2FIREGt9I37mhIatQZyKwsiKQDE/Wz303pgv7XoBYGjNRfeuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745487; c=relaxed/simple;
	bh=nHpU1D7vePiiUmMnW0BUVXPPq/tMiD6WtqmwDc11l5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPkOsGg5a0FOzl+k4YB2a1CE8NuSQbH2hDC9ntd4beB1UrPQ9PW6U3GdMczKqk8PjHJ3LFw2cO3quEDwkfysOQUCJIzTWK9Nod60FidS536nMvApYhMwDE3MaK+8s7nmdpNt6gqtt8CjedkC8YZUEAyDZxEkIvHK8KTVg3RTbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q4f4eUDZ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52E1CFF80F;
	Mon, 12 Feb 2024 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707745483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjzH8us36qfzbp3mhYrknBNc6xeLQlFhaU/yX/UTwvc=;
	b=Q4f4eUDZVfiGYGj1EG83eH4M3hyZfU8R6jntvSoDeeycvBzsEcymx1t/FZAdEXaMxL1qUO
	8eQjFJNQafi+NQk3G9nBTl1cx5pC5D1BQPUSTU79hsc4idcLORi5wGvJT72UsfW91M7y5O
	cm2XzWaIUxOCxsYEeDLqSg5cm9MFdjj00s/mI9e12YOaDhFqLgeyxvVb+xOK8EyrdP15d4
	4mD0RqrspkYtE85Il1Pc0EoRC0a7yahoAkNFl92QH4rKgx+fC2HvTfYbhFrGXp/MEbWO72
	1OTeRqWxfhJRHFguUgc+KbOfmAK8aBmUaM9Wlh5VoTdStg21abm3QVK4z1A8Fg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 12 Feb 2024 14:44:41 +0100
Subject: [PATCH v6 10/13] MIPS: mobileye: eyeq5: add OLB syscon node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-mbly-clk-v6-10-c46fa1f93839@bootlin.com>
References: <20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com>
In-Reply-To: <20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com>
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
X-Mailer: b4 0.12.4
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
2.43.0


