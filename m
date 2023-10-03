Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7F27B6283
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjJCHb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjJCHbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:31:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA48A83
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEiaA6q5YBinzWdbffTJl/XY5IjiDvNmm6W77A/Opzprj1rOsUTHbj1yDvLhuZn0jQhTkjrkr8ZHrWuHPq6WQeAolY8/A4SXupFaUml2f9RSsRJpKbqQCte5UwcOI3MDcFvuDsN/QQAcuI0z1GJAMLER081e6DrDMV25fZRtdj9AjKs5uVSwMxvqGzS1FBoMWju6YIldkVUY6UY9yZSuyiqL8IuXnGEDIBHPdUJUC+ei4NdaZaNIRruVPZqNOukBaUq3Uc67/Fe2d3KfNgTcoR0j06jO/Gj3XepYsuarbvJFu5NJX4qWcQww64hwdY3xeRAU1wowxS8tHlH8MQoz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TisWu+VLPNfEYcip/BDkc1glSc5VhFgBpx4jUXyMFF8=;
 b=dFVgW2aeSEnEQ8PBtMW2k/gdHnvNM/FHJ3EL43K0RivGXNy42+0X4HQZ6JlYwBfj+u4oA2Aef7tW1k7+xq7nx8JYqIxIKyWdEAe7x23w7eKEarz4sFjhT/MlY51ebJUi/rkdMuinVa6L9GiHCwIt4DRexe7Tl1lTzGdVJS6Huwt2mVvhOGgZ9DOQdCj9+FMaMgSOsGhAcEWGIp7HUSLz24OYk/Uhrm8y9VEfFEfjStrKtiOZ/EaZFh4rfujeKwS3U86j8SR1dBgeLq57hnjGeWVAVFuoS6Ne5y1tzQh2bR3Ukh3GVNiXo3YUHb2chh7FpfAyFp65+gg9VLrOhVBHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TisWu+VLPNfEYcip/BDkc1glSc5VhFgBpx4jUXyMFF8=;
 b=dufQDHuYQiARPbDB39UAsvDiDelHdULdIZIt2GEEj68dSt/NTavxsnbB0l5JXa+dvAYkbgcbSNkm1S/r+8r6ZlpWm/Q2an2GfGc0JNsS0svrfEHp0NpfLIlUob5NL3jSKe4lQu9vYid50w61QNP/YRTWrMeMpAtJ0RhkRU/tq1U=
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 07:31:50 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::3d) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 07:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 07:31:50 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 02:31:45 -0500
From:   Alexey Kardashevskiy <aik@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Alexey Kardashevskiy" <aik@amd.com>
Subject: [PATCH kernel v3] x86/compressed/64: reduce #VC nesting for intercepted CPUID for SEV-SNP guest
Date:   Tue, 3 Oct 2023 18:31:23 +1100
Message-ID: <20231003073123.1763564-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: f4753995-f295-485e-90b3-08dbc3e2ced0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASfCNUv+8gD/qK2mnFSEMzoa/rLHtlVlr8bcspotj+J5CMnkorp66eM8ZXPAKWRbG2Bibl4ZXWmoX13vTd9ZauKtCeZEX+Q1G51YNR3dgmyAu/WHLhhooxuzTTJz/sfYQeH7nrSwwb2rRrFcK/mxVedLyabGd7OrUOSF/t5UgzGXF/9zOzqpU5bDBcg569SQ8oWt2Keb46mEpFXpJ8NUPFPO6GwkjSuIwSUeuwmNElPKcDJMgL7Vj0t/D8PBjXtuXMGiNdPvDHd5IBwWlF4WrqfRtIKVKKMjCRVdVpt92lbwJVAMmh9bxRVvhXEoTUE4zA20yJwKUud9TndFPIn/uUewIitErMyEYDTieeONa0vXgKXy8p6vrlwFPn/YNOhAzG9g5uITFLitNSlPGr2smr1DAJ6+kS+C5uxscCNb0TC/dMCBiCDnw6BY27yxPCGT5/+uKxq0x51MYti1jRqM7Znh7lbnpaJ+XbE0sIsR7ln9Ft0hk27JVhaLyUme+vF79TANL0+6nYUugWNp8nCZn8aVL5p+jTB2PbOmuTiY6dzskQMBqo59QyvtQwYNIPtQzkXN6ajcoRA1fGx3uXnZIY3bZRJM4EGLj5GVBgaNqH9sWs966ShzS9kpfd1D4MPZSSgO+9/8tqUox5HGIxGzSLLUsFcsfqTiMhSoEyvGEIgJPoeJNKEi7mnR6DBTxpoQ3djmXg5JX7L+V5o955qyLAwu3X6nWhJraZ/vjmTVCe5XPjNWZ4Mbcg/ddXNj+coC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(2616005)(2906002)(40460700003)(356005)(82740400003)(83380400001)(81166007)(336012)(26005)(47076005)(40480700001)(36756003)(36860700001)(1076003)(16526019)(426003)(966005)(316002)(8936002)(4326008)(8676002)(478600001)(5660300002)(6916009)(41300700001)(54906003)(70206006)(70586007)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 07:31:50.2076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4753995-f295-485e-90b3-08dbc3e2ced0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This works fine for #VC and occasional NMIs but not so fine when the #VC
handler causes intercept + another #VC. If NMI arrives during
the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
The problem place is the #VC CPUID handler which reads an MSR which
triggers another #VC and if "perf" was running, panic happens:

Kernel panic - not syncing: Unable to handle #VC exception! GHCB and Backup GHCB are already in use

Add a helper similar to native_read_msr_safe() for making a direct hypercall
in the SEV-ES environment. Use the new helper instead of the raw "rdmsr" to
avoid the extra #VC event.

Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---

Based on:
https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent
which top at the time was:
62d5e970d022 "x86/sev: Change npages to unsigned long in snp_accept_memory()"

---
Changes:
v3:
* made it a function, mimic native_read_msr_safe() which 1) returns value 2) returns an error
* removed debug backtraces the commit log as these were added for debugging and never
appear with actual kernels


v2:
* de-uglify by defining rdmsr_safe_GHCB()
---
 arch/x86/kernel/sev-shared.c | 27 +++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index dcf325b7b022..494d92a71986 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -241,6 +241,25 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	return verify_exception_info(ghcb, ctxt);
 }
 
+
+/* Paravirt SEV-ES rdmsr which avoids extra #VC event */
+static unsigned long long ghcb_prot_read_msr(unsigned int msr, struct ghcb *ghcb,
+					     struct es_em_ctxt *ctxt, int *err)
+{
+	unsigned long long ret = 0;
+
+	ghcb_set_rcx(ghcb, msr);
+
+	*err = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, 0, 0);
+	if (*err == ES_OK)
+		ret = (ghcb->save.rdx << 32) | ghcb->save.rax;
+
+	/* Invalidate qwords for likely another following GHCB call */
+	vc_ghcb_invalidate(ghcb);
+
+	return ret;
+}
+
 static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 {
 	u64 val;
@@ -477,11 +496,11 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		if (leaf->subfn == 1) {
 			/* Get XSS value if XSAVES is enabled. */
 			if (leaf->eax & BIT(3)) {
-				unsigned long lo, hi;
+				int err = 0;
 
-				asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
-						     : "c" (MSR_IA32_XSS));
-				xss = (hi << 32) | lo;
+				xss = ghcb_prot_read_msr(MSR_IA32_XSS, ghcb, ctxt, &err);
+				if (err != ES_OK)
+					return -EINVAL;
 			}
 
 			/*
-- 
2.41.0

