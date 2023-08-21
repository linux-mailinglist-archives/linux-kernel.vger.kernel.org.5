Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957AC783650
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjHUXb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjHUXb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:31:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BEECD8;
        Mon, 21 Aug 2023 16:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKOytcUMZpIXs2PFUBUNS2vojxma02lTihr4n3Fq/O9Zr3cAk+lEl0eHVXoNWi0jJ7fBxJVj2k2bjvx+0WC0HgxZ9YpUM9AEcaufsV2HtkOWR+jEFoYjvRLPRdReWz7ZCqPOjBmAimAenlCr4h42q7k+i2jyAiV+07VUr1zFp7m6hlj8VTqYCtxvFTdil7A/Yp7zQCQh4FdhPtVdq+rAPbQfIVhYbMrccyssKtn/SMTmAQsI51m7OY5bqUPbTLTpLqDNvntDBSgomDKc8qAU1vRV8Me3E4jkN/D4gvRvpTbi/L0md43/bhT3szpnNMtus+UitUW5F0zO4RQmZ6BS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EQ53POh1e7IyFtIwBNyOmrheFBOnyi8T0DZ2hEa5UM=;
 b=TXcWQs8No0jlq1FuFkVaTWOkO13QAyhiaARZAO8rRUQFbv3+Y/XvN/QJC5uWBHGfrOZSED7jVTC4QtcQ4ii7IJXUxZt6GO6EuUxcyvjJxaS+UXNRGSSGGd+r2FUGshkHvaSzzxYMl8rMjVsbP2+7FQn4SveovcD919vLV2jgGA9CChZBlz4qlXMZJN2ppP5AZ3o1XTfQE3E5J33LzGROh/LBKZOBcryc2Pp9CggvcyB9gMTOGXqF/ZQ4jfdswpdT17QiU/SrKFQXsaj6WO6vJQsfyEgSYb0P8EsFjzPiDkzlFu/njHY4GrKo+1+ZiSDg39WBGRxivmiEkkvqrpVVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EQ53POh1e7IyFtIwBNyOmrheFBOnyi8T0DZ2hEa5UM=;
 b=L4rF6PFSe/frHNJszO6u6HDe5X+/PUNauHDYOTVrmFSBrXrVuZoqtQzfk9XXBW1YjXpfM0oZ5IL2aXxNzZmdIeC7u7BeIhPyCFxzWVQp70UFUT4Eu57SjYdE68lOfLMXe34fnn0CQVbAJX72R2sLB3oUaWL4cQfFovGgrQd/00w=
Received: from SJ0PR13CA0054.namprd13.prod.outlook.com (2603:10b6:a03:2c2::29)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Mon, 21 Aug
 2023 23:31:09 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::ec) by SJ0PR13CA0054.outlook.office365.com
 (2603:10b6:a03:2c2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Mon, 21 Aug 2023 23:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 23:31:09 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 18:31:05 -0500
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
Subject: [PATCH v8 2/8] x86/resctrl: Simplify rftype flag definitions
Date:   Mon, 21 Aug 2023 18:30:42 -0500
Message-ID: <20230821233048.434531-3-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821233048.434531-1-babu.moger@amd.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 47fdc983-b26e-4aa6-4066-08dba29eb310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33HyJDn8udo1/h78C8wqu6HWIVpx6ApXYDGD6MWPeHyl7w4w+PyZjG47cQHtvv71DODiWiF6jd13dckmfvuNx9Ciflx3bKOusaiQ+SqNP13VpCJe4kmz4Scc6/WBuuVC4jk968MkTeiKpe/aHIR9EzXcC7H7vs3OAbipl7JtHJHpARhfLi80J0QnIaJLKYaV+Bo4rlv81VOUgKc9gsT+28lSIPWNGfqHrZemwLrWWbMi+gOcKpcVilf3MAEw1Bi/+x3SRPc20cjyTWaYNpzEXuB4VRKD1A1Jq8nIcsBomvH/UeLilObn09G66p4ZCCRqHHBrJ4+s6WAxntpeciLqVoUksFDsBXKbLBtkq9TS0e977Vcp6BuSNW559VHAwKxEs03/n105zgeOPsoklCYsibXUemD9P58IDX6wIQ2GdnEFdj1J1jHc5K3uVP/1m8zdqS27ex+dTx5h42sN9WiV4aSrNl7hDbzEVgwoxw4dEGKKdIC4uqjDMpc09t1A4WgfuyL7RIuW0Q58C6kc5lP+LV4/+6RWnrYQYl6sJk+nQQOfQbNDYEu1NTYYvGd0FuHyZNOcFaaE8AzEL//jhIYjSRE8o/jYVfWXq9wGFerANJlegqrzN2WOxshGMMs5Gp6MltpqU8HTPYu9CX7pWDSVjk+MFndzdH2lQYQMPZjMmKbFGoJ60Bv2AdJ3Lj5W5wPzEEvIHW494qIy+n3wq6ZroXomgOlbl4mKMGGxrl2HfPQhL5zGOmZZKzjBLwAwiWc2EKK8BN0KrfwweTaPCHnEXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(356005)(40460700003)(1076003)(2616005)(336012)(426003)(6666004)(16526019)(47076005)(26005)(36860700001)(7696005)(83380400001)(5660300002)(4326008)(44832011)(7416002)(8936002)(8676002)(7406005)(2906002)(478600001)(110136005)(41300700001)(70586007)(316002)(54906003)(70206006)(81166007)(82740400003)(40480700001)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:31:09.4370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fdc983-b26e-4aa6-4066-08dba29eb310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 9 +++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 85ceaf9a31ac..62767774810d 100644
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
index 8c91c333f9b3..2f1b9f69326f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3242,7 +3242,11 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
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

