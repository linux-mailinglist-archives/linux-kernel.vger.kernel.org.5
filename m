Return-Path: <linux-kernel+bounces-138258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8526989EEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BA61C20E72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5E21598F8;
	Wed, 10 Apr 2024 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CqnCNTKc"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33660156F23;
	Wed, 10 Apr 2024 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741359; cv=none; b=T7UVeHdXdAXm5fNZ8XqNetbNk82sCIIYSMNhPqC41mwOYUoXB6adXYvrs+1BRXjap5nwcH3jPjA3k/RooSosXW3//WRg4zpbp6x7qdbOIiTZpdVoNMnx3cxc2Cf5kqc0E2GG7ztKgR3kL/PrPJbeCQe8e9B1NJXfaWujKu14HoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741359; c=relaxed/simple;
	bh=F/9Yanst1hBH0HDc3LX9DP2jVFZb4lsc+NgoZKuU+jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GArxIlkx+LiQMoe5/tO8+GptALHNpd6iejWDmcYCSCsZ4dN9m71hKNEPie5Pbx89p5DzZloJsUZ4kR7CxezocgQKoFYOv+iNO2n+/AzdoqBgtmRF2oBxHsKdBEbIGYFDx0AtEsGLoPhrfPBLZl86YyW1vQGNZtJ+mxaR7AM4DUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CqnCNTKc; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01BE9C000E;
	Wed, 10 Apr 2024 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712741355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sXwCu/pnKjPhnbG0qZ+rGnft7Ztmr1z9mGamghTqGc=;
	b=CqnCNTKchCH3wuSZAEJsID231NfI+9qO5g+mJ82GrR4nktt2r2++b1n7g+XTbR+I9Rmcjr
	FjwL6hPJr2qTSpKf5j7iwkZL7J90xE/oXxiqg8vzaoMtJe0fu+5+0KbanUp4GbPzfZYfch
	lhOdccPax6vRL7KNxZYjsaqWcDDCirtzLs1r990MCv7/TJ3LC4g2JpO7RZYZu7SmitH8XS
	KfJOi0zYXGGhnRc3cIQjHDIli8Xh/CHqaOKoPuzZ9vrkG9rtNyFROvEW6Q/Bj6GJyaGITR
	pTdUkeer6SdJmzqvq5bsjepPO8qjyvBp0ybZJSEFkFQl2VtjQWWDfIxd60OViA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 11:29:12 +0200
Subject: [PATCH v3 9/9] MIPS: mobileye: eyeq5: add octal flash node to eval
 board DTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-cdns-qspi-mbly-v3-9-7b7053449cf7@bootlin.com>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
In-Reply-To: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add SPI-NOR octal flash node to evaluation board devicetree.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
index 6898b2d8267d..0e5fee7b680c 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
+++ b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
@@ -21,3 +21,18 @@ memory@0 {
 		      <0x8 0x02000000 0x0 0x7E000000>;
 	};
 };
+
+&ospi {
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>; /* chip select */
+
+		spi-max-frequency = <40000000>;
+		spi-rx-bus-width = <8>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <400>;
+		cdns,tsd2d-ns = <400>;
+		cdns,tchsh-ns = <125>;
+		cdns,tslch-ns = <50>;
+	};
+};

-- 
2.44.0


