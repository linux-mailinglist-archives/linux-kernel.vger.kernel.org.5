Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABD375A2BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGSXWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjGSXWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:22:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE76E53;
        Wed, 19 Jul 2023 16:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLK9Lw3auvgXwOr+rbO7u5NpMYZUeYIc5Nz3lGKBnzmBW1KooQgc4O9iYGFDW+1/na8IA5/MiUWfc5ANOr5/yRFZ3moM7EZk4EyW3Ixi2Ev0VC15rkmOHE6OfD1y8qeS5S02JD3SY8KexrMgVWU8dPHVX5qXB+7Fpbm8HhIH0mWi6pZGwJNQREykanMTp71YM7Ix5uxJbER1jzbKEIdiIqBBLnkp5vcur255JOUyolI6fqOW/mdVz0Ei017ontINX0swhJ1pAkuQX1YUGAlkXBgxXagLNrfztMtJdpUR/qJ8qhMwvzm2eG+QcsiEPQyXs/nfGUhldB4khVqp2sbDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqYCi8ldNKkURthjbG3PWbyXcm2Z9fqG5Z7innpufOw=;
 b=KmuBeJ2uszGNHyrYIt5R3hRmjHrw0hM5IUlhMm7D6AmHHzg1VbXtizXFVH3HWuCwGY/2Q48ZJZFMlhOO/uHXf0saTt3YqK+5537VcGdVUJ84corzXUipUjey/nZy5YrWBPD7Cu+FKdmvmnV9jgWyjH483q6+PxJUeMnAslqImpNEvvfLGHx9xctMPZlTom/PrbPv5hP5kcNZSBgyy5MPn1oUBwGAaaGdBhc+c7mDEhFNfnNj3pzMLEzXqUfa1iSd7uQd4q9ZmQ8K5iP4v0kU55KA0cCmFyKJXP9JP69MK76hJzTNRKW4ASVJhKTo5zD6koEI0SlKxKbOzv2sjoAXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqYCi8ldNKkURthjbG3PWbyXcm2Z9fqG5Z7innpufOw=;
 b=hZa+ackwChZn0lWGYWnXZQE+7EKPfuw+TAx4QgXyqZJHDxPu1UhqUSyE3D+BCUinq0wTUUdH4H7xj/BYMbs3KJ5Z9Ko9bWYfg4dqu4XpuGUvIFl9pfTdxCQKk5knOLI70tdQxj4Y86/MUGLfqhSPF16XYrCFEu5E7gkrDbHaNco=
Received: from SJ0PR03CA0162.namprd03.prod.outlook.com (2603:10b6:a03:338::17)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 23:21:51 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:338:cafe::de) by SJ0PR03CA0162.outlook.office365.com
 (2603:10b6:a03:338::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 23:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 23:21:50 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 18:21:48 -0500
Subject: [PATCH v6 3/8] x86/resctrl: Rename rftype flags for consistency
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
Date:   Wed, 19 Jul 2023 18:21:46 -0500
Message-ID: <168980890686.1619861.10667395157566002978.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|MN2PR12MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc1ecec-12fe-46a5-b85c-08db88aeee48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxU8qj+7B/fBlKMso1zIHQgyz219R6rOatqUpuBtZZYZMSZSQ9ig3A9r+H6sLH7nUoPu4DS4xSkzLgjvB8fntt1BlL1BGhUmMD8nd+GZcuFoZBrWFDC98qJIUAjdgm4mRZcY59PvS2c27kbGMXATASPm/2QjtzodCwgWuHgyiDyPIkvmsWHAZKb4g30I3o8STMS1qfAYSb3VnVic2veRyhNLaDGc44VHChQQH933wLzFhkGr+vLP4E1q09wJ5M4V6ajCKqa+o1QJ29Ypp+nLzzxlws5zuKGqSjCpxTbXdcQGZhzLrKFrP1h4xDG+zjxoEOjVXB9tuARmexXliCSTgYH+ErXcZF1NJbqflo4jQEMEZaLHA7+d2uyp7rlw1lqO78e4WIhzmmX8QOByOkWReiPi/gBef202pfThT5+KaKTXubcVtKQ+eGBFBdc5XSHyJzq78SX9uenzlgyMXagAauZ2wPzoLGrYpbwcq2/SsLCYy5MrLe3b/2qPmJjhLg/nn6zaxZohsDORfHPAe1DY0u2EZL4FzjJ4YNzFdZf254jicJ5CM8q8EvEuRRFaRbwmGihV8L/4kaqg4Xf3CjwO/rLUgChU3WcL2sG7mmLNtbJ/vfe3/hN6dyNnX3i0X7Rr8yNujCuVPMyN7WHYsFJNwe0XpQHG5GGv0w6T7TDRiwAR5w5BNxWetLLXbxdNm3F5TyZ0GJ2TpZKddGAUm+NhOQ8sRtpDiUz0eCSgJt7Re+gD58D0AhV38VlDMyeBdDEJyRXncsSHDUG/aV36HkGDbXBr09mDPSyTEoKYZqmQC10=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(40460700003)(336012)(16526019)(426003)(26005)(186003)(36860700001)(47076005)(83380400001)(70586007)(70206006)(16576012)(4326008)(316002)(7406005)(8676002)(8936002)(7416002)(44832011)(41300700001)(5660300002)(9686003)(2906002)(478600001)(54906003)(110136005)(40480700001)(33716001)(356005)(81166007)(103116003)(86362001)(82740400003)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:21:50.5706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc1ecec-12fe-46a5-b85c-08db88aeee48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
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

