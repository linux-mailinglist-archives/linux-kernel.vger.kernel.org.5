Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70C07D61F8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjJYG6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjJYG6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:58:51 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3FEE5;
        Tue, 24 Oct 2023 23:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DY/rLGfaAldoLd5TDMjyusvRklYrj76nH6dWJ6T/xv96Txd/C8lRlt7QGtdX73oJyXTizMyEKWYLiQnXHhsPmXZnJLkSClS98hSU8MnpQ9NkML17tJmMfetRn410rvgp8tXTxgRUqYXehrRpj37/aWkibK5pSGcGwejs2q3Fld/TZ6GMIKGAgyVUYhNw8DLzpKxRp2nsq7J9inwgJvhD/lAsyltrXW6cAVRKoGJUUVpzD0NkSN0upevOCvw/pUbkzVIFEADDUqg5nSQ/aoG5uMZ5eB46vGHiTitvx7ls+cdrTlbRmhbupQbJtmiXFYB0RdE98eDBH8qdbDDIjOEXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpPqxzFrMsGd0rMhy7IXXJMM0Knb6koQRRjT+R8AQrI=;
 b=oGv/gosO1GcoyMxX+4y8uboH3LXiX3BH+sgdKZM3w0A0ZuFx4miZFGD8MSln+6fTDtDzAN+ocVtzGKOJVKNRfyR8FuxUVPZ2torITtVwQSeofXTV5L9JS8no1qR700CT5wAvesAUUKVdYMPp/eGFtStvWkMwSUVYg3GIfqRH3osafpMWDS8tAIv/9xieYzEwZg1zmtBfiuaOUpZaGcW29PajPXQbM8lnl9C++xmC4gniIuh3/BFUTBt/OaH0EDxKvDXxqcbJeA2BrthhyP4vkCF/H+jpEGPorHPNm1oSLGctD9WmjBdYlE9dKCVQfP8JFAHTV4edmP9SoHXlsYYwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpPqxzFrMsGd0rMhy7IXXJMM0Knb6koQRRjT+R8AQrI=;
 b=qd8F9x10wb0hDiPBA+rlWjFpC+SjFDr+rUIhGQZOSVFcv8IAXWzY+CQJcowPfHLWIZHPaCJH4STo7CBe/ADwwVZMml6zTz+oeL6mFkENh46e3U7GfHk18mA/zOK2iZqaXet7ZR57zx99v6sCAycShGpm/OuCE7IcMUEGQhSG4JY=
