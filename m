Return-Path: <linux-kernel+bounces-29757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C40E8312FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C045A283180
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91936134BC;
	Thu, 18 Jan 2024 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LHKL1ZIO"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220CC9467;
	Thu, 18 Jan 2024 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561846; cv=none; b=EbuPpAAr+AwvAdTHNv/WiZUN0V9SVK7p2XHNWzBIsX2ePqXWoODQJY2UslTsVviBODUHwbqqF8y7ykWWgShBOXUYSVQtuVm2sSRhzmobrtGIb/R1TdCBxdri1G1MKQ3EnBwLG/n/9ZKJuNANfyEjVskQH7YIhY9DYtHOi7s8idM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561846; c=relaxed/simple;
	bh=Bc7mvUtlN6MAEmaacOQ0aOMxxPe0DgY6fycEziccILU=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EXCLAIMER-MD-CONFIG; b=MsAKBkadhGPHqpko/1KiughXPOPEHyTS/7Yen8QMji4uDHpJacsT5oZtQGgUF2GevxccUxWc4YBaIwPvEGQ2Tsz72kjc0MKYxerXysNBpZOtM50vScTZNAt39IEqBTAcYMMxbun74wsJpejnvNXh8GEjd4BwWr9TkJlRYz/SwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LHKL1ZIO; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40I7AGsG042714;
	Thu, 18 Jan 2024 01:10:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705561816;
	bh=75YE61j0r+1Dfa+4E/8fFRXBLgRCFdakLw0N5VLdBxc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LHKL1ZIOmyKXhVCPt78BI9Yrrn9CthdGWFWSH8YQnnllAt4HGl3N8d3SDfs5daB6t
	 bfgGAaNK2gySH+vigzBuCz9vNdAxnVidsnkEWp/NfstfNyD+YwjIX9h/bvIPyOoET1
	 O6lcPzx14QdZuRLCyJ3StZJN+vB5KQ7drfVkT1ZE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40I7AGnc011441
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 01:10:16 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jan 2024 01:10:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jan 2024 01:10:15 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40I7AFQE025485;
	Thu, 18 Jan 2024 01:10:15 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40I7AEWZ021983;
	Thu, 18 Jan 2024 01:10:15 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        "Vladimir
 Oltean" <vladimir.oltean@nxp.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Grygorii
 Strashko" <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Eric
 Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v2 3/3] net: ti: icssg-prueth: Add support for ICSSG switch firmware
Date: Thu, 18 Jan 2024 12:40:05 +0530
Message-ID: <20240118071005.1514498-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118071005.1514498-1-danishanwar@ti.com>
References: <20240118071005.1514498-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add support for ICSSG switch firmware using existing Dual EMAC driver
with switchdev.

Limitations:
VLAN offloading is limited to 0-256 IDs.
MDB/FDB static entries are limited to 511 entries and different FDBs can
hash to same bucket and thus may not completely offloaded

Switch mode requires loading of new firmware into ICSSG cores. This
means interfaces have to taken down and then reconfigured to switch
mode.

Example assuming ETH1 and ETH2 as ICSSG2 interfaces:

Switch to ICSSG Switch mode:
 ip link set dev eth1 down
 ip link set dev eth2 down
 ip link add name br0 type bridge
 ip link set dev eth1 master br0
 ip link set dev eth2 master br0
 ip link set dev br0 up
 ip link set dev eth1 up
 ip link set dev eth2 up
 bridge vlan add dev br0 vid 1 pvid untagged self

Going back to Dual EMAC mode:

 ip link set dev br0 down
 ip link set dev eth1 nomaster
 ip link set dev eth2 nomaster
 ip link set dev eth1 down
 ip link set dev eth2 down
 ip link del name br0 type bridge
 ip link set dev eth1 up
 ip link set dev eth2 up

