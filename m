Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547827ACF13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 06:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjIYEXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 00:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjIYEXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 00:23:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32738E1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 21:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ML4hVB7BuDJbBE4M1aFCHdzMaJ8O3XqaWG0nbt2ymhqpgOPt0e+Vw/TmscxluLZVx5UcQ5NmZgzupqMlmllx5DOYqCI+MxBuHRWhiatX4LcnfkT/AQS0Crz567J8EjAAQqzMA7K8NEvVUMKeEl+PQG6uB0mPy6NOnR+Jv0AxfOZZg6B51VVD6cwcgKPSdQmf3Jv3kjrp84F+5a9ehv/o11XpHj0lENbdsAvcxF6wodIBoXH1Vu2ExFpcwdSx7lPx36ZSVSy8JHdeeVbQ4NjlM2jc6gcibNrSWlAw1L/zvvRTiE7KRGT+fHRpS4X1lJTYCnn2TGssoHOKNeHODHU/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61RaAjvWM7kTYS/4iKw8VS0XbI//hq3zMCWJuuY9G5Y=;
 b=e4+Avvw5fv+ZORoZsc0DOYBtUP8uLkBH0P0mhsN/Yk8GOcVSjNTcH7fXNbJaKxl2Z6h6sBcfZQsbF8PZgyj2o/8wssLA/VZd/zjzAel6kP6YWS2jduSKmym8e0afbMeCKD9DHn0Mo+/K0tzhAwlWAl4z1p+O+BVa1jBqAVHsXkSKaN9WRZAbvfrMbEa2pHUbPuSguXYtsg03L03Xunp3UPjbBO6R884DxXwoOTrg9ST5oj33Jj+P7idzxsslQ6RLAZfOu60J+fDwg4Lykmi5Sh6eGm/WfrTxvz2F3VCggLX/QAu5d02WgPjWuyfPH1fx7Ia+nyKPyPF12oEhhbNc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61RaAjvWM7kTYS/4iKw8VS0XbI//hq3zMCWJuuY9G5Y=;
 b=oUJMC5PN0jE5hFIW94Qp37YwiStaMqOiqIw+YierN/jQ2kxo8F9NlUgmjEPOuIukHGEJ1a+9WbP5aJR7e2kXPemloHBUOMQW/w8J2y5bWlnjhk1qM7sL5o40g+f7cQke3tGhU1R+Fug9DfCHt4hbWsahraMFMJ8czaqGFx09sh0=
