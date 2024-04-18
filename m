Return-Path: <linux-kernel+bounces-150111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC278A9A90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9091C20AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F6A136992;
	Thu, 18 Apr 2024 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PVMwD7TO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880D12FF75;
	Thu, 18 Apr 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445064; cv=none; b=YNG+W4uWQXHv6rlbhviSBkT1L+RJr57U4ET9Qra4I4wLFH9Y98H97H/U04ziNLyI2+JC3UtECPOZOfhsSNC3sEOIbccEDh80neLs6YVHot2SFxfQqTERBpAYG0iiBajgXcIwnGC+AtEy6BQWaa0cwZiXxKIW075cAA/jsSTwkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445064; c=relaxed/simple;
	bh=hMAx3F4EpPhGYFK9B8YTuJqNm5+V4TKLs3OdDNY1mSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oL6mcPV8ITkGsdTw4+Avsco668jJadC+crxLpK5nAoa793/vPGN6X2y9T+ftd4xa94YRoJpHsUW+AOmPqyQLEz7qdsMfUBsKQ8Nv5UquUfyUfVHyHJ2KSzjrvbqfrxz3fsiaKvCuTWA8D9aXo7XHt2KdJyiFdzDID+03Oehih8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PVMwD7TO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713445063; x=1744981063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hMAx3F4EpPhGYFK9B8YTuJqNm5+V4TKLs3OdDNY1mSE=;
  b=PVMwD7TO0dY6r2swm+4DAGFHNiBop1OvZ2t+BZyLsnpS+5kO5EjrhJtJ
   jjZrQFnUcd1l8uM3+N5IoPueMY3xeN9Xz6uW33btpo9ti9b6WiuJOprJF
   dLJ7kIwd227SNEvn0u4FllaBoeRKv+yAmpt2QwNxGpRZ+h1MPyGxFoF2x
   pTKY4t+LH3nRSykApc7SpFt+CPEHwB9rq0WFOYpIxmCqZhjqYScwqh6nn
   Ov41flZXMk4IVUvxuZVhgVKYr0elp6GWH3x1zN0nbi2qloqlWFPkT1M4k
   DogISlxkSOKqCQ7razIqQOgO/8ZUj+XMqkqfWvd2P63e1L88itxWrlbyv
   A==;
X-CSE-ConnectionGUID: buBoWaUbT9SIXw2DlVlEBg==
X-CSE-MsgGUID: Ujrcz+0xSJWTwxS/esqjxA==
X-IronPort-AV: E=Sophos;i="6.07,212,1708412400"; 
   d="scan'208";a="23619641"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 05:57:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 05:57:38 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 05:57:30 -0700
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
Subject: [PATCH net-next v4 06/12] net: ethernet: oa_tc6: implement internal PHY initialization
Date: Thu, 18 Apr 2024 18:26:42 +0530
Message-ID: <20240418125648.372526-7-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Internal PHY is initialized as per the PHY register capability supported
by the MAC-PHY. Direct PHY Register Access Capability indicates if PHY
registers are directly accessible within the SPI register memory space.
Indirect PHY Register Access Capability indicates if PHY registers are
indirectly accessible through the MDIO/MDC registers MDIOACCn defined in
OPEN Alliance specification. Currently the direct register access is only
supported.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c   | 230 +++++++++++++++++++++++++++++++-
 drivers/net/phy/microchip_t1s.c |  30 +++++
 include/linux/oa_tc6.h          |   4 +-
 include/uapi/linux/mdio.h       |   1 +
 4 files changed, 263 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 850765574d30..f04c4c13e8d3 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -7,9 +7,15 @@
 
 #include <linux/bitfield.h>
 #include <linux/iopoll.h>
+#include <linux/mdio.h>
+#include <linux/phy.h>
 #include <linux/oa_tc6.h>
 
 /* OPEN Alliance TC6 registers */
