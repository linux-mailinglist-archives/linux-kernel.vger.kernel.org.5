Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A747978037D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357112AbjHRBqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357110AbjHRBqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:46:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE89A2713
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:45:58 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRkg60mN9zFqgs;
        Fri, 18 Aug 2023 09:24:18 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 09:27:17 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <keescook@chromium.org>
CC:     <luto@amacapital.net>, <wad@chromium.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] seccomp: Fix comment on requests
Date:   Fri, 18 Aug 2023 09:26:58 +0800
Message-ID: <20230818012658.12262-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the comment on requests.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d3fdc0086168..7673aa3930dc 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -138,7 +138,7 @@ struct seccomp_kaddfd {
  * structure is fairly large, we store the notification-specific stuff in a
  * separate structure.
  *
- * @request: A semaphore that users of this notification can wait on for
+ * @requests: A atomic that users of this notification can wait on for
  *           changes. Actual reads and writes are still controlled with
  *           filter->notify_lock.
  * @next_id: The id of the next request.
-- 
2.17.1

