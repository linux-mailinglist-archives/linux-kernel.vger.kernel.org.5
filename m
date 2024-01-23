Return-Path: <linux-kernel+bounces-35905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DCB8398A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B941C26A60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BBF12BF18;
	Tue, 23 Jan 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n7G7Dzti"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A61292F7;
	Tue, 23 Jan 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035636; cv=none; b=PG9+A3pljdKrmo5kX/Ex4AI7SJ9tR805c+F8wOA0HA4leQ7laS0n2cJTmU7Z+EREOHeamOwZaQljENQf/KxhXQdsQMA0dLdOKVt27R+X9UlJIbjSJlrHPTyyKSJpdz53eK2DEEfHFdDBR8iUhZhpxgq77mzNm43n9YSSwOB8Gus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035636; c=relaxed/simple;
	bh=5I42VGLvLof95eUrYmMlYIgjFJ60v0f2/tsPQOT0pDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VQjsqy5JD8OIkP2k51GP1mcsAhbAoin+l/dPwMtt/WQbu/pA7nqJCkFOXeTmW6eX6h/AtpsXsD1qhsT6VfWVnFLLnO3Un7pdX2GshIqS89ozMO6s2xsz0bMBWy2a8VlnSGsV0jeGapmI3fv1mYL9Bm181aTe77q4GWUnqQKppMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n7G7Dzti; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1CE0C000C;
	Tue, 23 Jan 2024 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0knHG4yi0AiCd1SP9xN4YXMrWJdPos3leMIEEVAqA2A=;
	b=n7G7DztiXy241GRDUVJFENxjGlHt13tUe3vxHM2VTnPH+llXOmLeSu7p4TVewocNAgv8yt
	Ja7NwHdus3cAQTd7Hlt5eqAlWREGAk/Vv6r/iy0osWF276hm6I1L4t8p8X1s0LWw2UqTH3
	unc3WTXLxdDTX3AY3PT/Ju2XaI2/V7NKkIN7tUxOHsE9AdmsqjHVetOWakBao7oFvy9Sry
	pB4pZk2/TxYYufs4yvJrGdBQ/xgctIQbkaJgPXc5edpXQFg8Vm9oWWVmO7WYLn6iUyjpGG
	gjYa7GUvd7TxaHW7HGhKTcIJW3ZtBXKvxybwRdpFHzhIk5VdzVAeKyrikdXIUA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:51 +0100
Subject: [PATCH v3 06/17] dt-bindings: reset: mobileye,eyeq5-reset: add
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-6-392b010b8281@bootlin.com>
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

Add DT-Schema bindings for the EyeQ5 reset controller.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/reset/mobileye,eyeq5-reset.yaml       | 32 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
new file mode 100644
index 000000000000..481b61f278fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
@@ -0,0 +1,32 @@
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
+  "#reset-cells":
+    const: 2
+    description:
+      The first cell is the domain (0 to 2 inclusive) and the second one is the
+      reset index inside that domain.
+
+required:
+  - compatible
+  - "#reset-cells"
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 45ab636b6605..6e0eae9d6243 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14787,6 +14787,7 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
 F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig

-- 
2.43.0