+/* Standard Capabilities Register */
+#define OA_TC6_REG_STDCAP			0x0002
+#define STDCAP_DIRECT_PHY_REG_ACCESS		BIT(8)
+
 /* Reset Control and Status Register */
 #define OA_TC6_REG_RESET			0x0003
 #define RESET_SWRESET				BIT(0)	/* Software Reset */
@@ -25,6 +31,10 @@
 #define INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK	BIT(3)
 #define INT_MASK0_TX_PROTOCOL_ERR_MASK		BIT(0)
 
+/* PHY Clause 22 and 29 registers base address and mask */
+#define OA_TC6_PHY_STD_REG_ADDR_BASE		0xFF00
+#define OA_TC6_PHY_STD_REG_ADDR_MASK		0x3F
+
 /* Control command header */
 #define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
 #define OA_TC6_CTRL_HEADER_WRITE_NOT_READ	BIT(29)
@@ -33,6 +43,15 @@
 #define OA_TC6_CTRL_HEADER_LENGTH		GENMASK(7, 1)
 #define OA_TC6_CTRL_HEADER_PARITY		BIT(0)
 
+/* PHY – Clause 45 registers memory map selector (MMS) as per table 6 in the
+ * OPEN Alliance specification.
+ */
+#define OA_TC6_PHY_C45_PCS_MMS2			2	/* MMD 3 */
+#define OA_TC6_PHY_C45_PMA_PMD_MMS3		3	/* MMD 1 */
+#define OA_TC6_PHY_C45_VS_PLCA_MMS4		4	/* MMD 31 */
+#define OA_TC6_PHY_C45_AUTO_NEG_MMS5		5	/* MMD 7 */
+#define OA_TC6_PHY_C45_POWER_UNIT_MMS6		6	/* MMD 13 */
+
 #define OA_TC6_CTRL_HEADER_SIZE			4
 #define OA_TC6_CTRL_REG_VALUE_SIZE		4
 #define OA_TC6_CTRL_IGNORED_SIZE		4
@@ -46,6 +65,10 @@
 
 /* Internal structure for MAC-PHY drivers */
 struct oa_tc6 {
+	struct device *dev;
+	struct net_device *netdev;
+	struct phy_device *phydev;
+	struct mii_bus *mdiobus;
 	struct spi_device *spi;
 	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
 	void *spi_ctrl_tx_buf;
@@ -298,6 +321,191 @@ int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_write_register);
 
