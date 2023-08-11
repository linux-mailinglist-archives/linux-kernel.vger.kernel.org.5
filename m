Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C7877984A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjHKULB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbjHKUK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:10:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBEC30FF;
        Fri, 11 Aug 2023 13:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY21Ek9G4PuepjwBMYHgEVdC/9rSwgjcGuJdtECU6QQNFU30sElhadKQaazwuV5/nIUtVYXQC9YcO0kaCLzlUb31J8vFIheZTH+NeDm5uyHgfgZoqFtRmoEL33D5XM9ueYzSZNsqUXnXW1OADMpg4Vox4MyjnDgTKThq25/9q7Ez3x8MfYeRbGIVVCvJB4P2DNCcqboOTaLG9kVJurvsm3k/lxgNMcxTAQkWD/YvbYbQ3nGAovuPuH7Vm6hg2buseTXUAA7sO4kITk2sZ/1wQjcKsU2DnDXVlJb9S1RVq2+NNL1oKsHFOeUwc+8A3xd3JXzh1HDkMUqRPU3K5huT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4IhmNsexbxxmpffLsCR8dkV/Tuq3QoG6vGiVUEFgpg=;
 b=TZCBHog1gUXYVI70oQ1hsYq2pPMljonPaVJe74AcQOhFpSu8maFSQJdaL7iAFl7+aZQiimMbZ9LKlCWMBZZ8dDSdPeAzuTNcOhgWAgmaftVbUtbuSvVz2vdqavxTkG/SwkTOBKV+jtocSqEXTP/mnYXGsMuEhdhfPpEM5BUtfiNkaAlYr4Xsp7qW7GIahiHIX7I/BRM/juwkJitB2NNGWCCe/zCstIQTgrzOuDuBQxZe23JcnkYYuMsLRVotjGQtJNPxYsk6uWNUzaTby63PU4H90N2yJmdwkwjnKl8udBsDbVE5zxsXoz+IC0p6RDr1ot8R2t0ebZfUz682lYR18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=csgroup.eu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4IhmNsexbxxmpffLsCR8dkV/Tuq3QoG6vGiVUEFgpg=;
 b=jTLi3mRCk4HPJrP1TnvLl0/U04rwk62j27lhqsfCMvAEZ8SSmHTiIupaxEkKfsy9lG/9sdmlUn/BbmRauinwbome0pOWaOryMqd3Z9DrQfBYRh0P5Umdn9fKSyJbri8OiarzLNEooWz8geIlBFrklkNNz7/uyYsgJOdfsmdeGGs=
Received: from BYAPR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:74::24)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 20:10:52 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::b8) by BYAPR05CA0047.outlook.office365.com
 (2603:10b6:a03:74::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Fri, 11 Aug 2023 20:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 20:10:52 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 15:10:50 -0500
Subject: [PATCH v7 7/8] x86/resctrl: Introduce "-o debug" mount option
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
Date:   Fri, 11 Aug 2023 15:10:49 -0500
Message-ID: <169178464934.1147205.6915303244307989200.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2fc9e5-e71e-44c5-b156-08db9aa71024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFf5qI3QWM9N7faX3miY5cREpsG4x8hX/2AaHehbR47evfCb0Ug2LWH76FuAYy0qV1PEBAAtURfHby1EZF4PwSZYO1bYeIF9njR2qSxmh6/YajvJoQ6xUlyhvrl5RYgTdYjpDkRH+ALBUjcSlSAiSGmlspytiYYlOnAapL2TYam4zfgToG566sj/csDNgesTeYX3iz0fEvrLlj7Qn522LtfJd8mL9Njk2hm5OGvLBPEN95IbToqOzmvxijFSLaLEXvSI7KdJUjTtKBLvMVW5oSQfLFgbevBJjRBEFgxUNZoc0zMNYZ/ezNtmXHfJytWW6QmaP7flmi7TUfBnPVjeIORpjY/74P+u5ygrwD3s3FRaTgvXWx/cKicmcX3PJH6j8yaHMzROeKniz4F6UgqOAloKlNGKRqohn4BJYA3a1/+2AmJKxMGMt/Sd9AblIRFHiAveGmwOsemUBf2SBo1hEEzSRYPgSXT3Z9wx5zeGOkIzL2ZWX/aZBPUE5lwg2DWI9lXo2P87jTOS7MojVKX2tv2+S7956mA+0V5+kTHiW2oVPhg6nJzqh+bmP0+PiIhMnec9cEmMZRPXwf3dtBZ2ud/gJlfi+b5sk/qUx7OqjJBQAYZ0v6tnEJaJrKjWoisGq6hMh/k0ZHBg+ct635q8gKVdPxlm9a4YnWJ50XOBRqWM9bWKf3xaZw3JIWy6EYTz9YRn76DTCXBW1WxP/IDbNIKI5R2r1ArooxoxK5mK57UVF7z7qcClYnCcSuTEMw4l+x0CZ5kd/P8/aLTAec5KbJrTxO66WIv0fXFVRmMWW9I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(396003)(346002)(376002)(39860400002)(1800799006)(82310400008)(186006)(451199021)(36840700001)(40470700004)(46966006)(4326008)(9686003)(478600001)(54906003)(110136005)(70586007)(316002)(70206006)(16576012)(5660300002)(40480700001)(41300700001)(40460700003)(8936002)(8676002)(26005)(86362001)(33716001)(82740400003)(336012)(7416002)(7406005)(44832011)(16526019)(103116003)(36860700001)(47076005)(81166007)(356005)(2906002)(426003)(83380400001)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:10:52.2394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2fc9e5-e71e-44c5-b156-08db9aa71024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "-o debug" option to mount resctrl filesystem in debug mode. This=0A=
option is used for adding extra files to help resctrl debugging.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/arch/x86/resctrl.rst     |    5 ++++-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    2 ++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   21 +++++++++++++++++++++=0A=
 3 files changed, 27 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/re=
sctrl.rst=0A=
index af234681756e..5a2346d2c561 100644=0A=
--- a/Documentation/arch/x86/resctrl.rst=0A=
+++ b/Documentation/arch/x86/resctrl.rst=0A=
@@ -35,7 +35,7 @@ about the feature from resctrl's info directory.=0A=
 =0A=
 To use the feature mount the file system::=0A=
 =0A=
- # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl=0A=
+ # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps][,debug]] /sys/fs/re=
sctrl=0A=
 =0A=
 mount options are:=0A=
 =0A=
@@ -46,6 +46,9 @@ mount options are:=0A=
 "mba_MBps":=0A=
 	Enable the MBA Software Controller(mba_sc) to specify MBA=0A=
 	bandwidth in MBps=0A=
+"debug":=0A=
+	Make debug files accessible. Available debug files are annotated with=0A=
+	"Available only with debug option".=0A=
 =0A=
 L2 and L3 CDP are controlled separately.=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 2bd92c0c3b0c..4689e87ec638 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -59,6 +59,7 @@ struct rdt_fs_context {=0A=
 	bool				enable_cdpl2;=0A=
 	bool				enable_cdpl3;=0A=
 	bool				enable_mba_mbps;=0A=
+	bool				enable_debug;=0A=
 };=0A=
 =0A=
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)=
=0A=
@@ -297,6 +298,7 @@ struct rdtgroup {=0A=
 #define RFTYPE_TOP			BIT(6)=0A=
 #define RFTYPE_RES_CACHE		BIT(8)=0A=
 #define RFTYPE_RES_MB			BIT(9)=0A=
+#define RFTYPE_DEBUG			BIT(10)=0A=
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)=0A=
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)=0A=
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index a7453c93bad4..6b7e914657fa 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -56,6 +56,8 @@ static char last_cmd_status_buf[512];=0A=
 =0A=
 struct dentry *debugfs_resctrl;=0A=
 =0A=
