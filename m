Return-Path: <linux-kernel+bounces-46791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4187B844446
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF17F28A6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7D612CDB7;
	Wed, 31 Jan 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hO4O5qsr"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7312BE8C;
	Wed, 31 Jan 2024 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718439; cv=none; b=X6dIES5SM1Mf3TKHxL5wh3yz3ifrAEjDy4LMDcJTzU/8bby5VDv+expsRBMqcddRZMbs0tbjW2lr2Nq3ON7aEYqI9t+Kre6AjEBvawlBtIIW2CKdZtWPgvlpISoPbKFEj5hXLqDBfo48/JU13ZmYrnR6RWiq9L93ddnq4RWT460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718439; c=relaxed/simple;
	bh=cD9jvBK+96gZJ3HA4eYjVSI4yedYmYK6cGpEhJXfwUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urGVGWOcJjrr4wzFBhvSO92VBZ6YQs/DmfKZsfK+yd1xo8+YFUMo2Z81zevgeoNa5HPnj92DOWQyVkApbtD6Y67kvrMqGNL6VTEWG0bolj13TgrwzVFJK19XTCvfDLKCeT4R0JHyHSNZKcZxw0O5K2ZwTSooUOemON0olBJmBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hO4O5qsr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B5DE4000D;
	Wed, 31 Jan 2024 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706718434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjr4Vnej4PwH+rguhrbjhD7u4xdrgrLHVVHhEAIkmuI=;
	b=hO4O5qsrFi/ohWT1QY1pJUz9zBNXM3+hWVQjVwrAM+Q8tLY4p6W36gGCtZdPaIUrfi42TN
	UBxQDoKMil1t6FMQWYNp8Xe/XuFhMVDvwNRU/BJbJH0qP9fNIYqn9Ad/qpdXy7sJQaBwa/
	vxPWK80E8DV3vECDVaaFzlSyr2skMWXS65UbJZAlBzR4rMICdzji+HuR2286AtTSno62Pa
	UjBjYcV5lUohXKan/mla5vRp6zP9BKs2sXSxCo9x79cNN33/b0+Gk+sZ3fJCgL915cAIlO
	XWM4yZqWunqdCNvL5/2F2dj4nb9cohRR5Cz7ZN9eHn5hPni/NMHHV1XA2eL+gw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 31 Jan 2024 17:26:18 +0100
Subject: [PATCH v4 05/18] dt-bindings: reset: mobileye,eyeq5-reset: add
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-mbly-clk-v4-5-bcd00510d6a0@bootlin.com>
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

Add DT-Schema bindings for the EyeQ5 reset controller.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/reset/mobileye,eyeq5-reset.yaml       | 44 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
new file mode 100644
index 000000000000..6b412f867d0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
@@ -0,0 +1,44 @@
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
+    minItems: 3
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 42db14d184be..e81c4db22df3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14788,6 +14788,7 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S

-- 
2.43.0