By default, Dual EMAC firmware is loaded, and can be changed to switch
mode by above steps

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/Makefile              |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c  | 136 +++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   7 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 198 +++++++++++++++++-
 .../net/ethernet/ti/icssg/icssg_switchdev.c   |   2 +-
 6 files changed, 333 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index be01450c20dc..c72f26828b04 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -188,6 +188,7 @@ config TI_ICSSG_PRUETH
 	select TI_ICSS_IEP
 	select TI_K3_CPPI_DESC_POOL
 	depends on PRU_REMOTEPROC
+	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index d8590304f3df..d295bded7a32 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -38,5 +38,6 @@ icssg-prueth-y := icssg/icssg_prueth.o \
 		  icssg/icssg_config.o \
 		  icssg/icssg_mii_cfg.o \
 		  icssg/icssg_stats.o \
-		  icssg/icssg_ethtool.o
+		  icssg/icssg_ethtool.o \
+		  icssg/icssg_switchdev.o
 obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index afc10014ec03..eda08a87c902 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -105,28 +105,49 @@ static const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
 	},
 };
 
+static void icssg_config_mii_init_switch(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	int mii = prueth_emac_slice(emac);
+	u32 txcfg_reg, pcnt_reg, txcfg;
+	struct regmap *mii_rt;
+
+	mii_rt = prueth->mii_rt;
+
+	txcfg_reg = (mii == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
+				       PRUSS_MII_RT_TXCFG1;
+	pcnt_reg = (mii == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
+				       PRUSS_MII_RT_RX_PCNT1;
+
+	txcfg = PRUSS_MII_RT_TXCFG_TX_ENABLE |
+		PRUSS_MII_RT_TXCFG_TX_AUTO_PREAMBLE |
+		PRUSS_MII_RT_TXCFG_TX_IPG_WIRE_CLK_EN;
+
+	if (emac->phy_if == PHY_INTERFACE_MODE_MII && mii == ICSS_MII1)
+		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
+	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && mii == ICSS_MII0)
+		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
+
+	regmap_write(mii_rt, txcfg_reg, txcfg);
+	regmap_write(mii_rt, pcnt_reg, 0x1);
+}
+
 static void icssg_config_mii_init(struct prueth_emac *emac)
 {
-	u32 rxcfg, txcfg, rxcfg_reg, txcfg_reg, pcnt_reg;
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
+	u32 txcfg, txcfg_reg, pcnt_reg;
 	struct regmap *mii_rt;
 
 	mii_rt = prueth->mii_rt;
 
-	rxcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RXCFG0 :
-				       PRUSS_MII_RT_RXCFG1;
 	txcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
 				       PRUSS_MII_RT_TXCFG1;
 	pcnt_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
 				       PRUSS_MII_RT_RX_PCNT1;
 
-	rxcfg = MII_RXCFG_DEFAULT;
 	txcfg = MII_TXCFG_DEFAULT;
 
-	if (slice == ICSS_MII1)
-		rxcfg |= PRUSS_MII_RT_RXCFG_RX_MUX_SEL;
-
 	/* In MII mode TX lines swapped inside ICSSG, so TX_MUX_SEL cfg need
 	 * to be swapped also comparing to RGMII mode.
 	 */
@@ -135,7 +156,6 @@ static void icssg_config_mii_init(struct prueth_emac *emac)
 	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && slice == ICSS_MII1)
 		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
 
-	regmap_write(mii_rt, rxcfg_reg, rxcfg);
 	regmap_write(mii_rt, txcfg_reg, txcfg);
 	regmap_write(mii_rt, pcnt_reg, 0x1);
 }
@@ -249,6 +269,66 @@ static int emac_r30_is_done(struct prueth_emac *emac)
 	return 1;
 }
 
