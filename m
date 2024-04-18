Return-Path: <linux-kernel+bounces-149677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B4F8A946D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0AE1C218FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1545757F7;
	Thu, 18 Apr 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="loAR97z9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321F36B01;
	Thu, 18 Apr 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426670; cv=none; b=pxfRFWSPU615FFDPX8WwTf0cDxowdKF37mOGWgQgL+5pvLxWA4hc/mP2ld7yQb8EZsg11jitdy5juzmJkjsHnnutL/FImU+edvXOcjS2UWzhHUzFDQLBKfyvnOh0RqTF91wZdpIMfFLC2g7vh4lNHojzFHj/l4NaApEJ/ZrJb08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426670; c=relaxed/simple;
	bh=UAUIMBoGKJ6QxfnS0oTaue67w/jDTN5ouNW6IIvNw2I=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=W2SN3rDBE/vRWdaa9Hqw66Ht3245/usr30oXsSWNmbxH33lZuKdYx+q128FjSQ4vwwXAH3CVTqv6EudUIh5oG3e+HN/c2sC6Tg7pXf2e8VwPfPbnrN9AQUC2kXmMyVT7krE5jWbhc5wDoRTLHrzVUjGcjndX3qjsXZ8CeZqDa+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=loAR97z9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713426668; x=1744962668;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=UAUIMBoGKJ6QxfnS0oTaue67w/jDTN5ouNW6IIvNw2I=;
  b=loAR97z9hHrE3WLzyA+Y/4tX6aH+1ZaLG/ERFF6+2nPuXTrvmUH2kNtv
   BZU7J0Mhwh4TONGlVWXC5yRFxI9BuV3vOAO48aUBcnu+xLziNaG/ETQtv
   16yganiCPqpJvwLEtydynqXJJjWVOvXYoyppIpXVoNCrFsrYENA4pifBq
   2HkuA59V6EaLfb//3JFNT+ea19VdPp3WRZ+4CG/affp5e5UP0yjgq1cI5
   UL0h9hWWR+rclsugxNE1TIyCPxeEzj9T4lqeY/u54J37gZlCd5fZpOTsF
   5UtEr7U6PSExAcag9yX4pyPCKDtQ7GmUHpvp8QtToEOr+ARZPGk2GkMW3
   A==;
X-CSE-ConnectionGUID: Kx0F0lTSSFatiU+MgdlHCg==
X-CSE-MsgGUID: ESsrYjbGRLCHbni16zxgpA==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="scan'208";a="188859614"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 00:49:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 00:49:30 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 00:49:26 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 0/5] net: sparx5: add support for port mirroring
Date: Thu, 18 Apr 2024 09:48:59 +0200
Message-ID: <20240418-port-mirroring-v1-0-e05c35007c55@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGvQIGYC/x3MMQqAMAxA0atIZgNtVRSvIg6iac1gKmkRQby7x
 fEN/z+QSJkSjNUDShcnjlJg6wrWfZFAyFsxOONa0xqHZ9SMB6tGZQk42L7pbG9p9QuU6FTyfP/
 DCYQyCt0Z5vf9ADnJiapqAAAA
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Yue Haibing <yuehaibing@huawei.com>, Daniel Machon
	<daniel.machon@microchip.com>
X-Mailer: b4 0.14-dev

This series adds support for port mirroring, and port mirroring stats,
through tc matchall action FLOW_ACTION_MIRRED.

The hardware has three independent mirroring probes. Each probe can be
configured with a separate set of filtering conditions that must be
fulfilled before traffic is mirrored.

A mirror probe can have up to 64 source ports and a single monitor port.
The direction of a mirror probe determines if rx or tx traffic is
mirrored from the source port to the monitor port.

To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Lars Povlsen <lars.povlsen@microchip.com>
To: Steen Hegelund <Steen.Hegelund@microchip.com>
To: UNGLinuxDriver@microchip.com
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Yue Haibing <yuehaibing@huawei.com>

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (5):
      net: sparx5: add new register definitions
      net: sparx5: add bookkeeping code for matchall rules
      net: sparx5: add port mirroring implementation
      net: sparx5: add the tc glue to support port mirroring
      net: sparx5: add support for matchall mirror stats

 drivers/net/ethernet/microchip/sparx5/Makefile     |   3 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   3 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  25 +++
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   |  68 ++++++
 .../net/ethernet/microchip/sparx5/sparx5_mirror.c  | 233 +++++++++++++++++++++
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c | 123 ++++++++++-
 6 files changed, 446 insertions(+), 9 deletions(-)
---
base-commit: 1c25fe9a044d5334153a3585754b26553f8287b9
change-id: 20240402-port-mirroring-81735171ecfa

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


