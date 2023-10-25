Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2AD7D6200
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjJYG70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjJYG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:59:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABB11AC;
        Tue, 24 Oct 2023 23:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYoVhyQpjfAJPdwn5HryczDm2oDITOZRDPT5N3I/u2cpn0AyPSELD5ZrGXp4/DzNJOu0Wxu1V0CwuqVutdrnPILr0xJPxL5bFTYMbJbNEQ4n/JFNlj7kFl7KbWaSCMMyCvSLL6vWk3PWzfF744oRvYoED3R88PnHtQibyFg8TbzS2REXUwcK0HdyA6G8laD5PI7biq1rW0AECvwAH5ycdd415tXm3Mm+s+zsOkPKR9xYOO141cc8icPy25v0r5zz7qrAmRb+Va1RSbX/flx7jQ8K9FB7h1G5y2hDbJMjqlrOviXJAygWjYVYKJr7rViQKlpDgElsM3ak/zWsXZIA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckWBEZeidJZReDK1hNwwgvj0byokhOBvzxlNdWHB8Uo=;
 b=b796Gc5uv9AGadvntMnRvfsoLcFSK0GtoxuCIJeH2MF6YsAvnqCP73EqqsEkmxneFlF3qfQDdWG/ocZazOhq0fB1wz1nUIQFx2yMPsEPZbLteqCxXutCiBiBav7KCTAufwbIN6d5RC0Bk+lgWhHy/CibG8t0KNDBb1RHH60NOymMbnM/GUyKgCwbj+YOi6OFhQxfklYL+yeN16G0Ns+VkgE03HL5i+sD0Ay3eMOnlVN+OPK3Ejp1RIn/BibCeG/L6+xOtdhHpE8pCAE97gmY94B5GfmnEBpsyUVA5puRxUOPcqoYtnKvd4CxePuFynpORpr3kGNkwztJddZezdHhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckWBEZeidJZReDK1hNwwgvj0byokhOBvzxlNdWHB8Uo=;
 b=rx2R9HXLyx0wpvaHzzRBjEeLwvqcv0HYX+2W7VFkjhAuI33PmUkI08WQYKfXO0j9T+5n+df8aDAHnEkwsNm9IO3fAW4BadoQjIMTJrIWa2fvc1tpLHRlpRGVwziwqQDFvcwl5GepOQqQ2RmJNeMZO29yG449Oc1BgSKGGhRNSJI=
