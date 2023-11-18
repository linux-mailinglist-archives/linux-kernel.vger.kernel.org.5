Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4DB7F02A9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjKRTeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjKRTdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:19 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60461AD;
        Sat, 18 Nov 2023 11:33:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF/yd7QZiBdwtDJouGjUmv0GIxbw1RrINtdiwKKYKV2OaFZjRU7bNmXubOY68MPIbctEl7QXRTcI1Q9smtyj/xdrbuY+Fp+T8fwNDG21Yq2NswvPesxtKci1rpr/vbqHAXghy9BgyoBm+rYKNmBjsHK6ITCXEAHNZ1nQi0yM87nwBsVBjxGqKpVWCzaZ6dnd7RZf5gn73u2pZhjApXRPFU0dFeLfpr7uBi1nUFV8z2nBYHs0i5ioIOdJ6nb1osreMDi5a0N20mRJjIsbMp/f5LGpIVxS1ppDWi+KRTnBPkdFJtOCSw4atETzDzBgF5AHgNJ3Fkf6yNAnifOZUm7PVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6G0oyUjQOnR9yTjZokWWwMk1/gMR9SRf8LNA54A4Hs=;
 b=B0VY0cDBxM+dJnbk2t4g+bxvZm9XPvZg2/V14JdZimRmmiBDa2yQBxsH1fmV3gDh+TJDx4MCTDtvvc4jjPSX1rg+xf9Fg4ZBiMpko5q0Yv2IhkUtvG4OsIDeYYxQjIe9kBQhUWBBAHJnqk+awdehkckdejecPK1bkfULnj7iMMAjjbmUh53CpU6/pRIZy+bOtVm0D9z8TnT57S96vHskP3kH1Hpja91VrgR1dckW1lGO2zpH1sZwVJxMOrfUj7059UKpdzqMEp+6R9igjTJxYrgVeOsmmv5SWN+nTwSEAL77ApHaGvLhaxnKLVll7IHleULRs/RtQb34Ax0iT05Sow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6G0oyUjQOnR9yTjZokWWwMk1/gMR9SRf8LNA54A4Hs=;
 b=pSL56HmFVAbynIwbsaAnFQwusv5G4hfpMGDffwp1UCbqPoW5TnJXO2imAMYmiY4xIRLqp6EgBKAp+xhr0ksfWRUoQqUDVZJ58V8Zxohe1uA7NU/4yCCBddWPOMQfq7Un6vIItGoBj4GiS7voILXIWv9o46SrTRqq3QFZqqjDVX4=
Received: from BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::23)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Sat, 18 Nov
 2023 19:33:12 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::5b) by BLAP220CA0018.outlook.office365.com
 (2603:10b6:208:32c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:12 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:11 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 20/20] EDAC/mce_amd: Add support for FRU Text in MCA
Date:   Sat, 18 Nov 2023 13:32:48 -0600
Message-ID: <20231118193248.1296798-21-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: e159d9d2-14ea-4c17-4f41-08dbe86d3419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fFQPBD/cpnZIiwtbYIsa1KOZ4JahrumpknEqmlYjESdjFe0ak7kC+VGmlJCIuyIQz58AIVAVSiQSg+htlxHRvEnxtPs9F+mDmWpyMPVKt04n2mWqYMBf4PV0jEhjarTxi/sLle8UUbnKO/MdcC7YAHH9x4kbFwD2kMStrgAskqEux8ycHbv/V2IXFbXzXzbNnap54O6AaR2pEcT1EnhjOOJjvgZcQrmTeyn8iLJjpuYxFJobHvzw1fk6L3o87LcQxxLt2E7sJ2UyiCJFdhoWt7EaHf1Ii5fjdC9ONsceLyEmdO3Y09RnmwWcmMPRC9ATO7iSWYDR7N8vhlHp6sYbiZxdlub8QoGVGs3ZiP3dAxuyIxN9DSEwOxAWvw7y5BIGPixhGuAyzUJvacty+1gXI6kimU3/OH9CCWZs/Zyq7jh5oc73SxPy0/IT3cQNP/mOTjJ4Yi+ie3uZmEvng5QRgU62WuYF11tATqdgQ+lJoy03ypnWe1+dGrQIML7dsLxS5Pv9CiJgIB+YBNsyZeGlgswC9HfVqbTAc/LtJsZCLxTks/wtpx4fHXCzEO57sfOTlaxyL01CbstLY+Z5qf2EhMqIXh20O5tnBS9IfMNTPT3K6dbEHV3n1nhDHDrszEVt8/GbfiKcCej2Y+VuHXYoniF7WxDqoyL3AuryRSgizUs3N9LBFmABhPuKzeT2+qPt8JhrgSv9z6HZKhvxN9F58r0D6kbHk+brFU9n//NKgy7/UdyhnPivELjvtwq8UrQoDbMZQqTEMjxG+xdvs93VIHmyEM6N0REtVdsNNvY9rU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(36840700001)(478600001)(36756003)(26005)(336012)(426003)(7696005)(41300700001)(2616005)(6666004)(81166007)(356005)(16526019)(36860700001)(86362001)(47076005)(82740400003)(83380400001)(1076003)(2906002)(4326008)(8676002)(8936002)(70206006)(70586007)(54906003)(44832011)(316002)(6916009)(40480700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:12.5741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e159d9d2-14ea-4c17-4f41-08dbe86d3419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new "FRU Text in MCA" feature is defined where the Field Replaceable
Unit (FRU) Text for a device is represented by a string in the new
MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).

