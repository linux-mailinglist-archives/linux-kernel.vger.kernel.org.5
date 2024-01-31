Return-Path: <linux-kernel+bounces-46802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BB784447C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DCA1C25F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7513DB8A;
	Wed, 31 Jan 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Es78e1Ie"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7991386A8;
	Wed, 31 Jan 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718448; cv=none; b=mnLVjC19H8qReeFMu1PsusQHK07Xo6M0Cbas7cP8EP8khClpTs/4YQc55KjFXI93RKLCo7ki2EC9rR6LofydEwGWDiL0L+Hm2hysmtogPwfBKbHc6m/3SNvTcQuHgTDq/YF0M7jjgD+My1Y9gXa8ptbVs/h4uVi8mTnB/dGifLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718448; c=relaxed/simple;
	bh=oGVuFQH2Vpt7KWBJelUxk+aICBl1NUF8Jkkl7r/J8tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQS3gPT9oH8yXrNzqr/v6YI7v1DGjCvhRGnjEKE0WhfyTSQh11uWBkLUqoTjb4bk4S8RpIJTU4zaiQnRj66pWY+u9858Msmp75osnW3n7cCTL8MqMNkBSFodypW7NwFlAiDu+aGZ+vGZa+foHGpxOHlzmM4yW9E3AVAukfSP7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Es78e1Ie; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C549340006;
	Wed, 31 Jan 2024 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706718443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJeokSopmVKcL3uXVtWha5+P5NH0m5rgY0PH8CJYzgU=;
	b=Es78e1IesRvttlYt6VTqSYHuXGdy6TdFkNT3WJvGaOrJvm9Q8VM9leRnIXHHRovC1rNo3V
	0y6Ua0Tbl6gywXHUYmw/jgeY9WqhI0JnKvuYm5ItsMuQgOJBGx2A7uIn7566z4lXiG+PwK
	JIht0t8kcUOrWWdcTXsXkmnFCwfKa/+KBQ9sxO5S1RM7wAnFCzCYhEBkWbCqOimECKWLlg
	BivgPg7TbzZVI/XZFFNiSmdKIMKvq5eHTUt4AXe4Y0n38bwMMrcQ0VI8U9gdPzFnyvBhwZ
	B+phJc1ZiAl/IjXy9dey/O5fUYOLNTY1VKcKgQx+XMWI8j6j9ZsQ8R1x98RPuA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 31 Jan 2024 17:26:29 +0100
Subject: [PATCH v4 16/18] MIPS: mobileye: eyeq5: add reset properties to
 UARTs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-mbly-clk-v4-16-bcd00510d6a0@bootlin.com>
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
In-Reply-To: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
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

UART nodes have been added to the devicetree by the initial platform
support patch series. Add reset properties now that the reset node is
declared.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 06e941b0ce10..ece71cafb6ee 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -78,6 +78,7 @@ uart0: serial@800000 {
 			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
+			resets = <&reset 0 10>;
 		};
 
 		uart1: serial@900000 {
@@ -88,6 +89,7 @@ uart1: serial@900000 {
 			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
+			resets = <&reset 0 11>;
 		};
 
 		uart2: serial@a00000 {
@@ -98,6 +100,7 @@ uart2: serial@a00000 {
 			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
+			resets = <&reset 0 12>;
 		};
 
 		olb: system-controller@e00000 {

-- 
2.43.0


