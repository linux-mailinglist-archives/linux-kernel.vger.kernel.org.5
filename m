Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F079D7A69C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjISRmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjISRlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 701C5188
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 748B01FB;
        Tue, 19 Sep 2023 10:42:11 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F3E53F5A1;
        Tue, 19 Sep 2023 10:41:32 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:41:01 +0100
Subject: [PATCH RFT v2 13/18] firmware: arm_ffa: Don't set the memory
 region attributes for MEM_LEND
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-13-6f3a3ca3923c@arm.com>
References: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
In-Reply-To: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
Cc:     Joao Alves <joao.alves@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=ZvoeIZd0Pqo3Ya9dsPGQ9xQvguOm3+9Cq7nXLi0CZSc=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd08kfIH+2N9tA2KqxNb8BJD9kXW6U1ibgai8
 /fPN9BWhQeJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndPAAKCRAAQbq8MX7i
 mHf8EADWH21kGXFn2PLOkKMHCj83izRmm0b2DUKYAsLKj4jJSST/rdIujthnRARnmB/nKDcZbdr
 Wvmh6N77r5wlkLC6FHpUZZp10ILr7UyOupPEYPGvIPAaqUgaV8QfNRThMi0Tpz8CwWHGuCbDcIv
 LbYtc2XNQZHZVxb6fc00xhL/PXm0AiZ9HsHDsee5/wpxgB0xeyuWaCQHU8iUz3kMhLcxscSNM0x
 UCTtORQyk1gSInclvs74EKXZGySvUFtvbBwFvTYtld1xa6AY3dj8K1wxwjT0au363Rm6r4edYmR
 v6iSod8M95u35u/ykWZm1ycnWP5roZLQsXmvHH9SJS1vAC22oS37WTbfck0TvqiX3XlQYtRyjLg
 ackRNeRo8TWQvnw0beQygG/E510kwtQnRMhFQ0GkZBhzXQ9PtVX7kf5yh2sRm5/0ooXTP0mHa6U
 GyrLpGDjQb3SNNvreg0VzJZHWMeApNWM4E///nBGkxRNvTRkHog3xN5oM9vCZOVj4sjCa6VvTd5
 SXnUnRSLdyIY5aVXBVzA7butjib9HvzW9HWFWT7sMJ+93xCDba6VsH4oZE9dMRonI1ozI4Eie0z
 02bX1a3yZBtvp0wRljViU9nfor4vaJIyTM43HBb/r+F/AuyfBs6bwlAmT/OVkgZ+Yt7aed2Nbao
 d/FO/NqGhE8GZHQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the FF-A specification: section "Usage of other memory region
attributes", in a transaction to donate memory or lend memory to a single
borrower, if the receiver is a PE or Proxy endpoint, the owner must not
specify the attributes and the relayer will return INVALID_PARAMETERS
if the attributes are set.

Let us not set the memory region attributes for MEM_LEND.

Fixes: 82a8daaecfd9 ("firmware: arm_ffa: Add support for MEM_LEND")
Reported-by: Joao Alves <joao.alves@arm.com>
Reported-by: Olivier Deprez <olivier.deprez@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 8a5b5c274bb9..6312a7807d37 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -424,6 +424,19 @@ static u32 ffa_get_num_pages_sg(struct scatterlist *sg)
 	return num_pages;
 }
 
+static u8 ffa_memory_attributes_get(u32 func_id)
+{
+	/*
+	 * For the memory lend or donate operation, if the receiver is a PE or
+	 * a proxy endpoint, the owner/sender must not specify the attributes
+	 */
+	if (func_id == FFA_FN_NATIVE(MEM_LEND) ||
+	    func_id == FFA_MEM_LEND)
+		return 0;
+
+	return FFA_MEM_NORMAL | FFA_MEM_WRITE_BACK | FFA_MEM_INNER_SHAREABLE;
+}
+
 static int
 ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		       struct ffa_mem_ops_args *args)
@@ -440,8 +453,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	mem_region->tag = args->tag;
 	mem_region->flags = args->flags;
 	mem_region->sender_id = drv_info->vm_id;
-	mem_region->attributes = FFA_MEM_NORMAL | FFA_MEM_WRITE_BACK |
-				 FFA_MEM_INNER_SHAREABLE;
+	mem_region->attributes = ffa_memory_attributes_get(func_id);
 	ep_mem_access = &mem_region->ep_mem_access[0];
 
 	for (idx = 0; idx < args->nattrs; idx++, ep_mem_access++) {

-- 
2.42.0

