Return-Path: <linux-kernel+bounces-92233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56576871D2A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAECBB2113E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A315C54917;
	Tue,  5 Mar 2024 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b="SQBVLuZ2"
Received: from secondary.pambor.com (secondary.pambor.com [46.38.233.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FEC10A1B;
	Tue,  5 Mar 2024 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.233.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637278; cv=none; b=EijdlGJBOo97GmQ27RHcXNqDCKXA9HgcWXs6z3wHX9+HMfX3FHUIm+qSVM8oLn/4g3g2W/QhLzpZoVMM/OsIMJHv0Jr9nHoyoCB0kF1sy/K22OjqjQwXehEAJL5OsnRx6qYrqV8y2c6pjljh35DhpzQSh/OVlUO9c416qMF67CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637278; c=relaxed/simple;
	bh=g23TNXNaEuUBqK6ioN3KJo90x6OmVEv0VqAOHJZOjh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tocYyC+iVWPTF0SJkyzoQ6VL8IG0oW3I0jG7ktYRx75/+CQsIQ6gJaCQRslrSnsL70SFW1rzvd2wRteWQhkQWsH6ogIa1AExSWpdPseEC0BWmZpCRGocpiLSUHtE5ayPj1OCPR1TWvrpamBmGma3EQMHAUugXdS7dnj2f4gQO+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de; spf=pass smtp.mailfrom=osasysteme.de; dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b=SQBVLuZ2; arc=none smtp.client-ip=46.38.233.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=osasysteme.de
Received: from localhost (localhost [127.0.0.1])
	by secondary.pambor.com (Postfix) with ESMTP id 5125E6F03A2;
	Tue,  5 Mar 2024 12:07:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=osasysteme.de;
	s=19022017; t=1709636846;
	bh=g23TNXNaEuUBqK6ioN3KJo90x6OmVEv0VqAOHJZOjh8=;
	h=From:To:Cc:Subject:Date:From;
	b=SQBVLuZ2tEZi2HUL+R9jkg73Fuj7PnkaaQ4lWhuhLlla1oZqyPntz5wfpouFJwEw8
	 wTA5UTRUu3/fbpAafL/kIMtHbARhDEzdQMLgPSzXTTnfUiAb2jdyva+M9bAKotqSF7
	 xAMDNc56rt9+1D8yMjQiVnBVTwn/b5DPvtVfvVk4ml+emx60E7r4NhXRd/aV4qrvZI
	 o2ac2xW0PW50akDVYC63HNMH/7UAXcG5CjYjNJY9hwL7g6fftxldeOqXAi2DCt40B9
	 fZEs0qLEdf/ZqnLlvzi77/37obRc3is5LAs4E0UvcwZtNOLa6O/hXdoMzvR9f6BzHi
	 2aXd1Dp4OJZRw==
X-Virus-Scanned: Debian amavisd-new at secondary.pambor.com
Received: from secondary.pambor.com ([127.0.0.1])
	by localhost (secondary.pambor.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2Qg1vcMd3cyn; Tue,  5 Mar 2024 12:07:23 +0100 (CET)
Received: from chromebook.fritz.box (dynamic-2a02-3100-5dd1-2001-a8cd-25c2-d6af-d5f4.310.pool.telefonica.de [IPv6:2a02:3100:5dd1:2001:a8cd:25c2:d6af:d5f4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.osasysteme.de (Postfix) with ESMTPSA id 6445C6F035F;
	Tue,  5 Mar 2024 12:07:23 +0100 (CET)
From: Tim Pambor <tp@osasysteme.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dan Murphy <dmurphy@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Pambor <tp@osasysteme.de>
Subject: [PATCH net-next v3] net: phy: dp83822: Fix RGMII TX delay configuration
Date: Tue,  5 Mar 2024 12:06:08 +0100
Message-ID: <20240305110608.104072-1-tp@osasysteme.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic for enabling the TX clock shift is inverse of enabling the RX
clock shift. The TX clock shift is disabled when DP83822_TX_CLK_SHIFT is
set. Correct the current behavior and always write the delay configuration
to ensure consistent delay settings regardless of bootloader configuration.

Reference: https://www.ti.com/lit/ds/symlink/dp83822i.pdf p. 69

Fixes: 8095295292b5 ("net: phy: DP83822: Add setting the fixed internal delay")
Signed-off-by: Tim Pambor <tp@osasysteme.de>
---
Changes in v3:
  - Revert changes involving DP83822_RGMII_MODE_EN
  - Rebase on net-next
Changes in v2:
  - Further cleanup of RGMII configuration
  - Check for errors setting DP83822_RGMII_MODE_EN
---
 drivers/net/phy/dp83822.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 95178e26a060..c3426a17e6d0 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -402,7 +402,7 @@ static int dp83822_config_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
-	int rgmii_delay;
+	int rgmii_delay = 0;
 	s32 rx_int_delay;
 	s32 tx_int_delay;
 	int err = 0;
@@ -412,30 +412,33 @@ static int dp83822_config_init(struct phy_device *phydev)
 		rx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
 						      true);
 
-		if (rx_int_delay <= 0)
-			rgmii_delay = 0;
-		else
-			rgmii_delay = DP83822_RX_CLK_SHIFT;
+		/* Set DP83822_RX_CLK_SHIFT to enable rx clk internal delay */
+		if (rx_int_delay > 0)
+			rgmii_delay |= DP83822_RX_CLK_SHIFT;
 
 		tx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
 						      false);
+
+		/* Set DP83822_TX_CLK_SHIFT to disable tx clk internal delay */
 		if (tx_int_delay <= 0)
-			rgmii_delay &= ~DP83822_TX_CLK_SHIFT;
-		else
 			rgmii_delay |= DP83822_TX_CLK_SHIFT;
 
-		if (rgmii_delay) {
-			err = phy_set_bits_mmd(phydev, DP83822_DEVADDR,
-					       MII_DP83822_RCSR, rgmii_delay);
-			if (err)
-				return err;
-		}
+		err = phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
+				     DP83822_RX_CLK_SHIFT | DP83822_TX_CLK_SHIFT, rgmii_delay);
+		if (err)
+			return err;
+
+		err = phy_set_bits_mmd(phydev, DP83822_DEVADDR,
+				       MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
 
-		phy_set_bits_mmd(phydev, DP83822_DEVADDR,
-					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
+		if (err)
+			return err;
 	} else {
-		phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
-					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
+		err = phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
+					 MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
+
+		if (err)
+			return err;
 	}
 
 	if (dp83822->fx_enabled) {
-- 
2.43.0


