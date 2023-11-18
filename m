Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C1F7F02A8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjKRTeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjKRTdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:19 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1777D57;
        Sat, 18 Nov 2023 11:33:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJcdmqUtT6Z9d9ajapyKNkSKd5oN7JdE/J6c+jxl+hZ8yMfg/AXgiQ3AUe/oT0ROo8C4gwToszLwyoRXUIB1JQa9VThjxaw5RjuWMyjTIIiRvoLE71+WfBRtwpXfCx55u8gC/ZqFTv+2BvfKoAGzHu3gVSok4NB1UkicDpGaalGV6WmZS6ZwTG8jdI1n+E0pWFum8z5M46D5VAV6punVD5e/5tAwelvwUK+aDkpiO0RDzk48R+gmPFQVGvwwNGaO11oG/EmVGZRUPaID8i7FnxhVIntSlk5OVxN6MjNgLrijtkn2XrmdYlx3nRN7MA+zAuiok4pp6I9MMRJEmLdkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46vvSj727+xBFryn8AIsnDiQs4j6FkQnAMDhKMXIZg4=;
 b=YvfsY59Xzx/eqakXiF31WT9/Eh9gU3C5EFvUAlLzRPtfb6tTCMGdrlnT/7gB+sW7m6NjWmBDCWAfrSN2e8EMZ47YraExLIAXqKUxsmoUNM2J9FwZdBnoJ9mlYdirrp+O285K0yT6DYDduC0Fha6Wkjmy342tBWjVLpf4yIZIc95/PXxHvUf+SY09pTD6f/V9DJNr/WRFeF7Ofp9l+1LFSZc1MSC5llOgHDuYJGUE05GI87Zm0qUYif7u2L84HZqZt1LAv+6N3DIEBKkl2/tSWJkRPEqgqBlHHt2iXhoH8YZVqQGjqoAW8Jjuo+gukMUNvDLeKJWYmYOUqHcV/TQikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46vvSj727+xBFryn8AIsnDiQs4j6FkQnAMDhKMXIZg4=;
 b=E7LvCEZOE1QM4JgIvj2GnmZAFKmDmthdzJKZ9LWoRLLdwTVD1LpjgfkvUcbDE1vt6CCXLS9U2kgbN2L3+cPsKHI1P3IeLTt2Z3t4IpWydQgIC3Js2uqLlZyj6Va49p+v02ljQSVVUar7b6L56CfB7fZKIQN41E3BdiKGjn6Vl2g=
Received: from BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::20)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 19:33:07 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::b7) by BLAP220CA0015.outlook.office365.com
 (2603:10b6:208:32c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:07 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:01 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 04/20] x86/mce/amd, EDAC/mce_amd: Move long names to decoder module
Date:   Sat, 18 Nov 2023 13:32:32 -0600
Message-ID: <20231118193248.1296798-5-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118193248.1296798-1-yazen.ghannam@amd.com>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: da7df241-834c-4ac1-7178-08dbe86d3131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYsY7oQEwYkIsduxFPhiGkY8VsBPrKEhimRMy7hXUOxOW0RoEOK+J4Wv6THmAkDEsqzV9Fqw7m1yz5j5AsrjzjCvpawaSxLLFZ3APZDJRJvG03ogZMc0nWQWrAwWnWPyIxE7rT+jO6GNTJXahMhsK12bhSKJMFD7Z7fYADmkLKRLTjFn5hiAQZmxLGk622LUTFY4BWEykC6tW8fiBBKvZnKkd39NNtob4/Ya3JvmXxleUbH8XC2otfNXzSrKPH4MpOVaooWSL+dPYGcdRf1ATHoVr10KLOyoOXn+DGRCZrEj6sZ5bMPj5fhlfORnwh/hGag1NTxOBz+57fwZAc8L/PtZwjkOURg5LTM/QP9rPKduyBQVAqDHKaZfQOkK63NbBUvsRZE/G/u25zgQYljlg7Du0LVSPyTUlI8/V0xtMZBzaxCMtnJcuG+UqT6sVlePZWpq6yEGE7UJa5WxKAICjMt3Wt096VNKxakQbIYdG6TS2YCeud4KClMNks0CFJQDJlpXsV3R5K9VR4SRRCAddhFW3NdfuzoIkpnmfL9zqJV//+Y4bEDR7EnpqkXhHgkReS3spHaD0DpyWw6qpe8E7GOfA2wLPhGDp2PMIwAI3i80WrqZXd4tsewnYYBgZJ45YaeWsJ6YS5wF7i+lquJiR7npnMyVajqKqMxeNPMAJKuxbumFvC0gbQc7Pg6ZFFjerxvZVSPfQpjv/34nDewo3e1qYjLw+z1qAVlPIxWYg4whR7jTyOqrCblZ7QAw2B69gm97uibasHJ4Gv2JXyJ/Rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(44832011)(2906002)(356005)(81166007)(82740400003)(86362001)(36756003)(336012)(426003)(83380400001)(1076003)(26005)(16526019)(2616005)(7696005)(36860700001)(478600001)(6666004)(47076005)(41300700001)(8676002)(8936002)(4326008)(70586007)(70206006)(316002)(6916009)(54906003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:07.6991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da7df241-834c-4ac1-7178-08dbe86d3131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "long names" for SMCA banks are only used by the MCE decoder module.

