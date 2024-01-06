Return-Path: <linux-kernel+bounces-18670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C378260CC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492EB1C21164
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC0F9D7;
	Sat,  6 Jan 2024 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mFiyK5Af"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2995E563;
	Sat,  6 Jan 2024 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtFjnryOp7/so/PIAFiLTiKCAXp8TiWduO1tcSXtyAjniYNx0cxDYFU6eSN1lzMhmosEEAPcGyQ5psqBakNkC2ahPx9KkCPgg2jfiMVRe4Ir/8zMplFVt4uIMxqwjDW4j8AFYoKm9VCK7Ku94cDBLBwcAIpRbsERx8JROunpfP3hMokRNl2e0sHgxH294lDzKQ0ZAtaaS3ZFqaRbGbkViy5XLOxdcSFQSk7YiaR07TBBxM2y4bD0j6o7u+Dl7IiRnGs2QPCX+3SfedtAGiZ5xDAQxhtAQi0yGoT8IrJiXUlIoQkZwpE5KSv9U4pUYvnp0/QApj9t8azZoi/1+istgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG75d1RbsQ5i8KFAD28H1o+tle8JynPzlvR/lkNzQNI=;
 b=HmB8FFAwIIMvHY3pkwiP8jaRXkpvLtm2LYLrhXTefBodiEH6C5zTbHt2oeXEtQghfU0qNq+AIavdZ7/rGDK4wDTocf7R55QXkRKT0hTKekwVaU57ybAm8uI1EnCQbKfNu/LmyNlQNR18pb2Ftm7pkq0lFUFmRAwupTz8riYRZF+bQIJ+T8/0xbTHA0HVR1HNwOEUItS+cH0Egz0+mW3BZ8Kom6eRCuLl6bLdXMU/WY090LtOAOhsoYSkouvPRfOajdsfbV1uXanm6grdue28puJzKID9H24h5A3ZcvNnYv1n3Vfo4h4+uyNUFsADOcNktSPNDcjD2PSe4srx/axExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG75d1RbsQ5i8KFAD28H1o+tle8JynPzlvR/lkNzQNI=;
 b=mFiyK5Af+oAnCGqKA66/DYSHwWTu3OQ4oLb+0xZizDRCY7MrOO+GWw1Es045cvMdH1j4cyeu/ITLUBJ1UIQhnvVfL3ip/3XFShN9TEeAbQJ5q2mmBP7rQDwpWxGXOnqgHqzIN19FsSlLEgXCPmkYySuQfD1YOeZE2mMQ0ttCwnE=
