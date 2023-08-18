Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57418780E35
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377823AbjHROn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377921AbjHROnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:43:45 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4604489;
        Fri, 18 Aug 2023 07:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu/n2ygMmASLAmAKcp5qQXhfxsu9NFqC110l2vGcfJ0FossvifA6rN2YYdGTdkFR4pK+SwMQMiKjRwkD7R2FzvAPwiqkviynUEfGhKEKFADcfBjipaLRQ15sanLkCDjhcaMU9BRNbG/ULofiZqbP7Gaq1j4iDNpCAwP17mt8YyI/Yu7VnUEXtgjbesTax/OpTwZHBvWEtwCqgv1GSQCPbpgiUcC5sfHuBPF752VSxBi0oV+F/UfM7e8qqbp0czCt8CXSzeFYyczO5dfepmNXqVNzX1gliN7Gu3q+J0GriyIxaFRhCzp9AeRLtkZTTrPFNnst769XUlN9W/KgIZ7oXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Bm9xS8d7kYJzv/7ybqOLvdfV9Y5qw/34lLiVxWzdW8=;
 b=KliW0Azkyvp0M9nRK/AP8X/XA/ZWG91lOHp7da/835WEWQLa1RuGqEBxOdAh1eDcmfIOOBk1Gab/8RLHTAvwP/Oszd3qhU8xTLp8HJuXiI9iGW1SHG8pGSFnzmM27laO8/poJZtr4qT6QhRME5YmdMKoHSV05Xewf0qqJ+jcO74iNCLl+DgGoMl7tLLMC306Xu9T2qxZd5GlTPtIU8CTGcSP+XUf8upJ9U2ULrb03SUCqHs95yFjfJzbAT6WODE65A4dnaQak6H7HoIVFjL8v7ML8AKYxMxikW7G2ZgFLD0Y2WHvB3UxMbEEPH1tgvPRFBsGZnmvjL4v5FgS+WThog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bm9xS8d7kYJzv/7ybqOLvdfV9Y5qw/34lLiVxWzdW8=;
 b=fIfP6l9lzfb3FODLiVsFmbtgRj9+HImgnbA80PP8tfeWYIqTjCvtc3dOe9OaWFfaxXJbeGuTJvAif1rkxZ1n/JB90veMjFXbeGLBEzupdijv8ZYQ4s1kjSK6qa6MVxmtgTTtRpuNrKXmElvJNltloQJJuoWLlRyXF1lWBEqm8Ss=
