Return-Path: <linux-kernel+bounces-93544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD1D873139
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FAD1F216A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A89660271;
	Wed,  6 Mar 2024 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dph/qRyA"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0955FDAD;
	Wed,  6 Mar 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715094; cv=none; b=dKQi/9LsRuJtDVh/Ezj5aDoCySn8jsBUVXBn2m0CIo17A0ZALhLe4z2QIgs7fq6Y6vlFB8Jy565gz0w8hU2QOGvGihRvMGI1bl2Cfw4vwoR7Pyjk3JMzkxO3rieDd4AsZ1TOs8cKRBl0z9dPMKhMsSW8Y5cTEDOFcLQpa0shkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715094; c=relaxed/simple;
	bh=Mwpdd2KU05HBEyJ3fOew43CT4iawiXS6dxOBjxj34MY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9OtQN9/bd1Bm6S4MFNwMoAIbU+fZGZt8m96ZeDDe/UBBtDUsr7kyYW+xJ+tlvretfLejbrI8o5m1EsAB3O8m/LVODP7zQnxuKQ0OrOX9CS93md1jJ4b84KteI0fOGC6jNhL4TalMKQX9Dm03GmtxoWu6ZyXxQmjgxvCuur0ELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dph/qRyA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709715093; x=1741251093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mwpdd2KU05HBEyJ3fOew43CT4iawiXS6dxOBjxj34MY=;
  b=dph/qRyA6K6rTtTEAvoLcBnWed3v2XPvAhTNwqpN5nIxiVyvWUbbbWB4
   F15Mx6KLtmz7BVY+IDFYKHgOdl9XcsQc0SUh/CZyennx2D05wvNKaqxex
   80q4LZ22XoJVRSTVE3LU5EKvcm4O5X+/XoZ2OUxI7nYEAOFU+IB53Jv2y
   KFJ+91XrHF4kdHFwh8rsld+g18XYIcuqxLmC83lMbpfU/ZsPfxbvvJPYH
   MEeqedPq+G10DOzHYmBrClJ4PuHjjqCp/7Q1VPKX3KkuVx6+f/yYuMVZi
   Psfc7jvr/J0oKrHpKVvTaFN5xSiJ6yuHx9OozjciCJ1GlD/mT/pkXVFvS
   w==;
X-CSE-ConnectionGUID: ploPbevzQGew6QQo7Y/c+g==
X-CSE-MsgGUID: vajZCZ0tTY2nECpsHnSg7A==
X-IronPort-AV: E=Sophos;i="6.06,207,1705388400"; 
   d="scan'208";a="17278633"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 01:51:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 01:51:31 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 01:51:22 -0700
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
Subject: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement internal PHY initialization
Date: Wed, 6 Mar 2024 14:20:11 +0530
Message-ID: <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
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
 drivers/net/ethernet/oa_tc6.c | 160 +++++++++++++++++++++++++++++++++-
 include/linux/oa_tc6.h        |   4 +-
 2 files changed, 162 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index f8593b793291..82b4de13438f 100644
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
 #define OA_TC6_CTRL_HEADER_WRITE		BIT(29)
@@ -46,6 +56,10 @@
 
 /* Internal structure for MAC-PHY drivers */
 struct oa_tc6 {
+	struct device *dev;
+	struct net_device *netdev;
+	struct phy_device *phydev;
+	struct mii_bus *mdiobus;
 	struct spi_device *spi;
 	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
 	void *spi_ctrl_tx_buf;
@@ -298,6 +312,130 @@ int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value)
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
+static int oa_tc6_mdiobus_direct_read(struct mii_bus *bus, int addr, int regnum)
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
+static int oa_tc6_mdiobus_direct_write(struct mii_bus *bus, int addr, int regnum,
+				       u16 val)
+{
+	struct oa_tc6 *tc6 = bus->priv;
+
+	return oa_tc6_write_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
+				     (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),
+				     val);
+}
+
+static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
+{
+	int ret;
+
+	tc6->mdiobus = mdiobus_alloc();
+	if (!tc6->mdiobus) {
+		netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
+		return -ENODEV;
+	}
+
+	tc6->mdiobus->priv = tc6;
+	tc6->mdiobus->read = oa_tc6_mdiobus_direct_read;
+	tc6->mdiobus->write = oa_tc6_mdiobus_direct_write;
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
 static int oa_tc6_read_sw_reset_status(struct oa_tc6 *tc6)
 {
 	u32 regval;
@@ -351,11 +489,12 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
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
@@ -365,6 +504,8 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 		return NULL;
 
 	tc6->spi = spi;
+	tc6->netdev = netdev;
+	SET_NETDEV_DEV(netdev, &spi->dev);
 	mutex_init(&tc6->spi_ctrl_lock);
 
 	/* Set the SPI controller to pump at realtime priority */
@@ -395,10 +536,27 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
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
-- 
2.34.1


