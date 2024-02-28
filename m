Return-Path: <linux-kernel+bounces-84905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2365486AD7C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9C71F29FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C8F1332BC;
	Wed, 28 Feb 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fnU/jrSR"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7615CD47;
	Wed, 28 Feb 2024 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119716; cv=none; b=kC3ZbyxVQrbTz6ChG5fDuAVZUZfWji59uKxLwedz7stAmencf++Wea5ogFdKXaJU6rhAHIvNZSqAWNXOKJ2LxOziPsgW2+JmEXxfkUpNS34oH6gdJAlonglpdjbPDLBpBaiH/wCFSJ+Se0fOTbvW6EVXhMUWO9/nOTUnuQYblr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119716; c=relaxed/simple;
	bh=HhFUuvndfjaSqasjWMz9GJl5r35qeCTPu7aLKxHaCKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlehGudgEK6+yOAsZ9ak3GO901RWaibY2g80TbLsKSKcTdxFS3iLG7fXg+97G1J0eVCRwGwwSBYHiqhM0kwGWKOp9bYjJgwNemXDAZ2SgISsg/lJbwtG2fhJ/Vfg2SAYG+AW3potW1XZ94fzri9uzP6q4UHtyAZLP+shBmcaeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fnU/jrSR; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D08A1BF219;
	Wed, 28 Feb 2024 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uq0DPUf03GzjraZNzemqCpT91bjhZDBezLXQfKzg4vE=;
	b=fnU/jrSRHTXJIeUiDceVTbJn+etiOTYJRSX70xeikOILLIAPIOvbYImkwGsXD2wqqkUzLa
	ic2y0CYbLU1WJdSrXIuaoaxVt65L/4J8g8+TUFccGK55mUDIdvQRNo+M4dU4/5iIekvuqH
	W2v1LGfSfelivCnKvDuweW4aUBYw/tNfDjBRDQPXkRG7uoDS9iTBVwsKp1HC4S7xgYHlRq
	RiU7qE2WsQcUTN810F/80XjC5W3Z3T46rdL/UJxIX1+MEJr7t8kVgnE2QRzuuLWE06fgr5
	ZCtYQmKkMgBPmF/J7NVlxo7XsoHZqLq5Ym59ccYxQ3qCQWyzMtPI7xxVOAMSjw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:26 +0100
Subject: [PATCH v2 28/30] MIPS: mobileye: eyeq5: add two GPIO bank nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-28-3ba757474006@bootlin.com>
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

This platform uses the same GPIO controller as Nomadik. It however has
its own pinconf & pinmux controller. EyeQ5 is the first platform to use
gpio-nomadik independently from pinctrl-nomadik.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 8d4f65ec912d..0f18ac73620b 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -158,6 +158,32 @@ timer {
 				clocks = <&core0_clk>;
 			};
 		};
+
+		gpio0: gpio@1400000 {
+			compatible = "mobileye,eyeq5-gpio";
+			reg = <0x0 0x1400000 0x0 0x1000>;
+			gpio-bank = <0>;
+			ngpios = <29>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 14 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio@1500000 {
+			compatible = "mobileye,eyeq5-gpio";
+			reg = <0x0 0x1500000 0x0 0x1000>;
+			gpio-bank = <1>;
+			ngpios = <23>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 14 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 };
 

-- 
2.44.0