Received: from CY8PR02CA0016.namprd02.prod.outlook.com (2603:10b6:930:4d::19)
 by DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 14:43:06 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::bf) by CY8PR02CA0016.outlook.office365.com
 (2603:10b6:930:4d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 14:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 14:43:05 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 09:42:49 -0500
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
Subject: [PATCH] tee: amdtee: add support for use of cma region
Date:   Fri, 18 Aug 2023 20:12:21 +0530
Message-ID: <7531423fcb3b18ff78737ae5eabc84b0e3cb2909.1692369704.git.Devaraj.Rangasamy@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM8PR12MB5478:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e853f5-9bcb-4b41-9122-08db9ff96ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nj52SbdmQlILLb7tm6KN/JecSbzMdihd/smlRtP0vjZkSQasV6naXNRunGj7D9ND8Ij7CNbJImFxWW35mp4sOyg0zpkh9T1PqhF1yjOHlDow+QyBeMK97b2VzIqSjfA3AnoIaiulpupSagbzTYdoatiZaiy+XSxuOERaaodSoGAnFL43pDbaSF+WdLs6X+zdTLQF5n6Lsj/vmpHz7vrbPM8LPMyaf7F43DR1lx4JAZO7MnPqx4mor68gLHHGsRxnCXRX4Znx3tkslXhMFI1UA5aftqQ64OPvAwK3YgWHlHOaDTD/KNWXZwGKdc6BEfgcayLK1yEa9z/FW6145fnL4LsXLrLcpvZZjM5mySiQbUAub3f/0fU9AEnF+8+xBAfGaG14Qf0GzjDehoSIPgQ18aaK7BxX9m8lt9/RQPTrrztDBdB8eBAvtQh6baMVC2ipV3kupB24nFxHaP9aU647YppO4rnP3y7bMhhDC/06kCarDUw7wWByH6jmoVEQ0HWZukRllZoT9ADsFlWAA9ES4l4aycCKs/jN2yEx0ikFkhRMC5F31z81BvajkfQgrGndqEEXE31W7n5zlcuvDCcc+b8iihuwqhIo0OeMr9uusc+cVJ7NsnZ8gbxOW3AC/OSUKQiY8BaKyrWq7ahlXfnKc5CTGJe9WA1CS1vHMKjFIz3YQ4m+cRzgNk4noGFqFdSh96p7LVIZm49G3N3XKaCPBDcaPC7UBTzJ7omAfdCVaN/UgvCt8mE01Fcyl6199YxeIhj4zwHhbUbzEJDdGLGdW810IzGOlyVLY+TFx/gy74g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(86362001)(16526019)(336012)(426003)(26005)(40480700001)(83380400001)(36756003)(36860700001)(47076005)(81166007)(921005)(82740400003)(356005)(2616005)(2906002)(54906003)(316002)(30864003)(41300700001)(70206006)(70586007)(110136005)(5660300002)(7416002)(8676002)(4326008)(8936002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 14:43:05.9430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e853f5-9bcb-4b41-9122-08db9ff96ef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In systems with low memory configuration, memory gets fragmented
easily, and any bigger size contiguous memory allocations are likely
to fail.
Contiguous Memory Allocator (CMA) is used to overcome this
limitation, and to guarantee memory allocations.

This patch adds support for CMA area exclusive to amdtee.
The support can be enabled if kernel have CONFIG_CMA enabled.
The size can be set via the AMDTEE_CMA_SIZE config option
at compile time or with the "amdtee_cma" kernel parameter.
(e.g. "amdtee_cma=32 for 32MB").

Also, cma zone is utilized only for buffer allocation bigger than
64k bytes. When such allocation fails, there is a fallback to the
buddy allocator. Since CMA requires a boot time initialization,
it is enabled only when amdtee is built as an inbuilt driver.

Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Co-developed-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
Signed-off-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++
 arch/x86/include/asm/setup.h                  |  6 ++
 arch/x86/kernel/setup.c                       |  2 +
 drivers/tee/amdtee/Kconfig                    |  9 +++
 drivers/tee/amdtee/Makefile                   |  1 +
 drivers/tee/amdtee/amdtee_private.h           |  6 +-
 drivers/tee/amdtee/core.c                     |  6 +-
 drivers/tee/amdtee/shm_pool.c                 | 32 ++++++--
 drivers/tee/amdtee/shm_pool_cma.c             | 78 +++++++++++++++++++
 drivers/tee/amdtee/shm_pool_cma.h             | 38 +++++++++
 10 files changed, 176 insertions(+), 9 deletions(-)
 create mode 100644 drivers/tee/amdtee/shm_pool_cma.c
 create mode 100644 drivers/tee/amdtee/shm_pool_cma.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 722b6eca2e93..5e38423f3d53 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -363,6 +363,13 @@
 			  selects a performance level in this range and appropriate
 			  to the current workload.
 
+	amdtee_cma=nn	[HW,TEE]
+			Sets the memory size reserved for contiguous memory
+			allocations, to be used by amdtee device driver.
+			Value is in MB and can range from 4 to 128 (MBs)
+			CMA will be active only when CMA is enabled, and amdtee is
+			built as inbuilt driver, and not loaded as module.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f3495623ac99..bb5e4b7134a2 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -66,6 +66,12 @@ extern void x86_ce4100_early_setup(void);
 static inline void x86_ce4100_early_setup(void) { }
 #endif
 
+#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
+void amdtee_cma_reserve(void);
+#else
+static inline void amdtee_cma_reserve(void) { }
+#endif
+
 #ifndef _SETUP
 
 #include <asm/espfix.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index fd975a4a5200..e73433af3bfa 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1223,6 +1223,8 @@ void __init setup_arch(char **cmdline_p)
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
+	amdtee_cma_reserve();
+
 	if (boot_cpu_has(X86_FEATURE_GBPAGES))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 
diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
index 191f9715fa9a..5843c739a7b8 100644
--- a/drivers/tee/amdtee/Kconfig
+++ b/drivers/tee/amdtee/Kconfig
@@ -6,3 +6,12 @@ config AMDTEE
 	depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD
 	help
 	  This implements AMD's Trusted Execution Environment (TEE) driver.
+
+config AMDTEE_CMA_SIZE
+	int "Size of Memory in MiB reserved in CMA for AMD-TEE"
+	default "0"
+	depends on CMA && (AMDTEE=y)
+	help
+	  Specify the default amount of memory in MiB reserved in CMA for AMD-TEE driver
+	  Any amdtee shm buffer allocation larger than 64k will allocate memory from the CMA
+	  The default can be overridden with the kernel commandline parameter "amdtee_cma".
\ No newline at end of file
diff --git a/drivers/tee/amdtee/Makefile b/drivers/tee/amdtee/Makefile
index ff1485266117..a197839cfcf3 100644
--- a/drivers/tee/amdtee/Makefile
+++ b/drivers/tee/amdtee/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_AMDTEE) += amdtee.o
 amdtee-objs += core.o
 amdtee-objs += call.o
 amdtee-objs += shm_pool.o
+amdtee-objs += shm_pool_cma.o
diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
index 6d0f7062bb87..9ba47795adb6 100644
--- a/drivers/tee/amdtee/amdtee_private.h
+++ b/drivers/tee/amdtee/amdtee_private.h
@@ -87,11 +87,13 @@ struct shmem_desc {
  * struct amdtee_shm_data - Shared memory data
  * @kaddr:	Kernel virtual address of shared memory
  * @buf_id:	Buffer id of memory mapped by TEE_CMD_ID_MAP_SHARED_MEM
+ * @is_cma:	Indicates whether memory is allocated from cma region or not
  */
 struct amdtee_shm_data {
 	struct  list_head shm_node;
 	void    *kaddr;
 	u32     buf_id;
+	bool    is_cma;
 };
 
 /**
@@ -145,9 +147,9 @@ int amdtee_invoke_func(struct tee_context *ctx,
 
 int amdtee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
 
-int amdtee_map_shmem(struct tee_shm *shm);
+int amdtee_map_shmem(struct tee_shm *shm, bool is_cma);
 
-void amdtee_unmap_shmem(struct tee_shm *shm);
+void amdtee_unmap_shmem(struct tee_shm *shm, bool *is_cma);
 
 int handle_load_ta(void *data, u32 size,
 		   struct tee_ioctl_open_session_arg *arg);
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 372d64756ed6..448802dccf13 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -336,7 +336,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
 	return 0;
 }
 
-int amdtee_map_shmem(struct tee_shm *shm)
+int amdtee_map_shmem(struct tee_shm *shm, bool is_cma)
 {
 	struct amdtee_context_data *ctxdata;
 	struct amdtee_shm_data *shmnode;
@@ -368,6 +368,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
 
 	shmnode->kaddr = shm->kaddr;
 	shmnode->buf_id = buf_id;
+	shmnode->is_cma = is_cma;
 	ctxdata = shm->ctx->data;
 	mutex_lock(&ctxdata->shm_mutex);
 	list_add(&shmnode->shm_node, &ctxdata->shm_list);
@@ -378,7 +379,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
 	return 0;
 }
 
-void amdtee_unmap_shmem(struct tee_shm *shm)
+void amdtee_unmap_shmem(struct tee_shm *shm, bool *is_cma)
 {
 	struct amdtee_context_data *ctxdata;
 	struct amdtee_shm_data *shmnode;
@@ -395,6 +396,7 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
 	mutex_lock(&ctxdata->shm_mutex);
 	list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
 		if (buf_id == shmnode->buf_id) {
+			*is_cma = shmnode->is_cma;
 			list_del(&shmnode->shm_node);
 			kfree(shmnode);
 			break;
diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
index f0303126f199..9aad401387be 100644
--- a/drivers/tee/amdtee/shm_pool.c
+++ b/drivers/tee/amdtee/shm_pool.c
@@ -7,19 +7,30 @@
 #include <linux/tee_drv.h>
 #include <linux/psp.h>
 #include "amdtee_private.h"
+#include "shm_pool_cma.h"
 
 static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 			 size_t size, size_t align)
 {
 	unsigned int order = get_order(size);
 	unsigned long va;
+	bool is_cma = false;
 	int rc;
 
 	/*
 	 * Ignore alignment since this is already going to be page aligned
 	 * and there's no need for any larger alignment.
 	 */
-	va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+
+	/* if CMA is available, use it for higher order allocation */
+	if (amdtee_get_cma_size() && order > 6)
+		va = amdtee_alloc_from_cma(shm, order);
+
+	if (va)
+		is_cma = true;
+	else
+		va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+
 	if (!va)
 		return -ENOMEM;
 
@@ -28,9 +39,13 @@ static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 	shm->size = PAGE_SIZE << order;
 
 	/* Map the allocated memory in to TEE */
-	rc = amdtee_map_shmem(shm);
+	rc = amdtee_map_shmem(shm, is_cma);
 	if (rc) {
-		free_pages(va, order);
+		if (is_cma)
+			amdtee_free_from_cma(shm);
+		else
+			free_pages(va, order);
+
 		shm->kaddr = NULL;
 		return rc;
 	}
@@ -40,9 +55,16 @@ static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 
 static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
 {
+	bool is_cma = false;
+
 	/* Unmap the shared memory from TEE */
-	amdtee_unmap_shmem(shm);
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	amdtee_unmap_shmem(shm, &is_cma);
+
+	if (is_cma)
+		amdtee_free_from_cma(shm);
+	else
+		free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+
 	shm->kaddr = NULL;
 }
 
diff --git a/drivers/tee/amdtee/shm_pool_cma.c b/drivers/tee/amdtee/shm_pool_cma.c
new file mode 100644
index 000000000000..99dda9adb1c6
--- /dev/null
+++ b/drivers/tee/amdtee/shm_pool_cma.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/cma.h>
+#include <linux/mm.h>
+#include <linux/tee_drv.h>
+#include "shm_pool_cma.h"
+
+static struct cma *amdtee_cma;
+unsigned long amdtee_cma_size __initdata = CONFIG_AMDTEE_CMA_SIZE * SZ_1M;
+
+static int __init early_parse_amdtee_cma(char *p)
+{
+	int cmd_size;
+
+	if (!p)
+		return 1;
+
+	cmd_size = memparse(p, NULL);
+	if (cmd_size >= 4 && cmd_size <= 256)
+		amdtee_cma_size = cmd_size * SZ_1M;
+	else
+		pr_err("invalid amdtee_cma size: %lu\n", amdtee_cma_size);
+
+	return 0;
+}
+early_param("amdtee_cma", early_parse_amdtee_cma);
+
+void __init amdtee_cma_reserve(void)
+{
+	int ret;
+
+	ret = cma_declare_contiguous(0, amdtee_cma_size, 0, 0, 0, false, "amdtee", &amdtee_cma);
+	if (ret)
+		pr_err("Failed to reserve CMA region of size %lu\n", amdtee_cma_size);
+	else
+		pr_info("Reserved %lu bytes CMA for amdtee\n", amdtee_cma_size);
+}
+
+unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned int order)
+{
+	struct page *page = NULL;
+	unsigned long va = 0;
+	int nr_pages = 0;
+
+	if (amdtee_cma) {
+		nr_pages = 1 << order;
+		page = cma_alloc(amdtee_cma, nr_pages, 0, false);
+		if (page)
+			va = (unsigned long)page_to_virt(page);
+		else
+			pr_debug("failed to allocate from CMA region\n");
+	} else {
+		pr_debug("CMA region is not available\n");
+	}
+	return va;
+}
+
+void amdtee_free_from_cma(struct tee_shm *shm)
+{
+	struct page *page;
+	int nr_pages = 0;
+
+	if (amdtee_cma) {
+		nr_pages = 1 << get_order(shm->size);
+		page = virt_to_page(shm->kaddr);
+		cma_release(amdtee_cma, page, nr_pages);
+	} else {
+		pr_err("CMA region is not available\n");
+	}
+}
+#endif /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
diff --git a/drivers/tee/amdtee/shm_pool_cma.h b/drivers/tee/amdtee/shm_pool_cma.h
new file mode 100644
index 000000000000..d1cde11cbede
--- /dev/null
+++ b/drivers/tee/amdtee/shm_pool_cma.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: MIT */
+
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#ifndef SHM_POOL_CMA_H
+#define SHM_POOL_CMA_H
+
+#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
+
+extern unsigned long amdtee_cma_size;
+
+static inline unsigned long amdtee_get_cma_size(void)
+{
+	return amdtee_cma_size;
+}
+
+unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned int order);
+
+void amdtee_free_from_cma(struct tee_shm *shm);
+
+#else /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
+
+static inline unsigned long amdtee_get_cma_size(void)
+{
+	return 0;
+}
+
+static inline unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned int order)
+{
+	return 0;
+}
+
+static inline void amdtee_free_from_cma(struct tee_shm *shm) { }
+
+#endif /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
+#endif /* SHM_POOL_CMA_H */
-- 
2.25.1

