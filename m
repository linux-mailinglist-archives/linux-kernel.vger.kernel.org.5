Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EA277B0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjHNFyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjHNFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:54:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247B610DB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMYo19NR1LZJnbpuNgdL0OmSSQJ5qN/ljpbIZ/pJR3SeuHg9S4NsKXNQ3kzfRGkIKUJt2UEUsqkxqsVWH+xVV1i2A9sPvvHlMsNqGANcxz6FKxHcgC6h5bvmxtZ7/6ofhi1i/6u5kw/tJtPg96pBYesxGU0iAjizZZQ33oJAZTieV6MFrvF4XtQ3VzHmR7hErVxvZPVo+6ciTA1BwafbSxVe2fzP0HwQyDF3Ki9xvTsACr/kvwULyUCjM5Kb+y/g2VMzyqx/rF9cKXLVdelh/b+xqi0LRfMArwoKDx/g6zvVcvBOUdiKTIwmVJc09x4I/ducLwl2YgrZHa+Ls2RefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhSrHljLl1rrS996VfK80M41HfQys5Vt16cM10AjRWE=;
 b=Re+SNZh2OpmZvHNmsX+H1+VjayiAcyptmt4p5ShXCFYm2dvwYj2E94jvB+MobidbqUl52+GQsGvqcGCanW/HUNFHUsJfuQYNBG17how6/xPkCivrYGcV6qcWFtlj6tR/VWtc8uYU1PmFtunjTS7D1Vu2wouaqYXDYZpeCWqaW2LSFnc7qkWamawqwXoy+w063SDqFMllaDobRvC20PkYfe77rbreYl11gu/GifuzeBBxGm8t691WlFF/neM++wg8/1TAyeB+nWUPNbKgR251+098aHiZLZjflMp6/7bCMrs2R+8CSoLNPxOUZllaMMCmg9mvDoAGA1LIiAztMvVQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhSrHljLl1rrS996VfK80M41HfQys5Vt16cM10AjRWE=;
 b=gahdQGdvP3QH8Vsoi95oRrh1Ci9QEIqIg2geoC2/4QawTGNJqE6XCpnftt9avc4OoTkKaDonqE5s5XUni41f2dIJPCTIer5OIdwwYoWa3eXZF7KGo9PYLWyyu9BMIwCCO0AGj4d2egZ7LT2z5JGAps0rgZpUhC+jSJmxZjUpuvk=
Received: from MW4PR03CA0138.namprd03.prod.outlook.com (2603:10b6:303:8c::23)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 05:54:07 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::ae) by MW4PR03CA0138.outlook.office365.com
 (2603:10b6:303:8c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.13 via Frontend Transport; Mon, 14 Aug 2023 05:54:06 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:54:01 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 10/14] x86/sev: Change TSC MSR behavior for Secure TSC enabled guests
Date:   Mon, 14 Aug 2023 11:22:18 +0530
Message-ID: <20230814055222.1056404-11-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814055222.1056404-1-nikunj@amd.com>
References: <20230814055222.1056404-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 2228fbfb-13a0-4021-bf63-08db9c8adf49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BR4U+ZdKqFtH6PRj062L0YMDZIWpq2AtxmHAczSx40DUdGSHvcsI35z6mTQsk6ar77ANSJuYTRECRElohqt8+CRCTWTFxbAYEtJ7h7I7MXcLns4XevqP6wfwwEXHuOCpjFQM3BDFrsRkzj+2RxUJ2ub6kZOSTXtF5051eFW1pc6GCni80lhnlErF8PXY3yAT2lutImmwabSw6w7JQaDiUh+nhQHZNQ5CeSDeXL968lSe1WFbYTAN6mFen//xbooXornQCzC+6DK8PykcSacibbHRYzr9Rmnk8JgNfl1/tymhzX43lTC/rkXXDZoq9/Sq8zDn0FOtB6bTbZO4/SAx4GNvefWIph2d8+HxYuh3Gwud1hCHvl4GT0ks4edFEe8NL9D/TECXuY0rhNHIRNSF+Nei/8ClpPAzCVWZCwRXUbnPoWVMw0zqckEkLJMmU/0m3n1IanBtCM2KbvlxMFDx1HXnN82b1xTwLEBQF77bMSgvx/yraEppoB+NwWtMSUeAtUR/Et+63gypRbdUpJ9hK+gnoA9mDky4z+hxFSBiGY9PUjerGfhvz3GkvFvdY3bb/cmyx/b2V81iRVs/YW52yk3uwsaH2EHLGlbIhfA22R0iF3ahODejygqSLRjmdxqWm9muKunfCU2IWPjNIKINET99OhWGlWysGGcsWXKdmEiMrYs8wrGf9dGJrm9QYC1vogNcOi+/ONt5Xr4Jv1JIAmKOettv6rHD75soCeC+aiFgwUUIPBrtb+wlSMSxBHjp4QXvKdouaXUwcXkx1HSoyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(82310400008)(451199021)(186006)(1800799006)(46966006)(40470700004)(36840700001)(26005)(16526019)(2616005)(336012)(2906002)(1076003)(36860700001)(426003)(83380400001)(47076005)(70206006)(70586007)(316002)(4326008)(5660300002)(8676002)(8936002)(41300700001)(6666004)(478600001)(7696005)(110136005)(54906003)(36756003)(40480700001)(40460700003)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:54:06.6910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2228fbfb-13a0-4021-bf63-08db9c8adf49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

