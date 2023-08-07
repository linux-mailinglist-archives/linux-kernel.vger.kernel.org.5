Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588D1772548
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjHGNSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjHGNSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:18:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91828E43;
        Mon,  7 Aug 2023 06:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqJDh/IsQwvcd66B8o4xgRRIs2zEq1kIk5mQXi5pnqXBbm0/6HVxCMVY6MGh0gy+zHAKDIGiq9nbjQwqED6db0ZnhcMg7zFfgSkknPDGRnPD9eTdPOC//r3J5vpf8tAzlx0wgaXpVsD2wK3JHjU6esE9VK+BSU7hCH1elMxF8tM1bf0FVMrDD+/MrjzFkXafXllS1Dc9taHqZqLMVsvxAsjcMM/tvHbtcaNM0cCknQTrQ9zwyamUNgjfSUpVRpfIm1uw+l2J7skiiJtNvZKQgqGsN/OFCwFh8h+mo/D6gmN+BEnP1n4GC6sW1xJrxRS8uK6r7v8b6l8bp7BoH47jGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf1g97LwgcR5dH+cutavnADHry3axcnxPgJ/+79jG/o=;
 b=fOSoGJAzOggk1GCmJCnPHOp69LLc5w/2LoqkhsAKI+KZbvAOy6VjGul7Xn3COHtQFj0lanX24iSCcT4bjRT/ZK0NXHYVNnnO9V0b0HOWi+mItwQ1MbUkj7nP28tHEZARm8ZmIc9XpRV4uU8cATng4mpN/sEwyqC0f9GfXE7daiPjk7xc44S7y51kL9pnRlyIX1s7CYigMwmeGEn/rE18nljyGYl3Y/5TkrgDCXmximN0CE2CLRMRbKEiQDmniohcK4jPtDSN0AKrA17r7pFoBkHzn6UpHqA3OHbkIMoYLbuXJf3P3jnx/Kbp7x+JAkGeLn6P3wIHoLKygjuom87Uww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf1g97LwgcR5dH+cutavnADHry3axcnxPgJ/+79jG/o=;
 b=PLrlJINPn8TtMwTpem9HKz1PlKlR9xm6xAHbgzJmfxmiBU7Bwi3uV31+Qnej6K2z5v0nPjA83JOvTVEAayJsIaqJ18anniuYxWpfCVF4pOL45lCbOHX8XYsRMaUogUA2LBrfnwvWZ77sfkGqc47vKxzIHswZspBSEV+lhEWmgD0=
Received: from DS7PR05CA0079.namprd05.prod.outlook.com (2603:10b6:8:57::9) by
 BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 13:18:02 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::cf) by DS7PR05CA0079.outlook.office365.com
 (2603:10b6:8:57::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Mon, 7 Aug 2023 13:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 13:18:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 08:18:01 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 08:17:58 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux@armlinux.org.uk>,
        <robert.hancock@calian.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net] net: macb: In ZynqMP resume always configure PS GTR for non-wakeup source
