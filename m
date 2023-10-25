Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0807D61F6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjJYG6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:58:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC7DA6;
        Tue, 24 Oct 2023 23:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaQgKTLFjTaxWVhHLqBFY4Wsfwl1ycsAR3sROzLdPk1pyICpk/4ysJyp8524481LQIvnC32nRGAJWgnJ8nad+m9EUM8QYgaEbi77Wv3UQJLiMvf2+GQV5Cc1Yl9njc2IuCsog0gDmYEbauBwS2T8WeFBxIB3iLH4gzmSOc88ZCYt41nbujmSqhXwM1c7xWbNnMlc/bqAXy+zIj2Be4IXKJGXarNVqeag5QDTZvTFb/2d6gv4dlC4BtocSF2GWBcOhLkPRhQIwOgkv81IEPCHLaLV4KfbZoSG2ciZ++oR3K73YF+gSl3NnNYPYWCELojHWC8f4qaNY5lM2YEutQUcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fwrn8dKMKw7WhQRwXNC8o5ckt/libmcUL2aCAWLLU/Y=;
 b=eDb7cV7NU+9V2qJoSGC+DavlTJ7yyXDXkp03Y/pk7KBSi3YaswZBeDzGnfJbEegYWrO9geBCx0JbcrNQQ/RN49h8oguOGWBJZAJXvo57lEXOYSt8OjpBqxmuItCNWxe8CNv9uKN3xIbyuwnIfZxBvpbCqg3wFTeucyXcn2Vy9u2eZyvSXRcwRhq9Gq/pp2BUdIFfEqhYvGY2FpQbgZq8Rjqf1QsbOlgkh9IiD6/217pUuT+GPx5m+PvIKEmuzvDdGGezv0So5m1wYJSNc4P1NavVO5Hr/QpSTband9LYN1F/PLLxj4gCMKdG7BKwnZRPiTVsTEEWm9CXMJQ+ot3xvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fwrn8dKMKw7WhQRwXNC8o5ckt/libmcUL2aCAWLLU/Y=;
 b=2Km2fDoyBWtUkL34eH7T7QPVFgh7JQPFZaDfRg1tpKyIovkL0V8VKtHUIOAV8cREMLyruL00qMR+D/82L+3URb/rQhzfUmGo4NXah2JmAPh56ofmno1HzNwVjaj4XkEpmr8yQgUcL5c5mQQRSFARMeeKMXaeAMAMP9YbPb5lNng=
