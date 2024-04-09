Return-Path: <linux-kernel+bounces-137166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E54F89DDEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA471C225CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378A4137C4D;
	Tue,  9 Apr 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IHYAoJkw"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E773A136E09;
	Tue,  9 Apr 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675073; cv=none; b=GK0Pk4qnQ9fJaGuawujFyqT19m+Q4adQRDPFhJtz8T1M89YdCuUxZ1qbXtq9sqpl22eEl3pm1jHL4XiTUh88oijJ8Ozpl8ngDodX9MQXEPBh40iWyGCu/b3AJX11rY7Cad86C/COqglzzkkwFsGf4oeWdvjuocYzA5ty88iLIvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675073; c=relaxed/simple;
	bh=pf+KO/0Zew6qYm5Oj4aZkdCYcFsPta6+IQddolZlAFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FIVijX71kFCQI3lqmmK0WN5X/9ucLxqvl9sBp20//c6bh6NobR71k5xY4cOhAABve24uepPPrqJqhQpI9AObXOuEpm+O2Y9RhN2Reo0/Z7JJmYAnszpWyqzCqmIGnkNIgkqywEF79sJ+aI/punTvzWNWFeXY/liRFxhfMKXNVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IHYAoJkw; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16F88C000F;
	Tue,  9 Apr 2024 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712675069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyhWaZGEB3pQZmb/s2QIiKz0gyjt5m3H88OrGg5XaEQ=;
	b=IHYAoJkwTkM/4nspVM8XedOd4FsRzGIUee/euGIhVSxWNvcm10DbNA6wGZpW90w/M+S9pa
	h1gJMx2v/hIqQKWJJOC7p5tlE8mZ+wdfzE0HpojoKnxDyzhb360q7RkJ3kJquPKWFp4dvf
	o6ew45p3vJw5cxh3vszH/NZuOxXtFPQKGZrtStVvL4GIBCVrgLgrTS1OZ04OOBPvcc+ga7
	Qkz5tUzCTXiUsLvCrdLB0fB/hjiwhOQrza3kSElTuCZKkWK1rbjl/gCpOAqW4JWg7aencN
	Dav/lxLJ/KIqzpClV7v/hTPNyegsDp7Rx3AMT0kDy/8OGfBZLzxaVEYSFWIyFw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Apr 2024 17:03:59 +0200
Subject: [PATCH net-next v7 09/17] MAINTAINERS: Add myself to pse
 networking maintainer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-feature_poe-v7-9-11e38efd4dee@bootlin.com>
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

As I add support for PoE in PSE networking subsystem it seems legitimate
to be added to the maintainers.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3363e4fc261..a7972f7b2580 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17785,6 +17785,7 @@ F:	net/psample
 
 PSE NETWORK DRIVER
 M:	Oleksij Rempel <o.rempel@pengutronix.de>
+M:	Kory Maincent <kory.maincent@bootlin.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/pse-pd/

-- 
2.34.1