Date:   Mon, 7 Aug 2023 18:44:51 +0530
Message-ID: <1691414091-2260697-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad7d27b-625d-4d39-33b4-08db9748ba66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nn0BwYggzmrpehV8Nv4EJ4m5lQtv+VZslsE7gf/Z90qgOSs5nGfTrI4scWh+vOzbTT55E8GMR/3qFZtSkEdBqJvgfJTSZFMi6Qcd08OVr+Dqtdip5SeyGxy/jLRHGvPrITCPykz0MKqU0tEeLhBvljLInFOrw6CVyRiL1+qlqT4dOEQ+i2RJZNPiV79sQVY87Mj8nasY7lHM13929HFiPshUfr+DV66T+sgqoSVi3+ivgYN0q31XSolKqizjnGOyQuHO38kU9J+2pUcN31YuTxFfNY3Znaywn9Nb617hHOSYokFfcAa7VS9pEWizLU0Ic137YlEegwyK7i2OWETWPP6kgCiUvBbvndX4B+XVwmtxMGg4dxKGlhIvX4ChND/rSEbU8aZy6PXGx9b7mUZeOOj3mNOrI10z+8ivYZeotba5gcR1qe0sfLWAclAHM9oNpQCFSBFTd0ktD7DNdOyy47XLlZ5zDyL1/9WGyN4LvaZC7YixAbEYwF1h2Gz/mwLbjwDDG0jAuQbo7Il9s58jEm1xh+BIbO/cEgb3PYKBrNcCjrRQR+4lTEmjZYMu00PfCArc+GxIgSAdIVxDkAEHFa1nWkvG7Nmx7MCh+xmEJrTSfkK700ny2FDjELKkQzMdZXJamZkplD1dicj6+ceFw8jeq6rj4SNZWFc43QVa3X8eNedNIVOi5lSY4eZ9DisihPxsWaZuvkh/GXrADjKchYEwnWoVD8b3gWMG+6x4sUs7ZtbS5iC1ALqpCHQtUtyhjv8vt0X8KNrFsQIOm+LMfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(82310400008)(1800799003)(186006)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(2616005)(6666004)(478600001)(86362001)(82740400003)(81166007)(26005)(356005)(36756003)(41300700001)(316002)(5660300002)(7416002)(8936002)(8676002)(54906003)(110136005)(4326008)(2906002)(70206006)(70586007)(336012)(47076005)(83380400001)(36860700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 13:18:02.2819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad7d27b-625d-4d39-33b4-08db9748ba66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Zynq UltraScale+ MPSoC ubuntu platform when systemctl issues suspend,
network manager bring down the interface and goes into suspend. When it
wakes up it again enables the interface.

This leads to xilinx-psgtr "PLL lock timeout" on interface bringup, as
the power management controller power down the entire FPD (including
SERDES) if none of the FPD devices are in use and serdes is not
initialized on resume.

$ sudo rtcwake -m no -s 120 -v
$ sudo systemctl suspend  <this does ifconfig eth1 down>
$ ifconfig eth1 up
xilinx-psgtr fd400000.phy: lane 0 (type 10, protocol 5): PLL lock timeout
phy phy-fd400000.phy.0: phy poweron failed --> -110

macb driver is called in this way:
1. macb_close: Stop network interface. In this function, it
   reset MACB IP and disables PHY and network interface.

2. macb_suspend: It is called in kernel suspend flow. But because
   network interface has been disabled(netif_running(ndev) is
   false), it does nothing and returns directly;

3. System goes into suspend state. Some time later, system is
   waken up by RTC wakeup device;

4. macb_resume: It does nothing because network interface has
   been disabled;

5. macb_open: It is called to enable network interface again. ethernet
   interface is initialized in this API but serdes which is power-off
   by PMUFW during FPD-off suspend is not initialized again and so
   we hit GT PLL lock issue on open.

To resolve this PLL timeout issue always do PS GTR initialization
when ethernet device is configured as non-wakeup source.

Fixes: f22bd29ba19a ("net: macb: Fix ZynqMP SGMII non-wakeup source resume failure")
Fixes: 8b73fa3ae02b ("net: macb: Added ZynqMP-specific initialization")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f6a0f12a6d52..82929ee76739 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5194,6 +5194,9 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	unsigned int q;
 	int err;
 
+	if (!device_may_wakeup(&bp->dev->dev))
+		phy_exit(bp->sgmii_phy);
+
 	if (!netif_running(netdev))
 		return 0;
 
@@ -5254,7 +5257,6 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	if (!(bp->wol & MACB_WOL_ENABLED)) {
 		rtnl_lock();
 		phylink_stop(bp->phylink);
-		phy_exit(bp->sgmii_phy);
 		rtnl_unlock();
 		spin_lock_irqsave(&bp->lock, flags);
 		macb_reset_hw(bp);
@@ -5284,6 +5286,9 @@ static int __maybe_unused macb_resume(struct device *dev)
 	unsigned int q;
 	int err;
 
+	if (!device_may_wakeup(&bp->dev->dev))
+		phy_init(bp->sgmii_phy);
+
 	if (!netif_running(netdev))
 		return 0;
 
@@ -5344,8 +5349,6 @@ static int __maybe_unused macb_resume(struct device *dev)
 	macb_set_rx_mode(netdev);
 	macb_restore_features(bp);
 	rtnl_lock();
-	if (!device_may_wakeup(&bp->dev->dev))
-		phy_init(bp->sgmii_phy);
 
 	phylink_start(bp->phylink);
 	rtnl_unlock();
-- 
2.34.1