The FRU Text is populated dynamically for each individual error state
(MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
covers multiple devices, for example, a Unified Memory Controller (UMC)
bank that manages two DIMMs.

Print the FRU Text string, if available, when decoding an MCA error.

Also, add field for MCA_CONFIG MSR in struct mce_hw_err as vendor specific
error information and save the value of the MSR. The very value can then be
exported through tracepoint for userspace tools like rasdaemon to print FRU
Text, if available.

 Note: Checkpatch checks/warnings are ignored to maintain coding style.

[Yazen: Add Avadhut as co-developer for wrapper changes. ]

Co-developed-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/apei.c |  2 ++
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 drivers/edac/mce_amd.c         | 21 ++++++++++++++-------
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 1bd3f1e41dbb..7e2a3dba0cf3 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -59,6 +59,7 @@
  *  - TCC bit is present in MCx_STATUS.
  */
 #define MCI_CONFIG_MCAX		0x1
+#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
 #define MCI_IPID_MCATYPE_OLD	0xFFFF0000
 #define MCI_IPID_HWID_OLD	0xFFF
 #define MCI_IPID_MCATYPE	GENMASK_ULL(63, 48)
@@ -199,6 +200,7 @@ struct mce_hw_err {
 		struct {
 			u64 synd1;
 			u64 synd2;
+			u64 config;
 		} amd;
 	} vi;
 };
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index d01c9b272e2f..c8312e160117 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -155,6 +155,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		fallthrough;
 	/* MCA_CONFIG */
 	case 4:
+		err.vi.amd.config = *(i_mce + 3);
+		fallthrough;
 	/* MCA_MISC0 */
 	case 3:
 		m->misc = *(i_mce + 2);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e153a21bdb1b..b9da1cd0fb88 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -204,6 +204,8 @@ static void __print_mce(struct mce_hw_err *err)
 			pr_cont("SYND2 %llx ", err->vi.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
+		if (err->vi.amd.config)
+			pr_cont("CONFIG %llx ", err->vi.amd.config);
 	}
 
 	pr_cont("\n");
@@ -661,6 +663,7 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
+		err->vi.amd.config = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(i));
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 4d2929770620..2b738bd7889b 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1278,6 +1278,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	struct mce_hw_err *err = (struct mce_hw_err *)data;
 	struct mce *m = &err->m;
 	unsigned int fam = x86_family(m->cpuid);
+	u64 mca_config = err->vi.amd.config;
 	int ecc;
 
 	if (m->kflags & MCE_HANDLED_CEC)
@@ -1297,11 +1298,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		u32 low, high;
-		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
-
-		if (!rdmsr_safe(addr, &low, &high) &&
-		    (low & MCI_CONFIG_MCAX))
+		if (mca_config & MCI_CONFIG_MCAX)
 			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
 
 		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
@@ -1336,8 +1333,18 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
-			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
-				 err->vi.amd.synd1, err->vi.amd.synd2);
+			if (mca_config & MCI_CONFIG_FRUTEXT) {
+				char frutext[17];
+
+				memset(frutext, 0, sizeof(frutext));
+				memcpy(&frutext[0], &err->vi.amd.synd1, 8);
+				memcpy(&frutext[8], &err->vi.amd.synd2, 8);
+
+				pr_emerg(HW_ERR "FRU Text: %s", frutext);
+			} else {
+				pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+					 err->vi.amd.synd1, err->vi.amd.synd2);
+			}
 		}
 
 		pr_cont("\n");
-- 
2.34.1