Received: from PH8PR07CA0045.namprd07.prod.outlook.com (2603:10b6:510:2cf::14)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.29; Wed, 25 Oct 2023 06:58:45 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::dd) by PH8PR07CA0045.outlook.office365.com
 (2603:10b6:510:2cf::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 06:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 06:58:45 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 01:58:40 -0500
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
Subject: [PATCH 2/3] crypto: ccp - Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
Date:   Wed, 25 Oct 2023 12:26:59 +0530
Message-ID: <20231025065700.1556152-3-JESHWANTHKUMAR.NK@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 0682c3f2-27d3-4cce-d66f-08dbd527d4a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhsN5jFGBwWExzppSRpU/me3ylvYLdhSgk3g6MIGbxpiSXJVEz948+N1oMAWvfSYYuFppScd7mb7w/Pa3EiYDCkUsDZPHuLSMUXM86dsi0Kvb8pkEaWJ1LOJFWIrTsOSM/PwVlPIyU7yMjRwytr/umdqyYHuOFlc2vuQnH88mWuJteHPd0NFP2roEhreP0IEkQP1WodH1WV/8Q8z3OLdlzcqKV3zLba+JN3W7dVKUEov86KqLM68FWd1eLi0LCakI9A9C74B1ekI1u+OvnZVGxc1yCGGDCk5/5KOqvWi+H9JoqKnJho7Ezx36/bXzzi5KiJNtyt+2Wce5bJViaRWCv4pk+jfrC2o6tKPx/KXQMdja/Y++LPFtb4IHCFuJ+pgJDYe98w+AfcG/bb+unePm/bq7omG9MHfXyXdcXdYufggLBG6iGIFTG2Y7egsMLhHQPkSLfGz7Fmul3zxjNT8aXUqvV2lIX0YGtMAzL0h+hWIA0ZJ9QpCY3yqDsjRsIfvezTGCpT9ffcsThyrJQNLE0OTbGg+6teCBl6J+rrQePHqGVtjUzho6EewOf91LvtfNULXTKDlyfzmxrgMQK6xozytKZzI/LeSdobGdROwVkGBVYd8DoYoQDTME1h9kClRiU0KDxmOS02wdvH6o943CdtDeNIiJwQ/4UN5TklRX0AMxO617DP5pBsNm+aciKtLuiWQJttwh/2xiYMdbsDH4LOKXvFOc55wYl4NPCTak6vu8wJB8pUwAQvlWYhSydikv2YV6gAg2yG6IbWV8G/acxWU1D1/sBZLaWgitg5CggSdFQ01Gi1ZsrZkw3WIPn6q
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(36860700001)(83380400001)(40480700001)(4326008)(5660300002)(6666004)(8936002)(110136005)(70586007)(86362001)(41300700001)(478600001)(7696005)(54906003)(70206006)(316002)(8676002)(36756003)(81166007)(2906002)(426003)(356005)(16526019)(2616005)(33656002)(1076003)(336012)(82740400003)(47076005)(26005)(921008)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 06:58:45.0470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0682c3f2-27d3-4cce-d66f-08dbd527d4a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rijo Thomas <Rijo-john.Thomas@amd.com>

Allocate TEE ring buffer and command buffer using
psp_tee_alloc_buffer(), and free TEE ring buffer and command buffer
using psp_tee_free_buffer().

As part of cleanup, memory allocation using get_free_pages() is replaced
with DMA APIs.

Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Co-developed-by: Jeshwanth Kumar <JESHWANTHKUMAR.NK@amd.com>
Signed-off-by: Jeshwanth Kumar <JESHWANTHKUMAR.NK@amd.com>
---
 drivers/crypto/ccp/tee-dev.c | 68 ++++++++++++++----------------------
 drivers/crypto/ccp/tee-dev.h | 11 +++---
 2 files changed, 31 insertions(+), 48 deletions(-)

diff --git a/drivers/crypto/ccp/tee-dev.c b/drivers/crypto/ccp/tee-dev.c
index fa6f89572613..f0a94191662d 100644
--- a/drivers/crypto/ccp/tee-dev.c
+++ b/drivers/crypto/ccp/tee-dev.c
@@ -76,22 +76,16 @@ EXPORT_SYMBOL(psp_tee_free_buffer);
 static int tee_alloc_ring(struct psp_tee_device *tee, int ring_size)
 {
 	struct ring_buf_manager *rb_mgr = &tee->rb_mgr;
-	void *start_addr;
 
 	if (!ring_size)
 		return -EINVAL;
 
-	/* We need actual physical address instead of DMA address, since
-	 * Trusted OS running on AMD Secure Processor will map this region
-	 */
-	start_addr = (void *)__get_free_pages(GFP_KERNEL, get_order(ring_size));
-	if (!start_addr)
+	rb_mgr->ring_buf = psp_tee_alloc_buffer(ring_size,
+						GFP_KERNEL | __GFP_ZERO);
+	if (!rb_mgr->ring_buf) {
+		dev_err(tee->dev, "ring allocation failed\n");
 		return -ENOMEM;
-
-	memset(start_addr, 0x0, ring_size);
-	rb_mgr->ring_start = start_addr;
-	rb_mgr->ring_size = ring_size;
-	rb_mgr->ring_pa = __psp_pa(start_addr);
+	}
 	mutex_init(&rb_mgr->mutex);
 
 	return 0;
@@ -101,15 +95,8 @@ static void tee_free_ring(struct psp_tee_device *tee)
 {
 	struct ring_buf_manager *rb_mgr = &tee->rb_mgr;
 
-	if (!rb_mgr->ring_start)
-		return;
+	psp_tee_free_buffer(rb_mgr->ring_buf);
 
-	free_pages((unsigned long)rb_mgr->ring_start,
-		   get_order(rb_mgr->ring_size));
-
-	rb_mgr->ring_start = NULL;
-	rb_mgr->ring_size = 0;
-	rb_mgr->ring_pa = 0;
 	mutex_destroy(&rb_mgr->mutex);
 }
 
@@ -133,35 +120,36 @@ static int tee_wait_cmd_poll(struct psp_tee_device *tee, unsigned int timeout,
 	return -ETIMEDOUT;
 }
 
-static
-struct tee_init_ring_cmd *tee_alloc_cmd_buffer(struct psp_tee_device *tee)
+struct psp_tee_buffer *tee_alloc_cmd_buffer(struct psp_tee_device *tee)
 {
 	struct tee_init_ring_cmd *cmd;
+	struct psp_tee_buffer *cmd_buffer;
 
-	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
-	if (!cmd)
+	cmd_buffer = psp_tee_alloc_buffer(sizeof(*cmd),
+					  GFP_KERNEL | __GFP_ZERO);
+	if (!cmd_buffer)
 		return NULL;
 
-	cmd->hi_addr = upper_32_bits(tee->rb_mgr.ring_pa);
-	cmd->low_addr = lower_32_bits(tee->rb_mgr.ring_pa);
-	cmd->size = tee->rb_mgr.ring_size;
+	cmd = (struct tee_init_ring_cmd *)cmd_buffer->vaddr;
+	cmd->hi_addr = upper_32_bits(tee->rb_mgr.ring_buf->paddr);
+	cmd->low_addr = lower_32_bits(tee->rb_mgr.ring_buf->paddr);
+	cmd->size = tee->rb_mgr.ring_buf->size;
 
 	dev_dbg(tee->dev, "tee: ring address: high = 0x%x low = 0x%x size = %u\n",
 		cmd->hi_addr, cmd->low_addr, cmd->size);
 
-	return cmd;
+	return cmd_buffer;
 }
 
-static inline void tee_free_cmd_buffer(struct tee_init_ring_cmd *cmd)
+static inline void tee_free_cmd_buffer(struct psp_tee_buffer *cmd_buffer)
 {
-	kfree(cmd);
+	psp_tee_free_buffer(cmd_buffer);
 }
 
 static int tee_init_ring(struct psp_tee_device *tee)
 {
 	int ring_size = MAX_RING_BUFFER_ENTRIES * sizeof(struct tee_ring_cmd);
-	struct tee_init_ring_cmd *cmd;
-	phys_addr_t cmd_buffer;
+	struct psp_tee_buffer *cmd_buffer;
 	unsigned int reg;
 	int ret;
 
@@ -175,21 +163,19 @@ static int tee_init_ring(struct psp_tee_device *tee)
 
 	tee->rb_mgr.wptr = 0;
 
-	cmd = tee_alloc_cmd_buffer(tee);
-	if (!cmd) {
+	cmd_buffer = tee_alloc_cmd_buffer(tee);
+	if (!cmd_buffer) {
 		tee_free_ring(tee);
 		return -ENOMEM;
 	}
 
-	cmd_buffer = __psp_pa((void *)cmd);
-
 	/* Send command buffer details to Trusted OS by writing to
 	 * CPU-PSP message registers
 	 */
 
-	iowrite32(lower_32_bits(cmd_buffer),
+	iowrite32(lower_32_bits(cmd_buffer->paddr),
 		  tee->io_regs + tee->vdata->cmdbuff_addr_lo_reg);
-	iowrite32(upper_32_bits(cmd_buffer),
+	iowrite32(upper_32_bits(cmd_buffer->paddr),
 		  tee->io_regs + tee->vdata->cmdbuff_addr_hi_reg);
 	iowrite32(TEE_RING_INIT_CMD,
 		  tee->io_regs + tee->vdata->cmdresp_reg);
@@ -209,7 +195,7 @@ static int tee_init_ring(struct psp_tee_device *tee)
 	}
 
 free_buf:
-	tee_free_cmd_buffer(cmd);
+	tee_free_cmd_buffer(cmd_buffer);
 
 	return ret;
 }
@@ -219,7 +205,7 @@ static void tee_destroy_ring(struct psp_tee_device *tee)
 	unsigned int reg;
 	int ret;
 
-	if (!tee->rb_mgr.ring_start)
+	if (!tee->rb_mgr.ring_buf->vaddr)
 		return;
 
 	if (psp_dead)
@@ -308,7 +294,7 @@ static int tee_submit_cmd(struct psp_tee_device *tee, enum tee_cmd_id cmd_id,
 	do {
 		/* Get pointer to ring buffer command entry */
 		cmd = (struct tee_ring_cmd *)
-			(tee->rb_mgr.ring_start + tee->rb_mgr.wptr);
+			(tee->rb_mgr.ring_buf->vaddr + tee->rb_mgr.wptr);
 
 		rptr = ioread32(tee->io_regs + tee->vdata->ring_rptr_reg);
 
@@ -357,7 +343,7 @@ static int tee_submit_cmd(struct psp_tee_device *tee, enum tee_cmd_id cmd_id,
 
 	/* Update local copy of write pointer */
 	tee->rb_mgr.wptr += sizeof(struct tee_ring_cmd);
-	if (tee->rb_mgr.wptr >= tee->rb_mgr.ring_size)
+	if (tee->rb_mgr.wptr >= tee->rb_mgr.ring_buf->size)
 		tee->rb_mgr.wptr = 0;
 
 	/* Trigger interrupt to Trusted OS */
diff --git a/drivers/crypto/ccp/tee-dev.h b/drivers/crypto/ccp/tee-dev.h
index 49d26158b71e..0e4398d15f93 100644
--- a/drivers/crypto/ccp/tee-dev.h
+++ b/drivers/crypto/ccp/tee-dev.h
@@ -16,6 +16,7 @@
 
 #include <linux/device.h>
 #include <linux/mutex.h>
+#include <linux/psp-tee.h>
 
 #define TEE_DEFAULT_TIMEOUT		10
 #define MAX_BUFFER_SIZE			988
@@ -48,17 +49,13 @@ struct tee_init_ring_cmd {
 
 /**
  * struct ring_buf_manager - Helper structure to manage ring buffer.
- * @ring_start:  starting address of ring buffer
- * @ring_size:   size of ring buffer in bytes
- * @ring_pa:     physical address of ring buffer
  * @wptr:        index to the last written entry in ring buffer
+ * @ring_buf:    ring buffer allocated using DMA api
  */
 struct ring_buf_manager {
-	struct mutex mutex;	/* synchronizes access to ring buffer */
-	void *ring_start;
-	u32 ring_size;
-	phys_addr_t ring_pa;
+	struct mutex mutex;    /* synchronizes access to ring buffer */
 	u32 wptr;
+	struct psp_tee_buffer *ring_buf;
 };
 
 struct psp_tee_device {
-- 
2.25.1

