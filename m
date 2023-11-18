Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC6E7F02A6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjKRTeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjKRTdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:19 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C5BD58;
        Sat, 18 Nov 2023 11:33:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyMJxOARf4Dldi6Zq6LULBTZ9szbc3ZTGk6BfqBHW8r+V6ikXG6IsI1DWtk4cbtEhxhcAfR/IYE/KbqEXMqVQ6JgOwj6cRZB+iBZaMNAr1HFB23GHeEA8R+n8D7M3xwcCc95Aj634l3gJle4FNl0oHXda5zoFPtFii70jwRM2Go0/LaAevZcQP9ArU+8rpS/FPxIU3p/XolboV8ymT/divDCTN224hSLh8K4uNOL16RYxwGCaa5CCYVMR1pb2mlfvGpBV9JARBbwKy7YhYfZns+Tvtby5zuVscGncmtGtTC1dG0h0aDG+p1wfgqhIVBCl+wUHNAf4TNPGis4RWTbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5HjIzhjQpQSFY2FiZ6mHxQTdgp2iYyzbTlup2dDUnQ=;
 b=iN3il7YrFeLXnQ/lSrFMjJ6ADlV+9+P7yt1wuaCrX6gAr4n2IzzobPjdffYrOLZw3iSehDOPGqfCO3gXzg5s2FICWcg1tGI95YV6w2WfMwJ5cEFAliXZWcv5mP+4CDcTbffIkBP/dQVgh3a4Rh0ATlA5mfNTNU+jqKvjqLaSzTsto3xF1Kfu3FADllWCRQvKzRzKcHPOjOSDzSeNwUSJ441SC3AbC4JTU72Wb3vN073Utzazrk8clB3zDiTefletgkQz3dd/jzPk1CU8ZT3k7sIWCfv/mlYRU/dGe9gKWRR0cg1tCl8mEPK1atZwfAU4DoIxhRglOC+azfZMlz3Yng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5HjIzhjQpQSFY2FiZ6mHxQTdgp2iYyzbTlup2dDUnQ=;
 b=ZJGHFzUYxjPX3ZcxE/bNRqITz8k3psgquhh/FkdZZsgR8B4/gp91OXAI/kS8uiLB3SMZ7BdjXp8GfyKkA5/Dn7RZYKlbFCHD6NQZHXSZ/KImZKTq5+ZodjfA6xBJUfxKgibR9T5Mv0axtEY/0xZcjXsyU7QOmH/H1qN87wwhEhs=
Received: from MN2PR10CA0025.namprd10.prod.outlook.com (2603:10b6:208:120::38)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 19:33:10 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::31) by MN2PR10CA0025.outlook.office365.com
 (2603:10b6:208:120::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:09 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:06 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 11/20] x86/mce/amd: Simplify DFR handler setup
