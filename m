Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D22777C150
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjHNUJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjHNUJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:09:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84095E5E;
        Mon, 14 Aug 2023 13:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf8Y8qUq5usPn7r9Yt15ecBWLkG/2oiVmXfTHkoK+ya/ssYwOVfJarkxTJbFvybbtN4fVpTMLEvL+8ZwksdMUK+ajsM5a1x0Q6BvwjJ7km4v2DRDtLYSES9lxZGfJKEpNL5wRBs8ZFwSyIoHDWBZ3yRq71gxVbKFk9Q9FtRFAdV5HHc5OujeKBONmpUYCLkh4XF2ps1E8dlzQwDzukKcif7CNVIh7/PHfPVi9wr4M2EhvgwMYk7xeU8cdOmXUYh4pE40towgSD8kg3Pl2MNnSwgDF5+SHUEix/wRYsLMH60CGU6NoqvRf1g/TFDCYKqDHZ/1mk9gZPkYyU2YD/PB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFH8aW0HFjIzzNUyRUMjenTcQSuXDYR7bsIkoDQP69w=;
 b=J8Xtv3eiuYf18fgrEsWCA5ClN9QtUeovER185tQe+ASR05RWPIGKlK7sKo8f05RaDw+QX2hbpammlDlBPpQxhU+J2LpMUj4HgGDfbgky6PTRFwxdhOOZMkMichwAdz6GmIW3BRU/pjI/678E6rlT+wILdwk9a/+IIy5Bs4WYR0rf3JXkgbGVeNnDUv6V8sXppGUFcsWiiOlzqpet5cVILw+7IClKqBa+lC0apjrwSnxlsNhPbqEg/BmGJAk8cqC4soOCUpBButQ3PT0WHx48ofYxjEux11o9SHfo1rIJzqs9pl1MIXp/A+EgXa/B21+Dx5i15a9cKbKZbQ3LonZ7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFH8aW0HFjIzzNUyRUMjenTcQSuXDYR7bsIkoDQP69w=;
 b=JhmIK7/LpmTiXO1RGkyXUDPVFYe72NOZhShdIki83rDe/OfTyAH2CIj0VmjUEzL2ADdP9g3GfR3HWjz9qYvB3bd9BEzNm5RAAQxR08SOBOnKdWddZKCsTDcPtUV/wvHc3jeb9+uKCBBsQQZpJSJdhSzTDhUYkTE7l468C52ypVE=
Received: from SA0PR11CA0006.namprd11.prod.outlook.com (2603:10b6:806:d3::11)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 20:09:10 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::fa) by SA0PR11CA0006.outlook.office365.com
 (2603:10b6:806:d3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 20:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 20:09:10 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 15:09:08 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2] x86/MCE: Always save CS register on AMD Zen IF Poison errors
Date:   Mon, 14 Aug 2023 15:08:53 -0500
Message-ID: <20230814200853.29258-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 084f14bd-610f-4b20-4ead-08db9d025274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ah7Xl+lmBGPAKh4B8tbHIZ24WdrnO7GDKGfuYXc4mFLI6fsmjtxSwD13dHM8dekj6KQulht7pm3hwm4A2vO3pn1IXKDZczIPJSMZtrZmkmE4Oaa1+XniQ5VD9I80iJ8OHIlf6Bg6t9iF3H5mceBdtK091A7BeOldaoMQ3YznkB5IDLBsN0OmUqpL2FwSySl47GjZZrErSdlTo2Gc32NbFKC1suN4OTKmEXOZFjBOnf3KoijwpFQQBUL/Ci7aSCErjWnC/odU1c+yw48igW55DTKknn9o92JoT3rS13hz82pPvFcOdFYEBYSKcAVxxLpNn7ywMA0IxLAwCEEate015PoOuouXC+C4I5CLlQo/ILdo/XJj99WjiJJT2zjzsjvwpfAOFPpZp9C8uH22oDYLLQ3qcXB8ydVay4gpb96ri6fsFCz9hc7WM8/wYPEjWaQ3CDAAzKV4jEh7DK798ltaPlnVNSahIHGq3v6R0DlcBKcfO+7Foa8HOmER6uvt/5Tj3M8td26yZoSLXU+2vlb+FSokNSKXEgVr0cReDRq2mjcgHMG8V+Zjf0UfR+MtnXcJauyWeW94ZwqsBVeTm+8OTu9qkyihjUlYZ2CeJhtOchKyIg/6v3g8aLGqqSbyDm81mZs0sBbD41YuXTwvu9jO3ST+L6zR7bVrRjW9I4To1xn7c4kH2MIerZHqUmNL+W3i532Aj2IUCZiwITIuFM/eWLpv93kUQ5WEBc8RkOcf/wsgq3Rr38+6QQNFpZZSpYk8MQ8520PrFA681IR2Gs+Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(82310400008)(186006)(1800799006)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(82740400003)(356005)(81166007)(36756003)(86362001)(40460700003)(6666004)(478600001)(44832011)(966005)(2906002)(7696005)(1076003)(2616005)(26005)(70206006)(426003)(336012)(83380400001)(16526019)(316002)(54906003)(41300700001)(70586007)(6916009)(5660300002)(8676002)(8936002)(4326008)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 20:09:10.1281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084f14bd-610f-4b20-4ead-08db9d025274
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Instruction Fetch (IF) units on current AMD Zen-based systems do not
guarantee a synchronous #MC is delivered for poison consumption errors.
Therefore, MCG_STATUS[EIPV|RIPV] will not be set. However, the
microarchitecture does guarantee that the exception is delivered within
the same context. In other words, the exact rIP is not known, but the
context is known to not have changed.

