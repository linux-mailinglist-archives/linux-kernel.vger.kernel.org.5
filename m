Return-Path: <linux-kernel+bounces-167759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53AA8BAEC1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462F51F243F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA38155344;
	Fri,  3 May 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="auFdrfyc"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A910153BCB;
	Fri,  3 May 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746080; cv=none; b=Tysru9FD+8nTetfX2HovI9QC4NZ12EEk6eOHg5hNsCpKrVFyLS+C48gwaesu9dE7KPL5a3kMwF77OpNrp9frVZQycPTxBtLpmDcwenvKBNYYwuO04h4f/5f6vdl+Tp+NDacjZ95VSxZjKneZZmQe1DVjPsaGIpUTNcv0vWHvHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746080; c=relaxed/simple;
	bh=gXnfQAgrZrJmKu4c7d9//TfZQIsdHFJrk0CW6RdsEbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UY1IfoqeplASERUy4q/9tPMfg/shF7lJywSx4hrNSvOfz6V+13OeR2OwC1lrSeB6Ggga2R1eT7vEMsdugceFY/XfW94/j7esrQHlJ2lHL+Y82gdDjqqRgnqJhuxiocXwIAfFUbWtQlRGWU6hl7jhKJcXjF9aD/DKz5N6DyI3x8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=auFdrfyc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4ACD2E0011;
	Fri,  3 May 2024 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714746070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSit5l5HNYYTyzvi3BDpZSbmAXfYnPnJDQ+PPWXph2M=;
	b=auFdrfycfJlDBfQJRT7H48CB+saPXuS6J8hrJ1OWU5Q8N6RVx3dQROly6uFI6Id6j/nCEu
	BEQuFyl2ftXapbylh9aAQe63F6kQJmcAOYS084cMNI3581UvJFu03DRSEHg+cmS60xWVe+
	q0YCMaROy0G9crzAhmb+hTZ0T8cTBk9pc30y06eKs/aq6/iRHFnObPeu/EZQng3JypPU7A
	Mi6/NAM5AFEQg3JVirSb+OtCICz4fwx/8XgOWMfODD1tmgxOZzsJg4NllT2QrqHcLE/wcK
	NN6lMp97LG+tfghLUK0b7gafQDh+Fq3XbGRMM88vKo8leVZM5neTUC/0T+CL/g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 03 May 2024 16:20:46 +0200
Subject: [PATCH v2 01/11] dt-bindings: clock: mobileye,eyeq5-clk: drop
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240503-mbly-olb-v2-1-95ce5a1e18fe@bootlin.com>
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
 .../bindings/clock/mobileye,eyeq5-clk.yaml         | 51 ----------------------
 1 file changed, 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
deleted file mode 100644
index 2d4f2cde1e58..000000000000
--- a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
+++ /dev/null
@@ -1,51 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mobileye,eyeq5-clk.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mobileye EyeQ5 clock controller
-
-description:
-  The EyeQ5 clock controller handles 10 read-only PLLs derived from the main
-  crystal clock. It also exposes one divider clock, a child of one of the PLLs.
-  Its registers live in a shared region called OLB.
-
-maintainers:
-  - Grégory Clement <gregory.clement@bootlin.com>
-  - Théo Lebrun <theo.lebrun@bootlin.com>
-  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
-
-properties:
-  compatible:
-    const: mobileye,eyeq5-clk
-
-  reg:
-    maxItems: 2
-
-  reg-names:
-    items:
-      - const: plls
-      - const: ospi
-
-  "#clock-cells":
-    const: 1
-
-  clocks:
-    maxItems: 1
-    description:
-      Input parent clock to all PLLs. Expected to be the main crystal.
-
-  clock-names:
-    items:
-      - const: ref
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - "#clock-cells"
-  - clocks
-  - clock-names
-
-additionalProperties: false

-- 
2.45.0


