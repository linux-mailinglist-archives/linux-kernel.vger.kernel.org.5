Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6805B80F66A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjLLTRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjLLTRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:17:40 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A9C83;
        Tue, 12 Dec 2023 11:17:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmTDVyaKGiGfTl6l+gk37ORfYsHy6e0OE4pGz0d6bbixR04pbivOHR/L05k1Q0sCyu6pv5SrGayCfd6Ew2Gvj9RtfJs0bo6wABG9sQAMH/Huvm9QwTAEhu7wQyR0C3+M5+hhg+gWDUQxVUEShFM5wHp8zWO2ChvtzT2zyL3TaiU57mNvDJ81wrkk8UWTQW01bcRtER+YRRHrCHHqdqi483FxieSlvOM2Yl5+zvbZGAkdPsYtzLEdqamU8ItVpo1crGhpVVFIuK0t0gMzM4yHhz7445b8b0xNgu9CGpCdHPApPuiGkw6AU90T3ludAA4eFw0rhmRG4dev1KSH6bNscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQDGNZV+kRUa8WSgBqwG6IHrtd7fj0+dXeO4MASopj4=;
 b=nsg18xKlhn+akC0CR8cEc9DYCmNFlh8LMelei6u9nzT6lZrmcqp/95xdM3m5X7iGswHcR7uOfXvsxRts/kUSKktqTl7vY1sP+/oF+46tXnCJpR2zQRTBrxJK/JX0y4eD12IFWbTwVUnQs3U+5zH2n3tKcd484RNSFHBaHx3pHXwnT/FCxdfbgeZIz7ATPHtkoOq2zgcmyt+MCL/e9W/5m8VOJp9vH4ft7JC9sqOqpr0dNMCIYcI6Rr+//cPbeQqy497IZkCYsnX7C1+r+vLx7VdmCld8ZYmW3b43tO1jghYS+UV7s8/lFw4tocvRdk/1iAU/9Jja2okBmlftsdoozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQDGNZV+kRUa8WSgBqwG6IHrtd7fj0+dXeO4MASopj4=;
 b=VpolDjF1aG8N7mLK3hQ+HYHD+tYYtmbJU3zpFP/b4ToNf66iunzP+tIY2VoQwpC+ZY7MdhHtIJCHratH+rNx5rizVW3IOk6eq1ZTfz1uUEWqK10CwTLtNMpgMcwGzeDWMjwbUnERsBnBiQQ0TUCLq1VbwaKTrDfNKcPuf5X4Zik=
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 19:17:42 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::3a) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 19:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.7 via Frontend Transport; Tue, 12 Dec 2023 19:17:42 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 13:17:03 -0600
From:   Sanath S <Sanath.S@amd.com>
To:     <mario.limonciello@amd.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
        <YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sanath S <Sanath.S@amd.com>
Subject: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream ports created by boot firmware
Date:   Wed, 13 Dec 2023 00:46:35 +0530
Message-ID: <20231212191635.2022520-3-Sanath.S@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212191635.2022520-1-Sanath.S@amd.com>
References: <20231212191635.2022520-1-Sanath.S@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a6067f-bf39-445c-8050-08dbfb470396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+JAqKy5zjbIAgzjZKD4sH7tae3ALMcKO7d7PbyddRMmkY8YsS4qDEfzXgqkFIdLQXBRF0SKrnx6wMc8qJHFTqhSwsELkQ31hCfZKu5S+3K8t9XmKjKegVkyiptUixzsyV7MgKtaaxSDMGdfreUpcGOJlVCxKYgi5NZOVaRk4pJVg/cvQmEidXVpA40V/RhAxtAUhYt4GSUY3I43zTIX4NZocg/a6kWxG5GlSbgHP6cZkzmsZdsF1DAjCjQ5ORbAdJm7sBm6P6ftNukjFIi0dnC+QRlfSEpO/DPvPPVBAUNmj5M4J5e/6Ne661oHOjT3FLiHpKPltNhAfzR2ULXfZOEkSgCaGJjhU8y1xIM96bj3tcUD8jDHsm2BNB+wJv8t8r5eqVrCKoK6rxTjAysMxwNqNgiItjD+4aPJGE+xYIhdIghMEwy58Pg/uWLucTvu9G0qlaPW8ccdUQ3kVhafeJUAQk7HbfuA6uHtXhxCNmj3MZNRLQ30n2v1ZfBC0KmBtGjObhL3XDD7uU5cVKBwBUs7x4aWEwsBmE6OzxVsGzF6dcdNfo6AQjtHvklnOudS/1k9yn7rdzJvDO5G6o84PK9eUYqgOdoBkGkSg5xCxyymcuBfNVE6EHUSsq1TQAoTfWZPll1m+rHqWsJOZDqf3pQHayKW59u5qw4sLWT3lMtATu5XMi5cb1jbugNxVCPBlh7FnCtjWrvrFcgvJ1gBHCm6e2n/B98yKLbZy0lArq/f/6Yst1MrvboUuXIub681
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(46966006)(40470700004)(36840700001)(81166007)(356005)(36860700001)(47076005)(41300700001)(1076003)(2616005)(426003)(16526019)(40460700003)(336012)(26005)(36756003)(86362001)(40480700001)(82740400003)(7696005)(6666004)(478600001)(316002)(110136005)(70586007)(70206006)(4326008)(2906002)(8936002)(8676002)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:17:42.2939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a6067f-bf39-445c-8050-08dbfb470396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831
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
to handle it as a new hotplug for USB3 routers.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
---
 drivers/thunderbolt/tb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index fd49f86e0353..febd0b6972e3 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2598,6 +2598,17 @@ static int tb_start(struct tb *tb)
 	tb_switch_tmu_enable(tb->root_switch);
 	/* Full scan to discover devices added before the driver was loaded. */
 	tb_scan_switch(tb->root_switch);
+	/*
+	 * Boot firmware might have created tunnels of its own. Since we cannot
+	 * be sure they are usable for us, Tear them down and reset the ports
+	 * to handle it as new hotplug for USB4 routers.
+	 */
+	if (tb_switch_is_usb4(tb->root_switch)) {
+		tb_switch_discover_tunnels(tb->root_switch,
+					   &tcm->tunnel_list, false);
+		tcm->hotplug_active = true;
+		return tb_switch_reset_ports(tb->root_switch);
+	}
 	/* Find out tunnels created by the boot firmware */
 	tb_discover_tunnels(tb);
 	/* Add DP resources from the DP tunnels created by the boot firmware */
-- 
2.34.1

