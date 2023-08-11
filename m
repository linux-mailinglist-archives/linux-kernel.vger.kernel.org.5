Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E0779830
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbjHKUIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjHKUIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:08:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C81730F8;
        Fri, 11 Aug 2023 13:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5AYe56Fgx38hrjxYKGriijby5VoDJvb50VH8BzEh5HCIYih/eU6jBT+YJrSqUEqi/l+EaxpBtxLadHGYJ3mw9njH2Co0gSqdbrXTMsvF441IAdaYGGLmawPZ+oKUtAMQUch6gDKT48dE8fs5rjZAzL2sr7muDD8o4yFl6Mg7CGVnAB/YaJGb83vovgDLQTh/yTt3dhweovdtlKU/LvJwRRdrz43ZRfMrNzzoRfh5vu4Cc5KVgj5SwGOJiOvyn9IItUNBFIxk03KUfgX3fir7316BvvT4n9Jpx6Fg8QJxuxTQx7mByU2dHn8SzY8c5GE7yA060zxQz8ISVhFkoDfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5U4v7REjseNyp8szDNRtG7x0pMTTwGKkVR2CiMPjyg=;
 b=Zn54HZKGzJajuExXZJp9elnIf30YSGXvFWAnJOMaWFVW5bycJdXzhWBZtYy8Mnzo7jLHSCEwStc9qrXN9iKr4IOZlcf6DBX5B1ERfZAc2JjQL5brgDEX2YAJFd+MehGAdPx5+clsHxE/Ult6yk6Mv7dFxjPoQ2Hl+LO/xXmZxEkcDluJQiMclfK9K1Xl6LAPe7lANX2L0ca6aKaVKwcOdM0ftfRsl5Hm/tyr6dWOf42MRcf2qtX6LSAdg9Elu6DTxl9/I/zKyg/X7qw44el5wQ091ijKbgaqIL6bZx/sXDqoVKULsDPGbvgHAUOzTODjtbCHVnqKI2R4Oseica/9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=csgroup.eu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5U4v7REjseNyp8szDNRtG7x0pMTTwGKkVR2CiMPjyg=;
 b=naBOIk9l2oHQkboehBCRR4HQzzVrq7sUII2vN8qbMgVf9kZKbmxEr4+k2Q/uejlQ2kMD0HIA7RVcbn+MIMX5gEzs6XCkyU6E/a5cwp7nhBQ1R79acZx4BR3OOJEmifiJON7UPbAlGocy1Rkgh0lWGkV4vjStI5qU627SIRiDnio=
