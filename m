Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FC47DED5B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbjKBHbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjKBHbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:31:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32CB12B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:31:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc3216b2a1so4724595ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698910276; x=1699515076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1Kwz19o9ECsWczdBnTg7G4Gn09yWEPDImb0+FUx/2U=;
        b=ol92QYHLtnS36+ROAv9imxnK2JLDIRwKMRQV0QrJLt7Ekm8fySQG4HRAqUlmxPtMEV
         vFlZYQnEO2XsTMhfM/JbMWtE29fwAKi16Cky6IkbMP9X+qOGp//D6kPc1VLyeBzgCuEk
         4cG0OyZjVCVXmcja9dEzirzdYSC8bSPk7mr1GIw1J3fIKNYuSM7PHZCrOH2gecYOitm6
         ldiraADKKHSRwwAIVxZSn6qAe4MeFWdZTG4dIrcELr2VSuT1kHolxUAtKoqA06Hy12DH
         B9GabAQ6PfGgDtReZ9sBOHQs9jMfWT20renYA8iXU0VUQ8HdKDHyXu/7/KwH6kUATfTD
         cINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698910276; x=1699515076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1Kwz19o9ECsWczdBnTg7G4Gn09yWEPDImb0+FUx/2U=;
        b=O21BMQHocOhn4FuRZ7GKhccwU2O8yJwhT0zDboYTzIR3LnazrpV/tfvsIUvsq6olun
         KQyOIu6BhyoXkDtKrDeXzuAFeRUKUvEv+IELO0Jfd46PQ22pgZcBavxby5t5x5yOoMcB
         8NYAwZuKyWVaasBGd3VkmRpeTWvK38TUAWCXrk9niNYJ4SlJAi7V7mLaUv0p1AcIdDmK
         48ys+wKt85JeCzY6M5Qoi2wor4O4kbAq48Dk/gNCxQuv35cqWik6QHycVbhjzFY6lq76
         nCCbw2TsqK7vTLl9lmc5Fte4sUZhq0cBhtMjK3KyiF/tbg4wEezMg/tbnSNN8IlUQ5hM
         1N6Q==
X-Gm-Message-State: AOJu0YzQiOKcWljXfzKxMiHCwQqbaEcObZih3Wb0+orqtiBJnYadBh6X
        07DTE5996kXaD4+PqZU02adurQ==
X-Google-Smtp-Source: AGHT+IF0FaVDf0Cek3pfjrfFkfD4VwgqqUfqyJfS3aiBkLpzaJ1nCAY8QgEMuLnt+rIshqVckoSoNw==
X-Received: by 2002:a17:902:ce88:b0:1cc:636f:f37c with SMTP id f8-20020a170902ce8800b001cc636ff37cmr9238524plg.13.1698910276398;
        Thu, 02 Nov 2023 00:31:16 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.245])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c14600b001b03a1a3151sm2424104plj.70.2023.11.02.00.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 00:31:16 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org
Cc:     jan.kiszka@siemens.com, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        diogo.ivo@siemens.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 2/2] tee: optee: Remove redundant custom workqueue
Date:   Thu,  2 Nov 2023 13:00:56 +0530
Message-Id: <20231102073056.174480-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102073056.174480-1-sumit.garg@linaro.org>
References: <20231102073056.174480-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Global system workqueue is sufficient to suffice OP-TEE bus scanning work
needs. So drop redundant usage of the custom workqueue.

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/core.c          | 13 ++-----------
 drivers/tee/optee/optee_private.h |  2 --
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2a258bd3b6b5..1eaa191b6ff6 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -15,7 +15,6 @@
 #include <linux/string.h>
 #include <linux/tee_drv.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
 #include "optee_private.h"
 
 int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
@@ -110,12 +109,7 @@ int optee_open(struct tee_context *ctx, bool cap_memref_null)
 
 		if (!optee->scan_bus_done) {
 			INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
-			optee->scan_bus_wq = create_workqueue("optee_bus_scan");
-			if (!optee->scan_bus_wq) {
-				kfree(ctxdata);
-				return -ECHILD;
-			}
-			queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
+			schedule_work(&optee->scan_bus_work);
 			optee->scan_bus_done = true;
 		}
 	}
@@ -158,10 +152,7 @@ void optee_release_supp(struct tee_context *ctx)
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 
 	optee_release_helper(ctx, optee_close_session_helper);
-	if (optee->scan_bus_wq) {
-		destroy_workqueue(optee->scan_bus_wq);
-		optee->scan_bus_wq = NULL;
-	}
+
 	optee_supp_release(&optee->supp);
 }
 
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 6bb5cae09688..94c0ee381894 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -178,7 +178,6 @@ struct optee_ops {
  * @pool:		shared memory pool
  * @rpc_param_count:	If > 0 number of RPC parameters to make room for
  * @scan_bus_done	flag if device registation was already done.
- * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
  * @scan_bus_work	workq to scan optee bus and register optee drivers
  */
 struct optee {
@@ -197,7 +196,6 @@ struct optee {
 	struct tee_shm_pool *pool;
 	unsigned int rpc_param_count;
 	bool   scan_bus_done;
-	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
 };
 
-- 
2.34.1

