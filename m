Return-Path: <linux-kernel+bounces-46796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36709844466
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76AF2904AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48C137C41;
	Wed, 31 Jan 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VoOYdo8s"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8212DD9E;
	Wed, 31 Jan 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718443; cv=none; b=rOeFLZZrG1WKdRMSxSXng2J4Fw2yB/aU8L/nKoXNWlkZBNDd1cM2PlDPR4DDAMCqZtmfZUmpk/6RQlHxbtUFyV4zz/hLapEwHXOIjknp3G7LbrlgK3NnJPQveg6S20Jivb7WYtkn/Hidem01J7sxZ/GMR9O7xpion6oJSQqmOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718443; c=relaxed/simple;
	bh=wxcROPp5cSW5FM/68yRsdIXWyWDLdpBlm8rT+69R9J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Umtc+V1zk79ImBwoaAnHQNL5I5c7XY+l+8Jq58oeWyOtEvi7Z4Ml2kJA6wBhIb/w/oB1u19++63nxT3tAqeMNB+rDmnqbw6mVPd9s2EY3iDzZceR9ATyF4AaMHe2qKkUkoLkT9XxwlKOViWLjgT4D1/zAzUXsqGXoh4HPVhCMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VoOYdo8s; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F5244000F;
	Wed, 31 Jan 2024 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706718439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHx5/x8N5TbNVyfGqq5Ko5uZdVZrGH+Vu+pyCI0oxsM=;
	b=VoOYdo8s9MpbV1arulpe+hLEddtEWXmSSG75t5h3sgzxy6vFdGD9foJAR2IaTHu94My8iU
	WEicLyul1lqK7MNbgVWDU2+pG83Kr+LOYYITIRQebiZrjl2mTx8UGZCbEfdK/xzhi6LeQj
	FAL09Jmvvl1jVWhY3iI7MZG/zKNig/YLT7vkwon0jRmu1atl5YSwMBP1lOF0AvCGUmc2yt
	lSY8kcVkXqQkHcQbbZl5snM4OSfMl544WgiZw5UdK19HupmdtKFkX74YwEyhpE3ruI0G/m
	VqPG5fhJnFDwQe3c2tdDcuQcIb0UsV/SI2TRUvCsoCzb5Gu9mqTBDJ9/xdG1wQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 31 Jan 2024 17:26:24 +0100
Subject: [PATCH v4 11/18] MIPS: mobileye: eyeq5: rename olb@e00000 to
 system-controller@e00000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-mbly-clk-v4-11-bcd00510d6a0@bootlin.com>
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
In-Reply-To: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
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

See §2.2.2. "Generic Names Recommendation" in the devicetree
specification.

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


