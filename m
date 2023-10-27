Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1FA7D8E50
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjJ0F4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0F4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:56:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91221AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 22:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD6kBb9/NaYwLq4BUve3kW0FFK4ADaKyvwwsaPqHTi43WHLJrXUCWPgDVUWiCmwOlCJsL4DibgIL657yACAFtNOa3Vg66sNL+GlVpfQwC32EPrdOUXM+vFJTK6oJGZb9ctndeRz++52rildlJ1Qjw1gOg8uBlFKA5q9z5+UolF60VBvwBtMoVpJXjyJCp85v9gxW2ygY55dzSNWJMcSrEDffx82q/lXYKrXHPkqgEGY7k57Be4lnpFQCMWks2B9Xfihw7Mggl00JqiWMxVFecQzUUX9ASFs7Sl21vbKCYmgK87ElQHiV/GJO1bBVaMcOMeCfyzHkr9c982tP7UGBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y6pyqOswqHc7gWd/t+3f1r5xhtx8+CqSyAJVcgFok4=;
 b=nHNjXikFfi9ItRJB8rTWSYIMBSdCf4KChoSCUdVJK1rDhA9NDUcZ2XFptaY+Q5KraalNkxIJx3GYAfln4oN8HnWaCX8C5vw5mHlo9Vaa34JG460r06Ygv4hq/Ozhk5UPXtsbK4MAS88VsVzTByvdpSreu6Go14Rz2Ow9G2/C5afgebgpOxFlGygv2PL9J8PdRFi/fpcS1+ZFKJWe8jG0sd1sy/C2b/Ra0U0FiIq8QQeqT1aeKUHj7cdgRGvD+F6jYabMyXkYJmeMClmurcITMRtovX9T0ClYN8X/Ayd0Felp8NDXIDq1BlnR13xmE1MantzOJ+wFXarSqFaJl4S08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y6pyqOswqHc7gWd/t+3f1r5xhtx8+CqSyAJVcgFok4=;
 b=iZLylvTjGdrymHMaLA3fB8IE5uG4Icv8iIbXtMn+AtPbsBYdyqhYTPrJnlKTfsH55zsPxXcJCRbqe7FBFcz+w1zAtJN///WjbFoQfnfnzF9BOdF/IscmVLWhpvl5iLzIL32TUa8X9s0uhaGVpDTVkfCVuVy5wfi8Rfa3VkzIjxo=
Received: from BLAPR03CA0063.namprd03.prod.outlook.com (2603:10b6:208:329::8)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 05:56:29 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::fa) by BLAPR03CA0063.outlook.office365.com
 (2603:10b6:208:329::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Fri, 27 Oct 2023 05:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 05:56:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 00:56:28 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 27 Oct 2023 00:56:28 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc: xilinx: Fix for call trace due to the usage of smp_processor_id()
Date:   Thu, 26 Oct 2023 22:56:22 -0700
Message-ID: <20231027055622.21544-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: f5972e75-d61b-4893-dd59-08dbd6b1769f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nu2TVRYjW7xj7ERtLv78rzDczKvACmtnc4khXwscL+zL+xEBU6Cz5rV/TiGMfe0RRWqY5VlgS+qsZEcRuBZKcE1Rk2NJgepPy96+/+dslU9nWw0BQ3zAEUboMn5UmefTdiWUjXB1bC+a60UGNJSmfk2ZUKWOi8Yer3Wm5wX8TxuWqqewJWPkuAzgq6Npgu1m0UF72HLB0a3NBgjTtU3eW6a6hcMXLW5GYoqo+VAyTG9IyFMIEl4iu6qYLUlp9C7cEpqpW+ZGGRH2ar3SXN8JHsVEaUdvhxn6A96ZHe8wU3JwoJAfUBf+M4GejvCVtPowFHY7wOe1zNi+CwcdZtLWZRuppQX1lGnmXKl66OjkPpX/f20pyDpx8/3IJMD1dpv7ftRBbKOGo5Uen6TaL5fsHebd1T2U0W30UCrwFYrMkFyGpscGnTzJ2KY6ADEOEbDlREe3T3Hx7qhxYTJ0sg9RLB813P7EX13unh68XBh3dwekZJGAlAiIHueK+QpLSEH7o/KTqDE1FpukZxFOL6NRUo91IzUicRjWRg4m9SY7J1SOoMjplvgJSPsuShqAotoHWN965pIGEuu1uUVHaJZQTvgpHA+YMcs8CgYDOEeZg0Jik+026MvI9y6F42jaQVkiWfVNCXls7zFCdqhnqzpxLCPoJ8St1Uh/klwep5elQUmh8/xVm4kispa7KFAWbkm/uexZViAFQuwVBI9nNs4UZUEYI7kPze+oAEbQw401XCvZTiCo2hEryuH+AVXNzpVHcFxVHbTta7PVC9pddo+vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(86362001)(2906002)(83380400001)(36860700001)(47076005)(336012)(426003)(81166007)(1076003)(40480700001)(5660300002)(356005)(2616005)(82740400003)(40460700003)(41300700001)(44832011)(6666004)(6636002)(54906003)(316002)(70586007)(37006003)(36756003)(8676002)(478600001)(4326008)(26005)(70206006)(6862004)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 05:56:29.0332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5972e75-d61b-4893-dd59-08dbd6b1769f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: HariBabu Gattem <haribabu.gattem@xilinx.com>

When preemption is enabled in kernel and if any task which can be
preempted should not use smp_processor_id() directly, since CPU
switch can happen at any time, the previous value of cpu_id
differs with current cpu_id. As a result we see the below call trace
during xlnx_event_manager_probe.

[ 6.140197] dump_backtrace+0x0/0x190
[ 6.143884] show_stack+0x18/0x40
[ 6.147220] dump_stack_lvl+0x7c/0xa0
[ 6.150907] dump_stack+0x18/0x34
[ 6.154241] check_preemption_disabled+0x124/0x134
[ 6.159068] debug_smp_processor_id+0x20/0x2c
[ 6.163453] xlnx_event_manager_probe+0x48/0x250

To protect cpu_id, It is recommended to use get_cpu()/put_cpu()
to disable preemption, get the cpu_id and enable preemption respectively.
(For Reference, Documentation/locking/preempt-locking.rst and
Documentation/kernel-hacking/hacking.rst)

Use preempt_disable()/smp_processor_id()/preempt_enable()
API's to achieve the same.

Signed-off-by: HariBabu Gattem <haribabu.gattem@xilinx.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/soc/xilinx/xlnx_event_manager.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 86a048a10a13..edfb1d5c10c6 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -555,7 +555,7 @@ static void xlnx_disable_percpu_irq(void *data)
 static int xlnx_event_init_sgi(struct platform_device *pdev)
 {
 	int ret = 0;
-	int cpu = smp_processor_id();
+	int cpu;
 	/*
 	 * IRQ related structures are used for the following:
 	 * for each SGI interrupt ensure its mapped by GIC IRQ domain
@@ -592,9 +592,12 @@ static int xlnx_event_init_sgi(struct platform_device *pdev)
 	sgi_fwspec.param[0] = sgi_num;
 	virq_sgi = irq_create_fwspec_mapping(&sgi_fwspec);
 
+	cpu = get_cpu();
 	per_cpu(cpu_number1, cpu) = cpu;
 	ret = request_percpu_irq(virq_sgi, xlnx_event_handler, "xlnx_event_mgmt",
 				 &cpu_number1);
+	put_cpu();
+
 	WARN_ON(ret);
 	if (ret) {
 		irq_dispose_mapping(virq_sgi);
-- 
2.17.1

