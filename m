Return-Path: <linux-kernel+bounces-18668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2378260C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1206DB22590
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200F0C8F3;
	Sat,  6 Jan 2024 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mgl37zXB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB9E553;
	Sat,  6 Jan 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyMKIVqZmqvg/OIpX4GWXRVOrPkvPV0SVlwvuOe9DnRX9yOMmzHVUfdbfwZiSoZWNakt6GE4EUl9Y4iz0RGp96UY0dZsovpSTjOtYZZbUNXqbVS/7VraiOh22WRdxC/Ni3Pi7C6V+0ViQW4hZ52AjQQAaB2jc+dpG7ZpiKSvb0FWDiho6YQ3q5vCpddmZn0zyte95fbEEkRrV9sA7iVq3OPiKyqFbD7FKr2klOzFQlkbn5WoGp0irqQCWVdUyCp8fyBERFPx0uQRTcxQ7bbduow7PxDfgSzYdwqIKqz6uEZawyZlbWywrSOm7mLER9/xbBeyEpxk6F9ryErFuGshtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1beMKVH04h53PL54AIC6JZtAKZKUGXp6y+waviRLQs=;
 b=APFWprWMcXrK9JXPNRFMyBtAHWc+wvVvlFypdtwkD+ljPZ19uk2DOenR7AMilWGlwNjp3i1Q8k0Vvt7kNLn2ZWRORg5Ie54/YZs29bKo+vEUzB6T30h73YDM5lH+LN1i21FuQzpeGbyJj+uNJSwmQdmUFQ5quO7FGyHP23or9lNn+XT7bSJWB56K1VmKzGxDnt7rnBZuyFLQQX6Mh+LDZy8hK7JFKraPghlIkY4VVq7TSzl5cRjsMXX1198g2D6RPmg4nqjfD8dWC71kdmC0jSWJrOkvOkrZ0l1ALgmJohlD94lddJaR0oswt0wrO3NLIDsVETkB27XOsIgEj56Eqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1beMKVH04h53PL54AIC6JZtAKZKUGXp6y+waviRLQs=;
 b=Mgl37zXB07IbxUN8LqrV1WR62v61OXB2ZOn1P82p86U/zwz/BVFRwoF+j6o6yGXJAtbdrGntzam+gpYeJkinLjQrjaK5tN4n0Va1JwXtJocRqR3oSTmhEFiffAkXlCJpu9/gSeADvGy8MUb0mA4QxTiLB2xsAGqt0S9nYc6qhCo=