There is no architecturally-defined method to determine this behavior.

The Code Segment (CS) register is always valid on AMD Zen-based IF unit
poison errors regardless of the value of MCG_STATUS[EIPV|RIPV].

Add a quirk to save the CS register for poison consumption from the IF
unit banks.

Restrict this quirk to only the affected CPU families.

This is needed to properly determine the context of the error.
Otherwise, the severity grading function will assume the context is
IN_KERNEL due to the m->cs value being 0 (the initialized value). This
leads to unnecessary kernel panics on data poison errors due to the
kernel believing the poison consumption occurred in kernel context.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
Link:
https://lore.kernel.org/r/20210504174712.27675-2-Yazen.Ghannam@amd.com

v1->v2:
 * Simplified quirk function.
 * Updated code comments and commit message.
 * Included last affected CPU family.
 * Apply quirk based on mce_flags.

Note:
I think some of the MCE quirks can be handled during severity
grading. But that may need a bit of rework. This patch is kept
simple for easy backporting.

 arch/x86/kernel/cpu/mce/core.c     | 26 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  5 ++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b8ad5a5b4026..6f35f724cc14 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -842,6 +842,26 @@ static noinstr bool quirk_skylake_repmov(void)
 	return false;
 }
 
+/*
+ * Some Zen-based Instruction Fetch Units set EIPV=RIPV=0 on poison consumption
+ * errors. This means mce_gather_info() will not save the "ip" and "cs" registers.
+ *
+ * However, the context is still valid, so save the "cs" register for later use.
+ *
+ * The "ip" register is truly unknown, so don't save it or fixup EIPV/RIPV.
+ *
+ * The Instruction Fetch Unit is at MCA bank 1 for all affected systems.
+ */
+static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_regs *regs)
+{
+	if (bank != 1)
+		return;
+	if (!(m->status & MCI_STATUS_POISON))
+		return;
+
+	m->cs = regs->cs;
+}
+
 /*
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
@@ -861,6 +881,9 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
 		if (mce_flags.snb_ifu_quirk)
 			quirk_sandybridge_ifu(i, m, regs);
 
+		if (mce_flags.zen_ifu_quirk)
+			quirk_zen_ifu(i, m, regs);
+
 		m->bank = i;
 		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
 			mce_read_aux(m, i);
@@ -1849,6 +1872,9 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 == 0x15 && c->x86_model <= 0xf)
 			mce_flags.overflow_recov = 1;
 
+		if (c->x86 >= 0x17 && c->x86 <= 0x1A)
+			mce_flags.zen_ifu_quirk = 1;
+
 	}
 
 	if (c->x86_vendor == X86_VENDOR_INTEL) {
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index ed4a71c0f093..bcf1b3c66c9c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -157,6 +157,9 @@ struct mce_vendor_flags {
 	 */
 	smca			: 1,
 
+	/* Zen IFU quirk */
+	zen_ifu_quirk		: 1,
+
 	/* AMD-style error thresholding banks present. */
 	amd_threshold		: 1,
 
@@ -172,7 +175,7 @@ struct mce_vendor_flags {
 	/* Skylake, Cascade Lake, Cooper Lake REP;MOVS* quirk */
 	skx_repmov_quirk	: 1,
 
-	__reserved_0		: 56;
+	__reserved_0		: 55;
 };
 
 extern struct mce_vendor_flags mce_flags;
-- 
2.34.1

