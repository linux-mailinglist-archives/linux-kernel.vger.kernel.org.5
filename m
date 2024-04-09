Return-Path: <linux-kernel+bounces-137159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C26589DDCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5A01C22EAF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6529134CC2;
	Tue,  9 Apr 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pJ+QHZyE"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815B130E47;
	Tue,  9 Apr 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675067; cv=none; b=Nprhx4I1DzWw1Z4EvLR3FQwdf8PRUCIix3LdOe7RU1zqtDV7g0i09AnXifUmtkO3kqLl255DXulJCyljz8Kq0cBgCNhidbxcalHYavLOfFWf0kCjdsQ3/mivEdwHZy+1RisO4dxopbFXHRpVvRrRcM08yK3apJjyz25jz5dto4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675067; c=relaxed/simple;
	bh=4ERq0U5iMfSXhPyoq84Z0n0t9ecry+TPtJdFUbepSbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eB7bTPTLaN+6CqQJrQENnxReLXpPCKEbsI2nOeWtJkQu04fdqcKVTnLTB0xej1dN+45Mb5JJnGDmqM0zFDmC+E1ukd02Ml1U2llgGGFcoItnYRl0A8+bs7uX3fVr9odr8nVixGPBJoo7poI/QGV9RxpSoTVoYRKx4KM2Jrrpt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pJ+QHZyE; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F5A9C000D;
	Tue,  9 Apr 2024 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712675058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpIu4oPXZiRjvkrqx0KKsmI6Ga0O+KyJijz0/8t3XzE=;
	b=pJ+QHZyEpUdzEioFOH9jrxgS5F2bE3jTLIzQXX4wIboitIEBtdUjH4IPFheIzhpmTt/HzG
	ZcT5G9Y/2jx+HuHyCSXxPrmRvnHLr9RKH+nRg9phdNwUj18pCGeBr0A9WJQquDdM16lUrQ
	3ci7vnh4LNvHDDoBj3hYD5X2nSzToaWno/MjMzN+3KKviBrZ9xqsebA0dfeJY/zZGlwtKZ
	cnCNO7fXqvJczGI3J1nY2F+TkUsQU+N/q7KF9vnwB+I3n5hCFQFI7VNnCKRlyJePkxkX83
	SPSvUKdyoim3yCU2t+vz21cbnuw/Jd4qdAFUIFHkGVxlUKBUsJmn7jMulL96hQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Apr 2024 17:03:51 +0200
Subject: [PATCH net-next v7 01/17] MAINTAINERS: net: Add Oleksij to pse-pd
 maintainers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-feature_poe-v7-1-11e38efd4dee@bootlin.com>
References: <20240409-feature_poe-v7-0-11e38efd4dee@bootlin.com>
In-Reply-To: <20240409-feature_poe-v7-0-11e38efd4dee@bootlin.com>
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
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Oleksij was the first to add support for pse-pd net subsystem.
Add himself to the maintainers seems logical.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Changes in v3:
- New patch
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4745ea94d463..e3363e4fc261 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17783,6 +17783,13 @@ F:	include/net/psample.h
 F:	include/uapi/linux/psample.h
 F:	net/psample
 
+PSE NETWORK DRIVER
+M:	Oleksij Rempel <o.rempel@pengutronix.de>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pse-pd/
+F:	drivers/net/pse-pd/
+
 PSTORE FILESYSTEM
 M:	Kees Cook <keescook@chromium.org>
 R:	Tony Luck <tony.luck@intel.com>

-- 
2.34.1


