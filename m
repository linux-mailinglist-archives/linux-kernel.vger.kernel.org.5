Return-Path: <linux-kernel+bounces-29754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4468312FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01585B223EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825C3BA49;
	Thu, 18 Jan 2024 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uYm3mEcQ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209437481;
	Thu, 18 Jan 2024 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561844; cv=none; b=uE37KlfX9fb38uYYFObx/Spzge6uD/VKMeOCehYbU+2KlbOIIA3HIkbdkmQMvKggBKiKAYsjIYHU1DxG3ctym7cwN+7D4sA3i2ANYydAxzzH8jF3s8trzSI5KCrEEwggbVeiwgXqYM/WPSaHePCkLht1EYqAstCfV8C/+I2roSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561844; c=relaxed/simple;
	bh=xwnffKqnOMcsq3v8ez6obCozaz5qhBdADsldaU7/+MY=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EXCLAIMER-MD-CONFIG; b=b45m1hBKqDa3mfuIZM7kq86BzqANWb0IX/KB9Lmnmk0+0uYR5O927XGfwMeZ4ZDeKgc5eDI6xm24fvAMpS8tM0B6Ba9wARSyg1qPICahZEmBhSFatJOzCjAk+j82dsOx0kVbyE4Q8O/teQxIxeYkJ6M1o9qmU2aGHqVg1tpKW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uYm3mEcQ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40I7AEVR094648;
	Thu, 18 Jan 2024 01:10:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705561814;
	bh=6lYNPJmt/z6xeDHMH/bmz/fkrQrleQ8mTViafNVO648=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uYm3mEcQFOzgGvaRQUS3sK5ebT0RsXbxKXK6wS3Xp+xG1UoZGIJFWU5flWAbRQz2G
	 DsL3BZqcLSAOJZy0FjZKrSC9d0E5hZzB/HXFrqbRXDGOPb4vTa0Pxv5P7AdO1H3vLH
	 DMQsfKHcj3RGuKrkr4Mn3xt18n4qbyO5QhOjoxx4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40I7AETK011429
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 01:10:14 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jan 2024 01:10:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jan 2024 01:10:13 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40I7ADdH047033;
	Thu, 18 Jan 2024 01:10:13 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40I7ACLY021978;
	Thu, 18 Jan 2024 01:10:13 -0600
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
Subject: [RFC PATCH v2 2/3] net: ti: icssg-switch: Add switchdev based driver for ethernet switch support
Date: Thu, 18 Jan 2024 12:40:04 +0530
Message-ID: <20240118071005.1514498-3-danishanwar@ti.com>
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

ICSSG can operating in switch mode with 2 ext port and 1 host port with
VLAN/FDB/MDB and STP offloading. Add switchdev based driver to
support the same.

Driver itself will be integrated with icssg_prueth in future commits

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  24 +
 .../net/ethernet/ti/icssg/icssg_switchdev.c   | 478 ++++++++++++++++++
 .../net/ethernet/ti/icssg/icssg_switchdev.h   |  13 +
 4 files changed, 516 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.h

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 411898a4f38c..38d41ba6762a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -30,6 +30,7 @@
 
 #include "icssg_prueth.h"
 #include "icssg_mii_rt.h"
+#include "icssg_switchdev.h"
 #include "../k3-cppi-desc-pool.h"
 
 #define PRUETH_MODULE_DESCRIPTION "PRUSS ICSSG Ethernet driver"
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 006f77217bd1..5b90e8f8ee48 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -174,6 +174,9 @@ struct prueth_emac {
 
 	struct pruss_mem_region dram;
 
+	bool offload_fwd_mark;
+	int port_vlan;
+
 	struct delayed_work stats_work;
 	u64 stats[ICSSG_NUM_STATS];
 };
