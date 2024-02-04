Return-Path: <linux-kernel+bounces-51573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BC7848CAD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBD1B21C35
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55241B5BF;
	Sun,  4 Feb 2024 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b="Eef8+IUx"
Received: from secondary.pambor.com (secondary.pambor.com [46.38.233.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983A1B592;
	Sun,  4 Feb 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.233.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707041512; cv=none; b=CgcRwZpZgpgLpHNoP5Iz9xG3O+rDrxaBU8l0YOBcmxX2IwMwn7PNBWL49X4cje6hpGRUYEXzi9Yjw+zkqsRxV6LvZ8r7CnLQL1scd9yVV/vKrBO1bLubgHGyZI6HJdsTETK77m1HcuO7TBFL6RKsWSN0M68c3UsHTQZMXwwau9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707041512; c=relaxed/simple;
	bh=GP/K0NDMKaVN58IzCg9WjhrcSkEgoqe/cArG54xldsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+5eIJFhkxkaLWiUXaCXeYcQE7H66JdsDAwRdL930taVDcjyKbkaN0bvbqpgv9ZNFy7PwLAGZMUetDXDDHtkDkc7IZDauLPfDu8vKmQquHBAKoC/gTyEmD7Lelg8gLoSZLDaOsbS2h82phwNcRcCRYcHrqqLDVZj7YzhFkqeLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de; spf=pass smtp.mailfrom=osasysteme.de; dkim=pass (2048-bit key) header.d=osasysteme.de header.i=@osasysteme.de header.b=Eef8+IUx; arc=none smtp.client-ip=46.38.233.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osasysteme.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=osasysteme.de
Received: from localhost (localhost [127.0.0.1])
	by secondary.pambor.com (Postfix) with ESMTP id 2C0396EFF59;
	Sun,  4 Feb 2024 11:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=osasysteme.de;
	s=19022017; t=1707041531;
	bh=GP/K0NDMKaVN58IzCg9WjhrcSkEgoqe/cArG54xldsk=;
	h=From:To:Cc:Subject:Date:From;
	b=Eef8+IUxJ317AplhtmwG/8ulU4OYW5UtcgCdAZRUys/MAFhmzSUnnpkE6WT/hkity
	 JmTe4QuvnGsjD7XQeCqPGTBJ7hCUi8OiGPb/YBDiLpPyrfFW8/m7sieKVfQ9J2oh5N
	 Jy/aT1xI1F6f5RNPSHt2ybNDLSe+/XzR7csD+WfBfiZc+O36JCNmYuLf1kM24//0iU
	 9ZZYPmbzeJBC++kFvX0VdDwTnKAeTeKfvLeXoUdGLROM5tZsNNW6mTMlrpQexaxNX/
	 X/ODuYjMhnobCluYSkYrEOzMzrvVhTs2emsmZ4yReJPxAHZzSIB0Unfg+MqOBa+LGE
	 q08tsqs73cV8w==
X-Virus-Scanned: Debian amavisd-new at secondary.pambor.com
Received: from secondary.pambor.com ([127.0.0.1])
	by localhost (secondary.pambor.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I7Kpfd2cu_BG; Sun,  4 Feb 2024 11:12:08 +0100 (CET)
Received: from chromebook.fritz.box (dynamic-2a01-0c22-d419-0100-dbc6-7578-807d-f886.c22.pool.telefonica.de [IPv6:2a01:c22:d419:100:dbc6:7578:807d:f886])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.osasysteme.de (Postfix) with ESMTPSA id 3BD166EFE8E;
	Sun,  4 Feb 2024 11:12:07 +0100 (CET)
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
Subject: [PATCH v2] net: phy: dp83822: Fix RGMII TX delay configuration
Date: Sun,  4 Feb 2024 11:11:28 +0100
Message-ID: <20240204101128.49336-1-tp@osasysteme.de>
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
Changes in v2:
  - Further cleanup of RGMII configuration
  - Check for errors setting DP83822_RGMII_MODE_EN
---
 drivers/net/phy/dp83822.c | 41 +++++++++++++--------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index b7cb71817780..1b2c34a97396 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -380,42 +380,29 @@ static int dp83822_config_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
-	int rgmii_delay;
-	s32 rx_int_delay;
-	s32 tx_int_delay;
+	int rcsr_mask = DP83822_RGMII_MODE_EN;
+	int rcsr = 0;
 	int err = 0;
 	int bmcr;
 
 	if (phy_interface_is_rgmii(phydev)) {
-		rx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
-						      true);
+		rcsr |= DP83822_RGMII_MODE_EN;
 
-		if (rx_int_delay <= 0)
-			rgmii_delay = 0;
-		else
-			rgmii_delay = DP83822_RX_CLK_SHIFT;
+		/* Set DP83822_RX_CLK_SHIFT to enable rx clk internal delay */
+		if (phy_get_internal_delay(phydev, dev, NULL, 0, true) > 0)
+			rcsr |= DP83822_RX_CLK_SHIFT;
 
-		tx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
-						      false);
-		if (tx_int_delay <= 0)
-			rgmii_delay &= ~DP83822_TX_CLK_SHIFT;
-		else
-			rgmii_delay |= DP83822_TX_CLK_SHIFT;
+		/* Set DP83822_TX_CLK_SHIFT to disable tx clk internal delay */
+		if (phy_get_internal_delay(phydev, dev, NULL, 0, false) <= 0)
+			rcsr |= DP83822_TX_CLK_SHIFT;
 
-		if (rgmii_delay) {
-			err = phy_set_bits_mmd(phydev, DP83822_DEVADDR,
-					       MII_DP83822_RCSR, rgmii_delay);
-			if (err)
-				return err;
-		}
-
-		phy_set_bits_mmd(phydev, DP83822_DEVADDR,
-					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
-	} else {
-		phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
-					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
+		rcsr_mask |= DP83822_RX_CLK_SHIFT | DP83822_TX_CLK_SHIFT;
 	}
 
+	err = phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR, rcsr_mask, rcsr);
+	if (err < 0)
+		return err;
+
 	if (dp83822->fx_enabled) {
 		err = phy_modify(phydev, MII_DP83822_CTRL_2,
 				 DP83822_FX_ENABLE, 1);
-- 
2.43.0


