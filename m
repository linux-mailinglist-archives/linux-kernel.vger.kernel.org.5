Return-Path: <linux-kernel+bounces-150522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3011A8AA078
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBF8284761
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFBA171E55;
	Thu, 18 Apr 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dNkMDnUX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03B17107B;
	Thu, 18 Apr 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459441; cv=none; b=f7ifyDGBYgetuPgvDVTuiCmKfY4J3Qv/qUKQQE6H7Yjre7iWkCO7LrqEb7zp0o9bRqWt4PslqNZMb5zp5aUlCw5PsjhZGuRA3OzmeMzBdHpATbN6q8AUbpR0SIopPbhuAETvWRe450LK4Ld3sMgAA+DHBTnhPOrExrIpJQt+L2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459441; c=relaxed/simple;
	bh=9eMjiokD/unT75ZDmsitpJbieeh9fuX4Z9ShVHTY3Hs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=FQFh0QN5Egu8S7FCEDlbi4I5Slosx8H3GDl/E+7ymtHAf7o5A7mR3/rBDNfmpz6LwFpUCvTfvfsuBsXKT/jI70qJTC2yjGnVCzXuLTSIXQZMGqewsKFT4RFygLoBt/c7OzkhCgqO2lHFBCt075fl1R31o/+DRw4IaX8KOva6HBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dNkMDnUX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713459439; x=1744995439;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=9eMjiokD/unT75ZDmsitpJbieeh9fuX4Z9ShVHTY3Hs=;
  b=dNkMDnUX8rxF4qE/R4AUfIInrcZsB6iT+RMbFEsFVryRh5A1EQCW/Rn5
   lHO0apoAvxxcv3tuuAf2PyN+55zKSX6SqZmypsAtriRykHJwvvDnB8yQd
   kA24EITDCqv/xaGP87LHtg30cRZUjEnJld3BCaYuhc95oKXsOyiPiyg+W
   DtbF1x5/3Qf9l4lhArNA9vgWd8EtKBNx0ZWTu4jNB0VI9zpyfyI7PqC00
   bJkPDb8tqkKMnIDRKiHwvUM9F4ecDL4JvpHIypcgBQwE1Kfvy7NR3Jk/j
   NSh9fsjxpfoQruzhi+lR2yGCwJVreItngMj1vwZ0xJh7eZgrI8oUvGC06
   w==;
X-CSE-ConnectionGUID: IpAKQTwwQLuvUOb4hfuiSQ==
X-CSE-MsgGUID: s4iptT2aS+S3Z8646Ze55g==
X-IronPort-AV: E=Sophos;i="6.07,212,1708412400"; 
   d="scan'208";a="188927079"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 09:57:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 09:56:43 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 09:56:40 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v2 0/5] net: sparx5: add support for port
 mirroring
Date: Thu, 18 Apr 2024 18:56:33 +0200
Message-ID: <20240418-port-mirroring-v2-0-20642868b386@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMFQIWYC/12NQQqDMBBFryKzbsokGpSueo/iQqajzsJEJkEs4
 t0b7K7Lx+O/f0BiFU7wqA5Q3iRJDAXcrQKahzCxkXdhcOgabNCZNWo2i6hGlTCZzra1t61lGgc
 oo1V5lP0KviBwNoH3DH0xs6Qc9XM9bfbyv6jt/qObNWgYPdUesSXvn4uQRpplvVNcoD/P8wtf5
 RxuugAAAA==
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
 .../net/ethernet/microchip/sparx5/sparx5_mirror.c  | 233 +++++++++++++++++++++
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c | 125 ++++++++++-
 6 files changed, 447 insertions(+), 10 deletions(-)
---
base-commit: 1c25fe9a044d5334153a3585754b26553f8287b9
change-id: 20240402-port-mirroring-81735171ecfa

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


