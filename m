Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C967C4582
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbjJJXd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJJXdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:33:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2670A93;
        Tue, 10 Oct 2023 16:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsQU5f7LPyTZh/3R9O72z+RJpta1rFvuX9os+BNmDDvamAjLGryAiGfJuM2j5rR3ifnDmu1SBQkGPVWsjvFwX5auFXjrzT5LcsSD3S2TBvJwf3wEtJxoyeBAU9rWgymFtcVj9hWeUaTeZjJvfvjVdlMiLnQiAVl5qF2VP45fLDVwDtdbjL6bvAMNkGCf05N7rM8fm/1xnihGBzZbQUOGkZU2eIO5t/ZuRR467JtSrMmV8aFVVmdAOsyH5Pb/TreKyACX0SnTfSSeI+vR256MJJlp0yi2onDj2EAnqrWVicPftRzXGtaBiG/piLoF9Xtf57cvDfsXUGgOMoEXAy5VLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgNwhczAPO//dMRRHaucn0zT8vO7DFd9uRDVyZw4oNg=;
 b=czpIiiW+tPglH1FSw/r+QMLmcQoaCIAbFHsKMe8B3xmdNlUTEWbaFpZ8Qq8RF2xMOy6spfTYtkUc/M28OiDLZf4G0dhTBsQALbRUl6fiXfChCW9LYrJ/rJkCYOXOfIP6zcZ5Qnn0GgAosR2Q8pgwfeKAnQh9Z2zjU9L9rF3tU05kgyDe6aiPVzUTs9z39+4RI3AhINLnfrk8Hw//cJtHSF/uT9ge8BOELXyATQTnasfLmLW0L3rhApLntP7D0qH2at6hPCttSPgCZJHxMoI2oWsPJDPuw6Hjb0YNy2BpZ9guh+u63pn37f629EJrfbx8nm8KD5dGaOOH7TDtkd+1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgNwhczAPO//dMRRHaucn0zT8vO7DFd9uRDVyZw4oNg=;
 b=lxXl/nzrAM4BwdKaVnUq1P79+mheca4s0tjcdU/VJ/zew4Nt1vbONXv53L2unyCGbsYRxl6W4nMVLh1dNMsYBaSQYgMKv0jnyAgskXU41kt69Ztb8rAOFkSE+aovWrRZDMPUUysI8IS1cmVcIXy6Bn6kL5k3zthosxU2LEMQU7Q=
Received: from MN2PR17CA0017.namprd17.prod.outlook.com (2603:10b6:208:15e::30)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 23:33:45 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::c1) by MN2PR17CA0017.outlook.office365.com
 (2603:10b6:208:15e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Tue, 10 Oct 2023 23:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 23:33:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 18:33:43 -0500
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
Subject: [PATCH v12 01/10] x86/resctrl: Add multiple tasks to the resctrl group at once
Date:   Tue, 10 Oct 2023 18:33:26 -0500
Message-ID: <20231010233335.998475-2-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010233335.998475-1-babu.moger@amd.com>
References: <20231010233335.998475-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd48623-20e4-47fe-b8ab-08dbc9e95878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WT2gFKiry4P7NHmA+hEFmcNotb2NpGULyDA2Uq8bn6oiLacDcvVhI1vcxiaJkmZExrqOO7n+/oYxXfXaRhCltH6gsAnvOJ/R9RY6K+jKkwkPj3e1jkjG9W2WQNQhJgdEPWlK3kyn9zEjaz/IqSr/fICpRZ8Q/3/xwUnHFxp5qWaqZhYqRoR3Qp6tT/hmcoD/Avl8/heLAwt1tsP76Jcb2HdyoK8zY/Rj30HcLpO/j7ZNx0gQ4fsAhVjkVmMYzOvgbDkI5CPSRC2HAn8PAOt01zKoDhKwb5kTH3K7HXCi2gQjiQH7SPNRoZ3iRaJNQ8BAP5OO5fpTQx9f8bX53LwQvIZBAfXD3Tmy35hcUIPsQ+vyncdBwGqtvtlD1rnbx6MjCIg+SVlViJyipOzmsIyaiJgYKObF5uTcN+Hv9GRa5Yz/4+I3iKbLy1jICMG69gXP6aGCn/zMjnsc7CRM6LqWuRt2CNEvF4Qlti7wwh2WOPDAMk9uFEDlzrqAGTB9hIg1LGNdq7antbJEH1SZ531CUov+OGEYCGP+uLLzBNSPrahU72sPVBpPtcbNkj70CejqRY0vyPHUCCrt3PtCuxb/Ar7PTcqtVD9HXv2kX5RRQBVJIreiDRxsSBkpLCZ62HvZxeg1RCuKkC1Wud3o9j7JxJ6n/pgq9/1DlEj2bYzuVPiNan5yONOr4acwUqIQrmnjLw2rb2Stlfmxo42kufFik/JkJ0oKs9SRzWF1gu553MIYT137lyydFJjJA8HN0WR+l4ujxCZ1en7y60Venm8VjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(36756003)(86362001)(66899024)(40480700001)(478600001)(7416002)(1076003)(70586007)(54906003)(44832011)(7696005)(2906002)(2616005)(70206006)(110136005)(7406005)(5660300002)(41300700001)(316002)(6666004)(336012)(66574015)(426003)(47076005)(26005)(16526019)(36860700001)(4326008)(82740400003)(83380400001)(8676002)(40460700003)(8936002)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:33:45.1301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd48623-20e4-47fe-b8ab-08dbc9e95878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
v12: No changes
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

