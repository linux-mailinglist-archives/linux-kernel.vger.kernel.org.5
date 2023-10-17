Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239797CBFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjJQJoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjJQJn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:43:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB8130;
        Tue, 17 Oct 2023 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697535835; x=1729071835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CFTJJjSBX3m5VH/nQsAuLKVFYc6aPQDnDNdfm0DG3qA=;
  b=iMm2VYXDodLLjREgVg+uqlcTWhTnieGuPaqoL3jvgCrPZcn6drOeoo6b
   pKF/TeLKeKtzp49mtMrMQ1Eq5wycXvv/wMYpcQGHiCNJ0OHDUAuztS8kf
   zKUVVbTh7oAGvkm5X2uaup10vEjkU+1rnpro0iC3cQiDaIjVYDycQGwEQ
   BFwPfC92YHTUNBhNyap0xiW443f3gojy4j9Mqg31JDV9BKih0lcenILsD
   A4qw5yEEO2RPTzr99Hw5IpOuCqYlU3ypLGOsqnDYXnlIn4U/RtNey40l5
   n1Shd7d0yQ68GehvqZk+CQky62sXB3cz0800JX3JQTYQWL8i3DU1tVmhG
   g==;
X-CSE-ConnectionGUID: kBNkPMf2TJiKgY0/gLa5lw==
X-CSE-MsgGUID: j6f5hvInQdCnLOl7oQWqOA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="10101625"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2023 02:43:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 17 Oct 2023 02:43:39 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 17 Oct 2023 02:43:36 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <Bryan.Whitehead@microchip.com>, <linux-kernel@vger.kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V1 6/7] net: lan743x: Add support to the phylink framework
Date:   Tue, 17 Oct 2023 15:12:07 +0530
Message-ID: <20231017094208.4956-7-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017094208.4956-1-Raju.Lakkaraju@microchip.com>
References: <20231017094208.4956-1-Raju.Lakkaraju@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phylink framework is added since it is required for sfp support of
PCI11x1x boards with sfp cages

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change Log:                                                                     
===========
V0 -> V1:
  - Remove the phylib functions and support the phylink fully

 drivers/net/ethernet/microchip/Kconfig        |   2 +
 drivers/net/ethernet/microchip/lan743x_main.c | 741 +++++++++++-------
 drivers/net/ethernet/microchip/lan743x_main.h |   9 +
 3 files changed, 460 insertions(+), 292 deletions(-)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index f26368b7b834..5dc2c97d7129 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -52,6 +52,8 @@ config LAN743X
 	select I2C_PCI1XXXX
 	select GP_PCI1XXXX
 	select SFP
+	select PCS_XPCS
+	select PHYLINK
 	help
 	  Support for the Microchip LAN743x and PCI11x1x families of PCI
 	  Express Ethernet devices
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index a4baa00273f7..d6823ac6407c 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -19,6 +19,7 @@
 #include <linux/gpio/machine.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/platform_device.h>
+#include <linux/pcs/pcs-xpcs.h>
 #include "lan743x_main.h"
 #include "lan743x_ethtool.h"
 
@@ -1173,6 +1174,28 @@ static int lan743x_get_lsd(int speed, int duplex, u8 mss)
 	return lsd;
 }
 
