Return-Path: <linux-kernel+bounces-148696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2508A8653
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17981F211D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EEB144D38;
	Wed, 17 Apr 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JoRQZoQH"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE71442FE;
	Wed, 17 Apr 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364883; cv=none; b=I1Li5/CZq0vGkxwydQ+K01A9Hhjhe7Q5aQPMTKwj319c/sNtI3Ma6cNjlApH/iFhzPBHp71TJwt8TtciqCa182GTbMws0Ft/1zpVz7QK8BjOZaWOwo6LUHm3Bgv9RVGqMLC0h4ns6zDdpdVF319ZD/sbmIdYxcRHymy910zRkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364883; c=relaxed/simple;
	bh=AuTizRlBucGQsy/udo+KknCjERM2RoNGeMqV2UjoRq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=er+6jCVHxUCCE6OrilzHd2O8Z6GJOjuySKmkaAVe8PUG1bJ62G4qZq2hAcOJl5Uvy2QRyNSPpfSdJzv9SBgO5ex8roatIPVYKaguYHMvMlVPtoNt5GrJVa+JljXfGnitCi+w6T49B5zFXvexr3scTqDrgmJ/GFG3mHy8FAnIY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JoRQZoQH; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D139C1BF21B;
	Wed, 17 Apr 2024 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713364879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4LeRQ5OxpUS3XI25Dn4t1Qa5oIuaGs8bDOiCvVceS8=;
	b=JoRQZoQHhq5xriRQZJd5xW/T14Idfigp3aOLQemYBHIuB0hbN9K1/uO0Z0TaE8/Et2VHF2
	zbMVAfKUp+8iXJEphKVcxFTPZtYlzBBgOl/y4xJNwJ6rZJlViJZ2AmvFWUH5ruhbUeTcUV
	cEogZgvnJIUuRsUWtXTGDEg4VcVPQGz8GCto+HwVnYU/dMy/t/s9fj4Si23VjsIg5J15OQ
	BJ9ifNl4cQ66adG/WA6C7luXKnsXaiUWUbv/7tN8Ntpj1Iv49tW8gVJlI5KdMQLMqUA7DI
	/d1fN1juhIiZKan9zzuycwtE7s/oTbQi4MQjG5WZtPHogBWD5bNfLbu6bIMwHw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 17 Apr 2024 16:39:54 +0200
Subject: [PATCH net-next v9 06/14] MAINTAINERS: Add myself to pse
 networking maintainer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-feature_poe-v9-6-242293fd1900@bootlin.com>
References: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
In-Reply-To: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
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
index f22698a7859f..55b289f8bc05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17782,6 +17782,7 @@ F:	net/psample
 
 PSE NETWORK DRIVER
 M:	Oleksij Rempel <o.rempel@pengutronix.de>
+M:	Kory Maincent <kory.maincent@bootlin.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/pse-pd/

-- 
2.34.1


