Return-Path: <linux-kernel+bounces-143129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E408A34CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BB51C21FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432BA14D456;
	Fri, 12 Apr 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDbqWkc1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A945491F;
	Fri, 12 Apr 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943222; cv=none; b=vF/xNFizHAVWI0qj88m6V/xAm4UQpvlhrg6UU1DLyNiEipV0uzAp2CbTnvcrc51mwEok1hcsftwwRgoHyO9wf5z+Z6SZBfLbFuiJ7EjVqck2N8ypcdp7He1QFyNYMgLK56YLNffoyUM9gDOJJL5gI1e9VBBxzTsGs3lhyanA3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943222; c=relaxed/simple;
	bh=+Kb4STvNJ+pOq+Bbj0vo6MDVZVuYbMArjfmW9xuJGRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V2aeP1KnFdBociHNc29FDYPL6LI3vDyhPYzN1i+Lp+f/NOWV4K9AI1CT9BQvQbMACADDv9xg9YrVSs8LS5pgcAT85X93dtkbkBxDurJ+lMvQSi0uz6Hqp1H4B161l0z5YN6L4ZDnpRQfdN05zPPE6vjJBZk6lPlZntqwsRlfen4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDbqWkc1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712943221; x=1744479221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Kb4STvNJ+pOq+Bbj0vo6MDVZVuYbMArjfmW9xuJGRM=;
  b=YDbqWkc1C+vbY0lABkO1YMTeUx43Se7tvGWT6H+/sYc78H9yb777Qzmn
   xHiiuirbns7h5AEjolHKYctOuNpwq1JCakZ3cQDy00jV5MXhoe/4kZjCx
   n0ze3gdrcgSJIKtByuxIO2aPquYpSbhmDLG8aEx0LgePXURdcD+xFQf3+
   Bt91Urs9pDh16D8GwtiUuIfYgH14tclZxoAsOp5gN+58obWgtlfix1BxY
   UowbTeLXSUUEtyFktb/7ECqUHytJGQr8sV5APR2ErjoZr+vZ4J6zYZcyp
   lHlB9pKUQWidjy4/Js9+ZliKRIb79ntM4BigZ1g1HH5yNQafotFaLr5Ws
   w==;
X-CSE-ConnectionGUID: wCycNY2DTS2Eetw2E0d61A==
X-CSE-MsgGUID: gcps37+oT5a1Ab8HfOK8Eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8578640"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8578640"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:33:40 -0700
X-CSE-ConnectionGUID: PepGGd6URwelQES4/NIPNQ==
X-CSE-MsgGUID: 1KzlB0FzTxiRHI3zLn1afA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21326063"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 12 Apr 2024 10:33:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C3039FF; Fri, 12 Apr 2024 20:33:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] can: mcp251x: Fix up includes
Date: Fri, 12 Apr 2024 20:33:32 +0300
Message-ID: <20240412173332.186685-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver is including the legacy GPIO header <linux/gpio.h>
but the only thing it is using from that header is the wrong
define for GPIOF_DIR_OUT.

Fix it up by using GPIO_LINE_DIRECTION_* macros respectively.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/can/spi/mcp251x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 79c4bab5f724..643974b3f329 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -28,7 +28,6 @@
 #include <linux/device.h>
 #include <linux/ethtool.h>
 #include <linux/freezer.h>
-#include <linux/gpio.h>
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -482,9 +481,9 @@ static int mcp251x_gpio_get_direction(struct gpio_chip *chip,
 				      unsigned int offset)
 {
 	if (mcp251x_gpio_is_input(offset))
-		return GPIOF_DIR_IN;
+		return GPIO_LINE_DIRECTION_IN;
 
-	return GPIOF_DIR_OUT;
+	return GPIO_LINE_DIRECTION_OUT;
 }
 
 static int mcp251x_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.43.0.rc1.1336.g36b5255a03ac


