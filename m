Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741E578CD7D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjH2UUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbjH2UUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:20:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50D2CC2;
        Tue, 29 Aug 2023 13:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drQPYudmcm+7fFh3eV9yM4fpJFMuq6BynZQ+GvgBJjQP9Fv2qWpjz0ibs32+/IYSubwdfHtuxdp5FbdEnGBB5fxXK1w+rXYZV6cPyrBaqrkjFd/XMhUPndt6D3cisPYDowHVfdJw7yvtOGg0mfToG5zOSmFpibRtWECM/GSdoRmO+WDqG05UsFuYwHv+QHAxTTqz+uozK5CvBiFyywpkGraaQ8vQyU0I/z42BC5Ly296zATjryao5BKRd+UmvSMQcXw2JOqOSOhhhZ62kkmo5LPayEVg8co3pqqxgEdAecxlrvvnnUblhqzPpsxR2SzqBRlgTJ8FtUEUB4Nizvu4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1B4NXuXAz+4ABFdKkVxhyuWwHL/u8W5uLuVcUYqUII=;
 b=nCBlgdghDexGr5zkXuZ+jeeOqYW5uP7nIzbaSGgmPnPVP9pDoV7E48uT6xQXMIuP0vNKjQrDqAwfzEPLzX7Erixd7jejg+VDIDtlvYgF2LnBJUiEnRXVR8PAjnkQzURvjNhVigUfCyyxpB9Qx/7GEdK8TZbT2Wuuur4Ho1UbYMD8m5yw4sqg0Aa9zHcX9PFXK/hj6o7pxmq77XV0CxUwdrbrnNNchzI6iywsd6G28Q7YN86nTOojILXufTjfFfLuD1LbAm2DjOD1CjUEoLZfuHNqmuKmFrxyHyS8aUd6J4JuRyJ8HjEDLzfmWEXbCOyRCvwwgqpYexEGKiLqlACEuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1B4NXuXAz+4ABFdKkVxhyuWwHL/u8W5uLuVcUYqUII=;
 b=wQ31hJM00sr5uwZNd0ijnCsPn1f7mRFatXaHO0uqAzvB76iA9LmNFUP7U5w17Ny2xy/uUf6HDQZ5sD1fpQQXwEAnfvD7H89T9UdQ2J9cj3tScfJ7gw62tKuMKaGbIFIk66+wm+BA6zpkfzRHKfVBBn0Jv/bPk1n7FDhYNCONlBw=
Received: from MW4PR04CA0354.namprd04.prod.outlook.com (2603:10b6:303:8a::29)
 by CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 20:20:09 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::94) by MW4PR04CA0354.outlook.office365.com
 (2603:10b6:303:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 20:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 20:20:08 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 15:19:59 -0500
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
Subject: [PATCH v2 1/2] tee: amdtee: use page_alloc_exact() for memory allocations
Date:   Wed, 30 Aug 2023 01:49:42 +0530
Message-ID: <fe6fd7781d77ea32064e5b861f33150b28768278.1693340098.git.Devaraj.Rangasamy@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|CH0PR12MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 390a58a3-0ae0-4d02-f358-08dba8cd5739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DD6Lfqr81wntsDvwGyIJJZAZ2UlXvCB4gMRWlNsfSGFkg+mTGCAQpMTBgCC9WdofUAfy/izr/zCQBmP18QaqnSt1SucZvgyuezK8yagUP0lVITHKzM2GjU4YQ2BHEkVA6KeSYehoIqmqVToKFcJVsOQJ0xgWQqXsWraolv9cQN34bZpz7Goxr4opxY3L3dDGZWCNoznFhwkIbRb0NL0wbD5Wcw7wf286gRxwouaWy7JmCNtjxGYaVY2qmL+CkYYVDx3CxKllezxRUY1mKHG8z5TIvjdkXS8NpSuyY/1Fi1YM9OPAHMgpXcpV9Fb8DGMqoa+lHIi+PJEC6wc2QVL8ayReRqjjL1a0uN0hhy5OwmpDI1+H2A6h9RKgBD2aaH9+nndii7EnxwE2xx7RVdEXdu/bU9hXGRba7glttRUiO/5Pt49PuJeakA33/aY6SHTTl/r7uCdzung2eUgLsMMqT2Jcj055tdQSBkhHkfzJsHwc/DbrwdGUaQNN+BlylccvApezGbikxfIOMNrjPP1FmkN27CcspfCscxkK4vTtJpMZC1VHJS3ZGxIUkXvkcQFHdxHWlMK0Mm67jBSpNkmPf05VBFDwLkHWefyEMkOkJZdb0zVYxiWJv+M6ORv6QkrOvBLbpWOok9dNYmaotQca7vKow/E8GkJS0tUNUUz2mjH66l0XYjIOFTyt6aanWxKz5SMZzw9I8Qtxs0RcQMCYu3MOnfWkn854m3EpYxzc4wQpuuUjJxc4fUf40gStAtN+a/lrJu2K0oiyddbAlNaSbUq/mcm0S3FXFloXTmCZxBI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(7696005)(6666004)(83380400001)(26005)(2906002)(478600001)(426003)(336012)(16526019)(110136005)(7416002)(316002)(54906003)(4326008)(41300700001)(70586007)(5660300002)(8936002)(70206006)(8676002)(36756003)(40460700003)(86362001)(36860700001)(47076005)(40480700001)(2616005)(356005)(81166007)(921005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 20:20:08.7141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 390a58a3-0ae0-4d02-f358-08dba8cd5739
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5387
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use page_alloc_exact() to get buffers, instead of
get_free_pages(), so as to avoid wastage of memory.
Currently get_free_pages() is allocating at next order,
while page_alloc_exact() will free the unused pages.

Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
---
 v2:
 * Replaced __get_free_pages() with alloc_pages_exact().

 drivers/tee/amdtee/shm_pool.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
index f0303126f199..156e8a6f631f 100644
--- a/drivers/tee/amdtee/shm_pool.c
+++ b/drivers/tee/amdtee/shm_pool.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/tee_drv.h>
 #include <linux/psp.h>
 #include "amdtee_private.h"
@@ -11,26 +12,23 @@
 static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 			 size_t size, size_t align)
 {
-	unsigned int order = get_order(size);
-	unsigned long va;
+	void *va;
 	int rc;
 
-	/*
-	 * Ignore alignment since this is already going to be page aligned
-	 * and there's no need for any larger alignment.
-	 */
-	va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+	size = PAGE_ALIGN(size);
+
+	va = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
 	if (!va)
 		return -ENOMEM;
 
 	shm->kaddr = (void *)va;
 	shm->paddr = __psp_pa((void *)va);
-	shm->size = PAGE_SIZE << order;
+	shm->size = size;
 
 	/* Map the allocated memory in to TEE */
 	rc = amdtee_map_shmem(shm);
 	if (rc) {
-		free_pages(va, order);
+		free_pages_exact(va, size);
 		shm->kaddr = NULL;
 		return rc;
 	}
@@ -42,7 +40,7 @@ static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
 {
 	/* Unmap the shared memory from TEE */
 	amdtee_unmap_shmem(shm);
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	free_pages_exact(shm->kaddr, shm->size);
 	shm->kaddr = NULL;
 }
 
-- 
2.25.1

