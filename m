Return-Path: <linux-kernel+bounces-154780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29FD8AE0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B86B2287E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19E60264;
	Tue, 23 Apr 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jEr4m6Xm"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530113399A;
	Tue, 23 Apr 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864080; cv=none; b=M1KAwfSUJR50vHIKZ2t9fx7iY081oPOmabm9k3Ih8w4EniXU6aiG1arCEta42mXT3AyDYO31zSA8dTQCyHcw2mfKo1DtJYwcJo6So9Mz/slEp4w2QRNGj8bf1qB7LfDSxrVzD+Xu20N65k+uurkpmKT/IjvVa24f/DXdnGAY8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864080; c=relaxed/simple;
	bh=bJDjV5+y19iYs0jsERhc9wrq10cgSv0rW0l3K679Kjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fg01wd/nGnSM7OLk80Ng4gGHg/QiAvFSW9wik8Coqek8r742daI6oWioUY/SOoOoefBtVBg0xhby4IUUtVzHD5xqvHbLRjv+AC8z1b5ws6GJytHQAlxnBCt7EqKoswk0a5bF4JHSUY07FffEiik+Aw0J9+sxLwXsSnhN0UgkAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jEr4m6Xm; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15E42240008;
	Tue, 23 Apr 2024 09:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713864076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZUMcCLKyqM24JFjjdsriw3H19crjA0icuaIuq2mB64=;
	b=jEr4m6Xm3ryzjHiFJEZdmLg2cFVG8aoWfweW7CUkS7GHN9UJMRBJfgr73hl18DaXmrN5Iw
	P3+BIDN8CnzRtSd6GYGRL5OfsFLjJYDdHJp3X9p7hqZSMZQRk7ew6ym95jviL2DmIKEB29
	eOCA+Rzp4k59wDoOCCT9Klv434eKpJwLxaXRfGoc9Jx5yd/qI2U1rsc3tdUz3ZBtpPIdc+
	Dpsz9CszArOzCsJkmP8X2cWXx3IDgDCVDmO30MyTzp56HMNTEix4xfYdz3z3C4RlWMeYuR
	4TpYDWws65etjYfTvcQPIAFp+o0HEyfdpXYmmlglrg9aqpppR0Jmk8zfhcx+ww==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 23 Apr 2024 11:21:12 +0200
Subject: [PATCH net-next v3 3/3] net: pse-pd: Kconfig: Add missing
 Regulator API dependency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-fix_poe-v3-3-e50f32f5fa59@bootlin.com>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
In-Reply-To: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

The PSE (Power Sourcing Equipment) API now relies on the Regulator API.
However, the Regulator dependency was missing from Kconfig. This patch
adds the necessary dependency, resolving the issue of the missing
dependency and ensuring proper functionality of the PSE API.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404201020.mqX2IOu7-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202404200036.D8ap1Mf5-lkp@intel.com/
Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
index 80cf373a5a0e..577ea904b3d9 100644
--- a/drivers/net/pse-pd/Kconfig
+++ b/drivers/net/pse-pd/Kconfig
@@ -5,6 +5,7 @@
 
 menuconfig PSE_CONTROLLER
 	bool "Ethernet Power Sourcing Equipment Support"
+	depends on REGULATOR
 	help
 	  Generic Power Sourcing Equipment Controller support.
 
@@ -14,7 +15,6 @@ if PSE_CONTROLLER
 
 config PSE_REGULATOR
 	tristate "Regulator based PSE controller"
-	depends on REGULATOR || COMPILE_TEST
 	help
 	  This module provides support for simple regulator based Ethernet Power
 	  Sourcing Equipment without automatic classification support. For

-- 
2.34.1


