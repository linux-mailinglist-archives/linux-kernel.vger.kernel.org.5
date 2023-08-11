Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F4777984C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjHKULv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjHKULt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:11:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB0335AF;
        Fri, 11 Aug 2023 13:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBo31yxoPSaMc/zKkzNVHq8Uc0E0qusfn1PQ+N9qiVsaaXhnfiHEiGwRbkwo2rdiNYZfkAx9B1Org0dUhHfYrImOQUlWbnvU7Bxk9gZk5rvtqf2eTeYTthjjdOGSGxL/gXDCfdTHfKFR5sjMRDn2Bp9nG+CccczPW/pz8kq9CczzL/ngiKozpPF66AIDafPzyv8XoZ6QrmDxHBFbtceEj+EumlBJyMcKfh9eKHUI3Ewk40NA+xSXAKe0yRorr4UaweBgO0wJBtyWy8kXoJBdfjaf3q/f9vfs03zKB/+vHmqII1OWyk6F+xGdri+rG/yCMk12m8kDNxyHhRad536Ecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9WOWk3ZVA3KLqDN7eazTkBRKFW3gnVqyDdAPi+QCf4=;
 b=ls6QMqTiDUcCZ6M6QL+JSxSID+dF8oaMruE4KSbGcz2ByyUUELJQ4qX4Sdu9SztUkryGpK8Sct5gJDrGN6b/P5hiEaB1iq3FoTzA681IvM66kE9QTCmuz2w7MHdIqU5tPSs4JFGFpPmPcn+BmRHgAY8O/KjCWhW+AxgLTa+WSfiLKuPYTyXMHmizQCfpIc4dNjOm36BFcSyIvzcs6bxTmX0/53QxhWmX1CLwEdoc9G7J7WlmH9Zgf16znsvGLt0/PvObVKQ6jgatr2/GvKIgMwXPVBG6kWp+gwGo2WwtJKZFazDqfokDHUX5GY3A7ZuW2rnSkVEQTiSQxTFAO/BrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=csgroup.eu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9WOWk3ZVA3KLqDN7eazTkBRKFW3gnVqyDdAPi+QCf4=;
 b=yEPVgkdq5Lz5lRs94IdeHNZoTzdhPw7sPdrghntjVjIFJcjJHEEFNVdAqfFT+FLTS++B565fD9AKPDau2mY1jf6eAEi/ocUfCLCPS38oH4iXkvAKkIxe9XPpfRRNz7lrcr7ZqfqwuXClbLgmjZRrjMsG5KoDueYtWFtjhTBsVSk=
