Return-Path: <linux-kernel+bounces-58111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A7484E170
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A101D286330
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3D576419;
	Thu,  8 Feb 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jdb5IFcC"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2395763E8;
	Thu,  8 Feb 2024 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397805; cv=none; b=W9soMKbIEjRe1BenUIQNPPsEpd3SpI7Vy9oSsOy4h58G/dd5hSwohVukEMWO307lS/5GAk0OuQ3lV4buOrURT4ba/GwRuasQoTtFmfs+EfykBbz6IZkGq4G04eCWbR8iOYwKNfZOdf7ROFC74PjSATkBTDTK4kyMN54ZcLzvZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397805; c=relaxed/simple;
	bh=Z9tVQBey1nmcy4oqZLpHT3QhR0zoDG2WT75G04jxc78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QhuuFSGbMneM7FMX+VArSLDrlou6gRmQCne/0y2xn78584yvx73GhX3g5GRAMatVzSe7HDLlsbZuejTO1I7cal6PUkToGz2GKlj2GJNWYYwE1Hz1a5G/t3K2kdspn1znDLX9VQcjGxCDfXJPexf5hGKpLKG7tWt5WUPoRjroZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jdb5IFcC; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB9581BF206;
	Thu,  8 Feb 2024 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707397793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKJqdyhIDdN9hTUFPxoQEpyL4H4a0wajJuzgs7fQbmc=;
	b=jdb5IFcCJbBMQf7W0KdHxtmnzg5xKBSvqf5PqfxIoRq0vCEnWE6PDjTVqIMEtFnbX4rBKf
	YAET8gNUhjGcn6Pq5uEymvTYLXgBx2BlPXmWvpAy8SYGzrml1xjB6ZIw26Xt+C6JgBYgll
	HnO1F7pn3KWcw0pZijZIuswbr/3opu7bF3XO/OA+W48fvHwisW0gVZUZMCR2Jkbpprm7dw
	LOIkmsiOtcXGAp4NZlII5bPIA1MSocrhqtM6JUcMuvNoBZ06JiHU1Jm4pzabeSLGyUOwvG
	x+v1Sc6WDvMYbPV65nUhzh1ttYQyr2qbysv8UHSwpikVNi/73M8p0gTHm4+erg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 08 Feb 2024 14:08:38 +0100
Subject: [PATCH net-next v3 01/17] MAINTAINERS: net: Add Oleksij to pse-pd
 maintainers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-feature_poe-v3-1-531d2674469e@bootlin.com>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
In-Reply-To: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
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

Oleksij was the first to add support for pse-pd net subsystem.
Add himself to the maintainers seems logical.

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f465fd778b1..2dcf48948d2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17668,6 +17668,13 @@ F:	include/net/psample.h
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
2.25.1


