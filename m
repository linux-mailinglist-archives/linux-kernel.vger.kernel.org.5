Return-Path: <linux-kernel+bounces-65531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0283D854E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955A11F21CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A24664D5;
	Wed, 14 Feb 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nVdaODXS"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C506351A;
	Wed, 14 Feb 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927904; cv=none; b=UviKzH1233P+jdRlXX0G9peVYtlKgyK4uAoU9blpQIRnaqGsBSE4Smz70eAAmuT16mjppKJ3RiI+S+ue9MaMyg/86NFZYfz1qHKnFdRQUY3kpvQ1wlgyJIREfjvJp7RKG3PFjhLy/qa8tn553sMzd+pxuebJOTJlxg2+fnk+neg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927904; c=relaxed/simple;
	bh=lg+wMQyFSKH9DCQtdcbr5hbKPD1n5PuMlcYEsz8BV4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akztQ0gcxd43dL/hzyyhfoQXxLGL3bdWyHZ+w2HDw5GegtStUEOoZR8rhmbRbU8VYxVhm8z0LQ2OOunjCALldy0RkwICLfUmaiku0OOW9PoDQYsABrJJpL4O2QNIWv29vPYONkEBZFN+mya8UD0dVYlt/GIt4uZb54QxDI7FiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nVdaODXS; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B81AE60004;
	Wed, 14 Feb 2024 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOVR24b4z/rmoyZs5HktHwLGuO4fKwcoMaMenE1sdQA=;
	b=nVdaODXSFsbhPvSP73agbH5Ujd/TiZp2qrnPqIJvEjTl+x/qZZKnyFK2lLiPMrxV+Rj/W7
	zNGSJav0I0MNCy54VK2xklVikn00tkidze89TIxndwH5NBEc9zDaoIvsgaCXsia3IlLP6E
	yXcWwgUOrRCESufV6AQXCauJZmKan0W4MMArF6oCNSxHKrdepPp01QITVSILatPopfmfDu
	FlAdApGgCehl8VEYjj5kRUT8j5Ki4X9eNAwhSPAxNIglGQMpiPcmUAYTx+o8Z0HE8w9w8d
	q1dHjeJYjh688YqR2p/AvkzjQSllT7rTMjjwOzX9gqTf53SHjGSeeiKs9WzR9w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:14 +0100
Subject: [PATCH 21/23] MIPS: mobileye: eyeq5: add two GPIO bank nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-21-f88c0ccf372b@bootlin.com>
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
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
X-Mailer: b4 0.12.4
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
2.43.1