Received: from DM6PR06CA0076.namprd06.prod.outlook.com (2603:10b6:5:336::9) by
 CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.20; Fri, 11 Aug 2023 20:11:29 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::13) by DM6PR06CA0076.outlook.office365.com
 (2603:10b6:5:336::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 20:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 20:11:29 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 15:11:26 -0500
Subject: [PATCH v7 8/8] x86/resctrl: Display hardware ids of resource groups
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
Date:   Fri, 11 Aug 2023 15:10:57 -0500
Message-ID: <169178465701.1147205.1483883019768336774.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CH2PR12MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5cf2a6-0a15-47cb-8d20-08db9aa72648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7qLwyJUzorPqWRvP0fiwyF9nIZeEE9t4kQ/m4PUCli2/Y5z5UXeLNylBwXikBGQyGkIRCHjcv2laljk1OsvZDziE0oe15mm8fhdUXwiJSVsKOyjeK77Trm67ruXFXPOVl3KSmq7p/dkCDRnotR3yP5Us8UZRZOM6mf9N7rxRIQdpo+iw9/jO2GTKyDfQ1QOkEica8mKwpTxkS3LI3E4DeZKPSuMpmeGxRLGU0RWDNJ6IovTM4x4ftMSQVnFIF1IqQRYqqe///guTqd+mAtRN5cNiYQnI0AbDeHpzgBIPZGIbrvEKwqpfNFtfbQdg2Gum4RFnL4oU56dUktaL2ymV++EEg+DvXeujCOcbBwfPhFicxpMh0cI5m3OJeyUctkmKUy5Y0vIVa4O1LH17svAkcEOmSWejye4lgjN86tVxjxX2qy7YjSfw/MB1JMy0YOOnO918zyjK0dYg+rHfPzMwfzKAylVsJyXACvkvVWzA5y8IZOQUbyJKeEo6Em72i5FPY1Y8LpXTCSY9WzLiABwa8YaLLUPCH+6fL3YS1vBYq5wFC9R2bgMI16ExRZQ29uxIxC3vPR8MDqM5v+/EqJGtbW8qyHW+l0e+ixQyu5JNCCSOnvLfGCrCtaBOTwRD3+SYWz/nj42y/czW+Ci5fxwdLy7PcoOXpqoy/Tg/rTbO6Lok0jG+pqw/hKM4EH7CJ9MnqwQKnSeacHS67Q+c+uz/yJOlU3t3BYOuk37q6cvJ3qdwQNgnb07x1r1F0z+84KAauIfh5Gvla475lXg/tA/E9caEznL/0JS/Sqv5qmDp3Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(39860400002)(376002)(136003)(346002)(186006)(1800799006)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(33716001)(6666004)(5660300002)(356005)(8676002)(4326008)(8936002)(82740400003)(81166007)(40480700001)(9686003)(110136005)(70586007)(86362001)(70206006)(47076005)(478600001)(103116003)(7406005)(7416002)(83380400001)(16526019)(26005)(16576012)(2906002)(54906003)(316002)(36860700001)(41300700001)(426003)(336012)(44832011)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:11:29.4624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5cf2a6-0a15-47cb-8d20-08db9aa72648
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86, hardware uses CLOSID and an RMID to identify a control group and=0A=
a monitoring group respectively. When a user creates a control or monitor=
=0A=
group these details are not visible to the user. These details can help=0A=
debugging.=0A=
=0A=
Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups=0A=
display in resctrl interface. Users can see these details when resctrl=0A=
is mounted with "-o debug" option.=0A=
=0A=
Other architectures do not use "CLOSID" and "RMID". Use the names=0A=
ctrl_hw_id and mon_hw_id to refer "CLOSID" and "RMID" respectively in an=0A=
effort to keep the naming generic.=0A=
=0A=
For example:=0A=
 $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id=0A=
 1=0A=
 $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id=0A=
 3=0A=
=0A=
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>=0A=
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/arch/x86/resctrl.rst     |    8 ++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   46 ++++++++++++++++++++++++++++=
++++=0A=
 2 files changed, 54 insertions(+)=0A=
=0A=
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/re=
sctrl.rst=0A=
index 5a2346d2c561..41ad9b1f0c6a 100644=0A=
--- a/Documentation/arch/x86/resctrl.rst=0A=
+++ b/Documentation/arch/x86/resctrl.rst=0A=
@@ -351,6 +351,10 @@ When control is enabled all CTRL_MON groups will also =
contain:=0A=
 	file. On successful pseudo-locked region creation the mode will=0A=
 	automatically change to "pseudo-locked".=0A=
 =0A=
+"ctrl_hw_id":=0A=
+	Available only with debug option. The identifier used by hardware=0A=
+	for the control group. On x86 this is the CLOSID.=0A=
+=0A=
 When monitoring is enabled all MON groups will also contain:=0A=
 =0A=
 "mon_data":=0A=
@@ -364,6 +368,10 @@ When monitoring is enabled all MON groups will also co=
ntain:=0A=
 	the sum for all tasks in the CTRL_MON group and all tasks in=0A=
 	MON groups. Please see example section for more details on usage.=0A=
 =0A=
+"mon_hw_id":=0A=
+	Available only with debug option. The identifier used by hardware=0A=
+	for the monitor group. On x86 this is the RMID.=0A=
+=0A=
 Resource allocation rules=0A=
 -------------------------=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 6b7e914657fa..94471ad9d905 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -776,6 +776,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file=
 *of,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+static int rdtgroup_closid_show(struct kernfs_open_file *of,=0A=
+				struct seq_file *s, void *v)=0A=
+{=0A=
+	struct rdtgroup *rdtgrp;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
+	if (rdtgrp)=0A=
+		seq_printf(s, "%u\n", rdtgrp->closid);=0A=
+	else=0A=
+		ret =3D -ENOENT;=0A=
+	rdtgroup_kn_unlock(of->kn);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static int rdtgroup_rmid_show(struct kernfs_open_file *of,=0A=
+			      struct seq_file *s, void *v)=0A=
+{=0A=
+	struct rdtgroup *rdtgrp;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
+	if (rdtgrp)=0A=
+		seq_printf(s, "%u\n", rdtgrp->mon.rmid);=0A=
+	else=0A=
+		ret =3D -ENOENT;=0A=
+	rdtgroup_kn_unlock(of->kn);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
 #ifdef CONFIG_PROC_CPU_RESCTRL=0A=
 =0A=
 /*=0A=
@@ -1837,6 +1869,13 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdtgroup_tasks_show,=0A=
 		.fflags		=3D RFTYPE_BASE,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mon_hw_id",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_rmid_show,=0A=
+		.fflags		=3D RFTYPE_BASE | RFTYPE_DEBUG,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "schemata",=0A=
 		.mode		=3D 0644,=0A=
@@ -1860,6 +1899,13 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdtgroup_size_show,=0A=
 		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "ctrl_hw_id",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_closid_show,=0A=
+		.fflags		=3D RFTYPE_CTRL_BASE | RFTYPE_DEBUG,=0A=
+	},=0A=
 =0A=
 };=0A=
 =0A=
=0A=

