Return-Path: <linux-kernel+bounces-144192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808958A42EB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E6E1F211B8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641575812A;
	Sun, 14 Apr 2024 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ijSV6asD"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C7524D6;
	Sun, 14 Apr 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713104567; cv=none; b=Drtat+PRhEpORmOUn9TQC0GhI1MNJ0HxGsvhxS08482U39dDArKehad+zn6T35f0YrWOJ0scVHghr2mf38tnw0lHSTMJwOoF9y/ghuQ2Zlczq4MwcRa1RLXjZWQuk334c1Fk/m+w7VylE3ydqzdh577PYYYkxmSwqlijZDrpxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713104567; c=relaxed/simple;
	bh=g6mY9e31JchWhJGlhg+KMtogrVyGcZphTVwZSHCPYXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZJ/M4/wtFtPLfosdMsJ7zmHk+yAaoTrV2WJtGKeMT79suo1U3fE8xX6e7sPbmg9CkMuFBAHPLlkkupuVs6PEwXqIsAvFXnKrS9QEk18Nk1sALH+M07iyT1bXEoQ/i0Jdr+R0AByE3Bc6ka3WKItOExy52hbBim/PHdMhtr+P3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ijSV6asD; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8B99C0002;
	Sun, 14 Apr 2024 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713104562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zadTVC7fSzYdjKYEROA/ritmlhQiFopRb13Zqi9YeM=;
	b=ijSV6asDHUAtNow3ZNWeQUMlF0MAhl5qbjSwEXFM015flbPzn+4wBzNQJBPZ0n/CMGqxZD
	xiUrgWlqn/TNmhJHa798//soKLOBsNpYYVF02AtPdZ2ru1CqiC8wWfdj+GcqNZCxls3CoG
	aUhTTL7pqxQUPSg2HEjwjaaaZZYLrrqrnRQwI+DTSUyv4XizUXvsjGIgz28oO+7akBzymU
	lfKdKtLykngV5Mn8uhrFH6BWkl/V0ne99x7H5q6zBXSUnt/UoMB1XgM0STDrqWJw6ppfJ9
	5SQb9tjqn1scfoyYUqEmFax5gkjREbCHt7MEhNdOrBVALX5GjZ4vN0yEBirFSg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sun, 14 Apr 2024 16:21:50 +0200
Subject: [PATCH net-next v8 01/17] MAINTAINERS: net: Add Oleksij to pse-pd
 maintainers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-feature_poe-v8-1-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
In-Reply-To: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
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
index 5ba3fe6ac09c..f22698a7859f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17780,6 +17780,13 @@ F:	include/net/psample.h
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


