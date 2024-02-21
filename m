Return-Path: <linux-kernel+bounces-75276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A086B85E5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA382858E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C031272A1;
	Wed, 21 Feb 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JjcYP60m"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A286631;
	Wed, 21 Feb 2024 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539744; cv=none; b=lNhNWL2Pc1xTWQq3V3stHUuZtqjN5kLt1W9lX0dzMq/L6VNPum6TGbjUpsqvoQoKoifQAaMtKXJ1bmyWBKg5BUG01oiuQvXW0XEY6ZpSu01lhc1c+OBHMMM0Hc3/uq5Od/yI04zBkH4Y/Ditsw9UPW9Ywer0DxMewAsKicAW6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539744; c=relaxed/simple;
	bh=vnCORcptsMYT519sO0h3l7zszPgUG7xa4ihpqMAWw90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qS6IHGodOROTiXRJ7wUTerKf3k0rXl3R8p4IqelogqO27VjNCBWsOnr0KEwUMdSMWiRpdeJ568ZKlqhP8DTpCliVPAZ3Bo6UOzA+LNQmsLmFwm+foJMviWy0nzZtigZEmE5k3eJe3vxzrxyaBpa4NvMs/Qyzd7OECncazo8Z5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JjcYP60m; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF6501C000A;
	Wed, 21 Feb 2024 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708539740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvNqNx1fTtdrlAJg5eBSDYK4NTtMWF14aEw5+Swezo4=;
	b=JjcYP60m+1p0K0oQAQciprkfVEhwBClb5x4alejnqZavRB5mmx/s2VynOcIYLOEDaHmf2N
	O6poKtf+96mDVEmCQgC2IJIYGYXkIonwmXKB59t4rPwxomDOiwFQeKXBMhtwTiey30Om6t
	fKbKjazUwetmnzpFI+02WHzCYhDrlzZ4QPgb5czRUh3dqfmjDm6UcocPZRAK5+k3WQb0V4
	MSzzzhUaW1r3lmZkqXNIc5Uko8Igg/TLj3M+6SVNP/ECqvCa4+XDXTaRYtwFXysClS2GGq
	lbmnREEVN/T5TcD+oGkcSeUg+E9htfVdh1v304Y2NNI6oO+y5Jzu2cnM2n28TQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 21 Feb 2024 19:22:18 +0100
Subject: [PATCH v7 10/14] MAINTAINERS: Map OLB files to Mobileye SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240221-mbly-clk-v7-10-31d4ce3630c3@bootlin.com>
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
index d2cc66b92f5f..389e3a987bde 100644
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
2.43.2