+static int pci11x1x_pcs_read(struct mii_bus *bus, int addr, int devnum,
+			     int regnum)
+{
+	struct lan743x_adapter *adapter = bus->priv;
+
+	if (addr)
+		return -EOPNOTSUPP;
+
+	return lan743x_sgmii_read(adapter, devnum, regnum);
+}
+
+static int pci11x1x_pcs_write(struct mii_bus *bus, int addr, int devnum,
+			      int regnum, u16 val)
+{
+	struct lan743x_adapter *adapter = bus->priv;
+
+	if (addr)
+		return -EOPNOTSUPP;
+
+	return lan743x_sgmii_write(adapter, devnum, regnum, val);
+}
+
 static int lan743x_sgmii_mpll_set(struct lan743x_adapter *adapter,
 				  u16 baud)
 {
@@ -1241,73 +1264,6 @@ static int lan743x_is_sgmii_2_5G_mode(struct lan743x_adapter *adapter,
 	return 0;
 }
 
-static int lan743x_sgmii_aneg_update(struct lan743x_adapter *adapter)
-{
-	enum lan743x_sgmii_lsd lsd = adapter->sgmii_lsd;
-	int mii_ctrl;
-	int dgt_ctrl;
-	int an_ctrl;
-	int ret;
-
-	if (lsd == LINK_2500_MASTER || lsd == LINK_2500_SLAVE)
-		/* Switch to 2.5 Gbps */
-		ret = lan743x_sgmii_2_5G_mode_set(adapter, true);
-	else
-		/* Switch to 10/100/1000 Mbps clock */
-		ret = lan743x_sgmii_2_5G_mode_set(adapter, false);
-	if (ret < 0)
-		return ret;
-
-	/* Enable SGMII Auto NEG */
-	mii_ctrl = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMCR);
-	if (mii_ctrl < 0)
-		return mii_ctrl;
-
-	an_ctrl = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, VR_MII_AN_CTRL);
-	if (an_ctrl < 0)
-		return an_ctrl;
-
-	dgt_ctrl = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2,
-				      VR_MII_DIG_CTRL1);
-	if (dgt_ctrl < 0)
-		return dgt_ctrl;
-
-	if (lsd == LINK_2500_MASTER || lsd == LINK_2500_SLAVE) {
-		mii_ctrl &= ~(BMCR_ANENABLE | BMCR_ANRESTART | BMCR_SPEED100);
-		mii_ctrl |= BMCR_SPEED1000;
-		dgt_ctrl |= VR_MII_DIG_CTRL1_CL37_TMR_OVR_RIDE_;
-		dgt_ctrl &= ~VR_MII_DIG_CTRL1_MAC_AUTO_SW_;
-		/* In order for Auto-Negotiation to operate properly at
-		 * 2.5 Gbps the 1.6ms link timer values must be adjusted
-		 * The VR_MII_LINK_TIMER_CTRL Register must be set to
-		 * 16'h7A1 and The CL37_TMR_OVR_RIDE bit of the
-		 * VR_MII_DIG_CTRL1 Register set to 1
-		 */
-		ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2,
-					  VR_MII_LINK_TIMER_CTRL, 0x7A1);
-		if (ret < 0)
-			return ret;
-	} else {
-		mii_ctrl |= (BMCR_ANENABLE | BMCR_ANRESTART);
-		an_ctrl &= ~VR_MII_AN_CTRL_SGMII_LINK_STS_;
-		dgt_ctrl &= ~VR_MII_DIG_CTRL1_CL37_TMR_OVR_RIDE_;
-		dgt_ctrl |= VR_MII_DIG_CTRL1_MAC_AUTO_SW_;
-	}
-
-	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR,
-				  mii_ctrl);
-	if (ret < 0)
-		return ret;
-
-	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2,
-				  VR_MII_DIG_CTRL1, dgt_ctrl);
-	if (ret < 0)
-		return ret;
-
-	return lan743x_sgmii_write(adapter, MDIO_MMD_VEND2,
-				  VR_MII_AN_CTRL, an_ctrl);
-}
-
 static int lan743x_pcs_seq_state(struct lan743x_adapter *adapter, u8 state)
 {
 	u8 wait_cnt = 0;
@@ -1356,49 +1312,6 @@ static int lan743x_pcs_power_reset(struct lan743x_adapter *adapter)
 	return lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_UP);
 }
 
-static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
-{
-	struct net_device *netdev = adapter->netdev;
-	struct phy_device *phydev = netdev->phydev;
-	bool status;
-	int ret;
-
-	ret = lan743x_get_lsd(phydev->speed, phydev->duplex,
-			      phydev->master_slave_state);
-	if (ret < 0) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "error %d link-speed-duplex(LSD) invalid\n", ret);
-		return ret;
-	}
-
-	adapter->sgmii_lsd = ret;
-	netif_dbg(adapter, drv, adapter->netdev,
-		  "Link Speed Duplex (lsd) : 0x%X\n", adapter->sgmii_lsd);
-
-	ret = lan743x_sgmii_aneg_update(adapter);
-	if (ret < 0) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "error %d SGMII cfg failed\n", ret);
-		return ret;
-	}
-
-	ret = lan743x_is_sgmii_2_5G_mode(adapter, &status);
-	if (ret < 0) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "erro %d SGMII get mode failed\n", ret);
-		return ret;
-	}
-
-	if (status)
-		netif_dbg(adapter, drv, adapter->netdev,
-			  "SGMII 2.5G mode enable\n");
-	else
-		netif_dbg(adapter, drv, adapter->netdev,
-			  "SGMII 1G mode enable\n");
-
-	return lan743x_pcs_power_reset(adapter);
-}
-
 static void lan743x_mac_set_address(struct lan743x_adapter *adapter,
 				    u8 *addr)
 {
@@ -1535,113 +1448,6 @@ static int lan743x_mac_set_mtu(struct lan743x_adapter *adapter, int new_mtu)
 	return 0;
 }
 
