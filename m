Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DAD75A2B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGSXVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGSXVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:21:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FCA19BC;
        Wed, 19 Jul 2023 16:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne5kQlhSYZTjxCRITS/m5i7kyggViAIc2rJGDC6qXlgPHSHFwD3XCdmvMxcZiw5f1pj6x1qSHh9HW/V9+er1s7yMi91H+WcWfZievAmX4ZumiiUcHlXcP34YWMa2o/sq71zi0tSD2KiuLQ5MXJgeARcequXncfTMZXmFyvS2hSuF7xwVxiQqhnAhgmUHqppSyzOm+7NJ+TPUulLQo1BG7kwZSYXEphb9zVm5xjk6SSy0sdoO1ppNbs/sC5KBf2fI2IHB/GGPYQkycBIHm0ua11z39G5HZyPglAZCTo+uSH0jq+SQ/gRxKsdX2ZsImofs5w3FlHbIacvTQoVOx9FlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61Al6Z6LQLHeKfkTRNM6veo5Vu35Uwnfb24p/WvWesA=;
 b=kMsUByR7CRgFKB5W2K6/dEtjnfNVTaislE62PxtnHsQmHXWmnDX1k75+cyJatnmaVcj3x7OWQchh9r/fbLy9GnTKD0I7RezVnXT6jyzeb8OjkOhM3Zh+0dd9R5Hp/aiCdR8dWymRnbZ2HX30o0ZcsXjEc6Cwqv37sj58oUOgsc6LMwMlttOR97HZEcHCnvP6RKCO13PMm6jroEWcWM/K/yQ4Aj1ziL2Lwqc4HaBmd6KdNPmWgFozuiuN0kXkoMWrbv2zmnUSNlyhwE4LK2p3hYbBBm0dDVtBlE4tLaA0hqjHoidA/tllW5Ippc10SQNXQ5co2cNMQGsrazr2erlJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61Al6Z6LQLHeKfkTRNM6veo5Vu35Uwnfb24p/WvWesA=;
 b=4OQW55QjIXZ2NfcMeRydYFRLyJBHMrlLcS2B0+jpl4v1hKZcn8YgFSHYaQVY4vfGRsVQTj8vTSx2zkK55LBAvmZnmpiFXwkuKNsyYvq2hb1UL9dhHXN6Ncat455GR4kz45P4nKPowLLnMF3vPJj++m4tRqHAkhV1p+FjRJMl9SM=
Received: from DS7PR03CA0337.namprd03.prod.outlook.com (2603:10b6:8:55::25) by
 SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 23:21:29 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::e9) by DS7PR03CA0337.outlook.office365.com
 (2603:10b6:8:55::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 23:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 23:21:28 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 18:21:26 -0500
Subject: [PATCH v6 1/8] x86/resctrl: Add multiple tasks to the resctrl group
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
Date:   Wed, 19 Jul 2023 18:21:20 -0500
Message-ID: <168980888032.1619861.1165593867700435801.stgit@bmoger-ubuntu>
In-Reply-To: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 96af125d-1238-4855-d82d-08db88aee148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1f9Q4CMFvA2wcK+oaNgQURFQ+NA9c6KvM1fUMni5Tra6r80sG5TTDjkZ2N7J33J8JE8kWLHjqqbzL+uOgRue9W4/N3mLKFCrMLgTgR6wo2tHcxYcAa4hvQgV91xayxBnbQaQh8WCgwAg27lizTPfv4RN3AKWG11gk2nFOBnkzpFJzR7b5PYsYyJwwmy0MCCY+5LTqMjK5LkJQdxZN5OU3sbTqBXrizBAH7bSkd1ka1brFGU58QqdXcAf1SCoihVYewXh2FMqKg3CjS41IahB7paMlYmK2fxcCmxLJDaZEIN/RHpHOAR7SC/z38/6/Ev8NYT6Lx16Pi/uKyqXPTYcXj8XfeFkgOc9iHYDwIUuMvvu52iB87cG/U8rtqtMzc3qfzUaH18/87ezAtDLPjyJydtBFjRJJ9JT214s6Aoc0y+eH+mPassDE6eVr06vItFiCy2ahdYqegYPULCEYq/aIzEuhtffGOL+jZ8p9/IOgqTCQ34mMveN4EZbpp0dkaom0Z4KHNbaTU06Xqc9/S9snpi3H3iim82wtVKuaNqsp0IPmRcsd1H7jF53sJ5G0t0V0+wFUe87SVAFtpxWOPqsK5f+Qi191t/rkJWxSqTUu1KiyZQOSRyWAQdDzD5MQeglI22ES568oURkOqYC8PRKeAHrl0LULGSH57yPeLC9Kl5SZj9ZGeqPHsbidKm9jhVe4J3UXLx5gFADxvgSP9owVvh4F9vrsBnfV7/VJjUeo2IbqJGKt32x3Z1RAhoabG1w4t5w04XiT9v5LrwtdPWez4sQinCJxs4/JhUymg7oFY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(376002)(396003)(39860400002)(136003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(66899021)(4326008)(54906003)(6666004)(478600001)(110136005)(83380400001)(82740400003)(36860700001)(426003)(47076005)(40460700003)(86362001)(103116003)(40480700001)(336012)(356005)(2906002)(33716001)(70586007)(44832011)(186003)(16526019)(26005)(316002)(9686003)(70206006)(81166007)(7406005)(16576012)(8676002)(41300700001)(5660300002)(8936002)(7416002)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:21:28.7610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96af125d-1238-4855-d82d-08db88aee148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

