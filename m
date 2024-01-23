Return-Path: <linux-kernel+bounces-35914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E8E8398BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCEB9B24DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6974212F592;
	Tue, 23 Jan 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mwtbmPbn"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359612AAF4;
	Tue, 23 Jan 2024 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035640; cv=none; b=aHZbCbogJoAYbZyFzfii8qHIYKZ156Nmy8os5haXa0ZV0FFYhs7Vsi2A2FXrNct0V7RH9bo+DWuOaXGN5nAuWrK01oSdP7vEt6zLy/ePTI5kXzIz4J9B4oxTNMidoHrwcYZxh4cQw2fUk+fqIBnTZK2PBEd56g7ZdcVyNKPl2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035640; c=relaxed/simple;
	bh=yjp12oSxfxja7jh6fC7F+aeYuNS75B25MmED7rLtaBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o8n1dbuXyEYdhq1eVqWvTOjV3+xw4X3pAVV5Du8qi6HfZfmblwpXCFlK10V8EdvttMIq59aPGjPTSBpy0bMPIN9FK3oh3kmI3Dq+qmIWFW2QHiPyzJozvqvkjkzCENv6GeoRioKTw3MbtEva2XRu4YNu0JlUgtaXDZ4A5EkM4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mwtbmPbn; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E52E0C000D;
	Tue, 23 Jan 2024 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCny+mSIAQq2p/t/iXy+uHmjfw0TgeBQHqm3tqR9vX8=;
	b=mwtbmPbnHEV8ihY4Nsm93+07vaoHgZHgbpN6eBU/T6yLf7ws9jHcuV5bPT5EZrJx9zyewO
	kjxpMtPpMUrcerqr+apQChN5GxKHgXdYuxeaUB0XTwBVyaIaACVsQqTBQwWVjIJnCGA41L
	WqfUI01cVLoiDIQidNCoPHGP5jj5uRgbqsWSJiCvY06l0XLBXXgFsJ/t/7OurUZuMojcxk
	Vc7Lwq4nbZdTfipYQE/b0R474+YZZdf8oM7WyjcXgnxpYJJ2yK88Uz+P7maZZ205bplll4
	rV0YdAhnZx4F7LfW6gFqLOqVzbzTGAr6XjR3PMQVXC0cIKsaRn9ev6hpKch5oA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:47:02 +0100
Subject: [PATCH v3 17/17] MIPS: mobileye: eyeq5: add pinctrl properties to
 UART nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-17-392b010b8281@bootlin.com>
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

UART nodes are present in the platform devicetree. Add pinctrl to them
now that the pin controller is supported.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 05987c58ed73..bf06d7a801a2 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -79,6 +79,8 @@ uart0: serial@800000 {
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
 			resets = <&reset 0 10>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
 		};
 
 		uart1: serial@900000 {
@@ -90,6 +92,8 @@ uart1: serial@900000 {
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
 			resets = <&reset 0 11>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_pins>;
 		};
 
 		uart2: serial@a00000 {
@@ -101,6 +105,8 @@ uart2: serial@a00000 {
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
 			resets = <&reset 0 12>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pins>;
 		};
 
 		olb: system-controller@e00000 {

-- 
2.43.0


