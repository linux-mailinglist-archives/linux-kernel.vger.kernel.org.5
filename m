Return-Path: <linux-kernel+bounces-35906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0438398A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29861B27730
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE312BF2A;
	Tue, 23 Jan 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T8DecN12"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7C129A61;
	Tue, 23 Jan 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035636; cv=none; b=XCFhYjpPLhusoko+4J7WJpk6Htlp3zTNfSsIEmaWAFZQ0BjUpUxPIcCXSyJnVA2ndkYy/XhoDja7/MySBAYD3T68zIe43NU9iHl0+YhHFUbdVnRv2pwELi1vU8To3nMAh7m/nCKq/9s8rqQ+u9NgsJ9b055XFTgewzVn0Ch2HOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035636; c=relaxed/simple;
	bh=ourrz1ieqvpNYcthhHHVetAQ6WXHRFLcDA7Y7qV9bnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JeJ6Icgk+/BMlOJPcJrRo0Hhy8JEoPolTQrEm1o+dkj31hDUncPD67g4ZkmkTkbILe/wfW5z446WsM8v1QmLJ6rMgJ4SmAff3zSz27GdB2beE186a4/1gJPC2Fk0N0xa34xFA0c4LvvSd9Z2HDyLv+hvmdMNWDgS+j9sXzFaKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T8DecN12; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF3E3C0012;
	Tue, 23 Jan 2024 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+ATZ34iEoyWc1+JbHiNiRhf/HnzqfKoQxwJINgzSnA=;
	b=T8DecN12aj9sX+3QFqPv1g2TiS7sETrtzjHE51aHuAbCrrQiZIHB8RF9pOEvZiqEwb2dEb
	VMFAjk+R2T8fyJpaEoeIqdjr6rR61K4+Rf/m0nosd8JuswfzxwW9p9d4UenFrV17Xzr1WF
	JxZ2a/pcGIU/fKXJ0CBXH+0Fmfl9f4OO1mQQ1eDlxO5DDiqBo4Rr+7msFvwkc291v6cRhl
	lxXD0ju4jjTS6xYuJXaclazkaJKp8g6C4jdJ93sgIL5dhDZyl6NcbHS5yYlwUq/ud2rQ+T
	e5RKtGDXsdkXwf6k5YEf21T7wP3Y6+FBV1x+jePUyFEITNP6boNc0GcaM4T7cw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:56 +0100
Subject: [PATCH v3 11/17] MIPS: mobileye: eyeq5: rename olb@e00000 to
 system-controller@e00000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-11-392b010b8281@bootlin.com>
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

Node names should be generic. OLB, meaning "Other Logic Block", is a
name specific to this platform. Change the node name to the generic and
often-used "system-controller".

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index fd34c49af510..81497febcdee 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -100,7 +100,7 @@ uart2: serial@a00000 {
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		olb: olb@e00000 {
+		olb: system-controller@e00000 {
 			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
 			reg = <0 0xe00000 0x0 0x400>;
 			reg-io-width = <4>;

-- 
2.43.0


