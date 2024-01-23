Return-Path: <linux-kernel+bounces-34879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36398388AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D002B25061
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BC56754;
	Tue, 23 Jan 2024 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OO8tkWyc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E592AE91;
	Tue, 23 Jan 2024 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997821; cv=none; b=lb19rgxvFEqguVdXb/cdD7eHIIUnvN10XQZD8t12mEmGArEPItSndbRCjD7qfEjX+JiczYEpIrZ4K34oGDaiTlsyVW0mtRYNAaeJiIGFo3qQReU2UdorqCoBf3l0N51C3TowYHfxUcxHdPZ3cM15kSk4qc8DsUJCb2G9FvP9rPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997821; c=relaxed/simple;
	bh=yL0/rRUOOruG/OmQchTn5YSdcONtJQUhMYQ7Vuqu9Mc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ha8ynrBhc9YCJpYhAYm0oEJs4pQD/WJU+Go5MfwYCOaepKTdQiPrTr2AP9VaEnltqBdcv9aUz+Ct6DFGT3Kc7GxADhNpsfNfQh3iMbs0vEEjcTfOStqZPkNRkxeLqyY99Wd7yY8UiG2sfqVXUWs9wC3F4lk+4B7d7R3HQ/iDAGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OO8tkWyc; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705997819; x=1737533819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yL0/rRUOOruG/OmQchTn5YSdcONtJQUhMYQ7Vuqu9Mc=;
  b=OO8tkWyc+zbu3GDlAGqRlIexhJWbtmruLs8COxEs7IiAbn2PM6wDe4T6
   LBTQCqH2Z5IQbwn4ZccTUNCVHCymKigp2dYc9n4AKlNbtHgLGiS7xqB7i
   YQl7Dtg5O2CfjBH2O0Fy65imTrOGrDgq09F2bRjHfPmltF7mCeMBAoLHY
   4WCkUycYfJNuZAr1+sSb7gDucpRTyourBOQ3A/oJa3UDtLHgWtxDrGeLW
   0vOcPB0YCpG6sJOheheJ/vn2uuRzuR2BSMQ+YYtZNNK7ZfUdqLhD6fAM9
   2MS4np6sNzk5L+1kSqBXYa1EYin0t+isY99yVentGzyMAync0Ts1yPB/Q
   g==;
X-CSE-ConnectionGUID: k8HP9AtUSy+tUHKq9DRptg==
X-CSE-MsgGUID: hFw3hhdgQVeUod1aWPjpow==
X-IronPort-AV: E=Sophos;i="6.05,213,1701154800"; 
   d="scan'208";a="16393439"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 01:16:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:16:29 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:16:27 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net] net: lan966x: Fix port configuration when using SGMII interface
Date: Tue, 23 Jan 2024 09:15:14 +0100
Message-ID: <20240123081514.3625293-1-horatiu.vultur@microchip.com>
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
---
 drivers/net/ethernet/microchip/lan966x/lan966x_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
index 92108d354051c..975a6d64a2e18 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
@@ -170,7 +170,8 @@ static void lan966x_port_link_up(struct lan966x_port *port)
 	/* Also the GIGA_MODE_ENA(1) needs to be set regardless of the
 	 * port speed for QSGMII ports.
 	 */
-	if (phy_interface_num_ports(config->portmode) == 4)
+	if (phy_interface_num_ports(config->portmode) == 4 ||
+	    config->portmode == PHY_INTERFACE_MODE_SGMII)
 		mode = DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
 
 	lan_wr(config->duplex | mode,
-- 
2.34.1


