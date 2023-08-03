Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B86D76DDB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHCBz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjHCBy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:54:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183BB1FEE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:51:37 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGWyH588TzrRng;
        Thu,  3 Aug 2023 09:50:31 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 09:51:35 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next v2] efs: clean up -Wunused-const-variable= warning
Date:   Thu, 3 Aug 2023 09:51:03 +0800
Message-ID: <20230803015103.192985-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, the following warning occurs.

In file included from fs/efs/super.c:18:0:
fs/efs/efs.h:22:19: warning: ‘cprt’ defined but not used [-Wunused-const-variable=]
 static const char cprt[] = "EFS: "EFS_VERSION" - (c) 1999 Al Smith
<Al.Smith@aeschi.ch.eu.org>";
                   ^~~~
The 'cprt' is not used in any files, we move the copyright statement
into the comment.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>

---
Changes in v2:
- Remove cprt from the code, and move the copyright to the comment.
- Remove the fix tag.
---
 fs/efs/efs.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/efs/efs.h b/fs/efs/efs.h
index 13a4d9622633..918d2b9abb76 100644
--- a/fs/efs/efs.h
+++ b/fs/efs/efs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (c) 1999 Al Smith
+ * Copyright (c) 1999 Al Smith, <Al.Smith@aeschi.ch.eu.org>
  *
  * Portions derived from work (c) 1995,1996 Christian Vogelgsang.
  * Portions derived from IRIX header files (c) 1988 Silicon Graphics
@@ -19,9 +19,6 @@
 
 #define EFS_VERSION "1.0a"
 
-static const char cprt[] = "EFS: "EFS_VERSION" - (c) 1999 Al Smith <Al.Smith@aeschi.ch.eu.org>";
-
-
 /* 1 block is 512 bytes */
 #define	EFS_BLOCKSIZE_BITS	9
 #define	EFS_BLOCKSIZE		(1 << EFS_BLOCKSIZE_BITS)
-- 
2.17.1