+static bool resctrl_debug;=0A=
+=0A=
 void rdt_last_cmd_clear(void)=0A=
 {=0A=
 	lockdep_assert_held(&rdtgroup_mutex);=0A=
@@ -1871,6 +1873,9 @@ static int rdtgroup_add_files(struct kernfs_node *kn,=
 unsigned long fflags)=0A=
 =0A=
 	lockdep_assert_held(&rdtgroup_mutex);=0A=
 =0A=
+	if (resctrl_debug)=0A=
+		fflags |=3D RFTYPE_DEBUG;=0A=
+=0A=
 	for (rft =3D rfts; rft < rfts + len; rft++) {=0A=
 		if (rft->fflags && ((fflags & rft->fflags) =3D=3D rft->fflags)) {=0A=
 			ret =3D rdtgroup_add_file(kn, rft);=0A=
@@ -2387,6 +2392,9 @@ static void rdt_disable_ctx(struct rdt_fs_context *ct=
x)=0A=
 =0A=
 	if (ctx->enable_mba_mbps)=0A=
 		set_mba_sc(false);=0A=
+=0A=
+	if (ctx->enable_debug)=0A=
+		resctrl_debug =3D false;=0A=
 }=0A=
 =0A=
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)=0A=
@@ -2411,6 +2419,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)=
=0A=
 			goto out_disable;=0A=
 	}=0A=
 =0A=
+	if (ctx->enable_debug)=0A=
+		resctrl_debug =3D true;=0A=
+=0A=
 	return 0;=0A=
 =0A=
 out_disable:=0A=
@@ -2612,6 +2623,7 @@ enum rdt_param {=0A=
 	Opt_cdp,=0A=
 	Opt_cdpl2,=0A=
 	Opt_mba_mbps,=0A=
+	Opt_debug,=0A=
 	nr__rdt_params=0A=
 };=0A=
 =0A=
@@ -2619,6 +2631,7 @@ static const struct fs_parameter_spec rdt_fs_paramete=
rs[] =3D {=0A=
 	fsparam_flag("cdp",		Opt_cdp),=0A=
 	fsparam_flag("cdpl2",		Opt_cdpl2),=0A=
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),=0A=
+	fsparam_flag("debug",		Opt_debug),=0A=
 	{}=0A=
 };=0A=
 =0A=
@@ -2644,6 +2657,9 @@ static int rdt_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)=0A=
 			return -EINVAL;=0A=
 		ctx->enable_mba_mbps =3D true;=0A=
 		return 0;=0A=
+	case Opt_debug:=0A=
+		ctx->enable_debug =3D true;=0A=
+		return 0;=0A=
 	}=0A=
 =0A=
 	return -EINVAL;=0A=
@@ -2833,6 +2849,8 @@ static void rdt_kill_sb(struct super_block *sb)=0A=
 =0A=
 	set_mba_sc(false);=0A=
 =0A=
+	resctrl_debug =3D false;=0A=
+=0A=
 	/*Put everything back to default values. */=0A=
 	for_each_alloc_capable_rdt_resource(r)=0A=
 		reset_all_ctrls(r);=0A=
@@ -3713,6 +3731,9 @@ static int rdtgroup_show_options(struct seq_file *seq=
, struct kernfs_root *kf)=0A=
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))=0A=
 		seq_puts(seq, ",mba_MBps");=0A=
 =0A=
+	if (resctrl_debug)=0A=
+		seq_puts(seq, ",debug");=0A=
+=0A=
 	return 0;=0A=
 }=0A=
 =0A=
=0A=