+static int oa_tc6_check_phy_reg_direct_access_capability(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STDCAP, &regval);
+	if (ret)
+		return ret;
+
+	if (!(regval & STDCAP_DIRECT_PHY_REG_ACCESS))
+		return -ENODEV;
+
+	return 0;
+}
+
+static void oa_tc6_handle_link_change(struct net_device *netdev)
+{
+	phy_print_status(netdev->phydev);
+}
+
+static int oa_tc6_mdiobus_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct oa_tc6 *tc6 = bus->priv;
+	u32 regval;
+	bool ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
+				   (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),
+				   &regval);
+	if (ret)
+		return -ENODEV;
+
+	return regval;
+}
+
+static int oa_tc6_mdiobus_write(struct mii_bus *bus, int addr, int regnum,
+				u16 val)
+{
+	struct oa_tc6 *tc6 = bus->priv;
+
+	return oa_tc6_write_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
+				     (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),
+				     val);
+}
+
+static int oa_tc6_get_phy_c45_mms(int devnum)
+{
+	switch (devnum) {
+	case MDIO_MMD_PCS:
+		return OA_TC6_PHY_C45_PCS_MMS2;
+	case MDIO_MMD_PMAPMD:
+		return OA_TC6_PHY_C45_PMA_PMD_MMS3;
+	case MDIO_MMD_VEND2:
+		return OA_TC6_PHY_C45_VS_PLCA_MMS4;
+	case MDIO_MMD_AN:
+		return OA_TC6_PHY_C45_AUTO_NEG_MMS5;
+	case MDIO_MMD_POWER_UNIT:
+		return OA_TC6_PHY_C45_POWER_UNIT_MMS6;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
+				   int regnum)
+{
+	struct oa_tc6 *tc6 = bus->priv;
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_get_phy_c45_mms(devnum);
+	if (ret < 0)
+		return ret;
+
+	ret = oa_tc6_read_register(tc6, (ret << 16) | regnum, &regval);
+	if (ret)
+		return ret;
+
+	return regval;
+}
+
+static int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
+				    int regnum, u16 val)
+{
+	struct oa_tc6 *tc6 = bus->priv;
+	int ret;
+
+	ret = oa_tc6_get_phy_c45_mms(devnum);
+	if (ret < 0)
+		return ret;
+
+	return oa_tc6_write_register(tc6, (ret << 16) | regnum, val);
+}
+
+static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
+{
+	int ret;
+
+	tc6->mdiobus = mdiobus_alloc();
+	if (!tc6->mdiobus) {
+		netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
+		return -ENOMEM;
+	}
+
+	tc6->mdiobus->priv = tc6;
+	tc6->mdiobus->read = oa_tc6_mdiobus_read;
+	tc6->mdiobus->write = oa_tc6_mdiobus_write;
+	/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
+	 * C45 registers space. If the PHY is discovered via C22 bus protocol it
+	 * assumes it uses C22 protocol and always uses C22 registers indirect
+	 * access to access C45 registers. This is because, we don't have a
+	 * clean separation between C22/C45 register space and C22/C45 MDIO bus
+	 * protocols. Resulting, PHY C45 registers direct access can't be used
+	 * which can save multiple SPI bus access. To support this feature, PHY
+	 * drivers can set .read_mmd/.write_mmd in the PHY driver to call
+	 * .read_c45/.write_c45. Ex: drivers/net/phy/microchip_t1s.c
+	 */
+	tc6->mdiobus->read_c45 = oa_tc6_mdiobus_read_c45;
+	tc6->mdiobus->write_c45 = oa_tc6_mdiobus_write_c45;
+	tc6->mdiobus->name = "oa-tc6-mdiobus";
+	tc6->mdiobus->parent = tc6->dev;
+
+	snprintf(tc6->mdiobus->id, ARRAY_SIZE(tc6->mdiobus->id), "%s",
+		 dev_name(&tc6->spi->dev));
+
+	ret = mdiobus_register(tc6->mdiobus);
+	if (ret) {
+		netdev_err(tc6->netdev, "Could not register MDIO bus\n");
+		mdiobus_free(tc6->mdiobus);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void oa_tc6_mdiobus_unregister(struct oa_tc6 *tc6)
+{
+	mdiobus_unregister(tc6->mdiobus);
+	mdiobus_free(tc6->mdiobus);
+}
+
+static int oa_tc6_phy_init(struct oa_tc6 *tc6)
+{
+	int ret;
+
+	ret = oa_tc6_check_phy_reg_direct_access_capability(tc6);
+	if (ret) {
+		netdev_err(tc6->netdev,
+			   "Direct PHY register access is not supported by the MAC-PHY\n");
+		return ret;
+	}
+
+	ret = oa_tc6_mdiobus_register(tc6);
+	if (ret)
+		return ret;
+
+	tc6->phydev = phy_find_first(tc6->mdiobus);
+	if (!tc6->phydev) {
+		netdev_err(tc6->netdev, "No PHY found\n");
+		oa_tc6_mdiobus_unregister(tc6);
+		return -ENODEV;
+	}
+
+	tc6->phydev->is_internal = true;
+	ret = phy_connect_direct(tc6->netdev, tc6->phydev,
+				 &oa_tc6_handle_link_change,
+				 PHY_INTERFACE_MODE_INTERNAL);
+	if (ret) {
+		netdev_err(tc6->netdev, "Can't attach PHY to %s\n",
+			   tc6->mdiobus->id);
+		oa_tc6_mdiobus_unregister(tc6);
+		return ret;
+	}
+
+	phy_attached_info(tc6->netdev->phydev);
+
+	return 0;
+}
+
+static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
+{
+	phy_disconnect(tc6->phydev);
+	oa_tc6_mdiobus_unregister(tc6);
+}
+
 static int oa_tc6_read_status0(struct oa_tc6 *tc6)
 {
 	u32 regval;
@@ -351,11 +559,12 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
+ * @netdev: network device interface structure.
  *
  * Returns pointer reference to the oa_tc6 structure if the MAC-PHY
  * initialization is successful otherwise NULL.
  */
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 {
 	struct oa_tc6 *tc6;
 	int ret;
@@ -365,6 +574,8 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 		return NULL;
 
 	tc6->spi = spi;
+	tc6->netdev = netdev;
+	SET_NETDEV_DEV(netdev, &spi->dev);
 	mutex_init(&tc6->spi_ctrl_lock);
 
 	/* Set the SPI controller to pump at realtime priority */
@@ -395,10 +606,27 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 		return NULL;
 	}
 
+	ret = oa_tc6_phy_init(tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev,
+			"MAC internal PHY initialization failed: %d\n", ret);
+		return NULL;
+	}
+
 	return tc6;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
 
+/**
+ * oa_tc6_exit - exit function.
+ * @tc6: oa_tc6 struct.
+ */
+void oa_tc6_exit(struct oa_tc6 *tc6)
+{
+	oa_tc6_phy_exit(tc6);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_exit);
+
 MODULE_DESCRIPTION("OPEN Alliance 10BASE‑T1x MAC‑PHY Serial Interface Lib");
 MODULE_AUTHOR("Parthiban Veerasooran <parthiban.veerasooran@microchip.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 534ca7d1b061..769a88254285 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -268,6 +268,34 @@ static int lan86xx_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
+ * C45 registers space. If the PHY is discovered via C22 bus protocol it assumes
+ * it uses C22 protocol and always uses C22 registers indirect access to access
+ * C45 registers. This is because, we don't have a clean separation between
+ * C22/C45 register space and C22/C45 MDIO bus protocols. Resulting, PHY C45
+ * registers direct access can't be used which can save multiple SPI bus access.
+ * To support this feature, set .read_mmd/.write_mmd in the PHY driver to call
+ * .read_c45/.write_c45 in the OPEN Alliance framework
+ * drivers/net/ethernet/oa_tc6.c
+ */
+static int lan865x_phy_read_mmd(struct phy_device *phydev, int devnum,
+				u16 regnum)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return bus->read_c45(bus, addr, devnum, regnum);
+}
+
+static int lan865x_phy_write_mmd(struct phy_device *phydev, int devnum,
+				 u16 regnum, u16 val)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return bus->write_c45(bus, addr, devnum, regnum, val);
+}
+
 static struct phy_driver microchip_t1s_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
@@ -285,6 +313,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan865x_revb0_config_init,
 		.read_status        = lan86xx_read_status,
+		.read_mmd           = lan865x_phy_read_mmd,
+		.write_mmd          = lan865x_phy_write_mmd,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 85aeecf87306..606ba9f1e663 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -7,11 +7,13 @@
  * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
  */
 
+#include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 
 struct oa_tc6;
 
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi);
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev);
+void oa_tc6_exit(struct oa_tc6 *tc6);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value);
 int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 			   u8 length);
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index c0c8ec995b06..f0d3f268240d 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -23,6 +23,7 @@
 #define MDIO_MMD_DTEXS		5	/* DTE Extender Sublayer */
 #define MDIO_MMD_TC		6	/* Transmission Convergence */
 #define MDIO_MMD_AN		7	/* Auto-Negotiation */
+#define MDIO_MMD_POWER_UNIT	13	/* PHY Power Unit */
 #define MDIO_MMD_C22EXT		29	/* Clause 22 extension */
 #define MDIO_MMD_VEND1		30	/* Vendor specific 1 */
 #define MDIO_MMD_VEND2		31	/* Vendor specific 2 */
-- 
2.34.1


