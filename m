Return-Path: <linux-kernel+bounces-35901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02AE839872
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D971C2808E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF66F129A91;
	Tue, 23 Jan 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PErsHF0l"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8542823BB;
	Tue, 23 Jan 2024 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035634; cv=none; b=gmgsZHAScFMApfKkD5hB2IQJ3RcrM13tc4lREtXxRv//a2hAYJKO4dyQmBGh7y8kmfqUYr2UZpPq3mjuJtxPQ6N+4M9jluGlyjh93wdym6RRvWnvYNyZNkONM1W3qDhBoU1YSyqHgrMLMV/8NmI1F6MfjY1+yfSmPRITYH5SKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035634; c=relaxed/simple;
	bh=N43qmnGdH3FjGPsQyVkKZkyqKnkD4RpFi5SkZgTGhjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nh3pnQVzUJuDTQmocKVLH6YIrHG/FM67R81m+Rf9XkCgwT1Qg2SupI+mUnShMtREonEiUHD9Q/LjAWRDSEXS40TmNd5yj6/Z3BNDTNd3mtU8nPn2T7tLvjgafGjmyHECbcbGr02vi73qu8Agvyu5oDoDaw24ExuYDsXuIdcOUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PErsHF0l; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CBCDC0008;
	Tue, 23 Jan 2024 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6AavcBVCvaawd7cYcf6aSbn1cIf/DssL30p1KzHtXk=;
	b=PErsHF0l8WZFgc0DRJjp9lTsjBxy98WpCcJ/HGoCJLK5hbF0FE4gX/NUWxJeCYNBS+3/Cf
	vRhiT6eQ6RKvmF6rYZClNfDspY74WT7IA4yrECCj/TOwlce2/Y/dfiyYegNVxEI9sC7Q7p
	nvScDQGLWsB8IP8QYZh/VTnBlenS0OptpIjuAbey1Gt9b5QBuTIe9XnTAoc/+S2mgmB4Fd
	9DeK5huYRH3DZJunlIBZWdmdF0cTpnAfBLKncfdOKSDqHfGrVdqj5RnB0FxIZDHvswVqPJ
	BpTEJ1IKRc+y2tU5tXVfPTGDHvyRVqcEnBfBXgbrkO6UvkcOCxB7Qkg7UjjNzA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:48 +0100
Subject: [PATCH v3 03/17] dt-bindings: pinctrl: allow pin controller device
 without unit address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-3-392b010b8281@bootlin.com>
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

Allow a pin controller device to have no address, therefore no unit
address.

The previous $nodename was enforcing a unit address, but
scripts/dtc/checks.c enforced that names with unit addresses have reg
or ranges:

   Warning (unit_address_vs_reg): .../pinctrl@0: node has a unit
   name, but no reg or ranges property

Fix pinctrl.yaml to adopt a (pinctrl|pinmux)(-[a-z]+)? node name when
neither reg nor ranges are required. Use [a-z]+ to avoid conflicts with
pinctrl-consumer.yaml.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl.yaml | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl.yaml
index d471563119a9..1f1239c9b94d 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl.yaml
@@ -26,9 +26,6 @@ description: |
   controller device.
 
 properties:
-  $nodename:
-    pattern: "^(pinctrl|pinmux)(@[0-9a-f]+)?$"
-
   "#pinctrl-cells":
     description: >
       Number of pin control cells in addition to the index within the pin
@@ -42,4 +39,19 @@ properties:
       This property can be set either globally for the pin controller or in
       child nodes for individual pin group control.
 
+if:
+  anyOf:
+    - required:
+       - reg
+    - required:
+       - ranges
+then:
+  properties:
+    $nodename:
+      pattern: "^(pinctrl|pinmux)(@[0-9a-f]+)?$"
+else:
+  properties:
+    $nodename:
+      pattern: "^(pinctrl|pinmux)(-[a-z]+)?$"
+
 additionalProperties: true

-- 
2.43.0


