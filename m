Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6091A7C8E54
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjJMU1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjJMU0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:26:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6168119;
        Fri, 13 Oct 2023 13:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBNDsGalF/9EHevjk4IioVauV+Q+n2rOS4MKj9btbfNL7l1e7ifd0lHIGKhDFPlnCJyTSoeDH2Lp77Juq939mkMrp8Bq/yPHd/A+HigEzcDGxrAefqgAkzF/f3REPxJZKF0848yOJN2byym6cFw5TRoyxukvUsHiEOQmCVyq3fOGBF7Y8wcgdW7YFJu66/0iCmdl1xGd80pHzCtfbrxfUCyZpn2ST3KuwLHosShECnHsKVIP/WVqxros1jAYZi4IbdYWC1Yw+Ad7Sh+nBv88Qfz4tcKHixgd08H01UXZ2Mnmxfz0V7DeAg0vU55+GF/Wf7gbMtkU6kINvK5DduNcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xI4Po2AfLnVcMKXyHhFEAUfQWHHP8gOxU+wkEOUYopY=;
 b=PV7uL4p5NSm3Da0MyC/p0aoemA5iaDVhDL+Z1nrpWKn+MtbotmoA5292BaK1S5V0rFEDsXdsJR0sP+m3+JUzmrSJTIiiC0+LPZDzBSG/0t1bZLUKl4rPGlIw8o7sqDd0euL429dgg4LsmX5weKc9IvqIcKnD6hselQjUHujPClxD9vH/SODoHNvdC+kOime2ut7dkr6Zj/aF7M8Q1xAwIz5QVm8tUlp7AYKMqYy6ZYxJeqbXOJZfYgpBbPgSs+WE/Pf7RDkf0+V9CZ4c7yf4mXp/UDn5vezrrPy5g5+yRmqKG8DjNoWWMv9zeV3xhZMYfI+pjSJJdDvEwJDxIEGMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI4Po2AfLnVcMKXyHhFEAUfQWHHP8gOxU+wkEOUYopY=;
 b=vc734WdaSHURNQK0syNd9MmhI4cp56c0f6WPG1ZFlgWBzfkWTECKVtVfDJekMbOH+f9Q6S2HkFsmVPPXbqveBc4yQkpv+k9G9eRLpwnLQKShOo33bqx+xJ1mqRYPNEtTqkENS+FsiYtN0iNjP60Qa4mbM/vS0gMIbl33MDfL70I=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Fri, 13 Oct 2023 20:26:26 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::64) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 20:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 20:26:26 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 15:26:23 -0500
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
Subject: [PATCH v13 09/10] x86/resctrl: Add support for the files for MON groups only
Date:   Fri, 13 Oct 2023 15:26:01 -0500
Message-ID: <20231013202602.2492645-10-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8ab584-dc86-4408-f389-08dbcc2aad0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvVQFt0GCFOt+Gzp49yMxsUy/GYtlcCxlbGwaS8U27jJE3beAmDMIRrAbBx35McsRDDHvWURwlf1SpsrIMyODOsIXUIfrgbazQiTcH04TaZWtKrIUSAdQbGdx1e5vQmcyE/7Up2eI9byf2WeHHuSuvfbEjMIIwfodgvTsHUMKSKsUAvfGKG1fCg/kFHPAgrFJs8MTEZ44Rqq6wtFM/evN0UxM6rYYeEITZ6oO+jnr01kn0gv2IQ/qpIUjOUiHihR+4q3YYQ87JE80JG+IUznwcKv0iNCeYWe/z9f7X1m51MiUVP2HGjoxdxAYYZCik+dLZP7a/crOjJur8hkW0cjCQxCMxORSiALM4z3dGCr5px7aGYmvQpyw2Is+0982D3bCxeVjuy6upCgFLp7IrvjvdQv0GVlsRD1PLXfvivRByoor3ZWNMPdxfRC5Vk94M78PRpv3UCd9bR4AYnq++3LMTa9vqOYNueYeapuLjP4tbGs/cpzrCDE8OBlLOhuLE7++eB5LsWqxd884tRlYgVIlpIVvN40syJrqfuW7RWNfJqKsIsPcYQP+JdNBJ8vafpwcA7KnU2TuP4A5DMgJLIG68LU0FL03FxD1W+unr73fRPskJ7xctSGAoc3HYuHjJH2Ur+COgL24i++DEx3WQbax7ZD1mq5hK+Z5aqc2O5uiZNOZpLmGS/++pioWYdWIL8iwk3MvseGx5BW5GmzqstzOXIExdzvEQAk5T6QzDU01tf02rWEwmxMQHneQ0X4+Uh3mI3ENgfPoGFNs9x3PnfF9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(6666004)(41300700001)(7696005)(1076003)(2616005)(82740400003)(40480700001)(44832011)(316002)(86362001)(36756003)(478600001)(36860700001)(81166007)(356005)(40460700003)(7416002)(336012)(2906002)(7406005)(66574015)(47076005)(70586007)(426003)(83380400001)(26005)(16526019)(4326008)(5660300002)(70206006)(54906003)(8936002)(110136005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:26:26.6406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8ab584-dc86-4408-f389-08dbcc2aad0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Ensure that files with the RFTYPE_MON flag are created for CTRL_MON groups.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v13: Commit message update(adds a blank line). (Reinette)

v12: Removed the comments about the later patch. The text is
     moved to patch 10. (Boris)
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5814a0bf3cea..5f6d6ba63a2e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2551,6 +2551,7 @@ static void schemata_list_destroy(void)
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
+	unsigned long flags = RFTYPE_CTRL_BASE;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	int ret;
@@ -2581,7 +2582,10 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
-	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
+	if (rdt_mon_capable)
+		flags |= RFTYPE_MON;
+
+	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
 	if (ret)
 		goto out_schemata_free;
 
@@ -3271,8 +3275,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
 {
 	struct rdtgroup *prdtgrp, *rdtgrp;
+	unsigned long files = 0;
 	struct kernfs_node *kn;
-	uint files = 0;
 	int ret;
 
 	prdtgrp = rdtgroup_kn_lock_live(parent_kn);
@@ -3324,10 +3328,13 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
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

