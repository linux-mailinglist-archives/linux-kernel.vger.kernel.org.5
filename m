Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06241777B42
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbjHJOtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjHJOtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:49:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBBF211C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:49:51 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM8rC2gm3zCrWk;
        Thu, 10 Aug 2023 22:46:19 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 22:49:48 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <jens.wiklander@linaro.org>, <sumit.garg@linaro.org>,
        <etienne.carriere@linaro.org>, <yuehaibing@huawei.com>
CC:     <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] tee: Remove unused declarations
Date:   Thu, 10 Aug 2023 22:49:43 +0800
Message-ID: <20230810144943.34976-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4fb0a5eb364d ("tee: add OP-TEE driver") declared but never implemented
optee_supp_read()/optee_supp_write().
Commit 967c9cca2cc5 ("tee: generic TEE subsystem") never implemented tee_shm_init().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/tee/optee/optee_private.h | 2 --
 drivers/tee/tee_private.h         | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 72685ee0d53f..6bb5cae09688 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -238,8 +238,6 @@ int optee_notif_send(struct optee *optee, u_int key);
 u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 			struct tee_param *param);
 
-int optee_supp_read(struct tee_context *ctx, void __user *buf, size_t len);
-int optee_supp_write(struct tee_context *ctx, void __user *buf, size_t len);
 void optee_supp_init(struct optee_supp *supp);
 void optee_supp_uninit(struct optee_supp *supp);
 void optee_supp_release(struct optee_supp *supp);
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 409cadcc1cff..754e11dcb240 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -47,8 +47,6 @@ struct tee_device {
 	struct tee_shm_pool *pool;
 };
 
-int tee_shm_init(void);
-
 int tee_shm_get_fd(struct tee_shm *shm);
 
 bool tee_device_get(struct tee_device *teedev);
-- 
2.34.1

