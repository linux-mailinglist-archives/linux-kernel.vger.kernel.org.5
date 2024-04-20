Return-Path: <linux-kernel+bounces-152357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A428ABCE2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 21:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C0528184F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F9E3FE54;
	Sat, 20 Apr 2024 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X071cx1Z"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C4205E00;
	Sat, 20 Apr 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713641366; cv=none; b=A0Bm00pyeOo9FivIeel8TgOjuEEi5SaV0lsjcsMEefW++4H06y3awAbKitPELr2kwWRLjUiplIOmOTyVmbVy9TacW8azACRMKtKgZkJX4qkFDy2/GrPCe1Ah7BdUlRfBqSv8DvY601gD9IM9lmfTEdnJrATHzHTZhlwLfzVXD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713641366; c=relaxed/simple;
	bh=DPhpx3ogNvTeYIGyGZ1Z7G8Y4I9wQYO2ncB5m9y1fGM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=NzoBsa8dCJJcYdvmk2eUckV1W780og5iYSZUgR1Dns0X0PA2Wx1cRGeQJLh8YjWcksnBwfRS/TxpJImkDWvdZwzblm48d2Vj7FJgDDFlqXb78PrO0pE/UY4aKB8KwfrpFhiXFoCeC4XpL53iuLX1tGahXncH96549rnuHrC8cyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X071cx1Z; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713641363; x=1745177363;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=DPhpx3ogNvTeYIGyGZ1Z7G8Y4I9wQYO2ncB5m9y1fGM=;
  b=X071cx1ZtLa9L1FXNxmsMrJdPjngFZ3T8QFtCt7TWI7JAPNk7+QSzPDd
   64PDy/KlTpzkm88YIIyB5XezFQBwjiGuWQOyrIV2cwojt1TBxzoMcm4RK
   iz76fMI4irq7jr1YVX+5R72IbpnM8EWxiGUEP7oTA24Wrv7Dj2traLOZM
   d0YRccS+EldwwKUXhvrrRBhFg08u72iAAuac0YdE+QX1zpeBo4+hg+Q/o
   3WxFTNZG9FO48PYYCagtPcacAJ5D4Kn6V1pt6l0aUjiji7Zy4RJ4up/26
   y8PT151HDhCs5JW1xAlmS1KSkfK+VoyeRudvQ+V2Og2O2TxNQyrhXjGya
   w==;
X-CSE-ConnectionGUID: SORlnsJnTTyKwP8vKnva5A==
X-CSE-MsgGUID: T38QHzjBSBGSmRtFYPP18g==
X-IronPort-AV: E=Sophos;i="6.07,217,1708412400"; 
   d="scan'208";a="21911450"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2024 12:29:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Apr 2024 12:29:19 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sat, 20 Apr 2024 12:29:16 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v3 0/5] net: sparx5: add support for port
 mirroring
Date: Sat, 20 Apr 2024 21:29:09 +0200
Message-ID: <20240420-port-mirroring-v3-0-0fe3ac52006d@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIUXJGYC/33NzQ6DIBAE4FcxnEvDjyjpqe/R9GDpqnsQzEKIj
 fHdS+jNQ4+TyXyzswiEENmt2RlBxojBl6AvDXPz4Cfg+C6ZKaFa0QrF10CJL0gUCP3Erey1kb0
 ENw6sjFaCEbcKPpiHxD1siT1LM2NMgT71Kcva/1Bpz2iWXHAQxmkjRO+MuS/oKLgZ16sLS+Wy+
 k+oQijRtcp29qVtdyaO4/gCS5W0pv0AAAA=
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
Changes in v3:
- Ditch do_div() (patch #3) to fix warning on hexagon arch, reported by intel bot
- Link to v2: https://lore.kernel.org/r/20240418-port-mirroring-v2-0-20642868b386@microchip.com

Changes in v2:
- Fix clang build warning about uninitialized variable 'err'
- Link to v1: https://lore.kernel.org/r/20240418-port-mirroring-v1-0-e05c35007c55@microchip.com

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
 .../net/ethernet/microchip/sparx5/sparx5_mirror.c  | 235 +++++++++++++++++++++
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c | 125 ++++++++++-
 6 files changed, 449 insertions(+), 10 deletions(-)
---
base-commit: 1c25fe9a044d5334153a3585754b26553f8287b9
change-id: 20240402-port-mirroring-81735171ecfa

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


