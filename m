Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BBD80EE45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376401AbjLLOCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376404AbjLLOCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:02:01 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262F100;
        Tue, 12 Dec 2023 06:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah/6KNcZbGspPWn0qliB5588N4uSukzTW/f1wS3xiIYD0c8DAQm3BtBzmgBdy5WGFaRk9sNsD47tHdGPi/M6VwSCxLDrjORpmSqM8AhugFVVWIiXCT+lN/6djqfTfDXD2mYRjWKF5mCUFL4HhAmKBgcbzIBSvl9i3M6KMuAKzokIeV81OB7XqhgPwGej+INBugTx4E2U2ec6Lzij6ADxWywVsEtjeZa9m1sMVB7yDBgxfma58NEFhRvrKz8ZLbePGNwNizLVTrNIVhwk7getjyFuXSyUmsgUHZs8mCEgOtcm8nZz5qr1zFc/4iqmtzIil7L1cL2uXQIa9InvJAK/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bFfMCuV86jnR/ilSFLrF6DfQazlBQvcxV1L9vTV3pI=;
 b=FjbNM2/IjKmccKHiPMsoCbe9d7aZCiqQ0LV1RlvjWIp15HaHO5/kzXTVPR6mZ06IUI69lB7smm/V5tQPAmPfLlnXcQ033/+VKAZEnY134agjlzhgBupcVzaI8ADE/JrPmmina5fMiTXcjmHDfNG5p9/OZ5WjfCBDhc/bJ3kurqhqeXfvuO+7BUCHNwQFzSCj3ChISUlgzUKjJZvvsNtLFjkFgXg28ZWo9KPOWgPQVAm41/6iXXeXbBkrPlJmHYGm2sH2tXKGoKZbAthr2nS6AdJIEI2rdqpHZ3ok1JLd1kqolBCv6CQmn1OygtBPE7c6YgI3Spb2pRjEOVn4NPG6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bFfMCuV86jnR/ilSFLrF6DfQazlBQvcxV1L9vTV3pI=;
 b=GfOHH/K+kWH6MdB18VkO9BsDDjfTTqUAiTZyzIaNyLnyd6+IFG3Jg/F+D/DEvXNF+UVlU/670gCAdzZ4RiqYrZboYuhWYLjGfthKJKQYoFE1pc0X37IwGJOYwQTXE7RE/15b6lsLh8p+oyf0IDgleIIEFD3eYkSITFS2xIAYRts=
