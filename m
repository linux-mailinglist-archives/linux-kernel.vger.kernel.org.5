Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666467CB750
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjJQAXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJQAXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:23:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910092;
        Mon, 16 Oct 2023 17:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In7HcEbeaDXpVR+dqxitQ+xEnwaE/lWckffF77xB53hj2v5pQm/DzZSqlBc/OqRk96gjJtbzgRwHQeSDTFzFsWbFb+ppGORWxTAs+X7WaTptDGG38NwLVB7/bRPE7i2abAXoZ82tq+7ajTsyNpC7/ZbaE9lWIBEFsMKBQEjbtq37MyCJtyBM7qjBL1JWlovYnqgph+Y7oS0oNLjNWpxIh/atP/Co0pCKWUuDQV4cELctznciZAbAlEfCeHnoB+vtqlWH0oLatLhVyxWD5Blo82wZIo3pdrus8LBwJ/wlUTspvYd3wVPHHKQh94tcDwTpGE4v3q3sBShB/8KX63sFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnFdzXUk12q75LojiHXfoMRT+bFDwETuo3qQ8MWElYM=;
 b=Uk/ZbU720frifoekgHi3GjXPCO2iRI8seG+wsUu1ce5VsYah1eEdC/zALsenlTJhb6VSDIEk+uXBTBaccgecOG5qKeMDLrQAghvTmibnkfKFJrK2LFOgTgXpoThcd4Hg4sZbXa2HVKHGaqo4N9PLfiOZEl6BQ6rBFB8gjAkYptQTnikKow7LKU7TULNIO57WvT3D3aJ1cCyVjFsiX4a6OFsD5zBPykNowkzIFUQGgAg7IrM+Amz3vQ1r+BC98F9uhh5xK9Q1Dwq2ddhgqeq2exsAlcmF0a6PU31a69eA9/cVYHpLn8sDk8b+b9DCmqFWniErrY8MBavuMq3Fg7k3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnFdzXUk12q75LojiHXfoMRT+bFDwETuo3qQ8MWElYM=;
 b=cyAQt7EkHSxY4EwOBHzICGsZFcKgCz/RCzv+ioERG08uO23pJDk1xgcuvEugpDqHg/GYpd0/YeIx1MLZXwR6GCymIIfEW/lLtviBGv+HODX2Kgce93S3ubjfl9B/bLUDbKLjHpv/N9NtaYMcwFqriMSElU3Pg9Ss+DpRHR2ohB0=
Received: from BY3PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:39b::8)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 00:23:18 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::c4) by BY3PR05CA0033.outlook.office365.com
 (2603:10b6:a03:39b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.17 via Frontend
 Transport; Tue, 17 Oct 2023 00:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 00:23:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 19:23:15 -0500
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
Subject: [PATCH v14 1/9] x86/resctrl: Add multiple tasks to the resctrl group at once
Date:   Mon, 16 Oct 2023 19:23:00 -0500
Message-ID: <20231017002308.134480-2-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0608b7-661c-469d-7e15-08dbcea742da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJEh2NOUc/Mm7acKQKzGMQRBr8qI1BP9zkKCg31CrrLz7szVVN9U0KtAlPICWLAUqu8E1u5G8jy/luAUxBY8bSEPF3BFcf8LIHeCRs47SXxJnjVaubrkejML8MbdjWX1VRYHczk7E8vK2ltjTn6oIQWbb7XaNIU1AkZ6BxHOwzbJmy5hF9BA3oN9ytQhMAZbhir2rgQwpluopAfWxx9GAHtzC203xZsvNP0yB/zaxFh+nWPIkz9iY7AyYW8EfCFvQUar1a5+OEEBKGfq6rTfhlLf7rqHWwf2Zclbf5rD5kWa+R/3O5j0abmCXuu2loGz+w0vw0kp0LskZvIju/hVmrAbHVVMYA0mnhjyywa8jq7ECT/P0eXSo3yX9WzsKW2cv7Z16EDUmeOZ7gfwKfYqLBZSN3SuBPbb7Xm/wtAtaZ++8I4XNrPyMC3sCqUGIp9gx6/e732V8juO6v5ZhzJskRPWN0QKkyG9tljRx412+pImiKGahHEab4ykYbx3/s8gELzxcUb1vuL1fYdfqt9wr31xXZp1sgC+KPhgL/Pg3qzeqTcswuRZj+J5H5AI+a5O/zVOzGcDs0ItnxH5RAdCZLp0XOwck36Nd/Ced0LcMdvxFjFmw6px9CLKrvcMdxNFo59CJaCHHhy+saWomqcgzitjqVlkLjMe1/dy7wgDw4SyHq0z4eHu6piqNpbkhXs4pvi7dd/3uQbID+9+TGTFRkxbgi5scOQh/QgtKu4A//gTOsZ7F0tl7n3yL+Qx76frlEw71E6KdR6snGPQK1r8Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(36840700001)(46966006)(40470700004)(7696005)(40480700001)(5660300002)(44832011)(66899024)(40460700003)(2906002)(1076003)(26005)(36756003)(36860700001)(2616005)(426003)(336012)(16526019)(6666004)(83380400001)(66574015)(81166007)(86362001)(356005)(47076005)(82740400003)(7406005)(7416002)(41300700001)(316002)(110136005)(54906003)(70586007)(70206006)(8676002)(4326008)(8936002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:23:17.7970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0608b7-661c-469d-7e15-08dbcea742da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271
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
v14: No changes

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

