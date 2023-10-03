Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A517B7587
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbjJCXzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbjJCXzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:55:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A2F0;
        Tue,  3 Oct 2023 16:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc+W9+hL5L9SrsslAFiMpgPgFj+owG3cROoPBAXz5akHC+pBTOVB194SKVQ1Ik67kcIZ5WO29dq7aSmKjVICe82BH/fIn7eyX3c92mRScCtwMr3Kp/LrJDq0ndvGfvJEA80dP0AF4cRXflmbrpO77PJMUNf4jE4ZUzSpwPV6rYhL78V8+a5SqOPML6Vc8pD2lmOenalBaz38KVoYyHUIZXT3Nw0Ff4MNnMpFzxV21rVjEdy2DT9BkP0JZfxjAz7AU3y6+ugZqptwrm/CRTlw15cznPSmilF9tvf0evD3/xIaet1E0mbtStrDnrfQYS/2Rx0Y3qCQvsApcbhypEEWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El+R91vxj0VCXjBZ0rmoHLthS65G5hbX50DjnSV+Q1c=;
 b=aCSMx8EFWHVn6P88UzNmCD9dK+m7tFfJ3pigLnfO/RKb9WTHiK/9C4d4UOLU8q/qyQ/WvkIB7AXuKhjV1gN4wZDWtba0fmzTxRmE77r1gFoL5KN2r/rZy7lyBkDz46+sEn9hxFRNTVIOYQcbHsD/9z/Jzq25KKsw/oplkagzsHWvkF2tZNy+5675bQANrYS+PcI9/OeSkpBewG9aZuebrUhUGtirQBOLoiLVUyzR6lrF/biB2EVfOGzHMJm0j/iPc0vLHYz22RJ+F4OfLzBjC7pAYGeyOVhqvg+a2LDAWtqNqu33vcQ6wVgNa9CWSMl5Bmqy/2rW3VBjoOcEdp+NZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El+R91vxj0VCXjBZ0rmoHLthS65G5hbX50DjnSV+Q1c=;
 b=WWQBUov41E1Xp9zQaxKhNblybCVuj2OsAGOIdQXT/BQDCjdCz2vfKPvmvCERzoVT+LrJYwuAK06Oo4cNziyyj1oGuhruQ37HLdMqOom5m8495zmRTeelZqxd7sbIhAY2wkDDjjVLTDDpSrND/4ZVGftDiIVTAEIKwYzuM8Lhi0w=
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 23:55:01 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::f4) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 23:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.21 via Frontend Transport; Tue, 3 Oct 2023 23:55:00 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 18:54:58 -0500
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
Subject: [PATCH v11 09/10] x86/resctrl: Add support for the files for MON groups only
Date:   Tue, 3 Oct 2023 18:54:29 -0500
Message-ID: <20231003235430.1231238-10-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003235430.1231238-1-babu.moger@amd.com>
References: <20231003235430.1231238-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 9613220b-0988-494c-5586-08dbc46c27c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: by1PPhplV11+gjtMeuQbQGtqP5KZWTMumwyYFwTzGRuqNEeagqFzwjaMSN8sdvyPqOYLT4MkuWCFItEjTP/wgww2lVfDb/84AhcMiZA7ZXDKAj85X7JgxNZaaxi9nkHiMWy76FU08wyz2Kw530VHxdcNQ0EtSS/QtnW7jP+6BIliHPQ6gHRvkxNEoH1Jv4ViJ+P4fCGwlFeSG+DSBq9a4JEhpyXWSR+72w62x6mDc1PpzHCjXTegNGo9CH9JWeGI/QtcvUJHYi3U1epPPOPKEP/GPiydXFdd+9nRX3LXjJCSaoR1AXIfXbHlGbOAwryVWQ8EikQNS0IgbnEwX6+Pa+DwdWoMQ439j7Jp4gwK97mCTiQyyhbguF7woj1fuzLiQP+V7S6WFE8zCWJoM5WeeS3M/a7jEMxROM41sJgwiVNgLk7fU1A/NABJYQ2iBY+lH0WVgpGtw0FbcQ4uQArUFHBBpIU4AkamQYTZp7EWaJVUiI3+KTX+f/BS4/QHkIgjMbJ/03IythX2Ahv5LkCNdVnqLzSxfo+ry5mKywlM8JUGA5BF/B8Gg2takRzLalvM1F55vu9v7oeic0+nC9BQX7ojuFK6p91OSFftS3cDxEE/E98ZZbSc4vdq6zX9oD1DfalrE2qBlB0hFIUpMrRlzbnqvqfzrX7wfJx5F+nbr1+6i2i+YhHJcELzss4ufQk2ZoblZ8vw9xEAvJ0+K4581iWpqbiGMXabwuCdEPNJkWn6QKTuCAjCZbc9FgOoEIpNHma4iN7eqYm8xUMWz+rCxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(426003)(7696005)(6666004)(478600001)(66574015)(336012)(2616005)(16526019)(1076003)(26005)(83380400001)(7406005)(7416002)(2906002)(110136005)(41300700001)(70586007)(4326008)(8676002)(70206006)(5660300002)(54906003)(44832011)(8936002)(316002)(36756003)(86362001)(36860700001)(47076005)(356005)(81166007)(82740400003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:55:00.3832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9613220b-0988-494c-5586-08dbc46c27c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Files unique to monitoring groups have the RFTYPE_MON flag. When a new
monitoring group is created the resctrl files with flags RFTYPE_BASE
(files common to all resource groups) and RFTYPE_MON (files unique to
monitoring groups) are created to support interacting with the new
monitoring group.

A resource group can support both monitoring and control, also termed
a CTRL_MON resource group. CTRL_MON groups should get both monitoring
and control resctrl files but that is not the case. Only the
RFTYPE_BASE and RFTYPE_CTRL files are created for CTRL_MON groups.
This is not a problem because there are no monitoring specific files
with the RFTYPE_MON flag associated with resource groups.

A later patch introduces the first monitoring specific (RFTYPE_MON)
file for resource groups. Ensure that files with the RFTYPE_MON
flag are created for CTRL_MON groups.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 953b082cec8a..55d1b90f460e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2533,6 +2533,7 @@ static void schemata_list_destroy(void)
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
+	unsigned long flags = RFTYPE_CTRL_BASE;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	int ret;
@@ -2563,7 +2564,10 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
-	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
+	if (rdt_mon_capable)
+		flags |= RFTYPE_MON;
+
+	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
 	if (ret)
 		goto out_schemata_free;
 
@@ -3253,8 +3257,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
 {
 	struct rdtgroup *prdtgrp, *rdtgrp;
+	unsigned long files = 0;
 	struct kernfs_node *kn;
-	uint files = 0;
 	int ret;
 
 	prdtgrp = rdtgroup_kn_lock_live(parent_kn);
@@ -3306,10 +3310,13 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	if (rtype == RDTCTRL_GROUP)
+	if (rtype == RDTCTRL_GROUP) {
 		files = RFTYPE_BASE | RFTYPE_CTRL;
-	else
+		if (rdt_mon_capable)
+			files |= RFTYPE_MON;
+	} else {
 		files = RFTYPE_BASE | RFTYPE_MON;
+	}
 
 	ret = rdtgroup_add_files(kn, files);
 	if (ret) {
-- 
2.34.1

