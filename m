Return-Path: <linux-kernel+bounces-163350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8538B69BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6165C1C21ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F1B199A1;
	Tue, 30 Apr 2024 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c0vbkMDZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5417582;
	Tue, 30 Apr 2024 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453757; cv=none; b=VcoOSjB7C/7qQXzBrAJHY+BZlGXQ8WtDhANL4d9cf6IwpYcH8wZcp01rgBRHqqjrn/IdyGD0HjwA6kuFu3igC7e/vUTVvTrnn/AmJfV4sO0nO0y3m4V6klPBtbA9cENZbeGCPjhxxGHrbhAPiqZLfVhskxOH5izP6H030RYmZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453757; c=relaxed/simple;
	bh=V4JU0kcWhtn/tWTZ81/g5DtXt4pOFjRVoYRQ1OkLVxc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jqo9imjHEdo81ai65a+tytkraQRatIV2tHEnO8oN8hsF7D4A3rSaofXUa3w5Sc2qukXZ1CxY7Mb8oODA4Y5aBAd31W1/nP6u5I14tdLYLEmuI08cOqkRy2s09vtXn3+wKayuGKn3f3inM+eDf6BzULztJMwlOz3t/DxOliM196g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c0vbkMDZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714453755; x=1745989755;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V4JU0kcWhtn/tWTZ81/g5DtXt4pOFjRVoYRQ1OkLVxc=;
  b=c0vbkMDZLxGg+QgjRsapBW5iwaH1xTsX+wm+Dwh5k1ggErKfBsrKxtQB
   GPN9ufh6kGHQRArgWIIQtC/VfJ1giPGE5uAXWUHZ9LJU0pufzZ8OVptMZ
   o3TRwOyHnHt54jS1kV+hKtx19sHimh+9S6jQUTbc35TW3TXqooQ0Mzu8I
   Kthc7Aiag9XFJ2v0VaR1aQKsFyBSKQYwGDPlOudjrQxRsLM7cFQNZvZnv
   jVCWGbztu6yYaRW4YbrzNFjWXATOsRmOBTL/ryx5elB6IBqTBRhNt9FVD
   kmMrFf/a3X689H8QBXAgm5y/Ba4ffuYkeRHSSSs5woNQdKvcipwP1W3j3
   Q==;
X-CSE-ConnectionGUID: fZdkBnDSTq2nhZklP2dv1A==
X-CSE-MsgGUID: 9iD+Qmn4TB2zQWR/4qxDNA==
X-IronPort-AV: E=Sophos;i="6.07,241,1708412400"; 
   d="scan'208";a="23827299"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Apr 2024 22:09:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 22:09:02 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 22:08:58 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <lxu@maxlinear.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next] net: phy: add wol config options in phy device
Date: Tue, 30 Apr 2024 10:36:35 +0530
Message-ID: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Introduce a new member named 'wolopts' to the 'phy_device' structure to
store the user-specified Wake-on-LAN (WOL) settings. Update this member
within the phy driver's 'set_wol()' function whenever the WOL configuration
is modified by the user.

Currently, when the system resumes from sleep, the 'phy_init_hw()' function
resets the PHY's configuration and interrupts, which leads to problems upon
subsequent WOL attempts. By retaining the desired WOL settings in 'wolopts',
we can ensure that the PHY's WOL configuration is correctly reapplied
through 'phy_ethtool_set_wol()' before a system suspend, thereby resolving
the issue

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/phy/mxl-gpy.c    | 5 +++++
 drivers/net/phy/phy_device.c | 5 +++++
 include/linux/phy.h          | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index b2d36a3a96f1..6edb29a1d77e 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -680,6 +680,7 @@ static int gpy_set_wol(struct phy_device *phydev,
 	struct net_device *attach_dev = phydev->attached_dev;
 	int ret;
 
+	phydev->wolopts = 0;
 	if (wol->wolopts & WAKE_MAGIC) {
 		/* MAC address - Byte0:Byte1:Byte2:Byte3:Byte4:Byte5
 		 * VPSPEC2_WOL_AD45 = Byte0:Byte1
@@ -725,6 +726,8 @@ static int gpy_set_wol(struct phy_device *phydev,
 		ret = phy_read(phydev, PHY_ISTAT);
 		if (ret < 0)
 			return ret;
+
+		phydev->wolopts |= WAKE_MAGIC;
 	} else {
 		/* Disable magic packet matching */
 		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
@@ -748,6 +751,8 @@ static int gpy_set_wol(struct phy_device *phydev,
 		if (ret & (PHY_IMASK_MASK & ~PHY_IMASK_LSTC))
 			phy_trigger_machine(phydev);
 
+		phydev->wolopts |= WAKE_PHY;
+
 		return 0;
 	}
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 616bd7ba46cb..9740f08ad98e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2038,6 +2038,11 @@ int phy_suspend(struct phy_device *phydev)
 	if (phydev->suspended)
 		return 0;
 
+	if (phydev->wolopts) {
+		wol.wolopts = phydev->wolopts;
+		phy_ethtool_set_wol(phydev, &wol);
+	}
+
 	phy_ethtool_get_wol(phydev, &wol);
 	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
 	/* If the device has WOL enabled, we cannot suspend the PHY */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3ddfe7fe781a..4a628202699c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -615,6 +615,7 @@ struct macsec_ops;
  *                 handling shall be postponed until PHY has resumed
  * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
  *             requiring a rerun of the interrupt handler after resume
+ * @wolopts: User requested wake-on-lan configuration
  * @interface: enum phy_interface_t value
  * @possible_interfaces: bitmap if interface modes that the attached PHY
  *			 will switch between depending on media speed.
@@ -687,6 +688,7 @@ struct phy_device {
 
 	u32 dev_flags;
 
+	u32 wolopts;
 	phy_interface_t interface;
 	DECLARE_PHY_INTERFACE_MASK(possible_interfaces);
 
-- 
2.34.1


