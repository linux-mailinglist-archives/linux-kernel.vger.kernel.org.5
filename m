Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A737D876B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345371AbjJZRRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjJZRRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:17:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC361AD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:17:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-694ed847889so1091099b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698340628; x=1698945428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0Puy8uzDdeJA3YJWoPBCUPXKUz4iivPagxx13yStQQ=;
        b=N0JBY68UjxwUfH75it85R+aqxn30RXNMQGz+RZwLucA4qYoxFm7GkGfYOW4D2jB3fC
         6Q1q/9iWl8r9FOhBqOw8mXZ1Wj3/KKjHbqe1GxWUVKDvyjxEojbaXlI4qgEXV4h9YxBA
         55s03utzZEpLxDSZwfojm545yQBCVno9Bc0S2HHK6gAGLUUVPDpLeETt/kRXZIbwf9s1
         Dg7XZzjMXdEubJHi+rY/RNHmD0xc5OiSw4jcihXPgVH3Zt/3vHQ5VgZlhQ2mfQtKUiye
         2U7xQKkuvZ/bcCwOFckv9ZVq44fa2mJuO0dhGB/szIKFu//Q5ZWdW3SPLj9owbQ4H7jg
         peZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340628; x=1698945428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0Puy8uzDdeJA3YJWoPBCUPXKUz4iivPagxx13yStQQ=;
        b=AQmsfQt3k1QgWgo3E7h6e4bx0R7nG9JNY/1IaqO6QHYaBYY0PPsuB/HRwvIguwn0D9
         R7XLflfh7DWFHCfs+Uc/dnuaR6MWF5iZRZCNHjhsjpSImYBhDqSk1/hlesKIbYT2ue+k
         OagIq+dDqQa14dGGOkxfzI0RKEEFD6BG5VKIDBNjv8LSLarQJhD/YLICybyINaJeuILf
         AQbCyBag1TToG7acUgqfvF2StpfE7Mr85ZHkwJrRsKvGvP2q5Te0M9fcGKhSBybP7KfP
         gjyL/im/gRYf4iphEv9wQuJh7kuSb6iLtmXlZ00zWm7vuohsaVSL8+my/uVIOzP+vzpl
         67dg==
X-Gm-Message-State: AOJu0YzqKJV+D5mhvLVqjVY5oygfPTT0jgWk1OhFhFiWpnyalUiM20Xf
        nPaaRrF4l/NG7X4klW/NeS8bHdwElvGDDCbEnw0=
X-Google-Smtp-Source: AGHT+IFEzRu/080l7T/ci9ib0BseRGffnuXrBVtWGJELX6E9MeNj1xKrvrgaXhlAVULgZUxKgSwPsA==
X-Received: by 2002:a05:6a00:1143:b0:693:3851:bd3e with SMTP id b3-20020a056a00114300b006933851bd3emr123488pfm.3.1698340627641;
        Thu, 26 Oct 2023 10:17:07 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id h26-20020aa796da000000b0069343e474bcsm11443625pfq.104.2023.10.26.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:17:07 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] optee: add page list to kernel private shared memory
Date:   Thu, 26 Oct 2023 19:16:50 +0200
Message-Id: <20231026171650.515275-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now has kernel private shared memory allocated as dynamic shared
memory (not from the static shared memory pool) been returned without a
list of physical pages on allocations via RPC. To support allocations
larger than one page add a list of physical pages for all allocations
larger than one page. Allocate the memory with  alloc_pages_exact()
instead of alloc_pages() for more efficient memory usage.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c    | 59 +++++++++++++++++++++++++------------
 drivers/tee/optee/smc_abi.c | 45 +++++++++++++---------------
 2 files changed, 61 insertions(+), 43 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2a258bd3b6b5..60fe351ee5c8 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -26,24 +26,36 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 						   size_t num_pages,
 						   unsigned long start))
 {
-	unsigned int order = get_order(size);
-	struct page *page;
+	size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
+	unsigned int i;
 	int rc = 0;
 
 	/*
 	 * Ignore alignment since this is already going to be page aligned
 	 * and there's no need for any larger alignment.
 	 */
-	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!page)
+	shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
+				       GFP_KERNEL | __GFP_ZERO);
+	if (!shm->kaddr)
 		return -ENOMEM;
 
-	shm->kaddr = page_address(page);
-	shm->paddr = page_to_phys(page);
-	shm->size = PAGE_SIZE << order;
+	shm->size = nr_pages * PAGE_SIZE;
+	shm->num_pages = nr_pages;
 
