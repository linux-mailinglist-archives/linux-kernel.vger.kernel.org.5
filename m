Return-Path: <linux-kernel+bounces-36783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F071A83A695
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA231C21229
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8C18E1D;
	Wed, 24 Jan 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wpoeUIZd"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1141862A;
	Wed, 24 Jan 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091554; cv=none; b=K0HyNUGAjLCQYb0iYw3C1AgxAx1K9TN8I4HW4bjQMd2SLLNlvTeEg8ACvHoudOJVzz6bYTYGNfO3+OFmkNek2u/BsChHC/o9m/C6a7FJ1jEoCgNkL/cFE/J5i77lUluY3Lh1WKW2mopshOTbrCj8Oc7fFBVQYWOgLVLZZPjJMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091554; c=relaxed/simple;
	bh=yeYvgeBO8qftPD9gLi2kowkyqy92YLE64bSsre7Tjc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nuL4siSBc0W3P4ZLQMPtgQwUKWKDsLf9JgKT5LrnLBiPacCDGPejurW+9TvxqWCqwQnpP3WuOhWfg/3keElsQw/CxmhekxNGQRSBN3ustQPdaTrtfqA4t+yfDrMqG4A67OXARLtKP5N0wPRJKwuFDfRluRAIpxf8zmVxbuBdWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wpoeUIZd; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706091552; x=1737627552;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yeYvgeBO8qftPD9gLi2kowkyqy92YLE64bSsre7Tjc8=;
  b=wpoeUIZdU036XdM2SrZYdYO1BDFJ1ojAmsdzpLSWikVhHaCgeMxAo/c2
   g+QXxFXJj7blRHe7UjKUXPiEIgZtiMTcRgN7vbnybksZchTrI5F6VrLuq
   Kn6ftT/b6+/ZLRglUBIpzvQXkbL9eS3ZbQbSbDIfZwIViBX83kvO4opnL
   XdZn9fPFK85qgVIWSXmcVFn6sFAqiHQBpmoE7ss8uW8vb+04uNId+JodK
   DaMAPhAHTjT7m6UbD0gkAMKp095XSI4FbrJ+U9nhm5NwCY3nymJB5VLzi
   8WFVD9I0I4hA1tEizgDkkJaMYHbsaUKIvbiljV9SFTyAaZTi9wLWjSTjh
   w==;
X-CSE-ConnectionGUID: T28/u+jsQSe9VqMzdG+pyA==
X-CSE-MsgGUID: 4+gZpKMHQZ6Tx3AWTlULPg==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="scan'208";a="245938232"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2024 03:19:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 03:18:48 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 03:18:46 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>, "Horatiu
 Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH net v2] net: lan966x: Fix port configuration when using SGMII interface
Date: Wed, 24 Jan 2024 11:17:58 +0100
Message-ID: <20240124101758.406068-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In case the interface between the MAC and the PHY is SGMII, then the bit
GIGA_MODE on the MAC side needs to be set regardless of the speed at
which it is running.

Fixes: d28d6d2e37d1 ("net: lan966x: add port module support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

---
v1->v2:
- update comment to match the changes to if condition
---
 drivers/net/ethernet/microchip/lan966x/lan966x_port.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
index 92108d354051c..2e83bbb9477e0 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
@@ -168,9 +168,10 @@ static void lan966x_port_link_up(struct lan966x_port *port)
 	lan966x_taprio_speed_set(port, config->speed);
 
 	/* Also the GIGA_MODE_ENA(1) needs to be set regardless of the
-	 * port speed for QSGMII ports.
+	 * port speed for QSGMII or SGMII ports.
 	 */
-	if (phy_interface_num_ports(config->portmode) == 4)
+	if (phy_interface_num_ports(config->portmode) == 4 ||
+	    config->portmode == PHY_INTERFACE_MODE_SGMII)
 		mode = DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
 
 	lan_wr(config->duplex | mode,
-- 
2.34.1


