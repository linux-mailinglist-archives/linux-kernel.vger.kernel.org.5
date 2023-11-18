Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05747F02A5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjKRTeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjKRTdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:19 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5A7D5C;
        Sat, 18 Nov 2023 11:33:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/qqr4H5mRmISCjEqgnPGHNG/aVV2X1mttrKSxxjcA3o2bW0k0wp8i6NKePh0elQ2NBDFgtZ27JQSSGY6LpNSAy/3snSOb3ZBeXSwX5MqeXzoqluTEy8Vhzx7j9FeaPxDL0QGA0xNsFk/oIUAAofDAUsh7SsBx/ZfsejNG8L/WsDiQFOuDlEz5qgHE4jaTYGcKNFgeFaNVy819kdF5vgdZM8y5nM41Nxs+kLGFVLK9FiFvIVeH/zc7nyUdYLrU/RyGVVgLpXacGEXg6mNVh9w5Vi90ap0WIkUqI+2qAxVXLqTsFxx3cbueSISigOR1+A4t0Jfb6Q8c2HmzhTKo0iHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1vo3L9jP0ZUpR+bydJy3x1PS93pFx57vCQDgEOyZNA=;
 b=JNZditEsg9W/1vSerYGYg/rFpcnzrOYbUCRlV/kep7FHhfx1ScXY9xfJW/m9LpmtfArPYiL1kZixbMS76tIuturkDSif2UvTBaP6kCnj6puXaFdUmEK6H7jAGRJEJHEUsuz/82KHYn9gMm6LE+rUFdKOc5pK4+niCFtHaNjw/nE0xahPBeXJYropEOQ73tBuIYi2jP92gmu/HWlonAZSXKLCrEjld9ORT/DycGrZJv1WYYyVM5CHFBKds5kmYc94lDYtL1ozgy+s9zHMxmKC36dMvGG5ua/l3RaMrA8IF6tMHbYZhEQM7F75aW2vlobPPXi95TfLsHAqDB1WML8O/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1vo3L9jP0ZUpR+bydJy3x1PS93pFx57vCQDgEOyZNA=;
 b=ga6KEzmgf3oq6xQakvVAPS84nsjawyT3/oWw7pljF88LSRysCaJ4l6r42GOTK7XDdxXV8DrMSzMjh7F38z560E0eQVeiKfxGFEwTWcthPAM0TUQ+xTpbZOgkBSfB+y2uUYmHonAokGMnFsW9alIJF3QV8TvWvuw4Mqc8NMKa2As=
Received: from BLAP220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::27)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 19:33:11 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::f7) by BLAP220CA0022.outlook.office365.com
 (2603:10b6:208:32c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:11 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:09 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 16/20] x86/mce/amd: Support SMCA Corrected Error Interrupt
Date:   Sat, 18 Nov 2023 13:32:44 -0600
Message-ID: <20231118193248.1296798-17-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 4feae167-044e-44c1-e2af-08dbe86d3349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GACIr8e2BIRdgKg9E2GlxraG1et1WwTsdR8fKQ1kalJ+lmmZ1mS3ZTnYV6D2Ov21BFy1/74RMA8JDIo2Ell/P7G1ERbIiFNSFQiRjnNuIJ+x0/fWiIwOqvVVwyWsGWa0Jf40gPckBIjOYG1nZyrh28V0ibAF7UjVOqWOa0OM165hdWt52D26bS2Gu5Jlw+ofDxH9NYfd+3J/EtQAy113P5JzbU8DM4srOXFSBp1NjPqKV2mfvUOLH+8UrX+UHfcjUBCXO2YGBhJWac93VzUyyWJqtIo4TrwYUzGxOSLzRpgQ0B0vyMwm9iPhwsK3+sHz6j8QOBut2D67IamFyTXJYLEQOePPijrTDi3NrGnRZ3l4O4nNQJbwr4wSXYi7htbnt7IlNmj8JY4VDKQu9p9jVKXF0Zlik34uDH/vBrm7uKgtRT2GjTs149ZFdr2Zgg0QvyDxwb6rDrlgLKdyDGEYDWncY5Wj7heDvmMw6f/sc0uDf3K2YVoqkQ/94D2RKoYOC042mkPqeOEKZTV2fMnXZQwOqo8dBcI1yhvkKxgxCFERNyf5TAt+c3h6GcZVTutPE2mR1vHYpHFDwEL/WPNREFH+uD4bWi1oRWN4D3dFjYnsJ4I2Jx6XjwZC8l8vFzns8YR2ykTOaHoDT+tdBeTReksrDbddam6BMPSNq0ONyzxDIdWqekQ2oEB6nag2JofJRue717Wv+cTdGpPrQsLl691eUP7DPmSBdwgwlHeuFEzT5el2Cs9iTM2E0XQOuU2F
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39850400004)(396003)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(36840700001)(46966006)(41300700001)(44832011)(36756003)(5660300002)(86362001)(2906002)(47076005)(81166007)(356005)(82740400003)(7696005)(26005)(16526019)(2616005)(336012)(426003)(1076003)(83380400001)(478600001)(6666004)(36860700001)(70586007)(70206006)(4326008)(40480700001)(8676002)(8936002)(316002)(54906003)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:11.2147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feae167-044e-44c1-e2af-08dbe86d3349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD systems optionally support MCA Thresholding which provides the
ability for hardware to send an interrupt when a set error threshold is
reached. This feature counts errors of all severities, but it is
commonly used to report correctable errors with an interrupt rather than
polling.