Received: from MW4PR04CA0267.namprd04.prod.outlook.com (2603:10b6:303:88::32)
 by DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 20:08:35 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::f) by MW4PR04CA0267.outlook.office365.com
 (2603:10b6:303:88::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 20:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 20:08:34 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 15:08:24 -0500
Subject: [PATCH v7 1/8] x86/resctrl: Add multiple tasks to the resctrl group
 at once
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
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>, <babu.moger@amd.com>
Date:   Fri, 11 Aug 2023 15:08:18 -0500
Message-ID: <169178449820.1147205.3688106607892992826.stgit@bmoger-ubuntu>
In-Reply-To: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DM4PR12MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: 0123427f-177e-45b5-b42b-08db9aa6be0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1U3QJXG3KnFR61H1YnxmceKnWHKg8hKLcRV9hRuFIpmgJ8OBh34Wm2ecvoOSPtfc/JMYA/Zxk63BkyJEOCCrNVJd2uj5znd+CiDtn7NnDqPePSpMvxoFwyZ9k6w2wOsWiKwHSjV9nfigKds892E75Mv5uOrpXmhP4bsQ2ZCBlBEDb1n3DCxGTNpna6eYjNuQnMFqiPugDrpWDmUH0qdLTY21PND7Tcz49iG4IVXbyPttyZdpVAHwg0CY7cM0EE6GEvJzFFePr9GoDwpsNpnjtZHLX6423GkFg+4CMc4eFBiJOpJyXj8Si9oIY4mBxmeMQA/V6Rqh2tNrpyM4H7JOgME6H5CvvGmMGzYi4kgc+ibHhjxW83yu7yTN4WSHjyMpFoLPOSms+jmwLEqKP93fBRmtzacgMKa0lxPeEM74vIbKkPQQmCyu0wo2+NhC/qTGZejJnHr+h5G/3XZS8viuYNg2TTJHbe1cjxr17VNO0S8s9tYE3hEk6CyDRkRzv+mf0xAS/68/NIEYwKsU7H9C73YZMMlbZm7zkA/G/IaUVjZG4Spj3Bp9noRVN1aNCLPxSS5+Yvi2G1NleDAgg/DgTxzwYQ25DPkzsOt4dXhMe3FeeVBBr+6C38fuNRqT8kFm4eVjqOvKOpwvgjCmV1JinaM1W10sdDIKACZLcBS2fxvdWa0F1nh4T77WjkH3Nq4Dtzd0U9VWBfJaa/4s0cp+iB6JtjXrqWInrJSE5/hiDEHVPuFK5urbUO4ST5ZATtwRXDtfmoqvUVAHM85jZhZbH361AR8DRHfS4TttwKwedK0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(186006)(1800799006)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(66899021)(40480700001)(54906003)(110136005)(16526019)(26005)(70206006)(336012)(6666004)(478600001)(70586007)(103116003)(86362001)(426003)(47076005)(83380400001)(36860700001)(16576012)(33716001)(44832011)(316002)(41300700001)(7406005)(7416002)(4326008)(9686003)(356005)(2906002)(81166007)(8676002)(82740400003)(5660300002)(8936002)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:08:34.4959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0123427f-177e-45b5-b42b-08db9aa6be0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5261
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl task assignment for monitor or control group needs to be=0A=
done one at a time. For example:=0A=
=0A=
  $mount -t resctrl resctrl /sys/fs/resctrl/=0A=
  $mkdir /sys/fs/resctrl/ctrl_grp1=0A=
  $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks=0A=
  $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks=0A=
  $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks=0A=
=0A=
This is not user-friendly when dealing with hundreds of tasks.=0A=
=0A=
Support multiple task assignment in one command with tasks ids separated=0A=
by commas. For example:=0A=
  $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks=0A=
=0A=
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>=0A=
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/arch/x86/resctrl.rst     |    8 +++++++-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   25 ++++++++++++++++++++++---=0A=
 2 files changed, 29 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/re=
sctrl.rst=0A=
index cb05d90111b4..af234681756e 100644=0A=
--- a/Documentation/arch/x86/resctrl.rst=0A=
+++ b/Documentation/arch/x86/resctrl.rst=0A=
@@ -299,7 +299,13 @@ All groups contain the following files:=0A=
 "tasks":=0A=
 	Reading this file shows the list of all tasks that belong to=0A=
 	this group. Writing a task id to the file will add a task to the=0A=
-	group. If the group is a CTRL_MON group the task is removed from=0A=
+	group. Multiple tasks can be added by separating the task ids=0A=
+	with commas. Tasks will be assigned sequentially. Multiple=0A=
+	failures are not supported. A single failure encountered while=0A=
+	attempting to assign a task will cause the operation to abort.=0A=
+	Failures will be logged to /sys/fs/resctrl/info/last_cmd_status.=0A=
+=0A=
+	If the group is a CTRL_MON group the task is removed from=0A=
 	whichever previous CTRL_MON group owned the task and also from=0A=
 	any MON group that owned the task. If the group is a MON group,=0A=
 	then the task must already belong to the CTRL_MON parent of this=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 725344048f85..8c91c333f9b3 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -696,11 +696,10 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_ope=
n_file *of,=0A=
 				    char *buf, size_t nbytes, loff_t off)=0A=
 {=0A=
 	struct rdtgroup *rdtgrp;=0A=
+	char *pid_str;=0A=
 	int ret =3D 0;=0A=
 	pid_t pid;=0A=
 =0A=
-	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)=0A=
-		return -EINVAL;=0A=
 	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
 	if (!rdtgrp) {=0A=
 		rdtgroup_kn_unlock(of->kn);=0A=
@@ -715,7 +714,27 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open=
_file *of,=0A=
 		goto unlock;=0A=
 	}=0A=
 =0A=
-	ret =3D rdtgroup_move_task(pid, rdtgrp, of);=0A=
+	while (buf && buf[0] !=3D '\0' && buf[0] !=3D '\n') {=0A=
+		pid_str =3D strim(strsep(&buf, ","));=0A=
+=0A=
+		if (kstrtoint(pid_str, 0, &pid)) {=0A=
+			rdt_last_cmd_puts("Task list parsing error\n");=0A=
+			ret =3D -EINVAL;=0A=
+			break;=0A=
+		}=0A=
+=0A=
+		if (pid < 0) {=0A=
+			rdt_last_cmd_printf("Invalid pid %d\n", pid);=0A=
+			ret =3D -EINVAL;=0A=
+			break;=0A=
+		}=0A=
+=0A=
+		ret =3D rdtgroup_move_task(pid, rdtgrp, of);=0A=
+		if (ret) {=0A=
+			rdt_last_cmd_printf("Error while processing task %d\n", pid);=0A=
+			break;=0A=
+		}=0A=
+	}=0A=
 =0A=
 unlock:=0A=
 	rdtgroup_kn_unlock(of->kn);=0A=
=0A=

