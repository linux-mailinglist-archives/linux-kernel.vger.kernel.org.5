Return-Path: <linux-kernel+bounces-46789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364484443C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8676C1C266A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6712C54F;
	Wed, 31 Jan 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IOPpK276"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD312AACA;
	Wed, 31 Jan 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718438; cv=none; b=jK5kchbl/IFk9svsSetfV09ScYycUqo27FjUtiqXHv+GcWSEQOOVqyGaelukt9ICo5uonFMYDwdebrBVD3LkleW/KT0v+VYIkyJ5TQn8ePiAQtRk6K4xWRMwm81O8QKUyceVMgBT2lJDKIIrOBR4lNbDVuW7oA1CTppEbVmx0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718438; c=relaxed/simple;
	bh=Zk51Y46Yh6wBACGBamMWzs9UNn9LXA1oGZm2O1J384w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMxHsfi9bLU6fzdoIg61nxkWkoiygBZDikIZmjsh0gCzEzW1g8WtjRV4p54+mODzhrvaXi/0ica8E1SseDF0jucmDrVG08pPo6isBylWd4wpvSPgDgbMkV0voSCsvHVC9SZyDIL5L4Pb0dvq8qvfj5b4OC7jOvDzD+DjakTnCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IOPpK276; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9995940009;
	Wed, 31 Jan 2024 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706718433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eiFG62+hOSXiOhbfv9iGOn+0mEfhbeiuUK+9YHU1ZU=;
	b=IOPpK276Vnr4e/P2oPnaLT2bMmWFOLMmhPVczm6uFvBlJQxaYvkkRxRO+f0QvGpGl154Yu
	9pwyv3nRIqjSfIslVue5xKt4q6KiQXX0FnddvvwB5dD4hQvLiZdu1/NnK5wyZyaAOF77az
	P3k44VwKXKHK0jAJagi+APrR6VYZRAeHRX56MCi3zH2aeL1NBHbdwoYB57NWxY7JRaHzkq
	O0qHP/Zel30neBIYowQoxnpUyIxbuYYNhMzCI4tKks/8svjt6zC0cYQVB1L1dHe2S8Rqqv
	x5/GRqFmkAg4TBGXFR8StH2tpmwY9wQIUrB1YwwaKLVd+56e7eSvINAoYXNFCw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 31 Jan 2024 17:26:16 +0100
Subject: [PATCH v4 03/18] dt-bindings: pinctrl: allow pin controller device
 without unit address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-mbly-clk-v4-3-bcd00510d6a0@bootlin.com>
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
index d471563119a9..3d977b54e260 100644
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
+        - reg
+    - required:
+        - ranges
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