Received: from BN1PR13CA0010.namprd13.prod.outlook.com (2603:10b6:408:e2::15)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 14:02:00 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::c0) by BN1PR13CA0010.outlook.office365.com
 (2603:10b6:408:e2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.25 via Frontend
 Transport; Tue, 12 Dec 2023 14:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 14:01:59 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 08:01:23 -0600
From:   Sanath S <Sanath.S@amd.com>
To:     <mario.limonciello@amd.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
        <YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sanath S <Sanath.S@amd.com>
Subject: [PATCH 2/2] thunderbolt: Teardown tunnels and reset downstream ports created by boot firmware
Date:   Tue, 12 Dec 2023 19:30:47 +0530
Message-ID: <20231212140047.2021496-3-Sanath.S@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212140047.2021496-1-Sanath.S@amd.com>
References: <20231212140047.2021496-1-Sanath.S@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: a54a373c-418e-43a4-2a5f-08dbfb1ae91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVIzvQ6AjlvQ9XcA9N3QqnOH+uMHTVkN79hUm1RkVNW5YDf7lzNI3LOQ4lNK4NNiMElYylfcjdO1uJulM8iYbwdpiwVDeFnv/7TAnboelO0h1qYX5e16NT/TZ8KXVy6ZqCDiPBKTW+jgqRLnt3CgGsPgfc0fg1n+czGhupcawMe0BCFq+ki1HRxnhmE0c/1SKK/kd9x4kxUi4g2zerSHPxDCdmZB0GwRFN/4YyBcQTbcFtltuPKkAnlGxnwHwNqHZXpHPfb2cG0GzHHcZG7Ypz3G8H9aVqJLLLIeuZQD6c74PGa4EkxmvRWBhWDweyPFHbPTgCHUbbEnmXx7GAagzt3inysLvhmB404AsMXzSHsX59RfHr4UqKubN9oc87cVFCUBNVLiGcRauRtydT6BBghjOZ5HnEohpc1jAZO/lfUL03L1Bplzc5BUte9J8i7T1eKqrdfgNa0MM6BkRSF/cWDtpOfiajXpjhCXjKS1nsQOTKGFR3QqDyzCGTN866oUc8GRGTSw1slCtMwPXt2J3vwCeT4srLmdCzZzQM4wL/HaijV3mP7LHEcg0tmrVR2uJXnmOKsmegky7U/81oUFQSG4pDdpnzsvskgpZHt55sa03fFTAL9s4HcpFX71nqtYDDXn+QUeS3Bky0KSIF1nOnf+gBvI5yF4nf73lmnMGW4egAUXaMjrLvBU02/aHp+PF3egZr6llJhj/q7oFIBO1hRJi5T5SUoEmG/LcXhCF3Uy8EexblzWxbJcznF46aU278pvGwJhj+NRhVcD67sjzqn/durophf2dBcAuVYCe0s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(41300700001)(40460700003)(2906002)(5660300002)(316002)(4326008)(8936002)(70586007)(8676002)(70206006)(356005)(82740400003)(81166007)(2616005)(36860700001)(110136005)(36756003)(86362001)(66574015)(47076005)(83380400001)(426003)(26005)(6666004)(478600001)(1076003)(336012)(16526019)(7696005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:01:59.7900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a54a373c-418e-43a4-2a5f-08dbfb1ae91b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boot firmware might have created tunnels of its own. Since we cannot
be sure they are usable for us. Tear them down and reset the ports
to handle it as a new hotplug.

Since we teardown the tunnels, Discovering of tunnels is not needed.
Removing helper functions tb_discover_tunnels(),
tb_discover_dp_resources(), tb_create_usb3_tunnels(),
tb_add_dp_resources() and device_for_each_child().

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
---
 drivers/thunderbolt/tb.c | 137 ++-------------------------------------
 1 file changed, 7 insertions(+), 130 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index fd49f86e0353..bfad14846514 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -151,24 +151,6 @@ tb_attach_bandwidth_group(struct tb_cm *tcm, struct tb_port *in,
 	return group;
 }
 
-static void tb_discover_bandwidth_group(struct tb_cm *tcm, struct tb_port *in,
-					struct tb_port *out)
-{
-	if (usb4_dp_port_bandwidth_mode_enabled(in)) {
-		int index, i;
-
-		index = usb4_dp_port_group_id(in);
-		for (i = 0; i < ARRAY_SIZE(tcm->groups); i++) {
-			if (tcm->groups[i].index == index) {
-				tb_bandwidth_group_attach_port(&tcm->groups[i], in);
-				return;
-			}
-		}
-	}
-
-	tb_attach_bandwidth_group(tcm, in, out);
-}
-
 static void tb_detach_bandwidth_group(struct tb_port *in)
 {
 	struct tb_bandwidth_group *group = in->group;
@@ -247,32 +229,6 @@ static void tb_remove_dp_resources(struct tb_switch *sw)
 	}
 }
 
-static void tb_discover_dp_resource(struct tb *tb, struct tb_port *port)
-{
-	struct tb_cm *tcm = tb_priv(tb);
-	struct tb_port *p;
-
-	list_for_each_entry(p, &tcm->dp_resources, list) {
-		if (p == port)
-			return;
-	}
-
-	tb_port_dbg(port, "DP %s resource available discovered\n",
-		    tb_port_is_dpin(port) ? "IN" : "OUT");
-	list_add_tail(&port->list, &tcm->dp_resources);
-}
-
-static void tb_discover_dp_resources(struct tb *tb)
-{
-	struct tb_cm *tcm = tb_priv(tb);
-	struct tb_tunnel *tunnel;
-
-	list_for_each_entry(tunnel, &tcm->tunnel_list, list) {
-		if (tb_tunnel_is_dp(tunnel))
-			tb_discover_dp_resource(tb, tunnel->dst_port);
-	}
-}
-
 /* Enables CL states up to host router */
 static int tb_enable_clx(struct tb_switch *sw)
 {
@@ -472,34 +428,6 @@ static void tb_switch_discover_tunnels(struct tb_switch *sw,
 	}
 }
 
-static void tb_discover_tunnels(struct tb *tb)
-{
-	struct tb_cm *tcm = tb_priv(tb);
-	struct tb_tunnel *tunnel;
-
-	tb_switch_discover_tunnels(tb->root_switch, &tcm->tunnel_list, true);
-
-	list_for_each_entry(tunnel, &tcm->tunnel_list, list) {
-		if (tb_tunnel_is_pci(tunnel)) {
-			struct tb_switch *parent = tunnel->dst_port->sw;
-
-			while (parent != tunnel->src_port->sw) {
-				parent->boot = true;
-				parent = tb_switch_parent(parent);
-			}
-		} else if (tb_tunnel_is_dp(tunnel)) {
-			struct tb_port *in = tunnel->src_port;
-			struct tb_port *out = tunnel->dst_port;
-
-			/* Keep the domain from powering down */
-			pm_runtime_get_sync(&in->sw->dev);
-			pm_runtime_get_sync(&out->sw->dev);
-
-			tb_discover_bandwidth_group(tcm, in, out);
-		}
-	}
-}
-
 static int tb_port_configure_xdomain(struct tb_port *port, struct tb_xdomain *xd)
 {
 	if (tb_switch_is_usb4(port->sw))
@@ -1043,31 +971,6 @@ static int tb_tunnel_usb3(struct tb *tb, struct tb_switch *sw)
 	return ret;
 }
 
-static int tb_create_usb3_tunnels(struct tb_switch *sw)
-{
-	struct tb_port *port;
-	int ret;
-
-	if (!tb_acpi_may_tunnel_usb3())
-		return 0;
-
-	if (tb_route(sw)) {
-		ret = tb_tunnel_usb3(sw->tb, sw);
-		if (ret)
-			return ret;
-	}
-
-	tb_switch_for_each_port(sw, port) {
-		if (!tb_port_has_remote(port))
-			continue;
-		ret = tb_create_usb3_tunnels(port->remote->sw);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 /**
  * tb_configure_asym() - Transition links to asymmetric if needed
  * @tb: Domain structure
@@ -2534,27 +2437,6 @@ static void tb_stop(struct tb *tb)
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 }
 
-static int tb_scan_finalize_switch(struct device *dev, void *data)
-{
-	if (tb_is_switch(dev)) {
-		struct tb_switch *sw = tb_to_switch(dev);
-
-		/*
-		 * If we found that the switch was already setup by the
-		 * boot firmware, mark it as authorized now before we
-		 * send uevent to userspace.
-		 */
-		if (sw->boot)
-			sw->authorized = 1;
-
-		dev_set_uevent_suppress(dev, false);
-		kobject_uevent(&dev->kobj, KOBJ_ADD);
-		device_for_each_child(dev, NULL, tb_scan_finalize_switch);
-	}
-
-	return 0;
-}
-
 static int tb_start(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
@@ -2598,20 +2480,15 @@ static int tb_start(struct tb *tb)
 	tb_switch_tmu_enable(tb->root_switch);
 	/* Full scan to discover devices added before the driver was loaded. */
 	tb_scan_switch(tb->root_switch);
-	/* Find out tunnels created by the boot firmware */
-	tb_discover_tunnels(tb);
-	/* Add DP resources from the DP tunnels created by the boot firmware */
-	tb_discover_dp_resources(tb);
 	/*
-	 * If the boot firmware did not create USB 3.x tunnels create them
-	 * now for the whole topology.
+	 * Boot firmware might have created tunnels of its own. Since we cannot
+	 * be sure they are usable for us, Tear them down and reset the ports
+	 * to handle it as new hotplug.
 	 */
-	tb_create_usb3_tunnels(tb->root_switch);
-	/* Add DP IN resources for the root switch */
-	tb_add_dp_resources(tb->root_switch);
-	/* Make the discovered switches available to the userspace */
-	device_for_each_child(&tb->root_switch->dev, NULL,
-			      tb_scan_finalize_switch);
+	tb_switch_discover_tunnels(tb->root_switch, &tcm->tunnel_list, false);
+	ret = tb_switch_reset_ports(tb->root_switch);
+	if (ret)
+		return ret;
 
 	/* Allow tb_handle_hotplug to progress events */
 	tcm->hotplug_active = true;
-- 
2.34.1