Move them out of the arch code and into the decoder module.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |  1 -
 arch/x86/kernel/cpu/mce/amd.c | 74 ++++++++++++++---------------------
 drivers/edac/mce_amd.c        | 41 +++++++++++++++++++
 3 files changed, 71 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6de6e1d95952..4ad49afca2db 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -333,7 +333,6 @@ enum smca_bank_types {
 	N_SMCA_BANK_TYPES
 };
 
-extern const char *smca_get_long_name(enum smca_bank_types t);
 extern bool amd_mce_is_memory_error(struct mce *m);
 
 extern int mce_threshold_create_device(unsigned int cpu);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f3517b8a8e91..6cf8ed9c79be 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -87,42 +87,37 @@ struct smca_bank {
 static DEFINE_PER_CPU_READ_MOSTLY(struct smca_bank[MAX_NR_BANKS], smca_banks);
 static DEFINE_PER_CPU_READ_MOSTLY(u8[N_SMCA_BANK_TYPES], smca_bank_counts);
 
-struct smca_bank_name {
-	const char *name;	/* Short name for sysfs */
-	const char *long_name;	/* Long name for pretty-printing */
-};
-
-static struct smca_bank_name smca_names[] = {
-	[SMCA_LS ... SMCA_LS_V2]	= { "load_store",	"Load Store Unit" },
-	[SMCA_IF]			= { "insn_fetch",	"Instruction Fetch Unit" },
-	[SMCA_L2_CACHE]			= { "l2_cache",		"L2 Cache" },
-	[SMCA_DE]			= { "decode_unit",	"Decode Unit" },
-	[SMCA_RESERVED]			= { "reserved",		"Reserved" },
-	[SMCA_EX]			= { "execution_unit",	"Execution Unit" },
-	[SMCA_FP]			= { "floating_point",	"Floating Point Unit" },
-	[SMCA_L3_CACHE]			= { "l3_cache",		"L3 Cache" },
-	[SMCA_CS ... SMCA_CS_V2]	= { "coherent_slave",	"Coherent Slave" },
-	[SMCA_PIE]			= { "pie",		"Power, Interrupts, etc." },
+static char *smca_names[] = {
+	[SMCA_LS ... SMCA_LS_V2]	= "load_store",
+	[SMCA_IF]			= "insn_fetch",
+	[SMCA_L2_CACHE]			= "l2_cache",
+	[SMCA_DE]			= "decode_unit",
+	[SMCA_RESERVED]			= "reserved",
+	[SMCA_EX]			= "execution_unit",
+	[SMCA_FP]			= "floating_point",
+	[SMCA_L3_CACHE]			= "l3_cache",
+	[SMCA_CS ... SMCA_CS_V2]	= "coherent_slave",
+	[SMCA_PIE]			= "pie",
 
 	/* UMC v2 is separate because both of them can exist in a single system. */
-	[SMCA_UMC]			= { "umc",		"Unified Memory Controller" },
-	[SMCA_UMC_V2]			= { "umc_v2",		"Unified Memory Controller v2" },
-	[SMCA_PB]			= { "param_block",	"Parameter Block" },
-	[SMCA_PSP ... SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
-	[SMCA_SMU ... SMCA_SMU_V2]	= { "smu",		"System Management Unit" },
-	[SMCA_MP5]			= { "mp5",		"Microprocessor 5 Unit" },
-	[SMCA_MPDMA]			= { "mpdma",		"MPDMA Unit" },
-	[SMCA_NBIO]			= { "nbio",		"Northbridge IO Unit" },
-	[SMCA_PCIE ... SMCA_PCIE_V2]	= { "pcie",		"PCI Express Unit" },
-	[SMCA_XGMI_PCS]			= { "xgmi_pcs",		"Ext Global Memory Interconnect PCS Unit" },
-	[SMCA_NBIF]			= { "nbif",		"NBIF Unit" },
-	[SMCA_SHUB]			= { "shub",		"System Hub Unit" },
-	[SMCA_SATA]			= { "sata",		"SATA Unit" },
-	[SMCA_USB]			= { "usb",		"USB Unit" },
-	[SMCA_GMI_PCS]			= { "gmi_pcs",		"Global Memory Interconnect PCS Unit" },
-	[SMCA_XGMI_PHY]			= { "xgmi_phy",		"Ext Global Memory Interconnect PHY Unit" },
-	[SMCA_WAFL_PHY]			= { "wafl_phy",		"WAFL PHY Unit" },
-	[SMCA_GMI_PHY]			= { "gmi_phy",		"Global Memory Interconnect PHY Unit" },
+	[SMCA_UMC]			= "umc",
+	[SMCA_UMC_V2]			= "umc_v2",
+	[SMCA_PB]			= "param_block",
+	[SMCA_PSP ... SMCA_PSP_V2]	= "psp",
+	[SMCA_SMU ... SMCA_SMU_V2]	= "smu",
+	[SMCA_MP5]			= "mp5",
+	[SMCA_MPDMA]			= "mpdma",
+	[SMCA_NBIO]			= "nbio",
+	[SMCA_PCIE ... SMCA_PCIE_V2]	= "pcie",
+	[SMCA_XGMI_PCS]			= "xgmi_pcs",
+	[SMCA_NBIF]			= "nbif",
+	[SMCA_SHUB]			= "shub",
+	[SMCA_SATA]			= "sata",
+	[SMCA_USB]			= "usb",
+	[SMCA_GMI_PCS]			= "gmi_pcs",
+	[SMCA_XGMI_PHY]			= "xgmi_phy",
+	[SMCA_WAFL_PHY]			= "wafl_phy",
+	[SMCA_GMI_PHY]			= "gmi_phy",
 };
 
 static const char *smca_get_name(enum smca_bank_types t)
@@ -130,17 +125,8 @@ static const char *smca_get_name(enum smca_bank_types t)
 	if (t >= N_SMCA_BANK_TYPES)
 		return NULL;
 
-	return smca_names[t].name;
-}
-
-const char *smca_get_long_name(enum smca_bank_types t)
-{
-	if (t >= N_SMCA_BANK_TYPES)
-		return NULL;
-
-	return smca_names[t].long_name;
+	return smca_names[t];
 }
-EXPORT_SYMBOL_GPL(smca_get_long_name);
 
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank)
 {
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 9215c06783df..b8765292d26e 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1163,6 +1163,47 @@ static void decode_mc6_mce(struct mce *m)
 	pr_emerg(HW_ERR "Corrupted MC6 MCE info?\n");
 }
 
+static  char *smca_names[] = {
+	[SMCA_LS ... SMCA_LS_V2]	= "Load Store Unit",
+	[SMCA_IF]			= "Instruction Fetch Unit",
+	[SMCA_L2_CACHE]			= "L2 Cache",
+	[SMCA_DE]			= "Decode Unit",
+	[SMCA_RESERVED]			= "Reserved",
+	[SMCA_EX]			= "Execution Unit",
+	[SMCA_FP]			= "Floating Point Unit",
+	[SMCA_L3_CACHE]			= "L3 Cache",
+	[SMCA_CS ... SMCA_CS_V2]	= "Coherent Slave",
+	[SMCA_PIE]			= "Power, Interrupts, etc.",
+
+	/* UMC v2 is separate because both of them can exist in a single system. */
+	[SMCA_UMC]			= "Unified Memory Controller",
+	[SMCA_UMC_V2]			= "Unified Memory Controller v2",
+	[SMCA_PB]			= "Parameter Block",
+	[SMCA_PSP ... SMCA_PSP_V2]	= "Platform Security Processor",
+	[SMCA_SMU ... SMCA_SMU_V2]	= "System Management Unit",
+	[SMCA_MP5]			= "Microprocessor 5 Unit",
+	[SMCA_MPDMA]			= "MPDMA Unit",
+	[SMCA_NBIO]			= "Northbridge IO Unit",
+	[SMCA_PCIE ... SMCA_PCIE_V2]	= "PCI Express Unit",
+	[SMCA_XGMI_PCS]			= "Ext Global Memory Interconnect PCS Unit",
+	[SMCA_NBIF]			= "NBIF Unit",
+	[SMCA_SHUB]			= "System Hub Unit",
+	[SMCA_SATA]			= "SATA Unit",
+	[SMCA_USB]			= "USB Unit",
+	[SMCA_GMI_PCS]			= "Global Memory Interconnect PCS Unit",
+	[SMCA_XGMI_PHY]			= "Ext Global Memory Interconnect PHY Unit",
+	[SMCA_WAFL_PHY]			= "WAFL PHY Unit",
+	[SMCA_GMI_PHY]			= "Global Memory Interconnect PHY Unit",
+};
+
+static const char *smca_get_long_name(enum smca_bank_types t)
+{
+	if (t >= N_SMCA_BANK_TYPES)
+		return NULL;
+
+	return smca_names[t];
+}
+
 /* Decode errors according to Scalable MCA specification */
 static void decode_smca_error(struct mce *m)
 {
-- 
2.34.1

