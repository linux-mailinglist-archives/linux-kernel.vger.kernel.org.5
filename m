Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC4778CD81
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbjH2UVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbjH2UUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:20:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058DFCC3;
        Tue, 29 Aug 2023 13:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+QuEZ7cW6ehc1J2+1C7hvDpY0hoARSIj126hH1wlWcWWLfTVxlIrTqt78XCH3OXwAfS5G7wBYI8ATgiD91354/2MPh+CTMDSrI77XqZUYaOBhrjppDbuiIBydJADWcblhc/sRNCYYcCRHx6jYPl47yh00C9T1jUEPwiIanlpTlv5uE/uRaOkDuoIZQtAJt8/mlCu9BqeNFOQ+2BA8l7MJXoDMCh8mhluqqceSokrLQHSLM0ImtnN+TvHR8yl3rL8kmLP5rxOTelnbH6r8eaAnFBqba/lTllNFs8G9j8WcQUYrfswIX6+v+p9yUKfKV4U6pgPUszKLhCYT9I8Ow1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00e3Y5786Rq6uUOlT3C2FTByGVKIII8M64KZ7Do24RM=;
 b=CeQwmHN5sicb5lzruPHM84916+F+BrLMys6Dr1R2iJMzEF4wVwcXLS7GeL6/NiN3e3vfQ0Lpxk/twfeN5hiRzfProCciszd2PXTVniDEW43sGPiZLUJvrrqouaC6tmYdNr6SCBsoVfk6DZGYiftGPyCZcbqizODkOH5hiv6+9i0Q8KpvvoKX+3dYiUIypt6J8smlSclIHsOwLd7i3roBHPKVVCzO21OijNRIvFAflEON1wOmXwkKLpQojX6Erf+tVFRjy9puiO4lZHrUnlXlLByBZJxJKz08nXR76uL1PKe5sSL2F0v8ECwpK54ejsixaTpAXBBzpbACd2HoBBMRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00e3Y5786Rq6uUOlT3C2FTByGVKIII8M64KZ7Do24RM=;
 b=17PB6V3gF3+vMYzxMDaueOC1b/rC37fj+EomRKaXFKZBPSDkLoxc59DqD326gSVEACoCEDx6W2Dh6bNr/VmQxmq++zmXI550RxSSdPDIsr2a+Zqg4kRXR+Z+qwBLit1uRQqpT5kWDuk2Wi3cZUDZTZ6M3HWqeqAYQAAG2fJ298s=
