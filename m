Return-Path: <linux-kernel+bounces-153465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25F8ACE6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22370B23E44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B94152182;
	Mon, 22 Apr 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jIH1GQXi"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FDF746E;
	Mon, 22 Apr 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792971; cv=none; b=Msdt49HAGkvs0DSxtMCQ0hazTPxEBxGidv2EA0Wdh6mz3vTCY8LJx5jd4vvxe/6gnkW/CBZLqG+U9p3+at8XBUlujuYHoEO3E6HM/EZ74CvEIG5JE2hNxs/uhl0vYQDLA14VCMPAyYJ4Kht3G8ez91vMMAgDBfwgpEHPFLig070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792971; c=relaxed/simple;
	bh=MOieSkGFlLap9YqZh1kDWE4xoA3yyZ85BdHa4q/AEjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sQyqbpvdTNNoG9z7gWqmeFWMymNCXFrFc1XdcjXkQ3JQau7IulN/N527wqqY7NhZgVcPaDKUr5yzTjbze0wsOMRNqKHSL463UmgIwgx+n2TNSHvpeyJ8cxa7+HZHLOCp2QhpTWMs8XkbnhCMOwnMAju+34FokZg8ppp8OUae/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jIH1GQXi; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0140E1C0012;
	Mon, 22 Apr 2024 13:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713792962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2f64ANu3PLImfYGjhtzlKzsVrMAXXlyB8IVnzSIbzQ=;
	b=jIH1GQXi2hnbWCvqH9FvnVxSgSQbO+u0U4T7PfJRF8cSZ/ciZ6Bt8ZEjh87MJ3UiP8Ohgi
	xr3K3izrHsmttmBYS03DJigcLXh+KWJQKnTV1CN1qbsBx33ULXJ/WPGnjh6v3rTZsopnsB
	CB3pYpI7nikrB3+/Ve42SocQGUNjTb1BoBgSTsnId/iWrjPjVoy2za593Q0goTXILNdSek
	0SPcjzNZHNZ70LQ/qywQOlig1OBhQdVZpy+lyWivMuubPCngBBk5EMOdnG4VyyYOW2zOZ3
	gdvPfh4PiRCkuNLjdscVYQ7iCU9On9m8SMEpuFdqg60zFyOhZzNms/zuadY8KA==
From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Date: Mon, 22 Apr 2024 15:35:48 +0200
Subject: [PATCH net-next v2 3/3] net: pse-pd: Kconfig: Add missing
 Regulator API dependency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-fix_poe-v2-3-e58325950f07@bootlin.com>
References: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
In-Reply-To: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
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


