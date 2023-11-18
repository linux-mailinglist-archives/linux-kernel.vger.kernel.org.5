Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9258E7F02A0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjKRTdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjKRTdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:17 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CEB182;
        Sat, 18 Nov 2023 11:33:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NunpJUfVMRNONOjB6xeio5nYRuvMyzUMVxThqswf1VzTFIB2aNSz7jUet2qa6g1JjD11qiMt8me9Ds4aFwGpzJvfAQZtlWVUK9ps0U2VXoWr//ceoVX+W5bl3/n0tCx7YP4cYmgkbQ5ywnRZ3qgZ06tHM6pF8R2otE/R2yBB/Hv7DcKcCkXmHpt+oWrWwiKNQ4aPphDSgqtbOYXG+zwxfwXhHE+E9e52oWdjHPhU+Wfn3vUnrMo5JDw0BMAdVeq9FvZMzMEwQYIemnzj9vbGAhCuR2Gs70Swi591b9DJt4VISCEWlru0i0GP/K1AyQkLoHlyPAtFajHZJLI02K0W2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+44HoDxAcTsjWv7EzHqjBhM539PXDvFKvf4IB8D2vHs=;
 b=dqPtX8VHe99uLKud2K4Ubt8TxXpKkL+9la16mrOtUHO8H5yU2WpC5HuWp9dm9c4KLlRVHEklmfFolN5iMjEqcfhopMY09R+eTJxmxcqDOmKx1Bmol7fZwm81he/KRwJJv0HaDAze9IRVKzCj31OXHUjKxCZh4V2zRCnLbV5IatsiosqPByAdYvgN8Zg66FDHrvs7qb9iUI5K9Ge5OEwusB2N9hthWIMjTUum3Fr3cwiEDQ8CvUmFmcm+j3A/B+8PUIgSoBqdMzgNgMcNlgj87QqHpMlKdJW6G6x8341pFUIfqPZN+sP6hGqFCKx2Ix+jXr1jERuMXGSC03RCbSdyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+44HoDxAcTsjWv7EzHqjBhM539PXDvFKvf4IB8D2vHs=;
 b=aIeBhpaVN/Il+5rjyX9JeFGFgUWiw6OuHW/PgRq7f20AZBjCnRCEWUB/os7MElsxJCZQfAdk5NZVmVoxErDVXlZhH2QHflzv3mOYqJFa5YaIsBHDNWrJ6X8S4QGbHCCDC08hveI64vZl8jhna56JW3TV3RCxB353pa05MUOVcEk=
Received: from MN2PR10CA0011.namprd10.prod.outlook.com (2603:10b6:208:120::24)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 19:33:10 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::6) by MN2PR10CA0011.outlook.office365.com
 (2603:10b6:208:120::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:10 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:08 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 15/20] x86/mce: Skip AMD threshold init if no threshold banks found
Date:   Sat, 18 Nov 2023 13:32:43 -0600
Message-ID: <20231118193248.1296798-16-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: be7bb09a-1a85-4696-acad-08dbe86d330f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtDKS7BzBZYN5oiHhB3qJnXb5L1kaV4qDumHeVqQxM/vCpr5R18RwrgkQrQl1rCM2ph5a0viuvV5wXw8CpoeAgC4quOuPjmryWhl3g1r7gcOfoZZDPEYJrwzL0niETyLsjIYxGlLqvo/kbul0Bi9zyYHyaIz8CbMvth8UyRIfAkaz44K3DfWKG9e/AYmCFJjQz/433PKOLII+aQc/P7xdqF60xt92Az9E7/d7p8/ysPmM+d2zuBu6zABMNApzfknJyYWVNS9Wak4Ge3fo4cGg1HYBbQbBJJeiyklzMFcKWb4tqO27Uo24IRuPQqeyqOvHIHFEu2klzLP1PScz6AINrWr5GHOhGiIYeEpCaeG1Ewv4wY6iPE7+fINdaNc3Xgtw78MBF45qGeKj0kJ1zLNJI5X0LR0DTh1otFJWi9ZPYUzY/x0qGQYIBrBgMhnX2/drHcG3SxXHVhGadCMyKZ31XHs8QNF7Tw72SJCVMlTOXSddnO8kqkrb/kAMMIqvdv4XHpENb3HYSwETNfAAPK/dKj92+mhUMYCb8NAVQooec4R0DTAbKlZgdyNOA1T8wQtrcrA2yc8diUrEgOBrhanZCp+FmcMxudi6hnF6YYwUnxhm4BoUvm28MrDuOEcx0BgNRFy3hnstZDA3Nf1T/AM9XCezLp1Ae6sBAGr4MLU2TFyOFRISFAxR9fKUqKGc3OEtsBkcij+YYqym1SrPO97IatSZUVGbnmxsNjQhVsDtfGhlHfqvLPpD+0eKOfnCYWtza/V+3afM9xigOBN5At+BgAYUqRzll5jW2juopHFHfg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(44832011)(2906002)(15650500001)(356005)(81166007)(82740400003)(86362001)(36756003)(336012)(426003)(83380400001)(1076003)(26005)(16526019)(2616005)(7696005)(36860700001)(478600001)(6666004)(47076005)(41300700001)(8676002)(8936002)(4326008)(70586007)(70206006)(316002)(6916009)(54906003)(40480700001)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:10.8489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7bb09a-1a85-4696-acad-08dbe86d330f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
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

AMD systems optionally support MCA Thresholding. This feature is
discovered by checking capability bits in the MCA_MISC* registers.

Currently, MCA Thresholding is set up in two passes. The first is during
CPU init where available banks are detected, and the "bank_map" variable
is updated. The second is during sysfs/device init when the thresholding
data structures are allocated and hardware is fully configured.

During device init, the "threshold_banks" array is allocated even if no
available banks were discovered. Furthermore, the thresholding reset
flow checks if the top-level "threshold_banks" array is non-NULL, but it
doesn't check if individual "threshold_bank" structures are non-NULL.
This is avoided because the hardware interrupt is not enabled in this
case. But this issue becomes present if enabling the interrupt when the
thresholding data structures are not initialized.

Check "bank_map" to determine if the thresholding structures should be
allocated and initialized. Also, remove "mce_flags.amd_threshold" which
is redundant when checking "bank_map".

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c      | 2 +-
 arch/x86/kernel/cpu/mce/core.c     | 1 -
 arch/x86/kernel/cpu/mce/internal.h | 3 ---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b45ee297cde2..462ba9ff997b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1434,7 +1434,7 @@ int mce_threshold_create_device(unsigned int cpu)
 	struct threshold_bank **bp;
 	int err;
 
-	if (!mce_flags.amd_threshold)
+	if (!this_cpu_read(bank_map))
 		return 0;
 
 	bp = this_cpu_read(threshold_banks);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a81c0df217e2..bdbc32f10a9a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2004,7 +2004,6 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
-		mce_flags.amd_threshold	 = 1;
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 8ed1035f013b..fca7499e1bf4 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -162,9 +162,6 @@ struct mce_vendor_flags {
 	/* Zen IFU quirk */
 	zen_ifu_quirk		: 1,
 
-	/* AMD-style error thresholding banks present. */
-	amd_threshold		: 1,
-
 	/* Pentium, family 5-style MCA */
 	p5			: 1,
 
-- 
2.34.1