Received: from MW4PR04CA0344.namprd04.prod.outlook.com (2603:10b6:303:8a::19)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 20:20:49 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::7f) by MW4PR04CA0344.outlook.office365.com
 (2603:10b6:303:8a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 20:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 20:20:48 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 15:20:27 -0500
From:   Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        SivaSangeetha SK <SivaSangeetha.SK@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>
CC:     Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>
Subject: [PATCH v2 2/2] tee: amdtee: add support for CMA buffer allocations
Date:   Wed, 30 Aug 2023 01:49:43 +0530
Message-ID: <8c7f0641582d53c20c6657f0ebb4d3a1279e6f9b.1693340098.git.Devaraj.Rangasamy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <fe6fd7781d77ea32064e5b861f33150b28768278.1693340098.git.Devaraj.Rangasamy@amd.com>
References: <fe6fd7781d77ea32064e5b861f33150b28768278.1693340098.git.Devaraj.Rangasamy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 53761acf-f3e5-491d-7765-08dba8cd6f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53QJRN5BT2bYpCTdVJ/J6pA34bxq4evJQBbTbWSuC6Mv7w/rrarKqSQCdMYuQMbBGdzV5xmCASCBrMqCwYOipcz06MnpgarKlnswRtCxXQKtsRJA2Uxzf82wcR1YXFjARyej8OClO7yfTcxhRsyKwC8Vz/v2OJn4Dxamz9NnrJa7VT1pU10WxU1IpHelUQkc8aCaMuJr+6B78LowKeUBgEqKVs59fqazP4kr0q65kN6ZhaHbMWV/rFPmJMapMV7lx787DYGnJVZIKz2M7cmjnr50EXbHOshO6u6jVMfQ04j7ZXZRSLBzMOZ7OuyWOlp1TOLmEQyOwKfIjawH/JO1n2EXSzyef7gHCB4A9E9VTIZNKzhTF3GYWmXsEdk9Lpr5BJSlk/S0tySC4y+DjovuaP3cW7JYPw8dqK2GpBPFujzAAH66af1ys29/xsGoJHJtEoZB7Ga3kIJu5vtFjg1GGsO2oheqrnxzEnmTXFj5DVEVqBxaDTFHhtfRMF0tNTgWswYyVBIkGhvCm/VZJT5Kdv8ejimTFxyUEjsFIpgoaM6AEOS2yXsRaaqL+GYUXgHvhNm8tgwKfc67rvWgCZaznVGtd2ST61ebN3I3+Ei1kdUGWcEZOhCmxw1mgT/czkV1tcTwIGCHsWQZgA9b5eYrSr8bHT26/D8QI3eICUb94dBYuVwzK0gt9UxGIpJYqnonPXJWia1Q90VCF19n103+rzTC4r/a+5GSAdx8doZo98PVmPeqyAvSrnjRD7zBCQYtcvGUygQ7O8LzIjNYe6pZsHQiXZ1r+7i1d2w9ZTvBwfA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(336012)(2616005)(81166007)(82740400003)(921005)(6666004)(86362001)(47076005)(83380400001)(478600001)(356005)(7416002)(26005)(36860700001)(7696005)(426003)(16526019)(40480700001)(70586007)(70206006)(36756003)(110136005)(54906003)(316002)(2906002)(5660300002)(4326008)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 20:20:48.9328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53761acf-f3e5-491d-7765-08dba8cd6f30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amdtee driver shall use CMA region for contiguous
buffer allocation, if CMA is available.

since CMA and DMA contiguous APIs are not exported,
this support is enabled only when amdtee is built
as a builtin driver.

Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
v2:
* Switched to generic CMA pool.
* Replaced __get_free_pages() with alloc_pages_exact().
* Compacted patch with simplified changes within single file.

 drivers/tee/amdtee/shm_pool.c | 51 +++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
index 156e8a6f631f..d504d9749114 100644
--- a/drivers/tee/amdtee/shm_pool.c
+++ b/drivers/tee/amdtee/shm_pool.c
@@ -5,10 +5,50 @@
 
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/dma-map-ops.h>
 #include <linux/tee_drv.h>
 #include <linux/psp.h>
 #include "amdtee_private.h"
 
+#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_DMA_CMA)
+static void *alloc_from_cma(size_t size)
+{
+
+	int nr_pages = size >> PAGE_SHIFT;
+	struct page *page;
+
+	page = dma_alloc_from_contiguous(NULL, nr_pages, 0, false);
+	if (page)
+		return page_to_virt(page);
+
+	return NULL;
+}
+
+static bool free_from_cma(struct tee_shm *shm)
+{
+
+	int nr_pages;
+	struct page *page;
+
+	if (!dev_get_cma_area(NULL))
+		return false;
+
+	nr_pages = shm->size >> PAGE_SHIFT;
+	page = virt_to_page(shm->kaddr);
+	return dma_release_from_contiguous(NULL, page, nr_pages);
+}
+#else
+static void *alloc_from_cma(size_t size)
+{
+	return NULL;
+}
+
+static bool free_from_cma(struct tee_shm *shm)
+{
+	return false;
+}
+#endif
+
 static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 			 size_t size, size_t align)
 {
@@ -17,7 +57,11 @@ static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 
 	size = PAGE_ALIGN(size);
 
-	va = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
+	va = alloc_from_cma(size);
+
+	if (!va)
+		va = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
+
 	if (!va)
 		return -ENOMEM;
 
@@ -40,7 +84,10 @@ static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
 {
 	/* Unmap the shared memory from TEE */
 	amdtee_unmap_shmem(shm);
-	free_pages_exact(shm->kaddr, shm->size);
+
+	if (!free_from_cma(shm))
+		free_pages_exact(shm->kaddr, shm->size);
+
 	shm->kaddr = NULL;
 }
 
-- 
2.25.1