Received: from MW4PR04CA0211.namprd04.prod.outlook.com (2603:10b6:303:87::6)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Sat, 6 Jan
 2024 16:58:13 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::a2) by MW4PR04CA0211.outlook.office365.com
 (2603:10b6:303:87::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19 via Frontend
 Transport; Sat, 6 Jan 2024 16:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.3 via Frontend Transport; Sat, 6 Jan 2024 16:58:13 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 6 Jan
 2024 10:58:10 -0600
From: Sanath S <Sanath.S@amd.com>
To: <mario.limonciello@amd.com>, <andreas.noever@gmail.com>,
	<michael.jamet@intel.com>, <mika.westerberg@linux.intel.com>,
	<YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Sanath S <Sanath.S@amd.com>
Subject: [Patch v3 4/4] thunderbolt: Teardown tunnels and reset downstream ports created by boot firmware
Date: Sat, 6 Jan 2024 22:27:23 +0530
Message-ID: <20240106165723.3377789-5-Sanath.S@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b4dae0-fd80-487b-8af3-08dc0ed8aba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U9q5D/Os7X4VmV/Px+fkbMu/5hq5OiJVzn/8iu7mbWH3vhA1PDZR9m4NNrwBVFkxIKc7eVeeSMpyv0xqDn1Hso3IPqj4X3y9kRGItGPwIcsnsnA1uXJ2I/KxB2r+dFLZ9dW0mdIh0Bo1pu+yNymX2jlAtZFjVHS8clyuEWQea/Jqdle7ALCGPDhoYPeBxt+WNSPaZIqJyWIqRCGXpW4jfG2YroAB316S8F1rfMpZLg2nn/9JcmIlLQ4BcmDPzKrjEUwAHvod46GAMgv77rIn2hN5cdM8upunt4g1dZqgQyug3zY3JAmbSEguJFmgJNjyR4qRkaoPZw5mtKz3MGKyvSoTHoFr7L7gtHtFqAk4OuvH98mQIZVQKQ3S73j88DPoc/SuzqB28ytxsVX0de8XLVEwRtbzx5Ko6PUpYTfkAWufB4uuV4e4aomdEsgS7p1rhEV/4D/zuPAs99uwWVxdB9eT1ubG34UlfDOBNe4cfG11atp83yl8YYXtG9QpPyHZeP7m9AMkbWGk9y9iHpIF+dqO+kWa7mziE/mmcEbCAYxgF1fBf0IRS5e3nacBHulXJ6n6u5k2YEznVcqOS6RUH+W1vftdrv7OnlyVdx2dzKFsSFcZa/tR9LwyHWg2HhUos3suNj/rSVtwcnJlc2MN9qQRnaMqkKYMT1cV0BcEWG1FN+vWpwTyjKfiwntJyDWE5hQvkHz0GrGtpUIXVNTqJ2QhnepilNHTibmYXo0FTTunxbYP+DRAb35wG0UAyQE91f0V6h0LSE4D3gLPxXzdYfTONW0Ty9aQDfQl72QSnDc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(83380400001)(336012)(16526019)(426003)(2616005)(26005)(47076005)(36860700001)(316002)(2906002)(8936002)(8676002)(4326008)(6666004)(7696005)(5660300002)(110136005)(70206006)(70586007)(478600001)(1076003)(36756003)(41300700001)(82740400003)(86362001)(356005)(81166007)(40480700001)(40460700003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 16:58:13.3148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b4dae0-fd80-487b-8af3-08dc0ed8aba4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167

Boot firmware might have created tunnels of its own. Since we cannot
be sure they are usable for us. Tear them down and reset the ports
to handle it as a new hotplug for USB4 v1 routers.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
---
 drivers/thunderbolt/tb.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 740bf2ff1fcd..462616e3075c 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2596,12 +2596,27 @@ static int tb_start(struct tb *tb, bool reset)
 	tb_switch_tmu_configure(tb->root_switch, TB_SWITCH_TMU_MODE_LOWRES);
 	/* Enable TMU if it is off */
 	tb_switch_tmu_enable(tb->root_switch);
-	/* Full scan to discover devices added before the driver was loaded. */
-	tb_scan_switch(tb->root_switch);
-	/* Find out tunnels created by the boot firmware */
-	tb_discover_tunnels(tb);
-	/* Add DP resources from the DP tunnels created by the boot firmware */
-	tb_discover_dp_resources(tb);
+
+	/*
+	 * Boot firmware might have created tunnels of its own. Since we cannot
+	 * be sure they are usable for us, Tear them down and reset the ports
+	 * to handle it as new hotplug for USB4 routers.
+	 */
+	if (reset && usb4_switch_version(tb->root_switch) == 1) {
+		ret = tb_switch_reset(tb->root_switch);
+		if (ret) {
+			tb_sw_warn(tb->root_switch, "failed to reset\n");
+			return ret;
+		}
+	} else {
+		/* Full scan to discover devices added before the driver was loaded. */
+		tb_scan_switch(tb->root_switch);
+		/* Find out tunnels created by the boot firmware */
+		tb_discover_tunnels(tb);
+		/* Add DP resources from the DP tunnels created by the boot firmware */
+		tb_discover_dp_resources(tb);
+	}
+
 	/*
 	 * If the boot firmware did not create USB 3.x tunnels create them
 	 * now for the whole topology.
-- 
2.34.1


