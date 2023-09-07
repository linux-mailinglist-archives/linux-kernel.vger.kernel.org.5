Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BA5797F5D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjIGXvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjIGXvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:51:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957341BD3;
        Thu,  7 Sep 2023 16:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrTAxsTi+i8tRU39XNCrUzS2OE7HgyiMbZnWRONqzWQE4zPLWpiTqGKaHD2coIp3+JaLSi5EjUl2/79zOGJB9pXDxc1P9dWD+eIqtExQngG/fgFPpxmUMTdJNxHIYUf4XgQbph0qTQyeUya9hts9vpB3ac659w2Qg8itRNumnnYe5xq7k4RmIofOJUh8c7L4WomkCpnHb6aV1yCulL1a+B9dtlQheOxHN9GfaKzeoxTYRdqytCcpaC/SKAFMGeDSHER2qG8IfCQpILEvgGfKjNS121wr3JL57uyCffycuZ0/pFw0hMmj72/dIO119pyYzbp1RKjHZlV65/ZSEmfx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkVX2YWxsvn/yUySBmMBPFm/dx+a2epxXWBHdjCvrbw=;
 b=ECB0YXmVsLRAT5C46BpFZgSvOzRFGxFRdm7Cozy1xoVAglGg2e7MlROnR420AiKQMNc4C5EZpWJoC563YM7Hn5ba8Y5gTExgIUPX9tQoXpUxVoKzSi6zLjmda4ZyB4TDl0863BxfHMfF4gX3V6cyQgdmrUEgXt6p+dYqnohMZ0wZ2E3ID9aBNO7mG3YFRp58trTvP0WRogYHxJsy7boOcvXjsLTqXr48WTa0+hT8fENnvAusfQ1WuEYsLWaSsqVKphpkHBytDpPexpWp03qqs2RDzVkVM2A/DstaZAHkqCaGxea+RI/19mMNgij2nwajE8BA4hFPe5i5NHVcMnTWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkVX2YWxsvn/yUySBmMBPFm/dx+a2epxXWBHdjCvrbw=;
 b=zk2n8V/eth6pGdeFpwd4xU6rF9NTiZBGmKF5merCDiHAVrPocXHmSIqOTQyv9ToFTIYxzx5W70fbJQzmJ+6YKcT0gmMtkojuyhDhjbAuEccEky/MHeLRsKtPpbgng2uZofqWMYYohah0bE3s0YbX/WacAYSkSGzCDd4MaKYnKY8=
Received: from CY5PR19CA0055.namprd19.prod.outlook.com (2603:10b6:930:1a::32)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 23:51:39 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::5d) by CY5PR19CA0055.outlook.office365.com
 (2603:10b6:930:1a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.38 via Frontend
 Transport; Thu, 7 Sep 2023 23:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 23:51:38 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 18:51:36 -0500
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
Subject: [PATCH v9 1/9] x86/resctrl: Add multiple tasks to the resctrl group at once
Date:   Thu, 7 Sep 2023 18:51:20 -0500
Message-ID: <20230907235128.19120-2-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907235128.19120-1-babu.moger@amd.com>
References: <20230907235128.19120-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: ec61aa83-455d-4390-4ca3-08dbaffd60c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haFt6Ra3uKEYXSQPDFAyw1eEttnFjPd9/yIUYE2k/DKggHZ2QX1FX8gkk9/PbD02Q0PcEnDq2YQxvaEADuArNs+U8KPlMVA+tMfObH0pdjt4lyi6mczNy/uJnJVZ1ZcE9mueWWtm/95vI7/U1OkI2qurOaHxTY7nvsuqIZS+6X2/1ynNQfFAdaIVhMMQ8UGvqMnsBYJM/gR7tcB8W0z9b6mnFx4uZOtI3qZkJPYB6rrpGGTdOh3WtH8Ex+luY5L+OUpWN7zdJ47xeGkUzAnPIdcwKUQz0QkbT4GtNQi6jcf2YQ0fn7cnalOrNvEqxorJaJiTM4e87jzBQUbY7lOXjWsnEhLVXhCrP4ce24A8PHTcIWLE0MM0G4TP/FTebr+v+GT/Ioi2BxJRxDcvH5TA2Mzsz00KxuRgMUfHksl3vu9ffEnL3L+ZrfP/9nVc6nwcibQnpoD5+SIScGWCGkqP0K6+Vug/u2G+eJ/J+Gsi76u1ylKKxq3tdFI+k/TbloA6enYE4xHlpo7JVribNFgCfLFbegKw6rN0G0uawkV3SVJdD09ZHjYu5xKk0w4ydODC3P0M9zgxaKmXXPzhEWGfUR8Kxor4ZF9qz2ju2jfq/lT1qP4qPI79Jt8XX6ifl1jGuto80PSJQsnj0o17VFGvIsmQ4WwFXWfNkzysoIx2lijfEy2LnKKfCCuyeHqWicwK5cCg5GucjaT+agIr4dTT4O9v4rLGP8VylhEuxu631dtuPtoi8jOtjawdyK2GUt6TPhy3ErcbBvByGoWvwetIUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(7696005)(6666004)(83380400001)(478600001)(2616005)(26005)(70206006)(426003)(336012)(16526019)(2906002)(7416002)(7406005)(54906003)(41300700001)(70586007)(4326008)(316002)(8936002)(110136005)(44832011)(8676002)(5660300002)(40460700003)(47076005)(36756003)(1076003)(40480700001)(36860700001)(86362001)(356005)(82740400003)(81166007)(66899024)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 23:51:38.7355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec61aa83-455d-4390-4ca3-08dbaffd60c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
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

Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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