Scalable MCA systems allow the Platform to take control of this feature.
In this case, the OS will not see the feature configuration and control
bits in the MCA_MISC* registers. The OS will not receive the MCA
Thresholding interrupt, and it will need to poll for correctable errors.

A "corrected error interrupt" will be available on Scalable MCA systems.
This will be used in the same configuration where the Platform controls
MCA Thresholding. However, the Platform will now be able to send the
MCA Thresholding interrupt to the OS.

Check for the feature bit in the MCA_CONFIG register and attempt to set
up the MCA Thresholding interrupt handler. If successful, set the feature
enable bit in the MCA_CONFIG register to indicate to the Platform that
the OS is ready for the interrupt.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 462ba9ff997b..9292096787ad 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -47,6 +47,7 @@
 /* MCA Interrupt Configuration register, one per CPU */
 #define MSR_CU_DEF_ERR		0xC0000410
 #define MSR_MCA_INTR_CFG		0xC0000410
+#define INTR_CFG_THR_LVT_OFFSET		GENMASK_ULL(15, 12)
 #define INTR_CFG_DFR_LVT_OFFSET		GENMASK_ULL(7, 4)
 #define INTR_CFG_LEGACY_DFR_INTR_TYPE	GENMASK_ULL(2, 1)
 #define INTR_TYPE_APIC			0x1
@@ -54,8 +55,10 @@
 /* Scalable MCA: */
 
 /* MCA_CONFIG register, one per MCA bank */
+#define CFG_CE_INT_EN			BIT_ULL(40)
 #define CFG_DFR_INT_TYPE		GENMASK_ULL(38, 37)
 #define CFG_MCAX_EN			BIT_ULL(32)
+#define CFG_CE_INT_PRESENT		BIT_ULL(10)
 #define CFG_LSB_IN_STATUS		BIT_ULL(8)
 #define CFG_DFR_INT_SUPP		BIT_ULL(5)
 
@@ -355,8 +358,19 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 
 }
 
+static bool smca_thr_handler_enabled(u64 mca_intr_cfg)
+{
+	u8 offset = FIELD_GET(INTR_CFG_THR_LVT_OFFSET, mca_intr_cfg);
+
+	if (setup_APIC_eilvt(offset, THRESHOLD_APIC_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		return false;
+
+	mce_threshold_vector = amd_mca_interrupt;
+	return true;
+}
+
 /* Set appropriate bits in MCA_CONFIG. */
-static void configure_smca(unsigned int bank)
+static void configure_smca(unsigned int bank, u64 mca_intr_cfg)
 {
 	u64 mca_config;
 
@@ -391,6 +405,9 @@ static void configure_smca(unsigned int bank)
 	if (FIELD_GET(CFG_LSB_IN_STATUS, mca_config))
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = true;
 
+	if (FIELD_GET(CFG_CE_INT_PRESENT, mca_config) && smca_thr_handler_enabled(mca_intr_cfg))
+		mca_config |= FIELD_PREP(CFG_CE_INT_EN, 0x1);
+
 	wrmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_config);
 }
 
@@ -783,7 +800,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		if (mce_flags.smca)
 			smca_configure_old(bank, cpu);
 
-		configure_smca(bank);
+		configure_smca(bank, mca_intr_cfg);
 		disable_err_thresholding(c, bank);
 
 		for (block = 0; block < NR_BLOCKS; ++block) {
-- 
2.34.1

