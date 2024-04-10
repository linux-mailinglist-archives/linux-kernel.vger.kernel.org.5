Return-Path: <linux-kernel+bounces-139063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E4989FE04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE721C217CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C12C181CF4;
	Wed, 10 Apr 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F0we+2Nu"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87417BB2F;
	Wed, 10 Apr 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769166; cv=none; b=B72xwCGXDvciG+AEC2383yXIgsLc24NoNIbO4gW2M642B/s3Cbchlf665FCNxWsgaDbdVPAGakVi+sFntNopebCav13YHyZ2IUv6Fo3DnIyVImllQh8DCqqpOnTSIRVxFzObgyGWyXU+625uc1t9s+FAfbuOeekinuNTQw44f34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769166; c=relaxed/simple;
	bh=iYXkDLoD8tDRrp2wziiqK4v0tn/tz7yfQG4GHparyXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2OXSHfUNFJO4BPfsswKVx25PHtFhZTMav++ECouMbPoDUwpwaO1cembLf313akq7QbSrsoP077D+HBlSuINjGwkGLgZHvzM/2LMt2BEjBp2zxnCY+iA1BfbEO7TZZIzXeDXFTMwQKAvoTb12VESWg1WtxRFUHCZLIGOKmJ/7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F0we+2Nu; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2AD31C0002;
	Wed, 10 Apr 2024 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712769160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWM4le1lg+zZj5aG6IIDSjSmOtDGbtS+zl6wlgbWlYY=;
	b=F0we+2Nuahdvvbrm+10soAPPj5HBUwnbQ8lkPeCBfl9Isv6zFPaN8Ts4CHzfrWc65IU96g
	3t9gMyZJxwF8+sbXDbFR5YAtMOoYW8FK7r8PjOtfte+FmxSodzVXDxGkq/TjgWqby9muT8
	ptyM/zN5+D9bz/MMkp6nYYfX2jrjhpTOGC7bNYm7fWE2uAMHw3Ykx/8/XHxEpOx/dkR9pS
	P2aUkgLnZ9vAHVLxLyG64T2leax+bFiAFoKC6CZOEI49590kttqCcy2+KfbtnSmSgUkVaQ
	DFIc/Y51QsYkKKK5sibsZvGknXqKxVW5XW9fS9y4RCLyqId+3M+8W3o7CnXeYQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 19:12:39 +0200
Subject: [PATCH 10/11] MIPS: mobileye: eyeq5: add OLB reset controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-mbly-olb-v1-10-335e496d7be3@bootlin.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
In-Reply-To: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add devicetree node for the reset controller on Mobileye EyeQ5.
It appears as a subnode to the OLB syscon as its registers are located
in this shared register region.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 1a65b43e13b1..76935f237ab5 100644
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
@@ -107,6 +110,13 @@ olb: system-controller@e00000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			reset: reset-controller@e00000 {
+				compatible = "mobileye,eyeq5-reset";
+				reg = <0x000 0x0c>, <0x200 0x34>, <0x120 0x04>;
+				reg-names = "d0", "d1", "d2";
+				#reset-cells = <2>;
+			};
+
 			clocks: clock-controller@e0002c {
 				compatible = "mobileye,eyeq5-clk";
 				reg = <0x02c 0x50>, <0x11c 0x04>;

-- 
2.44.0


