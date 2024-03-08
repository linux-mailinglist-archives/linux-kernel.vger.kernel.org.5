Return-Path: <linux-kernel+bounces-97372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B968769A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58AD61C20BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECE5D471;
	Fri,  8 Mar 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HSbkESLk"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C415675B;
	Fri,  8 Mar 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918311; cv=none; b=A/MkfDEod6RTqtWon6age0xLLEKoHn/LJ4LllL6L/NQF3EUNo6u5GWnpIubchcRytE6+XBg9GDYL+94jA2PdA87EYGdeWtujOKdyY1wbzWmgk2ru+WSbZlqvU3gzThvs2FagW8zMstr6lUH45iTbe6eHX5Kz9KbiBPrPU71BjME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918311; c=relaxed/simple;
	bh=F/9Yanst1hBH0HDc3LX9DP2jVFZb4lsc+NgoZKuU+jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V8rpViz+b6KERCCgpLGNP9Vouxo/O59cx1xCKc7L0pCUG4gVVdOByhtaK9BIJwN4PjbtI+yWhnDBmWC1qUOVsIinbYrLAc0uIG9CLha5WSJ7xMzSX6c/4M1D9/cdHIBwMtStzZ/OqD2LA+LmCTHN7OC1MEceqdwfujGLe7MLyOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HSbkESLk; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A057C0002;
	Fri,  8 Mar 2024 17:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709918304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sXwCu/pnKjPhnbG0qZ+rGnft7Ztmr1z9mGamghTqGc=;
	b=HSbkESLkn/ZN8on+cmLXpGN539iCXlvUuwGXguCM2LbcKcO/Y5s2JZ67Iituk46SZG9Qw4
	QGuLotcRogiaYD5/Y233NLrU0EHT9aDZn/hfRv1aWtnIaWRKecjEMyHFXtO8VVKPiecJbU
	pU23Zx30nQzXgOb3TsFkvg7TxsjXxowjRZnCAWKHDLOyVN90HzkYpnYpISkpptx+YNB1dX
	3HibUlZk3vN6yP6CDJLcDilnmuqKLuOC5CUxL+5QsvB9Kl70hp5sRFTMSwhNNP8Uq0FpDm
	u3fhvMB1+0LvI2RL3SNa+Dcy/IaiIcZqONXlPoyz6BrcV2SjbCiyn1vwmGlVBg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Mar 2024 18:18:26 +0100
Subject: [PATCH 11/11] MIPS: mobileye: eyeq5: add octal flash node to eval
 board DTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-cdns-qspi-mbly-v1-11-a503856dd205@bootlin.com>
References: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
In-Reply-To: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
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


