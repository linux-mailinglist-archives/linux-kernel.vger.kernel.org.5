Return-Path: <linux-kernel+bounces-88685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124B286E54B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8DB1C22C9C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2409373189;
	Fri,  1 Mar 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lWfDCfhw"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31370CD9;
	Fri,  1 Mar 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310146; cv=none; b=Kzd9wB1gH9SJ4/j1OxxN6yCcii6EDtGT/rzpvYKd4o7riOGbbrvVHG3NEU3lpGZCWzuN5mDpwwTf6ryvHUFpTDR2nzont8n8hcZwsKm+v5Up62rZQUUOaQBRC8U7v494rtV++6Htuo7LR/fJsnOMG3W/igCP8vG24Ien+zez/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310146; c=relaxed/simple;
	bh=e+fny5g6MsS+gSQqeZXuQdFgEBmhF4B9PgE+HZI4muM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZNwLlAC3RSq54t5iL3dgwIRtvX0ApOWKbM8HRtTby6P4jK4QNoZbCUeZs6Uj1asfdmtvWM3AherZS2UhcIRrLOBcvjlL3xgNkd+wXpqC50DIFJvdT6BiP68MrC2ktfPDHBSWlYU+H2BXUHL+/QYGH2OWltzNPL0HaNdvCdXu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lWfDCfhw; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 946F2C0007;
	Fri,  1 Mar 2024 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709310142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfVmKW7jiq5sw6u952k0VXr2eBJ8dtpMeFQKqMz2C2s=;
	b=lWfDCfhwfn8zLQ7BMBZlWCA7fbcEJ4l6KOD9FW1IKHw1PY0ZHVupSX/3XuIqENyvI/cnoF
	xtDvnjS157FMRdxZlqJTKBRGFyI+uVRVsIgIHgNv/d2ZV71nvFiKB4eZ6+lDjbo5WPPoD/
	sgRImxR0mzJPVzYRyIOL6Oa/nlK2sNPk4GaCl4kKl7iR8lpxGtfa4raAnn0IYX3KnTbi0A
	MHNkedSAbON76zDK/vIGetyokAVQ6J0ntrCbb5uyPx495L4nNOdKfu2pRw/owFBQ4OOPvz
	s1XVsB+m3dMf+LCeQ1RVr9XtNEqwrQLTz+t31qp6h3QvJWHMTjghx5k+C2apcw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 01 Mar 2024 17:22:18 +0100
Subject: [PATCH v9 5/9] MAINTAINERS: Map OLB files to Mobileye SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240301-mbly-clk-v9-5-cbf06eb88708@bootlin.com>
References: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
In-Reply-To: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
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


