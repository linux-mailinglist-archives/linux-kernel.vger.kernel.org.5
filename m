Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A92C7C8E47
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjJMU01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjJMU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:26:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E460BE;
        Fri, 13 Oct 2023 13:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5JVg7AVKfyf9NH9I/2nBNIcXKfSvdC/SK0DVl9FET+wywSvrTGpHZt+cEahES8GlozCCfSckfbriXG0IYcEnscHgBZ21OEsMCBPUZzQ3zkh6Ky30CGk81S29RTg7RsVu7dbYIXd8mEF78gt8j5osnogTSE20vRrJfrIJNKalXhZcy2WgZS7CceFwiKSon4+iNIJlz//7sHVmmKZC0QIh2PZCZ3ubKkaXCDHx2ZEL3TEB8wj7l6olJPcv2qR6mMQirb1PJrsYfnoeX5KXPZL409tLT/zqeOF+jqKRQkK6CJTtmj0JxvJJT/Eq0/8VkRkMjdMTwMjXAaki7qWtl6zBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paP205jq7Mf7YYCCvKN44Nw7wgiZLx+lCH74vmNkMko=;
 b=Lh/UD0R5FQ2JxGvj49+wRHXlh8vAEwy3rEILQZel1/Wdqm+Uo+EPXNxJfKMNRZVrnSRvIRz6k0lbVhrkO8ce3x05nzM5JpW1BqcyYNrmkIWwUo/fFKgftsjr4R5KTtrEfhRFeDsP+AauZrRmqRBbLqBThVOMZItGKQydANWRAXnWJzjNvjQpRNNSVAIzs81DWScK/MNIdH2KPFKAvS/KhOTrhddsszeWw+TzytL1++Zsfu3TDfs1JvRqXkB6EoFny8cbnKsqDwi70XoWHUahkncVO2joNLwjXqYoWsKaZDO3xfWrOOz1ZM+GYi2aI4QI1XE9KjQ3/Mrq7TNGZuNY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paP205jq7Mf7YYCCvKN44Nw7wgiZLx+lCH74vmNkMko=;
 b=W/D2BeWgppskLuGYhDKOGKSnTpnDas03dDO2LjlEVgPiidub7LaOgxCJiLZIqSVjZyCufpOi41skDfFLVEtOrA8horspbc6czmoWU3ZLTmv9ABEPad2Wnn82yYiaQOYAfnnqtVp28vp7n6GM7boBlYfKFGXXUDG1ZDgtf0Rzqd8=
Received: from DS7PR07CA0021.namprd07.prod.outlook.com (2603:10b6:5:3af::23)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 20:26:14 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::ee) by DS7PR07CA0021.outlook.office365.com
 (2603:10b6:5:3af::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Fri, 13 Oct 2023 20:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 20:26:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 15:26:12 -0500
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v13 02/10] x86/resctrl: Simplify rftype flag definitions
Date:   Fri, 13 Oct 2023 15:25:54 -0500
Message-ID: <20231013202602.2492645-3-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013202602.2492645-1-babu.moger@amd.com>
References: <20231013202602.2492645-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdc74b7-39d9-4296-33d8-08dbcc2aa5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3h7QfG8XWEPQbjehmBnzKXGjoErwMRK4p1fuuXf31uLIEvdl0HJEg1RwtlarPfqPgnwD/dlOn6shZSS3eH60CgB9EyP07jVdKAVR2dlmjTW2SLOG9H6pv9i6VKp6NrKY/XhPWybxTd8r8P2Knim6s45oF52klmt7qg/AxmZzWBaUo4jyW4l/GcCJnjBu7hT/Ws2JcWBW2zRw8BRjPhqfA5CbAdY2lyw5HT3KbCyC7ifZivq/Sc3Y/QW7b/XsESETTK6j/gJFtUGVpkoLUlZ1S5FwOEqGUpq4H4fcHQLkmCfaslfvYGNOStwfEL2ACzt0WgRdmkn3OTzQEoUr9iYu/pDQDjjtzRfgNl6dRxthYGCjZja9cUhuPT69XChNdLMSAw8u+mwFn/t8zH4aaAYI0SQyK39Ui/vAE7Bl04MzOFI/fOj81hUPr7M3MSg6rnXfLF5XCV+U/6xyd09YZ/K18r8MkDbdUxLJrGpdJxZP0rra3yufBkcrcDhj9D38dPy9HkE5ub4VA4+ukqaRCYehdBk6dDJASvouZUtGj4mBik6TCKPFjh9M5KjHNyyximV613EiuY0D4iS2fvVp2b3CAn755AXFbpaWzjYk+JsZZr8JHBxveEWTGAMyV1fM/oFQCSSwfp3l+46zyISV2tUk1CwpR6JeKHePc6Wxr7Lh+ykVZoIrHPkw+g7+2qLH7BMAEFohqM7rj+w3bTUAsQMWOt9byUfgsunyrx7RFe7bshblbNQJsOYxsu957907ipDFoH4EPssu4ZGLW9h1oaZTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799009)(40470700004)(36840700001)(46966006)(70586007)(47076005)(83380400001)(316002)(40460700003)(8936002)(356005)(4326008)(8676002)(82740400003)(81166007)(110136005)(86362001)(36860700001)(70206006)(40480700001)(36756003)(54906003)(2616005)(41300700001)(2906002)(7406005)(7416002)(7696005)(6666004)(44832011)(1076003)(478600001)(336012)(426003)(5660300002)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:26:14.3936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdc74b7-39d9-4296-33d8-08dbcc2aa5c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rftype flags are bitmaps used for adding files under resctrl
filesystem. Some of these bitmaps have one extra level of indirection
which is not necessary.

Make them all direct definition to be consistent and easier to read.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v13: No changes

v12: No changes
---
 arch/x86/kernel/cpu/resctrl/internal.h | 9 +++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c47ef2f13e8e..0ad970c5c867 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -243,12 +243,9 @@ struct rdtgroup {
  */
 #define RFTYPE_INFO			BIT(0)
 #define RFTYPE_BASE			BIT(1)
-#define RF_CTRLSHIFT			4
-#define RF_MONSHIFT			5
-#define RF_TOPSHIFT			6
-#define RFTYPE_CTRL			BIT(RF_CTRLSHIFT)
-#define RFTYPE_MON			BIT(RF_MONSHIFT)
-#define RFTYPE_TOP			BIT(RF_TOPSHIFT)
+#define RFTYPE_CTRL			BIT(4)
+#define RFTYPE_MON			BIT(5)
+#define RFTYPE_TOP			BIT(6)
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
 #define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index fe239691628a..09141f1f0b96 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3260,7 +3260,11 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	files = RFTYPE_BASE | BIT(RF_CTRLSHIFT + rtype);
+	if (rtype == RDTCTRL_GROUP)
+		files = RFTYPE_BASE | RFTYPE_CTRL;
+	else
+		files = RFTYPE_BASE | RFTYPE_MON;
+
 	ret = rdtgroup_add_files(kn, files);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs fill error\n");
-- 
2.34.1

