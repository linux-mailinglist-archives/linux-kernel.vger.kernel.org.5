Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5475DBE4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGVLYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGVLYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:24:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B383AB0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbOHSvbu1ccqeP2NM8GAFfh5KtU3b64yijCt841ywPyn6UJy216qR61QH6t4uSB4Ijk1YRcchckgujhx1DStSrQDpilYVOcKpUHGrdKOgJuNkAXbs1nR4ByWDezMMgmHKffW6wIzKy3G38MyBzZ8bOrqH5ZYVrRCIv8cPkrZsnNUxcq/HSuJhn+45rZEOKL8cMlwzKAx7PkPxVgs5Si4U+w4KhgxZUkwLnmNF5hPc79qWtAlB+mz68CrRZR9VozZuHI0BNzr71ZksX0cgvfR1BwZbI896rpkgzG0GMUYnqLLG5nixYA4ppW7deSJHDWOYexUpAiH8krnKEUlxQO6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhSrHljLl1rrS996VfK80M41HfQys5Vt16cM10AjRWE=;
 b=LWEZtz7KfZwepa0PSBu6g8PkerazQU+Z8Vf2N/KRezjVDJqCihmiNnT7ZqFKCduQnz6396Eln5Xe+GJ6WC7pDPv0gbQ13KbQ6Wyj/BPNBDrlWHQgI2V0zeydILCvP6guNQ8IwQUcq1niwhVldr0RJvcYxYb8FSNFVJ5UQY2KIlgz/hfQsEPJa3zUbCa5xHfvH/YP0FbI0n84/3Vc6dkK4d6t/YPDTqUtwxkLrw5l4x9rG1nBv2EXwKBM2Q6sh5CABZlnvLV11Vj/fcTj6CPwC5Er9S3KRYVNc9r2ioqsTJ5GsEcVc9Ht34V486a+qzaw5FFH1KsG1hE7l9z2NYw+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhSrHljLl1rrS996VfK80M41HfQys5Vt16cM10AjRWE=;
 b=gLkcvAI4wLaU845rjChWQqVRZr+vkHgUfANDaloIVHDrwJvpTpP7OWP4WMykm/NF/SBT4nmHWiavAG+WM6uCbPcxfKEdslECwWwNfHEKrAHDl+hYhJwcGYVpu7vEOOFbi6wwqwQ3AMzjsWs5i6eEDY9gssjnyhrDCAki9AO2Fos=
Received: from DM6PR06CA0028.namprd06.prod.outlook.com (2603:10b6:5:120::41)
 by CH2PR12MB4857.namprd12.prod.outlook.com (2603:10b6:610:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 11:20:48 +0000
Received: from DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::2b) by DM6PR06CA0028.outlook.office365.com
 (2603:10b6:5:120::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT075.mail.protection.outlook.com (10.13.173.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Sat, 22 Jul 2023 11:20:48 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:44 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 10/14] x86/sev: Change TSC MSR behavior for Secure TSC enabled guests
Date:   Sat, 22 Jul 2023 16:49:05 +0530
Message-ID: <20230722111909.15166-11-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722111909.15166-1-nikunj@amd.com>
References: <20230722111909.15166-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT075:EE_|CH2PR12MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c0188d-c07d-4b61-7f37-08db8aa5b315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aES4z/uDbCjQF3M51FGr2Pnk6su+HFlfPFwzdtwvNkAwhPkD77mrJ/+0nMD1FBR+BI67zCAu6Vg6sF3CyUhccv0us7uM9zaSKk4k4jgnXNasEjksW22egJd1aDKNV25sZL8u+Vnd1XOH0Skx0onpwg0ibvpcgj4gQHj4h/MGxJ5wLkE8nW7vx3Tl6VquhEUoTmEXCidfJ9LuHs7ZHMT2MnFjBLTSHBmtXFs7JLlca2VWMd6DipuS9V8t022JU1RFGuN8GMkyMPXhHRrZmFuHm//cSNcZJ8WidbGhj1EGKhXa6ck6gRGd0ROzvVY2aAcqAzjs6BuTfMWaBeiIeCqVwTue4AmnZ6Gd2EZ0+t8pnGmLhK5aEjC6y3pcPTpF22xCkAa5kzoSx/tX05laU4mTwEpXWAjP/jzihpcqDymYhFb51sej8BaCIOgFGa6HADGDs9tzu0kjhWPHa7vTVlRB12J9HyH/Xi0T6BmXYViuR0fn7dW7Fzfrh3cwJ0cbE7zL1jmv0jOIqWqTRtgLxnh3Ixm0SZotUgecy/Cw0M6JDnKQQ+KQswkq3WVkvk7//H4WMKO6Hiwvgt8KwScO9BnlrV4pSaO7NZbwG6SHYb86ktUG+8V7GLjq/KongplNNNeLhrkhFSHDrFROCy7ha6rOeP3ycEYMuJckuzu+EaWjE6AjcXdoW1+nTjuzkFr6cFrlcjE6YHR8BNw2sHS5KI2mz9QJv32gdfde02cS4vgY3GutUXVZ7ejzpuHfVq5Oo7TBJ/ETx7exWb9Z0QlufVhMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40460700003)(81166007)(40480700001)(356005)(36860700001)(36756003)(426003)(2616005)(47076005)(83380400001)(16526019)(8936002)(8676002)(5660300002)(110136005)(478600001)(54906003)(4326008)(316002)(70586007)(70206006)(41300700001)(26005)(186003)(336012)(1076003)(6666004)(7696005)(2906002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:48.1043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c0188d-c07d-4b61-7f37-08db8aa5b315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secure TSC enabled guests should not write MSR_IA32_TSC(10H) register
as the subsequent TSC value reads are undefined. MSR_IA32_TSC related
accesses should not exit to the hypervisor for such guests.

Accesses to MSR_IA32_TSC needs special handling in the #VC handler for
the guests with Secure TSC enabled. Writes to MSR_IA32_TSC should be
ignored, and reads of MSR_IA32_TSC should return the result of the
RDTSC instruction.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index d55562cd395d..2d42822fa01c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1729,6 +1729,30 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	/* Is it a WRMSR? */
 	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
 
+	/*
+	 * TSC related accesses should not exit to the hypervisor when a
+	 * guest is executing with SecureTSC enabled, so special handling
+	 * is required for accesses of MSR_IA32_TSC:
+	 *
+	 * Writes: Writing to MSR_IA32_TSC can cause subsequent reads
+	 *         of the TSC to return undefined values, so ignore all
+	 *         writes.
+	 * Reads:  Reads of MSR_IA32_TSC should return the current TSC
+	 *         value, use the value returned by RDTSC.
+	 */
+	if (regs->cx == MSR_IA32_TSC && cc_platform_has(CC_ATTR_GUEST_SECURE_TSC)) {
+		u64 tsc;
+
+		if (exit_info_1)
+			return ES_OK;
+
+		tsc = rdtsc();
+		regs->ax = UINT_MAX & tsc;
+		regs->dx = UINT_MAX & (tsc >> 32);
+
+		return ES_OK;
+	}
+
 	ghcb_set_rcx(ghcb, regs->cx);
 	if (exit_info_1) {
 		ghcb_set_rax(ghcb, regs->ax);
-- 
2.34.1