-/* PHY */
-static int lan743x_phy_reset(struct lan743x_adapter *adapter)
-{
-	u32 data;
-
-	/* Only called with in probe, and before mdiobus_register */
-
-	data = lan743x_csr_read(adapter, PMT_CTL);
-	data |= PMT_CTL_ETH_PHY_RST_;
-	lan743x_csr_write(adapter, PMT_CTL, data);
-
-	return readx_poll_timeout(LAN743X_CSR_READ_OP, PMT_CTL, data,
-				  (!(data & PMT_CTL_ETH_PHY_RST_) &&
-				  (data & PMT_CTL_READY_)),
-				  50000, 1000000);
-}
-
-static void lan743x_phy_update_flowcontrol(struct lan743x_adapter *adapter,
-					   u16 local_adv, u16 remote_adv)
-{
-	struct lan743x_phy *phy = &adapter->phy;
-	u8 cap;
-
-	if (phy->fc_autoneg)
-		cap = mii_resolve_flowctrl_fdx(local_adv, remote_adv);
-	else
-		cap = phy->fc_request_control;
-
-	lan743x_mac_flow_ctrl_set_enables(adapter,
-					  cap & FLOW_CTRL_TX,
-					  cap & FLOW_CTRL_RX);
-}
-
-static int lan743x_phy_init(struct lan743x_adapter *adapter)
-{
-	return lan743x_phy_reset(adapter);
-}
-
-static void lan743x_phy_link_status_change(struct net_device *netdev)
-{
-	struct lan743x_adapter *adapter = netdev_priv(netdev);
-	struct phy_device *phydev = netdev->phydev;
-	u32 data;
-
-	phy_print_status(phydev);
-	if (phydev->state == PHY_RUNNING) {
-		int remote_advertisement = 0;
-		int local_advertisement = 0;
-
-		data = lan743x_csr_read(adapter, MAC_CR);
-
-		/* set duplex mode */
-		if (phydev->duplex)
-			data |= MAC_CR_DPX_;
-		else
-			data &= ~MAC_CR_DPX_;
-
-		/* set bus speed */
-		switch (phydev->speed) {
-		case SPEED_10:
-			data &= ~MAC_CR_CFG_H_;
-			data &= ~MAC_CR_CFG_L_;
-		break;
-		case SPEED_100:
-			data &= ~MAC_CR_CFG_H_;
-			data |= MAC_CR_CFG_L_;
-		break;
-		case SPEED_1000:
-			data |= MAC_CR_CFG_H_;
-			data &= ~MAC_CR_CFG_L_;
-		break;
-		case SPEED_2500:
-			data |= MAC_CR_CFG_H_;
-			data |= MAC_CR_CFG_L_;
-		break;
-		}
-		lan743x_csr_write(adapter, MAC_CR, data);
-
-		local_advertisement =
-			linkmode_adv_to_mii_adv_t(phydev->advertising);
-		remote_advertisement =
-			linkmode_adv_to_mii_adv_t(phydev->lp_advertising);
-
-		lan743x_phy_update_flowcontrol(adapter, local_advertisement,
-					       remote_advertisement);
-		lan743x_ptp_update_latency(adapter, phydev->speed);
-		if (phydev->interface == PHY_INTERFACE_MODE_SGMII ||
-		    phydev->interface == PHY_INTERFACE_MODE_1000BASEX ||
-		    phydev->interface == PHY_INTERFACE_MODE_2500BASEX)
-			lan743x_sgmii_config(adapter);
-	}
-}
-
-static void lan743x_phy_close(struct lan743x_adapter *adapter)
-{
-	struct net_device *netdev = adapter->netdev;
-	struct phy_device *phydev = netdev->phydev;
-
-	phy_stop(netdev->phydev);
-	phy_disconnect(netdev->phydev);
-
-	/* using phydev here as phy_disconnect NULLs netdev->phydev */
-	if (phy_is_pseudo_fixed_link(phydev))
-		fixed_phy_unregister(phydev);
-
-}
-
 static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 {
 	u32 id_rev;
@@ -1650,7 +1456,11 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 	data = lan743x_csr_read(adapter, MAC_CR);
 	id_rev = adapter->csr.id_rev & ID_REV_ID_MASK_;
 
-	if (adapter->is_pci11x1x && adapter->is_sgmii_en)
+	if (adapter->is_pci11x1x &&
+	    adapter->is_sgmii_en &&
+	    adapter->is_sfp_support_en)
+		adapter->phy_interface = PHY_INTERFACE_MODE_2500BASEX;
+	else if (adapter->is_pci11x1x && adapter->is_sgmii_en)
 		adapter->phy_interface = PHY_INTERFACE_MODE_SGMII;
 	else if (id_rev == ID_REV_ID_LAN7430_)
 		adapter->phy_interface = PHY_INTERFACE_MODE_GMII;
@@ -1658,65 +1468,9 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 		adapter->phy_interface = PHY_INTERFACE_MODE_MII;
 	else
 		adapter->phy_interface = PHY_INTERFACE_MODE_RGMII;
-}
-
-static int lan743x_phy_open(struct lan743x_adapter *adapter)
-{
-	struct net_device *netdev = adapter->netdev;
-	struct lan743x_phy *phy = &adapter->phy;
-	struct fixed_phy_status fphy_status = {
-		.link = 1,
-		.speed = SPEED_1000,
-		.duplex = DUPLEX_FULL,
-	};
-	struct phy_device *phydev;
-	int ret = -EIO;
-
-	/* try devicetree phy, or fixed link */
-	phydev = of_phy_get_and_connect(netdev, adapter->pdev->dev.of_node,
-					lan743x_phy_link_status_change);
-
-	if (!phydev) {
-		/* try internal phy */
-		phydev = phy_find_first(adapter->mdiobus);
-		if (!phydev)	{
-			if ((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
-					ID_REV_ID_LAN7431_) {
-				phydev = fixed_phy_register(PHY_POLL,
-							    &fphy_status, NULL);
-				if (IS_ERR(phydev)) {
-					netdev_err(netdev, "No PHY/fixed_PHY found\n");
-					return PTR_ERR(phydev);
-				}
-			} else {
-				goto return_error;
-				}
-		}
-
-		lan743x_phy_interface_select(adapter);
-
-		ret = phy_connect_direct(netdev, phydev,
-					 lan743x_phy_link_status_change,
-					 adapter->phy_interface);
-		if (ret)
-			goto return_error;
-	}
-
-	/* MAC doesn't support 1000T Half */
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
-
-	/* support both flow controls */
-	phy_support_asym_pause(phydev);
-	phy->fc_request_control = (FLOW_CTRL_RX | FLOW_CTRL_TX);
-	phy->fc_autoneg = phydev->autoneg;
-
-	phy_start(phydev);
-	phy_start_aneg(phydev);
-	phy_attached_info(phydev);
-	return 0;
 
-return_error:
-	return ret;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "selected phy interface: 0x%X\n", adapter->phy_interface);
 }
 
 static void lan743x_rfe_open(struct lan743x_adapter *adapter)
