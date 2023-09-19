Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092E97A69C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjISRmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjISRmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:42:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C17FC125
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 982A0C15;
        Tue, 19 Sep 2023 10:42:16 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D05A3F5A1;
        Tue, 19 Sep 2023 10:41:38 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:41:05 +0100
Subject: [PATCH RFT v2 17/18] firmware: arm_ffa: Update memory descriptor
 to support v1.1 format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-17-6f3a3ca3923c@arm.com>
References: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
In-Reply-To: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4060; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=/Ov5NW0RpBVvf5EftQkzohgGykDRR0+VeA9B3BekVss=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd08W0FeRpT843CWRqoq7omYR56V8rmCs6AGc
 Thxt80Vq66JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndPAAKCRAAQbq8MX7i
 mEhZEACEzIZMM+k6Nv/xNDhe1gkAmJX9WABGLWCIiwyJHnvXpc2Y2B0jMPbdEnNSW3GezwrAv6V
 fOkEuMAZn8ED+GMSMkCIBFTyeWTBqEv4yLGlmjPJAeNxiw8OE/RGILNyhpT9LndMBn3OfpIVLPF
 r71/y4iQnPKoRnF0+fTyuvkZEwlXEPeqiIJNFAjrefwsctSE2OjPCmLwWJayWPNcvkSz/+nDrJJ
 FpzjCSgRRhs79jlnuiABgMBqHrZr4d2i1Ec1EkErVY5wPMtUsc8vg41HB/deoPb/aGvhEaBLUO6
 X7IyBCPWsmMFRQPsRqqgKtB693LIHsWEI5PGqVG6rEqTo+Y2S7kYAV1mJQKBC3fd3SdD7o8l+2f
 7ap6RcHPiKQnCXSLjy3LpUbuB1T4CGJ9o9IrHpdSAZjovoFDTwsXEZFHy/U4GoPujkGXzX8UDo1
 TE4yt9pcHf4wXB6QvQMeX4PP0wkT5FZ2OoC30AN9Aj1Ech8JocyVp5GGRhAZBZFtakiVq+2MNHN
 7I6YhRfmkqJd8CGct2KiyHulAkLUSiuYIsa1eMj9ftO89gF+rlsXfZEKTNPEraq6+9t8P0OlGr9
 2N7zabEPQeCbzh7yv/l8QjzkNJ3Uh1Fz7evC0zjNJ88I0MxXk4iSLLBtgL6elP6PSTMpvjkXrhc
 bb+u0RexRjEUAog==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/arm_ffa.h           | 30 +++++++++++++++++++-----------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index e0a0c7cedd90..e18f0b125d46 100644
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
index 7be240e37f36..2a0d4b28245a 100644
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
@@ -337,30 +337,38 @@ struct ffa_mem_region {
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
+	/*
+	 * Earlier to v1.1, the endpoint memory descriptor array started at
+	 * offset 32(i.e. offset of ep_mem_offset itself)
+	 */
+	if (mem_desc_v1)
+		return offsetof(struct ffa_mem_region, ep_mem_offset) +
+			(count * sizeof(struct ffa_mem_region_attributes));
+	else
+		return buf->ep_mem_offset + count * buf->ep_mem_size;
 }
 
 struct ffa_mem_ops_args {

-- 
2.42.0

