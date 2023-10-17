Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024BA7CB764
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjJQAYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjJQAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:24:01 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD5B116;
        Mon, 16 Oct 2023 17:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwEAAh8vnAJ6d1FDSQvEMWdzL4zxKFXt/RxeejirlANnShvyW1NGQhO4IS+sdMlrEK0jYONUE4hEo/YJmOXbqc+VIUmYJSvg+JgqKFMRjMK6kqQPqRMnvJ2r2neygwjKL45PcYwo07zIMUXuD6wZVd3qAebqs8SU/ctM0vrohY8iNVAlQ/MWFXjMH7JS5oeDE4gLo5nCIyKohltCAPGytZMpyj9ZIKgHXyQeCYQN2KWGomCpN9vkhKMEgz4wC8sNWJlVRyvWmiBub0FF/RhcTZGHk63BePjU3aL6f0W5oFdbesF+IjdHOZjxB5Ft1LEqapZIo5fxXX32m1320EWc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WY9Q1XGjovX2NbFwxDDwTA7B7ZrS4TCO4WC9VQcHadI=;
 b=H07kH2OuSVYI7YGEfzVKkPTmP+yBR1DPANPn3ctMTdcah0gMXCQV5QMSwcCiooBUgIZTwoso/h0yAB2CJ7IQYKe6smgwnVRkhVHTiYVLX2JpxWbaFZkattROUPO/ToFdM+1BkDCK/dqsBkZjga6nogAtG/jUzVfkubig0dGFFo2jjRbQKJydzKN6vJF3GIJWmd6rCmkHJ50Tk1GHBx7rp5NSkqoGPzoPZ9ebMeAhT0BbY3bldrqWIDuBokp70Fz5UrbmEWjhwzTMqYJzH8ksvul+9kAQn8nySVGG3NrNfhGro7euq6EQgiChjQSsIArxZ7zRFYu9nP4ZM9Ur9TEoBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WY9Q1XGjovX2NbFwxDDwTA7B7ZrS4TCO4WC9VQcHadI=;
 b=TwJNw4k1yE0SKywTIcNpzFF5WJygZ1l4uapTiTOhQ5arcFzGF+CEWSAwbI3CmGL0RvCBNpS2OO0a9kKUcZl8jSc0go9GBCmK+cT+narpQUcNPdAc0o8OCPTm8rx7aT+SQEXurC4+kM6UABlDG5qI8TKBIrIT27CUNndULOWi7jA=
Received: from MW4PR04CA0132.namprd04.prod.outlook.com (2603:10b6:303:84::17)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Tue, 17 Oct
 2023 00:23:42 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::3d) by MW4PR04CA0132.outlook.office365.com
 (2603:10b6:303:84::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 00:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 00:23:42 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 19:23:39 -0500
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
Subject: [PATCH v14 8/9] x86/resctrl: Add support for the files for MON groups only
Date:   Mon, 16 Oct 2023 19:23:07 -0500
Message-ID: <20231017002308.134480-9-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017002308.134480-1-babu.moger@amd.com>
References: <20231017002308.134480-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c177fba-5e2c-4b18-e949-08dbcea75179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbg3F92Qd/XamYnFM7/4Ip0AyjjAoxhuFtQx6pZqo05+GSnleiEjCYWQg00MWpo0vBd7TtJOkLgcqboJrljMTVrzlmEB7ydbiXxvjgEPLtj95t6atHe0wx2nLa1ijzi51CF3N0rBPuc/YWG40e8pNbE4OcS9NRhDuUo3nNppjkmYQpaC8BacuR1A/CRU/vPwl7uHJAI3FDP5jOqf9nDaCi/oRBwiQ8jpLBUnuyVXcn5ECTHRptCgSvLmhuIqRSrYr//utw5scOFHKJ8XFAUvlKBdMy6yVQGgPNLSUD9/Kn8dxUtOBKwcMcdnxx89hpbih399GQXbyuEQyIT5fO6Hu+mcL4vs3OkFY6w6mO+IQN6bT1XePlgdz0AmwoY7WFTPvDQW2h5ChhQNFXO+nOORI8B+QBVsmibKDw1FLC2ASzque9regbpritHw5zYkD4konu2yMHZzx0RHsxDxUK4V7zohF5Ffp5LcdIG+K51NqfBF6ECaZxJR87GKmge8GS0kaKVDcAI+YRd2OzzasTz/ROAaMNDVmsZCbX/dxixhH1W1cVYkTqKZbBqi0VQa3SxarWXZ/tUry5KF8ux97GjKSftCfFm+DmWrXD8v7Ft6Iy70XmQLTvEQcpf/1vEuZbGhJyt29nTdyac8jaEitvI17DIWyyvQJXU+2gmLFkvyQJ9PyQd6e4cwKnRNEAoa9/h4ELki0GJ4phcxKDrVu5yRhm9ezoplTaW/ABQGCy7zIPT3XghNtjijUp/Srts4h6le8XOu0ctxxWDtLQU92+NKiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(478600001)(6666004)(356005)(81166007)(7696005)(2906002)(82740400003)(26005)(36860700001)(86362001)(110136005)(40460700003)(7406005)(7416002)(70206006)(70586007)(47076005)(54906003)(316002)(4326008)(66574015)(16526019)(1076003)(2616005)(8676002)(40480700001)(336012)(83380400001)(36756003)(426003)(8936002)(5660300002)(44832011)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:23:42.3455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c177fba-5e2c-4b18-e949-08dbcea75179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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
v14: No changes

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