Received: from SA0PR13CA0004.namprd13.prod.outlook.com (2603:10b6:806:130::9)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 25 Oct
 2023 06:59:12 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::c) by SA0PR13CA0004.outlook.office365.com
 (2603:10b6:806:130::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 06:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 06:59:12 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 01:59:06 -0500
From:   jeshwank <JESHWANTHKUMAR.NK@amd.com>
To:     <thomas.lendacky@amd.com>, <john.allen@amd.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jens.wiklander@linaro.org>, <sumit.garg@linaro.org>,
        <jarkko.nikula@linux.intel.com>, <mario.limonciello@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>
CC:     <Mythri.Pandeshwarakrishna@amd.com>, <Devaraj.Rangasamy@amd.com>,
        <Rijo-john.Thomas@amd.com>, <nimesh.easow@amd.com>,
        <JESHWANTHKUMAR.NK@amd.com>
Subject: [PATCH 3/3] tee: amdtee: Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
Date:   Wed, 25 Oct 2023 12:27:00 +0530
Message-ID: <20231025065700.1556152-4-JESHWANTHKUMAR.NK@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
References: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbb4be3-d714-4d6f-f8e1-08dbd527e4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePNOO5RsFvvqkseZfG7EvqL+dpPE4OUNihJ1u3yEo/veR3R0YjMhqhJj8tMMKhPtvbZMA28VSv2T+O1qtlhXWoKqXWR3fl9r8jkVE0zmLfMYL3Wj4oxdonxOk2m4duLaeDb5k837soCWHx85n4Bq+hxoa8MAiciwPFUUzfrXEAHcfwT3Pe7J41sFskMduiqhZWmDS1qrFMm2ECuHa0ib7aFayfqNCHKSc+Fzy/3lL55JrSY+GYfEOUIgbsWnd0ImWoPgeULQLNYHCiKNYHDDHpeOL4W8wEFMD3bbfyA3cvfh5K/VEUh0MLAfgo07AmVCsp7qxal2NSchSXj3xLETy3C+ffQ29jdTFyq2AGSdsL73uZCVirqwmdoRRn5VoPcumYsVPrHVmkgx0l3wzpKeIdWZ5NUY4M53Jy4h/KA4P9NDvoG149fDRe6Mqe6ve3Y+NQtTEm1fqIIgzNLHEU3lACZW/m+/MmQVkPdDQw+kGncLjM0gfJau9ZZvE+lhixLSl541t+OU5X+CkSXy63qRGPS+u0dkoAaNkawFrOuS140ZHuRBR9J1Lor/KrM3ikLCUGIuYNBRIAKbi2bDDP+5WeEzpd5qRBXWn3IrJapRcK3e4QUdbaZw8V8vTN/VhHyqU/AttFkscR5tn/TCvGJ85hfs/D1IDXJnw4P8WdOPfO4BCTpoYEwWfPutNZGiCjE3kWrUZVeumah4Bp3rrWUlWTIO0RfEv9VIRt2oIlZ/9werPnwbvvvrefjkYgKZgI++UEU0bhNpJWqBQAOs7nkYnadzXrTfyLrGfKr6+8x8wt13/vnDdtwe5bHVAFTA9Eoj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(36756003)(81166007)(40480700001)(2616005)(110136005)(336012)(40460700003)(316002)(41300700001)(54906003)(70206006)(26005)(6666004)(16526019)(82740400003)(478600001)(1076003)(426003)(7696005)(70586007)(86362001)(47076005)(36860700001)(356005)(2906002)(5660300002)(30864003)(33656002)(4326008)(83380400001)(8676002)(8936002)(921008)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 06:59:12.1602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbb4be3-d714-4d6f-f8e1-08dbd527e4cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rijo Thomas <Rijo-john.Thomas@amd.com>

Allocate shared memory using psp_tee_alloc_buffer(), and free shared
memory using psp_tee_free_buffer().

As part of cleanup, memory allocation using get_free_pages() is replaced
with DMA APIs.

Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Signed-off-by: Jeshwanth Kumar <JESHWANTHKUMAR.NK@amd.com>
---
 drivers/tee/amdtee/amdtee_private.h | 18 +++----
 drivers/tee/amdtee/call.c           | 74 +++++++++++++----------------
 drivers/tee/amdtee/core.c           | 72 +++++++++++++++++-----------
 drivers/tee/amdtee/shm_pool.c       | 21 ++------
 4 files changed, 89 insertions(+), 96 deletions(-)

diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
index 6d0f7062bb87..e2bb0a21942c 100644
--- a/drivers/tee/amdtee/amdtee_private.h
+++ b/drivers/tee/amdtee/amdtee_private.h
@@ -13,6 +13,7 @@
 #include <linux/kref.h>
 #include <linux/types.h>
 #include "amdtee_if.h"
+#include <linux/psp-tee.h>
 
 #define DRIVER_NAME	"amdtee"
 #define DRIVER_AUTHOR   "AMD-TEE Linux driver team"
@@ -78,19 +79,14 @@ struct amdtee_driver_data {
 	struct amdtee *amdtee;
 };
 
-struct shmem_desc {
-	void *kaddr;
-	u64 size;
-};
-
 /**
  * struct amdtee_shm_data - Shared memory data
- * @kaddr:	Kernel virtual address of shared memory
+ * @shm_buf:	Pointer to shared memory buffer
  * @buf_id:	Buffer id of memory mapped by TEE_CMD_ID_MAP_SHARED_MEM
  */
 struct amdtee_shm_data {
 	struct  list_head shm_node;
-	void    *kaddr;
+	struct	psp_tee_buffer *shm_buf;
 	u32     buf_id;
 };
 
@@ -145,11 +141,11 @@ int amdtee_invoke_func(struct tee_context *ctx,
 
 int amdtee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
 
-int amdtee_map_shmem(struct tee_shm *shm);
+int amdtee_alloc_shmem(struct tee_shm *shm);
 
-void amdtee_unmap_shmem(struct tee_shm *shm);
+void amdtee_free_shmem(struct tee_shm *shm);
 
-int handle_load_ta(void *data, u32 size,
+int handle_load_ta(struct psp_tee_buffer *buf,
 		   struct tee_ioctl_open_session_arg *arg);
 
 int handle_unload_ta(u32 ta_handle);
@@ -159,7 +155,7 @@ int handle_open_session(struct tee_ioctl_open_session_arg *arg, u32 *info,
 
 int handle_close_session(u32 ta_handle, u32 info);
 
-int handle_map_shmem(u32 count, struct shmem_desc *start, u32 *buf_id);
+int handle_map_shmem(struct psp_tee_buffer *shm_buf, u32 *buf_id);
 
 void handle_unmap_shmem(u32 buf_id);
 
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index e9b63dcb3194..031d37cc975c 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -283,53 +283,44 @@ int handle_invoke_cmd(struct tee_ioctl_invoke_arg *arg, u32 sinfo,
 	return ret;
 }
 
-int handle_map_shmem(u32 count, struct shmem_desc *start, u32 *buf_id)
+int handle_map_shmem(struct psp_tee_buffer *shm_buf, u32 *buf_id)
 {
 	struct tee_cmd_map_shared_mem *cmd;
-	phys_addr_t paddr;
-	int ret, i;
 	u32 status;
+	int ret;
 
-	if (!count || !start || !buf_id)
+	if (!shm_buf || !shm_buf->vaddr || !buf_id)
 		return -EINVAL;
 
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
 
-	/* Size must be page aligned */
-	for (i = 0; i < count ; i++) {
-		if (!start[i].kaddr || (start[i].size & (PAGE_SIZE - 1))) {
-			ret = -EINVAL;
-			goto free_cmd;
-		}
-
-		if ((u64)start[i].kaddr & (PAGE_SIZE - 1)) {
-			pr_err("map shared memory: page unaligned. addr 0x%llx",
-			       (u64)start[i].kaddr);
-			ret = -EINVAL;
-			goto free_cmd;
-		}
+	/* Size and address must be page aligned */
+	if (shm_buf->size & (PAGE_SIZE - 1)) {
+		ret = -EINVAL;
+		goto free_cmd;
 	}
 
-	cmd->sg_list.count = count;
-
-	/* Create buffer list */
-	for (i = 0; i < count ; i++) {
-		paddr = __psp_pa(start[i].kaddr);
-		cmd->sg_list.buf[i].hi_addr = upper_32_bits(paddr);
-		cmd->sg_list.buf[i].low_addr = lower_32_bits(paddr);
-		cmd->sg_list.buf[i].size = start[i].size;
-		cmd->sg_list.size += cmd->sg_list.buf[i].size;
-
-		pr_debug("buf[%d]:hi addr = 0x%x\n", i,
-			 cmd->sg_list.buf[i].hi_addr);
-		pr_debug("buf[%d]:low addr = 0x%x\n", i,
-			 cmd->sg_list.buf[i].low_addr);
-		pr_debug("buf[%d]:size = 0x%x\n", i, cmd->sg_list.buf[i].size);
-		pr_debug("list size = 0x%x\n", cmd->sg_list.size);
+	if ((u64)shm_buf->vaddr & (PAGE_SIZE - 1)) {
+		pr_err("map shared memory: page unaligned. addr 0x%llx",
+		       (u64)shm_buf->vaddr);
+		ret = -EINVAL;
+		goto free_cmd;
 	}
 
+	/* Update sg list */
+	cmd->sg_list.count = 1;
+	cmd->sg_list.buf[0].hi_addr = upper_32_bits(shm_buf->paddr);
+	cmd->sg_list.buf[0].low_addr = lower_32_bits(shm_buf->paddr);
+	cmd->sg_list.buf[0].size = shm_buf->size;
+	cmd->sg_list.size = cmd->sg_list.buf[0].size;
+
+	pr_debug("buf: hi addr = 0x%x\n", cmd->sg_list.buf[0].hi_addr);
+	pr_debug("buf: low addr = 0x%x\n", cmd->sg_list.buf[0].low_addr);
+	pr_debug("buf: size = 0x%x\n", cmd->sg_list.buf[0].size);
+	pr_debug("list size = 0x%x\n", cmd->sg_list.size);
+
 	*buf_id = 0;
 
 	ret = psp_tee_process_cmd(TEE_CMD_ID_MAP_SHARED_MEM, (void *)cmd,
@@ -396,25 +387,24 @@ int handle_open_session(struct tee_ioctl_open_session_arg *arg, u32 *info,
 	return ret;
 }
 
-int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
+int handle_load_ta(struct psp_tee_buffer *buf,
+		   struct tee_ioctl_open_session_arg *arg)
 {
 	struct tee_cmd_unload_ta unload_cmd = {};
 	struct tee_cmd_load_ta load_cmd = {};
-	phys_addr_t blob;
 	int ret;
 
-	if (size == 0 || !data || !arg)
+	if (buf->size == 0 || !buf->paddr || !arg)
 		return -EINVAL;
 
-	blob = __psp_pa(data);
-	if (blob & (PAGE_SIZE - 1)) {
-		pr_err("load TA: page unaligned. blob 0x%llx", blob);
+	if (buf->dma & (PAGE_SIZE - 1)) {
+		pr_err("load TA: page unaligned. addr 0x%llx", buf->dma);
 		return -EINVAL;
 	}
 
-	load_cmd.hi_addr = upper_32_bits(blob);
-	load_cmd.low_addr = lower_32_bits(blob);
-	load_cmd.size = size;
+	load_cmd.hi_addr = upper_32_bits(buf->paddr);
+	load_cmd.low_addr = lower_32_bits(buf->paddr);
+	load_cmd.size = buf->size;
 
 	mutex_lock(&ta_refcount_mutex);
 
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 3c15f6a9e91c..37784360fc10 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -17,6 +17,7 @@
 #include "amdtee_private.h"
 #include "../tee_private.h"
 #include <linux/psp-tee.h>
+#include <linux/psp.h>
 
 static struct amdtee_driver_data *drv_data;
 static DEFINE_MUTEX(session_list_mutex);
@@ -158,7 +159,8 @@ u32 get_buffer_id(struct tee_shm *shm)
 
 	mutex_lock(&ctxdata->shm_mutex);
 	list_for_each_entry(shmdata, &ctxdata->shm_list, shm_node)
-		if (shmdata->kaddr == shm->kaddr) {
+		if (shmdata->shm_buf &&
+		    shmdata->shm_buf->vaddr == shm->kaddr) {
 			buf_id = shmdata->buf_id;
 			break;
 		}
@@ -168,11 +170,13 @@ u32 get_buffer_id(struct tee_shm *shm)
 }
 
 static DEFINE_MUTEX(drv_mutex);
-static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
-			  size_t *ta_size)
+static int copy_ta_binary(struct tee_context *ctx, void *ptr,
+			  struct psp_tee_buffer **bufp)
 {
 	const struct firmware *fw;
 	char fw_name[TA_PATH_MAX];
+	struct psp_tee_buffer *buf;
+	unsigned long size;
 	struct {
 		u32 lo;
 		u16 mid;
@@ -201,15 +205,16 @@ static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
 		goto unlock;
 	}
 
-	*ta_size = roundup(fw->size, PAGE_SIZE);
-	*ta = (void *)__get_free_pages(GFP_KERNEL, get_order(*ta_size));
-	if (!*ta) {
-		pr_err("%s: get_free_pages failed\n", __func__);
+	size = roundup(fw->size, PAGE_SIZE);
+	buf = psp_tee_alloc_buffer(size, GFP_KERNEL);
+	if (!buf) {
+		pr_err("TA binary memory allocation failed\n");
 		rc = -ENOMEM;
 		goto rel_fw;
 	}
+	memcpy(buf->vaddr, fw->data, fw->size);
+	*bufp = buf;
 
-	memcpy(*ta, fw->data, fw->size);
 rel_fw:
 	release_firmware(fw);
 unlock:
@@ -234,24 +239,23 @@ int amdtee_open_session(struct tee_context *ctx,
 {
 	struct amdtee_context_data *ctxdata = ctx->data;
 	struct amdtee_session *sess = NULL;
+	struct psp_tee_buffer *buf;
 	u32 session_info, ta_handle;
-	size_t ta_size;
 	int rc, i;
-	void *ta;
 
 	if (arg->clnt_login != TEE_IOCTL_LOGIN_PUBLIC) {
 		pr_err("unsupported client login method\n");
 		return -EINVAL;
 	}
 
-	rc = copy_ta_binary(ctx, &arg->uuid[0], &ta, &ta_size);
+	rc = copy_ta_binary(ctx, &arg->uuid[0], &buf);
 	if (rc) {
 		pr_err("failed to copy TA binary\n");
 		return rc;
 	}
 
 	/* Load the TA binary into TEE environment */
-	handle_load_ta(ta, ta_size, arg);
+	handle_load_ta(buf, arg);
 	if (arg->ret != TEEC_SUCCESS)
 		goto out;
 
@@ -298,7 +302,7 @@ int amdtee_open_session(struct tee_context *ctx,
 	}
 
 out:
-	free_pages((u64)ta, get_order(ta_size));
+	psp_tee_free_buffer(buf);
 	return rc;
 }
 
@@ -338,51 +342,62 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
 	return 0;
 }
 
-int amdtee_map_shmem(struct tee_shm *shm)
+int amdtee_alloc_shmem(struct tee_shm *shm)
 {
 	struct amdtee_context_data *ctxdata;
 	struct amdtee_shm_data *shmnode;
-	struct shmem_desc shmem;
-	int rc, count;
+	struct psp_tee_buffer *shm_buf;
 	u32 buf_id;
+	int rc;
 
 	if (!shm)
 		return -EINVAL;
 
-	shmnode = kmalloc(sizeof(*shmnode), GFP_KERNEL);
-	if (!shmnode)
+	shm_buf = psp_tee_alloc_buffer(shm->size, GFP_KERNEL | __GFP_ZERO);
+	if (!shm_buf)
 		return -ENOMEM;
 
-	count = 1;
-	shmem.kaddr = shm->kaddr;
-	shmem.size = shm->size;
+	shm->kaddr = shm_buf->vaddr;
+	shm->paddr = __psp_pa(shm_buf->vaddr);
+
+	shmnode = kmalloc(sizeof(*shmnode), GFP_KERNEL);
+	if (!shmnode) {
+		rc = -ENOMEM;
+		goto free_dmabuf;
+	}
 
 	/*
 	 * Send a MAP command to TEE and get the corresponding
 	 * buffer Id
 	 */
-	rc = handle_map_shmem(count, &shmem, &buf_id);
+	rc = handle_map_shmem(shm_buf, &buf_id);
 	if (rc) {
 		pr_err("map_shmem failed: ret = %d\n", rc);
-		kfree(shmnode);
-		return rc;
+		goto free_shmnode;
 	}
 
-	shmnode->kaddr = shm->kaddr;
+	shmnode->shm_buf = shm_buf;
 	shmnode->buf_id = buf_id;
 	ctxdata = shm->ctx->data;
 	mutex_lock(&ctxdata->shm_mutex);
 	list_add(&shmnode->shm_node, &ctxdata->shm_list);
 	mutex_unlock(&ctxdata->shm_mutex);
 
-	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shmnode->kaddr);
+	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shm->kaddr);
 
 	return 0;
+
+free_shmnode:
+	kfree(shmnode);
+free_dmabuf:
+	psp_tee_free_buffer(shm_buf);
+	return rc;
 }
 
-void amdtee_unmap_shmem(struct tee_shm *shm)
+void amdtee_free_shmem(struct tee_shm *shm)
 {
 	struct amdtee_context_data *ctxdata;
+	struct psp_tee_buffer *shm_buf = NULL;
 	struct amdtee_shm_data *shmnode;
 	u32 buf_id;
 
@@ -390,6 +405,7 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
 		return;
 
 	buf_id = get_buffer_id(shm);
+
 	/* Unmap the shared memory from TEE */
 	handle_unmap_shmem(buf_id);
 
@@ -398,10 +414,12 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
 	list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
 		if (buf_id == shmnode->buf_id) {
 			list_del(&shmnode->shm_node);
+			shm_buf = shmnode->shm_buf;
 			kfree(shmnode);
 			break;
 		}
 	mutex_unlock(&ctxdata->shm_mutex);
+	psp_tee_free_buffer(shm_buf);
 }
 
 int amdtee_invoke_func(struct tee_context *ctx,
diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
index f0303126f199..443874c82611 100644
--- a/drivers/tee/amdtee/shm_pool.c
+++ b/drivers/tee/amdtee/shm_pool.c
@@ -12,25 +12,13 @@ static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 			 size_t size, size_t align)
 {
 	unsigned int order = get_order(size);
-	unsigned long va;
 	int rc;
 
-	/*
-	 * Ignore alignment since this is already going to be page aligned
-	 * and there's no need for any larger alignment.
-	 */
-	va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!va)
-		return -ENOMEM;
-
-	shm->kaddr = (void *)va;
-	shm->paddr = __psp_pa((void *)va);
 	shm->size = PAGE_SIZE << order;
 
-	/* Map the allocated memory in to TEE */
-	rc = amdtee_map_shmem(shm);
+	/* Allocate and map memory in to TEE */
+	rc = amdtee_alloc_shmem(shm);
 	if (rc) {
-		free_pages(va, order);
 		shm->kaddr = NULL;
 		return rc;
 	}
@@ -41,8 +29,9 @@ static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
 {
 	/* Unmap the shared memory from TEE */
-	amdtee_unmap_shmem(shm);
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	amdtee_free_shmem(shm);
+
+	shm->size = 0;
 	shm->kaddr = NULL;
 }
 
-- 
2.25.1

