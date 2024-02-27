Return-Path: <linux-kernel+bounces-83418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F58698CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410A6286A45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2035114A08F;
	Tue, 27 Feb 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fzbK1FnQ"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99996146909;
	Tue, 27 Feb 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045001; cv=none; b=qWdOHPvyuYVnOcime1lwf2wHlfv+HagyxsE2cuLX+ypxMx+ytHoHaDVazjuzjowTxlRgGhLCtlUYOm6DzC7IEvHNnItBMrBUYangUFh25Uyek3OF2lISl3nA9iOQKbJCr2iIGBeMY8mXFLc6+k2SXYM9dFMO+550CPZwTYSIU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045001; c=relaxed/simple;
	bh=SuHBK+hWYbTwqGf1JIYxmzYvFaoSV53Aa9fztIrCmxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EvJkpbx/BoBGGQFAzyzfEHE7zbRNouOrmzokqQmVZuTIH+W9yqTwlycapTytpFuX1dnd0TW8ogXyH/c0QoE95ZKq5nzi84kXNokXkL/T9woLmxGYNbwEEbPXR5lmh+FN+tWJ57eChp2XGOE1MTbl8wASOMbgs78d368FN21ta30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fzbK1FnQ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7DE120017;
	Tue, 27 Feb 2024 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709044997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwVZ1kFaP4gpOaz1jMw0As8dbSIleQ9gERJ6osP639w=;
	b=fzbK1FnQNUcMxXojhTGGr80Wtnpiee/q6kFwtsVqOPugWxDW8IIMnehilepEkRTOb3WAJL
	kWaNKkcXk2vRdJFn+8YwFchUpUbOghXYIDjMEu/glg8JYl3SyMzUv1tu1YBm/WopvqHYyU
	tsYGexkQqwwTB1sS8puATq10ecZe0K9zcTh5VkDuiFcd4n4+y541fvLJEfDT47IdxMMXTE
	UyekIuw5Fqo+Sy7JWNBsf48VJT7YtCDtSzYQ5lYZ4Zp7whDiw3xl0om30jFMnGdKwK1fF4
	Smu4/3Zz2a0pBHJOgJBmM5MUHs7vn1AqL09zJsbTb3bPqISxJtzR0c9d0vE1yA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 27 Feb 2024 15:42:51 +0100
Subject: [PATCH net-next v5 09/17] MAINTAINERS: Add myself to pse
 networking maintainer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-feature_poe-v5-9-28f0aa48246d@bootlin.com>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
In-Reply-To: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

As I add support for PoE in PSE networking subsystem it seems legitimate
to be added to the maintainers.

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f9b554f79da..43d26b766936 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17692,6 +17692,7 @@ F:	net/psample
 
 PSE NETWORK DRIVER
 M:	Oleksij Rempel <o.rempel@pengutronix.de>
+M:	Kory Maincent <kory.maincent@bootlin.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/pse-pd/

-- 
2.25.1


