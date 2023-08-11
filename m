Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D23779840
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbjHKUJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjHKUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:09:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0533E30F8;
        Fri, 11 Aug 2023 13:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoHDhCgztulUx2EgSOSvA35bxwgf0Y/cDSCEpfGhwC3lDbG9OTDg/kW/gMRCdZKfXgNwl6Bbb6Qc0f06SEoR/ADH+oyMHhpuOn35AR/RWt2gJS9JdezLfDXMN+C1zx9ZNVD3C5rqslk4afNJguewyKap0lNRC0NTC9CWfB2enGIVgv6iaRsLwiY0ALXiw5hLwoilRR0QgWNbdRUvd/F7AviUKg/vcj/a0bbKkYPPvyl/JRBHRlBpW68NOt2MOxoNfVa8z+3XOdcGHvSASG+s5p1JFI5C1AUlJucoE2Q3LvgJBfKx8bFT8kWPyaFyKnLveqHVhHOzmgL3/LbcMcSokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuEnOFEyu1DSfIuALeQr57ZKwBzWcxoQIVgTeYOQnyk=;
 b=CfLuaH380dVwwIcmUKbePDChvrHaxA2zGy0uhfRUa5srFTAb6Teu/FMqitH9/TyDVU9kr9O8vTYdAoy1209+wXOEm3DHMri0VjjJ/ZKIVIil6JDK9R6R7hEC1YAOKZ+4EUhqXy8Ecr1KSReAJA/0CUyRluqIf4p0KYFjx6J0vk10yK7bA3SdvCeDnJh2HKC1WaTiTsRXTg/nM0CN0wfYI1s6mrZIS3vAKs8D+a3MTrj5nDvMDVDCz4DoTV/wSAwfCc9zc0YwEyawckBSHrvpysUFqaLS+0+OnbuLeFirRcWW+VaBLeYHDt2Zu5OFqT4/+ev9VAK8A52Rh8a7J0gfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=csgroup.eu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuEnOFEyu1DSfIuALeQr57ZKwBzWcxoQIVgTeYOQnyk=;
 b=GIuYvvsCWnXttqDgDjDaciH5GHFHSB3WoC5rln0NKbNhg098lYOhDYXQSYQ+FlQ4o5kqvocuZYB8HRS8S19hgPVwCX7yl8kdWegXS/R80VQbzayh38U1B9pJ/Sfvkbo2Hr7BzH7zs9j5OYOlJzcEqEz/7oISH2mO1W0mZSIjAms=
