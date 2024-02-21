Return-Path: <linux-kernel+bounces-75271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A3A85E599
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488382856EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A432685C42;
	Wed, 21 Feb 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lzm29+GA"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372458526A;
	Wed, 21 Feb 2024 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539739; cv=none; b=S+GB4mOwzrzOV5WE5UWksmYzhDq+as/TbreHZsEV7N5BlbDfllvGzPOMPiT5Fh4GRhy3FLJsP7lsYfuJJ3vsprbshtu7N4zz33PZbSpeqSfoQ+XIPyMnNILDF7TKQzY0nto3nduiIajOCU21c4ttvLDSI84AmevSHszIX+CkZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539739; c=relaxed/simple;
	bh=ew4TZ4OQx1NlPPCCWerriv3q2tGFtvkfQdf4kMBIylE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QOXd1xbUEBb75RAAymFNrB3I2evYuulM+KDYreCzm4JQxzwiy6jznAHxOA/hP0a9oa20rAfSNJHf2m+FvlvioXwOO/8NcwHC7fbp+fIa1MPnDdT6gijq2PCiWJZjVjo+mP0WuMJ9RCbAnbQJmtBYG5DAStZ/52R5pGfKy3f5UE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lzm29+GA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2D0B1C000E;
	Wed, 21 Feb 2024 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708539735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owId5NPip0Jfq+8MxLBRuEiza4Oqh5kwoiW58z98vFA=;
	b=Lzm29+GAyvheb/O+LkdFThGzvOq4G36VmsGnVgsohvUpgyxVkE+b18kXcH5u18DXEJZL25
	jb9QnPc6srAFS2dpXTmRO8zJhvswWf+QOvshAayVyyCvtBYHGOtl5M9sW8sijHpsbV6vOl
	OAnuD8XM1AVToq/2hpjyrFcykv18EjSQQdqRQtxrF+1KaxKSd/a1vkBhyVi3MoxCQIxZVb
	zggJowg7wH0xhnGxtcUQRu0P7QR00Yx0DEj4GnJpTdZBw5c9WtVB7znqBIbN33VRY/4GnF
	DTwLKA+99EQlhLVNqSGYKMrBIMIz3hDHB+27LqlV2FARL2vIu4nSFNsLXyu35g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 21 Feb 2024 19:22:12 +0100
Subject: [PATCH v7 04/14] dt-bindings: reset: mobileye,eyeq5-reset: add
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240221-mbly-clk-v7-4-31d4ce3630c3@bootlin.com>
References: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
In-Reply-To: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add DT-Schema bindings for the EyeQ5 reset controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/reset/mobileye,eyeq5-reset.yaml       | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
new file mode 100644
index 000000000000..062b4518347b
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/mobileye,eyeq5-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye EyeQ5 reset controller
+
+description:
+  The EyeQ5 reset driver handles three reset domains. Its registers live in a
+  shared region called OLB.
+
+maintainers:
+  - Grégory Clement <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+
+properties:
+  compatible:
+    const: mobileye,eyeq5-reset
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: d0
+      - const: d1
+      - const: d2
+
+  "#reset-cells":
+    const: 2
+    description:
+      The first cell is the domain (0 to 2 inclusive) and the second one is the
+      reset index inside that domain.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#reset-cells"
+
+additionalProperties: false

-- 
2.43.2