Date:   Sat, 18 Nov 2023 13:32:39 -0600
Message-ID: <20231118193248.1296798-12-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 559052a5-7495-4265-b39c-08dbe86d3274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5I2Pu0TekLnhb6A7SWo3IYVGFDVdllx7uUlL2S/S/yG3ETaeSTWTIVx7mo2Z+g4f+Tyqv3+k08Hu/vaFvpmMN8xWtXkQvWBK3xphvrF8Gi1bIiTggR98gEqfxJnZkCdD0Unq4NW8QiMmfJjkVOKklofSwjnFcDsXURB+n8kGkdEqfyuu4CNDcRRWfbroJtMEDpB9cneWUu1oG9o1xBB1UTmdXyzdT23/a3WuBjwjHWI/N558RKfUOtFaqMJApba9pOfcdd46Hh6bRBvnJK5USf7e8xOem43dInbJ3AuwLpuolZvX+9D2Wy6jKSJTNgs77USz/qV163ZmSIrT4CRuOL6Sx5Qb4KJUyUAPvg5bpex5JCuLxEdIzYTPlRLcZySnyc3x4I0ettA67gK9wxrVXJrtXp76qk41FLUDE5/LUGdi9IkEs7c/+irj9YbZiBLv7t22jWs6VAKf2VW/kiVh/oVe9qUOTipNuKmtB2SXo53fSPapUzyG4dntLTSPX+DJYRjbZhaD+9vqkrmtbEO7aHvDgZtXKiDNPCMTr9t/gO46aKszbUz8Bc2ihFVkY9dNeEy7vl/Zc5hfRai/mw/B+xu0sUsVieBfMRZpqrleTrbmwU2c6nSH4jRea5ULM+TN2v/aVuEvb3zykigRzYHatNP6JrVsDVTwx57iS+GN6iXOntaEei3icBqUj1qoVq2LdF7Kr0W2KRt6H72V1Vf6rpFQLZBHBvxvJnh9Nl+e7SnM0XpCOzMivnGoYV/9fd/EPM6YN6tBzRptTQ60zu11Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(47076005)(1076003)(81166007)(2616005)(356005)(7696005)(40460700003)(36860700001)(336012)(41300700001)(426003)(83380400001)(16526019)(36756003)(26005)(82740400003)(44832011)(4326008)(8676002)(8936002)(40480700001)(478600001)(5660300002)(86362001)(70206006)(6666004)(70586007)(2906002)(6916009)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:09.8176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 559052a5-7495-4265-b39c-08dbe86d3274
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD systems with the SUCCOR feature can send an APIC LVT interrupt for
deferred errors. The LVT offset is 0x2 by convention, i.e. this is the
default as listed in hardware documentation.

However, the MCA registers may list a different LVT offset for this
interrupt. The kernel should honor the value from the hardware.

Simplify the enable flow by using the hardware-provided value. Any
conflicts will be caught by setup_APIC_eilvt(). Conflicts on production
systems can be handled as quirks, if needed.

Also, rename the function using a "verb-first" style.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 4fddc5c8ae0e..9197badd9929 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -48,7 +48,6 @@
 #define MSR_CU_DEF_ERR		0xC0000410
 #define MASK_DEF_LVTOFF		0x000000F0
 #define MASK_DEF_INT_TYPE	0x00000006
-#define DEF_LVT_OFF		0x2
 #define DEF_INT_TYPE_APIC	0x2
 #define INTR_TYPE_APIC			0x1
 
@@ -581,19 +580,9 @@ static int setup_APIC_mce_threshold(int reserved, int new)
 	return reserved;
 }
 
-static int setup_APIC_deferred_error(int reserved, int new)
+static void enable_deferred_error_interrupt(void)
 {
-	if (reserved < 0 && !setup_APIC_eilvt(new, DEFERRED_ERROR_VECTOR,
-					      APIC_EILVT_MSG_FIX, 0))
-		return new;
-
-	return reserved;
-}
-
-static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
-{
-	u32 low = 0, high = 0;
-	int def_offset = -1, def_new;
+	u32 low = 0, high = 0, def_new;
 
 	if (!mce_flags.succor)
 		return;
@@ -601,17 +590,15 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
 	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
 		return;
 
+	/*
+	 * Trust the value from hardware.
+	 * If there's a conflict, then setup_APIC_eilvt() will throw an error.
+	 */
 	def_new = (low & MASK_DEF_LVTOFF) >> 4;
-	if (!(low & MASK_DEF_LVTOFF)) {
-		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred error IRQs correctly.\n");
-		def_new = DEF_LVT_OFF;
-		low = (low & ~MASK_DEF_LVTOFF) | (DEF_LVT_OFF << 4);
-	}
+	if (setup_APIC_eilvt(def_new, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		return;
 
-	def_offset = setup_APIC_deferred_error(def_offset, def_new);
-	if ((def_offset == def_new) &&
-	    (deferred_error_int_vector != amd_deferred_error_interrupt))
-		deferred_error_int_vector = amd_deferred_error_interrupt;
+	deferred_error_int_vector = amd_deferred_error_interrupt;
 
 	if (!mce_flags.smca)
 		low = (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;
@@ -777,7 +764,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
-	deferred_error_interrupt_enable(c);
+	enable_deferred_error_interrupt();
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
-- 
2.34.1

