Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF34F7D533C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbjJXNwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343676AbjJXNu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:50:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2A51FF9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCVhIfWJUw28GHQ/bNboHYiYcgRUadBOxIHtTm14/3W0ytbCwd8mStUSBD7daUhsn7YYORuQ430NVSFJr7OnNnYT2pnodiw3yDLmCWdAYfRrM8/j9Vr2taTVX4RBwFtTGsREaI//6Bd57Q8/dtYl27zlMG3SdAdYV7ljzwB1TXqDijK+dZzW6qPSX3yCbpt/seFNlfQ+UFVVuzvRRoGJX/yCSfs+XBcW6CCAQ10qisojpxELuzTOkUg/ZAEDsuiUOuW+/U2e01v+lP0KnvjXXcykjsDZJUT/MMM5Z4sOzdC2rvdma/1WYGuA1rhZueh0Cv3ewYR8YJaXxNXvmaPR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aL6jhokH0Ke8eu6Zm1u1KJSrGEii/gWKhp5AojLr2Y=;
 b=j1DwIrSfeCKPKtknlOFng6e/C9ed5Af3OpkzXfohO/IF6udelRbFAX/HWN0LAeKNIWQBCOXnNfJOxXRJ33Sh1Q6nMoQeQjsvcp9+cPPGYuhPJxAn9eHVf7lf0heCZwSY4wG3Xten6SorrIYL9+OA5sUieALgT+I+c1kteAgPxfM6SkCYMW2a5tbLNjFsAQ2/hJSY9TA285Geub1HbfPYumawpj8vg8xMU8W3ym2f/EJIUbtgS2khXJxq+P8tIqB4NVp55fiIcldl7QwNd36UkwVC0q8xVnjq7j+oX9tEDAyUdXaPl+cHhGGd3cyWW4PiJ3kKkmJJlB0XOLY0GJGcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aL6jhokH0Ke8eu6Zm1u1KJSrGEii/gWKhp5AojLr2Y=;
 b=OoY02+rySkj9grT1+ACDjxuILKi8EpdCCyB9Q5SkGcWVFHZNnOFDSJ1tZm2eJtXPMqnUlbT2rFb+bSesoCR3XkoZUap8FkyLH3cO0k3mfY2Uf/g+vlQUFHY/SsmEOdqmZ8cg3zfMkWoKuJke6VWuBgMSsJgQVHywYj0r7wcHrNY=
Received: from DM6PR13CA0026.namprd13.prod.outlook.com (2603:10b6:5:bc::39) by
 DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.29; Tue, 24 Oct 2023 13:48:06 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::d) by DM6PR13CA0026.outlook.office365.com
 (2603:10b6:5:bc::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.15 via Frontend
 Transport; Tue, 24 Oct 2023 13:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Tue, 24 Oct 2023 13:48:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 08:47:42 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Raju Kumar Pothuraju <rajukumar.pothuraju@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 3/3] microblaze: defconfig: Enable the Marvell phy driver
Date:   Tue, 24 Oct 2023 15:46:48 +0200
Message-ID: <3912fb168671dd5b418da8947ea1c463b554fa86.1698155190.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1698155190.git.michal.simek@amd.com>
References: <cover.1698155190.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=789; i=michal.simek@amd.com; h=from:subject:message-id; bh=lLWtOhzQHTFRDHvedh8q8/DtJJP5kojMPrkm8gBDiZo=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTzU3uMRBd84tKTdTM+1sZaaZh5qkOgXsJg6mHuDa/eZ DG9CTDtiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABO5dJRhfumn1Vc2hoVz35rW 49K6/6qrqF7XYYa5UvtuvH78+OBsgegl93i2Br+0E3yVCgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f1ba4a-d14f-4327-7133-08dbd497d97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVklr7fttgxLAEBDj4PFV1KtOuuXmfihhKVVEhcMDUCLfGyUWeeCoYe6qWeDkhpZyR3+22n4kJqiAkFFoE9zwENKv3CW2LQNW6aiRbjrZov29ji08sCZoe8CrkZjj0y139xvbFGdjKmqUhfsij2hFsjdGtyu3zXy72QAt5luUBteDVHYYbhJvXzM1mI0O4bSvahMjuSquv8vX+MHc1v6TfKweV/ix6U73TVbSQzrT+3t2iaWstDOS2C/joKb0wa0pjbPWRBfuuO08aC42TgGFcDt972GrGYiVDHTEKgICFt8R3MlbAfsIvy3J01VGBaMWrYBxeXrRhu/ht+iagA3eHygYoS07BQZTlBzoy7GjJWT5r5jlwX4Jxa9Z51ahTUN5zcUzubfXcxdecMG+pqmB5Bn5dvQQscJ4FJJrmpKLqt2ETk0ZnyxX11RSEUdd5ZYchzbJbXyOpJsrpCcn8il3fKpGWeLZZ700Q24ALwk2SsYFHrGZmL/3uwHeO17zJkFhLywlmT/3//l3O/6wK4318YQb6JwUR2+Jdsvqxmaxlg6I7qlsiz/xxkvgKLVqXkfgKvnmuBAJ4XxbCv0pJTa80oR88Msg6h1F3+Pqf8rH6JPPQuD5m2mQ2zKbLDGSdCpLrbaf9tP/Z0AVpIgcS6JzMKmAXoKJPmycuLOkS+feHlzGtUi5JMH+YODHcOpiAlm3P0Jsc/05v7tRQyMBrOjTkzXjBPdwn6Erw6q7wXnIP/ZS+LmOqx1PLj3fwfIMydyWGixjYAC6J/zUU0nWBjahcBCh87i7WDMw/zUIm2O55I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(46966006)(40470700004)(36840700001)(4744005)(41300700001)(2906002)(81166007)(54906003)(70206006)(82740400003)(316002)(70586007)(478600001)(110136005)(16526019)(336012)(40480700001)(47076005)(426003)(36860700001)(44832011)(40460700003)(86362001)(5660300002)(4326008)(2616005)(36756003)(8936002)(8676002)(356005)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 13:48:05.6434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f1ba4a-d14f-4327-7133-08dbd497d97f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Enable the marvell phy driver by default as it is commonly
used PHY on multiple microblaze based evaluation boards.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/microblaze/configs/mmu_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index 85afdb377f73..4da7bc4ac4a3 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -44,6 +44,7 @@ CONFIG_NETDEVICES=y
 CONFIG_XILINX_EMACLITE=y
 CONFIG_XILINX_AXI_EMAC=y
 CONFIG_XILINX_LL_TEMAC=y
+CONFIG_MARVELL_PHY=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-- 
2.36.1