+static int prueth_switch_buffer_setup(struct prueth_emac *emac)
+{
+	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
+	struct icssg_rxq_ctx __iomem *rxq_ctx;
+	struct prueth *prueth = emac->prueth;
+	int slice = prueth_emac_slice(emac);
+	u32 addr;
+	int i;
+
+	addr = lower_32_bits(prueth->msmcram.pa);
+	if (slice)
+		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
+
+	if (addr % SZ_64K) {
+		dev_warn(prueth->dev, "buffer pool needs to be 64KB aligned\n");
+		return -EINVAL;
+	}
+
+	bpool_cfg = emac->dram.va + BUFFER_POOL_0_ADDR_OFFSET;
+	/* workaround for f/w bug. bpool 0 needs to be initilalized */
+	for (i = 0; i <  PRUETH_NUM_BUF_POOLS; i++) {
+		writel(addr, &bpool_cfg[i].addr);
+		writel(PRUETH_EMAC_BUF_POOL_SIZE, &bpool_cfg[i].len);
+		addr += PRUETH_EMAC_BUF_POOL_SIZE;
+	}
+
+	if (!slice)
+		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
+	else
+		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
+
+	for (i = PRUETH_NUM_BUF_POOLS;
+	     i < 2 * PRUETH_SW_NUM_BUF_POOLS_HOST + PRUETH_NUM_BUF_POOLS;
+	     i++) {
+		/* The driver only uses first 4 queues per PRU so only initialize them */
+		if (i % PRUETH_SW_NUM_BUF_POOLS_HOST < PRUETH_SW_NUM_BUF_POOLS_PER_PRU) {
+			writel(addr, &bpool_cfg[i].addr);
+			writel(PRUETH_SW_BUF_POOL_SIZE_HOST, &bpool_cfg[i].len);
+			addr += PRUETH_SW_BUF_POOL_SIZE_HOST;
+		} else {
+			writel(0, &bpool_cfg[i].addr);
+			writel(0, &bpool_cfg[i].len);
+		}
+	}
+
+	if (!slice)
+		addr += PRUETH_SW_NUM_BUF_POOLS_HOST * PRUETH_SW_BUF_POOL_SIZE_HOST;
+	else
+		addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+
+	rxq_ctx = emac->dram.va + HOST_RX_Q_PRE_CONTEXT_OFFSET;
+	for (i = 0; i < 3; i++)
+		writel(addr, &rxq_ctx->start[i]);
+
+	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
+	writel(addr - SZ_2K, &rxq_ctx->end);
+
+	return 0;
+}
+
 static int prueth_emac_buffer_setup(struct prueth_emac *emac)
 {
 	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
@@ -325,13 +405,41 @@ static void icssg_init_emac_mode(struct prueth *prueth)
 	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
 }
 
