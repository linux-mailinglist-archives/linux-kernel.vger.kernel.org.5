Return-Path: <linux-kernel+bounces-84886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93B86AD22
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5C628254E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95CE14AD0A;
	Wed, 28 Feb 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LIvQ46/m"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1013B283;
	Wed, 28 Feb 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119705; cv=none; b=Skhggn8CFsAY32cEzaiQLj5KwEOwsdMrQCjIriPzxmwTnJNAhNxxrwtsI2dghVXUvHi3GWH6u+WksbSWI2QP7kRIi+JwecdAuQgOg4ZITkLaEmb1yQ/TErVHJ9HZju47bjox4CxidplBE8nfm4inuJhTmn9mkXD3FIoycS/3H7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119705; c=relaxed/simple;
	bh=xBs03zQWP9DGnm/0faV0yhMmbet0oizIZbCMp/uQ170=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFRw89D8mru17JW2F+SKey4MJUobyAZApaCYrMePpoZSqA/7YFuBiz89evc3tWmyoRfVFZoEbTDP7eJ0jbwmbt7edI6IgkSG65ogTD3wNt6pqFepMtUxWZLOonUTM1kcoGDmyJpt54dp2OBzfhSKxY0tON1XZlKJ8ukWmdqvStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LIvQ46/m; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 934081BF211;
	Wed, 28 Feb 2024 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKuJlJDHFtwtHyGwNcDNStT1C0f3zdHI2RI/EGUYOk8=;
	b=LIvQ46/mspV2f9qlQ+vzDd+nZguxfkKJGIM5NddzX5KMwgSPFcb9blKVrk+nSB69qb9SNa
	gqhlrU3hFvOdkq7sSBvpLMNmP49yl2eIb4ueVOecNMNs3nqn4Qy7gHPb9C7UoiTxgruUxg
	l5Zlm3322XV4CISHgV2oWaO8TDsAFylcTKCZWVsDZn/BL2PUkoJMBIiFKkJMtkL+xQmVXH
	lWA2Cj+AQugWtfRUEkHNYvm7a9E1NqyRgrrgXmb9sRaCgeFW5me1iKZH4/7euDhFwN3Pk/
	rL/Kcmm+ngO04IEStOu3WAZIjnX6Yv9+OWG6gcf7fe3xzw/p8jcJIWPIdq0Huw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:12 +0100
Subject: [PATCH v2 14/30] gpio: nomadik: add #include <linux/slab.h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-14-3ba757474006@bootlin.com>
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add linux/slab.h header include for GFP flags.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index e39477e1a58f..9347c93af62c 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/seq_file.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 
 #include <linux/gpio/gpio-nomadik.h>

-- 
2.44.0


