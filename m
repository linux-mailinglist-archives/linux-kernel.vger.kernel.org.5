Return-Path: <linux-kernel+bounces-167761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27868BAEE4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592B41F2264F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3814156986;
	Fri,  3 May 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hi5Rgki0"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4D154BF3;
	Fri,  3 May 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746082; cv=none; b=p8nIPv2rpo9GYj1i/s+S0PDhvWteq6d7aX1p9zVL2MI0/PMnjiJ11z2JNPLBsEj2PmjOsosWTdLZfszDBVHSmUXhgPDr8lfaOWYO6LF+Se4xe2yjME95Zwm0q6mE9JFN8ThXFGcpUnReQrJc1RVZQabyrNT0zOsGmcdTdJRAyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746082; c=relaxed/simple;
	bh=/8WKSj8z+PwGRoB7v9CKzRHvu5T8bI/rz8wOFPwwC9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F8qWryE8rt6PizehNBnslBowcfgR/cSLsV+pTBM9RQU/Cpk7p9jGdqaZUJQQbzvrJgLWmX6/abpERWo14sfEGZlhgphOzv8NTWNwY/JQLdfXgymW9jreeKyexyGwsEOAsokDQ4Sy31jFkSNxx3tCKe7O1epKoWH0TTBJREeNTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hi5Rgki0; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2752AE0008;
	Fri,  3 May 2024 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714746071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxYpvnPVBmTt3NbX4kfm6Echib8luItPMHNWvwB5PdM=;
	b=hi5Rgki0kjWKWubEKXyaPKioINsk1mPjF6oFXi7CO28GP82RL2pVkYlspOxnGRKD8kjQAS
	TmpifjNV4e5zrR0EROYtkg+NnmtWfpwRUhw254DkN1QERqp+6h5FFzM/GAyvBrULvQIk16
	aYj9dr7LuAEN8WZ9UHHerUldNCAtU7CFuhweO1Y//OcPHUiYDA6Dl2g9yB45ZfeuJRFf9h
	QHW6/WK6lHueVY/0YDSZJe/WDOSV6aulMHFdC1Ek//AUDXYHiulXjm/NOcLSR3itSB7ckx
	MWcSq4mpPgJCe5Qjyn8qW6XLfk4ggwGPh3QM6htr/oMi9nq/QdfCrKRtFGePCw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 03 May 2024 16:20:47 +0200
Subject: [PATCH v2 02/11] dt-bindings: clock: mobileye,eyeq5-reset: drop
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240503-mbly-olb-v2-2-95ce5a1e18fe@bootlin.com>
References: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
In-Reply-To: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Switch from sub-nodes in system-controller for each functionality to a
single node representing the entire OLB instance. dt-bindings is
unnecessary and soc/mobileye/mobileye,eyeq5-olb.yaml will inherit all
properties.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/reset/mobileye,eyeq5-reset.yaml       | 43 ----------------------
 1 file changed, 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
deleted file mode 100644
index 062b4518347b..000000000000
--- a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
+++ /dev/null
@@ -1,43 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/reset/mobileye,eyeq5-reset.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mobileye EyeQ5 reset controller
-
-description:
-  The EyeQ5 reset driver handles three reset domains. Its registers live in a
-  shared region called OLB.
-
-maintainers:
-  - Grégory Clement <gregory.clement@bootlin.com>
-  - Théo Lebrun <theo.lebrun@bootlin.com>
-  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
-
-properties:
-  compatible:
-    const: mobileye,eyeq5-reset
-
-  reg:
-    maxItems: 3
-
-  reg-names:
-    items:
-      - const: d0
-      - const: d1
-      - const: d2
-
-  "#reset-cells":
-    const: 2
-    description:
-      The first cell is the domain (0 to 2 inclusive) and the second one is the
-      reset index inside that domain.
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - "#reset-cells"
-
-additionalProperties: false

-- 
2.45.0