Received: from BYAPR04CA0033.namprd04.prod.outlook.com (2603:10b6:a03:40::46)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 20:09:43 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::f7) by BYAPR04CA0033.outlook.office365.com
 (2603:10b6:a03:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Fri, 11 Aug 2023 20:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 20:09:42 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 15:09:39 -0500
Subject: [PATCH v7 3/8] x86/resctrl: Rename rftype flags for consistency
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
Date:   Fri, 11 Aug 2023 15:09:38 -0500
Message-ID: <169178457798.1147205.16211900713494712341.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: f3002ab3-6210-46ef-0da0-08db9aa6e6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7K8/aklYzRx966TjkJXqndQ5SkFDknEi3RtuE1/d0j1/J8CMeSEUy+NuxYqBcWDcGK16BCIA+YwWT257kHPwWv++wtMhaEXuQx1Xw7wbQ+mT4vX375v+4JBrrNDmXd+LcJeF31TaYGeVHGXGgRtKyeKcyzh1WCYMZ31ypJgnX714rnN4lXfQjRaGaoE6X4RsvbMu+yD7Ve7R4Qa+G/IyV9+pwNPTm6e2tWM+9vbHTY9Fl6ycluxJRswC43sjooSTBMMmKttrd88JEVI0QChhMBiaQJMnPqvel2eYy7GFxS3+7ouPtUuubguMJah1yKTJRVKb/O/KDC45NQCgcDfZrG+FEH5sYafd0IV+dYgYfUyzNozaNOwSVx8PWgvS3Pqri/PSjjkmbQ6oicjVN3Bpeud1kjUk1cqUZxH7TUzRUuKqqkjYoimzuA+MY9rFqkRQRo1Wq3BZslq1iATdmmavDOA4ptmG8z7UlvN/NqldoC2zh5uTaOTgW+G6b7CjvEF7giwpjbRlBrjW9EkAI11x7bMt30W0+Cr5uf+s/r0XGAwNzr/OCx7Jetk2JYXZjnsHzF5GIRQGvcqI7dslB01KLMTF+BK9dvPLtyNpnGYaSnNv3+JKwfErts4xCls3ASd9ydb8ONNNoCVLlUSp3Fd8cu84pnxKrhSpN/BWPV8qOiN1AbUNzEO4a2kBJH34+Pc244K74IPjR2IvXL6FghxNwlbVwaAFUFhXhCrUbMnJzq6PqsuhnUtL7rCDJ+mbTksuztWMxHjk7geD9XYRbDkt7uNQ7OW0nA/7RdZ9pWUKcF8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(82310400008)(1800799006)(186006)(46966006)(36840700001)(40470700004)(44832011)(40460700003)(2906002)(16576012)(316002)(8936002)(8676002)(7406005)(7416002)(5660300002)(41300700001)(103116003)(33716001)(40480700001)(86362001)(4326008)(9686003)(26005)(16526019)(82740400003)(356005)(81166007)(83380400001)(47076005)(336012)(110136005)(36860700001)(426003)(54906003)(478600001)(70586007)(70206006)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:09:42.7459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3002ab3-6210-46ef-0da0-08db9aa6e6b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl associates rftype flags with its files so that files can be chosen=
=0A=
based on the resource, whether it is info or base, and if it is control=0A=
or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.=
=0A=
=0A=
Change the prefix to RFTYPE_ for all these flags to be consistent.=0A=
=0A=
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>=0A=
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>=0A=
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |   10 ++++----=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   42 ++++++++++++++++------------=
----=0A=
 2 files changed, 26 insertions(+), 26 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 62767774810d..2051179a3b91 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -248,10 +248,10 @@ struct rdtgroup {=0A=
 #define RFTYPE_TOP			BIT(6)=0A=
 #define RFTYPE_RES_CACHE		BIT(8)=0A=
 #define RFTYPE_RES_MB			BIT(9)=0A=
-#define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)=0A=
-#define RF_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)=0A=
-#define RF_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)=0A=
-#define RF_CTRL_BASE			(RFTYPE_BASE | RFTYPE_CTRL)=0A=
+#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)=0A=
+#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)=0A=
+#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)=0A=
+#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)=0A=
 =0A=
 /* List of all resource groups */=0A=
 extern struct list_head rdt_all_groups;=0A=
@@ -267,7 +267,7 @@ void __exit rdtgroup_exit(void);=0A=
  * @mode:	Access mode=0A=
  * @kf_ops:	File operations=0A=
  * @flags:	File specific RFTYPE_FLAGS_* flags=0A=
- * @fflags:	File specific RF_* or RFTYPE_* flags=0A=
+ * @fflags:	File specific RFTYPE_* flags=0A=
  * @seq_show:	Show content of the file=0A=
  * @write:	Write to the file=0A=
  */=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 2f1b9f69326f..3010e3a1394d 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1705,77 +1705,77 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_last_cmd_status_show,=0A=
-		.fflags		=3D RF_TOP_INFO,=0A=
+		.fflags		=3D RFTYPE_TOP_INFO,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "num_closids",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_num_closids_show,=0A=
-		.fflags		=3D RF_CTRL_INFO,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mon_features",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_mon_features_show,=0A=
-		.fflags		=3D RF_MON_INFO,=0A=
+		.fflags		=3D RFTYPE_MON_INFO,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "num_rmids",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_num_rmids_show,=0A=
-		.fflags		=3D RF_MON_INFO,=0A=
+		.fflags		=3D RFTYPE_MON_INFO,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "cbm_mask",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_default_ctrl_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "min_cbm_bits",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_min_cbm_bits_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "shareable_bits",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_shareable_bits_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "bit_usage",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_bit_usage_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "min_bandwidth",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_min_bw_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_MB,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "bandwidth_gran",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_bw_gran_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_MB,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "delay_linear",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdt_delay_linear_show,=0A=
-		.fflags		=3D RF_CTRL_INFO | RFTYPE_RES_MB,=0A=
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,=0A=
 	},=0A=
 	/*=0A=
 	 * Platform specific which (if any) capabilities are provided by=0A=
@@ -1794,7 +1794,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.write		=3D max_threshold_occ_write,=0A=
 		.seq_show	=3D max_threshold_occ_show,=0A=
-		.fflags		=3D RF_MON_INFO | RFTYPE_RES_CACHE,=0A=
+		.fflags		=3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mbm_total_bytes_config",=0A=
@@ -1841,7 +1841,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.write		=3D rdtgroup_schemata_write,=0A=
 		.seq_show	=3D rdtgroup_schemata_show,=0A=
-		.fflags		=3D RF_CTRL_BASE,=0A=
+		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mode",=0A=
@@ -1849,14 +1849,14 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.write		=3D rdtgroup_mode_write,=0A=
 		.seq_show	=3D rdtgroup_mode_show,=0A=
-		.fflags		=3D RF_CTRL_BASE,=0A=
+		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "size",=0A=
 		.mode		=3D 0444,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D rdtgroup_size_show,=0A=
-		.fflags		=3D RF_CTRL_BASE,=0A=
+		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
 	},=0A=
 =0A=
 };=0A=
@@ -1913,7 +1913,7 @@ void __init thread_throttle_mode_init(void)=0A=
 	if (!rft)=0A=
 		return;=0A=
 =0A=
-	rft->fflags =3D RF_CTRL_INFO | RFTYPE_RES_MB;=0A=
+	rft->fflags =3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB;=0A=
 }=0A=
 =0A=
 void __init mbm_config_rftype_init(const char *config)=0A=
@@ -1922,7 +1922,7 @@ void __init mbm_config_rftype_init(const char *config=
)=0A=
 =0A=
 	rft =3D rdtgroup_get_rftype_by_name(config);=0A=
 	if (rft)=0A=
-		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;=0A=
+		rft->fflags =3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE;=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -2057,21 +2057,21 @@ static int rdtgroup_create_info_dir(struct kernfs_n=
ode *parent_kn)=0A=
 	if (IS_ERR(kn_info))=0A=
 		return PTR_ERR(kn_info);=0A=
 =0A=
-	ret =3D rdtgroup_add_files(kn_info, RF_TOP_INFO);=0A=
+	ret =3D rdtgroup_add_files(kn_info, RFTYPE_TOP_INFO);=0A=
 	if (ret)=0A=
 		goto out_destroy;=0A=
 =0A=
 	/* loop over enabled controls, these are all alloc_capable */=0A=
 	list_for_each_entry(s, &resctrl_schema_all, list) {=0A=
 		r =3D s->res;=0A=
-		fflags =3D  r->fflags | RF_CTRL_INFO;=0A=
+		fflags =3D r->fflags | RFTYPE_CTRL_INFO;=0A=
 		ret =3D rdtgroup_mkdir_info_resdir(s, s->name, fflags);=0A=
 		if (ret)=0A=
 			goto out_destroy;=0A=
 	}=0A=
 =0A=
 	for_each_mon_capable_rdt_resource(r) {=0A=
-		fflags =3D  r->fflags | RF_MON_INFO;=0A=
+		fflags =3D r->fflags | RFTYPE_MON_INFO;=0A=
 		sprintf(name, "%s_MON", r->name);=0A=
 		ret =3D rdtgroup_mkdir_info_resdir(r, name, fflags);=0A=
 		if (ret)=0A=
@@ -3709,7 +3709,7 @@ static int __init rdtgroup_setup_root(void)=0A=
 =0A=
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);=0A=
 =0A=
-	ret =3D rdtgroup_add_files(kernfs_root_to_node(rdt_root), RF_CTRL_BASE);=
=0A=
+	ret =3D rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BAS=
E);=0A=
 	if (ret) {=0A=
 		kernfs_destroy_root(rdt_root);=0A=
 		goto out;=0A=
=0A=

