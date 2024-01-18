Return-Path: <linux-kernel+bounces-29756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D778312FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4741F239B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA63A11CB6;
	Thu, 18 Jan 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KHr6Rm9o"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22092944D;
	Thu, 18 Jan 2024 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561845; cv=none; b=sGIirWsjMRcSAuDZRFdZNKw7SYlyGU1X51FDv84JsMAmrxZv7f2Hk5xvz7l3sE0txPd4W/LEI3WHdEWJZDMcZFwnLNbGKaAuEyHg2E20F3oivBggjMkeIjicufzzKFr9bCzbl6sPG+LyL5XFiYwgERYK7ecKMqZMQQLK2KmkYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561845; c=relaxed/simple;
	bh=FRBrPgpFgVXhpEAWTxuPexO9XmcGvPIIOwvZ7k2/L8Y=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EXCLAIMER-MD-CONFIG; b=jcG/woUagaaHLfTuXA9FkCzoPRDGWYUQvzIDvayGcvSqgBMFILWPK2G9hfpmbP3ceJkGmU+Kb9uCKo5/ewYA/PyM+91HalG2E0Ss0ITkOn/+gob0qrZCkhCj+K/XCg+hrRh4krN1PObwQ4dBCchU9RILW+0JmqKzKscmERbvadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KHr6Rm9o; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40I7AC49042695;
	Thu, 18 Jan 2024 01:10:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705561812;
	bh=t7twOxAdxB90uyyY1wjW9yz76lr11Ls0gPvMo3Zn6BA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KHr6Rm9o8Zt+0uIIosA+dMWJTW6DvLuHhyXRgdjWCFtcT2UMtrd3DgsjeTnO8/SBx
	 qUmEPQbDScNpV/0wGs7b/5rfZBcM0A5AvlXN7lTZDENgnYVdjeJz+ee53JRqW0RprN
	 dhU5mGWaKVmB4vILEvfnDTauzpxDBONUU5sy/iw4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40I7ACxe011383
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 01:10:12 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jan 2024 01:10:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jan 2024 01:10:11 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40I7ABlr046934;
	Thu, 18 Jan 2024 01:10:11 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40I7ABoo021971;
	Thu, 18 Jan 2024 01:10:11 -0600
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
Subject: [RFC PATCH v2 1/3] net: ti: icssg-prueth: Add helper functions to configure FDB
Date: Thu, 18 Jan 2024 12:40:03 +0530
Message-ID: <20240118071005.1514498-2-danishanwar@ti.com>
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

Introduce helper functions to configure firmware FDB tables, VLAN tables
and Port VLAN ID settings to aid adding Switch mode support.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_config.c | 188 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_config.h |  19 ++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  12 ++
 3 files changed, 219 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 99de8a40ed60..afc10014ec03 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -469,3 +469,191 @@ void icssg_config_set_speed(struct prueth_emac *emac)
 
 	writeb(fw_speed, emac->dram.va + PORT_LINK_SPEED_OFFSET);
 }
