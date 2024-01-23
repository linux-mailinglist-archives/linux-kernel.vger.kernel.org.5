Return-Path: <linux-kernel+bounces-35912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD68398BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BEF1C27306
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8012CDB8;
	Tue, 23 Jan 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cEKsmENh"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255A12A15C;
	Tue, 23 Jan 2024 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035638; cv=none; b=Y5Hb4C9dI2x4aW0M45YlV25FZG+8FMehPNLLIhcQoloDsXQ7X1f4HflRv+owIFISCxKmzrrUU/6z0S8UZ3BdNHSpX0p7JekXJkj3a/qtSR9L57xQImag2ymojCO4nh4xs5zUfuYjy92PJ4N0co792Yp+cNQdWgoI3fDQbXpCS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035638; c=relaxed/simple;
	bh=CRl71IIRGChYj09LDs8MG3mlUeXntEyS2lM1Effj4pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8Z3Vq1R2EuRYlN3wIeMRIXquiCAuJ2jIhJrlYtRZbbk4naG4LPkeo1Vt1j+ipGQMta9sBQ9Wv7n/O9oxvUlgBtBZOa7Xu8dY7NF63sCZIfLUu/Sk8vkV9E4HG+yyUjq/dc5velydey1XE5hekm/OLgmGb6U+HdUycHP4tEJbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cEKsmENh; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50091C000A;
	Tue, 23 Jan 2024 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdHSB87u5sD7QQGA0+EynSxKbm6bwp41S0X3AQVUPG8=;
	b=cEKsmENh7Gdycrf23pi7Tj0OuLskgCGYMllo546rTc/hjkELsx+yn2JF2EXtaAY1blnC9n
	Ezhlue8Z1PlRXBV7EqdI9uujXQ6o53eeBf8y28tkmFF9OORtg6udAb4a/sg0QO4uJVHFuy
	Ti/aHl6NFhduLRNR2nfB1+Qd+nD/Yp7bw2IHknufwWOT2d1a7ht3cTkhmp9YwbYZ1FJPXb
	69uV0J6AuDp9yLxRpv9bEoXYbec9kBqacvelQSmWGNlYlSq29GTsMzyiCMFP6uM5PC5hZk
	GD5Laxwaue14ahU29uKCVqMDpFCB4PH2o7MOYLoyyU3RDi9lJiIvpqz408S/mg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:47:00 +0100
Subject: [PATCH v3 15/17] MIPS: mobileye: eyeq5: add reset properties to
 uarts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-15-392b010b8281@bootlin.com>
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
In-Reply-To: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
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
index a246df6e3c85..11cdbaed2b33 100644
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


