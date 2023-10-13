Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575487C8E49
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjJMU0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjJMU0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:26:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC0AB7;
        Fri, 13 Oct 2023 13:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3lxQiX58+3luBYVR7jDHfBi7W2SuEABlw5Qx9bqKfrtkbFvgnDj88t8ptUE5nEH42IQYT7Adt1Tqx3RQQePEIDb61o0fIi9/IFz/ZCK4o3kbmnNSVFmX/qZRjChBNWWgC18+/KiO/NqNKZyvmZtFsVKVUZ9viE/G1W5VaJooR2Xtj1pXjqqupVBEuaORWW0S3jvetUYvc+pU1W1MTXVKCRJBNhvLMEQIiHCzvi86ngfkB/HyhwGfNFCK9QCN/VP6gYD8p04xMMZygywWP/F0G9d9T09xg4hugjEAtAuk3n9G3GJf5ZzvmjEkkpF+dKtRK17ER87wG5tlKG+szwrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCatZGSWZUcdPVlebxVWApBrEvhOCVHeak/FRA/3ww0=;
 b=kdV/jgxPbXKcZyUjKB3sjZ7W18jpTWNB7U3cMXHnW23hIAmdaQrqm+hW4LVk+zn5sxTKeDkixg2ArzdVXrH6DjpVTl1WrhGcIMusISW9N8BnOu3DtAxwB+5m9meEmezItqElaP6txJ7i/9bmpSFHaBYBcyTIEvN202S9GGlWqi+c8YbbipalAAVsrCdCTYgzTbaPb/lfl482dJENnJa9RdZIWYdaQY5p43Fe2V1Dc/0+ioEgsxFpKNssaKGmR7grPQ5KKUtGINyfV5YVc6y00jHYqdPIhqK6XAwdSsrEhMCTIdJB6nsWFXj0Cae61Pnd+c2B4pEvCACCX60PFl2M6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCatZGSWZUcdPVlebxVWApBrEvhOCVHeak/FRA/3ww0=;
 b=COdohcC0ds4zA4oheQxwNOElulRth9qc0LQDLwXZ2yzPnZlc8P3Uqj0jZcK27Mt6XDHYP0+29pcgL+0Hoa36duSqbI+2jA+Bwjkx8qGN+IPOBEeX5yMcTCtG4ajTEqClnzMXUHq+wfSToWTUvsGCwDi10ww/GZAvZZz29Dkw3c0=
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 20:26:14 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::c5) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
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
 2023 15:26:10 -0500
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
Subject: [PATCH v13 01/10] x86/resctrl: Add multiple tasks to the resctrl group at once
Date:   Fri, 13 Oct 2023 15:25:53 -0500
Message-ID: <20231013202602.2492645-2-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DM4PR12MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: 8837f41e-2c08-4603-84b4-08dbcc2aa592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5anyITFDpSPxA4atFvXN6038GQKo50wJVu42ya/wcFpLYsePok02QetYOp3hszNnDD1VYM4l50pMAuRQ27myDi7OL0bp9MwHudvW3JXO8FM19bL3kA9S4egMLv20VnL4Rfih+zWqk/zldDwqhhS4kiCgzrlUynDz9I1xsbyRPjFubTEX8ddmJK+WcKcyJGNNM+hp831E7y5AMuicZN+uh5NVkHr4BQDXpg8GYgxKlS+si3XdNcecLzl83kKYKOTmFTJBXaKxHxgFSqMXS85dbkexYirtiNwg2M/HtURfbaUxDZ6rVz5XsClEpeJIyUyfX5OPJLl4wXHSGFZ7crSm6xclxZQyE45VI+eADG1rYghx0fH5s3Hwv8H6pCVp4I+EjRC3OClVUPe1KIPxss/L4j7Fp5LaRkyxcmprNctauk5Z7eyPg8D8zowrYCdiUkeY+VkVprnnT+zB7mkTXPhK27SfEd9bnURomf8EaGRzGhHqnPybjvERMJwh/c/sq3tCAf8Zpdg+iDDGtWP2PbyrG20M2y1oTbC5FJ/h7Ir+D2mPiJVPSGsOP3r6w2kTKZOlcCFs9jj7MtNMXaE/uXGTJq9ML9peCO3ORhnUajD53epo6K98NGLaxW5zXIHsRbl35KA45eylFYtXCUr1hu7EBgas7VK2NizvCa4EssSK+VgOpF8GTevbJ1k0Cyo6MKjTXyWC8r4PxYsMF6wFApC7IcSBElc2xc4HjZ0czp2/hDvBQwx403uqHQSSFqil71Fa48GejF1k5nX9GiOZJNA+9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(7416002)(7406005)(6666004)(2906002)(40460700003)(478600001)(41300700001)(4326008)(5660300002)(8936002)(66899024)(8676002)(40480700001)(44832011)(316002)(54906003)(110136005)(70586007)(70206006)(7696005)(36756003)(83380400001)(47076005)(26005)(16526019)(82740400003)(336012)(66574015)(426003)(36860700001)(81166007)(356005)(86362001)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:26:14.0811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8837f41e-2c08-4603-84b4-08dbcc2aa592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5389
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl task assignment for monitor or control group needs to be
done one at a time. For example:

  $mount -t resctrl resctrl /sys/fs/resctrl/
  $mkdir /sys/fs/resctrl/ctrl_grp1
  $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
  $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
  $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks

This is not user-friendly when dealing with hundreds of tasks.

Support multiple task assignment in one command with tasks ids separated
by commas. For example:
  $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks

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
 Documentation/arch/x86/resctrl.rst     |  9 ++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 25 ++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 4c6421e2aa31..178ab1d8f747 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -306,7 +306,14 @@ All groups contain the following files:
 "tasks":
 	Reading this file shows the list of all tasks that belong to
 	this group. Writing a task id to the file will add a task to the
-	group. If the group is a CTRL_MON group the task is removed from
+	group. Multiple tasks can be added by separating the task ids
+	with commas. Tasks will be assigned sequentially. Multiple
+	failures are not supported. A single failure encountered while
+	attempting to assign a task will cause the operation to abort and
+	already added tasks before the failure will remain in the group.
+	Failures will be logged to /sys/fs/resctrl/info/last_cmd_status.
+
+	If the group is a CTRL_MON group the task is removed from
 	whichever previous CTRL_MON group owned the task and also from
 	any MON group that owned the task. If the group is a MON group,
 	then the task must already belong to the CTRL_MON parent of this
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 09848ff11f7b..fe239691628a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -696,11 +696,10 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
 	struct rdtgroup *rdtgrp;
+	char *pid_str;
 	int ret = 0;
 	pid_t pid;
 
-	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
-		return -EINVAL;
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
 		rdtgroup_kn_unlock(of->kn);
@@ -715,7 +714,27 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 		goto unlock;
 	}
 
-	ret = rdtgroup_move_task(pid, rdtgrp, of);
+	while (buf && buf[0] != '\0' && buf[0] != '\n') {
+		pid_str = strim(strsep(&buf, ","));
+
+		if (kstrtoint(pid_str, 0, &pid)) {
+			rdt_last_cmd_printf("Task list parsing error pid %s\n", pid_str);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (pid < 0) {
+			rdt_last_cmd_printf("Invalid pid %d\n", pid);
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = rdtgroup_move_task(pid, rdtgrp, of);
+		if (ret) {
+			rdt_last_cmd_printf("Error while processing task %d\n", pid);
+			break;
+		}
+	}
 
 unlock:
 	rdtgroup_kn_unlock(of->kn);
-- 
2.34.1