@@ -182,10 +185,12 @@ struct prueth_emac {
  * struct prueth_pdata - PRUeth platform data
  * @fdqring_mode: Free desc queue mode
  * @quirk_10m_link_issue: 10M link detect errata
+ * @switch_mode: switch firmware support
  */
 struct prueth_pdata {
 	enum k3_ring_mode fdqring_mode;
 	u32	quirk_10m_link_issue:1;
+	u32	switch_mode:1;
 };
 
 /**
@@ -211,6 +216,15 @@ struct prueth_pdata {
  * @iep0: pointer to IEP0 device
  * @iep1: pointer to IEP1 device
  * @vlan_tbl: VLAN-FID table pointer
+ * @hw_bridge_dev: pointer to HW bridge net device
+ * @br_members: bitmask of bridge member ports
+ * @prueth_netdevice_nb: netdevice notifier block
+ * @prueth_switchdevice_nb: switchdev notifier block
+ * @prueth_switchdev_bl_nb: switchdev blocking notifier block
+ * @is_switch_mode: flag to indicate if device is in Switch mode
+ * @is_switchmode_supported: indicates platform support for switch mode
+ * @switch_id: ID for mapping switch ports to bridge
+ * @default_vlan: Default VLAN for host
  */
 struct prueth {
 	struct device *dev;
@@ -236,6 +250,16 @@ struct prueth {
 	struct icss_iep *iep0;
 	struct icss_iep *iep1;
 	struct prueth_vlan_tbl *vlan_tbl;
+
+	struct net_device *hw_bridge_dev;
+	u8 br_members;
+	struct notifier_block prueth_netdevice_nb;
+	struct notifier_block prueth_switchdev_nb;
+	struct notifier_block prueth_switchdev_bl_nb;
+	bool is_switch_mode;
+	bool is_switchmode_supported;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
+	int default_vlan;
 };
 
 struct emac_tx_ts_response {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
new file mode 100644
index 000000000000..48d8ed4fa7a8
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Texas Instruments K3 ICSSG Ethernet Switchdev Driver
+ *
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/if_bridge.h>
+#include <linux/netdevice.h>
+#include <linux/workqueue.h>
+#include <net/switchdev.h>
+
+#include "icssg_prueth.h"
+#include "icssg_switchdev.h"
+#include "icss_mii_rt.h"
+
+struct prueth_switchdev_event_work {
+	struct work_struct work;
+	struct switchdev_notifier_fdb_info fdb_info;
+	struct prueth_emac *emac;
+	unsigned long event;
+};
+
+static int prueth_switchdev_stp_state_set(struct prueth_emac *emac,
+					  u8 state)
+{
+	enum icssg_port_state_cmd emac_state;
+	int ret = 0;
+
+	switch (state) {
+	case BR_STATE_FORWARDING:
+		emac_state = ICSSG_EMAC_PORT_FORWARD;
+		break;
+	case BR_STATE_DISABLED:
+		emac_state = ICSSG_EMAC_PORT_DISABLE;
+		break;
+	case BR_STATE_LEARNING:
+	case BR_STATE_LISTENING:
+	case BR_STATE_BLOCKING:
+		emac_state = ICSSG_EMAC_PORT_BLOCK;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	emac_set_port_state(emac, emac_state);
+	netdev_dbg(emac->ndev, "STP state: %u\n", emac_state);
+
+	return ret;
+}
+
+static int prueth_switchdev_attr_br_flags_set(struct prueth_emac *emac,
+					      struct net_device *orig_dev,
+					      struct switchdev_brport_flags brport_flags)
+{
+	enum icssg_port_state_cmd emac_state;
+
+	if (brport_flags.mask & BR_MCAST_FLOOD)
+		emac_state = ICSSG_EMAC_PORT_MC_FLOODING_ENABLE;
+	else
+		emac_state = ICSSG_EMAC_PORT_MC_FLOODING_DISABLE;
+
+	netdev_dbg(emac->ndev, "BR_MCAST_FLOOD: %d port %u\n",
+		   emac_state, emac->port_id);
+
+	emac_set_port_state(emac, emac_state);
+
+	return 0;
+}
+
+static int prueth_switchdev_attr_br_flags_pre_set(struct net_device *netdev,
+						  struct switchdev_brport_flags brport_flags)
+{
+	if (brport_flags.mask & ~(BR_LEARNING | BR_MCAST_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int prueth_switchdev_attr_set(struct net_device *ndev, const void *ctx,
+				     const struct switchdev_attr *attr,
+				     struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int ret;
+
+	netdev_dbg(ndev, "attr: id %u port: %u\n", attr->id, emac->port_id);
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		ret = prueth_switchdev_attr_br_flags_pre_set(ndev,
+							     attr->u.brport_flags);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
+		ret = prueth_switchdev_stp_state_set(emac,
+						     attr->u.stp_state);
+		netdev_dbg(ndev, "stp state: %u\n", attr->u.stp_state);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		ret = prueth_switchdev_attr_br_flags_set(emac, attr->orig_dev,
+							 attr->u.brport_flags);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static void prueth_switchdev_fdb_offload_notify(struct net_device *ndev,
+						struct switchdev_notifier_fdb_info *rcv)
+{
+	struct switchdev_notifier_fdb_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.addr = rcv->addr;
+	info.vid = rcv->vid;
+	info.offloaded = true;
+	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
+				 ndev, &info.info, NULL);
+}
+
+static void prueth_switchdev_event_work(struct work_struct *work)
+{
+	struct prueth_switchdev_event_work *switchdev_work =
+		container_of(work, struct prueth_switchdev_event_work, work);
+	struct prueth_emac *emac = switchdev_work->emac;
+	struct switchdev_notifier_fdb_info *fdb;
+	int port_id = emac->port_id;
+	int ret;
+
+	rtnl_lock();
+	switch (switchdev_work->event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		fdb = &switchdev_work->fdb_info;
+
+		netdev_dbg(emac->ndev, "prueth_fdb_add: MACID = %pM vid = %u flags = %u %u -- port %d\n",
+			   fdb->addr, fdb->vid, fdb->added_by_user,
+			   fdb->offloaded, port_id);
+
+		if (!fdb->added_by_user)
+			break;
+		if (memcmp(emac->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
+			break;
+
+		ret = icssg_fdb_add_del(emac, fdb->addr, fdb->vid,
+					BIT(port_id), true);
+		if (!ret)
+			prueth_switchdev_fdb_offload_notify(emac->ndev, fdb);
+		break;
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		fdb = &switchdev_work->fdb_info;
+
+		netdev_dbg(emac->ndev, "prueth_fdb_del: MACID = %pM vid = %u flags = %u %u -- port %d\n",
+			   fdb->addr, fdb->vid, fdb->added_by_user,
+			   fdb->offloaded, port_id);
+
+		if (!fdb->added_by_user)
+			break;
+		if (memcmp(emac->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
+			break;
+		icssg_fdb_add_del(emac, fdb->addr, fdb->vid,
+				  BIT(port_id), false);
+		break;
+	default:
+		break;
+	}
+	rtnl_unlock();
+
+	kfree(switchdev_work->fdb_info.addr);
+	kfree(switchdev_work);
+	dev_put(emac->ndev);
+}
+
+static int prueth_switchdev_event(struct notifier_block *unused,
+				  unsigned long event, void *ptr)
+{
+	struct net_device *ndev = switchdev_notifier_info_to_dev(ptr);
+	struct prueth_switchdev_event_work *switchdev_work;
+	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int err;
+
+	if (!prueth_dev_check(ndev))
+		return NOTIFY_DONE;
+
+	if (event == SWITCHDEV_PORT_ATTR_SET) {
+		err = switchdev_handle_port_attr_set(ndev, ptr,
+						     prueth_dev_check,
+						     prueth_switchdev_attr_set);
+		return notifier_from_errno(err);
+	}
+
+	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
+	if (WARN_ON(!switchdev_work))
+		return NOTIFY_BAD;
+
+	INIT_WORK(&switchdev_work->work, prueth_switchdev_event_work);
+	switchdev_work->emac = emac;
+	switchdev_work->event = event;
+
+	switch (event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		memcpy(&switchdev_work->fdb_info, ptr,
+		       sizeof(switchdev_work->fdb_info));
+		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
+		if (!switchdev_work->fdb_info.addr)
+			goto err_addr_alloc;
+		ether_addr_copy((u8 *)switchdev_work->fdb_info.addr,
+				fdb_info->addr);
+		dev_hold(ndev);
+		break;
+	default:
+		kfree(switchdev_work);
+		return NOTIFY_DONE;
+	}
+
+	queue_work(system_long_wq, &switchdev_work->work);
+
+	return NOTIFY_DONE;
+
+err_addr_alloc:
+	kfree(switchdev_work);
+	return NOTIFY_BAD;
+}
+
+static int prueth_switchdev_vlan_add(struct prueth_emac *emac, bool untag, bool pvid,
+				     u8 vid, struct net_device *orig_dev)
+{
+	bool cpu_port = netif_is_bridge_master(orig_dev);
+	int untag_mask = 0;
+	int port_mask;
+	int ret = 0;
+
+	if (cpu_port)
+		port_mask = BIT(PRUETH_PORT_HOST);
+	else
+		port_mask = BIT(emac->port_id);
+
+	if (untag)
+		untag_mask = port_mask;
+
+	icssg_vtbl_modify(emac, vid, port_mask, untag_mask, true);
+
+	netdev_dbg(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X PVID %d\n",
+		   vid, port_mask, untag_mask, pvid);
+
+	if (!pvid)
+		return ret;
+
+	icssg_set_pvid(emac->prueth, vid, emac->port_id);
+
+	return ret;
+}
+
+static int prueth_switchdev_vlan_del(struct prueth_emac *emac, u16 vid,
+				     struct net_device *orig_dev)
+{
+	bool cpu_port = netif_is_bridge_master(orig_dev);
+	int port_mask;
+	int ret = 0;
+
+	if (cpu_port)
+		port_mask = BIT(PRUETH_PORT_HOST);
+	else
+		port_mask = BIT(emac->port_id);
+
+	icssg_vtbl_modify(emac, vid, port_mask, 0, false);
+
+	if (cpu_port)
+		icssg_fdb_add_del(emac, emac->mac_addr, vid,
+				  BIT(PRUETH_PORT_HOST), false);
+
+	if (vid == icssg_get_pvid(emac))
+		icssg_set_pvid(emac->prueth, 0, emac->port_id);
+
+	netdev_dbg(emac->ndev, "VID del vid:%u port_mask:%X\n",
+		   vid, port_mask);
+
+	return ret;
+}
+
+static int prueth_switchdev_vlans_add(struct prueth_emac *emac,
+				      const struct switchdev_obj_port_vlan *vlan)
+{
+	bool untag = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	struct net_device *orig_dev = vlan->obj.orig_dev;
+	bool cpu_port = netif_is_bridge_master(orig_dev);
+	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+
+	netdev_dbg(emac->ndev, "VID add vid:%u flags:%X\n",
+		   vlan->vid, vlan->flags);
+
+	if (cpu_port && !(vlan->flags & BRIDGE_VLAN_INFO_BRENTRY))
+		return 0;
+
+	if (vlan->vid > 0xff)
+		return 0;
+
+	return prueth_switchdev_vlan_add(emac, untag, pvid, vlan->vid,
+					 orig_dev);
+}
+
+static int prueth_switchdev_vlans_del(struct prueth_emac *emac,
+				      const struct switchdev_obj_port_vlan *vlan)
+{
+	if (vlan->vid > 0xff)
+		return 0;
+
+	return prueth_switchdev_vlan_del(emac, vlan->vid,
+					 vlan->obj.orig_dev);
+}
+
+static int prueth_switchdev_mdb_add(struct prueth_emac *emac,
+				    struct switchdev_obj_port_mdb *mdb)
+{
+	struct net_device *orig_dev = mdb->obj.orig_dev;
+	u8 port_mask, fid_c2;
+	bool cpu_port;
+	int err;
+
+	cpu_port = netif_is_bridge_master(orig_dev);
+
+	if (cpu_port)
+		port_mask = BIT(PRUETH_PORT_HOST);
+	else
+		port_mask = BIT(emac->port_id);
+
+	fid_c2 = icssg_fdb_lookup(emac, mdb->addr, mdb->vid);
+
+	err = icssg_fdb_add_del(emac, mdb->addr, mdb->vid, fid_c2 | port_mask, true);
+	netdev_dbg(emac->ndev, "MDB add vid %u:%pM  ports: %X\n",
+		   mdb->vid, mdb->addr, port_mask);
+
+	return err;
+}
+
+static int prueth_switchdev_mdb_del(struct prueth_emac *emac,
+				    struct switchdev_obj_port_mdb *mdb)
+{
+	struct net_device *orig_dev = mdb->obj.orig_dev;
+	int del_mask, ret, fid_c2;
+	bool cpu_port;
+
+	cpu_port = netif_is_bridge_master(orig_dev);
+
+	if (cpu_port)
+		del_mask = BIT(PRUETH_PORT_HOST);
+	else
+		del_mask = BIT(emac->port_id);
+
+	fid_c2 = icssg_fdb_lookup(emac, mdb->addr, mdb->vid);
+
+	if (fid_c2 & ~del_mask)
+		ret = icssg_fdb_add_del(emac, mdb->addr, mdb->vid, fid_c2 & ~del_mask, true);
+	else
+		ret = icssg_fdb_add_del(emac, mdb->addr, mdb->vid, 0, false);
+
+	netdev_dbg(emac->ndev, "MDB del vid %u:%pM  ports: %X\n",
+		   mdb->vid, mdb->addr, del_mask);
+
+	return ret;
+}
+
+static int prueth_switchdev_obj_add(struct net_device *ndev, const void *ctx,
+				    const struct switchdev_obj *obj,
+				    struct netlink_ext_ack *extack)
+{
+	struct switchdev_obj_port_vlan *vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+	struct switchdev_obj_port_mdb *mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int err = 0;
+
+	netdev_dbg(ndev, "obj_add: id %u port: %u\n", obj->id, emac->port_id);
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		err = prueth_switchdev_vlans_add(emac, vlan);
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		err = prueth_switchdev_mdb_add(emac, mdb);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int prueth_switchdev_obj_del(struct net_device *ndev, const void *ctx,
+				    const struct switchdev_obj *obj)
+{
+	struct switchdev_obj_port_vlan *vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+	struct switchdev_obj_port_mdb *mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int err = 0;
+
+	netdev_dbg(ndev, "obj_del: id %u port: %u\n", obj->id, emac->port_id);
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		err = prueth_switchdev_vlans_del(emac, vlan);
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		err = prueth_switchdev_mdb_del(emac, mdb);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int prueth_switchdev_blocking_event(struct notifier_block *unused,
+					   unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_OBJ_ADD:
+		err = switchdev_handle_port_obj_add(dev, ptr,
+						    prueth_dev_check,
+						    prueth_switchdev_obj_add);
+		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_OBJ_DEL:
+		err = switchdev_handle_port_obj_del(dev, ptr,
+						    prueth_dev_check,
+						    prueth_switchdev_obj_del);
+		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     prueth_dev_check,
+						     prueth_switchdev_attr_set);
+		return notifier_from_errno(err);
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+int prueth_switchdev_register_notifiers(struct prueth *prueth)
+{
+	int ret = 0;
+
+	prueth->prueth_switchdev_nb.notifier_call = &prueth_switchdev_event;
+	ret = register_switchdev_notifier(&prueth->prueth_switchdev_nb);
+	if (ret) {
+		dev_err(prueth->dev, "register switchdev notifier fail ret:%d\n",
+			ret);
+		return ret;
+	}
+
+	prueth->prueth_switchdev_bl_nb.notifier_call = &prueth_switchdev_blocking_event;
+	ret = register_switchdev_blocking_notifier(&prueth->prueth_switchdev_bl_nb);
+	if (ret) {
+		dev_err(prueth->dev, "register switchdev blocking notifier ret:%d\n",
+			ret);
+		unregister_switchdev_notifier(&prueth->prueth_switchdev_nb);
+	}
+
+	return ret;
+}
+
+void prueth_switchdev_unregister_notifiers(struct prueth *prueth)
+{
+	unregister_switchdev_blocking_notifier(&prueth->prueth_switchdev_bl_nb);
+	unregister_switchdev_notifier(&prueth->prueth_switchdev_nb);
+}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switchdev.h b/drivers/net/ethernet/ti/icssg/icssg_switchdev.h
new file mode 100644
index 000000000000..0e64e7760a00
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_switchdev.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ */
+#ifndef __NET_TI_ICSSG_SWITCHDEV_H
+#define __NET_TI_ICSSG_SWITCHDEV_H
+
+#include "icssg_prueth.h"
+
+int prueth_switchdev_register_notifiers(struct prueth *prueth);
+void prueth_switchdev_unregister_notifiers(struct prueth *prueth);
+bool prueth_dev_check(const struct net_device *ndev);
+
+#endif /* __NET_TI_ICSSG_SWITCHDEV_H */
-- 
2.34.1


