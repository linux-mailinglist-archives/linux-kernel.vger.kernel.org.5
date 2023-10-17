Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569987CBFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbjJQJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343522AbjJQJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:43:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ABE132;
        Tue, 17 Oct 2023 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697535835; x=1729071835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ba6HwTPkRbCSwIWA3B8GnzRPuOLHu7vKRu2yrTlZQOk=;
  b=p/c948G1V8HU9RO3xqy1dQjFBCp0FDlZ7+oVCzMk7oEtnwMdmzPZ2udI
   RkLG4K90EMtcFreixLJxZH9//qfugKybQxjjdwBu2fd3epbizjtaqDL1K
   vdIp7x2KqFnhhDfbcFP4rzV/I6VfgeLwAKcBlyhHMhDzg5WeiTjq3Skhk
   K3gwEkxgoFUVcrfwKVGw4JLS6QR9MJwKepmnZqnahxwT6vAUhjkTCQqZE
   K5P1rgmcBbBUhe+f1SyH+3dLaHX1JFpMbweK0uEZkmQmlJ5VORRcoxbqY
   PnXx52wcAH5zHiwQ2GwABet6PDYTYGtMcqtLfU2E8w43jladWSoaKb4wp
   w==;
X-CSE-ConnectionGUID: kBNkPMf2TJiKgY0/gLa5lw==
X-CSE-MsgGUID: vyNM9+M4T+iilhqSyYBSGg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="10101624"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2023 02:43:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 17 Oct 2023 02:43:36 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 17 Oct 2023 02:43:33 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <Bryan.Whitehead@microchip.com>, <linux-kernel@vger.kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V1 5/7] net: lan743x: Register the platform device for sfp pluggable module
Date:   Tue, 17 Oct 2023 15:12:06 +0530
Message-ID: <20231017094208.4956-6-Raju.Lakkaraju@microchip.com>
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

Add support for sfp pluggable module as platform device handle the gpio
input and output signals and i2c bus access the sfp eeprom data.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/Kconfig        |  2 +-
 drivers/net/ethernet/microchip/lan743x_main.c | 41 +++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  1 +
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index c50970705e88..f26368b7b834 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -46,12 +46,12 @@ config LAN743X
 	tristate "LAN743x support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
-	select PHYLIB
 	select FIXED_PHY
 	select CRC16
 	select CRC32
 	select I2C_PCI1XXXX
 	select GP_PCI1XXXX
+	select SFP
 	help
 	  Support for the Microchip LAN743x and PCI11x1x families of PCI
 	  Express Ethernet devices
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 71cce7722a21..a4baa00273f7 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -18,6 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio/machine.h>
 #include <linux/auxiliary_bus.h>
+#include <linux/platform_device.h>
 #include "lan743x_main.h"
 #include "lan743x_ethtool.h"
 
@@ -3257,6 +3258,31 @@ static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
 	return software_node_register_node_group(nodes->group);
 }
 
+static int lan743x_sfp_register(struct lan743x_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct platform_device_info sfp_info;
+	struct platform_device *sfp_dev;
+
+	memset(&sfp_info, 0, sizeof(sfp_info));
+	sfp_info.parent = &adapter->pdev->dev;
+	sfp_info.fwnode = software_node_fwnode(adapter->nodes->group[SWNODE_SFP]);
+	sfp_info.name = "sfp";
+	sfp_info.id = (pdev->bus->number << 8) | pdev->devfn;
+	sfp_dev = platform_device_register_full(&sfp_info);
+	if (IS_ERR(sfp_dev)) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "Failed to register SFP device\n");
+		return PTR_ERR(sfp_dev);
+	}
+
+	adapter->sfp_dev = sfp_dev;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "SFP platform device registered");
+
+	return 0;
+}
+
 static int lan743x_netdev_close(struct net_device *netdev)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
@@ -3472,6 +3498,9 @@ static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
 {
 	unregister_netdev(adapter->netdev);
 
+	if (adapter->sfp_dev)
+		platform_device_unregister(adapter->sfp_dev);
+
 	if (adapter->i2c_adap)
 		adapter->i2c_adap = NULL;
 
@@ -3689,6 +3718,18 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 				    NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	adapter->netdev->hw_features = adapter->netdev->features;
 
+	if (adapter->is_sfp_support_en) {
+		adapter->i2c_adap->dev.fwnode =
+			software_node_fwnode(adapter->nodes->group[SWNODE_I2C]);
+
+		ret = lan743x_sfp_register(adapter);
+		if (ret < 0) {
+			netif_err(adapter, probe, netdev,
+				  "failed to sfp register (%d)\n", ret);
+			goto cleanup_hardware;
+		}
+	}
+
 	/* carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(netdev);
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 450d8984cdb5..9746e36baaac 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1082,6 +1082,7 @@ struct lan743x_adapter {
 	phy_interface_t		phy_interface;
 	struct lan743x_sw_nodes	*nodes;
 	struct i2c_adapter	*i2c_adap;
+	struct platform_device	*sfp_dev;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.34.1