Received: from PH0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:510:5::30)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 06:58:23 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::5e) by PH0PR07CA0025.outlook.office365.com
 (2603:10b6:510:5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 06:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 06:58:21 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 01:58:16 -0500
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
Subject: [PATCH 1/3] crypto: ccp - Add function to allocate and free memory using DMA APIs
Date:   Wed, 25 Oct 2023 12:26:58 +0530
Message-ID: <20231025065700.1556152-2-JESHWANTHKUMAR.NK@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4894d7-6a4c-4782-7707-08dbd527c691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SC+CKHgEMux7l6LzqmvJRAvhTkdTo0L0jnD5YPQS8IWoVkIvaBMXWB8aNLs5krUWRUL/DrWx6821O0v8bQGhyLwUAcokV7L7UxEAmPcRKpq2dj9LCIqnr/H1ozdtrAsoC4Z1S5aDq3vn0QoM8hfeZZukuAuAmGb4RDNxPmG+fscJeBl4rzq0fB8imAHZBfHF5CFrtJfSo4/oar7nTSZwuizO3RlN/7OD8ZXR3AGmxjxeaWtSjofNjZQM2N+dm6v3EMzkbaHQjjYMAJTlhX2zRT2i8KwabaNfbhwyDqkC9kA9sWyW3z+6OtNMMpK2TG0WmjfySSqja4b3toO48LwkdTb+0jEAANL0OoEnYy27RKvAUoaR76vwcB/Ij2VympJR0RbGJ9uGB0JWnxaF5ztnskxfA5FOMv+Fe5DKgMdYqAe4wUT/i+HjzeG+lbzpF1+XhGPVc9F4XhCuqQT2bB23qMLagT0Th40ggYSaA03N0lpqpOe+Btt40xK/2kUvsv4nrD8lpPHJEBi8Z4XNwkZW35M6OothrPKf2ohDO5auhp2Gu3ltlXwqisN3/UhcBOMmaKTBHaq5cmPOJCK6CLK8l/if8w2KDkzR7C3UNhI8n0sbvLc9eefRfmYpVGzBec37KYpjv7//p4WglrKaNENILK98Pmw+NXhX+Qi3dk/lfzF4pvRRk/Di197H7zP8DgnauUfwkRWRPqk+a9ecW/DuO4zBuIduesj8BcDrR4o4xjDB1xlQsjhLq6EyLtjxR6wws6bfdhQWExwaCM7BuA9YXBfTk0Wzf3QxAk8/KxeZJhgopVoc67EtFt3vwaBFVcgb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(41300700001)(40460700003)(2906002)(81166007)(70206006)(54906003)(82740400003)(6666004)(16526019)(478600001)(7696005)(356005)(47076005)(40480700001)(336012)(426003)(83380400001)(110136005)(86362001)(36756003)(33656002)(5660300002)(2616005)(36860700001)(1076003)(8676002)(4326008)(8936002)(70586007)(921008)(26005)(316002)(66899024)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 06:58:21.4294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4894d7-6a4c-4782-7707-08dbd527c691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
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

As part of cleanup, memory allocation using get_free_pages() is replaced
with DMA APIs.

psp_tee_alloc_buffer() and psp_tee_free_buffer() has been introduced, so
that DMA address can be shared with PSP Trusted OS for buffer mapping.
In the presence of IOMMU, the address will be an IOVA. So, it must be
converted into a physical address before sharing it with PSP Trusted OS.

Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Signed-off-by: Jeshwanth Kumar <JESHWANTHKUMAR.NK@amd.com>
---
 drivers/crypto/ccp/psp-dev.c |  3 +++
 drivers/crypto/ccp/tee-dev.c | 51 ++++++++++++++++++++++++++++++++++++
 include/linux/psp-tee.h      | 47 +++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index d42d7bc62352..049954d9984b 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -163,6 +163,9 @@ int psp_dev_init(struct sp_device *sp)
 		goto e_err;
 	}
 
+	if (sp->set_psp_master_device)
+		sp->set_psp_master_device(sp);
+
 	psp->io_regs = sp->io_map;
 
 	ret = psp_get_capability(psp);
diff --git a/drivers/crypto/ccp/tee-dev.c b/drivers/crypto/ccp/tee-dev.c
index 5560bf8329a1..fa6f89572613 100644
--- a/drivers/crypto/ccp/tee-dev.c
+++ b/drivers/crypto/ccp/tee-dev.c
@@ -13,6 +13,8 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/dma-direct.h>
+#include <linux/iommu.h>
 #include <linux/gfp.h>
 #include <linux/psp.h>
 #include <linux/psp-tee.h>
@@ -22,6 +24,55 @@
 
 static bool psp_dead;
 
