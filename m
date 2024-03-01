Return-Path: <linux-kernel+bounces-88686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6C686E550
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60996B21F6A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015357441A;
	Fri,  1 Mar 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FuGRf2SF"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DAA71B24;
	Fri,  1 Mar 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310147; cv=none; b=Ed/WGchblUU5+G+WBT7l4NZJvm23MlyhTokbSLpYA58sgx51KHYnkOyKXIdg2+TSZXcBVD0U21Mk4PJ96JOnJkFCalA73c638MJcCIJU+CvVxPb9jQMlOr6mqFSMfbRsHcORTRe75oF4AUBBTP9z3E86JYLUM+/oiavaUdLMugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310147; c=relaxed/simple;
	bh=na5iUFUdCcxo/XeKMDsWD2m8gyrN1SLEJxFdOBZFpes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d32MtAWPjCyGxy8W3tpP2AQ7NNM3VYnj8Q+cKHajXAj94R4zea+gkqgJtyGm/SAfl1rMR829r7zSL+c/tL5G5XyOhnGuCIHJDBMSqFppBwsUWfoVdkmLkadWI289K9tiaYrH9mV+KXSGUkl4O4R8isVKGsKnsqTtxr1B0Ld/Bto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FuGRf2SF; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EBD5C0009;
	Fri,  1 Mar 2024 16:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709310143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnALdwStqz9eKISqFy6qQHCMwj31QlMpXRX8xAVY3EI=;
	b=FuGRf2SFNrXK0a9naPd1fC0PcewKjq1ARL1CO8+eHcX3JHjbRm6mcL3lyQ1ETCLhbbrC68
	UfP5WuJ/XIZvDKa04/0XkhSiFkdbwWhNaK/KNlB9T3QAgorMYOimocnoVCGU32FKlQTtcg
	2GgPXqVi+uVm/4KmW9c8W42vPOrMdpbJgbdATRDt/ta7Pu9LfTI6a433o8fzsCmGsEzNTm
	hCjV21LqExF2RJj4hidz6SpEeMFmLBR5kHuKpC3MkxTNCo5RFyEJcm2FMNDfElrcFl3pVv
	3sXpl/Mg59Krn8L177jL9KoX6LMqzlIoo2zcoMHKXnQ7TvHTT2H9/ztMRlTleA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 01 Mar 2024 17:22:19 +0100
Subject: [PATCH v9 6/9] MIPS: mobileye: eyeq5: add OLB syscon node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240301-mbly-clk-v9-6-cbf06eb88708@bootlin.com>
References: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
In-Reply-To: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
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
2.44.0