-	if (shm_register) {
-		unsigned int nr_pages = 1 << order, i;
+	/*
+	 * If memory is registered immediately use a temporary page list
+	 * and free it directly after the registration is completed.
+	 *
+	 * Else, if we have allocated more than one page store a page
+	 * list in the struct tee_shm.
+	 *
+	 * Else, store the physical address of the single page that was
+	 * allocated.
+	 *
+	 * optee_pool_op_free_helper() is responsible for freeing the
+	 * resourses allocated in this function.
+	 */
+	if (shm_register || nr_pages > 1) {
 		struct page **pages;
 
 		pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
@@ -53,19 +65,26 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 		}
 
 		for (i = 0; i < nr_pages; i++)
-			pages[i] = page + i;
-
-		rc = shm_register(shm->ctx, shm, pages, nr_pages,
-				  (unsigned long)shm->kaddr);
-		kfree(pages);
-		if (rc)
-			goto err;
+			pages[i] = virt_to_page((u8 *)shm->kaddr +
+						i * PAGE_SIZE);
+
+		if (shm_register) {
+			rc = shm_register(shm->ctx, shm, pages, nr_pages,
+					  (unsigned long)shm->kaddr);
+			kfree(pages);
+			if (rc)
+				goto err;
+		} else {
+			shm->pages = pages;
+		}
+	} else {
+		shm->paddr = virt_to_phys(shm->kaddr);
 	}
 
 	return 0;
-
 err:
-	free_pages((unsigned long)shm->kaddr, order);
+	free_pages_exact(shm->kaddr, shm->size);
+	shm->kaddr = NULL;
 	return rc;
 }
 
@@ -75,8 +94,10 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 {
 	if (shm_unregister)
 		shm_unregister(shm->ctx, shm);
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	free_pages_exact(shm->kaddr, shm->size);
 	shm->kaddr = NULL;
+	kfree(shm->pages);
+	shm->pages = NULL;
 }
 
 static void optee_bus_scan(struct work_struct *work)
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index d5b28fd35d66..b69410c7cc0a 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -678,10 +678,11 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 					  struct optee_msg_arg *arg,
 					  struct optee_call_ctx *call_ctx)
 {
-	phys_addr_t pa;
 	struct tee_shm *shm;
 	size_t sz;
 	size_t n;
+	struct page **pages;
+	size_t page_count;
 
 	arg->ret_origin = TEEC_ORIGIN_COMMS;
 
@@ -716,32 +717,23 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 		return;
 	}
 
-	if (tee_shm_get_pa(shm, 0, &pa)) {
-		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
-		goto bad;
-	}
-
-	sz = tee_shm_get_size(shm);
-
-	if (tee_shm_is_dynamic(shm)) {
-		struct page **pages;
+	/*
+	 * If there are pages it's dynamically allocated shared memory (not
+	 * from the reserved shared memory pool) and needs to be
+	 * registered.
+	 */
+	pages = tee_shm_get_pages(shm, &page_count);
+	if (pages) {
 		u64 *pages_list;
-		size_t page_num;
-
-		pages = tee_shm_get_pages(shm, &page_num);
-		if (!pages || !page_num) {
-			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
-			goto bad;
-		}
 
-		pages_list = optee_allocate_pages_list(page_num);
+		pages_list = optee_allocate_pages_list(page_count);
 		if (!pages_list) {
 			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
 			goto bad;
 		}
 
 		call_ctx->pages_list = pages_list;
-		call_ctx->num_entries = page_num;
+		call_ctx->num_entries = page_count;
 
 		arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
 				      OPTEE_MSG_ATTR_NONCONTIG;
@@ -752,17 +744,22 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 		arg->params[0].u.tmem.buf_ptr = virt_to_phys(pages_list) |
 			(tee_shm_get_page_offset(shm) &
 			 (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
-		arg->params[0].u.tmem.size = tee_shm_get_size(shm);
-		arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
 
-		optee_fill_pages_list(pages_list, pages, page_num,
+		optee_fill_pages_list(pages_list, pages, page_count,
 				      tee_shm_get_page_offset(shm));
 	} else {
+		phys_addr_t pa;
+
+		if (tee_shm_get_pa(shm, 0, &pa)) {
+			arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+			goto bad;
+		}
+
 		arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
 		arg->params[0].u.tmem.buf_ptr = pa;
-		arg->params[0].u.tmem.size = sz;
-		arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
 	}
+	arg->params[0].u.tmem.size = tee_shm_get_size(shm);
+	arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
 
 	arg->ret = TEEC_SUCCESS;
 	return;

base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
-- 
2.34.1