+struct psp_tee_buffer *psp_tee_alloc_buffer(unsigned long size, gfp_t gfp)
+{
+	struct psp_device *psp = psp_get_master_device();
+	struct psp_tee_buffer *tee_buf;
+	struct iommu_domain *dom;
+
+	if (!psp || !size)
+		return NULL;
+
+	tee_buf = kzalloc(sizeof(*tee_buf), GFP_KERNEL);
+	if (!tee_buf)
+		return NULL;
+
+	tee_buf->vaddr = dma_alloc_coherent(psp->dev, size, &tee_buf->dma, gfp);
+	if (!tee_buf->vaddr || !tee_buf->dma) {
+		kfree(tee_buf);
+		return NULL;
+	}
+
+	tee_buf->size = size;
+
+	/* Check whether IOMMU is present. If present, translate IOVA
+	 * to physical address, else the dma handle is the physical
+	 * address.
+	 */
+	dom = iommu_get_domain_for_dev(psp->dev);
+	if (dom)
+		tee_buf->paddr = iommu_iova_to_phys(dom, tee_buf->dma);
+	else
+		tee_buf->paddr = tee_buf->dma;
+
+	return tee_buf;
+}
+EXPORT_SYMBOL(psp_tee_alloc_buffer);
+
+void psp_tee_free_buffer(struct psp_tee_buffer *tee_buf)
+{
+	struct psp_device *psp = psp_get_master_device();
+
+	if (!psp || !tee_buf)
+		return;
+
+	dma_free_coherent(psp->dev, tee_buf->size,
+			  tee_buf->vaddr, tee_buf->dma);
+
+	kfree(tee_buf);
+}
+EXPORT_SYMBOL(psp_tee_free_buffer);
+
 static int tee_alloc_ring(struct psp_tee_device *tee, int ring_size)
 {
 	struct ring_buf_manager *rb_mgr = &tee->rb_mgr;
diff --git a/include/linux/psp-tee.h b/include/linux/psp-tee.h
index cb0c95d6d76b..c3db3f33d069 100644
--- a/include/linux/psp-tee.h
+++ b/include/linux/psp-tee.h
@@ -40,6 +40,20 @@ enum tee_cmd_id {
 	TEE_CMD_ID_UNMAP_SHARED_MEM,
 };
 
+/**
+ * struct psp_tee_buffer - Structure of a TEE buffer shared with PSP.
+ * @dma:    DMA buffer address
+ * @paddr:  Physical address of DMA buffer
+ * @vaddr:  CPU virtual address of DMA buffer
+ * @size:   Size of DMA buffer in bytes
+ */
+struct psp_tee_buffer {
+	dma_addr_t dma;
+	phys_addr_t paddr;
+	void *vaddr;
+	unsigned long size;
+};
+
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 /**
  * psp_tee_process_cmd() - Process command in Trusted Execution Environment
@@ -75,6 +89,28 @@ int psp_tee_process_cmd(enum tee_cmd_id cmd_id, void *buf, size_t len,
  */
 int psp_check_tee_status(void);
 
+/**
+ * psp_tee_alloc_buffer() - Allocates memory of requested size and flags using
+ * dma_alloc_coherent() API.
+ *
+ * This function can be used to allocate a shared memory region between the
+ * host and PSP TEE.
+ *
+ * Returns:
+ * non-NULL   a valid pointer to struct psp_tee_buffer
+ * NULL       on failure
+ */
+struct psp_tee_buffer *psp_tee_alloc_buffer(unsigned long size, gfp_t gfp);
+
+/**
+ * psp_tee_free_buffer() - Deallocates memory using dma_free_coherent() API.
+ *
+ * This function can be used to release shared memory region between host
+ * and PSP TEE.
+ *
+ */
+void psp_tee_free_buffer(struct psp_tee_buffer *tee_buffer);
+
 #else /* !CONFIG_CRYPTO_DEV_SP_PSP */
 
 static inline int psp_tee_process_cmd(enum tee_cmd_id cmd_id, void *buf,
@@ -87,5 +123,16 @@ static inline int psp_check_tee_status(void)
 {
 	return -ENODEV;
 }
+
+static inline
+struct psp_tee_buffer *psp_tee_alloc_buffer(unsigned long size, gfp_t gfp)
+{
+	return NULL;
+}
+
+static inline void psp_tee_free_buffer(struct psp_tee_buffer *tee_buffer)
+{
+}
+
 #endif /* CONFIG_CRYPTO_DEV_SP_PSP */
 #endif /* __PSP_TEE_H_ */
-- 
2.25.1