Received: from DS7PR03CA0294.namprd03.prod.outlook.com (2603:10b6:5:3ad::29)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 25 Sep
 2023 04:23:39 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::e7) by DS7PR03CA0294.outlook.office365.com
 (2603:10b6:5:3ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 04:23:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 04:23:38 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 24 Sep
 2023 23:23:30 -0500
From:   Alexey Kardashevskiy <aik@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH kernel] x86/compressed/64: reduce #VC nesting for intercepted CPUID for SEV-SNP guest
Date:   Mon, 25 Sep 2023 14:23:02 +1000
Message-ID: <20230925042302.593317-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dec1c1-b58e-4369-5786-08dbbd7f3168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWzvYZJNCEKs1pQbYybvsF2BriSFUoREWSgyj42aBdmFARCnBeO20oGoZsXrjoRwreO2aO+sjApVWVvfdLRwE9VbyDd+liLaeg8f4iOYZUlvy5+hJpMb0xMBtIWdsL8gSxbzwv+cRc52uabnLUd4ybTGxC65i2p7CiyUFQSb3Bx5IvzFmmgeJOpEGPKI6H47f2bDHlEQNe4bWxWAAYe4lA4TGsvLMrqkNs4U5C73lw7RycAGGPqGpNbEAxl0zLpHQuz4TBip9x3ROeXYfb9w88QMv46o3t/qKSN0+12KU67hbobFJ2WsxdDgBwJcOQSdZNuFeIV7T1gSmgx5oPpFdCR9l4BjU8nvQIE2GOCP7blYiWcodJbxVlWmQOIB0bpWKPZCbu0QRM93jmbFVk/6tusQrx4uX2XvPNDF8sUeKgURwRQVfXTtFjCiPGWmBFTnNd1g8oXfVKnLgeMM/+KI7iQdUIOOqBDycd06a5AglypLdfJiPK0Nhmqe9TslujB1wSvLecfUJed2pznx+xyNKnBa62XQwwqcAbD2FaXOhanXZOKMDr+Os/2xrGqCHBNYmJZrFatsX7VPGcyrRmQ1uYpuN4xHRvr3FbZpHjpbAqwxl95wdDsOxpK5ynch1XeLrJ6ARil4OAvsGkPaht441cscnOEse9qDhcgvnTQ/7fSSmocOliTrz5D+UVtIE+Emizea3S1OnQbxS+mKMxxJmF+IidYCdNZQ88lEK9X/CfPEWpOGA40XGvwTRHVaY176
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(70586007)(40460700003)(26005)(81166007)(16526019)(8676002)(8936002)(82740400003)(36860700001)(356005)(2616005)(1076003)(4326008)(83380400001)(36756003)(47076005)(2906002)(336012)(426003)(7696005)(6666004)(40480700001)(54906003)(966005)(5660300002)(478600001)(6916009)(316002)(41300700001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 04:23:38.9693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dec1c1-b58e-4369-5786-08dbbd7f3168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For certain intercepts an SNP guest uses the GHCB protocol to talk to
the hypervisor from the #VC handler. The protocol requires a shared page so
there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
handler triggers a #VC, there is another "backup" GHCB page which stores
the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
The vc_raw_handle_exception() handler manages main and backup GHCB pages
via __sev_get_ghcb/__sev_put_ghcb.

This works fine for #VC and occasional NMIs. This does not work so fine if
the #VC handler causes intercept + another #VC, if NMI arrives during
the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
The problem place is the #VC CPUID handler. Running perf in the SNP guest
crashes with:

Kernel panic - not syncing: Unable to handle #VC exception! GHCB and Backup GHCB are already in use

vc_raw_handle_exception #1: exit_code 72 (CPUID) eax d ecx 1
We lock the main GHCB and while it is locked we get to
snp_cpuid_postprocess() which executes "rdmsr" of MSR_IA32_XSS==0xda0 which
triggers:

vc_raw_handle_exception #2: exit_code 7c (MSR) ecx da0
Here we lock the backup ghcb.

And then PMC NMI comes which cannot complete as there is no GHCB page left
to use:

CPU: 5 PID: 566 Comm: touch Not tainted 6.5.0-rc2-aik-ad9c-g7413e71d3dcf-dirty #27
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
Call Trace:
 <NMI>
 dump_stack_lvl+0x44/0x60
 panic+0x222/0x310
 ____sev_get_ghcb+0x21e/0x220
 __sev_es_nmi_complete+0x28/0xf0
 exc_nmi+0x1ac/0x1c0
 end_repeat_nmi+0x16/0x67
...
 </NMI>
 <TASK>
 vc_raw_handle_exception+0x9e/0x2c0
 kernel_exc_vmm_communication+0x4d/0xa0
 asm_exc_vmm_communication+0x31/0x60
RIP: 0010:snp_cpuid+0x2ad/0x420

Drop one #VC by replacing "rdmsr" with GHCB's VMGEXIT to read the value from
the hypervisor.

Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
Cc: x86@kernel.org
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---

This is made on top of (which has the "efi/unaccepted: Make sure unaccepted table is mapped"
fix for booting SNP):
b996cbe1203c (tip/master) 15 hours ago Ingo Molnar Merge branch into tip/master: 'x86/tdx'

plus:
https://lore.kernel.org/lkml/a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com/
---
 arch/x86/kernel/sev-shared.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index e73c90c9cc5b..399219de5a9b 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -477,11 +477,19 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		if (leaf->subfn == 1) {
 			/* Get XSS value if XSAVES is enabled. */
 			if (leaf->eax & BIT(3)) {
-				unsigned long lo, hi;
-
-				asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
-						     : "c" (MSR_IA32_XSS));
-				xss = (hi << 32) | lo;
+				/*
+				 * Since we're here, it is SNP and rdmsr will trigger
+				 * another #VC and waste one of just two GHCB pages.
+				 * Skip the intercept and do direct hypercall.
+				 */
+				ghcb_set_rcx(ghcb, MSR_IA32_XSS);
+				if (sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, 0, 0) != ES_OK)
+					return -EINVAL;
+
+				xss = (ghcb->save.rdx << 32) | ghcb->save.rax;
+
+				/* Invalidate qwords for likely another following GHCB call */
+				vc_ghcb_invalidate(ghcb);
 			}
 
 			/*
-- 
2.41.0

