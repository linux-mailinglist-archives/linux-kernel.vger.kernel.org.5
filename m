Return-Path: <linux-kernel+bounces-83446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4047186996D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB14528DC59
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBF214A08A;
	Tue, 27 Feb 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A1O4NKjr"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F7145333;
	Tue, 27 Feb 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045743; cv=none; b=GrhZ6+ivY8IkiE813djsNcFz+Z5z0SOEoik2IU1lZWZiys8m5NgbRIStWB/5JFrjpYKzBAA4cRI2Rgne9Kw9bN7CYrXt06Pr79eCe3JRKG4J/IOHJ9doIKpC9bvRp32Qqb9tkpUjHWxv9E54AFgs165XP+MsyVA4XMUGPvChpxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045743; c=relaxed/simple;
	bh=e+fny5g6MsS+gSQqeZXuQdFgEBmhF4B9PgE+HZI4muM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+1CmD/kqVv70Zyyxe/tStHwLEZWqjGrDhHI5pkZOF3h1dQB9js+clyVd3gXgNEVkLtTImCIQTViZhiwGMiriAo7XgBioRde53RrJXOKbIpimU4wEwWQ8Rzw21r5KY3pZkhDVkYs3+x6ugzWeDq71xh5EpjWMjXXyXjMz0BNQHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A1O4NKjr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 716B020010;
	Tue, 27 Feb 2024 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709045739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfVmKW7jiq5sw6u952k0VXr2eBJ8dtpMeFQKqMz2C2s=;
	b=A1O4NKjrVJGeYBkFzPUjLs9xtPtpHWdekfvCprqrhNCnVmSmpzkzDy1drK4NaDwF7xUmSt
	MtaUM5IuLgLxswvrWjX/6urDSLowQXqC8feGQlfHheHgLoNc7ZTfNQMHskcN7a1hSBfvuc
	K5eMkZ4PVeLr6qk8GXBYmo/b/JefLUr9Xu/V9DOHVGdqVVPsHcduX1hvBTp9PG0p+XbWf3
	+myChyyP0ZbDa8wGYoFGAkONLbYChd7VN8CbuvHmJb13fJaParRItGilljMJKQxoon1fKz
	VM9QU1P9fvMZ1yHUvZRiIxV/Koj925oTLZMoepmeP/LHY9Q1iHhip84JTInlKQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 27 Feb 2024 15:55:27 +0100
Subject: [PATCH v8 06/10] MAINTAINERS: Map OLB files to Mobileye SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240227-mbly-clk-v8-6-c57fbda7664a@bootlin.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
In-Reply-To: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
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
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add all OLB related (system-controller) files to the MOBILEYE MIPS SOCS
entry.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

---

This does not follow the standard of adding MAINTAINERS entries with
file additions. We avoid dependencies inbetween maintainer trees. The
MOBILEYE MIPS SOCS is added by [0] series. It is currently in
mips-next [1].

[0]: https://lore.kernel.org/lkml/20240216174227.409400-1-gregory.clement@bootlin.com/
[1]: https://lore.kernel.org/lkml/ZdSst3fM3EOQGH03@alpha.franken.de/
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d2a6a3937e88..73bd2851eb4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14793,10 +14793,18 @@ M:	Gregory CLEMENT <gregory.clement@bootlin.com>
 M:	Théo Lebrun <theo.lebrun@bootlin.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
+F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
+F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S
+F:	drivers/clk/clk-eyeq5.c
+F:	drivers/pinctrl/pinctrl-eyeq5.c
+F:	drivers/reset/reset-eyeq5.c
+F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 F:	include/dt-bindings/soc/mobileye,eyeq5.h
 
 MODULE SUPPORT

-- 
2.44.0


