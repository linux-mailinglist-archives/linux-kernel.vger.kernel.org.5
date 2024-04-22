Return-Path: <linux-kernel+bounces-153391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638818ACD8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A1C2854C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA13153BEF;
	Mon, 22 Apr 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i59he1T0"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDC14F13C;
	Mon, 22 Apr 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790279; cv=none; b=j03HXtrrdJIZz8EjjZdZU793J4T+8T6DsoPXkPLdp68PJMGHwHMas0RIu9tqagn7bmYXDcmIaQ5X8upeAif+BXgbSAoWmjrgqEIWHuPrRe2D3oeiF49WurL+a9Nvrl2jYNr1A3dP6AkT6aaNP3KB5U9cq6AM1CeIKHOAA8ducPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790279; c=relaxed/simple;
	bh=VrKavGaAza0SYYHTP4vDCQZC/hQ8AFa3VvI7kF71uqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8PHKrCSxomOWmgN5ytuimEQX60AKbDuOGXALTKxjll5jm5ro396HdHeNndyLSB0cplenxDXWLwck4vs57plU64a8Maw5TI2xuXUBUoT+yF1cwYwpZhmjq+CbMUV/jEAdHqonBBT+Rw3PuhM1j3NPOpGFzulU9RQDh5Dn2HKb+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i59he1T0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99AD36000D;
	Mon, 22 Apr 2024 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713790276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HN6nZnig5iFISzyn77RTNiJeFQAc1efrKa9cbrzw86Y=;
	b=i59he1T0nN1VQllDQ+6inR921WP53OTiIQMRSg5ajz0z5q1n9HkBDDHugm4qmUY0FkYL6T
	gY7VCfi8MHR/6ReiM0SN7zXySAR5Ex82CvbxxmU0ut+OhDhFAlKvmrYafxdO3dsZ2dOxT0
	mhgMRLQmapJU2OJ8B83kS8xUgGxHPfWa16WBZ9G2bwGrXjK8ktULU8W0av3F8R0CuI/qbq
	dS/dffcprVdaiq5gAPOPzkkqkiJj73O0BvhX2RGyoNAPyAybbvThNJjmYQ3x8XmcRIhiOZ
	4PZLQz3CSwjzHsI+FOHT898LFoiB/JBcPFsJ17gePx3tx7X8LcsMXXUrlmaSCg==
From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Date: Mon, 22 Apr 2024 14:50:50 +0200
Subject: [PATCH net-next 3/3] net: pse-pd: Kconfig: Add missing Regulator
 API dependency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-fix_poe-v1-3-811c8c0b9da7@bootlin.com>
References: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
In-Reply-To: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>, 
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
Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
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


