Return-Path: <linux-kernel+bounces-4152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A454817884
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776CB284D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA8A5A85A;
	Mon, 18 Dec 2023 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PowopAzL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F425D735;
	Mon, 18 Dec 2023 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A21920009;
	Mon, 18 Dec 2023 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702920011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFEhtm8TN595z9mluAbF5vfxS0ToImp1eb8mLdoD7tw=;
	b=PowopAzLR0FRPktyG1gO4z2q21NU+ZKhkwVyaYJhguUo5Wv7RGKzbkDlXtxVkKB0W/mw5n
	QXJ+4/Bo2jKBeaL/Lkubclju/lOG2/2UNwIVd/o+6cyj2E7ZVdJq6+/y4KalhQNKsYDsEb
	dL590XJ8VpGbI6y4FZoVO3u8TB03CYZzw/2sqprNSXSfwRUURTX38IJz1xiRIFLbbE3uvR
	vayHWGZ2tlqHDBtJ4V4Qzzne+y95MYyJAFOz4isuoWOtu3K1jx5Lpp6CI3l0ROtWAIei02
	P22Ykd92Zg+dmK2ViYna13ya4+KHoA/ThXucsAZfkFkCYQcirYYYQn5gi6PbQA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 18 Dec 2023 18:19:49 +0100
Subject: [PATCH 4/4] MIPS: mobileye: eyeq5: add pinctrl properties to uarts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231218-mbly-pinctrl-v1-4-2f7d366c2051@bootlin.com>
References: <20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com>
In-Reply-To: <20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
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
index def9e9645dac..fb7397a3366c 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -52,6 +52,8 @@ uart0: serial@800000 {
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
 			resets = <&reset 0 EQ5R_D0_UART0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
 		};
 
 		uart1: serial@900000 {
@@ -63,6 +65,8 @@ uart1: serial@900000 {
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
 			resets = <&reset 0 EQ5R_D0_UART1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_pins>;
 		};
 
 		uart2: serial@a00000 {
@@ -74,6 +78,8 @@ uart2: serial@a00000 {
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
 			resets = <&reset 0 EQ5R_D0_UART2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pins>;
 		};
 
 		olb: olb@e00000 {

-- 
2.43.0


