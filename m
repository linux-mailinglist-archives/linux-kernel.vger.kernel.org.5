Return-Path: <linux-kernel+bounces-93551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF83873172
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576041F2157F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB295F869;
	Wed,  6 Mar 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vuL/ruha"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA435D8EA;
	Wed,  6 Mar 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715182; cv=none; b=Ut7s9Eei0MS3jnEyZOgE5pAGYln3/5SlOS7ti3segBT1Av1OX5CrxMbHejVP+KMsmCQiX5HIH2OSCSrYFblWFT/KVHl4ugbbwF9wMeerj6iD2h/KFOS0oERDs4gnY6Qfsa9FibdV+Qh20QrCRqo842myvLcpu1RcpXwGysEjwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715182; c=relaxed/simple;
	bh=0V+FdkudyMrb9hsJWXPvgznXHBT+oKQDh+0RKZgsok4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXE7EFTJzaOsdBCeY1aiRxRBi1UXAzvkJrI92OEIUMgYHm3YdTdNDtN/d3kj21gd4pFcUu7XTfzWFkfpCIU/SOukKPBzINZNm3TRFHbYR0xaeYs6pzC5naaTvtQm0lbqqsBiRtoVQKDIJ+IvcwGjXiQiNuCgQKdqA9UpkIXHhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vuL/ruha; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709715180; x=1741251180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0V+FdkudyMrb9hsJWXPvgznXHBT+oKQDh+0RKZgsok4=;
  b=vuL/ruhaUEk4A72Cm9PBAhaYYKdOMnSHvIHDNq3HG46NEk79mKCTqalk
   5VlXt5zn30Hxq1HSAxoZc57ayRBuDtTpUsiXlfrDSye7PpLKg8L6DHsMa
   1LgMTGNBRS0fyFtbAC5RRpmIglWSLKZHJC3hb9bInIlNTadPyh46sjH8R
   PQmS2ckV24CAIFWvhOEEnH62gmyDog+/9QGjgM5XP6G51h8Cwh/gZWmv4
   pN5IYlRXo8ix3mWmn3oN5pTYIaaCXirImLbidoShiUdHe5PoFRRtoQxXE
   WClyvCl1UxwxcnqqFZqnjgp+iCzxWODG9R3bxIeZVwwVhSdsQ4YgHMnwl
   Q==;
X-CSE-ConnectionGUID: cO76qCGVTh6esswCB3LBdA==
X-CSE-MsgGUID: 2VoiqRHsRl+BHBBtBnF3TQ==
X-IronPort-AV: E=Sophos;i="6.06,207,1705388400"; 
   d="scan'208";a="18916180"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 01:52:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 01:52:19 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 01:52:10 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v3 11/12] microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY
Date: Wed, 6 Mar 2024 14:20:16 +0530
Message-ID: <20240306085017.21731-12-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE-T1x
MAC-PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
MAC integration provides the low pin count standard SPI interface to any
microcontroller therefore providing Ethernet functionality without
requiring MAC integration within the microcontroller. The LAN8650/1
operates as an SPI client supporting SCLK clock rates up to a maximum of
25 MHz. This SPI interface supports the transfer of both data (Ethernet
frames) and control (register access).

By default, the chunk data payload is 64 bytes in size. The Ethernet
Media Access Controller (MAC) module implements a 10 Mbps half duplex
Ethernet MAC, compatible with the IEEE 802.3 standard. 10BASE-T1S
physical layer transceiver integrated is into the LAN8650/1. The PHY and
MAC are connected via an internal Media Independent Interface (MII).

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 MAINTAINERS                                   |   6 +
 drivers/net/ethernet/microchip/Kconfig        |   1 +
 drivers/net/ethernet/microchip/Makefile       |   1 +
 .../net/ethernet/microchip/lan865x/Kconfig    |  19 +
 .../net/ethernet/microchip/lan865x/Makefile   |   6 +
 .../net/ethernet/microchip/lan865x/lan865x.c  | 350 ++++++++++++++++++
 6 files changed, 383 insertions(+)
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Kconfig
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Makefile
 create mode 100644 drivers/net/ethernet/microchip/lan865x/lan865x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 603528948f61..f41b7f2257d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14374,6 +14374,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
+M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/microchip/lan865x/lan865x.c
+
 MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
 M:	Arun Ramadoss <arun.ramadoss@microchip.com>
 R:	UNGLinuxDriver@microchip.com
diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 43ba71e82260..06ca79669053 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -56,6 +56,7 @@ config LAN743X
 	  To compile this driver as a module, choose M here. The module will be
 	  called lan743x.
 
+source "drivers/net/ethernet/microchip/lan865x/Kconfig"
 source "drivers/net/ethernet/microchip/lan966x/Kconfig"
 source "drivers/net/ethernet/microchip/sparx5/Kconfig"
 source "drivers/net/ethernet/microchip/vcap/Kconfig"
diff --git a/drivers/net/ethernet/microchip/Makefile b/drivers/net/ethernet/microchip/Makefile
index bbd349264e6f..15dfbb321057 100644
--- a/drivers/net/ethernet/microchip/Makefile
+++ b/drivers/net/ethernet/microchip/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_LAN743X) += lan743x.o
 
 lan743x-objs := lan743x_main.o lan743x_ethtool.o lan743x_ptp.o
 
+obj-$(CONFIG_LAN865X) += lan865x/
 obj-$(CONFIG_LAN966X_SWITCH) += lan966x/
 obj-$(CONFIG_SPARX5_SWITCH) += sparx5/
 obj-$(CONFIG_VCAP) += vcap/
diff --git a/drivers/net/ethernet/microchip/lan865x/Kconfig b/drivers/net/ethernet/microchip/lan865x/Kconfig
new file mode 100644
index 000000000000..f3d60d14e202
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan865x/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Microchip LAN865x Driver Support
+#
+
+if NET_VENDOR_MICROCHIP
+
+config LAN865X
+	tristate "LAN865x support"
+	depends on SPI
+	depends on OA_TC6
+	help
+	  Support for the Microchip LAN8650/1 Rev.B1 MACPHY Ethernet chip. It
+	  uses OPEN Alliance 10BASE-T1x Serial Interface specification.
+
+	  To compile this driver as a module, choose M here. The module will be
+	  called lan865x.
+
+endif # NET_VENDOR_MICROCHIP
diff --git a/drivers/net/ethernet/microchip/lan865x/Makefile b/drivers/net/ethernet/microchip/lan865x/Makefile
new file mode 100644
index 000000000000..9f5dd89c1eb8
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan865x/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the Microchip LAN865x Driver
+#
+
+obj-$(CONFIG_LAN865X) += lan865x.o
diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
new file mode 100644
index 000000000000..8f265227f75a
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Microchip's LAN865x 10BASE-T1S MAC-PHY driver
+ *
+ * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/phy.h>
+#include <linux/oa_tc6.h>
+
+#define DRV_NAME			"lan865x"
+
+/* MAC Network Control Register */
+#define LAN865X_REG_MAC_NET_CTL		0x00010000
+#define MAC_NET_CTL_TXEN		BIT(3) /* Transmit Enable */
+#define MAC_NET_CTL_RXEN		BIT(2) /* Receive Enable */
+
+#define LAN865X_REG_MAC_NET_CFG		0x00010001 /* MAC Network Configuration Reg */
+#define MAC_NET_CFG_PROMISCUOUS_MODE	BIT(4)
+#define MAC_NET_CFG_MULTICAST_MODE	BIT(6)
+#define MAC_NET_CFG_UNICAST_MODE	BIT(7)
+
+#define LAN865X_REG_MAC_L_HASH		0x00010020 /* MAC Hash Register Bottom */
+#define LAN865X_REG_MAC_H_HASH		0x00010021 /* MAC Hash Register Top */
+#define LAN865X_REG_MAC_L_SADDR1	0x00010022 /* MAC Specific Addr 1 Bottom Reg */
+#define LAN865X_REG_MAC_H_SADDR1	0x00010023 /* MAC Specific Addr 1 Top Reg */
+
+struct lan865x_priv {
+	struct work_struct multicast_work;
+	struct net_device *netdev;
+	struct spi_device *spi;
+	struct oa_tc6 *tc6;
+};
+
+static int lan865x_set_hw_macaddr_low_bytes(struct oa_tc6 *tc6, const u8 *mac)
+{
+	u32 regval;
+
+	regval = (mac[3] << 24) | (mac[2] << 16) | (mac[1] << 8) | mac[0];
+
+	return oa_tc6_write_register(tc6, LAN865X_REG_MAC_L_SADDR1, regval);
+}
+
+static int lan865x_set_hw_macaddr(struct lan865x_priv *priv, const u8 *mac)
+{
+	int restore_ret;
+	u32 regval;
+	int ret;
+
+	/* Configure MAC address low bytes */
+	ret = lan865x_set_hw_macaddr_low_bytes(priv->tc6, mac);
+	if (ret)
+		return ret;
+
+	/* Prepare and configure MAC address high bytes */
+	regval = (mac[5] << 8) | mac[4];
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_SADDR1, regval);
+	if (!ret)
+		return 0;
+
+	/* Restore the old MAC address low bytes from netdev if the new MAC
+	 * address high bytes setting failed.
+	 */
+	restore_ret = lan865x_set_hw_macaddr_low_bytes(priv->tc6,
+						       priv->netdev->dev_addr);
+	if (restore_ret)
+		return restore_ret;
+
+	return ret;
+}
+
+static void
+lan865x_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->bus_info, dev_name(netdev->dev.parent),
+		sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops lan865x_ethtool_ops = {
+	.get_drvinfo        = lan865x_get_drvinfo,
+	.get_link_ksettings = phy_ethtool_get_link_ksettings,
+	.set_link_ksettings = phy_ethtool_set_link_ksettings,
+};
+
+static int lan865x_set_mac_address(struct net_device *netdev, void *addr)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	struct sockaddr *address = addr;
+	int ret;
+
+	ret = eth_prepare_mac_addr_change(netdev, addr);
+	if (ret < 0)
+		return ret;
+
+	if (ether_addr_equal(address->sa_data, netdev->dev_addr))
+		return 0;
+
+	ret = lan865x_set_hw_macaddr(priv, address->sa_data);
+	if (ret)
+		return ret;
+
+	eth_hw_addr_set(netdev, address->sa_data);
+
+	return 0;
+}
+
+static u32 lan865x_hash(u8 addr[ETH_ALEN])
+{
+	return (ether_crc(ETH_ALEN, addr) >> 26) & GENMASK(5, 0);
+}
+
+static void lan865x_set_specific_multicast_addr(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	struct netdev_hw_addr *ha;
+	u32 hash_lo = 0;
+	u32 hash_hi = 0;
+
+	netdev_for_each_mc_addr(ha, netdev) {
+		u32 bit_num = lan865x_hash(ha->addr);
+		u32 mask = BIT(bit_num);
+
+		/* 5th bit of the 6 bits hash value is used to determine which
+		 * bit to set in either a high or low hash register.
+		 */
+		if (bit_num & BIT(5))
+			hash_hi |= mask;
+		else
+			hash_lo |= mask;
+	}
+
+	/* Enabling specific multicast addresses */
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH, hash_hi)) {
+		netdev_err(netdev, "Failed to write reg_hashh");
+		return;
+	}
+
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH, hash_lo))
+		netdev_err(netdev, "Failed to write reg_hashl");
+}
+
+static void lan865x_multicast_work_handler(struct work_struct *work)
+{
+	struct lan865x_priv *priv = container_of(work, struct lan865x_priv,
+						 multicast_work);
+	u32 regval = 0;
+
+	if (priv->netdev->flags & IFF_PROMISC) {
+		/* Enabling promiscuous mode */
+		regval |= MAC_NET_CFG_PROMISCUOUS_MODE;
+		regval &= (~MAC_NET_CFG_MULTICAST_MODE);
+		regval &= (~MAC_NET_CFG_UNICAST_MODE);
+	} else if (priv->netdev->flags & IFF_ALLMULTI) {
+		/* Enabling all multicast mode */
+		regval &= (~MAC_NET_CFG_PROMISCUOUS_MODE);
+		regval |= MAC_NET_CFG_MULTICAST_MODE;
+		regval &= (~MAC_NET_CFG_UNICAST_MODE);
+	} else if (!netdev_mc_empty(priv->netdev)) {
+		lan865x_set_specific_multicast_addr(priv->netdev);
+		regval &= (~MAC_NET_CFG_PROMISCUOUS_MODE);
+		regval &= (~MAC_NET_CFG_MULTICAST_MODE);
+		regval |= MAC_NET_CFG_UNICAST_MODE;
+	} else {
+		/* enabling local mac address only */
+		if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH,
+					  regval)) {
+			netdev_err(priv->netdev, "Failed to write reg_hashh");
+			return;
+		}
+		if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH,
+					  regval)) {
+			netdev_err(priv->netdev, "Failed to write reg_hashl");
+			return;
+		}
+	}
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CFG, regval))
+		netdev_err(priv->netdev,
+			   "Failed to enable promiscuous/multicast/normal mode");
+}
+
+static void lan865x_set_multicast_list(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+
+	schedule_work(&priv->multicast_work);
+}
+
+static netdev_tx_t lan865x_send_packet(struct sk_buff *skb,
+				       struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+
+	return oa_tc6_start_xmit(priv->tc6, skb);
+}
+
+static int lan865x_hw_disable(struct lan865x_priv *priv)
+{
+	u32 regval;
+
+	if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, &regval))
+		return -ENODEV;
+
+	regval &= ~(MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN);
+
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int lan865x_net_close(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	int ret;
+
+	netif_stop_queue(netdev);
+	phy_stop(netdev->phydev);
+	ret = lan865x_hw_disable(priv);
+	if (ret) {
+		netdev_err(netdev, "Failed to disable the hardware: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lan865x_hw_enable(struct lan865x_priv *priv)
+{
+	u32 regval;
+
+	if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, &regval))
+		return -ENODEV;
+
+	regval |= MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN;
+
+	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int lan865x_net_open(struct net_device *netdev)
+{
+	struct lan865x_priv *priv = netdev_priv(netdev);
+	int ret;
+
+	ret = lan865x_hw_enable(priv);
+	if (ret) {
+		netdev_err(netdev, "Failed to enable hardware: %d\n", ret);
+		return ret;
+	}
+
+	phy_start(netdev->phydev);
+
+	return 0;
+}
+
+static const struct net_device_ops lan865x_netdev_ops = {
+	.ndo_open		= lan865x_net_open,
+	.ndo_stop		= lan865x_net_close,
+	.ndo_start_xmit		= lan865x_send_packet,
+	.ndo_set_rx_mode	= lan865x_set_multicast_list,
+	.ndo_set_mac_address	= lan865x_set_mac_address,
+};
+
+static int lan865x_probe(struct spi_device *spi)
+{
+	struct net_device *netdev;
+	struct lan865x_priv *priv;
+	int ret;
+
+	netdev = alloc_etherdev(sizeof(struct lan865x_priv));
+	if (!netdev)
+		return -ENOMEM;
+
+	priv = netdev_priv(netdev);
+	priv->netdev = netdev;
+	priv->spi = spi;
+	spi_set_drvdata(spi, priv);
+	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
+
+	priv->tc6 = oa_tc6_init(spi, netdev);
+	if (!priv->tc6) {
+		ret = -ENODEV;
+		goto free_netdev;
+	}
+
+	/* Get the MAC address from the SPI device tree node */
+	if (device_get_ethdev_address(&spi->dev, netdev))
+		eth_hw_addr_random(netdev);
+
+	ret = lan865x_set_hw_macaddr(priv, netdev->dev_addr);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to configure MAC");
+		goto oa_tc6_exit;
+	}
+
+	netdev->if_port = IF_PORT_10BASET;
+	netdev->irq = spi->irq;
+	netdev->netdev_ops = &lan865x_netdev_ops;
+	netdev->ethtool_ops = &lan865x_ethtool_ops;
+
+	ret = register_netdev(netdev);
+	if (ret) {
+		dev_err(&spi->dev, "Register netdev failed (ret = %d)", ret);
+		goto oa_tc6_exit;
+	}
+
+	return 0;
+
+oa_tc6_exit:
+	oa_tc6_exit(priv->tc6);
+free_netdev:
+	free_netdev(priv->netdev);
+	return ret;
+}
+
+static void lan865x_remove(struct spi_device *spi)
+{
+	struct lan865x_priv *priv = spi_get_drvdata(spi);
+
+	cancel_work_sync(&priv->multicast_work);
+	unregister_netdev(priv->netdev);
+	oa_tc6_exit(priv->tc6);
+	free_netdev(priv->netdev);
+}
+
+static const struct of_device_id lan865x_dt_ids[] = {
+	{ .compatible = "microchip,lan8650" },
+	{ .compatible = "microchip,lan8651" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
+
+static struct spi_driver lan865x_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = lan865x_dt_ids,
+	 },
+	.probe = lan865x_probe,
+	.remove = lan865x_remove,
+};
+module_spi_driver(lan865x_driver);
+
+MODULE_DESCRIPTION(DRV_NAME " 10Base-T1S MACPHY Ethernet Driver");
+MODULE_AUTHOR("Parthiban Veerasooran <parthiban.veerasooran@microchip.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1