@@ -3283,6 +3037,375 @@ static int lan743x_sfp_register(struct lan743x_adapter *adapter)
 	return 0;
 }
 
+void lan743x_mac_cfg_update(struct lan743x_adapter *adapter, bool link,
+			    int speed, const unsigned long *advertise)
+{
+	int mac_cr;
+
+	mac_cr = lan743x_csr_read(adapter, MAC_CR);
+	mac_cr &= ~(MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
+	if (link) {
+		if (speed == SPEED_2500)
+			mac_cr |= (MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
+		else if (speed == SPEED_1000)
+			mac_cr |= (MAC_CR_CFG_H_);
+		else if (speed == SPEED_100)
+			mac_cr |= (MAC_CR_CFG_L_);
+	} else if (test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, advertise) ||
+		   test_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, advertise)) {
+		mac_cr |= (MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
+		adapter->sgmii_lsd = LINK_2500_MASTER;
+	} else if (test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, advertise) ||
+		   test_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, advertise)) {
+		mac_cr |= (MAC_CR_CFG_H_);
+		adapter->sgmii_lsd = LINK_1000_MASTER;
+	} else if (test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, advertise) ||
+		   test_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, advertise) ||
+		   test_bit(ETHTOOL_LINK_MODE_100baseFX_Full_BIT, advertise) ||
+		   test_bit(ETHTOOL_LINK_MODE_100baseFX_Half_BIT, advertise)) {
+		mac_cr |= (MAC_CR_CFG_L_);
+		adapter->sgmii_lsd = LINK_1000_MASTER;
+	} else {
+		adapter->sgmii_lsd = LINK_1000_MASTER;
+	}
+
+	lan743x_csr_write(adapter, MAC_CR, mac_cr);
+}
+
+static int lan743x_phylink_sgmii_config(struct lan743x_adapter *adapter)
+{
+	int ret;
+
+	ret = lan743x_get_lsd(SPEED_1000, DUPLEX_FULL,
+			      MASTER_SLAVE_STATE_MASTER);
+	if (ret < 0) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "error %d link-speed-duplex(LSD) invalid\n", ret);
+		return ret;
+	}
+
+	adapter->sgmii_lsd = ret;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "Link Speed Duplex (lsd) : 0x%X\n", adapter->sgmii_lsd);
+
+	/* Switch to serial bit rate of 1.25 Gbps */
+	ret = lan743x_sgmii_2_5G_mode_set(adapter, false);
+	if (ret < 0)
+		return ret;
+
+	return lan743x_pcs_power_reset(adapter);
+}
+
+static int lan743x_phylink_1000basex_config(struct lan743x_adapter *adapter)
+{
+	u32 sgmii_ctl;
+	int ret;
+
+	ret = lan743x_get_lsd(SPEED_1000, DUPLEX_FULL,
+			      MASTER_SLAVE_STATE_MASTER);
+	if (ret < 0) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "error %d link-speed-duplex(LSD) invalid\n", ret);
+		return ret;
+	}
+
+	adapter->sgmii_lsd = ret;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "Link Speed Duplex (lsd) : 0x%X\n", adapter->sgmii_lsd);
+
+	/* LINK_STATUS_SOURCE 1000BASE-X PCS link status */
+	sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
+	sgmii_ctl |= SGMII_CTL_LINK_STATUS_SOURCE_;
+	lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
+	sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
+
+	/* Switch to serial bit rate of 1.25 Gbps */
+	ret = lan743x_sgmii_2_5G_mode_set(adapter, false);
+	if (ret < 0)
+		return ret;
+
+	return lan743x_pcs_power_reset(adapter);
+}
+
+static int lan743x_phylink_2500basex_config(struct lan743x_adapter *adapter)
+{
+	u32 sgmii_ctl;
+	int ret;
+
+	ret = lan743x_get_lsd(SPEED_2500, DUPLEX_FULL,
+			      MASTER_SLAVE_STATE_MASTER);
+	if (ret < 0) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "error %d link-speed-duplex(LSD) invalid\n", ret);
+		return ret;
+	}
+
+	adapter->sgmii_lsd = ret;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "Link Speed Duplex (lsd) : 0x%X\n", adapter->sgmii_lsd);
+
+	/* LINK_STATUS_SOURCE 2500BASE-X PCS link status */
+	sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
+	sgmii_ctl |= SGMII_CTL_LINK_STATUS_SOURCE_;
+	lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
+	sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
+
+	/* Switch to serial bit rate of 3.125 Gbps */
+	ret = lan743x_sgmii_2_5G_mode_set(adapter, true);
+	if (ret < 0)
+		return ret;
+
+	return lan743x_pcs_power_reset(adapter);
+}
+
+static struct phylink_pcs *lan743x_phylink_mac_select(struct phylink_config *config,
+						      phy_interface_t interface)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	if (adapter->xpcs)
+		return &adapter->xpcs->pcs;
+
+	return NULL;
+}
+
+static void lan743x_phylink_mac_config(struct phylink_config *config,
+				       unsigned int link_an_mode,
+				       const struct phylink_link_state *state)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	bool status;
+	int ret;
+
+	lan743x_mac_cfg_update(adapter, state->link, state->speed,
+			       state->advertising);
+
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_2500BASEX:
+		lan743x_phylink_2500basex_config(adapter);
+		break;
+	case PHY_INTERFACE_MODE_1000BASEX:
+		lan743x_phylink_1000basex_config(adapter);
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		lan743x_phylink_sgmii_config(adapter);
+		break;
+	default:
+		netif_dbg(adapter, drv, adapter->netdev,
+			  "RGMII/GMII/MII mode enable\n");
+		return;
+	}
+
+	ret = lan743x_is_sgmii_2_5G_mode(adapter, &status);
+	if (ret < 0)
+		netif_err(adapter, drv, adapter->netdev,
+			  "erro %d SGMII get mode failed\n", ret);
+
+	if (status)
+		netif_dbg(adapter, drv, adapter->netdev,
+			  "SGMII 2.5G mode enable\n");
+	else
+		netif_dbg(adapter, drv, adapter->netdev,
+			  "SGMII 1G mode enable\n");
+}
+
+static void lan743x_phylink_mac_link_down(struct phylink_config *config,
+					  unsigned int link_an_mode,
+					  phy_interface_t interface)
+{
+	netif_tx_stop_all_queues(to_net_dev(config->dev));
+}
+
+static void lan743x_phylink_mac_link_up(struct phylink_config *config,
+					struct phy_device *phydev,
+					unsigned int link_an_mode,
+					phy_interface_t interface,
+					int speed, int duplex,
+					bool tx_pause, bool rx_pause)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	struct lan743x_phy *phy = &adapter->phy;
+	u32 remote_adv;
+	u32 local_adv;
+	u8 cap = 0;
+	int mac_cr;
+
+	mac_cr = lan743x_csr_read(adapter, MAC_CR);
+	mac_cr &= ~(MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
+	if (speed == SPEED_2500)
+		mac_cr |= (MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
+	else if (speed == SPEED_1000)
+		mac_cr |= (MAC_CR_CFG_H_);
+	else if (speed == SPEED_100)
+		mac_cr |= (MAC_CR_CFG_L_);
+
+	lan743x_csr_write(adapter, MAC_CR, mac_cr);
+
+	/* Flow Control operation */
+	if (phydev) {
+		local_adv = linkmode_adv_to_mii_adv_t(phydev->advertising);
+		remote_adv = linkmode_adv_to_mii_adv_t(phydev->lp_advertising);
+
+		if (phy->fc_autoneg)
+			cap = mii_resolve_flowctrl_fdx(local_adv, remote_adv);
+		else
+			cap = phy->fc_request_control;
+	} else {
+		if (tx_pause)
+			cap |= FLOW_CTRL_TX;
+		if (rx_pause)
+			cap |= FLOW_CTRL_RX;
+	}
+
+	lan743x_mac_flow_ctrl_set_enables(adapter,
+					  cap & FLOW_CTRL_TX,
+					  cap & FLOW_CTRL_RX);
+
+	lan743x_rfe_update_mac_address(adapter);
+
+	netif_tx_wake_all_queues(to_net_dev(config->dev));
+}
+
+static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
+	.mac_select_pcs = lan743x_phylink_mac_select,
+	.mac_config = lan743x_phylink_mac_config,
+	.mac_link_down = lan743x_phylink_mac_link_down,
+	.mac_link_up = lan743x_phylink_mac_link_up,
+};
+
+static int lan743x_phylink_create(struct net_device *netdev)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	struct fwnode_handle *fwnode = NULL;
+	struct phylink *phylink;
+	int ret;
+
+	adapter->phylink_config.dev = &netdev->dev;
+	adapter->phylink_config.type = PHYLINK_NETDEV;
+	adapter->phylink_config.mac_managed_pm = true;
+
+	adapter->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
+		MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
+
+	/* Config serdes Interface */
+	if (adapter->phy_interface == PHY_INTERFACE_MODE_NA)
+		lan743x_phy_interface_select(adapter);
+
+	if (adapter->is_sgmii_en) {
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  adapter->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  adapter->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  adapter->phylink_config.supported_interfaces);
+	} else {
+		switch (adapter->phy_interface) {
+		case PHY_INTERFACE_MODE_GMII:
+			__set_bit(PHY_INTERFACE_MODE_GMII,
+				  adapter->phylink_config.supported_interfaces);
+			break;
+		case PHY_INTERFACE_MODE_MII:
+			__set_bit(PHY_INTERFACE_MODE_MII,
+				  adapter->phylink_config.supported_interfaces);
+			break;
+		default:
+			__set_bit(PHY_INTERFACE_MODE_RGMII,
+				  adapter->phylink_config.supported_interfaces);
+		}
+	}
+
+	if (adapter->nodes) {
+		fwnode = software_node_fwnode(adapter->nodes->group[SWNODE_PHYLINK]);
+		if (!fwnode)
+			return -ENODEV;
+	}
+
+	phylink = phylink_create(&adapter->phylink_config,
+				 fwnode,
+				 adapter->phy_interface,
+				 &lan743x_phylink_mac_ops);
+
+	if (IS_ERR(phylink)) {
+		ret = PTR_ERR(phylink);
+		netdev_err(netdev, "Could not create phylink (%pe)\n", phylink);
+		return ret;
+	}
+
+	adapter->phylink = phylink;
+	netdev_dbg(netdev, "lan743x phylink created");
+
+	return 0;
+}
+
+static bool lan743x_phy_handle_exists(struct device_node *dn)
+{
+	dn = of_parse_phandle(dn, "phy-handle", 0);
+	of_node_put(dn);
+	if (IS_ERR(dn))
+		return false;
+
+	return true;
+}
+
+static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
+{
+	struct device_node *dn = adapter->pdev->dev.of_node;
+	struct net_device *dev = adapter->netdev;
+	struct fixed_phy_status fphy_status = {
+		.link = 1,
+		.speed = SPEED_1000,
+		.duplex = DUPLEX_FULL,
+	};
+	struct phy_device *phydev;
+	int ret;
+
+	if (!adapter->is_sfp_support_en) {
+		if (dn)
+			ret = phylink_of_phy_connect(adapter->phylink, dn, 0);
+
+		if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
+			phydev = phy_find_first(adapter->mdiobus);
+			if (!phydev) {
+				if ((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
+				     ID_REV_ID_LAN7431_) {
+					phydev = fixed_phy_register(PHY_POLL,
+								    &fphy_status,
+								    NULL);
+					if (IS_ERR(phydev)) {
+						netdev_err(dev,
+							   "No PHY/fixed_PHY found\n");
+						return PTR_ERR(phydev);
+					}
+				} else {
+					netdev_err(dev, "no PHY found\n");
+					return -ENXIO;
+				}
+			}
+
+			/* attach the mac to the phy */
+			ret = phylink_connect_phy(adapter->phylink, phydev);
+		}
+
+		if (ret) {
+			netdev_err(dev, "Could not attach PHY (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	phylink_start(adapter->phylink);
+
+	return 0;
+}
+
+static void lan743x_phylink_close(struct lan743x_adapter *adapter)
+{
+	phylink_stop(adapter->phylink);
+	phylink_disconnect_phy(adapter->phylink);
+}
+
 static int lan743x_netdev_close(struct net_device *netdev)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
@@ -3296,7 +3419,7 @@ static int lan743x_netdev_close(struct net_device *netdev)
 
 	lan743x_ptp_close(adapter);
 
-	lan743x_phy_close(adapter);
+	lan743x_phylink_close(adapter);
 
 	lan743x_mac_close(adapter);
 
@@ -3319,13 +3442,13 @@ static int lan743x_netdev_open(struct net_device *netdev)
 	if (ret)
 		goto close_intr;
 
-	ret = lan743x_phy_open(adapter);
+	ret = lan743x_phylink_connect(adapter);
 	if (ret)
 		goto close_mac;
 
 	ret = lan743x_ptp_open(adapter);
 	if (ret)
-		goto close_phy;
+		goto close_phylink;
 
 	lan743x_rfe_open(adapter);
 
@@ -3355,8 +3478,8 @@ static int lan743x_netdev_open(struct net_device *netdev)
 	}
 	lan743x_ptp_close(adapter);
 
-close_phy:
-	lan743x_phy_close(adapter);
+close_phylink:
+	lan743x_phylink_close(adapter);
 
 close_mac:
 	lan743x_mac_close(adapter);
@@ -3385,11 +3508,14 @@ static netdev_tx_t lan743x_netdev_xmit_frame(struct sk_buff *skb,
 static int lan743x_netdev_ioctl(struct net_device *netdev,
 				struct ifreq *ifr, int cmd)
 {
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
 	if (!netif_running(netdev))
 		return -EINVAL;
 	if (cmd == SIOCSHWTSTAMP)
 		return lan743x_ptp_ioctl(netdev, ifr, cmd);
-	return phy_mii_ioctl(netdev->phydev, ifr, cmd);
+
+	return phylink_mii_ioctl(adapter->phylink, ifr, cmd);
 }
 
 static void lan743x_netdev_set_multicast(struct net_device *netdev)
@@ -3491,6 +3617,9 @@ static void lan743x_hardware_cleanup(struct lan743x_adapter *adapter)
 
 static void lan743x_mdiobus_cleanup(struct lan743x_adapter *adapter)
 {
+	if (adapter->xpcs)
+		xpcs_destroy(adapter->xpcs);
+
 	mdiobus_unregister(adapter->mdiobus);
 }
 
@@ -3498,6 +3627,8 @@ static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
 {
 	unregister_netdev(adapter->netdev);
 
+	phylink_destroy(adapter->phylink);
+
 	if (adapter->sfp_dev)
 		platform_device_unregister(adapter->sfp_dev);
 
@@ -3548,17 +3679,13 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 	if (ret)
 		return ret;
 
-	if (adapter->is_sfp_support_en) {
+	if (adapter->is_sfp_support_en && !adapter->nodes) {
 		ret = lan743x_swnodes_register(adapter);
 		if (ret) {
 			netdev_err(adapter->netdev,
 				   "failed to register software nodes\n");
 			return ret;
 		}
-	} else {
-		ret = lan743x_phy_init(adapter);
-		if (ret)
-			return ret;
 	}
 
 	ret = lan743x_ptp_init(adapter);
@@ -3588,6 +3715,7 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 
 static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 {
+	struct dw_xpcs *xpcs;
 	u32 sgmii_ctl;
 	int ret;
 
@@ -3608,8 +3736,14 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 				  "SGMII operation\n");
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
-			adapter->mdiobus->read_c45 = lan743x_mdiobus_read_c45;
-			adapter->mdiobus->write_c45 = lan743x_mdiobus_write_c45;
+			if (adapter->is_sfp_support_en) {
+				adapter->mdiobus->read_c45 = pci11x1x_pcs_read;
+				adapter->mdiobus->write_c45 = pci11x1x_pcs_write;
+			} else {
+				adapter->mdiobus->read_c45 = lan743x_mdiobus_read_c45;
+				adapter->mdiobus->write_c45 = lan743x_mdiobus_write_c45;
+			}
+
 			adapter->mdiobus->name = "lan743x-mdiobus-c45";
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "lan743x-mdiobus-c45\n");
@@ -3645,9 +3779,26 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 	ret = mdiobus_register(adapter->mdiobus);
 	if (ret < 0)
 		goto return_error;
+
+	if (adapter->is_sfp_support_en) {
+		if (!adapter->phy_interface)
+			lan743x_phy_interface_select(adapter);
+
+		xpcs = xpcs_create_mdiodev(adapter->mdiobus, 0,
+					   adapter->phy_interface);
+		if (IS_ERR(xpcs)) {
+			netdev_err(adapter->netdev,
+				   "failed to create xpcs\n");
+			return PTR_ERR(xpcs);
+		}
+
+		adapter->xpcs = xpcs;
+	}
+
 	return 0;
 
 return_error:
+	mdiobus_free(adapter->mdiobus);
 	return ret;
 }
 
@@ -3717,6 +3868,15 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 	adapter->netdev->features = NETIF_F_SG | NETIF_F_TSO |
 				    NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	adapter->netdev->hw_features = adapter->netdev->features;
+	/* Default Link-Speed-Duplex (LSD) state */
+	adapter->sgmii_lsd = LINK_2500_MASTER;
+
+	ret = lan743x_phylink_create(adapter->netdev);
+	if (ret < 0) {
+		netif_err(adapter, probe, netdev,
+			  "failed to setup phylink (%d)\n", ret);
+		goto cleanup_hardware;
+	}
 
 	if (adapter->is_sfp_support_en) {
 		adapter->i2c_adap->dev.fwnode =
@@ -3730,9 +3890,6 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 		}
 	}
 
-	/* carrier off reporting is important to ethtool even BEFORE open */
-	netif_carrier_off(netdev);
-
 	ret = register_netdev(adapter->netdev);
 	if (ret < 0)
 		goto cleanup_mdiobus;
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 9746e36baaac..aab3c1567310 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -6,6 +6,7 @@
 
 #include <linux/phy.h>
 #include <linux/property.h>
+#include <linux/phylink.h>
 #include "lan743x_ptp.h"
 
 #define DRIVER_AUTHOR   "Bryan Whitehead <Bryan.Whitehead@microchip.com>"
@@ -317,6 +318,9 @@
 /* Vendor Specific SGMII MMD details */
 #define SR_VSMMD_PCS_ID1		0x0004
 #define SR_VSMMD_PCS_ID2		0x0005
+#define SR_MII_CTRL			MII_BMCR
+#define SR_MII_STS			MII_BMSR
+#define SR_MII_STS_LINK_STS_		BIT(2)
 #define SR_VSMMD_STS			0x0008
 #define SR_VSMMD_CTRL			0x0009
 
@@ -1083,6 +1087,9 @@ struct lan743x_adapter {
 	struct lan743x_sw_nodes	*nodes;
 	struct i2c_adapter	*i2c_adap;
 	struct platform_device	*sfp_dev;
+	struct dw_xpcs		*xpcs;
+	struct phylink		*phylink;
+	struct phylink_config	phylink_config;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
@@ -1203,5 +1210,7 @@ void lan743x_hs_syslock_release(struct lan743x_adapter *adapter);
 void lan743x_mac_flow_ctrl_set_enables(struct lan743x_adapter *adapter,
 				       bool tx_enable, bool rx_enable);
 int lan743x_sgmii_read(struct lan743x_adapter *adapter, u8 mmd, u16 addr);
+void lan743x_mac_cfg_update(struct lan743x_adapter *adapter, bool link,
+			    int speed, const unsigned long *advertise);
 
 #endif /* _LAN743X_H */
-- 
2.34.1

