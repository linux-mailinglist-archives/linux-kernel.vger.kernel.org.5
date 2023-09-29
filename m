Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AE47B364B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjI2PEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjI2PDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0C2E1B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F4AA1FB;
        Fri, 29 Sep 2023 08:04:12 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2884C3F5A1;
        Fri, 29 Sep 2023 08:03:33 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:03:05 +0100
Subject: [PATCH v3 16/17] firmware: arm_ffa: Update memory descriptor to
 support v1.1 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-16-c8e4f15190c8@arm.com>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
In-Reply-To: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4081; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=WhdrDVZNbm/z1aM3IcsKqTU6ZT3SC2M0eEn3tH9qkZc=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucwbXjAQ8dzp00ZxFqLBv0AqMokTo704J+fB
 rmuIA6oMUWJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnMAAKCRAAQbq8MX7i
 mBMUEACmH/uqQzGyBRet5JKTbwTcgVI1Vo2373bNgX4uPpmlDE4Oyfy+ai6exmpC4duHMn5NjWy
 i42VWuu5z2HlnqrcSUiVglmYkyKzLygQeslDAAZOn6vXpnu07OCRUm/F/JS9H44XQPLEegaYMKw
 Y7aFIyEIKe9Uqx+9VOAJ0P7HElKSxc5rq3sd8TI9OMfhgW7hNf5o4/0E9qaL0AUhtlM+TOAAKvk
 VgERES5cvrmMCvrB0wzrwDwe/+V9gIBPkVziTJtWHAwn9sGGS66DWfSOFTxcfjVaJIJ+jkpWbfd
 KYCNr3KA4RkzhW3ZigXoqoz1oi/iT0uvkayAfCa9VSmr00sXXmV5YUNuOctmTQQ87jqF5iekLvW
 0ELWwJIj4Hl+f5ExhN6YTOYFpDBFgreJvHjCWbd41gBOg578VNODsKR2teY+VaJoXgUDhqQEr0T
 yqz5NcyQ+CorJBGlHdAnv0RVkXvXf5EorbzZM8RHAiHDPUg7D6ggpa/2Bb2WqMYy5xfWWgzLLM1
 KF9tdwtKVjXA4HtBsSsqBIx3YbDroWv+dng6o8gUxjTpebBI8aONSt7j9WXBaJWmttINxcjhFi5
 gSn3EwpPWAy6JevYs5nPGl+XxuILkJHTVw1aPev7xiH5WHhpFpOl1YXrAiHc7Dyigcf5EnmculJ
 p3Pf60Ckmccnwqg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update memory transaction descriptor structure to accommodate couple of
new entries in v1.1 which were previously marked reserved and MBZ(must
be zero).

It also removes the flexible array member ep_mem_access in the memory
transaction descriptor structure as it need not be at fixed offset.
Also update ffa_mem_desc_offset() accessor to handle both old and new
formats of memory transaction descriptors.

The updates ffa_mem_region structure aligns with new format in v1.1 and
hence the driver/user must take care not to use members beyond and
including ep_mem_offset when using the old format.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 11 ++++++++---
 include/linux/arm_ffa.h           | 32 +++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index ef7011c86d60..0168e69c495d 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -424,7 +424,7 @@ static u32 ffa_get_num_pages_sg(struct scatterlist *sg)
 	return num_pages;
 }
 
-static u8 ffa_memory_attributes_get(u32 func_id)
+static u16 ffa_memory_attributes_get(u32 func_id)
 {
 	/*
 	 * For the memory lend or donate operation, if the receiver is a PE or
@@ -467,9 +467,14 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		ep_mem_access->reserved = 0;
 	}
 	mem_region->handle = 0;
-	mem_region->reserved_0 = 0;
-	mem_region->reserved_1 = 0;
 	mem_region->ep_count = args->nattrs;
+	if (mdesc_v1) {
+		mem_region->ep_mem_size = 0;
+	} else {
+		mem_region->ep_mem_size = sizeof(*ep_mem_access);
+		mem_region->ep_mem_offset = sizeof(*mem_region);
+		memset(mem_region->reserved, 0, 12);
+	}
 
 	composite = buffer + composite_offset;
 	composite->total_pg_cnt = ffa_get_num_pages_sg(args->sg);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 7be240e37f36..f3adba0ef6c6 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -298,8 +298,8 @@ struct ffa_mem_region {
 #define FFA_MEM_NON_SHAREABLE	(0)
 #define FFA_MEM_OUTER_SHAREABLE	(2)
 #define FFA_MEM_INNER_SHAREABLE	(3)
-	u8 attributes;
-	u8 reserved_0;
+	/* Memory region attributes, upper byte MBZ pre v1.1 */
+	u16 attributes;
 /*
  * Clear memory region contents after unmapping it from the sender and
  * before mapping it for any receiver.
@@ -337,30 +337,40 @@ struct ffa_mem_region {
 	 * memory region.
 	 */
 	u64 tag;
-	u32 reserved_1;
+	/* Size of each endpoint memory access descriptor, MBZ pre v1.1 */
+	u32 ep_mem_size;
 	/*
 	 * The number of `ffa_mem_region_attributes` entries included in this
 	 * transaction.
 	 */
 	u32 ep_count;
 	/*
-	 * An array of endpoint memory access descriptors.
-	 * Each one specifies a memory region offset, an endpoint and the
-	 * attributes with which this memory region should be mapped in that
-	 * endpoint's page table.
+	 * 16-byte aligned offset from the base address of this descriptor
+	 * to the first element of the endpoint memory access descriptor array
+	 * Valid only from v1.1
 	 */
-	struct ffa_mem_region_attributes ep_mem_access[];
+	u32 ep_mem_offset;
+	/* MBZ, valid only from v1.1 */
+	u32 reserved[3];
 };
 
-#define	COMPOSITE_OFFSET(x)	\
-	(offsetof(struct ffa_mem_region, ep_mem_access[x]))
 #define CONSTITUENTS_OFFSET(x)	\
 	(offsetof(struct ffa_composite_mem_region, constituents[x]))
 
 static inline u32
 ffa_mem_desc_offset(struct ffa_mem_region *buf, int count, bool mem_desc_v1)
 {
-	return COMPOSITE_OFFSET(0);
+	u32 offset = count * sizeof(struct ffa_mem_region_attributes);
+	/*
+	 * Earlier to v1.1, the endpoint memory descriptor array started at
+	 * offset 32(i.e. offset of ep_mem_offset itself)
+	 */
+	if (mem_desc_v1)
+		offset += offsetof(struct ffa_mem_region, ep_mem_offset);
+	else
+		offset += sizeof(struct ffa_mem_region);
+
+	return offset;
 }
 
 struct ffa_mem_ops_args {

-- 
2.42.0