+static void icssg_init_switch_mode(struct prueth *prueth)
+{
+	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
+	int i;
+
+	if (prueth->emacs_initialized)
+		return;
+
+	/* Set VLAN TABLE address base */
+	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
+			   addr <<  SMEM_VLAN_OFFSET);
+	/* Set enable VLAN aware mode, and FDBs for all PRUs */
+	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, FDB_EN_ALL);
+	prueth->vlan_tbl = (struct prueth_vlan_tbl __force *)(prueth->shram.va +
+			    EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET);
+	for (i = 0; i < SZ_4K - 1; i++) {
+		prueth->vlan_tbl[i].fid = i;
+		prueth->vlan_tbl[i].fid_c1 = 0;
+	}
+
+	if (prueth->hw_bridge_dev)
+		icssg_class_set_host_mac_addr(prueth->miig_rt, prueth->hw_bridge_dev->dev_addr);
+	icssg_set_pvid(prueth, prueth->default_vlan, PRUETH_PORT_HOST);
+}
+
 int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 {
 	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
 	struct icssg_flow_cfg __iomem *flow_cfg;
 	int ret;
 
-	icssg_init_emac_mode(prueth);
+	if (prueth->is_switch_mode)
+		icssg_init_switch_mode(prueth);
+	else
+		icssg_init_emac_mode(prueth);
 
 	memset_io(config, 0, TAS_GATE_MASK_LIST0);
 	icssg_miig_queues_init(prueth, slice);
@@ -345,7 +453,10 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	regmap_update_bits(prueth->miig_rt, ICSSG_CFG_OFFSET,
 			   ICSSG_CFG_DEFAULT, ICSSG_CFG_DEFAULT);
 	icssg_miig_set_interface_mode(prueth->miig_rt, slice, emac->phy_if);
-	icssg_config_mii_init(emac);
+	if (prueth->is_switch_mode)
+		icssg_config_mii_init_switch(emac);
+	else
+		icssg_config_mii_init(emac);
 	icssg_config_ipg(emac);
 	icssg_update_rgmii_cfg(prueth->miig_rt, emac);
 
@@ -368,7 +479,10 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	writeb(0, config + SPL_PKT_DEFAULT_PRIORITY);
 	writeb(0, config + QUEUE_NUM_UNTAGGED);
 
-	ret = prueth_emac_buffer_setup(emac);
+	if (prueth->is_switch_mode)
+		ret = prueth_switch_buffer_setup(emac);
+	else
+		ret = prueth_emac_buffer_setup(emac);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 0d5d5d253b7a..cc923f1d4387 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -35,6 +35,13 @@ struct icssg_flow_cfg {
 	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
 	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
 
+#define PRUETH_SW_BUF_POOL_SIZE_HOST	SZ_4K
+#define PRUETH_SW_NUM_BUF_POOLS_HOST	8
+#define PRUETH_SW_NUM_BUF_POOLS_PER_PRU 4
+#define MSMC_RAM_SIZE_SWITCH_MODE \
+	(MSMC_RAM_SIZE + \
+	(2 * PRUETH_SW_BUF_POOL_SIZE_HOST * PRUETH_SW_NUM_BUF_POOLS_HOST))
+
 #define PRUETH_SWITCH_FDB_MASK ((SIZE_OF_FDB / NUMBER_OF_FDB_BUCKET_ENTRIES) - 1)
 
 struct icssg_rxq_ctx {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 38d41ba6762a..9197599e5495 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -27,6 +27,7 @@
 #include <linux/remoteproc/pruss.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
+#include <net/switchdev.h>
 
 #include "icssg_prueth.h"
 #include "icssg_mii_rt.h"
@@ -54,6 +55,10 @@
 
 #define prueth_napi_to_emac(napi) container_of(napi, struct prueth_emac, napi_rx)
 
+#define DEFAULT_VID		1
+#define DEFAULT_PORT_MASK	1
+#define DEFAULT_UNTAG_MASK	1
+
 /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
 #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
 
@@ -558,6 +563,8 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 	} else {
 		/* send the filled skb up the n/w stack */
 		skb_put(skb, pkt_len);
+		if (emac->prueth->is_switch_mode)
+			skb->offload_fwd_mark = emac->offload_fwd_mark;
 		skb->protocol = eth_type_trans(skb, ndev);
 		napi_gro_receive(&emac->napi_rx, skb);
 		ndev->stats.rx_bytes += pkt_len;
@@ -890,6 +897,19 @@ struct icssg_firmwares {
 	char *txpru;
 };
 
+static struct icssg_firmwares icssg_switch_firmwares[] = {
+	{
+		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
+		.rtu = "ti-pruss/am65x-sr2-rtu0-prusw-fw.elf",
+		.txpru = "ti-pruss/am65x-sr2-txpru0-prusw-fw.elf",
+	},
+	{
+		.pru = "ti-pruss/am65x-sr2-pru1-prusw-fw.elf",
+		.rtu = "ti-pruss/am65x-sr2-rtu1-prusw-fw.elf",
+		.txpru = "ti-pruss/am65x-sr2-txpru1-prusw-fw.elf",
+	}
+};
+
 static struct icssg_firmwares icssg_emac_firmwares[] = {
 	{
 		.pru = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
@@ -909,7 +929,10 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
 	struct device *dev = prueth->dev;
 	int slice, ret;
 
-	firmwares = icssg_emac_firmwares;
+	if (prueth->is_switch_mode)
+		firmwares = icssg_switch_firmwares;
+	else
+		firmwares = icssg_emac_firmwares;
 
 	slice = prueth_emac_slice(emac);
 	if (slice < 0) {
@@ -1411,6 +1434,21 @@ static int emac_ndo_open(struct net_device *ndev)
 
 	queue_work(system_long_wq, &emac->stats_work.work);
 
+	if (prueth->is_switch_mode) {
+		icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
+				  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
+				  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
+				  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
+				  ICSSG_FDB_ENTRY_BLOCK,
+				  true);
+		icssg_vtbl_modify(emac, emac->port_vlan | DEFAULT_VID,
+				  BIT(emac->port_id) | DEFAULT_PORT_MASK,
+				  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
+				  true);
+		icssg_set_pvid(emac->prueth, emac->port_vlan, emac->port_id);
+		emac_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
+	}
+
 	return 0;
 
 reset_tx_chan:
@@ -1949,6 +1987,148 @@ static void prueth_put_cores(struct prueth *prueth, int slice)
 		pru_rproc_put(prueth->pru[slice]);
 }
 
+static void prueth_offload_fwd_mark_update(struct prueth *prueth)
+{
+	int set_val = 0;
+	int i;
+
+	if (prueth->br_members == (PRUETH_PORT_MII0 | PRUETH_PORT_MII1))
+		set_val = 1;
+
+	dev_dbg(prueth->dev, "set offload_fwd_mark %d\n", set_val);
+
+	for (i = PRUETH_MAC0; i < PRUETH_NUM_MACS; i++) {
+		struct prueth_emac *emac = prueth->emac[i];
+
+		if (!emac || !emac->ndev)
+			continue;
+
+		emac->offload_fwd_mark = set_val;
+	}
+}
+
+bool prueth_dev_check(const struct net_device *ndev)
+{
+	if (ndev->netdev_ops == &emac_netdev_ops && netif_running(ndev)) {
+		struct prueth_emac *emac = netdev_priv(ndev);
+
+		return emac->prueth->is_switch_mode;
+	}
+
+	return false;
+}
+
+static int prueth_netdevice_port_link(struct net_device *ndev,
+				      struct net_device *br_ndev,
+				      struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	int err;
+
+	if (!prueth->br_members) {
+		prueth->hw_bridge_dev = br_ndev;
+	} else {
+		/* This is adding the port to a second bridge, this is
+		 * unsupported
+		 */
+		if (prueth->hw_bridge_dev != br_ndev)
+			return -EOPNOTSUPP;
+	}
+
+	err = switchdev_bridge_port_offload(br_ndev, ndev, emac,
+					    &prueth->prueth_switchdev_nb,
+					    &prueth->prueth_switchdev_bl_nb,
+					    false, extack);
+	if (err)
+		return err;
+
+	prueth->br_members |= BIT(emac->port_id);
+
+	if (prueth->br_members & BIT(PRUETH_PORT_MII0) &&
+	    prueth->br_members & BIT(PRUETH_PORT_MII1)) {
+		prueth->is_switch_mode = true;
+		prueth->default_vlan = 1;
+		emac->port_vlan = prueth->default_vlan;
+	}
+
+	prueth_offload_fwd_mark_update(prueth);
+
+	return NOTIFY_DONE;
+}
+
+static void prueth_netdevice_port_unlink(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+
+	prueth->br_members &= ~BIT(emac->port_id);
+
+	prueth->is_switch_mode = false;
+	emac->port_vlan = 0;
+
+	prueth_offload_fwd_mark_update(prueth);
+
+	if (!prueth->br_members)
+		prueth->hw_bridge_dev = NULL;
+}
+
+/* netdev notifier */
+static int prueth_netdevice_event(struct notifier_block *unused,
+				  unsigned long event, void *ptr)
+{
+	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changeupper_info *info;
+	int ret = NOTIFY_DONE;
+
+	if (ndev->netdev_ops != &emac_netdev_ops)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		info = ptr;
+
+		if (netif_is_bridge_master(info->upper_dev)) {
+			if (info->linking)
+				ret = prueth_netdevice_port_link(ndev, info->upper_dev, extack);
+			else
+				prueth_netdevice_port_unlink(ndev);
+		}
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static int prueth_register_notifiers(struct prueth *prueth)
+{
+	int ret = 0;
+
+	prueth->prueth_netdevice_nb.notifier_call = &prueth_netdevice_event;
+	ret = register_netdevice_notifier(&prueth->prueth_netdevice_nb);
+	if (ret) {
+		dev_err(prueth->dev, "can't register netdevice notifier\n");
+		return ret;
+	}
+
+	ret = prueth_switchdev_register_notifiers(prueth);
+	if (ret)
+		unregister_netdevice_notifier(&prueth->prueth_netdevice_nb);
+
+	return ret;
+}
+
+static void prueth_unregister_notifiers(struct prueth *prueth)
+{
+	prueth_switchdev_unregister_notifiers(prueth);
+	unregister_netdevice_notifier(&prueth->prueth_netdevice_nb);
+}
+
+static const struct of_device_id prueth_dt_match[];
+
 static int prueth_probe(struct platform_device *pdev)
 {
 	struct device_node *eth_node, *eth_ports_node;
@@ -2076,6 +2256,10 @@ static int prueth_probe(struct platform_device *pdev)
 	}
 
 	msmc_ram_size = MSMC_RAM_SIZE;
+	prueth->is_switchmode_supported = prueth->pdata.switch_mode;
+	if (prueth->is_switchmode_supported)
+		msmc_ram_size = MSMC_RAM_SIZE_SWITCH_MODE;
+
 
 	/* NOTE: FW bug needs buffer base to be 64KB aligned */
 	prueth->msmcram.va =
@@ -2171,6 +2355,14 @@ static int prueth_probe(struct platform_device *pdev)
 		phy_attached_info(prueth->emac[PRUETH_MAC1]->ndev->phydev);
 	}
 
+	if (prueth->is_switchmode_supported) {
+		ret = prueth_register_notifiers(prueth);
+		if (ret)
+			goto netdev_unregister;
+
+		sprintf(prueth->switch_id, "%s", dev_name(dev));
+	}
+
 	dev_info(dev, "TI PRU ethernet driver initialized: %s EMAC mode\n",
 		 (!eth0_node || !eth1_node) ? "single" : "dual");
 
@@ -2240,6 +2432,8 @@ static void prueth_remove(struct platform_device *pdev)
 	struct device_node *eth_node;
 	int i;
 
+	prueth_unregister_notifiers(prueth);
+
 	for (i = 0; i < PRUETH_NUM_MACS; i++) {
 		if (!prueth->registered_netdevs[i])
 			continue;
@@ -2337,10 +2531,12 @@ static const struct dev_pm_ops prueth_dev_pm_ops = {
 static const struct prueth_pdata am654_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
 	.quirk_10m_link_issue = 1,
+	.switch_mode = 1,
 };
 
 static const struct prueth_pdata am64x_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_RING,
+	.switch_mode = 1,
 };
 
 static const struct of_device_id prueth_dt_match[] = {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
index 48d8ed4fa7a8..90d0d98e0ef9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
@@ -14,7 +14,7 @@
 
 #include "icssg_prueth.h"
 #include "icssg_switchdev.h"
-#include "icss_mii_rt.h"
+#include "icssg_mii_rt.h"
 
 struct prueth_switchdev_event_work {
 	struct work_struct work;
-- 
2.34.1