Received: from MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::34)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19; Sat, 6 Jan
 2024 16:58:07 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::dc) by MW4P222CA0029.outlook.office365.com
 (2603:10b6:303:114::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19 via Frontend
 Transport; Sat, 6 Jan 2024 16:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.3 via Frontend Transport; Sat, 6 Jan 2024 16:58:06 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 6 Jan
 2024 10:58:02 -0600
From: Sanath S <Sanath.S@amd.com>
To: <mario.limonciello@amd.com>, <andreas.noever@gmail.com>,
	<michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
	<YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Sanath S <Sanath.S@amd.com>
Subject: [Patch v3 2/4] thunderbolt: Extend tb_switch_reset() to support lane and protocol adapter reset
Date: Sat, 6 Jan 2024 22:27:21 +0530
Message-ID: <20240106165723.3377789-3-Sanath.S@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240106165723.3377789-1-Sanath.S@amd.com>
References: <20240106165723.3377789-1-Sanath.S@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM6PR12MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fcbb0f-469e-4f45-d93b-08dc0ed8a7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cj6dkKuKanDxrX6ui92r0Rfo18vYxvM9/Lw2Mdx0sU9qmlX9hC+Ww/DWrtDI/viIbWlJzKUNPCVDUKD2rLnB16OicSVS5Gm6lzSPoPRWet+YTCvmYdC0RkqH2g1hYO2KuXyigOeNfiGlysKyWrye9tSQY6Q6tKNeAmZBllVMvia/sWKYZQLzYUFH6On/WzoGfJP9MD0ziCbwqiOu3eIeAVbDhata/JXX8pZydbOjfOwDaTcStbD1KBZib+f8KEBm1AR9sNinpAGpmurd1hkbl9wOcf7MGLm4hcs2Ntscw+5FNs8eK8ZF2sVrVvl4lV6kSNwAmX7BjNXey1SVf5wm8/WSrlYCf1wYaa+gKt6tBGwT+GC4ABu5gH+Ga1GMazB3oJV81MKMUrX4nQC0zdKEyDFHVTrk54J4fZX/CgrgMFAd/wNz0TopfsojifX69RFtUYcDGtS60SqkxvydhqBtCBu+Tnmsze6KMPAqsP8iq6cRX1qJGRJAbGjXYJEh+HWFFXfc5CpXLqEMrrKNm4WWiUhuoqCBRaI0Djg9hLZ+a1RYt1sVPspSMt9VyJbgrWMrBivFmlxMBfh1Ed1zg9UrzoK8qVrM8GmtVe+pvs6UUDWB/hoMIPmG1G6O9JUtsDheAaSNq171MdToHI0UJPtYNoRyv4qcYAeX/Ic0xFihiakdH4h/JTOjGswstAnjQcRkqZ3WzrI3/PbCoo79uTxv1INfHWbqF6Rl+zyeecGHMpmWW7+9AxQ50K7DSXcAqWrqbtwArELPMhs3FrsRXqDfoe8QWlH6APwOdT6ZOlto2xA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(26005)(336012)(426003)(1076003)(2616005)(7696005)(478600001)(6666004)(47076005)(83380400001)(16526019)(66574015)(2906002)(5660300002)(41300700001)(70206006)(316002)(70586007)(110136005)(8676002)(8936002)(4326008)(82740400003)(36860700001)(36756003)(86362001)(81166007)(356005)(40480700001)(40460700003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 16:58:06.7411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fcbb0f-469e-4f45-d93b-08dc0ed8a7bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548

Extend tb_switch_reset() to support resetting lane adapters and
protocol adapters for USB4 routers. Incase of lane adapters it
resets downstream port and its path config spaces and incase of
protocol adapters it disables the path and resets its path config
spaces.

Introduce tb_path_deactivate_hop() to deactivate path for given
hop index and lane/protocol adapter.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
---
 drivers/thunderbolt/path.c   | 13 ++++++++
 drivers/thunderbolt/switch.c | 61 ++++++++++++++++++++++++++++++++++--
 drivers/thunderbolt/tb.h     |  3 ++
 3 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 091a81bbdbdc..f760e54cd9bd 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -446,6 +446,19 @@ static int __tb_path_deactivate_hop(struct tb_port *port, int hop_index,
 	return -ETIMEDOUT;
 }
 
+/**
+ * tb_path_deactivate_hop() - Deactivate one path in path config space
+ * @port: Lane or protocol adapter
+ * @hop_index: HopID of the path to be cleared
+ *
+ * This deactivates or clears a single path config space entry at
+ * @hop_index. Returns %0 in success and negative errno otherwise.
+ */
+int tb_path_deactivate_hop(struct tb_port *port, int hop_index)
+{
+	return __tb_path_deactivate_hop(port, hop_index, true);
+}
+
 static void __tb_path_deactivate_hops(struct tb_path *path, int first_hop)
 {
 	int i, res;
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 44e9b09de47a..fec0078f15ef 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -676,6 +676,13 @@ int tb_port_disable(struct tb_port *port)
 	return __tb_port_enable(port, false);
 }
 
+static int tb_port_reset(struct tb_port *port)
+{
+	if (tb_switch_is_usb4(port->sw))
+		return usb4_port_reset(port);
+	return tb_lc_reset_port(port);
+}
+
 /*
  * tb_init_port() - initialize a port
  *
@@ -1550,18 +1557,66 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
 /**
  * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
  * @sw: Switch to reset
+ * tb_switch_reset() - Perform reset to the router
+ * @sw: Router to reset
  *
  * Return: Returns 0 on success or an error code on failure.
+ * Issues reset to the router. Can be used for any router. Returns %0
+ * on success or an error code on failure.
  */
 int tb_switch_reset(struct tb_switch *sw)
 {
 	struct tb_cfg_result res;
 
-	if (sw->generation > 1)
-		return 0;
+	tb_sw_dbg(sw, "resetting router\n");
+
+	if (sw->generation > 1) {
+		struct tb_port *port;
+
+		tb_sw_dbg(sw, "resetting switch\n");
+		tb_switch_for_each_port(sw, port) {
+			int i, ret;
+
+			/*
+			 * For lane adapters we issue downstream port
+			 * reset and clear up path config spaces.
+			 *
+			 * For protocol adapters we disable the path and
+			 * clear path config space one by one (from 8 to
+			 * Max Input HopID of the adapter).
+			 */
+			if (tb_port_is_null(port) && !tb_is_upstream_port(port)) {
+				if (!port->cap_usb4)
+					continue;
+				ret = tb_port_reset(port);
+				if (ret)
+					return ret;
+			} else if (tb_port_is_usb3_down(port) ||
+				   tb_port_is_usb3_up(port)) {
+				tb_usb3_port_enable(port, false);
+			} else if (tb_port_is_dpin(port) ||
+				   tb_port_is_dpout(port)) {
+				tb_dp_port_enable(port, false);
+			} else if (tb_port_is_pcie_down(port) ||
+				   tb_port_is_pcie_up(port)) {
+				tb_pci_port_enable(port, false);
+			} else {
+				continue;
+			}
 
-	tb_sw_dbg(sw, "resetting switch\n");
+			/* Cleanup path config space of protocol adapter */
+			for (i = TB_PATH_MIN_HOPID;
+			     i <= port->config.max_in_hop_id; i++) {
+				ret = tb_path_deactivate_hop(port, i);
+				if (ret)
+					return ret;
+			}
+		}
+
+		return 0;
+	}
 
+	/* Thunderbolt 1 uses the "reset" config space packet */
 	res.err = tb_sw_write(sw, ((u32 *) &sw->config) + 2,
 			      TB_CFG_SWITCH, 2, 2);
 	if (res.err)
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e299e53473ae..030d6525cbc9 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1132,6 +1132,7 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 void tb_path_free(struct tb_path *path);
 int tb_path_activate(struct tb_path *path);
 void tb_path_deactivate(struct tb_path *path);
+int tb_path_deactivate_hop(struct tb_port *port, int hop_index);
 bool tb_path_is_invalid(struct tb_path *path);
 bool tb_path_port_on_path(const struct tb_path *path,
 			  const struct tb_port *port);
@@ -1151,6 +1152,7 @@ int tb_drom_read(struct tb_switch *sw);
 int tb_drom_read_uid_only(struct tb_switch *sw, u64 *uid);
 
 int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid);
+int tb_lc_reset_port(struct tb_port *port);
 int tb_lc_configure_port(struct tb_port *port);
 void tb_lc_unconfigure_port(struct tb_port *port);
 int tb_lc_configure_xdomain(struct tb_port *port);
@@ -1283,6 +1285,7 @@ void usb4_switch_remove_ports(struct tb_switch *sw);
 
 int usb4_port_unlock(struct tb_port *port);
 int usb4_port_hotplug_enable(struct tb_port *port);
+int usb4_port_reset(struct tb_port *port);
 int usb4_port_configure(struct tb_port *port);
 void usb4_port_unconfigure(struct tb_port *port);
 int usb4_port_configure_xdomain(struct tb_port *port, struct tb_xdomain *xd);
-- 
2.34.1