+
+int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
+		       struct mgmt_cmd_rsp *rsp)
+{
+	struct prueth *prueth = emac->prueth;
+	int slice = prueth_emac_slice(emac);
+	int addr, ret;
+
+	addr = icssg_queue_pop(prueth, slice == 0 ?
+			       ICSSG_CMD_POP_SLICE0 : ICSSG_CMD_POP_SLICE1);
+	if (addr < 0)
+		return addr;
+
+	/* First 4 bytes have FW owned buffer linking info which should
+	 * not be touched
+	 */
+	memcpy_toio(prueth->shram.va + addr + 4, cmd, sizeof(*cmd));
+	icssg_queue_push(prueth, slice == 0 ?
+			 ICSSG_CMD_PUSH_SLICE0 : ICSSG_CMD_PUSH_SLICE1, addr);
+	ret = read_poll_timeout(icssg_queue_pop, addr, addr >= 0,
+				2000, 20000000, false, prueth, slice == 0 ?
+				ICSSG_RSP_POP_SLICE0 : ICSSG_RSP_POP_SLICE1);
+	if (ret) {
+		netdev_err(emac->ndev, "Timedout sending HWQ message\n");
+		return ret;
+	}
+
+	memcpy_fromio(rsp, prueth->shram.va + addr, sizeof(*rsp));
+	/* Return buffer back for to pool */
+	icssg_queue_push(prueth, slice == 0 ?
+			 ICSSG_RSP_PUSH_SLICE0 : ICSSG_RSP_PUSH_SLICE1, addr);
+
+	return 0;
+}
+
+int icssg_fdb_add_del(struct prueth_emac *emac, const unsigned char *addr,
+		      u8 vid, u8 fid_c2, bool add)
+{
+	struct mgmt_cmd_rsp fdb_cmd_rsp = { 0 };
+	int slice = prueth_emac_slice(emac);
+	struct mgmt_cmd fdb_cmd = { 0 };
+	u8 mac_fid[ETH_ALEN + 2];
+	u16 fdb_slot;
+	u8 fid = vid;
+	int ret, i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		mac_fid[i] = addr[i];
+
+	/* 1-1 VID-FID mapping is already setup */
+	mac_fid[ETH_ALEN] = fid;
+	mac_fid[ETH_ALEN + 1] = 0;
+
+	fdb_slot = bitrev32(crc32_le(0, mac_fid, 8)) & PRUETH_SWITCH_FDB_MASK;
+
+	fdb_cmd.header = ICSSG_FW_MGMT_CMD_HEADER;
+	fdb_cmd.type   = ICSSG_FW_MGMT_FDB_CMD_TYPE;
+	fdb_cmd.seqnum = ++(emac->prueth->icssg_hwcmdseq);
+	if (add)
+		fdb_cmd.param  = ICSS_CMD_ADD_FDB;
+	else
+		fdb_cmd.param = ICSS_CMD_DEL_FDB;
+
+	fdb_cmd.param |= (slice << 4);
+
+	fid_c2 |= ICSSG_FDB_ENTRY_VALID;
+	memcpy(&fdb_cmd.cmd_args[0], addr, 4);
+	memcpy(&fdb_cmd.cmd_args[1], &addr[4], 2);
+	fdb_cmd.cmd_args[1] |= ((fid << 16) | (fid_c2 << 24));
+	fdb_cmd.cmd_args[2] = fdb_slot;
+
+	netdev_dbg(emac->ndev, "MAC %pM slot %X vlan %X FID %X\n",
+		   addr, fdb_slot, vid, fid);
+
+	ret = icssg_send_fdb_msg(emac, &fdb_cmd, &fdb_cmd_rsp);
+	if (ret)
+		return ret;
+
+	WARN_ON(fdb_cmd.seqnum != fdb_cmd_rsp.seqnum);
+	if (fdb_cmd_rsp.status == 1)
+		return 0;
+
+	return -EINVAL;
+}
+
+int icssg_fdb_lookup(struct prueth_emac *emac, const unsigned char *addr,
+		     u8 vid)
+{
+	struct mgmt_cmd_rsp fdb_cmd_rsp = { 0 };
+	int slice = prueth_emac_slice(emac);
+	struct mgmt_cmd fdb_cmd = { 0 };
+	struct prueth_fdb_slot *slot;
+	u8 mac_fid[ETH_ALEN + 2];
+	u16 fdb_slot;
+	u8 fid = vid;
+	int ret, i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		mac_fid[i] = addr[i];
+
+	/* 1-1 VID-FID mapping is already setup */
+	mac_fid[ETH_ALEN] = fid;
+	mac_fid[ETH_ALEN + 1] = 0;
+
+	fdb_slot = bitrev32(crc32_le(0, mac_fid, 8)) & PRUETH_SWITCH_FDB_MASK;
+
+	fdb_cmd.header = ICSSG_FW_MGMT_CMD_HEADER;
+	fdb_cmd.type   = ICSSG_FW_MGMT_FDB_CMD_TYPE;
+	fdb_cmd.seqnum = ++(emac->prueth->icssg_hwcmdseq);
+	fdb_cmd.param  = ICSS_CMD_GET_FDB_SLOT;
+
+	fdb_cmd.param |= (slice << 4);
+
+	memcpy(&fdb_cmd.cmd_args[0], addr, 4);
+	memcpy(&fdb_cmd.cmd_args[1], &addr[4], 2);
+	fdb_cmd.cmd_args[1] |= fid << 16;
+	fdb_cmd.cmd_args[2] = fdb_slot;
+
+	ret = icssg_send_fdb_msg(emac, &fdb_cmd, &fdb_cmd_rsp);
+	if (ret)
+		return ret;
+
+	WARN_ON(fdb_cmd.seqnum != fdb_cmd_rsp.seqnum);
+
+	slot = (struct prueth_fdb_slot __force *)(emac->dram.va + FDB_CMD_BUFFER);
+	for (i = 0; i < 4; i++) {
+		if (ether_addr_equal(addr, slot->mac) && vid == slot->fid)
+			return (slot->fid_c2 & ~ICSSG_FDB_ENTRY_VALID);
+		slot++;
+	}
+
+	return 0;
+}
+
+void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
+		       u8 untag_mask, bool add)
+{
+	struct prueth *prueth = emac->prueth;
+	struct prueth_vlan_tbl *tbl;
+	u8 fid_c1;
+
+	tbl = prueth->vlan_tbl;
+	fid_c1 = tbl[vid].fid_c1;
+
+	/* FID_C1: bit0..2 port membership mask,
+	 * bit3..5 tagging mask for each port
+	 * bit6 Stream VID (not handled currently)
+	 * bit7 MC flood (not handled currently)
+	 */
+	if (add) {
+		fid_c1 |= (port_mask | port_mask << 3);
+		fid_c1 &= ~(untag_mask << 3);
+	} else {
+		fid_c1 &= ~(port_mask | port_mask << 3);
+	}
+
+	tbl[vid].fid_c1 = fid_c1;
+}
+
+u16 icssg_get_pvid(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	u32 pvid;
+
+	if (emac->port_id == PRUETH_PORT_MII0)
+		pvid = readl(prueth->shram.va + EMAC_ICSSG_SWITCH_PORT1_DEFAULT_VLAN_OFFSET);
+	else
+		pvid = readl(prueth->shram.va + EMAC_ICSSG_SWITCH_PORT2_DEFAULT_VLAN_OFFSET);
+
+	pvid = pvid >> 24;
+
+	return pvid;
+}
+
+void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port)
+{
+	u32 pvid;
+
+	/* only 256 VLANs are supported */
+	pvid = (u32 __force)cpu_to_be32((ETH_P_8021Q << 16) | (vid & 0xff));
+
+	if (port == PRUETH_PORT_MII0)
+		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT1_DEFAULT_VLAN_OFFSET);
+	else if (port == PRUETH_PORT_MII1)
+		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT2_DEFAULT_VLAN_OFFSET);
+	else
+		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT0_DEFAULT_VLAN_OFFSET);
+}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 43eb0922172a..0d5d5d253b7a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -35,6 +35,8 @@ struct icssg_flow_cfg {
 	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
 	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
 
+#define PRUETH_SWITCH_FDB_MASK ((SIZE_OF_FDB / NUMBER_OF_FDB_BUCKET_ENTRIES) - 1)
+
 struct icssg_rxq_ctx {
 	__le32 start[3];
 	__le32 end;
@@ -146,6 +148,23 @@ struct icssg_setclock_desc {
 #define ICSSG_TS_PUSH_SLICE0	40
 #define ICSSG_TS_PUSH_SLICE1	41
 
+struct mgmt_cmd {
+	u8 param;
+	u8 seqnum;
+	u8 type;
+	u8 header;
+	u32 cmd_args[3];
+} __packed;
+
+struct mgmt_cmd_rsp {
+	u32 reserved;
+	u8 status;
+	u8 seqnum;
+	u8 type;
+	u8 header;
+	u32 cmd_args[3];
+} __packed;
+
 /* FDB FID_C2 flag definitions */
 /* Indicates host port membership.*/
 #define ICSSG_FDB_ENTRY_P0_MEMBERSHIP         BIT(0)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 8b6d6b497010..006f77217bd1 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -210,6 +210,7 @@ struct prueth_pdata {
  * @emacs_initialized: num of EMACs/ext ports that are up/running
  * @iep0: pointer to IEP0 device
  * @iep1: pointer to IEP1 device
+ * @vlan_tbl: VLAN-FID table pointer
  */
 struct prueth {
 	struct device *dev;
@@ -234,6 +235,7 @@ struct prueth {
 	int emacs_initialized;
 	struct icss_iep *iep0;
 	struct icss_iep *iep1;
+	struct prueth_vlan_tbl *vlan_tbl;
 };
 
 struct emac_tx_ts_response {
@@ -279,6 +281,16 @@ int icssg_queue_pop(struct prueth *prueth, u8 queue);
 void icssg_queue_push(struct prueth *prueth, int queue, u16 addr);
 u32 icssg_queue_level(struct prueth *prueth, int queue);
 
+int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
+		       struct mgmt_cmd_rsp *rsp);
+int icssg_fdb_add_del(struct prueth_emac *emac,  const unsigned char *addr,
+		      u8 vid, u8 fid_c2, bool add);
+int icssg_fdb_lookup(struct prueth_emac *emac, const unsigned char *addr,
+		     u8 vid);
+void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
+		       u8 untag_mask, bool add);
+u16 icssg_get_pvid(struct prueth_emac *emac);
+void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
 #define prueth_napi_to_tx_chn(pnapi) \
 	container_of(pnapi, struct prueth_tx_chn, napi_tx)
 
-- 
2.34.1


