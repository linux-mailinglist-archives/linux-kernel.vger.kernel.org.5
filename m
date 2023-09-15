Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE14A7A2A8C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbjIOWnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbjIOWmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:42:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424E526B8;
        Fri, 15 Sep 2023 15:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVq4lgDDG4tTBA0VP5mqfWQ0UmnDNUEWBXPBuddDPbM7zDgdXtZm48LyYhqrWLCxY0DpQd+HMJlxjVWY29ypRtlnC28Xj/4WErIuHGTQZuhtLpXoiFamqnDCJTvTJOZvw0kii3lh84dU7Er0TnN3YZhE0gBvmwJwslVIwta7MoUULfdRirqc+liCZ20HkkrGnlsNggYx2U8zBnlXB5mPe69MMFF/7YpmA7fY6zWNrmQjcsxmPWkPk63JAMkn2414m15+QhVAUo4xBZ3KIA1jDdzgBrhaTq3AitcPQfVhbjbkEhzQW1MZ72+mPXDoUa7smMRudrOnCeikljP2T/S+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUhWzRrT6nvglIRlMoitP6PZLno159FzGba81EjYa+A=;
 b=JOEdybVWA35DTy71XvDZjI3b8TGs2i+cjId1O+nGn0DnCpJPMSkL5KFXDbVGUcLykNLGNRl6pcp+5LDZK00JXBp/SBFHUu5aLBWFGM0ncnNAkrVHbfID4ZDD5k6i0rK66UIQb8EJwixQOPh3Dtx3EGzQCK8K2D2qP2GyXOgoLamnq29trelRTTC14QgDNLH8BTphXJmyDsO9FyIwkCEsQRF8YQdc5cZaZ60nMKH5nJ140bphHhe6vJBuNew/5hwuTjQQpj4gS8ULrEAy5GuELWLBhAfNUWOHSfSp3S+byaoYmi5ZSgT5hQmmqnfjzxZED3yF9nZ2k5N6hSCEhZfIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUhWzRrT6nvglIRlMoitP6PZLno159FzGba81EjYa+A=;
 b=fmVF3MWoUDt18Hoh5lyF6QltwhvwTU1ZLfnxCeaMt8mAK3vRhCvCgaAGwXb7jjIIKt+sAhFal3ea62a9xTzC87HqYKaFXh5d5jBdB4gPOAi+Mi8ePI7AjGuHB1x4zPwf/I+64T2/eNLOoP4cxrgvEWNf59TazI8JziEps1DpklU=
Received: from CY5P221CA0105.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::40) by
 DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 22:42:38 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::cc) by CY5P221CA0105.outlook.office365.com
 (2603:10b6:930:9::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 22:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 22:42:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 17:42:35 -0500
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
Subject: [PATCH v10 01/10] x86/resctrl: Add multiple tasks to the resctrl group at once
Date:   Fri, 15 Sep 2023 17:42:18 -0500
Message-ID: <20230915224227.1336967-2-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915224227.1336967-1-babu.moger@amd.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DM6PR12MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: 2348c6bf-3e18-41c4-9b2c-08dbb63d0fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05ECD5FVt8Sj7gTD/f4ALIxUHnVczBs+lCbajodiImhRF8ITGED/6Tjkx7LgfGthhQiMrvtF3bzYl10SPrKDbIYviwFqQtP4upUx2pqYJddw1pFhjkwgo2jAq9YjJkcDEjbCRbygGgd2vjFcqlAm4MHN/RCZFxwcPjCo93XkKJE/djZQIsoJrx6nZ8aPkrKBnHeHEfPMW8Thy5VE0+1R8Ee6goJVCspHyxZ9j6VIChfQTCUGVK2Krxn6dqcSxK7vISitDEFNtmFJwIIUgI+YSN5oIPsdQpTLosHPdycm3fHiJ9WUJ6/NHeNgkhOwRiQ7Q+uh8A/1fDUy75ZkBHyhyUwTVu2Ys5DxLFYtMKuW05qwC0+JFwIjqddcPXjcQ0WzxEt9cvES9GyYkh16bfMaHbCYhjsy4gyk0WXa3Rw4LxY6CUDWPABRAYfRcPpqemrOTbts62Qo0uB4fUB/i2719K7q6SUhWWgj7rRkLDUtG/VshEXRyuuxoAZIiU+sUHAmjsTNUt/wOnQ4ULLRTmwaIsePURgC2KMOzqqJp+wtbAg8y3m3Uj11AzpJql7ReU3C29AUAFw0fTeksL9IMAeQVvagsZ2/17nZfTl1LHPw+Gdq9RyWhr7wt/aNd55OZVcEBPs7Qnwhi0izhIKJ5+issVFdqk4RqaO0uwdp7965p5dikfyaGqVRE5ipIY8hg2NbbLJ6N7Fu855ohK608o1/HPCZE27r6fPeRqX/FYmhgZ89XGMeBg95l3TGETzHwI8tBsYnoGytv98gj9Io6i5tQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(82310400011)(186009)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(26005)(5660300002)(16526019)(8936002)(1076003)(8676002)(4326008)(40460700003)(66899024)(36756003)(2906002)(83380400001)(7406005)(7416002)(86362001)(82740400003)(81166007)(356005)(36860700001)(47076005)(336012)(426003)(44832011)(40480700001)(7696005)(6666004)(2616005)(110136005)(54906003)(70586007)(70206006)(478600001)(41300700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:42:37.7299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2348c6bf-3e18-41c4-9b2c-08dbb63d0fd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/arch/x86/resctrl.rst     |  9 ++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 25 ++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index cb05d90111b4..8154e9975d1e 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -299,7 +299,14 @@ All groups contain the following files:
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
index 725344048f85..f0d163950969 100644
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

